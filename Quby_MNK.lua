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
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Hybrid', 'Counter')
    state.WeaponskillMode:options('Normal', 'Acc', 'NODA')
    state.HybridMode:options('Normal', 'Hybrid', 'Counter')
    state.PhysicalDefenseMode:options('DT')
    state.IdleMode:options('Normal', 'DT')

    include('Mote-TreasureHunter')

    update_combat_form()
	update_melee_groups()
	
    -- Additional local binds
	send_command('bind f9 gs c cycle HybridMode')
	send_command('bind ^f9 gs c cycle TreasureMode')
	send_command('bind ^g gs c cycle Weapon')
	
	state.Weapon = M{['description']='Current Weapon','Karambit','Mercurial Pole'}

	-- JSE Gear	
	Artifact_Anchorite = {}
		Artifact_Anchorite.head 	="Anchorite's Crown +2"		-- Focus (keep +1)
		Artifact_Anchorite.body 	="Anchorite's Cyclas +2"	-- Chakra (keep +1)
		Artifact_Anchorite.hands 	="Anchorite's Gloves +2"	-- +3 WSD
		Artifact_Anchorite.legs 	="Anchorite's Hose +2"		-- Counter (can +3)
		Artifact_Anchorite.feet 	="Anchorite's Gaiters +3"

    Relic_Hesychast = {}
		Relic_Hesychast.head 		="Hesychast's Crown +1"  	-- +3 wsd  (2.5m shard/400k)
		Relic_Hesychast.body 		="Hesychast's Cyclas"  		-- keep NQ (super cheap to +3 50k shard)
		Relic_Hesychast.hands 		="Hesychast's Gloves +1" 	-- chakra keep +1 (pretty cheap 500k shard)
		Relic_Hesychast.legs 		="Hesychast's Hose"			-- +3 Melee set? Kick WSs  (6m shard) (dont know if needed)
		Relic_Hesychast.feet 		="Hesychast's Gaiters"		-- +3 for now (counterstance) (very cheap  100k shard)

    Empy_Bhikku = {}
		Empy_Bhikku.body 			="Bhikku Cyclas +1"
		Empy_Bhikku.legs 			="Bhikku Hose"  -- storage

	-- gear.cape1 = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}}
	-- gear.cape2 = { name="Segomo's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}
	-- gear.cape3 = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	-- gear.cape4 = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}

	gear.segomo_tp	={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}}
	gear.segomo_wsd	={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    select_default_macro_book()
	set_lockstyle()
end

function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
    send_command('unbind ^g')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.TreasureHunter = {
		-- head="White Rarab Cap +1",
		hands=gear.herc_hands_TH2,
		legs="Volte Hose",
        waist="Chaac Belt", 
    }
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs=Relic_Hesychast.legs}
    sets.precast.JA['Boost'] = {hands=Artifact_Anchorite.hands}
    sets.precast.JA['Dodge'] = {feet=Artifact_Anchorite.feet}
    sets.precast.JA['Focus'] = {head=Artifact_Anchorite.head}
    sets.precast.JA['Counterstance'] = {feet=Relic_Hesychast.feet}
    -- sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
    sets.precast.JA['Formless Strikes'] = {body=Relic_Hesychast.body}
    sets.precast.JA['Mantra'] = {feet=Relic_Hesychast.feet}

    sets.precast.JA['Chi Blast'] = set_combine(sets.TreasureHunter, {
		head=Relic_Hesychast.head,
	})

	-- VIT MOD
    sets.precast.JA['Chakra'] = {
		-- head="Rao Kabuto +1",
		body=Artifact_Anchorite.body,
		hands=Relic_Hesychast.hands,
		ring1="Niqmaddu Ring",
		-- ring2="Regal Ring",
		Legs=gear.hizamaru_legs,
		feet=Relic_Hesychast.feet,
		-- ear1="Thureous Earring",
		ear2="Odnowa Earring +1"
	}
 
    -- Fast cast sets for spells 
    sets.precast.FC = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Orunmila's Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		body="Kendatsuba Samue +1",
		hands="Leyline Gloves",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back=gear.segomo_tp,
		waist="Moonbow Belt",
		legs="Malignance Tights",
		feet=gear.herculean_feet_melee,
	}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Lilitu Headpiece",
		neck="Monk's Nodowa +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		body="Kendatsuba Samue +1",
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs=gear.hizamaru_legs,
		feet="Kendatsuba Sune-Ate +1",
	}

    sets.precast.MaxTP = {left_ear="Telos Earring"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	
	})	

	sets.precast.WS.NODA = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands="Malignance Gloves",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		waist="Moonbow Belt",
		legs="Malignance Tights",
        feet="Malignance Boots",
		}

    -- Specific weaponskill sets. 

	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head=gear.adhemar_head_melee,
		neck="Fotia Gorget",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		body="Kendatsuba Samue +1",
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1",
	})
	
	sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head=gear.adhemar_head_melee,
		neck="Monk's Nodowa +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		body=gear.adhemar_body_melee,
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1",
	})
	
	sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Kendatsuba Jinpachi +1",
		neck="Fotia Gorget",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		body=gear.adhemar_body_melee,
		hands="Kendatsuba Tekko +1",
		left_ring="Niqmaddu Ring",
		right_ring="Ilabrat Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1",
	})
	
	sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Lilitu Headpiece",  -- relic head +3
		neck="Monk's Nodowa +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		body="Kendatsuba Samue +1",
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs=gear.hizamaru_legs,
		feet="Kendatsuba Sune-Ate +1",
	})

	sets.precast.WS["Tornado Kick"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Lilitu Headpiece",
		neck="Monk's Nodowa +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		body="Kendatsuba Samue +1",
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_wsd,
		waist="Moonbow Belt",
		legs=gear.hizamaru_legs,
		feet="Kendatsuba Sune-Ate +1",
	})

	sets.precast.WS["Dragon Kick"] = sets.precast.WS["Tornado Kick"]
	sets.precast.WS["Ascetic's Fury"] = sets.precast.WS["Victory Smite"]
    sets.precast.WS["Cataclysm"] = set_combine(sets.precast.WS, {})

	-----------------------------------
			-- Midcast --
	-----------------------------------

	sets.midcast.FastRecast = sets.precast.FC
       
    -- Sets to return to when not performing an action.
    
    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Monk's Nodowa +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands="Malignance Gloves",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		waist="Moonbow Belt",
		legs="Malignance Tights",
        feet="Malignance Boots",
	}

    sets.idle.DT = set_combine(sets.idle, {
		neck="Loricate Torque +1",
		left_ring="Gelatinous Ring +1",
	})
    
    -- Defense sets
    sets.defense.DT = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands="Malignance Gloves",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		waist="Moonbow Belt",
		legs="Malignance Tights",
        feet="Malignance Boots",
	}

	sets.idle.Town = {
		ammo="Staunch Tathlum +1",
		head="Kendatsuba Jinpachi +1",
		neck="Monk's Nodowa +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands="Kendatsuba Tekko +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back=gear.segomo_tp,
		waist="Moonbow Belt",
		legs="Kendatsuba Hakama +1",
		feet="Kendatsuba Sune-Ate +1",
	}

    sets.Kiting = {ring1="Shneddick Ring",}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {
		ammo="Ginsen",
		head="Kendatsuba Jinpachi +1",
		neck="Monk's Nodowa +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		body="Kendatsuba Samue +1",
		hands=gear.adhemar_hands_melee,
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=gear.segomo_tp,
		waist="Moonbow Belt",
		legs="Kendatsuba Hakama +1",
		feet=gear.herculean_feet_melee,
	}

    sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		hands="Kendatsuba Tekko +1",
		feet="Kendatsuba Sune-Ate +1",
	})
    
    -- Defensive melee hybrid sets
    sets.engaged.Hybrid = set_combine(sets.engaged.Acc, {
		ammo="Staunch Tathlum +1",
		right_ring="Defending Ring",
	})

    sets.engaged.Counter = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		-- head="Rao Kabuto +1",
		body=Relic_Hesychast.body,
		-- hands="Rao Kote +1",
		legs=Artifact_Anchorite.legs,
		feet=Relic_Hesychast.feet,
	})

    sets.engaged.Acc.Counter = sets.engaged.Counter

    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, { body=Empy_Bhikku.body })
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, { body=Empy_Bhikku.body })
    sets.engaged.Hybrid.HF = set_combine(sets.engaged.Hybrid)
    sets.engaged.Hybrid.HF.Impetus = set_combine(sets.engaged.Hybrid, { body=Empy_Bhikku.body })
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, { body=Empy_Bhikku.body	})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, { body=Empy_Bhikku.body })

    -- Footwork combat form
    sets.engaged.Footwork = set_combine(sets.engaged, { feet=Artifact_Anchorite.feet })
    sets.engaged.Footwork.Impetus = set_combine(sets.engaged.Footwork, {
		body=Empy_Bhikku.body,
		-- legs=Relic_Hesychast.legs
	})
    sets.engaged.Footwork.Acc = set_combine(sets.engaged.Acc, { feet=Artifact_Anchorite.feet })
    sets.engaged.Footwork.Acc.Impetus = set_combine(sets.engaged.Footwork.Acc, {
		body=Empy_Bhikku.body,
		-- legs=Relic_Hesychast.legs
	})

    sets.engaged.Impetus = set_combine(sets.engaged, { body=Empy_Bhikku.body })
    sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, { body=Empy_Bhikku.body })
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = { body=Empy_Bhikku.body }
    sets.footwork_kick_feet = { feet=Artifact_Anchorite.feet }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
                equip(sets.impetus_body)
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Weapon.current == 'Mercurial Pole' then
        equip({main="Mercurial Pole"})
	elseif state.Weapon.current == 'Karambit' then
		equip({main="Karambit"})
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Current Weapon' then
        if state.Weapon.current == 'Mercurial Pole' then
            equip({main="Mercurial Pole"})
		elseif state.Weapon.current == 'Karambit' then
            equip({main="Karambit"})
		end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Weapon.current == 'Mercurial Pole' then
        equip({ranged="Mercurial Pole"})
	elseif state.Weapon.current == 'Karambit' then
		equip({main="Karambit"})
    end
    return idleSet
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['Hundred Fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['Hundred Fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

function job_status_change(stateField, newValue, oldValue)
    update_melee_groups()
    handle_equipping_gear(player.status)
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['Hundred Fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['Hundred Fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 15)
    else
        set_macro_page(1, 15)
    end
end

function set_lockstyle()
    send_command('wait 8; input /lockstyleset 12')
end