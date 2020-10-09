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
    state.Buff.Hasso = buffactive.Hasso or false

    include('Mote-TreasureHunter')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'Acc', 'NODA')
    state.PhysicalDefenseMode:options('Normal', 'PDT', 'MDT')
	state.IdleMode:options('Normal', 'PDT')	
	
	state.Weapon = M{['description']='Current Weapon','Geirrothr','Quint Spear'}
	
	-- JSE Gear	
    
	-- Ambuscade Capes
	gear.brigantia_str 		={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

    update_combat_form()

    -- Additional local binds   
	send_command('bind f9 gs c cycle treasuremode')
	send_command('bind ^g gs c cycle Weapon')

    select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()   
	send_command('unbind f9')
    send_command('unbind ^g')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    sets.TreasureHunter = {
        head="White Rarab Cap +1",
		waist="Chaac Belt",
		feet=gear.valorous_feet_th
    }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Spirit Surge'] = {
		-- body="Pteroslaver Mail +3"
	}
	sets.precast.JA['Call Wyvern'] = {
		-- body="Pteroslaver Mail +3"
	}

    sets.precast.JA['Jump'] = {
		ammo="Ginsen",
		head=gear.flamma_head,
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		ring1="Petrov Ring",
		ring2="Flamma Ring",
		back=gear.brigantia_str,
		waist="Ioskeha Belt",
		legs=gear.sulevia_legs,
		feet=gear.flamma_feet,
    }

    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'],{
		-- legs="Pteroslaver Brais +1"
	})
    sets.precast.JA['Super Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'],{
		-- feet="Peltast's Schynbalds +1"
	})
    sets.precast.JA['Soul Jump'] = sets.precast.JA['Jump']

    sets.precast.JA['Angon'] = {
		-- hands="Pteroslaver Finger Gauntlets +1"
	}
    sets.precast.JA['Spirit Link'] = {
		-- head="Vishap Armet +2",
		-- hands="Peltast's Vambraces +1"
	}

    sets.precast.JA['Ancient Circle'] = {
		-- legs="Vishap Brais +2"
	}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.flamma_head,
		neck="Fotia Gorget",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back=gear.brigantia_str,
		waist="Fotia Belt",
		legs=gear.sulevia_legs,
		feet=gear.flamma_feet,
	}

    sets.precast.WS.NODA = {
		ammo="Ginsen",
		head="Hjarrandi Helm",
		neck="Loricate Torque",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
		back=gear.brigantia_str,
		waist="Flume Belt",
		legs=gear.sulevia_legs,
		feet=gear.sulevia_feet,
	}
    
	sets.precast.WS.Acc = sets.precast.WS
	

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    --  73-85% STR / 4hit
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		-- ammo="Knobkierrie",
		-- head="Flamma Zucchetto +2",
		-- neck="Fotia Gorget",
		-- ear1="Sherida Earring",
		-- ear2="Moonshade Earring",
		-- body="Dagon Breastplate",
		-- hands="Sulevia's Gauntlets +2",
		-- ring1="Regal Ring",
		-- ring2="Niqmaddu Ring",
		-- back=gear.brigantias_da,
		-- waist="Fotia Belt",
		-- legs="Sulevia's Cuisses +2",
		-- feet="Flamma Gambieras +2"
    })
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})

    -- 50% STR / Crit / 0.875 attk penalty / 4hit
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		-- ammo="Knobkierrie",
		-- head="Flamma Zucchetto +2",
		-- neck="Fotia Gorget",
		-- ear1="Thrud Earring",
		-- ear2="Moonshade Earring",
		-- body="Hjarrandi Breastplate",
		-- hands="Flamma Manopolas +2",
		-- ring1="Regal Ring",
		-- ring2="Niqmaddu Ring",
		-- back=gear.brigantias_da,
		-- waist="Sailfi Belt +1",
		-- legs="Peltast's Cuissots +1",
		-- feet="Flamma Gambieras +2"
    })
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 60% STR / 60% VIT / 3.0 fTP  -- Gear for WSD
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
		-- ammo="Knobkierrie",
		-- head=gear.valorous_head_wsd,
		-- neck="Fotia Gorget",
		-- ear1="Thrud Earring",
		-- ear2="Ishvara Earring",
		-- body="Dagon Breastplate"
		-- ,hands=gear.valorous_hands_wsd,
		-- ring1="Karieyh Ring +1",
		-- ring2="Niqmaddu Ring",
		-- back=gear.brigantias_wsd,
		-- waist="Fotia Belt",
		-- legs="Vishap Brais +2",
		-- feet="Sulevia's Leggings +2"
    })
    sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 100% STR /  1.0/3.0/5.5 fTP  -- Assuming Shining One
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		-- ammo="Knobkierrie",
		-- head=gear.valorous_head_wsd,
		-- neck="Fotia Gorget",
		-- ear1="Brutal Earring",
		-- ear2="Moonshade Earring",
		-- body="Hjarrandi Breastplate",
		-- hands="Flamma Manopolas +2",
		-- ring1="Regal Ring",
		-- ring2="Niqmaddu Ring",
		-- back=gear.brigantias_da,
		-- waist="Sailfi Belt +1",
		-- legs="Peltast's Cuissots +1",
		-- feet="Sulevia's Leggings +2"
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 40% STR / 40% DEX / 3.0/3.7/4.5
    sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS, {
		-- ammo="Knobkierrie",
		-- head=gear.valorous_head_wsd,
		-- neck="Fotia Gorget",
		-- ear1="Thrud Earring",
		-- ear2="Ishvara Earring",
		-- body="Dagon Breastplate",
		-- hands=gear.valorous_hands_wsd,
		-- ring1="Regal Ring",
		-- ring2="Niqmaddu Ring",
		-- back=gear.brigantias_wsd,
		-- waist="Fotia Belt",
		-- legs="Vishap Brais +2",
		-- feet="Sulevia's Leggings +2"
    })
    sets.precast.WS["Sonic Thrust"].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})


        -- Midcast Sets
    sets.midcast.FastRecast = {
    }

    
    -- Sets to return to when not performing an action.    

    -- Idle sets
    sets.idle = {
		ammo="Ginsen",
		head="Hjarrandi Helm",
		neck="Loricate Torque",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
		back=gear.brigantia_str,
		waist="Flume Belt",
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
	sets.engaged = {
		ammo="Ginsen",
		head=gear.flamma_head,
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body="Hjarrandi Breastplate",
		hands=gear.sulevia_hands,
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back=gear.brigantia_str,
		waist="Ioskeha Belt",
		legs=gear.sulevia_legs,
		feet=gear.flamma_feet,
	}
		
    sets.engaged.Acc = set_combine(sets.engaged, {
	})
	
    sets.engaged.Hybrid = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		neck="Loricate Torque",
		ring1="Gelatinous Ring +1",
	})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- if spell.type == 'WeaponSkill' then
    --     -- Replace Moonshade Earring if we're at cap TP
    --     if player.tp == 3000 then
    --         equip(sets.precast.MaxTP)
    --     end
    -- end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    -- if state.HybridMode.value == 'Reraise' or
    --     (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
    --     equip(sets.Reraise)
    -- end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Weapon.current == 'Quint Spear' then
        equip({main="Quint Spear"})
	elseif state.Weapon.current == 'Geirrothr' then
		equip({main="Geirrothr"})
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Current Weapon' then
        if state.Weapon.current == 'Quint Spear' then
            equip({main="Quint Spear"})
		elseif state.Weapon.current == 'Geirrothr' then
            equip({main="Geirrothr"})
		end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Weapon.current == 'Quint Spear' then
        equip({ranged="Quint Spear"})
	elseif state.Weapon.current == 'Geirrothr' then
		equip({main="Geirrothr"})
    end
    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- if areas.Adoulin:contains(world.area) and buffactive.ionis then
    --     state.CombatForm:set('Adoulin')
    -- else
    --     state.CombatForm:reset()
    -- end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
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