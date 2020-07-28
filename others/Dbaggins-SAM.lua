-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()


    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
    state.Buff['Reive Mark'] = buffactive['Reive Mark'] or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Mid', 'High')
    state.HybridMode:options('Normal', 'Meva', 'PDT')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.IdleMode:options('Normal', 'Regen')

        
	-- Ambuscade Capes
    gear.smertrios_wsd 	={name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} 
    gear.smertrios_tp   ={name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Accuracy+10','Phys. dmg. taken-10%',}}
	gear.smertrios_meva   ={name="Smertrios's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Accuracy+10','"Store TP"+10','Mag. Evasion+15',}} 

    -- Additional local binds
    

    select_default_macro_book(1, 1)
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back=gear.smertrios_tp}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
    sets.precast.JA['Meikyo Shisui'] = {feet="Sak. Sune-ate +3"}
    

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		sub="Utu Grip",
		ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','STR+15','Accuracy+15','Attack+4',}},
		neck="Sam. Nodowa +2",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
        body="Sakonji Domaru +3",
		hands={ name="Valorous Mitts", augments={'Attack+18','Weapon skill damage +4%','STR+13','Accuracy+11',}},
		ring1="Epaminondas's Ring",
		ring2="Regal Ring",
        back=gear.smertrios_wsd,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Accuracy+19','Weapon skill damage +4%','STR+14','Attack+8',}}
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Ageha'] = {
		sub="Utu Grip",
		ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
		neck="Sam. Nodowa +2",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
        body="Flamma Korazin +2",
		hands="Flamma Manopolas +2",
		ring1="Epaminondas's Ring",
		ring2="Regal Ring",
        back=gear.smertrios_wsd,
		waist="Fotia Belt",
		legs="Flamma Dirs +2",
		feet="Flamma Gambieras +2"
		}

    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Sam. Nodowa +2",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back="Moonlight Cape",waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Danzo Sune-Ate"}
    
    sets.idle.Field = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Wakido Kabuto +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Tartarus Platemail",hands="Sakonji Kote +3",ring1="Warden's Ring",ring2="Defending Ring",
        back=gear.smertrios_wsd,waist="Flume Belt +1",legs="Kendatsuba Hakama +1",feet="Danzo Sune-Ate"}

    sets.idle.Weak = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Wakido Kabuto +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Tartarus Platemail",hands="Sakonji Kote +3",ring1="Warden's Ring",ring2="Defending Ring",
        back=gear.smertrios_wsd,waist="Flume Belt +1",legs="Kendatsuba Hakama +1",feet="Ken. Sune-Ate +1"}

    sets.idle.Regen = {head="Rao Kabuto +1",body="Hiza. Haramaki +2",hands="Rao Kote +1",legs="Rao Haidate +1",feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",waist="Flume Belt +1",left_ear="Etiolation Earring",right_ear="Infused Earring",
        left_ring="Paguroidea Ring",right_ring="Chirich Ring +1",back="Moonlight Cape",}
    
    sets.idle.Field.Regen = {head="Rao Kabuto +1",body="Hiza. Haramaki +2",hands="Rao Kote +1",legs="Rao Haidate +1",feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",waist="Flume Belt +1",left_ear="Etiolation Earring",right_ear="Infused Earring",
        left_ring="Paguroidea Ring",right_ring="Chirich Ring +1",back="Moonlight Cape",}
    
    sets.idle.Town.Regen = {head="Rao Kabuto +1",body="Hiza. Haramaki +2",hands="Rao Kote +1",legs="Rao Haidate +1",feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",waist="Flume Belt +1",left_ear="Etiolation Earring",right_ear="Infused Earring",
        left_ring="Paguroidea Ring",right_ring="Chirich Ring +1",back="Moonlight Cape",}

        
    -- Defense sets
    sets.defense.PDT = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Tartarus Platemail",
		hands="Sakonji Kote +3",
		ring1="Warden's Ring",
		ring2="Defending Ring",
        back="Moonlight Cape",
		waist="Flume Belt +1",
		legs="Kendatsuba Hakama +1",
		feet="Ken. Sune-Ate +1"
		}

    sets.defense.Reraise = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Twilight Mail",hands="Sakonji Kote +3",ring1="Warden's Ring",ring2="Defending Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Kendatsuba Hakama +1",feet="Ken. Sune-Ate +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
   
    sets.engaged = {
		sub="Utu Grip",
		ammo="Ginsen",
        head="Flamma Zucchetto +2",
		neck="Sam. Nodowa +2",
		ear1="Dedition Earring",
		ear2="Telos Earring",
        body="Kasuga Domaru +1",
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Chirich Ring +1",
        back="Takaha Mantle",
		waist="Ioskeha Belt +1",
		legs="Ryuo Hakama +1",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
		}
    sets.engaged.Mid = {sub="Utu Grip",ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Brutal Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}}
    sets.engaged.High = {sub="Utu Grip",ammo="Ginsen",
        head="Flam. Zucchetto +2",neck="Sam. Nodowa +2",ear1="Cessance Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Wakido Sune. +3",}
    sets.engaged.Meva = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_meva,waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.Mid.Meva = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_meva,waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.High.Meva = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_meva,waist="Ioskeha Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.PDT = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",legs="Ryuo Hakama +1",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",feet="Wakido Sune. +3",}
    sets.engaged.Mid.PDT = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",legs="Ryuo Hakama +1",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",feet="Wakido Sune. +3",}
    sets.engaged.High.PDT = {sub="Utu Grip",ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Sam. Nodowa +2",ear1="Dedition Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",legs="Ryuo Hakama +1",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",feet="Wakido Sune. +3",}

    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kas. Sune-ate +1"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +3"}
    sets.buff.Reive = {neck= "Ygnas's Resolve +1"}
    sets.MaxTP = {ear1="Ishvara Earring"}
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
        if player.tp > 2750 then
            equip(sets.MaxTP)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    --update_offense_mode()
    determine_haste_group()
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
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------