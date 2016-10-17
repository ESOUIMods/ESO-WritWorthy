local LAM2 = LibStub("LibAddonMenu-2.0")

local MMChat = {}
MMChat.name            = "MMChat"
MMChat.version         = "2.6.1"
MMChat.savedVarVersion = 1
MMChat.NAME_BANK       = "bank"
MMChat.NAME_CRAFT_BAG  = "craft bag"
MMChat.char_index      = nil
MMChat.default = {
    bag = {}
}
MMChat.channel_id_enabled = {
  [CHAT_CHANNEL_WHISPER] = true
, [CHAT_CHANNEL_GUILD_3] = true
, [CHAT_CHANNEL_GUILD_4] = true
--, [CHAT_CHANNEL_GUILD_5] = true
, [CHAT_CHANNEL_OFFICER_3] = true
, [CHAT_CHANNEL_OFFICER_4] = true
--, [CHAT_CHANNEL_OFFICER_5] = true
}
MMChat.text_queue = {}

MMChat.LINK_PATTERN   = '|H%d:item:[0-9:]+|h[^|]*|h'
MMChat.LINK_PATTERN_N = '([%d+x]*) ?('..MMChat.LINK_PATTERN..')'

-- Chat colors
MMChat.GREY = "999999"

function MMChat.color(color, text)
    return "|c" .. color .. text .. "|r"
end

function MMChat.grey(text)
    return MMChat.color(MMChat.GREY, text)
end

function MMChat.round(f)
    if not f then return f end
    return math.floor(0.5+f)
end

-- Return commafied integer number, or "?" if nil.
function MMChat.ToMoney(x)
    if not x then return "?" end
    return ZO_CurrencyControl_FormatCurrency(MMChat.round(x), false)
end



-- Item ----------------------------------------------------------------------
local Item = {}
function Item:FromLinkCt(link, ct)
    local o = { total_value = 0
              , ct          = ct
              , mm          = nil
              , link        = link
              }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- A formatted line suitable for display in chat
function Item:ToText()
    return  MMChat.grey(
                   tostring(MMChat.ToMoney(self.total_value)).."g"
        .."  = ".. tostring(self.ct) .."x"
        .." "   .. tostring(MMChat.ToMoney(self.mm)) .."g"
            ) -- end grey
        .."   " .. tostring(self.link)
        .. " "  .. self:BoundHow()
end

function Item:FetchMM()
    self.mm = MMChat.MMPrice(self.link)
    if self.mm then
        self.total_value = self.mm * self.ct
    end
end

Item.BIND_STRING = {
  [BIND_TYPE_NONE]               = ""
, [BIND_TYPE_ON_EQUIP]           = "BoE"
, [BIND_TYPE_ON_PICKUP]          = "BoP"
, [BIND_TYPE_ON_PICKUP_BACKPACK] = "Bag-BoP"
, [BIND_TYPE_UNSET]              = "unset"
}

-- Return Master Merchant's "stats to chat" text.
--
-- Basically copied straight from Master Merchant's own
-- MasterMerchant:onItemActionLinkStatsLink()
function Item:PriceCheckText()
  local tipLine, days = MasterMerchant:itemPriceTip(self.link, true)
  if not tipLine then
    if days == 10000 then
      tipLine = GetString(MM_TIP_FORMAT_NONE)
    else
      tipLine = string.format(GetString(MM_TIP_FORMAT_NONE_RANGE), days)
    end
  end
  if tipLine then
    tipLine = string.gsub(tipLine, 'M.M.', 'MM')
    local ChatEditControl = CHAT_SYSTEM.textEntry.editControl
    if (not ChatEditControl:HasFocus()) then StartChatInput() end
    local itemText = string.gsub(self.link, '|H0', '|H1')
    return(MasterMerchant.concat(tipLine, GetString(MM_TIP_FOR), itemText))
  end
  return ""
end

function Item:BoundHow()
    if not IsItemLinkBound(self.link) then return "" end
    local bt = GetItemLinkBindType(self.link)
    return Item.BIND_STRING[bt]
end

-- ChatEvent --------------------------------------------------------------------
local ChatEvent = {}
function ChatEvent:New(channel_id, from, text)
    local o = { channel_id  = channel_id
              , from        = from
              , text        = text
              }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- MMChat --------------------------------------------------------------------
-- Might some day go dynamic, but for now...
function MMChat:IsEnabledForChannelID(channel_id)
    return MMChat.channel_id_enabled[channel_id]
end

-- Don't report on our own MM reports!
function MMChat:IsMMReport(text)
    if string.match(text, "^MM price ") then return true end
    return string.match(text, "^MM has no data ")
end

MMChat.PRICE_CHECK = { "^PC ", "Price Check " }

function MMChat:IsPriceCheck(text)
    for _, key in pairs(MMChat.PRICE_CHECK) do
        if string.match(text,              key ) then return true end
        if string.match(text, string.lower(key)) then return true end
    end
    return false
end

-- Is this MM-worthy?
-- "|H0:item:4456:30:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
function MMChat:ContainsLink(text)
    return string.match(text, MMChat.LINK_PATTERN)
end

-- Convert "100x" to integer 100. Convert empty (no multiplier) to 1.
function MMChat:ToInt(s)
    if not s or s == "" then return 1 end
    local nox = string.gsub(s,"x", "")
    return tonumber(nox)
end

-- Donated by @astraea360: 10x|H1:item:54181:34:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h 100x|H1:item:54180:33:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h 200x|H1:item:54179:32:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h 200x|H1:item:54178:31:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h
-- (Flash Auction, 15 seconds) Donated by @dot_hackza: |H1:item:84705:362:50:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0:0|h|h

-- Given a string "100xRawhide 50xHemming Dreugh Wax"
-- return a list of Items
--      (100 "Rawhide"      )
--      ( 50 "Hemming"      )
--      (  1  "Dreugh Wax"  )
--
-- Suitable for MM-ification and multiplication (but that's someone else's focus).
--
function MMChat:ToLinkCounts(text)
    local r = {}
    for ct, link in string.gmatch(text, MMChat.LINK_PATTERN_N) do
        local item = Item:FromLinkCt(link, MMChat:ToInt(ct))
        table.insert(r, item)
    end
    return r
end

function MMChat.MMPrice(link)
    if not MasterMerchant then return nil end
    if not link then return nil end
    mm = MasterMerchant:itemStats(link, false)
    if not mm then return nil end
    --d("MM for link: "..tostring(link).." "..tostring(mm.avgPrice))
    return mm.avgPrice
end

function MMChat:SendChatMessage(chat_event, message)
    if chat_event.channel_id == CHAT_CHANNEL_WHISPER then
        CHAT_SYSTEM:SetChannel(CHAT_CHANNEL_WHISPER, chat_event.from)
    else
        CHAT_SYSTEM:SetChannel(chat_event.channel_id)
    end
    d(message)
    -- CHAT_SYSTEM:StartTextEntry(message)
    -- CHAT_SYSTEM:SubmitTextEntry()
end

-- Init ----------------------------------------------------------------------

function MMChat.OnAddOnLoaded(event, addonName)
    if addonName ~= MMChat.name then return end
    if not MMChat.version then return end
    if not MMChat.default then return end
    MMChat:Initialize()
end

function MMChat:Initialize()

    self.savedVariables = ZO_SavedVars:NewAccountWide(
                              "MMChatVars"
                            , self.savedVarVersion
                            , nil
                            , self.default
                            )
    --EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_ADD_ON_LOADED)
end

-- Chat Event Handler --------------------------------------------------------

-- Using zo_calllater() to defer this MM handling until AFTER we're out of chat
-- handling, so that we don't break any chat events with our noise.
function MMChat.AfterMessage()
    local event = table.remove(MMChat.text_queue, 1)
    if not event then return end
    local text = event.text
    local item_list = MMChat:ToLinkCounts(text)
    local total     = 0
    for i, item in ipairs(item_list) do
        item:FetchMM()
        d(item:ToText())
        total = total + item.total_value
    end
    local is_pc = MMChat:IsPriceCheck(text)
    local pc = ""
    if is_pc then
        pc = "PRICE CHECK on channel " .. tostring(event.channel_id)
    end
    d(MMChat.ToMoney(total) .. "g total  " .. pc)
    if is_pc then
        for i, item in ipairs(item_list) do
            local pc_text = item:PriceCheckText(item.link) .. " " .. item:BoundHow()
            MMChat:SendChatMessage(event, pc_text)
        end
    end
end

function MMChat.OnEventChatMessageChannel(
          event_id
        , channel_id
        , from
        , text
        , is_cust_svc
        )
    if not MMChat:IsEnabledForChannelID(channel_id) then return end

    -- return text, zo_channel_info.saveTarget
    if MMChat:ContainsLink(text) and not MMChat:IsMMReport(text) then
        local event = ChatEvent:New(channel_id, from, text)
        table.insert(MMChat.text_queue, event)
        zo_callLater(MMChat.AfterMessage, 50)
        -- MMChat.AfterMessage()
    end
end


-- Postamble -----------------------------------------------------------------

EVENT_MANAGER:RegisterForEvent( MMChat.name
                              , EVENT_ADD_ON_LOADED
                              , MMChat.OnAddOnLoaded
                              )

-- ZO_ChatSystem_AddEventHandler() does not work if other
-- ZO_ChatSystem_AddEventHandler() clients are in play: Shissu/pChat/libChat2
-- and wkyyyd's enhanced chat all cause this  to not be called.
--
-- ZO_ChatSystem_AddEventHandler ( EVENT_CHAT_MESSAGE_CHANNEL
--                               , MMChat.OnChatMessageChannel
--                               )

-- EVENT_MANAGER:RegisterForEvent() is post-called, after the message appears
-- in chat, after wykkyd and libChat2 have a chance to modify and display.
-- Perfect for our needs as an after-event trigger.

EVENT_MANAGER:RegisterForEvent( MMChat.name .. "2"
                              , EVENT_CHAT_MESSAGE_CHANNEL
                              , MMChat.OnEventChatMessageChannel
                              )
