--------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        QuickDraw Selector  Cycle through available primary and secondary shot types,
                            and trigger with a single macro
        Haste Detection     Detects current magic haste level and equips corresponding engaged set to
                            optimize delay reduction (automatic)
        Haste Mode          Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
        Capacity Pts. Mode  Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle     Automatically locks specified equipset on file load
--]]


------------------------------------------------------------------------
-------------------------------------------

--[[
    Custom commands:
    
    gs c qd
        Uses the currently configured shot on the target, with either <t> or <stnpc> depending on setting.
    gs c qd t
        Uses the currently configured shot on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainqd
        Cycles through the available steps to use as the primary shot when using one of the above commands.
        
    gs c cycle altqd
        Cycles through the available steps to use for alternating with the configured main shot.
        
    gs c toggle usealtqd
        Toggles whether or not to use an alternate shot.
        
    gs c toggle selectqdtarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
        
        
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


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
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.FlurryMode = M{['description']='Flurry Mode', 'Flurry I', 'Flurry II'}
    state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
    state.DualWield = M(false, 'Dual Wield III')
    state.QDMode = M{['description']='Quick Draw Mode', 'Magic Enhance', 'Magic Attack', 'STP'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
    
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
    
    define_roll_values()
    determine_haste_group()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')    
    state.Gun = M{['description']='Current Gun', 'Death Penalty', 'Fomalhaut', 'Ataktos'}--, 'Armageddon'
    state.CP = M(false, "Capacity Points Mode")

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Chrono Bullet"
    options.ammo_warning_limit = 10

    -- Additional local binds
    

    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command ('bind @` gs c toggle LuzafRing')

    send_command('bind ^- gs c cycleback mainqd')
    send_command('bind ^= gs c cycle mainqd')
    send_command('bind !- gs c cycle altqd')
    send_command('bind != gs c cycleback altqd')
    send_command('bind ^[ gs c toggle selectqdtarget')
    send_command('bind ^] gs c toggle usealtqd')

    send_command('bind @c gs c toggle CP')
    send_command('bind @q gs c cycle QDMode')
    send_command('bind @k gs c cycle Gun')
    send_command('bind @f gs c cycle FlurryMode')
    send_command('bind @h gs c cycle HasteMode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numlock input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'RNG' then
        send_command('bind ^numpad/ input /ja "Barrage" <me>')
        send_command('bind ^numpad* input /ja "Sharpshot" <me>')
        send_command('bind ^numpad- input /ja "Shadowbind" <me>')
    end

    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    send_command('bind ^numpad4 input /ws "Leaden Salute" <t>')
    send_command('bind ^numpad6 input /ws "Wildfire" <t>')
    send_command('bind ^numpad1 input /ws "Requiescat" <t>')
    send_command('bind ^numpad2 input /ws "Sniper Shot" <t>')
    send_command('bind ^numpad3 input /ws "Numbing Shot" <t>')


    

    select_default_macro_book()
    set_lockstyle(19)
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^,')
    send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @g')
    send_command('unbind @f')
    send_command('unbind @h')
    send_command('unbind @w')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind numpad0')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +2"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}

    sets.precast.CorsairRoll = {
    main="Fettering Blade",
    sub="Nusku Shield",
    range={ name="Compensator", augments={'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}},
   
    head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    body={ name="Lanun Frac +2", augments={'Enhances "Loaded Deck" effect',}},
    hands="Chasseur's Gants",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Regal Necklace",
    waist="Grunfeld Rope",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Defending Ring",
    right_ring="Meghanada Ring",
    back={ name="Camulus's Mantle", augments={'AGI+17','Rng.Acc.+20 Rng.Atk.+20','AGI+3','Weapon skill damage +10%',}},}

    sets.precast.CorsairRoll.Gun = set_combine(sets.precast.CorsairRoll.Engaged, {})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
    
    sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.FoldDoubleBust = {}

    sets.precast.Waltz = {}

    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.FC = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Taeon Tabard", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','"Fast Cast"+4','Phalanx +3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Voltsurge Torque",
    left_ear="Loquac. Earring",
    left_ring="Weather. Ring",
    right_ring="Kishar Ring",}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Oshosi Vest",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Meg. Jam. +2",
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Ilabrat Ring",
    right_ring="Rajas Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},} --59/26

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Oshosi Vest",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Snapshot"+6',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Meg. Jam. +2",
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Ilabrat Ring",
    right_ring="Rajas Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}) --47/46

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {main="Fettering Blade",
    main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Laksa. Frac +3",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Meg. Jam. +2",
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Ilabrat Ring",
    right_ring="Rajas Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}) --30/65


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {head={ name="Herculean Helm", augments={'Rng.Acc.+26','Weapon skill damage +3%','AGI+14',}},
    body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +3%','DEX+4','Rng.Acc.+11','Rng.Atk.+7',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'Rng.Atk.+30','Weapon skill damage +4%','AGI+7',}},
    feet={ name="Herculean Boots", augments={'Rng.Acc.+20','Weapon skill damage +4%','AGI+12',}},
    neck="Iskur Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Ishvara Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {head="Meghanada Visor +1",
    body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +3%','DEX+4','Rng.Acc.+11','Rng.Atk.+7',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+13 Rng.Atk.+13','Weapon skill damage +4%','Rng.Acc.+14','Rng.Atk.+13',}},
    feet={ name="Herculean Boots", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','Rng.Acc.+10','Rng.Atk.+2',}},
    neck="Iskur Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Telos Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},})

    sets.precast.WS['Wildfire'] = {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','INT+8','Mag. Acc.+4',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','INT+10','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Gunslinger's Cape", augments={'Enmity-5','"Mag.Atk.Bns."+2','"Phantom Roll" ability delay -1','Weapon skill damage +4%',}},}

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {main="Fettering Blade",
    sub="Nusku Shield",
    head="Pixie Hairpin +1",
    body="Laksa. Frac +3",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit.hit rate+1','MND+8','"Mag.Atk.Bns."+12',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Vertigo Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+17','Rng.Acc.+20 Rng.Atk.+20','AGI+3','Weapon skill damage +10%',}},})

    sets.precast.WS['Leaden Salute'].FullTP = {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','INT+8','Mag. Acc.+4',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','INT+10','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Novio Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back={ name="Gunslinger's Cape", augments={'Enmity-5','"Mag.Atk.Bns."+2','"Phantom Roll" ability delay -1','Weapon skill damage +4%',}},}
        
    sets.precast.WS['Evisceration'] = {}

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head={ name="Herculean Helm", augments={'Accuracy+14 Attack+14','Weapon skill damage +4%','STR+7','Accuracy+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+10','Weapon skill damage +4%','STR+13',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'Accuracy+18 Attack+18','Weapon skill damage +1%','STR+7',}},
    feet={ name="Herculean Boots", augments={'Attack+25','Weapon skill damage +5%','STR+9',}},
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Rufescent Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},})
        
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {head={ name="Herculean Helm", augments={'Accuracy+14 Attack+14','Weapon skill damage +4%','STR+7','Accuracy+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','Weapon skill damage +4%','DEX+9','Attack+7',}},
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Meg. Jam. +2",
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Rufescent Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},})

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {}) --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','INT+8','Mag. Acc.+4',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','INT+10','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Gunslinger's Cape", augments={'Enmity-5','"Mag.Atk.Bns."+2','"Phantom Roll" ability delay -1','Weapon skill damage +4%',}},})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    sets.midcast.Cure = {}    

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- Occult Acumen Set
    sets.midcast['Dark Magic'] = {}

    sets.midcast.CorsairShot = {}

    sets.midcast.CorsairShot.STP = {}

    sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {})

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot.Enhance = {}

    -- Ranged gear
    sets.midcast.RA = {main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Nisroch Jerkin",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet="Meg. Jam. +2",
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Volley Earring",
    right_ear="Bladeborn Earring",
    left_ring="Ilabrat Ring",
    right_ring="Rajas Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {head="Meghanada Visor +1",
    body="Mummu Jacket +2",
    hands={ name="Adhemar Wrist. +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Ilabrat Ring",
    right_ring="Dingir Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},})

	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet="Meg. Jam. +2",
    neck="Iskur Gorget",
    waist="Kwahu Kachina Belt",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Ilabrat Ring",
    right_ring="Mummu Ring",
    back={ name="Camulus's Mantle", augments={'AGI+17','Rng.Acc.+20 Rng.Atk.+20','AGI+3','Weapon skill damage +10%',}},})

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {})

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {})

    sets.TripleShot = {} --27



    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = { head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Bathy Choker",
    waist="Flume Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Purity Ring",
    back="Moonbeam Cape",}

    sets.idle = { main="Fettering Blade",
    sub="Nusku Shield",
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Mummu Kecks +2",
    feet="Meg. Jam. +2",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Handler's Earring",
    right_ear="Thureous Earring",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%',}},}

    sets.idle.DT = set_combine(sets.idle, {})

    sets.idle.Town = set_combine(sets.idle, { head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Bathy Choker",
    waist="Flume Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Purity Ring",
    back="Moonbeam Cape",})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%
    
    -- No Magic Haste (74% DW to cap)
    sets.engaged = {head={ name="Herculean Helm", augments={'Accuracy+29','"Dual Wield"+3','DEX+6',}},
    body={ name="Adhemar Jacket", augments={'STR+10','DEX+10','Attack+15',}},
    hands="Floral Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back="Agema Cape",} -- 52%

    sets.engaged.LowAcc = set_combine(sets.engaged, {})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})

    sets.engaged.STP = set_combine(sets.engaged, {})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.LowHaste = {head={ name="Herculean Helm", augments={'Accuracy+29','"Dual Wield"+3','DEX+6',}},
    body={ name="Adhemar Jacket", augments={'STR+10','DEX+10','Attack+15',}},
    hands="Floral Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back="Agema Cape",} -- 52%

    sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {})

    sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {})

    sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, {})

    sets.engaged.STP.LowHaste = set_combine(sets.engaged.LowHaste, {})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.MidHaste = { head={ name="Herculean Helm", augments={'Accuracy+29','"Dual Wield"+3','DEX+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back="Agema Cape",} -- 41%

    sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {})

    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {})

    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, {})

    sets.engaged.STP.MidHaste = set_combine(sets.engaged.MidHaste, {})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.HighHaste = { head={ name="Herculean Helm", augments={'Accuracy+29','"Dual Wield"+3','DEX+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back="Agema Cape",} -- 37%

    sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {})

    sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {})

    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {})

    sets.engaged.STP.HighHaste = set_combine(sets.engaged.HighHaste, {})
        
    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = {head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back="Agema Cape",} -- 21%

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {})

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {})

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {})

    sets.engaged.STP.MaxHaste = set_combine(sets.engaged.MaxHaste, {})

    sets.LessDualWield = {back=gear.COR_TP_Cape}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = { head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Bathy Choker",
    waist="Flume Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Purity Ring",
    back="Moonbeam Cape",}
    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.MidHaste = set_combine(sets.engaged.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    end
    
    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if state.FlurryMode.value == 'Flurry II' and (buffactive[265] or buffactive[581]) then
            equip(sets.precast.RA.Flurry2)
        elseif state.FlurryMode.value == 'Flurry I' and (buffactive[265] or buffactive[581]) then
            equip(sets.precast.RA.Flurry1)
        end
    -- Equip obi if weather/day matches for WS.
    elseif spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
            if player.tp > 2900 then
                equip(sets.precast.WS['Leaden Salute'].FullTP)
            end    
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for Quick Draw.
    if spell.type == 'CorsairShot' then
        if (spell.element == world.day_element or spell.element == world.weather_element) and 
        (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            equip(sets.Obi)
        end
        if state.QDMode.value == 'Magic Enhance' then
            equip(sets.midcast.CorsairShot.Enhance)
        elseif state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
        end
    elseif spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
        equip(sets.TripleShot)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        customize_melee_set()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then           
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then           
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Gun.current == 'Death Penalty' then
        equip({ranged="Death Penalty"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Ataktos' then
        equip({ranged="Ataktos"})
--    elseif state.Gun.current == 'Armageddon' then
--        equip({ranged="Armageddon"})
    end

    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.DualWield.value == true and player.sub_job == 'NIN' then
        meleeSet = set_combine(meleeSet, sets.LessDualWield)
    end

    return meleeSet
end


-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.

function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current
    
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    
    msg = msg .. '/' ..state.RangedMode.current .. ' ]'

    if state.WeaponskillMode.value ~= 'Normal' then
        msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end
    
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

    msg = msg .. '[ ' .. state.HasteMode.value .. ' ][ ' .. state.FlurryMode.value .. ' ]'

    msg = msg .. '[ *'..state.Mainqd.current

    if state.UseAltqd.value == true then
        msg = msg .. '/'..state.Altqd.current
    end
    
    msg = msg .. '* '

    if state.QDMode.value == 'Magic Enhance' then
        msg = msg .. '(E)'
    end    

    msg = msg .. ']'
    
    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end        
        
        send_command('@input /ja "'..doqd..'" <t>')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

    classes.CustomMeleeGroups:clear()

    if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) or buffactive[580] == 2 then
            --add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
            state.DualWield:set()
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            --add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
            state.DualWield:set()
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            --add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
            state.DualWield:set()
        elseif (buffactive.march == 1 or buffactive[604]) then
            --add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
            state.DualWield:set()
        else
            state.DualWield:set(false)
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 or buffactive[580] == 2 then
            --add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
            state.DualWield:set()
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            --add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
            state.DualWield:set()
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            --add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
            state.DualWield:set()
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            --add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
            state.DualWield:set()
        else
            state.DualWield:set(false)
        end
    end
end


function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"]     = {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"]       = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"]       = {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 1')
end