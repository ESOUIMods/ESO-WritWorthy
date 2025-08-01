--[[
-------------------------------------------------------------------------------
-- WritWorthy
-------------------------------------------------------------------------------
-- Original author: ziggr (project started 2017-02-12)
--
-- Current maintainer: Sharlikran (contributions since 2022-11-12)
-- Contributor: jogietze (formerly otac0n) � GitHub PR contributions
--
-- ----------------------------------------------------------------------------
-- Unless otherwise stated, portions of this software are � ziggr and may
-- be subject to �All Rights Reserved� status due to the absence of a public
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
-- Parse a food or dring request.

local WritWorthy = _G["WritWorthy"] -- defined in WritWorthy_Define.lua

WritWorthy.Provisioning = {
  savedVarVersion = 2
}

local Provisioning = WritWorthy.Provisioning
local Util = WritWorthy.Util
local Fail = WritWorthy.Util.Fail
local Log = WritWorthy.Log

-- Recipe item_id list from @Phinix's most excellent ESO Master Recipe List
-- which in turn got much of its data from @Sneak-Thief's ESO Master Provisioning Database
-- and @Daveh's ESO Data Pages.
--
--  fooddrink  recipe
--  item_id    item_id
--  --------   -----
--
Provisioning.FOODDRINK_TO_RECIPE_ITEM_ID = {
  [28281] = 45913,
  [28289] = 45915,
  [28293] = 45916,
  [28297] = 45917,
  [28299] = 45654,
  [28301] = 45918,
  [28304] = 45655,
  [28305] = 45919,
  [28308] = 45656,
  [28309] = 45920,
  [28311] = 45657,
  [28313] = 45921,
  [28316] = 45658,
  [28317] = 45922,
  [28320] = 45659,
  [28321] = 45887,
  [28325] = 45890,
  [28330] = 45893,
  [28331] = 45696,
  [28332] = 45712,
  [28333] = 45719,
  [28334] = 45894,
  [28338] = 45899,
  [28342] = 45900,
  [28346] = 45905,
  [28348] = 45636,
  [28350] = 45906,
  [28353] = 45637,
  [28354] = 45912,
  [28357] = 45638,
  [28358] = 55462,
  [28360] = 45639,
  [28362] = 45938,
  [28366] = 45939,
  [28370] = 45940,
  [28373] = 45675,
  [28374] = 45941,
  [28378] = 45942,
  [28382] = 45943,
  [28385] = 45678,
  [28386] = 45944,
  [28390] = 45945,
  [28394] = 45946,
  [28397] = 45681,
  [28398] = 45947,
  [28401] = 45970,
  [28402] = 46048,
  [28403] = 45620,
  [28405] = 45971,
  [28409] = 45972,
  [28411] = 45539,
  [28413] = 45973,
  [28415] = 45540,
  [28417] = 45974,
  [28419] = 45541,
  [28421] = 45975,
  [28423] = 45542,
  [28425] = 45976,
  [28427] = 45543,
  [28429] = 45977,
  [28431] = 45544,
  [28433] = 45978,
  [28435] = 45546,
  [28437] = 45979,
  [28439] = 45548,
  [28441] = 45996,
  [28443] = 45622,
  [28444] = 46050,
  [28445] = 45997,
  [28449] = 45998,
  [28452] = 45567,
  [28453] = 45999,
  [28456] = 45568,
  [28457] = 46000,
  [28460] = 45569,
  [28461] = 46001,
  [28464] = 45570,
  [28465] = 46002,
  [28468] = 45571,
  [28469] = 46003,
  [28472] = 45572,
  [28473] = 46004,
  [28476] = 45574,
  [28477] = 46005,
  [28481] = 46022,
  [28482] = 46052,
  [28483] = 45628,
  [28485] = 46023,
  [28487] = 45604,
  [28489] = 46024,
  [28492] = 45594,
  [28493] = 46025,
  [28496] = 45595,
  [28497] = 46026,
  [28500] = 45596,
  [28501] = 46027,
  [28504] = 45597,
  [28505] = 46028,
  [28508] = 45598,
  [28509] = 46029,
  [28510] = 45599,
  [28512] = 45600,
  [28513] = 46030,
  [28514] = 45601,
  [28516] = 45602,
  [28517] = 46031,
  [28518] = 45603,
  [32160] = 45964,
  [33358] = 45914,
  [33403] = 45676,
  [33405] = 45677,
  [33409] = 45679,
  [33411] = 45680,
  [33416] = 45682,
  [33420] = 54241,
  [33434] = 45545,
  [33436] = 45547,
  [33438] = 45549,
  [33440] = 45623,
  [33454] = 45573,
  [33456] = 45575,
  [33458] = 45576,
  [33459] = 45577,
  [33478] = 45923,
  [33480] = 45660,
  [33484] = 45924,
  [33487] = 45661,
  [33490] = 45925,
  [33493] = 45662,
  [33496] = 45926,
  [33498] = 45663,
  [33502] = 45927,
  [33505] = 45664,
  [33508] = 45928,
  [33511] = 45665,
  [33514] = 45929,
  [33516] = 45666,
  [33520] = 45930,
  [33523] = 45667,
  [33526] = 45888,
  [33528] = 45640,
  [33531] = 45641,
  [33537] = 45643,
  [33540] = 45644,
  [33552] = 45948,
  [33555] = 45683,
  [33557] = 45949,
  [33560] = 45684,
  [33563] = 45950,
  [33567] = 45685,
  [33569] = 45951,
  [33573] = 45686,
  [33575] = 45952,
  [33578] = 45687,
  [33581] = 45953,
  [33585] = 45688,
  [33587] = 45954,
  [33591] = 45689,
  [33593] = 45955,
  [33594] = 45690,
  [33596] = 54243,
  [33600] = 45980,
  [33602] = 46049,
  [33603] = 45621,
  [33606] = 45981,
  [33612] = 45982,
  [33614] = 45551,
  [33618] = 46035,
  [33620] = 45552,
  [33624] = 45984,
  [33626] = 45553,
  [33630] = 45985,
  [33632] = 45554,
  [33636] = 45986,
  [33638] = 45555,
  [33642] = 45987,
  [33644] = 45556,
  [33646] = 45557,
  [33648] = 46006,
  [33650] = 45624,
  [33652] = 46051,
  [33654] = 46007,
  [33660] = 46008,
  [33663] = 45579,
  [33666] = 46009,
  [33669] = 45580,
  [33672] = 46010,
  [33675] = 45581,
  [33678] = 46011,
  [33681] = 45582,
  [33684] = 46012,
  [33687] = 45583,
  [33690] = 46013,
  [33693] = 45584,
  [33694] = 45691,
  [33696] = 46032,
  [33697] = 45627,
  [33698] = 46053,
  [33699] = 45626,
  [33702] = 46033,
  [33708] = 46034,
  [33711] = 45607,
  [33714] = 45983,
  [33717] = 45608,
  [33720] = 46036,
  [33723] = 45609,
  [33726] = 46037,
  [33729] = 45610,
  [33732] = 46038,
  [33735] = 45611,
  [33738] = 46039,
  [33739] = 46081,
  [33741] = 45612,
  [33789] = 45931,
  [33795] = 45932,
  [33796] = 54371,
  [33797] = 45670,
  [33801] = 45933,
  [33802] = 45671,
  [33804] = 45672,
  [33808] = 45673,
  [33810] = 45674,
  [33813] = 45934,
  [33819] = 45935,
  [33825] = 45936,
  [33831] = 45937,
  [33837] = 45889,
  [33839] = 45648,
  [33843] = 45892,
  [33846] = 45649,
  [33849] = 45897,
  [33852] = 45650,
  [33855] = 45898,
  [33856] = 54370,
  [33857] = 45651,
  [33861] = 45903,
  [33862] = 54369,
  [33864] = 45652,
  [33867] = 45904,
  [33868] = 45791,
  [33870] = 45653,
  [33873] = 45909,
  [33879] = 45910,
  [33885] = 45956,
  [33886] = 45692,
  [33889] = 45693,
  [33891] = 45957,
  [33892] = 45694,
  [33895] = 45695,
  [33897] = 45958,
  [33898] = 45714,
  [33900] = 45715,
  [33903] = 45959,
  [33904] = 45702,
  [33906] = 45703,
  [33909] = 45960,
  [33910] = 45704,
  [33913] = 45705,
  [33915] = 45961,
  [33916] = 45706,
  [33919] = 45707,
  [33921] = 45962,
  [33922] = 45708,
  [33924] = 45709,
  [33927] = 45963,
  [33928] = 45710,
  [33931] = 45711,
  [33933] = 45988,
  [33939] = 45989,
  [33945] = 45990,
  [33947] = 45559,
  [33951] = 45991,
  [33953] = 45560,
  [33957] = 45992,
  [33959] = 45561,
  [33963] = 45993,
  [33965] = 45562,
  [33969] = 45994,
  [33971] = 45563,
  [33975] = 45995,
  [33977] = 45564,
  [33979] = 45565,
  [33981] = 46014,
  [33982] = 45625,
  [33984] = 54242,
  [33987] = 46015,
  [33993] = 46016,
  [33996] = 45587,
  [33999] = 46017,
  [34002] = 45588,
  [34005] = 46018,
  [34008] = 45589,
  [34011] = 46019,
  [34014] = 45590,
  [34017] = 46020,
  [34020] = 45591,
  [34023] = 46021,
  [34026] = 45592,
  [34027] = 46079,
  [34029] = 46040,
  [34030] = 45629,
  [34032] = 46054,
  [34033] = 45630,
  [34035] = 46041,
  [34041] = 46042,
  [34044] = 45614,
  [34047] = 46043,
  [34050] = 45615,
  [34053] = 46044,
  [34056] = 45616,
  [34059] = 46045,
  [34062] = 45617,
  [34065] = 46046,
  [34068] = 45618,
  [34071] = 46047,
  [34072] = 46082,
  [34074] = 45619,
  [42759] = 45668,
  [42784] = 45902,
  [42786] = 45645,
  [42790] = 45907,
  [42793] = 45646,
  [42796] = 45908,
  [42799] = 45647,
  [42804] = 45891,
  [42807] = 45895,
  [42808] = 45642,
  [42811] = 45896,
  [42814] = 45901,
  [43088] = 45965,
  [43089] = 45713,
  [43092] = 45697,
  [43094] = 45966,
  [43097] = 45717,
  [43124] = 45967,
  [43128] = 45698,
  [43142] = 45968,
  [43143] = 45716,
  [43154] = 45969,
  [43155] = 45718,
  [43158] = 45699,
  [46057] = 45632,
  [46058] = 45633,
  [46059] = 45634,
  [46060] = 45535,
  [46061] = 46055,
  [46062] = 45631,
  [46063] = 46056,
  [54377] = 45700,
  [55922] = 45701,
  [57080] = 56943,
  [57081] = 56944,
  [57082] = 56947,
  [57083] = 56946,
  [57084] = 56945,
  [57085] = 56948,
  [57086] = 56949,
  [57087] = 56950,
  [57088] = 56951,
  [57089] = 56952,
  [57090] = 56953,
  [57091] = 56954,
  [57092] = 56955,
  [57093] = 56956,
  [57094] = 56957,
  [57095] = 56958,
  [57096] = 56959,
  [57098] = 56961,
  [57099] = 56962,
  [57100] = 56963,
  [57101] = 56964,
  [57102] = 56965,
  [57103] = 56966,
  [57104] = 56967,
  [57105] = 56968,
  [57106] = 56969,
  [57107] = 56970,
  [57108] = 56971,
  [57109] = 56972,
  [57110] = 56973,
  [57111] = 56974,
  [57112] = 56975,
  [57113] = 56976,
  [57114] = 56977,
  [57115] = 56978,
  [57116] = 56979,
  [57117] = 56980,
  [57118] = 56981,
  [57119] = 56982,
  [57120] = 56983,
  [57121] = 56984,
  [57122] = 56985,
  [57123] = 56986,
  [57124] = 56987,
  [57125] = 56988,
  [57126] = 56989,
  [57127] = 56990,
  [57128] = 56991,
  [57129] = 56992,
  [57130] = 56993,
  [57131] = 56994,
  [57132] = 56995,
  [57133] = 56996,
  [57134] = 56997,
  [57135] = 56998,
  [57136] = 56999,
  [57137] = 57000,
  [57138] = 57001,
  [57139] = 57002,
  [57140] = 57003,
  [57141] = 57004,
  [57142] = 57005,
  [57143] = 57006,
  [57144] = 57007,
  [57145] = 57008,
  [57146] = 57009,
  [57147] = 57010,
  [57148] = 57011,
  [57149] = 57012,
  [57150] = 57013,
  [57151] = 57014,
  [57152] = 57015,
  [57153] = 57016,
  [57155] = 57017,
  [57156] = 57018,
  [57157] = 57019,
  [57158] = 57020,
  [57159] = 57021,
  [57160] = 57022,
  [57161] = 57023,
  [57162] = 57024,
  [57163] = 57025,
  [57164] = 57026,
  [57165] = 57027,
  [57166] = 57028,
  [57167] = 57029,
  [57168] = 57030,
  [57169] = 57031,
  [57170] = 57032,
  [57171] = 57033,
  [57172] = 57034,
  [57173] = 57035,
  [57174] = 57036,
  [57175] = 57037,
  [57176] = 57038,
  [57177] = 57039,
  [57178] = 57040,
  [57179] = 57041,
  [57180] = 57042,
  [57181] = 57043,
  [57182] = 57044,
  [57183] = 57045,
  [57184] = 57046,
  [57185] = 57047,
  [57186] = 57048,
  [57187] = 57049,
  [57188] = 57050,
  [57189] = 57051,
  [57190] = 57052,
  [57191] = 57053,
  [57192] = 57054,
  [57193] = 57055,
  [57194] = 57056,
  [57195] = 57057,
  [57196] = 57058,
  [57197] = 57059,
  [57198] = 57060,
  [57199] = 57061,
  [57200] = 57062,
  [57201] = 57063,
  [57202] = 57064,
  [57203] = 57065,
  [57204] = 57066,
  [57205] = 57067,
  [57206] = 57068,
  [57207] = 57069,
  [57208] = 57070,
  [57209] = 57071,
  [57210] = 57072,
  [57211] = 57073,
  [57212] = 57074,
  [57213] = 57075,
  [57214] = 57076,
  [57215] = 57077,
  [57216] = 57078,
  [57217] = 57079,
  [64221] = 64223,
  [68233] = 68189,
  [68234] = 68190,
  [68235] = 68191,
  [68236] = 68192,
  [68237] = 68193,
  [68238] = 68194,
  [68239] = 68195,
  [68240] = 68196,
  [68241] = 68197,
  [68242] = 68198,
  [68243] = 68199,
  [68244] = 68200,
  [68245] = 68201,
  [68246] = 68202,
  [68247] = 68203,
  [68248] = 68204,
  [68249] = 68205,
  [68250] = 68206,
  [68251] = 68207,
  [68252] = 68208,
  [68253] = 68209,
  [68254] = 68210,
  [68255] = 68211,
  [68256] = 68212,
  [68257] = 68213,
  [68258] = 68214,
  [68259] = 68215,
  [68260] = 68216,
  [68261] = 68217,
  [68262] = 68218,
  [68263] = 68219,
  [68264] = 68220,
  [68265] = 68221,
  [68266] = 68222,
  [68267] = 68223,
  [68268] = 68224,
  [68269] = 68225,
  [68270] = 68226,
  [68271] = 68227,
  [68272] = 68228,
  [68273] = 68229,
  [68274] = 68230,
  [68275] = 68231,
  [68276] = 68232,
  [71056] = 71060,
  [71057] = 71061,
  [71058] = 71062,
  [71059] = 71063,
  [87685] = 87682,
  [87686] = 87683,
  [87687] = 87684,
  [87690] = 87688,
  [87691] = 87689,
  [87695] = 87692,
  [87696] = 87693,
  [87697] = 87694,
  [87699] = 87698,
  [101879] = 96968,
  [112425] = 96967,
  [112426] = 96966,
  [112433] = 96965,
  [112434] = 96964,
  [112435] = 96963,
  [112438] = 96962,
  [112439] = 96961,
  [112440] = 96960,
  [115027] = 115029,
  [120076] = 120077,
  [120436] = 120767,
  [120762] = 120768,
  [120763] = 120769,
  [120764] = 120770,
  [133554] = 133551,
  [133555] = 133552,
  [133556] = 133553,
  [139016] = 139012,
  [139018] = 139017,
  [153625] = 153624,
  [153627] = 153626,
  [153629] = 153628,
  [171323] = 171324,
  [171329] = 171331,
  [171432] = 171435
}

-- Recipe --------------------------------------------------------------------

Provisioning.Recipe = {}
local Recipe = Provisioning.Recipe
function Recipe:New(args)
  local o = {
    class = "provisioning",
    fooddrink_item_id = args.fooddrink_item_id, -- int(33526)
    recipe_item_id = args.recipe_item_id, -- int(45888)
    recipe_link = args.recipe_link, -- "|H1:item:45888:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    is_known = args.is_known, -- true
    mat_list = {}, -- list of MatRow ingredients
    fooddrink_link = nil,
    fooddrink_name = nil
  }

  setmetatable(o, self)
  self.__index = self
  return o
end

function Recipe:FromFoodDrinkItemID(fooddrink_item_id)
  local MatRow = WritWorthy.MatRow

  local o = Recipe:New({ fooddrink_item_id = fooddrink_item_id })
  o.recipe_item_id = Provisioning.FOODDRINK_TO_RECIPE_ITEM_ID[fooddrink_item_id]
  if not o.recipe_item_id then
    return nil
  end
  o.recipe_link = string.format("|H1:item:%d:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", o.recipe_item_id)
  o.fooddrink_link = GetItemLinkRecipeResultItemLink(o.recipe_link, LINK_STYLE_DEFAULT)
  o.fooddrink_name = WritWorthy.FoodDrink(GetItemLinkItemId(o.fooddrink_link))
  o.is_known = IsItemLinkRecipeKnown(o.recipe_link)

  local r = { GetItemLinkItemType(o.fooddrink_link) }
  o.fooddrink_item_type = r[1]
  o.fooddrink_specialized_item_type = r[2]

  local log_t = {}
  log_t.fooddrink_item_id = fooddrink_item_id
  log_t.recipe_item_id = o.recipe_item_id
  log_t.recipe_link = o.recipe_link
  log_t.fooddrink_link = o.fooddrink_link
  log_t.fooddrink_name = o.fooddrink_name
  log_t.is_known = o.is_known
  log_t.fooddrink_item_type = o.fooddrink_item_type
  log_t.fooddrink_specialized_item_type = o.fooddrink_specialized_item_type
  Log:Add(log_t)

  local mat_ct = GetItemLinkRecipeNumIngredients(o.recipe_link)
  local cook_ct = 2 -- Usually need to craft 2x batches for master writs
  for ingr_index = 1, mat_ct do
    local _, _, ingr_ct = GetItemLinkRecipeIngredientInfo(o.recipe_link, ingr_index)
    local ingr_link = GetItemLinkRecipeIngredientItemLink(o.recipe_link, ingr_index, LINK_STYLE_DEFAULT)
    if 0 < ingr_ct and ingr_link and ingr_link ~= "" then
      local mr = MatRow:FromLink(ingr_link, ingr_ct * cook_ct)
      table.insert(o.mat_list, mr)
    end
  end
  return o
end

-- Provisioning --------------------------------------------------------------

-- Find a recipe by fooddrink_item_id
--
-- First time this runs, we decompress a list of all 554 recipe names.
-- Takes 1+ second!
--
-- Second-and-later times this runs, it's O(1) instantaneous.
--
-- returns a Recipe{} instance.
--
function Provisioning.FindRecipe(fooddrink_item_id)
  local recipe = Recipe:FromFoodDrinkItemID(fooddrink_item_id)
  if not recipe then
    return Fail("WritWorthy: recipe not found:" .. tostring(fooddrink_item_id))
  end
  return recipe
end

Provisioning.Parser = {
  class = "provisioning"
}
local Parser = Provisioning.Parser

function Parser:New()
  local o = {
    recipe = nil, -- Recipe{}
    crafting_type = CRAFTING_TYPE_PROVISIONING
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Parser:ParseItemLink(item_link)
  Log:StartNewEvent("ParseItemLink: %s %s", self.class, item_link)
  local fields = Util.ToWritFields(item_link)
  self.recipe = Provisioning.FindRecipe(fields.writ1)
  if not self.recipe then
    return nil
  end
  return self
end

function Parser:ToMatList()
  return self.recipe.mat_list
end

function Parser:ToKnowList()
  Log:StartNewEvent("ToKnowList: %s", self.class)
  local Know = WritWorthy.Know
  local k = Know:New(
    {
      name = "recipe",
      is_known = self.recipe.is_known,
      lack_msg = WritWorthy.Str("know_err_recipe"),
      how = WritWorthy.Know.KNOW.RECIPE
    }
  )
  local r = { k }
  if self.recipe.fooddrink_item_type == ITEMTYPE_FOOD then
    local chef = WritWorthy.RequiredSkill.PR_FOOD_4X:ToKnow()
    chef.is_warn = true
    table.insert(r, chef)
  elseif self.recipe.fooddrink_item_type == ITEMTYPE_DRINK then
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
  o[2] = 2 -- timesToMake
  o[3] = true -- autocraft
  o[4] = unique_id -- reference
  return {
    ["function"] = "CraftProvisioningItemByRecipeId",
    ["args"] = o
  }
end
