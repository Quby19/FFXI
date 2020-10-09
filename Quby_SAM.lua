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
	state.OffenseMode:options('Normal', 'Acc', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'Acc', 'NODA')
    state.PhysicalDefenseMode:options('Normal', 'MDT')
    state.IdleMode:options('Normal', 'PDT')
	
	state.Katana = M{['description']='Current Katana','Masamune','Dojikiri Yasutsuna','Soboro Sukehiro'}
	
	-- JSE Gear	
	Artifact_Wakido = {}
		Artifact_Wakido.head 	="Wakido Kabuto +1"
		Artifact_Wakido.body 	="Wakido Domaru +1"
		Artifact_Wakido.hands 	="Wakido Kote +3"
		Artifact_Wakido.legs 	="Wakido Haidate +3"

    Relic_Sakonji = {}
		Relic_Sakonji.body 		="Sakonji Domaru +3"
		Relic_Sakonji.hands 	="Sakonji Kote +3"
		Relic_Sakonji.feet 		="Sakonji Sune-Ate +1"

    Empy_Kasuga = {}
		Empy_Kasuga.body 		="Kasuga Domaru +1"
		Empy_Kasuga.hands 		="Kasuga Kote +1"
		Empy_Kasuga.feet 		="Kasuga Sune-Ate +1"
    
	-- Ambuscade Capes
    gear.smertrios_wsd 	={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.smertrios_tp   ={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

    -- Additional local binds
	send_command('bind f9 gs c cycle treasuremode')
	send_command('bind ^g gs c cycle Katana')

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
		legs="Volte Hose",
		feet=gear.valorous_feet_TH
	}
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
		head=Artifact_Wakido.head,
		hands=Relic_Sakonji.hands,
		back=gear.smertrios_wsd
	}
    sets.precast.JA['Warding Circle'] = {head=Artifact_Wakido.head}
    sets.precast.JA['Blade Bash'] = {hands=Relic_Sakonji.hands}
    sets.precast.JA['Meikyo Shisui'] = {hands="Sakonji Sune-ate +1"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
        head=gear.valorous_head,
		neck="Samurai's Nodowa +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
        body=Relic_Sakonji.body,
		hands=gear.valorous_hands,
		ring1="Apate Ring",
		ring2="Niqmaddu Ring",
        back=gear.smertrios_wsd,
		waist="Sailfi Belt +1",
		legs=Artifact_Wakido.legs,
		feet=gear.valorous_feet
	}
		
	sets.precast.WS['Tachi: Ageha'] = {
        ammo="Hydrocera",
		head=gear.flamma_head,
		neck="Sanctity Necklace",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		body=gear.flamma_body,
		hands=gear.flamma_hands,
		left_ring="Metamor. Ring +1",
		right_ring="Sangoma Ring",
        back=gear.smertrios_wsd,
		waist="Eschan Stone",
		legs="Volte Hose",
		feet=gear.flamma_feet,
	}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		head=gear.flamma_head,
		hands=gear.flamma_hands,
		feet=gear.flamma_feet
	})

	sets.precast.WS.NODA = {
		ammo="Staunch Tathlum +1",
		head="Kendatsuba Jinpachi +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands=Relic_Sakonji.hands,
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Kendatsuba Hakama +1",
		feet="Ken. Sune-Ate +1"
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
    sets.idle = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
        head=gear.valorous_head,
		neck="Sanctity Necklace",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands=Relic_Sakonji.hands,
		ring1="Shneddick Ring",
		ring2="Defending Ring",
        back=gear.smertrios_tp,
		waist="Flume Belt",
		legs="Kendatsuba Hakama +1",
		feet="Ken. Sune-Ate +1"
	}
		
	sets.idle.PDT = set_combine(sets.idle, {
        head="Kendatsuba Jinpachi +1",
		neck="Loricate Torque +1",
		ring1="Gelatinous Ring +1",
		feet="Ken. Sune-Ate +1"
	})

	sets.idle.Town = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		neck="Samurai's Nodowa +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands=Artifact_Wakido.hands,
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
        back=gear.smertrios_tp,
		waist="Ioskeha Belt +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1"
	}
    
    -- Defense sets
    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Kendatsuba Samue +1",
		hands=Relic_Sakonji.hands,
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Kendatsuba Hakama +1",
		feet="Ken. Sune-Ate +1"
	}

    sets.Kiting = {ring1="Shneddick Ring"}

    -- sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		sub="Utu Grip",
		ammo="Ginsen",
        head=gear.flamma_head,
		neck="Samurai's Nodowa +1",
		ear1="Telos Earring",
		ear2="Cessance Earring",
        body=Empy_Kasuga.body,
		hands=Artifact_Wakido.hands,
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
        back=gear.smertrios_tp,
		waist="Ioskeha Belt +1",
		legs="Ken. Hakama +1",
		feet=gear.ryuo_feet_stp
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {
		head="Kendatsuba Jinpachi +1",
		body="Kendatsuba Samue +1",
		feet="Ken. Sune-Ate +1"
	})

    sets.engaged.Hybrid = set_combine(sets.engaged, {
		ammo="Staunch Tathlum +1",
		head="Kendatsuba Jinpachi +1",
		body="Kendatsuba Samue +1",
		ring1="Ilabrat Ring",
		feet="Ken. Sune-Ate +1"
	})

    sets.buff.Sekkanoki = {hands=Empy_Kasuga.hands}
    sets.buff.Sengikori = {feet=Empy_Kasuga.feet}
    sets.buff['Meikyo Shisui'] = {feet=Relic_Sakonji.feet}
    sets.buff.Reive = {neck= "Ygnas's Resolve +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end		
        if state.Buff['Reive Mark'] then
            equip(sets.buff.Reive)
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Katana.current == 'Dojikiri Yasutsuna' then
        equip({main="Dojikiri Yasutsuna"})
    elseif state.Katana.current == 'Soboro Sukehiro' then
        equip({main="Soboro Sukehiro"})
	elseif state.Katana.current == 'Masamune' then
		equip({main="Masamune"})
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Current Katana' then
        if state.Katana.current == 'Dojikiri Yasutsuna' then
            equip({main="Dojikiri Yasutsuna"})
        elseif state.Katana.current == 'Soboro Sukehiro' then
            equip({main="Soboro Sukehiro"})
		elseif state.Katana.current == 'Masamune' then
            equip({main="Masamune"})
		end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Katana.current == 'Dojikiri Yasutsuna' then
        equip({ranged="Dojikiri Yasutsuna"})
    elseif state.Katana.current == 'Soboro Sukehiro' then
        equip({main="Soboro Sukehiro"})
	elseif state.Katana.current == 'Masamune' then
		equip({main="Masamune"})
    end
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
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end

function set_lockstyle()
    send_command('wait 10; input /lockstyleset 8')
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------