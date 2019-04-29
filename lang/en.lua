local WritWorthy = _G['WritWorthy'] or {} -- defined in WritWorthy_Define.lua

-- Static UI strings that should be translated to other languages.

WritWorthy.I18N = WritWorthy.I18N or {}

WritWorthy.I18N['shorten'] = WritWorthy.I18N['shorten'] or {}
WritWorthy.I18N['shorten']['en'] = {
    ["Alchemy"                     ] = "Alchemy"
,   ["Alessia's Bulwark"           ] = "Alessia's"
,   ["Ancestor Silk Breeches"      ] = "breeches"
,   ["Ancestor Silk Epaulets"      ] = "epaulets"
,   ["Ancestor Silk Gloves"        ] = "gloves"
,   ["Ancestor Silk Hat"           ] = "hat"
,   ["Ancestor Silk Jerkin"        ] = "shirt"
,   ["Ancestor Silk Robe"          ] = "robe"
,   ["Ancestor Silk Sash"          ] = "sash"
,   ["Ancestor Silk Shoes"         ] = "shoes"
,   ["Armor of the Seducer"        ] = "Seducer"
,   ["Enchanting"                  ] = "Enchant"
,   ["Night Mother's Gaze"         ] = "Night Mother's"
,   ["Pelinal's Aptitude"          ] = "Pelinal's"
,   ["Provisioning"                ] = "Provis"
,   ["Rubedite Axe"                ] = "1h axe"
,   ["Rubedite Battle Axe"         ] = "2h battle axe"
,   ["Rubedite Cuirass"            ] = "cuirass"
,   ["Rubedite Dagger"             ] = "dagger"
,   ["Rubedite Gauntlets"          ] = "gauntlets"
,   ["Rubedite Girdle"             ] = "girdle"
,   ["Rubedite Greatsword"         ] = "2h greatsword"
,   ["Rubedite Greaves"            ] = "greaves"
,   ["Rubedite Helm"               ] = "helm"
,   ["Rubedite Mace"               ] = "1h mace"
,   ["Rubedite Maul"               ] = "2h maul"
,   ["Rubedite Pauldron"           ] = "pauldron"
,   ["Rubedite Sabatons"           ] = "sabatons"
,   ["Rubedite Sword"              ] = "1h sword"
,   ["Rubedo Leather Arm Cops"     ] = "arm cops"
,   ["Rubedo Leather Belt"         ] = "belt"
,   ["Rubedo Leather Boots"        ] = "boots"
,   ["Rubedo Leather Bracers"      ] = "bracers"
,   ["Rubedo Leather Guards"       ] = "guards"
,   ["Rubedo Leather Helmet"       ] = "helmet"
,   ["Rubedo Leather Jack"         ] = "jack"
,   ["Ruby Ash Bow"                ] = "bow"
,   ["Ruby Ash Ice Staff"          ] = "frost"
,   ["Ruby Ash Inferno Staff"      ] = "flame"
,   ["Ruby Ash Lightning Staff"    ] = "lightning"
,   ["Ruby Ash Restoration Staff"  ] = "resto"
,   ["Ruby Ash Shield"             ] = "shield"
,   ["Whitestrake's Retribution"   ] = "Whitestrake's"
,   ["Woodworking"                 ] = "Wood"
}

WritWorthy.I18N['static'] = {}
WritWorthy.I18N['static']['en'] = {
    ["ags_label"                             ] = "WritWorthy cost per voucher"
,   ["button_dequeue_all"                    ] = "Dequeue All"
,   ["button_enqueue_all"                    ] = "Enqueue All"
,   ["button_sort_by_station"                ] = "Sort by Station"
,   ["count_writs_vouchers"                  ] = "%d writs, %s vouchers"
,   ["currency_suffix_gold"                  ] = "g"
,   ["currency_suffix_gold_per_voucher"      ] = "g/v"
,   ["currency_suffix_voucher"               ] = "v"
,   ["empty"                                 ] = ""
,   ["enchanting_cp150"                      ] = "Superb"
,   ["enchanting_cp160"                      ] = "Truly Superb"
,   ["err_could_not_parse"                   ] = "Could not parse."
,   ["glyph_absorb_health"                   ] = "Absorb Health"
,   ["glyph_absorb_magicka"                  ] = "Absorb Magicka"
,   ["glyph_absorb_stamina"                  ] = "Absorb Stamina"
,   ["glyph_bashing"                         ] = "Bashing"
,   ["glyph_crushing"                        ] = "Crushing"
,   ["glyph_decrease_health"                 ] = "Decrease Health"
,   ["glyph_decrease_physical_harm"          ] = "Decrease Physical Harm"
,   ["glyph_decrease_spell_harm"             ] = "Decrease Spell Harm"
,   ["glyph_disease_resist"                  ] = "Disease Resist"
,   ["glyph_flame"                           ] = "Flame"
,   ["glyph_flame_resist"                    ] = "Flame Resist"
,   ["glyph_foulness"                        ] = "Foulness"
,   ["glyph_frost"                           ] = "Frost"
,   ["glyph_frost_resist"                    ] = "Frost Resist"
,   ["glyph_hardening"                       ] = "Hardening"
,   ["glyph_health"                          ] = "Health"
,   ["glyph_health_recovery"                 ] = "Health Recovery"
,   ["glyph_increase_magical_harm"           ] = "Increase Magical Harm"
,   ["glyph_increase_physical_harm"          ] = "Increase Physical Harm"
,   ["glyph_magicka"                         ] = "Magicka"
,   ["glyph_magicka_recovery"                ] = "Magicka Recovery"
,   ["glyph_poison"                          ] = "Poison"
,   ["glyph_poison_resist"                   ] = "Poison Resist"
,   ["glyph_potion_boost"                    ] = "Potion Boost"
,   ["glyph_potion_speed"                    ] = "Potion Speed"
,   ["glyph_prismatic_defense"               ] = "Prismatic Defense"
,   ["glyph_prismatic_onslaught"             ] = "Prismatic Onslaught"
,   ["glyph_reduce_feat_cost"                ] = "Reduce Feat Cost"
,   ["glyph_reduce_spell_cost"               ] = "Reduce Spell Cost"
,   ["glyph_shielding"                       ] = "Shielding"
,   ["glyph_shock"                           ] = "Shock"
,   ["glyph_shock_resist"                    ] = "Shock Resist"
,   ["glyph_stamina"                         ] = "Stamina"
,   ["glyph_stamina_recovery"                ] = "Stamina Recovery"
,   ["glyph_weakening"                       ] = "Weakening"
,   ["glyph_weapon_damage"                   ] = "Weapon Damage"
,   ["header_Detail 1"                       ] = "Detail 1"
,   ["header_Detail 2"                       ] = "Detail 2"
,   ["header_Detail 3"                       ] = "Detail 3"
,   ["header_Detail 4"                       ] = "Detail 4"
,   ["header_Q"                              ] = "Q"
,   ["header_Quality"                        ] = "Quality"
,   ["header_Type"                           ] = "Type"
,   ["header_V"                              ] = "V"
,   ["header_tooltip_Q"                      ] = "Enqueued for crafting"
,   ["header_tooltip_V"                      ] = "Voucher count"
,   ["keybind_writworthy"                    ] = "Toggle window"
,   ["know_err_motif"                        ] = "Motif %s not known"
,   ["know_err_recipe"                       ] = "Recipe not known"
,   ["know_err_skill_missing"                ] = "Missing skill: %s"
,   ["know_err_skill_not_maxed"              ] = "Insufficient skill '%s': %d/%d"
,   ["know_err_trait"                        ] = "Trait %s %s not known"
,   ["know_err_trait_ct_too_low"             ] = "%d of %d traits required for set %s"
,   ["lam_banked_vouchers_desc"              ] = "Scan bank and include those writs in the list of writs available to automatically craft.\n|cFF3333BE CAREFUL if you craft on multiple characters! WritWorthy will not warn you if you craft the same banked writ on multiple characters.|r"
,   ["lam_banked_vouchers_title"             ] = "Include writs from bank in auto-crafting window"
,   ["lam_mat_list_alchemy_only"             ] = "Alchemy Only"
,   ["lam_mat_list_all"                      ] = "All"
,   ["lam_mat_list_desc"                     ] = "Write several lines of materials to chat each time a Master Writ tooltip appears."
,   ["lam_mat_list_off"                      ] = "Off"
,   ["lam_mat_list_title"                    ] = "Show material list in chat"
,   ["lam_mat_price_tt_desc"                 ] = "Insert text into tooltip with the cost of all the materials that crafting this writ would consume."
,   ["lam_mat_price_tt_title"                ] = "Show material price in tooltip"
,   ["lam_mm_fallback_desc"                  ] = "If M.M. has no price average for some materials:\n* use 15g for basic style materials such as Molybdenum\n* use 5g for common trait materials such as Quartz."
,   ["lam_mm_fallback_title"                 ] = "M.M. Fallback: hardcoded prices if no M.M. data"
,   ["lam_station_colors_desc"               ] = "Use different colors for blacksmithing, clothing, and woodworking items in the WritWorthy window."
,   ["lam_station_colors_title"              ] = "Station colors in window"
,   ["slash_auto"                            ] = "auto"
,   ["slash_auto_desc"                       ] = "Automatically accept quests from inventory."
,   ["slash_count"                           ] = "count"
,   ["slash_count_desc"                      ] = "How many master writs in this character's inventory/bank?"
,   ["slash_discover"                        ] = "discover"
,   ["slash_discover_desc"                   ] = "Dump item_link writ fields to tables in log"
,   ["slash_forget"                          ] = "forget"
,   ["slash_forget_desc"                     ] = "Forget this character's crafted master writs"
,   ["slash_writworthy_desc"                 ] = "Show/hide WritWorthy window"
,   ["status_discover"                       ] = "scanning writ fields..."
,   ["status_forget"                         ] = "forgetting everything this character already crafted..."
,   ["status_list_empty_no_writs"            ] = "This character has no sealed master writs in its inventory."
,   ["summary_completed_average_voucher_cost"] = "average completed voucher cost"
,   ["summary_completed_mat_cost"            ] = "total materials completed"
,   ["summary_completed_voucher_ct"          ] = "total vouchers completed"
,   ["summary_queued_average_voucher_cost"   ] = "average queued voucher cost"
,   ["summary_queued_mat_cost"               ] = "total materials queued"
,   ["summary_queued_voucher_ct"             ] = "total vouchers queued"
,   ["title_writ_inventory_player"           ] = "Writ Inventory: %s"
,   ["title_writ_inventory_player_bank"      ] = "Writ Inventory: %s + bank"
,   ["tooltip_crafted"                       ] = "crafting completed"
,   ["tooltip_mat_total"                     ] = "Mat total"
,   ["tooltip_per_voucher"                   ] = "Per voucher"
,   ["tooltip_purchase"                      ] = "Purchase"
,   ["tooltip_queued"                        ] = "queued for crafting"
,   ["tooltip_sell_for"                      ] = "Sell for %s g"
,   ["tooltip_sell_for_cannot"               ] = "Cannot sell for %s g"
}

