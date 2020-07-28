-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Mote-Utility.lua')
    include('Mote-TreasureHunter')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	-- Auto ws mode
	state.autoWS = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Melee', 'Acc', 'Mod')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.PhysicalDefenseMode:options('Normal', 'MDT')
    state.IdleMode:options('Normal', 'Regen')
    
	-- gear.RAbullet = "Eminent Bullet"    
    -- gear.WSbullet = "Eminent Bullet"
	gear.RAbullet = "Chrono Bullet"    
    gear.WSbullet = "Chrono Bullet"
    gear.QDbullet = "Animikii Bullet"
    gear.MAbullet = "Orichalcum Bullet"
	
    options.ammo_warning_limit = 15

    state.WeaponLock = M(false, 'Weapon Lock')
    state.Gun = M{['description']='Current Gun', 'Anarchy +2','Fomalhaut'}
    state.QuickDraw = M{['description']='STP','ElementalBonus'}
	
	-- JSE Gear	
	Artifact_Laksamana = {}
		Artifact_Laksamana.head 	="Laksamana's Tricorne +2"
		Artifact_Laksamana.body 	="Laksamana's Frac +3"
		Artifact_Laksamana.feet 	="Laksamana's Boots +2"

    Relic_Lanun = {}
		Relic_Lanun.head 	="Lanun Tricorne"
		Relic_Lanun.body 	="Lanun Frac +3"
		Relic_Lanun.hands 	="Lanun Gants"
		Relic_Lanun.legs 	="Lanun Trews"
		Relic_Lanun.feet 	="Lanun Bottes +2"

    Empy_Chasseur = {}
		Empy_Chasseur.head 		="Chasseur's Tricorne +1"
		Empy_Chasseur.body 		="Chasseur's Frac +1"
		Empy_Chasseur.hands 	="Chasseur's Gants +1"
		Empy_Chasseur.legs 		="Chasseur's Culottes"
		Empy_Chasseur.feet 		="Chasseur's Bottes +1"

    -- JSE Capes
	gear.camulus_wsd     = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    gear.camulus_tp      = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.camulus_snap    = { name="Camulus's Mantle", augments={'Snapshot +10%',}}
    gear.camulus_savageb = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}	
	
    -- Additional local binds
    send_command('bind !z input /ja "Bolter\'s Roll" <me>')
    send_command('bind ^z input /ja "Double-up" <me>')
    send_command('bind ^g gs c cycle Gun')
    send_command('bind ^w gs c toggle WeaponLock')
	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^k gs c cycle autoWS')
	send_command('bind ^f9 gs c cycle treasuremode')

    select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !z')
    send_command('unbind ^z')
    send_command('unbind ^g')
    send_command('unbind ^w ')
	send_command('unbind f9')
	send_command('unbind ^f9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	 sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt", 
    }

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body=Empy_Chasseur.body}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
    sets.precast.JA['Snake Eye'] = {legs=Relic_Lanun.legs}
    sets.precast.JA['Random Deal'] = {body=Relic_Lanun.body}

    -- PR set
    sets.precast.CorsairRoll = {
        range="Compensator",
        head=Relic_Lanun.head,
        neck="Regal Necklace",
        ear1="Etiolation Earring",
        ear1="Odnowa Earring +1",
        body=gear.meghanada_body,
        hands=Empy_Chasseur.hands,
        ring1="Barataria Ring",
        ring2="Defending Ring",
        back=gear.camulus_tp,
		waist="Flume Belt",
        legs="Desultor Tassets",
        feet="Malignance Boots",
    }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=Empy_Chasseur.legs})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=Empy_Chasseur.head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=Empy_Chasseur.body})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=Empy_Chasseur.feet})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=Empy_Chasseur.hands})
    
    --sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands=Relic_Lanun.hands}
    
    --sets.precast.CorsairShot = {head="Blood Mask"}    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body=gear.meghanada_body,
		hands=gear.meghanada_hands,
        feet=gear.meghanada_feet
		}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head=gear.herc_head_mabwsd,
		neck="Orunmila's Torque",	-- 5
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Kishar Ring",
		feet="Carmine Greaves",		-- 7
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC)

    -- Snapshot: 70% Cap (all sources)
    --      48/70   Snapshot
    --      29/??   Rapid Shot     

    --      5/5%  100JP
    --      5/5%  1200JP 

    --      (Flurry2 = 30%)
    --      (Flurry  ~ 15%)
    sets.precast.RA = {
        ammo=gear.RAbullet,
        head="Taeon Chapeau",
        body=Artifact_Laksamana.body,
        hands="Carmine Finger Gauntlets +1",
        back=gear.camulus_snap,
        waist="Impulse Belt",
        feet=gear.meghanada_feet,
        legs=gear.adhemar_legs_preshot,
    }

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body=Artifact_Laksamana.body,             -- 18% Rapid Shot
        }) 

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        head=Empy_Chasseur.head,          -- 14% Rapid Shot
        body=Artifact_Laksamana.body,     -- 18% Rapid Shot
        -- waist="Yemaya Belt"            -- 5%  Rapid Shot 
        })
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=gear.meghanada_head,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body=Artifact_Laksamana.body,
		hands=gear.meghanada_hands,
		ring1="Apate Ring",
		ring2="Dingir Ring",
        back=gear.camulus_wsd,
		waist="Fotia Belt",		
		legs=gear.herculean_legs_wsd,
		feet=Relic_Lanun.feet
		}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- 70% AGI proc
    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, {
		ammo=gear.WSbullet,
		})
	
    -- 73~85% AGI
    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		ammo=gear.WSbullet,
		})

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS, {
		ammo=gear.WSbullet,
		ear1="Enervating Earring",
		ring1="Longshot Ring",
		feet=gear.meghanada_feet
		})

    -- 60% AGI // Magical
    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {
		ammo=gear.MAbullet,
		head=gear.herc_head_mabwsd,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
        body=Relic_Lanun.body,
		hands="Carmine Finger Gauntlets +1",
		ring1="Acumen Ring",
		ring2="Dingir Ring",
        back="Gunslinger's Cape",
		waist="Eschan Stone",
		legs=gear.herculean_legs_mab,
		})
    
	-- 100% AGI
    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
        ring1="Archon Ring",
		})
	
	-- 50% STR / 50% MND (TP bonus past 2000)
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Lilitu Headpiece",
		neck="Caro Necklace",
		ring1="Apate Ring",
		ring2="Rajas Ring",
        back=gear.camulus_savageb,
		waist="Sailfi Belt +1",
		legs=gear.herculean_legs_wsd,
		})
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		head="Malignance Chapeau",
		feet="Malignance Boots"
		})

	-- 50% DEX (Crit)
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head=gear.adhemar_head_melee,
		ear1="Cessance Earring",
        -- body="Abnoba Kaftan",
		ring1="Apate Ring",
		ring2="Rajas Ring",		
        back=gear.camulus_savageb,
		legs="Samnuha Tights",
		-- feet=gear.herc_feet_cchance
		})
	
	-- 73~85% AGI
    sets.precast.WS['Exenterator'] = {}
	
	-- 73~85% MND
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {       
        head=gear.adhemar_head_melee,
		ear1="Telos Earring",
        body=gear.meghanada_body,
		hands=gear.meghanada_hands,
		ring2="Epona's Ring",
        back=gear.camulus_wsd,
		legs=gear.meghanada_legs,
		feet=gear.meghanada_feet
		})

    
    ----------------------------------
    -- Midcast Sets
	----------------------------------
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		head=gear.adhemar_head_melee,
        body=gear.adhemar_body_melee,
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Carmine Greaves",		-- 7
		})
        
    -- Specific spells
    sets.midcast.CorsairShot = {
		ammo=gear.QDbullet,
		head=gear.herc_head_mabwsd,
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Enervating Earring",
        body=Relic_Lanun.body,
		hands="Malignance Gloves",
		ring1="Petrov Ring",
		ring2="Dingir Ring",
        back="Gunslinger's Cape",
		waist="Eschan Stone",
		legs=Empy_Chasseur.legs,
		feet=Relic_Lanun.feet
		}

    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot, { 
		ammo=gear.QDbullet,
		head=Artifact_Laksamana.head,
		ear1="Gwati Earring",
		ear2="Navarch's Earring",
		body=gear.mummu_body,
		ring1="Mummu Ring",
		ring2="Sangoma Ring",
		legs="Malignance Tights",
		feet=Artifact_Laksamana.feet
		})

    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {
		ring2="Archon Ring",
	})

    -- Ranged gear
    sets.midcast.RA = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		neck="Marked Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
        body=gear.mummu_body,
		hands="Malignance Gloves",
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
        back=gear.camulus_wsd,
		waist="Eschan Stone",
		legs="Malignance Tights",
        feet="Malignance Boots",
		}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		ammo=gear.RAbullet,
		body="Laksamana Frac +3",
		ring1="Meghanada Ring",
		ring2="Longshot Ring",
		})

    sets.TripleShot = set_combine(sets.midcast.RA, {
        head="Oshosi Mask",         --4
        body=Empy_Chasseur.body,  --12
        hands="Oshosi Gloves",		--3
        legs="Oshosi Trousers",		--5
        feet="Oshosi Leggings",		--2
    })
	
	sets.TripleShot.Acc = set_combine(sets.midcast.RA.Acc, sets.TripleShot)
		
    
    -- Sets to return to when not performing an action.    

    ----------------------------------
    -- Idle Sets
	----------------------------------	
    sets.idle = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body=gear.meghanada_body,
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
        feet="Malignance Boots",
		}
		
	sets.idle.Regen = set_combine(sets.idle, {
		head=gear.meghanada_head,
		body=gear.meghanada_body,
		hands=gear.meghanada_hands,
		feet=gear.meghanada_feet,
		neck="Sanctity Necklace",
		})		
	
    sets.resting = set_combine(sets.idle, {
		neck="Sanctity Necklace",
		ring1="Sheltered Ring",
		})
    
    -- Defense sets
    sets.defense.PDT = {		
		}

    sets.defense.MDT = {
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body=gear.meghanada_body,
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
        feet="Malignance Boots",
		}    

    sets.Kiting = {legs="Carmine Cuisses +1",}

    ----------------------------------
    -- Engaged Sets
	----------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    --   sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.DefenseMode][classes.CustomMeleeGroups (any number)]


    -- Normal melee group
    sets.engaged.Melee = {
		ammo=gear.RAbullet,
        head=gear.adhemar_head_melee,
		neck="Lissome Necklace",
		ear1="Telos Earring",
		ear2="Suppanomimi",
        body=gear.adhemar_body_melee,
		hands=gear.adhemar_hands_melee,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
        back=gear.camulus_tp,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.herculean_feet_melee
		}
    
    sets.engaged.Acc = set_combine(sets.engaged.Melee, {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Telos Earring",
        body=gear.adhemar_body_melee,
		hands="Malignance Gloves",
		ring1="Meghanada Ring",
		ring2="Mummu Ring",
        back=gear.camulus_tp,
		waist="Eschan Stone",
		legs="Malignance Tights",
        feet="Malignance Boots",
		})

    sets.engaged.Acc.DW = set_combine(sets.engaged.Acc, {
		})

    -- Engaged but only for WS
    sets.engaged.Mod = set_combine(sets.engaged.Melee, {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Cessance Earring",
		ear2="Telos Earring",
        body=gear.adhemar_body_melee,
		hands="Malignance Gloves",
		ring1="Epona's Ring",
		ring2="Defending Ring",
        back=gear.camulus_tp,
		waist="Windbuffet Belt +1",
		legs="Malignance Tights",
        feet="Malignance Boots",
		})
    
    sets.engaged.DW = set_combine(sets.engaged.Melee, {
		})

    sets.engaged.DW.Melee = set_combine(sets.engaged.Melee, {
		})

    -- 11% DW
    sets.engaged.DW.Melee.MaxHaste = set_combine(sets.engaged.Melee, {
		})
    
    -- 20% DW
    sets.engaged.DW.Melee.HighHaste = set_combine(sets.engaged.Melee, {
		})
    
    -- 31% DW
    sets.engaged.DW.Melee.MidHaste = set_combine(sets.engaged.Melee, {
		})

    -- 42% DW
    sets.engaged.DW.Melee.LowHaste = set_combine(sets.engaged.Melee, {
		})
		
	---------------  AUTOWS ----------------
	windower.register_event('tp change', function(tp)
		if state.autoWS.value == true and tp >= 1000 then
			windower.send_command('input /ws "Savage Blade" <t>')
		end
	end)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    end

    if spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    -- Equip obi if weather/day matches for WS.
    elseif spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' and (world.weather_element == 'Dark' or world.day_element == 'Dark') then
            equip({waist="Hachirin-no-Obi"})
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip({waist="Hachirin-no-Obi"})
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
        equip(sets.TripleShot)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if state.Gun.current == 'Fomalhaut' then
        equip({range="Fomalhaut"})
    elseif state.Gun.current == 'Doomsday' then
        equip({range="Doomsday"})
    elseif state.Gun.current == 'Holliday' then
        equip({range="Holliday"})
    elseif state.Gun.current == 'Anarchy +2' then
        equip({range="Anarchy +2"})
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Current Gun' then
        if state.Gun.current == 'Fomalhaut' then
            equip({range="Fomalhaut"})
        elseif state.Gun.current == 'Doomsday' then
            equip({range="Doomsday"})
        elseif state.Gun.current == 'Holliday' then
            equip({range="Holliday"})
        elseif state.Gun.current == 'Anarchy +2' then
            equip({range="Anarchy +2"})
        end
    end

    if stateField == 'Weapon Lock' then
        if newValue == true then
            disable('range')
        else
            enable('main','sub','range')
        end
    end
    if stateField == 'Offense Mode' then
        if newValue == 'Melee' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                state.CombatForm:set('DW')
            end
            disable('main','sub','range')
        elseif newValue == 'Ranged' then
            if state.WeaponLock.value ~= true then
                enable('main','sub','range')
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Gun.current == 'Doomsday' then
        equip({ranged="Doomsday"})
    elseif state.Gun.current == 'Holliday' then
        equip({range="Holliday"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Anarchy +2' then
        equip({ranged="Anarchy +2"})
    end
    return idleSet
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
            msg = msg .. ' ' .. v .. ''
        end
    end

    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    --msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   	= {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       	= {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    	= {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       	= {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     	= {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    	= {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      	= {lucky=3, unlucky=7, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      	= {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      	= {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       	= {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     	= {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    	= {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]   		= {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]  	= {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]  	= {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]    	= {lucky=4, unlucky=8, bonus="Pet Accuracy"},
        ["Gallant's Roll"]  	= {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]   	= {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    	= {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   	= {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    	= {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    	= {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   	= {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   	= {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"]	= {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]   		= {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     	= {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] 	= {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   	= {lucky=4, unlucky=8, bonus="Counter Rate"},
        ["Naturalist's Roll"]   = {lucky=3, unlucky=7, bonus="Enhancing Magic"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        --add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        --add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
        add_to_chat(104, ' Lucky: [ '..tostring(rollinfo.lucky)..' ]  Unlucky: [ '..tostring(rollinfo.unlucky)..' ]  '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')

    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            if gear.RAbullet ~= gear.WSbullet then
                add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
                return
            end
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 11)
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 9')
end