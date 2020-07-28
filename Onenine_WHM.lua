-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	sets.Organizer = {
			
    }
	
	--------------------------------------
    -- Precast Sets
	--------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Incantor Stone",
		head="Nahtirah Hat",
		neck="Dualism Collar",
		ear1="Malignance Earring",
		ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		ring1="Kishar Ring",
		ring2="Etana Ring",
		back="Alaunus's Cape",
		waist="Embla sash",
		feet="Gendewitha Galoshes +1",
		}

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		head=gear.vanya_head_skill,
		body=gear.vanya_body_skill,
		ear1="Mendicant's Earring",
		ear2="Nourishing Earring +1",
		hands=gear.vanya_hands_skill,
		legs="Ebers Pantaloons +1",
		feet=gear.vanya_feet_skill,
		})
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		})
	
	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi hat",
		})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    
    -- Precast sets to enhance JAs
    -- sets.precast.JA.Benediction = {
		-- }
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Wayfarer Circlet",
		neck="Chivalrous Chain",
        body="Theophany Briault +1",
		hands="Wayfarer Cuffs",
		legs="Wayfarer Slops",
		feet="Wayfarer Clogs"
		}
    
    sets.precast.WS['Flash Nova'] = sets.precast.WS
    
	------------------------------------
    -- Midcast Sets
	------------------------------------
    
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		hands="Inyanga Dastanas +2",
		})
    
    -- Cure sets
    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Hydrocera",
        head=gear.vanya_head_skill,
		neck="Incanter's Torque",
		ear1="Malignance earring",
		ear2="Glorious Earring",
        body="Ebers Bliaud +1",
		hands=gear.vanya_hands_skill,
		ring1="Sirona's Ring",
		ring2="Etana Ring",
		waist="Embla sash",
		legs="Ebers Pantaloons +1",
		back="Alaunus's Cape",
		feet=gear.vanya_feet_skill,
		})

    sets.midcast.CureSolace = sets.midcast.Cure

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.CureMelee = set_combine(sets.midcast.Cure, {
		})

	-- need healing magic skill and/or cursna+ gear
    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
		feet="Gendewitha Galoshes +1"
		})

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
        head="Orison Cap +2",
		legs="Ebers Pantaloons +1"
		})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
        -- main="Gada",
        -- sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --9%
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --8%
        waist="Embla Sash",                 --10%
        legs=gear.telchine_legs_enh_dur,    --10%
        feet=gear.telchine_feet_enh_dur     --10%
		})
    
	sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration
    sets.midcast["Enhancing Magic"] = set_combine(sets.midcast.EnhancingDuration, {
		ear2="Andoaa Earring",
		})
	
	sets.midcast["Haste"] = set_combine(sets.midcast.EnhancingDuration, {
		})
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		waist="Siegel Sash"
		})

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {
		feet="Orison Duckbills +2",
		hands="Dynasty Mitts",
		})

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        head="Orison Cap +2",
        body="Ebers Bliaud +1",
		})

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		head="Inyanga Tiara +1",
		})

    -- sets.midcast.Protectra = {}

    -- sets.midcast.Shellra = {}


    sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast, {
		})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast, {
		})
		
	sets.midcast["Enfeebling Magic"] = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Hydrocera",
		head="Inyanga Tiara +1",
		neck="Erra Pendant",
		left_ear="Malignance Earring",
		right_ear="Gwati Earring",
		body=gear.vanya_body_skill,
		hands="Inyanga Dastanas +2",
		ring1="Kishar Ring",
		ring2="Etana Ring",
		back="Kumbira Cape",
		waist="Eschan Stone",
		legs="Inyanga Shalwar +2",
		feet="Medium's Sabots",
		})

    -- Custom spell classes
    sets.midcast.MndEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {
		})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {
		})
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		ring1="Fortified Ring",
		ring2="Shneddick Ring",
        back="Solemnity Cape",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Inyanga Crackows +1",
		}    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Homiliary",
		head="Inyanga Tiara +1",
		neck="Loricate Torque",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		ring1="Fortified Ring",
		ring2="Shneddick Ring",
        back="Solemnity Cape",
        waist="Fucho-no-obi",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +1",
		}

    sets.idle.PDT = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Enki Strap",
		ear1="Eabani Earring",
		})

    -- sets.idle.Town = {}
    
    --sets.idle.Weak = {}
    
    -- Defense sets

    -- sets.defense.PDT = {}

    -- sets.defense.MDT = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		ring1="Fortified Ring",
		ring2="Shneddick Ring",
        back="Solemnity Cape",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Inyanga Crackows +1",
		}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset 5')
end
