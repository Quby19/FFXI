-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('Mote-TreasureHunter')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate','Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo','Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.Stun = S{'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'White Wind','Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Mod')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'TH')
    state.IdleMode:options('Normal', 'PDT')

    state.DW = M(true, 'Dual Wield')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
    send_command('bind !d gs c toggle DW')	
	send_command('bind f9 gs c cycle CastingMode')
	send_command('bind ^f9 gs c cycle treasuremode')

    update_combat_form()
    select_default_macro_book()
    set_lockstyle()
	
	gear.rosmerta_nuke 		={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.rosmerta_fc 		={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}}
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind !d')
	send_command('unbind f9')
	send_command('unbind ^f9')
end

-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
	--------------------------------------
	sets.TreasureHunter = {
        head="White Rarab Cap +1",
		waist="Chaac Belt",
		legs="Volte Hose"
		}

    -- Fast cast sets for spells    
    sets.precast.FC = {
		ammo="Staunch Tathlum +1",
		head=gear.herc_head_mabwsd, -- 7
		neck="Orunmila's Torque",	-- 5
		ear1="Etiolation Earring",	-- 1
		ear2="Loquac. Earring",		-- 2
		body=gear.jhakri_body,
		hands="Leyline Gloves",		-- 8
		ring1="Kishar Ring",		-- 4
		ring2="Defending Ring",
		back=gear.rosmerta_fc,		-- 10
		-- waist="",
		legs="Psycloth Lappas",		-- 7
		feet="Carmine Greaves",		-- 7
	}
	
	-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head=gear.herc_head_wsd,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.adhemar_body_melee,
		hands=gear.jhakri_hands,
		ring1="Apate Ring",
		ring2="Rajas Ring",
		back=gear.rosmerta_fc,
		waist="Fotia Belt",
		legs=gear.herculean_legs_wsd,
		feet=gear.jhakri_feet
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS)

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        head=gear.herc_head_mabwsd,
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
        body=gear.jhakri_body,
		hands=gear.jhakri_hands,
		ring1="Metamorph Ring +1",
		ring2="Acumen Ring",
		back=gear.rosmerta_nuke,
		waist="Eschan Stone",
		legs=gear.jhakri_legs,
		feet=gear.jhakri_feet
		})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        head=gear.adhemar_head_melee,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
        body=gear.adhemar_body_melee,
		hands=gear.adhemar_hands_melee,
		ring1="Epona's Ring",
		waist="Fotia Belt",
		})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Lilitu Headpiece",
		neck="Caro Necklace",
		waist="Sailfi Belt +1",
		})
		
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
        
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast,{
		-- hands="Hashishin Bazubands +1"
		})

    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
		ammo="Hydrocera",
        head=gear.jhakri_head,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
        body=gear.jhakri_body,
		hands=gear.jhakri_hands,
		ring1="Metamorph Ring +1",
		ring2="Acumen Ring",
		back=gear.rosmerta_nuke,
		waist="Eschan Stone",
		legs=gear.jhakri_legs,
		feet=gear.jhakri_feet
	}
	
	sets.midcast['Blue Magic'].Magical.TH = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="White Rarab Cap +1",
		waist="Chaac Belt",
		legs="Volte Hose"
	})
	
	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="Pixie Hairpin +1",
		ring2="Archon Ring",
	})

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical)

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy)
 
	-- Cure potency +9%
	sets.midcast['Blue Magic'].Healing =  set_combine(sets.midcast.FastRecast, {
		neck="Phalaina Locket", -- 4%
		ear1="Mendicant's Earring", -- 5%
		ring1="Vocane ring"
	})
		
    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
	})

    sets.midcast['Blue Magic'].SkillBasedBuff = {}

    sets.midcast['Blue Magic'].Buff = {}
	
	sets.midcast.Refresh = {}
 
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff,{
		-- hands="Assimilator's Bazubands +1"
	})

    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Idle sets
    sets.idle = {
		-- main="Naegling",
		-- sub="Genbu's Shield",
		ammo="Staunch Tathlum +1",
		neck="Sanctity Necklace",
		head="Malignance Chapeau",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body=gear.jhakri_body,
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
		back=gear.rosmerta_fc,
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
	}
	
	sets.idle.PDT = set_combine(sets.idle, {
		neck="Loricate Torque +1",
		-- legs="Malignance Tights",
	})

	-- Resting sets
    sets.resting = set_combine(sets.idle, {
		body=gear.jhakri_body
		})
    
    sets.Kiting = {legs="Carmine cuisses +1"}

    -- Engaged sets
    sets.engaged = {
		ammo="Ginsen",
		head=gear.adhemar_head_melee,
		neck="Lissome Necklace",
		ear1="Telos Earring",
		ear2="Brutal Earring",
		body=gear.adhemar_body_melee,
		hands=gear.adhemar_hands_melee,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=gear.rosmerta_fc,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.herculean_feet_melee,
	}
	
    sets.engaged.Mod = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		lets="Malignance Tights",
		feet="Malignance Boots",
	
	})
	
	-- Defense sets
    sets.defense.PDT = {		
		}

    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		neck="Loricate Torque +1",
		head="Malignance Chapeau",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body=gear.jhakri_body,
		hands="Malignance Gloves",
		ring1="Vocane Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Malignance Boots",
		}  

	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)

    sets.self_healing = set_combine(sets.midcast['Blue Magic'].Healing)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
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
        state.Buff[buff] = gain
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
            msg = msg .. ' ' .. v .. ''
        end
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
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 13)
    else
        set_macro_page(1, 13)
    end
end


function set_lockstyle()
    send_command('wait 4; input /lockstyleset 11')
end
