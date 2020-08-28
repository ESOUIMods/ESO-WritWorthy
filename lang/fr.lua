local WritWorthy = _G['WritWorthy'] or {} -- defined in WritWorthy_Define.lua

-- Static UI strings that should be translated to other languages.

WritWorthy.I18N = WritWorthy.I18N or {}

WritWorthy.I18N['shorten'] = WritWorthy.I18N['shorten'] or {}
WritWorthy.I18N['shorten']['fr'] = {
    ["Alchemy"                     ] = "Alchimie"
,   ["Alessia's Bulwark"           ] = "Alessia"
,   ["Ancestor Silk Breeches"      ] = "Braies"
,   ["Ancestor Silk Epaulets"      ] = "Épaulettes"
,   ["Ancestor Silk Gloves"        ] = "Gants"
,   ["Ancestor Silk Hat"           ] = "Chapeau"
,   ["Ancestor Silk Jerkin"        ] = "Chemise"
,   ["Ancestor Silk Robe"          ] = "Robe"
,   ["Ancestor Silk Sash"          ] = "Baudrier"
,   ["Ancestor Silk Shoes"         ] = "Chaussures"
,   ["Enchanting"                  ] = "Enchantement"
,   ["Night Mother's Gaze"         ] = "Mère de la nuit"
,   ["Pelinal's Aptitude"          ] = "Pélinal"
,   ["Provisioning"                ] = "Approvisionnement"
,   ["Rubedite Axe"                ] = "Hache"
,   ["Rubedite Battle Axe"         ] = "Hache de Bataille"
,   ["Rubedite Cuirass"            ] = "Cuirasse"
,   ["Rubedite Dagger"             ] = "Dague"
,   ["Rubedite Gauntlets"          ] = "Gantelets"
,   ["Rubedite Girdle"             ] = "Gaine"
,   ["Rubedite Greatsword"         ] = "épée longue"
,   ["Rubedite Greaves"            ] = "Grèves"
,   ["Rubedite Helm"               ] = "Heaume"
,   ["Rubedite Mace"               ] = "Masse"
,   ["Rubedite Maul"               ] = "Masse d'armes"
,   ["Rubedite Pauldron"           ] = "Spallière"
,   ["Rubedite Sabatons"           ] = "Solerets"
,   ["Rubedite Sword"              ] = "Épée"
,   ["Rubedo Leather Arm Cops"     ] = "Coque d'épaules"
,   ["Rubedo Leather Belt"         ] = "Ceinture"
,   ["Rubedo Leather Boots"        ] = "Bottes"
,   ["Rubedo Leather Bracers"      ] = "Brassards"
,   ["Rubedo Leather Guards"       ] = "Gardes"
,   ["Rubedo Leather Helmet"       ] = "Casque"
,   ["Rubedo Leather Jack"         ] = "Gilet"
,   ["Ruby Ash Bow"                ] = "Arc"
,   ["Ruby Ash Ice Staff"          ] = "Glace"
,   ["Ruby Ash Inferno Staff"      ] = "Infernal"
,   ["Ruby Ash Lightning Staff"    ] = "Foudre"
,   ["Ruby Ash Restoration Staff"  ] = "Rétablissement"
,   ["Ruby Ash Shield"             ] = "Bouclier"
,   ["Whitestrake's Retribution"   ] = "Blancserpent"
,   ["Woodworking"                 ] = "Travail du bois"
}

WritWorthy.I18N['static'] = WritWorthy.I18N['static'] or {}
WritWorthy.I18N['static']['en'] = {
    ["ags_label"                             ] = "WritWorthy coût par assignats"
,   ["button_dequeue_all"                    ] = "Retirer de la file"
,   ["button_enqueue_all"                    ] = "Mettre en file"
,   ["button_sort_by_station"                ] = "Tri par Station"
,   ["count_writs_vouchers"                  ] = "%d Commandes, %s Assignats"
,   ["currency_suffix_gold"                  ] = " O"
,   ["currency_suffix_gold_per_voucher"      ] = " O/A"
,   ["currency_suffix_voucher"               ] = " A"
,   ["empty"                                 ] = ""
,   ["enchanting_cp150"                      ] = "Superbe"
,   ["enchanting_cp160"                      ] = "Vraiment Superbe"
,   ["err_could_not_parse"                   ] = "Impossible d'analyser."
,   ["glyph_absorb_health"                   ] = "Absorbe la santé"
,   ["glyph_absorb_magicka"                  ] = "Absorbe la magie"
,   ["glyph_absorb_stamina"                  ] = "Absorbe la vigueur"
,   ["glyph_bashing"                         ] = "Percutant"
,   ["glyph_crushing"                        ] = "Écrasement"
,   ["glyph_decrease_health"                 ] = "Diminue la santé"
,   ["glyph_decrease_physical_harm"          ] = "Diminue les dommages physiques"
,   ["glyph_decrease_spell_harm"             ] = "Diminue les dégâts des sorts"
,   ["glyph_disease_resist"                  ] = "Résistance aux maladies"
,   ["glyph_flame"                           ] = "Ardent"
,   ["glyph_flame_resist"                    ] = "Ignifugé"
,   ["glyph_foulness"                        ] = "Odieux"
,   ["glyph_frost"                           ] = "Froid"
,   ["glyph_frost_resist"                    ] = "Résistance au givre"
,   ["glyph_hardening"                       ] = "Durcissement"
,   ["glyph_health"                          ] = "Santé"
,   ["glyph_health_recovery"                 ] = "Récupération de santé"
,   ["glyph_increase_magical_harm"           ] = "Augmente les dégâts magiques"
,   ["glyph_increase_physical_harm"          ] = "Augmente les dommages physiques"
,   ["glyph_magicka"                         ] = "Magie"
,   ["glyph_magicka_recovery"                ] = "Récupération de magie"
,   ["glyph_poison"                          ] = "Poison"
,   ["glyph_poison_resist"                   ] = "Résistance au poison"
,   ["glyph_potion_boost"                    ] = "Augmente la durée des effets de potions"
,   ["glyph_potion_speed"                    ] = "Accélération de potion"
,   ["glyph_prismatic_defense"               ] = "Défense prismatique"
,   ["glyph_prismatic_onslaught"             ] = "Assaut prismatique"
,   ["glyph_reduce_feat_cost"                ] = "Réduit le coût des compétences"
,   ["glyph_reduce_spell_cost"               ] = "Réduit le coût des sorts"
,   ["glyph_shielding"                       ] = "Blindage"
,   ["glyph_shock"                           ] = "étourdissant"
,   ["glyph_shock_resist"                    ] = "Résistance à la foudre"
,   ["glyph_stamina"                         ] = "Vigueur"
,   ["glyph_stamina_recovery"                ] = "Recupération de vigueur"
,   ["glyph_weakening"                       ] = "Affaiblissement"
,   ["glyph_weapon_damage"                   ] = "Dégâts d'arme"
,   ["header_Detail 1"                       ] = "Détail 1"
,   ["header_Detail 2"                       ] = "Détail 2"
,   ["header_Detail 3"                       ] = "Détail 3"
,   ["header_Detail 4"                       ] = "Détail 4"
,   ["header_Q"                              ] = "F"
,   ["header_M"                              ] = "C"
,   ["header_Quality"                        ] = "Qualité"
,   ["header_Type"                           ] = "Type"
,   ["header_V"                              ] = "A"
,   ["header_tooltip_Q"                      ] = "En file d'attente pour l'artisanat"
,   ["header_tooltip_M"                      ] = "Utilisée une pierre caméléons ?"
,   ["header_tooltip_V"                      ] = "Nombre d'assignats"
,   ["keybind_writworthy"                    ] = "Basculer la fenêtre"
,   ["know_err_motif"                        ] = "Motif %s pas connu"
,   ["know_err_recipe"                       ] = "Recette inconnue"
,   ["know_err_skill_missing"                ] = "Compétence manquante: %s"
,   ["know_err_skill_not_maxed"              ] = "Compétence insuffisante '%s': %d/%d"
,   ["know_err_trait"                        ] = "Trait %s %s pas connu"
,   ["know_err_trait_ct_too_low"             ] = "%d sur %d traits requis pour l'ensemble %s"
,   ["lam_banked_vouchers_desc"              ] = "Scannez la banque et incluez ces commandes dans la liste des commandes disponibles pour fabriquer automatiquement.\n|cFF3333SOYEZ PRUDENT si vous fabriquez sur plusieurs personnages! WritWorthy ne vous avertira pas si vous fabriquez la même commande en banque sur plusieurs personnages.|r"
,   ["lam_banked_vouchers_title"             ] = "Inclure les commande en banque dans la fenêtre de fabrication automatique"
,   ["lam_force_en_desc"                     ] = "Ignorer le paramètre de langue du client et utiliser l'Anglais pour tous les textes dans WritWorthy."
,   ["lam_force_en_title"                    ] = "Force en Anglais"
,   ["lam_mat_list_alchemy_only"             ] = "Alchimie uniquement"
,   ["lam_mat_list_all"                      ] = "Tout"
,   ["lam_mat_list_desc"                     ] = "Écris plusieurs lignes de documents dans le tchat chaque fois qu'une info-bulle commande de maître apparaît."
,   ["lam_mat_list_off"                      ] = "Arrêt"
,   ["lam_mat_list_title"                    ] = "Affiche la liste des matériaux dans le tchat"
,   ["lam_mat_price_tt_desc"                 ] = "Insére du texte dans l'info-bulle avec le coût de tous les matériaux, que la fabrication que cette commande consommerait."
,   ["lam_mat_price_tt_title"                ] = "Affiche le prix du matériau dans l'info-bulle"
,   ["lam_mm_fallback_desc"                  ] = "Si LibPrice ne peut pas obtenir un prix de MM / ATT / TTC pour certains matériaux:\n* utilisé 15 Or pour les matériaux de style de base tels que Molybden\n* utilisé 5 Or pour des matériaux communs tels que Quartz."
,   ["lam_mm_fallback_title"                 ] = "Retour aux prix codés en dur si aucune donnée LibPrice"
,   ["lam_lib_price_desc"                    ] = "Vérifie auprès de MM / ATT / TTC les prix des matériaux. Nécessite LibPrice."
,   ["lam_lib_price_title"                   ] = "Utilise LibPrice pour les prix des matériaux"
,   ["lam_station_colors_desc"               ] = "Utilise différentes couleurs pour la forge, les vêtements et les articles de menuiserie dans la fenêtre WritWorthy."
,   ["lam_station_colors_title"              ] = "Couleurs de la station dans la fenêtre"
,   ["max_gold_per_voucher"                  ] = "Max d'or par Assignats:"
,   ["slash_auto"                            ] = "Auto"
,   ["slash_auto_desc"                       ] = "Accepter automatiquement les quêtes de l'inventaire."
,   ["slash_count"                           ] = "Compter"
,   ["slash_count_desc"                      ] = "Combien de commandes de maître dans l'inventaire / la banque de ce personnage ?"
,   ["slash_discover"                        ] = "Découvrir"
,   ["slash_discover_desc"                   ] = "Vider les champs d'écriture item_link dans les tables du journal"
,   ["slash_forget"                          ] = "Oublier"
,   ["slash_forget_desc"                     ] = "Oubliez les commandes de maître fabriquées par ce personnage"
,   ["slash_writworthy_desc"                 ] = "Afficher / masquer la fenêtre WritWorthy"
,   ["status_discover"                       ] = "Analyse des champs d'écriture..."
,   ["status_forget"                         ] = "Oublie tout ce que ce personnage a déjà créé..."
,   ["status_list_empty_no_writs"            ] = "Ce personnage n'a pas de commandes de maître scellé dans son inventaire."
,   ["summary_completed_average_voucher_cost"] = "Coût moyen des assignats terminés"
,   ["summary_completed_mat_cost"            ] = "Coût total des matériaux terminés"
,   ["summary_completed_voucher_ct"          ] = "Total des assignats termninés"
,   ["summary_completed_writ_ct"             ] = "Total des commandes terminés"
,   ["summary_queued_average_voucher_cost"   ] = "Coût moyen des assignats en file d'attente"
,   ["summary_queued_mat_cost"               ] = "Coût total des matériaux en file d'attente"
,   ["summary_queued_voucher_ct"             ] = "Total des assignats en file d'attente"
,   ["summary_queued_writ_ct"                ] = "Total des commandes en file d'attente"
,   ["title_writ_inventory_player"           ] = "Inventaire des commandes: %s"
,   ["title_writ_inventory_player_bank"      ] = "Inventaire des commandes: %s + Banque"
,   ["tooltip_crafted"                       ] = "Fabrication terminée"
,   ["tooltip_mat_total"                     ] = "Matériel total"
,   ["tooltip_per_voucher"                   ] = "Par assignats"
,   ["tooltip_purchase"                      ] = "Achat"
,   ["tooltip_queued"                        ] = "En attente pour la fabrication"
,   ["tooltip_sell_for"                      ] = "à vendre pour %s O"
,   ["tooltip_sell_for_cannot"               ] = "Impossible de vendre pour %s O"
}

