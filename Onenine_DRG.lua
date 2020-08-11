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

    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
    state.Buff['Reive Mark'] = buffactive['Reive Mark'] or false

    --update_offense_mode()    
    -- determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Normal', 'PDT', 'MDT')
    state.IdleMode:options('Normal', 'PDT')
	
	-- JSE Gear	
    
	-- Ambuscade Capes
	gear.brigantia_str 		={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

    -- Additional local binds   
	send_command('bind f9 gs c cycle treasuremode')

    select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()    
	send_command('unbind f9')
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
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    -- sets.precast.JA['Warding Circle'] = {head=Artifact_Wakido.head}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.flamma_head,
		neck="Anu Torque",
		left_ear="Sherida Earring",
		right_ear="Odnowa Earring",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back=gear.brigantia_str,
		waist="Grunfeld Rope",
		legs=gear.sulevia_legs,
		feet=gear.sulevia_feet,
		}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
    sets.idle = {
		ammo="Ginsen",
		head="Hjarrandi Helm",
		neck="Loricate Torque",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		ring1="Gelatinous Ring +1",
		right_ring="Shneddick Ring",
		back=gear.brigantia_str,
		waist="Sailfi Belt +1",
		legs=gear.sulevia_legs,
		feet=gear.sulevia_feet,
		}
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {
		})

    sets.defense.MDT = set_combine(sets.idle, {
		})

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		ammo="Ginsen",
		head=gear.flamma_head,
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back=gear.brigantia_str,
		waist="Sailfi Belt +1",
		legs=gear.sulevia_legs,
		feet=gear.flamma_feet,
		}
		
    sets.engaged.Acc = set_combine(sets.engaged, {
		})
	
    sets.engaged.Mod = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		neck="Loricate Torque",
		ring1="Gelatinous Ring +1",
		})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    --update_offense_mode()
    -- determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_offense_mode()
    
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end


function set_lockstyle()
    send_command('wait 4; input /lockstyleset 3')
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------