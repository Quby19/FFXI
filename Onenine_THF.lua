-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Mote-Utility.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('Normal', 'PDT', 'MDT')
    state.IdleMode:options('Normal', 'Slow')

	-- gear.MovementFeet = {name="Skadi's Jambeaux"}
	-- gear.SlowFeet = "Mummu Gamashes +1 +1"
    -- gear.FastFeet = "Skadi's Jambeaux"
    
    --select_movement_feet()

    gear.default.weaponskill_neck = "Sanctity Necklace"

    -- Additional local binds
    send_command('bind f5 gs c cycle IdleMode')
	send_command('bind f6 gs c cycle OffenseMode')
	send_command('bind f7 gs c cycle WeaponskillMode')
	send_command('bind f8 gs c cycle DefenseMode')
	send_command('bind f9 gs c cycle treasuremode')	

    select_default_macro_book()	
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind f5')
	send_command('unbind f6')
	send_command('unbind f7')
	send_command('unbind f8')
	send_command('unbind f9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Assassin's Armlets +2", feet="Skulker's Poulaines +1"}
    -- sets.ExtraRegen = {neck="Orochi Nodowa"}
    -- sets.Kiting = {feet="Skadi's Jambeaux"}

    sets.buff['Sneak Attack'] = {
		-- ear2="Melnina's Earring",
		back="Toutatis's Cape",
		}

    sets.buff['Trick Attack'] = {
		-- ear2="Melnina's Earring",
		waist="Sinew Belt",
		}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    -- sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    -- sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Rogue's Poulaines"}
    -- sets.precast.JA['Conspirator'] = {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {feet="Rogue's Poulaines"}
    sets.precast.JA['Despoil'] = {feet="Raider's Poulaines +2"}
    -- sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    -- sets.precast.JA['Feint'] = {} {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Wayfarer Robe",
		}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
		-- ear1="Etiolation Earring",
		ear2="Loquacious Earring",
		legs="Limbo Trousers",
		-- hands="Leyline Gloves",
		}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    -- Ranged snapshot gear
    --sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Meghanada Visor +1",
		neck='Sanctity Necklace',
		ear1="Odnowa Earring +1",
		ear2="Suppanomimi",
        body="Meghanada Cuirie +1",
		hands="Meghanada Gloves +1",
		ring1="Apate Ring",
		ring2="Rajas Ring",
        back="Atheling Mantle",
		waist="Crudleis Belt",
		legs="Meghanada Chausses +1",
		feet="Meghanada Jambeaux +1"
		}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {waist="Soil Belt"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Mummu Bonnet +1",
        body="Mummu Jacket +1",
		hands="Mummu Wrists",
		-- waist="Twilight Belt",
		legs="Mummu Kecks +2",
		feet="Mummu Gamashes +1"
		}

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
		-- neck="Orochi Nodowa",
		}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		head="Malignance Chapeau",
		neck='Loricate Torque',
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
        body="Meghanada Cuirie +1",
		hands="Malignance Gloves",
		ring1="Fortified Ring",
		ring2="Shneddick Ring",
        back="Solemnity Cape",
		waist="Eschan Stone",
		legs="Malignance Tights",
        feet="Malignance Boots",
		}
	
	sets.idle.Slow = set_combine(sets.idle, {
		-- feet="Meghanada Jambeaux +2"
		})

    -- sets.idle.Town = {
		-- head="Raider's Bonnet +2",
		-- neck="Love Torque",
		-- ear1="Brutal Earring",
		-- ear2="Suppanomimi",
        -- body="Raider's Vest +2",
		-- hands="Assassin's Armlets",
		-- left_ring="Rajas Ring",
		-- right_ring="Epona's Ring",
        -- back="Atheling Mantle",
		-- waist="Twilight Belt",
		-- legs="Raider's Culottes +2",
		-- feet="Skadi's Jambeaux",
		-- }
		
	-- sets.idle.Town.Slow = set_combine(sets.idle.Town, {
		-- feet="Mummu Gamashes +1 +1"
		-- })

    sets.idle.Weak = set_combine(sets.idle, {})


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {
        -- neck="Twilight Torque",
		}

    sets.defense.MDT = {
		-- neck="Twilight Torque",
		-- back="Resentment Cape",
		}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		head="Malignance Chapeau",
		neck='Anu Torque',
		ear1="Sherida Earring",
		ear2="Suppanomimi",
        body="Mummu Jacket +1",
		hands="Malignance Gloves",
		ring1="Apate Ring",
		ring2="Rajas Ring",
        back="Atheling Mantle",
		waist="Grunfeld Rope",
		legs="Samnuha Tights",
        feet="Malignance Boots",
		}
		
    sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.engaged.PDT)

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
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
        set_macro_page(1, 4)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end

-- function select_movement_feet()
	-- if state.IdleMode.value == 'Slow' then
		-- gear.MovementFeet.name = gear.SlowFeet
	-- end
-- end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 7')
end