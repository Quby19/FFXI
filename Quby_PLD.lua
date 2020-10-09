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
	
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
	
	-- Auto ws mode
	state.autoWS = M(false)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.OffenseMode:options('Normal', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'SIRD')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
    state.HybridMode:options('Normal', 'PDT', 'MDT')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.DualWield = M(false, 'Dual Wield III')
    state.EquipShield = M(false, 'Equip Shield w/Defense')
	state.Shield = M{['description']='Current Shield','Aegis', "Ochain"}

    update_defense_mode()
    
	send_command('bind f9 gs c cycle CastingMode')
	send_command('bind ^f9 gs c cycle treasuremode')
	send_command('bind ^k gs c cycle autoWS')
	send_command('bind ^g gs c cycle Shield')
	send_command('bind ^w gs c cycle HybridMode')
	send_command('bind !e input /item "Echo Drops" <me>')
	send_command('bind !h input /item "Holy Water" <me>')
	send_command('bind !r input /item "Remedy" <me>')

    select_default_macro_book()
	set_lockstyle()
end

function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
    send_command('unbind ^k')
    send_command('unbind ^g')
    send_command('unbind ^w')
	send_command('unbind !e')
	send_command('unbind !h')
	send_command('unbind !r')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt",
		feet="Odyssean Greaves"
    }
	
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
	sets.precast.JA = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Moonbeam Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		ring1="Apeile Ring +1",
		ring2="Apeile Ring",
        back="Rudianos's Mantle",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
	
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {ear2="Knightly Earring",hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps 80%; PLD JT: 0%
    sets.precast.FC = {
        ammo="Incantor Stone",		    --2%
		neck="Orunmila's Torque",		-- 5
        ear1="Etiolation Earring",      --1%
        ear2="Loquacious Earring",      --2%
		body="Reverence Surcoat +2",    --5%
		hands="Leyline Gloves",		    --8%
		ring1="Kishar Ring"
		}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		-- waist="Siegel Sash",
		})
		
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		-- neck="Diemer Gorget",
		-- ear2="Nourishing Earring +1"
	})
	
    ----- Weaponskill sets
	
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
        head=gear.flamma_head,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body=gear.flamma_body,
		hands=gear.flamma_hands,
		ring1="Apate Ring",
		ring2="Rajas Ring",
        back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Volte Hose",
		feet=gear.flamma_feet
		}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Atonement'] = set_combine(sets.precast.WS, {})
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Magnetic Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
         
    sets.midcast.Enmity = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Moonbeam Necklace",
		ear1="Cryptic Earring",
		ear2="Friomisi Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		ring1="Apeile Ring +1",
		ring2="Apeile Ring",
        back="Rudianos's Mantle",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
     
    sets.midcast.SIRD = {
		ammo="Staunch Tathlum +1",
		head="Souveran Schaller +1",
		neck="Moonbeam Necklace",
		ear2="Knightly Earring",
		legs="Carmine Cuisses +1",
		feet="Odyssean Greaves"
		}
 
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.midcast.SIRD)
     
    sets.midcast.Stun = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.midcast.Stun, sets.midcast.SIRD)
     
    sets.midcast.Cure = set_combine(sets.midcast.Enmity, {
		-- neck="Phalaina Locket",
		-- back="Solemnity Cape",
		-- ear2="Nourishing Earring +1"
		})
    sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
 
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
     
    sets.midcast['Enhancing Magic'] = {
		legs="Carmine Cuisses +1",
		}
    sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SIRD)
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		ammo="Staunch Tathlum +1",
		head="Yorium Barbuta",
		body="Yorium Cuirass",
		hands="Souveran Handschuhs +1",
		back="Weard Mantle",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"
		})
	sets.midcast['Phalanx'].SIRD = set_combine(sets.midcast['Phalanx'], {		
		head="Souveran Schaller +1",
		neck="Moonbeam Necklace",
		ear1="Knightly Earring",
		ear2="Magnetic Earring",
		ring2="Evanescence Ring",
		})
     
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protect.SIRD = set_combine(sets.midcast.Protect, sets.midcast.SIRD)
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shell.SIRD = set_combine(sets.midcast.Shell, sets.midcast.SIRD)
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {}
    
    sets.resting = {
		ammo="Homiliary",
		neck="Sanctity Necklace",
        ring1="Sheltered Ring",
		}    

    ----- Idle sets
    sets.idle = {
		ammo="Homiliary",
        head="Souveran Schaller +1",
		neck="Sanctity Necklace",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",
		hands="Regal Gauntlets",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
		waist="Creed Baudrier",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"
		}
		
	sets.idle.PDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		neck="Diemer Gorget",
		hands="Souveran Handschuhs +1",
		ring2="Defending Ring",
		legs="Souveran Diechlings +1",
		})
	
	sets.idle.MDT = set_combine(sets.idle.PDT, {
		neck="Loricate Torque +1",
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
		legs="Carmine Cuisses +1",
		})
    
    sets.idle.Weak = set_combine(sets.idle.PDT, {})
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {
		legs="Carmine Cuisses +1"
		}

    -- sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    -- sets.Knockback = {back="Repulse Mantle"}
    -- sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    -- sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Brilliance",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Brilliance",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Diemer Gorget",
		ear1="Etiolation Earring",
		ear2="Magnetic Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
		
    sets.defense.HP = set_combine(sets.defense.PDT, {
		ear2="Odnowa Earring +1",
		ring1="Moonbeam Ring",
		ring2="Moonbeam Ring"
		})
    sets.defense.Reraise = set_combine(sets.defense.PDT, {})
    sets.defense.Charm = set_combine(sets.defense.PDT, {})
	
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		neck="Loricate Torque +1",		
		waist="Creed Baudrier"
		})


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
		ammo="Ginsen",
        head=gear.flamma_head,
		neck="Lissome Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
        body=gear.flamma_body,
		hands=gear.flamma_hands,
		ring1="Petrov Ring",
		ring2="Rajas Ring",
        back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Carmine Cuisses +1",
		feet=gear.flamma_feet
		}

    sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Sanctity Necklace",
		hands="Souveran Handschuhs +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		})

    sets.engaged.DW = set_combine(sets.engaged, {})

    sets.engaged.DW.MaxHaste = set_combine(sets.engaged, {})

    sets.engaged.DW.HighHaste = set_combine(sets.engaged, {})
        
    sets.engaged.DW.MidHaste = set_combine(sets.engaged, {})

    sets.engaged.DW.LowHaste = set_combine(sets.engaged, {})

    sets.engaged.DW.Acc = set_combine(sets.engaged, {})

    sets.engaged.PDT = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Diemer Gorget",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
		
    -- sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
		-- ammo="Staunch Tathlum +1",
        -- head="Souveran Schaller +1",
		-- neck="Diemer Gorget",
		-- ear1="Etiolation Earring",
		-- ear2="Magnetic Earring",
        -- body="Reverence Surcoat +2",
		-- hands="Souveran Handschuhs +1",
		-- left_ring="Moonbeam Ring",
		-- right_ring="Moonbeam Ring",
        -- back="Moonbeam Cape",
		-- waist="Creed Baudrier",
		-- legs="Souveran Diechlings +1",
		-- feet="Souveran Schuhs +1"
		-- })
		
	sets.engaged.MDT = {
		ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
        back="Moonbeam Cape",		
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"
		}
		
    -- sets.engaged.Acc.MDT = set_combine(sets.engaged.Acc, {
		-- ammo="Staunch Tathlum +1",
        -- head="Souveran Schaller +1",
		-- neck="Loricate Torque +1",
		-- ear1="Etiolation Earring",
		-- ear2="Magnetic Earring",
        -- body="Reverence Surcoat +2",
		-- hands="Souveran Handschuhs +1",
		-- left_ring="Moonbeam Ring",
		-- right_ring="Moonbeam Ring",
        -- back="Moonbeam Cape",
		-- waist="Creed Baudrier",
		-- legs="Souveran Diechlings +1",
		-- feet="Souveran Schuhs +1"
		-- })
		
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {
		body="Reverence Surcoat +2",
		neck="Loricate Torque +1",
		ring2="Defending Ring"
		})
		
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {
		body="Reverence Surcoat +2",
		neck="Loricate Torque +1",
		ring2="Defending Ring"
		})
		
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	--sets.Reive.Cure.with_buff['reive mark'] = {neck="Arciela's Grace +1"}

    -- sets.buff.Doom = {ring2="Saida Ring"}
    -- sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Shield.current == 'Aegis' then
        equip({main="Brilliance",sub="Aegis"})
    elseif state.Shield.current == 'Ochain' then
        equip({main="Brilliance",sub="Ochain"})
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
	if stateField == 'Current Shield' then
        if state.Shield.current == 'Aegis' then
            equip({main="Brilliance",sub="Aegis"})
        elseif state.Shield.current == 'Ochain' then
            equip({main="Brilliance",sub="Ochain"})
        end
    end
	
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Shield.current == 'Aegis' then
        equip({main="Brilliance",sub="Aegis"})
    elseif state.Shield.current == 'Ochain' then
        equip({main="Brilliance",sub="Ochain"})
    end
	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    if haste_string then
        msg = msg .. ' '..haste_string
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'BLU' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'WAR' then
		set_macro_page(5, 7)
    else
        set_macro_page(1, 7)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset 6')
end