-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')	
	include('Mote-Utility.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    include('Mote-TreasureHunter')
	
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
	
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Normal', 'PDT')

    gear.MovementFeet = {name="Danzo Sune-ate"}
	-- gear.SlowFeet = "Outrider Greaves"
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"
    
    select_movement_feet()
    select_default_macro_book()
	set_lockstyle()
	
	send_command('bind f5 gs c cycle IdleMode')
	send_command('bind f6 gs c cycle OffenseMode')
	send_command('bind f7 gs c cycle WeaponskillMode')
	send_command('bind f8 gs c cycle DefenseMode')
	send_command('bind f9 gs c cycle treasuremode')
end

function file_unload()
    send_command('unbind f5')
	send_command('unbind f6')
	send_command('unbind f7')
	send_command('unbind f8')
	send_command('unbind f9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt", 
		legs="Volte Hose"
    }

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    -- sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    -- sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    -- sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    --sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    --sets.precast.Step = {}

    --sets.precast.Flourish = {}

	---------------
    -- Fast cast sets for spells
    ---------------
	
    sets.precast.FC = {
		head="gear.herc_head_mabwsd",
		neck="Orunmila's Torque",	-- 5
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Kishar Ring"
		}
    
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {}
		)

    -- Snapshot for ranged
    -- sets.precast.RA = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head={ name="Herculean Helm", augments={'Weapon skill damage +5%','Accuracy+12',}},
		body="Mummu Jacket +2",
		hands="Malignance Gloves",
		legs="Hiza. Hizayoroi +2",
		feet=gear.herculean_feet_melee,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Atheling Mantle",
		}
		
    -- sets.precast.WS.Acc = set_combine(sets.precast.WS, {}
		-- )

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
		
		})
	
	 sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
		
		})
	
     -- sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
		-- neck="Breeze Gorget",
		-- })

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
	sets.midcast = {
		head="Adhemar Bonnet +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		ring1="Vocane Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Herculean Boots"
		}
	
    -- sets.midcast.FastRecast = {}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast, {
		})

    -- sets.midcast.ElementalNinjutsu = {}

    -- sets.midcast.NinjutsuDebuff = {}

    -- sets.midcast.NinjutsuBuff = {}

    -- sets.midcast.RA = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
		neck="Sanctity Necklace",
		ring1="Sheltered Ring",
		}
    
    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Mummu Jacket +2",
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet=gear.MovementFeet
		}
		
	sets.idle.PDT = set_combine(sets.idle, {
		feet="Malignance Boots"
		})

    -- sets.idle.Town = set_combine(sets.idle, {
        -- head="Iga Zukin +2",
        -- body="Ninja Chainmail",
		-- neck="Iga Erimaki",
		-- feet=gear.MovementFeet
		-- })
    
	-- sets.idle.Town.Slow = set_combine(sets.idle.Town, {
        -- feet="Outrider Greaves"
		-- })
	
    --sets.idle.Weak = {}
    
    -- Defense sets
    --sets.defense.Evasion = {}

    sets.defense.PDT = {
		neck="Loricate Torque +1",
        }

    sets.defense.MDT = {
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Mummu Jacket +2",
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
        feet="Malignance Boots",
		feet=gear.herculean_feet_melee
		}

    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
        head="Adhemar Bonnet +1",
		neck="Moonbeam Nodowa",
		ear1="Telos Earring",
		ear2="Suppanomimi",
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		ring1="Epona's Ring",
		ring2="Petrov Ring",
        back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.herculean_feet_melee
		}
		
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion = set_combine(sets.engaged, {})
	
    sets.engaged.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged, {})
	

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT.HighHaste = set_combine(sets.engaged, {})
	

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT.EmbravaHaste = set_combine(sets.engaged, {})
	

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged, {})
	


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Yonin = {legs="Iga Hakama +2"}
    -- sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
-- function job_post_midcast(spell, action, spellMap, eventArgs)
    -- if state.Buff.Doom then
        -- equip(sets.buff.Doom)
    -- end
-- end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- function job_aftercast(spell, action, spellMap, eventArgs)
    -- if not spell.interrupted and spell.english == "Migawari: Ichi" then
        -- state.Buff.Migawari = true
    -- end
-- end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
		select_movement_feet()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
		select_movement_feet()
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 100 then
        idleSet = set_combine(idleSet, sets.Regen)
	end
    select_movement_feet()

	return idleSet
end


-- Modify the default melee set after it was constructed.
-- function customize_melee_set(meleeSet)
    -- if state.Buff.Migawari then
        -- meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    -- end
    -- if state.Buff.Doom then
        -- meleeSet = set_combine(meleeSet, sets.buff.Doom)
    -- end
    -- return meleeSet
-- end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
	-- if state.IdleMode.value == 'Slow' then
		-- gear.MovementFeet.name = gear.SlowFeet
	-- elseif state.IdleMode.value == 'Normal' then
		if world.time >= 17*60 or world.time < 7*60 then
			gear.MovementFeet.name = gear.NightFeet
		else
			gear.MovementFeet.name = gear.DayFeet
		end
	--end
end

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 7')
end
