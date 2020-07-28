------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
------------------------------------------------------------------------------
function define_global_sets()
-- Special gear info that may be useful across jobs.

	-- Meghanada Set
	gear.meghanada_head		= "Meghanada Visor +2"
	gear.meghanada_body		= "Meghanada Cuirie +2"
	gear.meghanada_hands	= "Meghanada Gloves +2"
	gear.meghanada_legs		= "Meghanada Chausses +1"
	gear.meghanada_feet		= "Meghanada Jambeaux +2"
	
	-- Mummu Set
	gear.mummu_head			= "Mummu Bonnet +1"
	gear.mummu_body			= "Mummu Jacket +2"
	gear.mummu_hands		= "Mummu Wrists +1"
	gear.mummu_legs			= "Mummu Kecks +2"
	gear.mummu_feet			= "Mummu Gamashes +1"
	
	-- Flamma Set
	gear.flamma_head		= "Flamma Zucchetto +2"
	gear.flamma_body		= "Flamma Korazin +2"
	gear.flamma_hands		= "Flamma Manopolas +2"
	gear.flamma_legs		= "Flamma Dirs +1"
	gear.flamma_feet		= "Flamma Gambieras +2"
	
	-- Jhakri Set
	gear.jhakri_head		= "Jhakri Coronal +2"
	gear.jhakri_body		= "Jhakri Robe +2"
	gear.jhakri_hands		= "Jhakri Cuffs +2"
	gear.jhakri_legs		= "Jhakri Slops +2"
	gear.jhakri_feet		= "Jhakri Pigaches +2"
	
	-- Hizamaru Set
	gear.hizamaru_legs		= "Hizamaru Hizayoroi +2"
	
	-- Inyanga Set
	gear.inyanga_body		= "Inyanga Jubbah +2"
	
	-- Adhemar Mods
	gear.adhemar_head_melee 	={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.adhemar_body_melee 	={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.adhemar_hands_melee 	={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.adhemar_legs_preshot 	={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
	
	-- Herculean Mods
	gear.herc_head_mabwsd 		={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','Weapon skill damage +4%','INT+2',}}
	gear.herc_head_wsd 			={ name="Herculean Helm", augments={'Weapon skill damage +5%','Accuracy+12',}}
	gear.herculean_legs_wsd 	={ name="Herculean Trousers", augments={'Pet: Haste+4','Accuracy+4 Attack+4','Weapon skill damage +10%',}}
	gear.herculean_legs_mab 	={ name="Herculean Trousers", augments={'MND+1','Accuracy+13','Weapon skill damage +3%','Accuracy+4 Attack+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.herculean_feet_melee 	={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4','DEX+9',}}
	
	-- Valorous Mods
	gear.valorous_head			={ name="Valorous Mask", augments={'Accuracy+17','Weapon skill damage +3%','STR+11',}}
	gear.valorous_hands			={ name="Valorous Mitts", augments={'Weapon skill damage +3%','STR+10','Accuracy+3','Attack+8',}}
	gear.valorous_feet			={ name="Valorous Greaves", augments={'Accuracy+10 Attack+10','Weapon skill damage +3%','STR+9','Accuracy+13',}}
	
	-- Merlinic Mods
	gear.merlinic_feet_th		={ name="Merlinic Crackows", augments={'"Fast Cast"+4','"Mag.Atk.Bns."+9','"Treasure Hunter"+2','Accuracy+1 Attack+1','Mag. Acc.+15 	"Mag.Atk.Bns."+15',}}
	gear.merlinic_legs 			={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+25','Pet: INT+10','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	gear.merlinic_hands_mab 	={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+18','Blood Pact Dmg.+9','Pet: DEX+4','Pet: Mag. Acc.+1',}}
	gear.merlinic_hands_phy 	={ name="Merlinic Dastanas", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','Blood Pact Dmg.+10',}}
	gear.merlinic_head 			={ name="Merlinic Hood", augments={'Potency of "Cure" effect received+6%','Mag. Acc.+15','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}
	
	-- Vanya Mods
	gear.vanya_head_skill		={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_body_skill		={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_hands_skill		={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_legs_skill		={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    gear.vanya_feet_skill		={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	
	-- Ryuo Mods
	gear.ryuo_feet_stp			={ name="Ryuo Sune-Ate", augments={'HP+50','"Store TP"+4','"Subtle Blow"+7',}}
	
	------------------------------------------------------------------------------

	-- Weapons
	gear.espiritus_skill = { name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}}	

	------------------------------------------------------------------------------

	-- Crafting
	sets.crafting_skillup = {}
	sets.crafting_hq = {}

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