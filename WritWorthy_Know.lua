--[[
-------------------------------------------------------------------------------
-- WritWorthy
-------------------------------------------------------------------------------
-- Original author: ziggr (project started 2017-02-12)
--
-- Current maintainer: Sharlikran (contributions since 2022-11-12)
-- Contributor: jogietze (formerly otac0n) — GitHub PR contributions
--
-- ----------------------------------------------------------------------------
-- Unless otherwise stated, portions of this software are © ziggr and may
-- be subject to “All Rights Reserved” status due to the absence of a public
-- open-source license declaration.
--
-- ----------------------------------------------------------------------------
-- Contributions by Sharlikran are licensed under the BSD 3-Clause License:
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
--
-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
-- 3. Neither the name of the author "Sharlikran" nor the names of previous
--    contributors may be used to endorse or promote products derived from this
--    software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES ARE DISCLAIMED. IN NO EVENT SHALL THE
-- COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING IN
-- ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
-- OF SUCH DAMAGE.
--
-- Maintainer Notice:
-- Redistribution of this software outside of ESOUI.com (including Bethesda.net
-- or other platforms) is discouraged unless authorized by the current
-- maintainer. Please do not redistribute or fork without attribution,
-- permission, and license compliance.
-------------------------------------------------------------------------------
]]
local WritWorthy = _G["WritWorthy"] -- defined in WritWorthy_Define.lua

WritWorthy.Know = {}
local Know = WritWorthy.Know
local Log = WritWorthy.Log

-- Which knowledge tooltips duplicate information that Marify also shows in
-- Marify's Confirm Master Writ? We'll hide those tooltip lines if the user
-- deselects WW settings checkbox for show_confirm_master_writ_duplicates.
Know.KNOW = {
  MOTIF = { cmw = true },
  RECIPE = { cmw = true },
  TRAIT = { cmw = true },
  TRAIT_CT_FOR_SET = { cmw = true },
  SKILL_COST_REDUCTION = { cmw = false },
  SKILL_REQUIRED = { cmw = true },
  LIBLAZYCRAFTING = { cmw = false }
}

-- Know ====================================================================
--
-- One piece of required knowledge such as recipe, trait, trait count.
--
function Know:New(args)
  local o = {
    name = args.name, -- "recipe"
    is_known = args.is_known, -- false
    is_warn = args.is_warn, -- not required, but increases mat cost.
    -- WritWorthy will refuse to queue for
    -- LibLazyCrafting.

    lack_msg = args.lack_msg, -- "Recipe not known"
    how = args.how -- WW.Know.KNOW.MOTIF
  }
  setmetatable(o, self)
  self.__index = self
  Log:Add(
    "is_known:" ..
      tostring(args.is_known) .. " name:" .. tostring(args.name) .. " lack_msg:" .. tostring(args.lack_msg)
  )
  return o
end

function Know:DebugText()
  return string.format("%s:%s", self.name, tostring(self.is_known))
end

function Know:TooltipText()
  if self.is_known then
    return nil
  end
  local color = WritWorthy.Util.COLOR_RED
  if self.is_warn then
    color = WritWorthy.Util.COLOR_ORANGE
  end
  return WritWorthy.Util.color(color, self.lack_msg)
end
