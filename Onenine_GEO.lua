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
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT')
	
	gear.nantosuelta_regen = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%',}}

    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}

    -- Fast cast sets for spells

    sets.precast.FC = {
		main="Solstice",			--4
		sub="Genbu's Shield",
		range="Dunna",  			--3
        head="Nahtirah Hat",		--10
		neck="Dualism Collar",
		ear1="Malignance Earring",	--4
		ear2="Etiolation Earring",	--1
        body="Shango Robe",			--8
		hands="Geomancy mitaines +2",
		ring1="Kishar Ring",		--4
		ring2="Etana Ring",
        back="Lifestream Cape",		--7
		waist="Embla sash",			--5
		legs="Geomancy Pants +1",	--11
		feet="Merlinic Crackows"	--9
		}
		
	sets.precast.FC['Dispelga'] = {
		main="Daybreak",
		sub="Genbu's Shield",
		range="Dunna",  			--3
        head="Nahtirah Hat",		--10
		neck="Dualism Collar",
		ear1="Malignance Earring",	--4
		ear2="Etiolation Earring",	--1
        body="Shango Robe",			--8
		hands="Geomancy mitaines +2",
		ring1="Kishar Ring",		--4
		ring2="Etana Ring",
        back="Lifestream Cape",		--7
		waist="Embla sash",			--5
		legs="Geomancy Pants +1",	--11
		feet="Merlinic Crackows"	--9
		}
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head=gear.vanya_head_skill,
		ear1="Mendicant's Earring",	
		body=gear.vanya_body_skill,
		hands=gear.vanya_hands_skill,
		legs=gear.vanya_legs_skill,
		feet=gear.vanya_feet_skill,
		})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		ear2="Barkarole Earring",
		hands="Mallquis Cuffs +1",
		ring2="Mallquis Ring",
		})
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		})
	
	sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi hat",
		})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ring1="Rajas Ring",
		ring2="Apate Ring",
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {})

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
	
		}

    --- 901 skill
    sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast, {
        range="Dunna",
        head="Azimuth Hood +1",
        neck="Incanter's Torque",
		ear1="Mendicant's Earring",
		ear2="Gifted Earring",
        body="Bagua Tunic +1", 
        hands="Geomancy Mitaines +2",
        back="Lifestream Cape",
		})

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
		main="Solstice",
		legs="Bagua Pants +1",
        feet="Azimuth Gaiters +1",
		})
    
    sets.midcast["Elemental Magic"] = set_combine(sets.midcast.FastRecast, {
		main="Solstice",
		sub="Culminus",
		ammo="Hydrocera",
        head="Mallquis Chapeau +1",
		neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Barkarole Earring",
        body="Mallquis Saio +2",
		hands="Mallquis Cuffs +1",
		ring1="Mallquis Ring",
		ring2="Etana Ring",
        back="Kumbira Cape",
		waist="Eschan Stone",
		back="Kumbira Cape",
		legs="Mallquis Trews +1",
		feet="Mallquis Clogs +2"
		})
		
	sets.midcast.GeoElem = sets.midcast["Elemental Magic"]

    sets.midcast["Enfeebling Magic"] = set_combine(sets.midcast.FastRecast, {
		head="Befouled Crown",
		body=gear.vanya_body_skill,
		hands="Geo. Mitaines +2",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		ring1="Kishar Ring",
		ring2="Etana Ring",
		back="Kumbira Cape",
		})

    sets.midcast["Dark Magic"] = set_combine(sets.midcast["Enfeebling Magic"], {   
		neck="Erra Pendant",
		body="Shango Robe"
		})

    sets.midcast.Drain = set_combine(sets.midcast["Dark Magic"], {
		waist="Fucho-no-obi",
		feet="Merlinic crackows"
		})

    sets.midcast.Aspir = sets.midcast.Drain
	
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
			ear1="Andoaa Earring",		
		})
		
	sets.midcast["Haste"] = set_combine(sets.midcast.EnhancingDuration, {
		})
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		waist="Siegel Sash"
		})

    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		main="Daybreak",
		sub="Genbu's Shield",
		ammo="Hydrocera",
        head=gear.vanya_head_skill,
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",
		ear2="Etiolation Earring",
        body=gear.vanya_body_skill,
		hands=gear.vanya_hands_skill,
		ring1="Sirona's ring",
		ring2="Etana Ring",
		legs=gear.vanya_legs_skill,
		back="Lifestream Cape",
		feet=gear.vanya_feet_skill,
		})
    
    sets.midcast.Curaga = sets.midcast.Cure

    -- sets.midcast.Protectra = {ring1="Sheltered Ring"}

    -- sets.midcast.Shellra = {ring1="Sheltered Ring"}
	
	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
    })
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
		main="Daybreak",
		sub="Genbu's Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Witching Robe",
		hands="Geomancy Mitaines +2",
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
        back="Kumbira Cape",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Azimuth Gaiters +1",
		}

    -- Idle sets

    sets.idle = {
		main="Daybreak",
		sub="Genbu's Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Witching Robe",
		hands="Geomancy Mitaines +2",
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
        back=gear.nantosuelta_regen,
        waist="Fucho-no-obi",
		legs="Assiduity Pants +1",
		feet="Azimuth Gaiters +1"
		}

    sets.idle.PDT = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Enki Strap",
		neck="Loricate Torque",
		ear1="Eabani Earring",
        body="Mallquis Saio +2",
		legs="Geomancy Pants +1"
		})

    -- .Pet sets are for when Luopan is present.  39
    sets.idle.Pet = {
		main="Daybreak",
		sub="Genbu's Shield",
		range="Dunna",						--5
        head="Azimuth Hood +1",
		neck="Loricate Torque",
		ear1="Handler's Earring +1",		--4
		ear2="Handler's Earring",			--3
		body=gear.telchine_body_pet_dt,		--4
		hands="Geomancy Mitaines +2",		--12
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
        back=gear.nantosuelta_regen,
        waist="Isa Belt",					--3
		legs="Psycloth Lappas",				--4
		feet=gear.telchine_feet_pet_dt		--4
		}

    sets.idle.PDT.Pet = set_combine(sets.idle.Pet, {	
		main="Malignance Pole",
		sub="Enki Strap",
		ear2="Etiolation Earring",
        body="Mallquis Saio +2",
		feet="Azimuth Gaiters +1",
		})

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = sets.idle
    sets.idle.PDT.Indi = sets.idle.PDT
    sets.idle.Pet.Indi = sets.idle.Pet
    sets.idle.PDT.Pet.Indi = sets.idle.PDT.Pet

    -- sets.idle.Town = {}

    -- sets.idle.Weak = {}

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {
		head="Befouled Crown",
		neck="Loricate Torque",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
        body="Mallquis Saio +2",
		hands="Geomancy Mitaines +2",
		ring1="Gelatinous Ring +1",
		ring2="Shneddick Ring",
        back="Lifestream Cape",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Azimuth Gaiters +1"
		}

    sets.Kiting = {}

    sets.latent_refresh = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = set_combine(sets.idle, {
		main="Daybreak",
		sub="Genbu's Shield",
		})

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
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
    set_macro_page(2, 2)
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 6')
end