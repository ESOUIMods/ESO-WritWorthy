-- Parse a food or dring request.

local WritWorthy = _G['WritWorthy'] -- defined in WritWorthy_Define.lua

WritWorthy.Holliday = {
    savedVarVersion = 2
}

local Holliday = WritWorthy.Holliday
local Util         = WritWorthy.Util
local Fail         = WritWorthy.Util.Fail
local Log          = WritWorthy.Log

-- Hand entered itemId to recipeId
--
--  fooddrink  recipe
--  item_id    item_id
--  --------   -----
--
Holliday.HOLLIDAYITEM_TO_RECIPE_ITEM_ID = {
}

-- Recipe --------------------------------------------------------------------

Holliday.Recipe  = {}
local Recipe = Holliday.Recipe
function Recipe:New(args)
    local o = {
        class             = "hollidayitem"
    ,   hollidayItemId = args.hollidayItemId  -- int(33526)
    ,   recipe_item_id    = args.recipe_item_id     -- int(45888)
    ,   recipe_link       = args.recipe_link        -- "|H1:item:45888:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    ,   is_known          = args.is_known           -- true
    ,   mat_list          = {}                      -- list of MatRow ingredients
    ,   hollidayitem_link    = nil
    ,   hollidayitem_name    = nil
    }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Recipe:FromFoodDrinkItemID(hollidayItemId)
    local MatRow = WritWorthy.MatRow

    local o = Recipe:New({ hollidayItemId = hollidayItemId })
    o.recipe_item_id = Holliday.HOLLIDAYITEM_TO_RECIPE_ITEM_ID[hollidayItemId]
    if not o.recipe_item_id then return nil end
    o.recipe_link = string.format("|H1:item:%d:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", o.recipe_item_id)
    o.hollidayitem_link = GetItemLinkRecipeResultItemLink(
                                      o.recipe_link
                                    , LINK_STYLE_DEFAULT)
    o.hollidayitem_name    = WritWorthy.FoodDrink(GetItemLinkItemId(o.hollidayitem_link))
    o.is_known = IsItemLinkRecipeKnown(o.recipe_link)

    local r = { GetItemLinkItemType(o.hollidayitem_link) }
    o.holliday_item_type = r[1]
    o.fooddrink_specialized_item_type = r[2]

    local log_t = {}
    log_t.hollidayItemId                 = hollidayItemId
    log_t.recipe_item_id                    = o.recipe_item_id
    log_t.recipe_link                       = o.recipe_link
    log_t.hollidayitem_link                    = o.hollidayitem_link
    log_t.hollidayitem_name                    = o.hollidayitem_name
    log_t.is_known                          = o.is_known
    log_t.holliday_item_type               = o.holliday_item_type
    log_t.fooddrink_specialized_item_type   = o.fooddrink_specialized_item_type
    Log:Add(log_t)

    local mat_ct = GetItemLinkRecipeNumIngredients(o.recipe_link)
    local hollidayItemCount = 1 -- Usually need to craft 1 item for holliday writs
    for ingr_index = 1,mat_ct do
        local _, _, ingr_ct = GetItemLinkRecipeIngredientInfo(
                              o.recipe_link
                            , ingr_index)
        local ingr_link = GetItemLinkRecipeIngredientItemLink(
                              o.recipe_link
                            , ingr_index
                            , LINK_STYLE_DEFAULT)
        if 0 < ingr_ct and ingr_link and ingr_link ~= "" then
            local mr = MatRow:FromLink(ingr_link, ingr_ct * hollidayItemCount)
            table.insert(o.mat_list, mr)
        end
    end
    return o
end


-- Holliday --------------------------------------------------------------

-- Find a recipe by hollidayItemId
--
-- First time this runs, we decompress a list of all 554 recipe names.
-- Takes 1+ second!
--
-- Second-and-later times this runs, it's O(1) instantaneous.
--
-- returns a Recipe{} instance.
--
function Holliday.FindRecipe(hollidayItemId)
    local recipe = Recipe:FromFoodDrinkItemID(hollidayItemId)
    if not recipe then
        return Fail("WritWorthy: recipe not found:"..tostring(hollidayItemId))
    end
    return recipe
end

Holliday.Parser = {
    class = "hollidayitem"
}
local Parser = Holliday.Parser

function Parser:New()
    local o = {
        recipe          = nil -- Recipe{}
    ,   crafting_type   = WW_CRAFTING_TYPE_FURNITURE
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Parser:ParseItemLink(item_link)
    Log:StartNewEvent("ParseItemLink: %s %s", self.class, item_link)
    local fields = Util.ToWritFields(item_link)
    self.recipe = Holliday.FindRecipe(fields.writ1)
    if not self.recipe then return nil end
    return self
end

function Parser:ToMatList()
    return self.recipe.mat_list
end

function Parser:ToKnowList()
    Log:StartNewEvent("ToKnowList: %s", self.class)
    local Know = WritWorthy.Know
    local k = Know:New({ name = "recipe"
                       , is_known = self.recipe.is_known
                       , lack_msg = WritWorthy.Str("know_err_recipe")
                       , how      = WritWorthy.Know.KNOW.RECIPE
                       })
    local r = { k }
    if self.recipe.holliday_item_type == ITEMTYPE_FOOD then
        local chef   = WritWorthy.RequiredSkill.PR_FOOD_4X:ToKnow()
        chef.is_warn = true
        table.insert(r, chef)
    elseif self.recipe.holliday_item_type == ITEMTYPE_DRINK then
        local brewer = WritWorthy.RequiredSkill.PR_DRINK_4X:ToKnow()
        brewer.is_warn = true
        table.insert(r, brewer)
    end
    return r
end

function Parser:ToDolRequest(unique_id)
    local mat_list = self:ToMatList()
    local o = {}
    o[1] = self.recipe.recipe_item_id -- recipeId
    o[2] = 2                          -- timesToMake
    o[3] = true                       -- autocraft
    o[4] = unique_id                  -- reference
    return { ["function"       ] = "CraftProvisioningItemByRecipeId"
           , ["args"           ] = o
           }
end
