-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow

--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy','Sonic Buffet','Tornado II'}


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy', ['Siren']='Hysteric Assault'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600,
		['Katabatic Blades'] = 360, ['Chinook'] = 900, ['Wind\'s Blessing'] = 300
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	state.BallistaMode:options('Normal', 'Skill')

    gear.perp_staff = {name="Gridarvor"}
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	-- Gear Variables
	Artifact_Convoker = {}
    Artifact_Convoker.Head = "Convoker's Horn +1"
    Artifact_Convoker.Body = "Convoker's Doublet +3"
    Artifact_Convoker.Hands = "Convoker's Bracers +3"
    Artifact_Convoker.Legs = ""
    Artifact_Convoker.Feet = "Convoker's Pigaches +3"

    Relic_Glyphic = {}
    Relic_Glyphic.Head = "Glyphic Horn +3"
    Relic_Glyphic.Body = "Glyphic Doublet +2"
    Relic_Glyphic.Hands = "Glyphic Bracers +3"
    Relic_Glyphic.Legs = "Glyphic Spats +2"
    Relic_Glyphic.Feet = "Glyphic Pigaches +3"

    Empy_Beckoner = {}
    Empy_Beckoner.Head = "Beckoner's Horn +1"
    Empy_Beckoner.Body = ""
    Empy_Beckoner.Hands = "Beckoner's Bracers +1"
    Empy_Beckoner.Legs = ""
    Empy_Beckoner.Feet = "Beckoner's Pigaches +1"

	--------------------------------------
	-- Shared Sets
	--------------------------------------
	sets.Baayami = {
		head="Baayami Hat +1",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
	}
	
	sets.MaxSummoningSkill = set_combine(sets.Baayami, {
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Cath Palug Earring",
		ring2="Evoker's Ring",
		waist="Lucidity Sash",
		back=gear.back.Conveyance
	})
	
	sets.ballista = sets.Baayami
	
	sets.ballista.Skill = sets.MaxSummoningSkill

    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = { head=Relic_Glyphic.Head }
	sets.precast.JA['Mana Cede'] = { hands=Empy_Beckoner.Hands }
    
    sets.precast.JA['Elemental Siphon'] = set_combine(sets.MaxSummoningSkill, {
		back="Conveyance Cape",
		ring2="Zodiac Ring",
		feet=Empy_Beckoner.Feet
	})

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = set_combine(sets.MaxSummoningSkill, {
		main="Espiritus",
		ammo="Sancus Sachet +1",
		head=Empy_Beckoner.Head
	})

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		head="Cath Palug Crown", -- 8
		neck="Orunmila's Torque", -- 5
		ear1="Etiolation Earring", -- 1
		ear2="Loquacious Earring", -- 2
        body="Baayami Robe +1", -- 12
		ring1="Kishar Ring", -- 4
		ring2="Lebeche Ring",
		waist="Channeler's Stone", -- 2
        legs="Gyve Trousers", -- 4
		feet="Regal Pumps" -- 3
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.Cure = set_combine(sets.precast.FC,{
		main="Daybreak",
		sub="Ammurapi Shield",
		ear1="Mendicant's Earring",
		back="Pahtli Cape"
	})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
		main="Daybreak", -- 30
		sub="Ammurapi Shield",
		ammo="Hydrocera",
        head="Cath Palug Crown",
		neck="Nodens Gorget", -- 5
		ear1="Mendicant's Earring", -- 5
		ear2="Magnetic Earring",
        body="Vrikodara Jupon", -- 13
		hands="Telchine Gloves", -- 10
		ring2="Lebeche Ring", -- 3
        back="Solemnity Cape", -- 7
		legs="Gyve Trousers", -- 10
		feet="Medium's Sabots" -- 7
	}

	sets.midcast['Summoning Magic'] = {
		body="Baayami Robe +1",
		back=gear.back.Campestres.Physical
	}

	sets.midcast['Enhancing Magic'] = {
		main="Kaja Rod",
		sub="Ammurapi Shield",
		ear1="Andoaa Earring",
		head=gear.head.Telchine.EnhancingDuration,
		hands="Inyanga Dastanas +1",
		legs=gear.legs.Telchine.EnhancingDuration,
		feet=gear.feet.Telchine.EnhancingDuration
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		waist="Siegel Sash"
	})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1",
		waist="Gishdubar Sash"
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1"
	})
	
	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Inyanga Tiara +1",
		neck="Erra Pendant",
		ear1="Gwati Earring",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +1",
		ring1="Kishar Ring",
		ring2="Jhakri Ring",
		legs="Inyanga Shalwar +1",
		feet="Inyanga Crackows +1",
		waist="Eschan Stone"
	}

    sets.midcast['Elemental Magic'] = sets.idle

    sets.midcast['Dark Magic'] = sets.idle
	
    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = sets.MaxSummoningSkill

    sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.midcast.Pet.BloodPactWard, {
		neck="Summoner's Collar +2",
		ear1="C. Palug Earring",
		ear2="Lugalbanda Earring",
		body=Artifact_Convoker.Body,
		hands=Artifact_Convoker.Hands,
		back=gear.back.Campestres.Magical,
		waist="Regal Belt",
		feet=Artifact_Convoker.Feet
	})
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head=gear.head.Apogee.Physical,
		neck="Summoner's Collar +2",
		ear1="Gelos Earring",
		ear2="Lugalbanda Earring",
        body=Artifact_Convoker.Body,
		hands=gear.hands.Merlinic.Physical,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back=gear.back.Campestres.Physical,
        waist="Incarnation Sash",
		legs=gear.legs.Apogee.Physical,
		feet=gear.feet.Apogee.Physical
	}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
		body=Artifact_Convoker.Body,
		hands=Artifact_Convoker.Hands,
		feet=Artifact_Convoker.Feet,
		waists="Klouskap Sash +1"
	})

    sets.midcast.Pet.MagicalBloodPactRage = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head="Cath Palug Crown",
		neck="Summoner's Collar +2",
		ear1="Gelos Earring",
		ear2="Lugalbanda Earring",
        body=Artifact_Convoker.Body,
		hands=gear.hands.Merlinic.Magical,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
        back=gear.back.Campestres.Magical,
		waist="Regal Belt",
		legs=gear.legs.EnticersPants,
		feet=gear.feet.Apogee.Magical
	}
	
	sets.midcast.Pet.MagicalBloodPactRage['Flaming Crush'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
		legs=gear.legs.Apogee.Physical,
		feet=gear.feet.Apogee.Physical
	})

    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
		feet=Artifact_Convoker.Feet
	})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = sets.idle
    
    -- Idle sets
	sets.idle.Town = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Baayami Hat +1",
		neck="Summoner's Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back="Moonlight Cape",
		waist="Regal Belt",
		legs="Baayami Slops +1",
		feet="Crier's Gaiters"
	}
	
    sets.idle = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sancus Sachet +1",
		head=Empy_Beckoner.Head,
		neck="Summoner's Collar +2",
		ear1="Lugalbanda Earring",
		ear2="Cath Palug Earring",
		body="Shomonjijoe +1",
		hands="Asteria Mitts +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Moonlight Cape",
		waist="Regal Belt",
		legs="Assiduity Pants +1",
		feet="Baayami Sabots +1"
	}

	-- Total: 45%
    sets.idle.PDT = set_combine(sets.idle, {
		main="Malignance Pole", -- 20%
		sub="Elan Strap +1",
		neck="Loricate Torque +1", -- 6%
		ring2="Defending Ring", -- 10%
		waist="Regal Belt", -- 3%
		back="Moonlight Cape" -- 6%
	})
	
	-- Total: 45%
	sets.idle.MDT = sets.idle.PDT
	
	sets.defense.PDT = sets.idle.PDT
	sets.defense.MDT = sets.idle.MDT

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Convoker's Pigaches: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = set_combine(sets.idle, {
		main="Nirvana",
		sub="Elan Strap +1",
		head="Baayami Hat +1",
		neck="Caller's Pendant",
		ear1="Evans Earring",
		body="Shomonjijoe +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		waist="Lucidity Sash",
		legs="Assiduity Pants +1",
		feet=Empy_Beckoner.Feet,
		back=gear.back.Campestres.Physical
	})

    --sets.idle.PDT.Avatar = {main="Gridarvor",sub="Achaq Grip",ammo="Seraphicaller",
    --    head="Convoker's Horn",neck="Caller's Pendant",ear1="Gifted Earring",ear2="Loquacious Earring",
    --    body="Hagondes Coat",hands="Regimen Mittens",ring1="Evoker's Ring",ring2="Defending Ring",
    --    back="Conveyance Cape",waist="Fucho-no-Obi",legs="Hagondes Pants",feet="Convoker's Pigaches"}

    --sets.idle.Spirit = {main="Gridarvor",sub="Achaq Grip",ammo="Seraphicaller",
    --    head="Convoker's Horn",neck="Caller's Pendant",ear1="Gifted Earring",ear2="Loquacious Earring",
    --    body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Evoker's Ring",ring2="Sangoma Ring",
    --    back="Samanisi Cape",waist="Fucho-no-Obi",legs="Summoner's Spats",feet="Herald's Gaiters"}

    sets.idle.Avatar.Favor = set_combine(sets.idle.Avatar, {
		head="Baayami Hat +1",
		body="Shomonjijoe +1",
		hands="Baayami Cuffs +1",
		waist="Lucidity Sash",
		legs="Baayami Slops +1"
	})
    
	sets.idle.Avatar.Melee = set_combine(sets.idle.Avatar,{
		neck="Shulmanu Collar",
		ear2="Domesticator's Earring",
		waist="Klouskap Sash +1",
	})
	
	sets.idle.Avatar.Favor.Melee = set_combine(sets.idle.Avatar.Favor,{
		neck="Shulmanu Collar",
		ear2="Domesticator's Earring",
		waist="Klouskap Sash +1",
	})
        
    sets.perp = {}
	
	sets.perp.staff_and_grip = {
		main="Gridarvor"
	}
	
	-- Avatar matches day
    sets.perp.Day = {
		hands=Empy_Beckoner.Feet
	}
	-- Avatar matches weather
    sets.perp.Weather = {
		neck="Caller's Pendant",
		hands=Empy_Beckoner.Hands
	}
	-- Carbuncle
    sets.perp.Carbuncle = {
		hands="Asteria Mitts +1"
	}
	-- Alexander
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    sets.Kiting = {feet="Crier's Gaiters"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Baayami Hat +1",
		neck="Shulmanu Collar",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		back="Moonlight Cape",
		waist="Klouskap Sash +1",
		legs="Baayami Slops +1",
		feet=Empy_Beckoner.Feet
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 5)
end
