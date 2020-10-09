------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
------------------------------------------------------------------------------
function define_global_sets()
-- Special gear info that may be useful across jobs.

	-- Flamma Set
	gear.flamma_head		= "Flamma Zucchetto +2"
	gear.flamma_body		= "Flamma Korazin +1"
	gear.flamma_hands		= "Flamma Manopolas +1"
	gear.flamma_legs		= "Flamma Dirs +1"
	gear.flamma_feet		= "Flamma Gambieras +2"
	
	-- Sulevia Set
	gear.sulevia_hands		= "Sulevia's Gauntlets +2"
	gear.sulevia_legs		= "Sulevia's Cuisses +2"
	gear.sulevia_feet		= "Sulevia's Leggings +2"
	
	-- Telchine Mods	
	gear.telchine_head_enh_dur	={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
    gear.telchine_body_enh_dur	={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}}
    gear.telchine_hands_enh_dur	={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}}
    gear.telchine_legs_enh_dur	={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
    gear.telchine_feet_enh_dur	={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}
	
	gear.telchine_head_pet_dt	={ name="Telchine Cap", augments={'DEF+17','Pet: Damage taken -4%',}}
    gear.telchine_body_pet_dt	={ name="Telchine Chas.", augments={'Evasion+19','Pet: Damage taken -4%',}}
    gear.telchine_legs_pet_dt	={ name="Telchine Braconi", augments={'Evasion+18','Pet: Damage taken -3%',}}
    gear.telchine_feet_pet_dt	={ name="Telchine Pigaches", augments={'Evasion+18','Pet: Damage taken -4%',}}
	
	gear.vanya_head_skill		={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_body_skill		={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_hands_skill		={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_legs_skill		={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.vanya_feet_skill		={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	
	gear.valorous_feet_th		={ name="Valorous Greaves", augments={'Crit.hit rate+1','STR+8','"Treasure Hunter"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	
	------------------------------------------------------------------------------

	-- Weapons

	------------------------------------------------------------------------------

	-- Crafting
	sets.crafting_skillup = {}
	sets.crafting_hq = set_combine(sets.crafting_skillup, {})

end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	sets.reive = {}
end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end