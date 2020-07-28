--Built off of my BLU GS
---Thanks to various sources such as LS members and BlueGartr for the help building this GearSwap.
 
--Augmented Gear--
 
function get_sets()
    maps()
 
    HerculeanHelm = {}
    HerculeanHelm.Nuke = { name = "Herculean Helm", augments = { 'Mag. Acc.+18 "Mag.Atk.Bns."+18', '"Fast Cast"+1', 'INT+9', 'Mag. Acc.+9', '"Mag.Atk.Bns."+12', } }
    HerculeanHelm.DT = { name = "Herculean Helm", augments = { 'Attack+12', 'Phys. dmg. taken -4%', 'STR+9', 'Accuracy+8', } }
    HerculeanHelm.Refesh = { name = "Herculean Helm", augments = { 'Weapon skill damage +2%','Pet: Accuracy+11 Pet: Rng. Acc.+11','"Refresh"+2', } }
    HerculeanHelm.WSD = { name = "Herculean Helm", augments = { 'Attack+18','Weapon skill damage +4%','STR+10','Accuracy+12', } }
    HerculeanHelm.WSDAcc = { name = "Herculean Helm", augments = { 'Accuracy+23 Attack+23','Weapon skill damage +3%','STR+3','Accuracy+13','Attack+11', } }
    HerculeanHelm.Reso =  { name="Herculean Helm", augments = {'Accuracy+27','"Triple Atk."+3','STR+3',} }
   
    TaeonHead = {}
    TaeonHead.SIR = { name="Taeon Chapeau", augments = {'Spell interruption rate down -9%',} }
   
    HerculeanVest = {}
    HerculeanVest.WSD = { name="Herculean Vest", augments = {'Accuracy+25','Weapon skill damage +4%','STR+8',}}
    HerculeanVest.Phalanx = { name="Herculean Vest", augments = {'Accuracy+2','DEX+8','Phalanx +2','Accuracy+1 Attack+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
   
    TaeonBody = {}
    TaeonBody.FC = { name="Taeon Tabard", augments={'Accuracy+23','"Fast Cast"+5','HP+36',} }
    TaeonBody.SIR = { name="Taeon Tabard", augments = {'Spell interruption rate down -8%','STR+7 VIT+7'} }
   
    HerculeanGloves = {}
    HerculeanGloves.WSD = { name = "Herculean Gloves", augments = { 'Accuracy+21 Attack+21', 'Weapon skill damage +4%', 'Accuracy+9', 'Attack+10', } }
    HerculeanGloves.DT = { name = "Herculean Gloves", augments = { 'Accuracy+13', 'Damage taken-3%', 'AGI+1', 'Attack+5', } }
    HerculeanGloves.HighAcc = { name = "Herculean Gloves", augments = { 'Accuracy+23 Attack+23', '"Triple Atk."+2', 'DEX+15', 'Accuracy+11', 'Attack+13', } }
    HerculeanGloves.Refresh = { name = "Herculean Gloves", augments = { 'Spell interruption rate down -1%','"Repair" potency +4%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+16 "Mag.Atk.Bns."+16', } }
    HerculeanGloves.Crit = { name = "Herculean Gloves", augments = { 'Attack+23', 'Crit. hit damage +4%', 'DEX+8', 'Accuracy+11', } }
    HerculeanGloves.Reso = { name="Herculean Gloves", augments={'Accuracy+11 Attack+11','"Triple Atk."+2','STR+10','Accuracy+15','Attack+5', } }
    HerculeanGloves.Phalanx = { name="Herculean Gloves", augments={'INT+5','Pet: "Dbl. Atk."+3','Phalanx +4',}}
   
    HerculeanLegs = {}
    HerculeanLegs.DT = { name = "Herculean Trousers", augments = { 'Accuracy+22', 'Damage taken-2%', 'VIT+6', } }
    HerculeanLegs.WSD = { name = "Herculean Trousers", augments = { 'Attack+28', 'Weapon skill damage +3%', 'STR+10', 'Accuracy+9', } }
    HerculeanLegs.Magic = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','STR+4','Mag. Acc.+15', } }
    HerculeanLegs.Reso = { name="Herculean Trousers", augments={'Attack+21','"Triple Atk."+2','STR+6','Accuracy+13', } }
   
    LustFeet = {}
    LustFeet.DEXACC = { name="Lustra. Leggings +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}
   
    HerculeanFeet = {}
    HerculeanFeet.QA = { name = "Herculean Boots", augments = { 'AGI+4', '"Dbl.Atk."+2', 'Quadruple Attack +3', 'Accuracy+4 Attack+4', } }
    HerculeanFeet.TA = { name = "Herculean Boots", augments = { 'Accuracy+14 Attack+14', '"Triple Atk."+4', 'DEX+3', 'Accuracy+2', 'Attack+15' } }
    HerculeanFeet.DT = { name = "Herculean Boots", augments = { 'Accuracy+23', 'Damage taken -3%' } }
    HerculeanFeet.Idle = { name = "Herculean Boots", augments = { 'Crit. hit damage +1%','STR+10','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
    HerculeanFeet.CritDmg = { name = "Herculean Boots", augments = { 'Accuracy+28', 'Crit. hit damage +5%', 'DEX+9', } }
    HerculeanFeet.WSD = { name = "Herculean Boots", augments = { 'Attack+22', 'Weapon skill damage +4%', 'Accuracy+15', } }
    HerculeanFeet.DW = { name = "Herculean Boots", augments = { 'Accuracy+3 Attack+3','"Dual Wield"+4','AGI+3','Accuracy+14' } }
    HerculeanFeet.Phalanx = { name = "Herculean Boots", augments = {'Mag. Acc.+11 "Mag.Atk.Bns."+11','STR+6','Phalanx +2','Accuracy+12 Attack+12', } }
    HerculeanFeet.TH = { name="Herculean Boots", augments = { 'Mag. Acc.+17','"Blood Pact" ability delay -2','"Treasure Hunter"+1' } }
   
    Ogma = {}
    Ogma.TP = { name="Ogma's cape", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10', } }
    Ogma.Tank = { name="Ogma's cape", augments={ 'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10', } }
    Ogma.WSD = { name = "Ogma's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%', } }
    Ogma.Reso = { name="Ogma's cape", augments={ 'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10', } }
    Ogma.FC = { name = "Ogma's Cape", augments = { 'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10', } }
   
------End of Augmented Gear-----------------------------------------------------------------------------------------------------------------------------
    --Idle Sets--
    sets.Idle = {}
    sets.Idle.index = { 'DT', 'Standard', 'BuffDuration', }
    Idle_ind = 2
    sets.Idle.DT = {ammo="Staunch Tathlum",
    head="Meghanada Visor +2",
    body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
    hands="Turms Mittens",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Genmei Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",}
       
    sets.Idle.Standard = {ammo="Staunch Tathlum",
    head={ name="Rawhide Mask", augments={'Attack+15','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+15',}},
    body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
    hands="Turms Mittens",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Turms Leggings",
    neck="Sanctity Necklace",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Infused Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",}
   
    sets.Idle.BuffDuration = set_combine(sets.Idle.Standard, {head="Erilaz Galea +1",
    legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},})
   
   
 
        --Dat Waifu--
    sets.Idle.Town = set_combine(sets.Idle.Standard, {})
 
-------TP Sets-------------------------------------------
   
    ---------------------
    --OneHanded TP Sets--
    ---------------------
   
    sets.OneHandedTP = {}
    sets.OneHandedTP.index = { 'DualWield', 'CappedHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
    OneHandedTP_ind = 1
    --+31 needed with just Haste II
    sets.OneHandedTP.DualWield = {ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','"Triple Atk."+2','AGI+1','Accuracy+2',}},
    body={ name="Adhemar Jacket", augments={'STR+10','DEX+10','Attack+15',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
   
    sets.OneHandedTP.CappedHaste = {ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','"Triple Atk."+2','AGI+1','Accuracy+2',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
 
    sets.OneHandedTP.AccuracyLite = {ammo="Yamarang",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','"Triple Atk."+2','AGI+1','Accuracy+2',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
 
    sets.OneHandedTP.AccuracyMid = {ammo="Yamarang",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Lissome Necklace",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
 
    sets.OneHandedTP.AccuracyFull = {ammo="Yamarang",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Herculean Vest", augments={'Accuracy+30','"Triple Atk."+4',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','DEX+9',}},
    neck="Lissome Necklace",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
   
    ---------------------
    --TwoHanded TP Sets--
    ---------------------
   
    sets.TwoHandedTP = {}
    sets.TwoHandedTP.index = { 'CappedHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
    TwoHandedTP_ind = 1
 
    sets.TwoHandedTP.CappedHaste = {ammo="Ginsen",
    head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','STR+6','Accuracy+8',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','STR+5',}},
    neck="Lissome Necklace",
    waist="Ioskeha Belt",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
 
    sets.TwoHandedTP.AccuracyLite = {}
 
    sets.TwoHandedTP.AccuracyMid = {}
 
    sets.TwoHandedTP.AccuracyFull = {}
 
    -------------------
    --EpeoAM3 TP Sets--
    -------------------
   
    sets.EpeoAM3 = {}
    sets.EpeoAM3.index = { 'CappedHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
    EpeoAM3_ind = 1 -- In the same rule as the 2H TP Toggle so it toggles it at the same time
 
    sets.EpeoAM3.CappedHaste = set_combine(sets.TwoHandedTP.CappedHaste, {})
 
    sets.EpeoAM3.AccuracyLite = set_combine(sets.TwoHandedTP.AccuracyLite, {})
 
    sets.EpeoAM3.AccuracyMid = set_combine(sets.TwoHandedTP.AccuracyMid, {})
 
    sets.EpeoAM3.AccuracyFull = set_combine(sets.TwoHandedTP.AccuracyFull, {})
   
    -------------------
    --Tanking TP Sets--
    -------------------
   
    sets.TankingTP = {}
    sets.TankingTP.index = { 'Tank', 'TankHyb', 'DDHyb', 'TankHybAcc'}
    TankingTP_ind = 1
   
    sets.TankingTP.Tank = {ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
    body="Runeist's Coat +2",
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Genmei Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
    --Capped DT with DD Gear
    sets.TankingTP.TankHyb = {ammo="Staunch Tathlum",
    head="Meghanada Visor +2",
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','STR+5',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
    --Low DT with DD Gear
    sets.TankingTP.DDHyb = {ammo="Staunch Tathlum",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','STR+5',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Moonbeam Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
    --Mid DT and Acc
    sets.TankingTP.TankHybAcc = {ammo="Yamarang",
    head="Meghanada Visor +2",
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','STR+5',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Moonbeam Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
------End of TP--------------------------------------------------------------------------------------------------------------------
    --WS Sets--
    sets.WS = {}
   
    sets.Requiescat = {}
 
    sets.Requiescat.index = { 'Attack', 'Accuracy' }
    Requiescat_ind = 1
 
    sets.Requiescat.Attack = {ammo="Knobkierrie",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Meg. Jam. +2",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
 
    sets.Requiescat.Accuracy = {ammo="Knobkierrie",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Meg. Jam. +2",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
 
    sets.Resolution = {}
 
    sets.Resolution.index = { 'Attack', 'Accuracy' }
    Resolution_ind = 1
 
    sets.Resolution.Attack = {ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','STR+6','Accuracy+8',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
    neck="Anu Torque",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
 
    sets.Resolution.Accuracy = {}
 
    sets.SanguineBlade = {ammo="Seeth. Bomblet +1",
    head={ name="Herculean Helm", augments={'Spell interruption rate down -10%','Magic dmg. taken -2%','Damage taken-3%','Accuracy+16 Attack+16','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','INT+10','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Evasionist's Cape", augments={'Enmity+5','"Embolden"+9','"Dbl.Atk."+1','Damage taken-5%',}},}
   
    sets.FlashNova = {ammo="Seeth. Bomblet +1",
    head={ name="Herculean Helm", augments={'Spell interruption rate down -10%','Magic dmg. taken -2%','Damage taken-3%','Accuracy+16 Attack+16','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','INT+10','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Evasionist's Cape", augments={'Enmity+5','"Embolden"+9','"Dbl.Atk."+1','Damage taken-5%',}},}
 
    sets.SavageBlade = {}
 
    sets.SavageBlade.index = { 'Attack', 'Accuracy' }
    SavageBlade_ind = 1
    sets.SavageBlade.Attack = {ammo="Knobkierrie",
    head={ name="Herculean Helm", augments={'Accuracy+14 Attack+14','Weapon skill damage +4%','STR+7','Accuracy+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+10','Weapon skill damage +4%','STR+13',}},
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Attack+25','Weapon skill damage +5%','STR+9',}},
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
 
    sets.SavageBlade.Accuracy = {ammo="Knobkierrie",
    head={ name="Herculean Helm", augments={'Accuracy+14 Attack+14','Weapon skill damage +4%','STR+7','Accuracy+6',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','Weapon skill damage +4%','DEX+9','Attack+7',}},
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Attack+25','Weapon skill damage +5%','STR+9',}},
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
 
    sets.Dimidiation = {}
 
    sets.Dimidiation.index = { 'Attack', 'Accuracy', 'AccuracyHigh' }
    Dimidiation_ind = 1
 
    sets.Dimidiation.Attack = {ammo="Knobkierrie",
    head={ name="Herculean Helm", augments={'Attack+3','Weapon skill damage +5%','DEX+7','Accuracy+1',}},
    body={ name="Herculean Vest", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','DEX+6',}},
    hands="Meg. Gloves +2",
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
    neck="Lissome Necklace",
    waist="Grunfeld Rope",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
                   
    sets.Dimidiation.Accuracy = {}                          
                               
    sets.Dimidiation.AccuracyHigh = {}
   
    sets.BlackHalo = {}
 
    sets.BlackHalo.index = { 'Attack', 'Accuracy' }
    BlackHalo_ind = 1
    sets.BlackHalo.Attack = {}
 
    sets.BlackHalo.Accuracy = set_combine(sets.BlackHalo.Attack, {})
   
    sets.Realmrazer = {}
 
    sets.Realmrazer.index = { 'Attack', 'Accuracy' }
    Realmrazer_ind = 1
    sets.Realmrazer.Attack = {}
 
    sets.Realmrazer.Accuracy = set_combine(sets.Realmrazer.Attack, {})
------End of WS------------------------------------------------------------------------------------------
------Magic Sets---
    sets.BlueMagic = {}
 
    sets.BlueMagic.STR = set_combine(sets.Resolution.Attack, {
    })
 
    --Curing Sets--
    sets.Cures = {}
   
    sets.Cures.SelfCures = set_combine(sets.Cures, {})
    --Spell Interruption Rate--
    sets.SIR = {}
------End of Magic-------------------------------------------------------------------------------------
    --Enmity Set--
   
    sets.Enmity = { ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs="Eri. Leg Guards +1",
    feet="Ahosi Leggings",
    neck="Unmoving Collar +1",
    waist="Kasiri Belt",
    left_ear="Trux Earring",
    right_ear="Friomisi Earring",
    left_ring="Begrudging Ring",
    right_ring="Petrov Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
   
    --Utility Sets--
   
    sets.Utility = {}
 
    sets.Utility.TH = {}
   
    sets.Utility.AccDT = {}
   
    sets.Utility.MDTTank =  {}
   
    --Shell V on. Need 23% when 5/5 with pants, 21% with sheltered (24 with sheltered and trust)--
    sets.Utility.MDTV = {}
 
    --Shell II only--
    sets.Utility.MDTII = {}
 
    --No Shell--
    sets.Utility.MDTNO = {}
 
    --Telchine with proper ball busting augments is the best for magic evasion--
    sets.Utility.MEVA = {}
 
    ---------------------------------------------------------------
   
    sets.Utility.Charm = {}
   
    sets.Utility.Doom = {}
   
    --Enhancing Sets--
   
    sets.Enhancing = {}
   
    sets.Enhancing.Skill = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    hands="Runeist Mitons +1",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    left_ring="Stikini Ring",}
   
    sets.Enhancing.Duration = {head="Erilaz Galea +1",
    hands="Runeist Mitons +1",
    legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    left_ring="Stikini Ring",}
   
    sets.Enhancing.Phalanx = set_combine(sets.Enhancing.Duration, {ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
    body={ name="Taeon Tabard", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','"Fast Cast"+4','Phalanx +3',}},
    hands={ name="Herculean Gloves", augments={'STR+13','"Fast Cast"+1','Phalanx +5','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','Phalanx +5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    feet={ name="Herculean Boots", augments={'Pet: "Mag.Atk.Bns."+23','Pet: DEX+7','Phalanx +4','Accuracy+8 Attack+8','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},})
   
    sets.Enhancing.Refresh = set_combine(sets.Enhancing.Duration, {ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    waist="Gishdubar Sash",
    right_ring="Evanescence Ring",})
   
    sets.Enhancing.Regen = set_combine(sets.Enhancing.Duration, {ammo="Staunch Tathlum",
    head="Rune. Bandeau +1",
    right_ring="Evanescence Ring",})
   
    sets.Enhancing.ProShell = set_combine(sets.Enhancing.Duration, {})
   
    sets.Enhancing.Foil = set_combine(sets.Enmity, {})
   
    --Job Ability Sets--
 
    sets.JA = {}
   
    sets.JA.Lunge = {}
 
    sets.JA.Sforzo = set_combine(sets.Enmity, {body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},})
 
    sets.JA.Swordplay = set_combine(sets.Enmity, {})
   
    sets.JA.Vallation = set_combine(sets.Enmity, {body="Runeist's Coat +2",
    legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
    })
   
    sets.JA.Pflug = set_combine(sets.Enmity, {})
   
    sets.JA.Valiance = set_combine(sets.Enmity, {body="Runeist's Coat +2",
    legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
    })
   
    sets.JA.Embolden = set_combine(sets.Enmity, {})
   
    sets.JA.Pulse = set_combine(sets.Enmity, {})
   
    sets.JA.Gambit = set_combine(sets.Enmity, {hands="Runeist Mitons +1",})
   
    sets.JA.Battuta = set_combine(sets.Enmity, {head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},})
   
    sets.JA.Rayke = set_combine(sets.Enmity, {})
   
    sets.JA.Liement = set_combine(sets.Enmity, {})
    --One For All is HP * .2 = Magic Damage Reduction--
    sets.JA.One = set_combine(sets.Enmity, {})
   
    sets.JA.Subterfuge = set_combine(sets.Enmity, {})
   
    ---SAM---
    sets.JA.Meditate = set_combine(sets.Enmity, {})
   
    ---WAR---
    sets.JA.Provoke = set_combine(sets.Enmity, {})
 
	sets.JA.Sentinal = set_combine{sets.Enmity, {}}
 
    sets.JA.Warcry = set_combine(sets.Enmity, {})
   
    --Precast Sets--
    sets.precast = {}
 
    sets.precast.FastCast = {ammo="Sapience Orb",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Taeon Tabard", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','"Fast Cast"+4','Phalanx +3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +1",
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Voltsurge Torque",
    waist="Siegel Sash",
    left_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",}
 
    sets.precast.FastCast.Standard = {ammo="Sapience Orb",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Taeon Tabard", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','"Fast Cast"+4','Phalanx +3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +1",
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Voltsurge Torque",
    waist="Siegel Sash",
    left_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",}
   
    sets.precast.FastCast.Enhancing = set_combine(sets.precast.FastCast.Standard, {
        legs = "Futhark Trousers +1"
    })
end
 
---End of Gear---------------------------------------------------------------------------------------------------------------------------------------------------------
 
-------------------------------------
---------                   ---------
------                         ------
---         Start of Maps         ---
------                         ------
---------                   ---------
-------------------------------------
 
-------------------------
--   BLU Spells List   --
-------------------------
 
TwoHandedWeapons = S {
    'Aettir', 'Epeolatry', 'Lionheart', 'Beheader +1', 'Takoba', 'Zulqifar', 'Bidenhander',
    'Montante', 'Montante +1', 'Humility', 'Nibiru Faussar', 'Macbain', 'Soulcleaver',
    'Kaqulijaan', 'Beorc Sword', 'Trial Blade', 'Sword of Trials', 'Irradiance Blade',
    'Greatsword', 'Parashu'
}
 
-------------------------
--   BLU Spells List   --
-------------------------
 
function maps()
    PhysicalSpells = S {
        'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
        'Power Attack', 'Screwdriver', 'Sickle Slash', 'Smite of Rage',
        'Terror Touch', 'Battle Dance', 'Claw Cyclone', 'Foot Kick', 'Grand Slam',
        'Sprout Smack', 'Helldive', 'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Uppercut'
    }
   
    BlueMagic_Buffs = S {
        'Refueling',
    }
 
    BlueMagic_Healing = S {
        'Healing Breeze', 'Pollen', 'Wild Carrot'
    }
 
    BlueMagic_Enmity = S {
        'Blank Gaze', 'Jettatura', 'Geist Wall', 'Sheep Song', 'Soporific', 'Cocoon', 'Stinking Gas'
    }
   
    RUNMagic_Enmity = S {
        'Flash'
    }
end
 
------------------------
--   Town Gear List   --
------------------------
 
Town = S {
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
    "Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
    "Aht Urhgan Whitegate", "Nashmau",
    "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold",
    "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}
 
---End of Maps----------------------------------------------------------------------------------------------------------------------------------------------------------
 
function msg(str)
    send_command('@input /echo <----- ' .. str .. ' ----->')
end
 
------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------
function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (21, 'Your lockstyle looks like shit, and you should feel bad')
    add_to_chat (55, 'You are on '..('RUN '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
--  add_to_chat (60, 'Eat tendies in moderation')
end
 
--Page, Book--
set_macros(1,10)
--Use the Lockstyle Number--
set_style(98)
------------------------------------------
-- Variables
------------------------------------------
SetLocked = false --Used to Check if set is locked before changing equipment
LockedEquipSet = {} --Placeholder to store desired lock set
LockGearSet = {}
equipSet = {} --Currently Equiped Gearset
LockGearIndex = false
LockGearIndex = false
TargetDistance = 0
TH = false -- Defaults
SIR = false -- Spell Interruption Rate
TankingTP = true
TwoHandedTP = true -- TP set order, looks for Tanking TP set before 2H TP before 1H DW TP.
------------------------------------------
-- Windower Hooks              --
------------------------------------------
 
function buff_change(n, gain, buff_table)
    local name
    name = string.lower(n)
    if S{"terror","petrification","sleep","stun"}:contains(name) then
        if gain then
            ChangeGear(sets.TankingTP.Tank)
        elseif not has_any_buff_of({"terror","petrification","sleep","stun"}) then
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    if TankingTP == true then
                        ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
                    elseif EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                    elseif TwoHandedTP == true then
                        ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                    else
                        ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
                    end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "doom" then
        if gain then
            ChangeGear(sets.Utility.Doom)
            send_command('@input /p Doomed {~o~:} !')
            disable('ring1','ring2','waist')
        else
            if player.status == 'Engaged' then
                if LockGearIndex then
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    if TankingTP == true then
                        ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
                    elseif EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                    elseif TwoHandedTP == true then
                        ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                    else
                        ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
                    end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "charm" then
        if gain then
            send_command('@input /p Charmed {<3_<3:} !')
        else
            send_command('@input /p Charm is off {~_^}')
        end
    elseif name == "weakness" then
        if gain then
            enable('ring1','ring2','waist')
        end
    elseif name ==  "embolden" then
        if gain then
        ChangeGear(set_combine(equipSet, {back="Evasionist's Cape"}))
        else
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    if TankingTP == true then
                        ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
                    elseif EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                    elseif TwoHandedTP == true then
                        ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                    else
                        ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
                    end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "hasso" then
        if gain then
        do return end
    else
        send_command('gs c -cd Hasso Lost!')
        end
    end
   
    if name == "aftermath: lv.3" and player.equipment.main == 'Epeolatry' then -- Mythic AM3
        if gain then
            EpeoAM3 = true
            send_command('timers create "Mythic AM3" 180 down')
             if LockGearIndex then
                ChangeGear(LockGearSet)
            elseif TankingTP == true then
                ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
            else
                ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
            end
        else
            EpeoAM3 = false
            send_command('timers delete "Mythic AM3";gs c -cd AM3 Lost!!!')
        end
    end
end
 
------------------------------------------
--               Binds                  --
------------------------------------------
send_command('bind f9 gs c toggle TP set') --This means if you hit f9 it toggles the sets
send_command('bind f10 gs c toggle Reso set')
send_command('bind f11 gs c toggle Dimidiation set')
send_command('bind f12 gs c toggle Idle set')
send_command('bind ^f8 gs c toggle SIR') -- Turns Spell Interruption Rate set on
send_command('bind ^f9 input /ws "Resolution" <t>') --^ means cntrl
send_command('bind ^f10 input /ws "Dimidiation" <t>')
send_command('bind ^f11 input /ws "Ground Strike" <t>')
send_command('bind ^f12 input /ws "Savage Blade" <t>')
send_command('bind !f7 gs c toggle TankingTP set') --! means alt, this exists only for toggling outside of this mode being active, otherwise f9
send_command('bind !f8 gs c toggle TankingTP') --! turns tanking tp off
send_command('bind !f9 gs c toggle backwards')
send_command('bind !f10 gs c toggle Other WS set') -- Changes affiliated ws sets
send_command('bind !f11 --Available--')
send_command('bind !f12 gs c lockgearindex')
 
send_command('bind !e input /item "Echo Drops" <me>')
send_command('bind !r input /item "Remedy" <me>')
send_command('bind !p input /item "Panacea" <me>')
send_command('bind !h input /item "Holy Water" <me>')
send_command('bind !w input /equip ring2 "Warp Ring"; /echo Warping; wait 11; input /item "Warp Ring" <me>;')
send_command('bind !q input /equip ring2 "Dim. Ring (Holla)"; /echo Reisenjima; wait 11; input /item "Dim. Ring (Holla)" <me>;')
send_command('bind !t gs c toggle TH') -- alt + t toggles TH mode
 
--Unload Binds
function file_unload()
    send_command('unbind ^f9')
    send_command('unbind ^f10')
    send_command('unbind ^f11')
    send_command('unbind ^f12')
    send_command('unbind !f9')
    send_command('unbind !f10')
    send_command('unbind !f11')
    send_command('unbind !f12')
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f11')
    send_command('unbind f12')
   
    send_command('unbind !e')
    send_command('unbind !r')
    send_command('unbind !p')
    send_command('unbind !h')
    send_command('unbind !w')
    send_command('unbind !q')
    send_command('unbind !t')
end
 
------------------------------------------
-- Console Commands             --
------------------------------------------
function self_command(command)
    if command == 'togglelock' then
        if SetLocked == false then
            msg("Equipment Set LOCKED!")
        else
            SetLocked = false
            msg("Equipment Set UNLOCKED!")
        end
    elseif command == 'lockgearindex' then
        if LockGearIndex == false then
            LockGearIndex = true
            LockGearSet = {
                ammo = player.equipment.ammo,
                head = player.equipment.head,
                neck = player.equipment.neck,
                ear1 = player.equipment.left_ear,
                ear2 = player.equipment.right_ear,
                body = player.equipment.body,
                hands = player.equipment.hands,
                ring1 = player.equipment.left_ring,
                ring2 = player.equipment.right_ring,
                back = player.equipment.back,
                waist = player.equipment.waist,
                legs = player.equipment.legs,
                feet = player.equipment.feet
            }
            msg("Gear Index Locked")
        else
            LockGearIndex = false
            msg("Gear Index Unlocked")
            if player.status == 'Engaged' then
                if TankingTP == true then
                    ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
                elseif EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                elseif TwoHandedTP == true then
                    ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                else
                    ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
                end
            else
                ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
            end
        end
    end
    if command == 'toggle TP set' then
        if TankingTP == true then
            TankingTP_ind = TankingTP_ind + 1
            if TankingTP_ind > #sets.TankingTP.index then TankingTP_ind = 1 end
            send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
            if player.status == 'Engaged' then
                ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
            end
        elseif TankingTP == false then
            if TwoHandedTP == true then
                TwoHandedTP_ind = TwoHandedTP_ind + 1
                EpeoAM3_ind = EpeoAM3_ind +1
                if TwoHandedTP_ind > #sets.TwoHandedTP.index then TwoHandedTP_ind = 1 end
                if EpeoAM3_ind > #sets.EpeoAM3.index then EpeoAM3_ind = 1 end
                send_command('@input /echo <----- 2H TP Set changed to ' .. sets.TwoHandedTP.index[TwoHandedTP_ind] .. ' ----->')  
                if player.status == 'Engaged' then
                    if EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                    else
                        ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                    end
                end
            elseif TwoHandedTP == false then
                OneHandedTP_ind = OneHandedTP_ind + 1
                if OneHandedTP_ind > #sets.OneHandedTP.index then OneHandedTP_ind = 1 end
                send_command('@input /echo <----- 1H TP Set changed to ' .. sets.OneHandedTP.index[OneHandedTP_ind] .. ' ----->')
                if player.status == 'Engaged' then
                    ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
                end
            end    
        end
    elseif command == 'toggle Idle set' then
        Idle_ind = Idle_ind + 1
        if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
        send_command('@input /echo <----- Idle Set changed to ' .. sets.Idle.index[Idle_ind] .. ' ----->')
        ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
    elseif command == 'toggle Dimidiation set' then
        Dimidiation_ind = Dimidiation_ind + 1
        if Dimidiation_ind > #sets.Dimidiation.index then Dimidiation_ind = 1 end
        send_command('@input /echo <----- Dimidiation Set changed to ' .. sets.Dimidiation.index[Dimidiation_ind] .. ' ----->')
    elseif command == 'toggle Reso set' then
        Resolution_ind = Resolution_ind + 1
        if Resolution_ind > #sets.Resolution.index then Resolution_ind = 1 end
        send_command('@input /echo <----- Resolution Set changed to ' .. sets.Resolution.index[Resolution_ind] .. ' ----->')
    elseif command == 'toggle Other WS set' then
        SavageBlade_ind = SavageBlade_ind + 1
        Requiescat_ind = Requiescat_ind + 1
        BlackHalo_ind = BlackHalo_ind + 1
        Realmrazer_ind = Realmrazer_ind + 1
        if SavageBlade_ind > #sets.SavageBlade.index then SavageBlade_ind = 1 end
        if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
        if BlackHalo_ind > #sets.BlackHalo.index then BlackHalo_ind = 1 end
        if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
        send_command('@input /echo <----- Sword/Club WS Set changed to ' .. sets.SavageBlade.index[SavageBlade_ind] .. ' ----->')
    elseif command == 'toggle TankingTP set' then
        TankingTP_ind = TankingTP_ind + 1
        if TankingTP_ind > #sets.TankingTP.index then TankingTP_ind = 1 end
        send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
        if player.status == 'Engaged' then
            ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
        end
    elseif command == 'toggle TankingTP' then
        if TankingTP == true then
            TankingTP = false
            send_command('@input /echo <----- Tanking TP: [Off] ----->')
        else
            TankingTP = true
            send_command('@input /echo <----- Tanking TP: [On] ----->')
        end
        status_change(player.status)
    elseif command == 'toggle TwoHandedTP' then
        if TwoHandedTP == true then
            TwoHandedTP = false
            send_command('@input /echo <----- 2H TP: [Off] ----->')
        else
            TwoHandedTP = true
            send_command('@input /echo <----- 2H TP: [On] ----->')
        end
        status_change(player.status)
    elseif command == 'toggle SIR' then
        if SIR == true then
            SIR = false
            send_command('@input /echo <----- Spell Interruption Rate: [Off] ----->')
        else
            SIR = true
            send_command('@input /echo <----- Spell Interruption Rate: [On] ----->')
        end
        status_change(player.status)
    elseif command == 'toggle TH' then
        if TH == true then
            TH = false
            send_command('@input /echo <----- Treasure Hunter TP: [Off] ----->')
        else
            TH = true
            send_command('@input /echo <----- Treasure Hunter TP: [On] ----->')
        end
        status_change(player.status)
    elseif command == 'toggle backwards' then
        if TankingTP == true then
            TankingTP_ind = TankingTP_ind -1
            if TankingTP_ind == 0 then
                TankingTP_ind = #sets.TankingTP.index
            end
            send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
            if player.status == 'Engaged' then
                ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
            end
        elseif TankingTP == false then
            if TwoHandedTP == true then
                TwoHandedTP_ind = TwoHandedTP_ind -1
                EpeoAM3_ind = EpeoAM3_ind -1
                if TwoHandedTP_ind == 0 then
                    TwoHandedTP_ind = #sets.TwoHandedTP.index
                end
                if EpeoAM3_ind == 0 then
                    EpeoAM3_ind = #sets.EpeoAM3.index
                end
                send_command('@input /echo <----- 2H TP Set changed to ' .. sets.TwoHandedTP.index[TwoHandedTP_ind] .. ' ----->')  
                if player.status == 'Engaged' then
                    if EpeoAM3 == true then
                        ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
                    else
                        ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
                    end
                end
            elseif TwoHandedTP == false then
                OneHandedTP_ind = OneHandedTP_ind -1
                if OneHandedTP_ind == 0 then
                    OneHandedTP_ind = #sets.OneHandedTP.index
                end
                if player.status == 'Engaged' then
                    ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[TP_ind]])
                end
            end
        end
    elseif command == 'ZoneChange' then
        IdleState()
    elseif string.sub(command, 0, 4) == '-cd ' then     --If the first 4 characters of the command are '-cd '
        add_to_chat (30, string.sub(command, 5, string.len(command)))      --add everything after '-cd ' to a message in the chat
    end
end
 
------------------------------------------
-- Character States                     --
------------------------------------------
function IdleState()
    if LockGearIndex then
        ChangeGear(LockGearSet)
    elseif not LockGearIndex then
        ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
    end
   
    if player.mpp <= 50 and Idle_ind == 2 then --standard idle
        ChangeGear({head = HerculeanHelm.Refesh, waist = "Fucho-no-obi"})
    elseif player.mpp <= 50 and Idle_ind == 3 then -- buff duration
        ChangeGear({waist = "Fucho-no-obi"})
    end
       
    if Town:contains(world.area) and player.mpp < 75 then
        ChangeGear(set_combine(sets.Idle.Town, sets.Idle.Refresh))
        elseif Town:contains(world.area) then
        ChangeGear(sets.Idle.Town)
    end
   
    if buffactive['Embolden'] then
        ChangeGear(set_combine(equipSet, {back="Evasionist's Cape"}))
    end
   
end
 
windower.raw_register_event('zone change',function()
windower.send_command('@wait 9; input //gs c ZoneChange')
end)
 
function RestingState()
 
end
 
function EngagedState()
    if LockGearIndex then
        ChangeGear(LockGearSet)
    elseif not LockGearIndex then
        if TankingTP == true then
            ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
        elseif buffactive["Aftermath: Lv.3"] and player.equipment.main == 'Epeolatry' then --am3
            EpeoAM3 = true
            ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])  
        elseif TwoHandedTP == true then
            EpeoAM3 = false
            ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
        else
            EpeoAM3 = false
            ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
        end
    end
end
 
-----------------------------
--      Spell control      --
-----------------------------
unusable_buff = {
    spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
 --return true if spell/ability is unable to be used at this time
function spell_control(spell)
    if spell.type == "Item" then
        return false
    --Stops spell if you do not have a target
    elseif spell.target.name == nil and not spell.target.raw:contains("st") then
        return true
    --Stops spell if a blocking buff is active
    elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
        return true
    elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
        return true
    elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
        msg("Weapon Skill Canceled, Can't")
        return true
    elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell)
      or not check_recast('spell',spell.recast_id)) then
        return true
    --Stops spell if you do not have enuf mp/tp to use
    elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) then
        msg("Spell Canceled, Not Enough MP")
        return true
    end
    --Calculate how many finishing moves your char has up to 6
    local fm_count = 0
    for i, v in pairs(buffactive) do
        if tostring(i):startswith('finishing move') or tostring(i):startswith('?????????') then
            fm_count = tonumber(string.match(i, '%d+')) or 1
        end
    end
    --Stops flourishes if you do not have enough finishing moves
    local min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
                                   ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
    if min_fm_for_flourishes[spell.en] then
        if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
            return true
        end
    end
    --Reomves Sneak when casting Spectral Jig
    if spell.en == 'Spectral Jig' then
        send_command('cancel 71')
    end
    if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
        return true
    end
    if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
        msg("Weapon Skill Canceled  Target Out of Range")
        return true
    end
end
 
------------------------------------------
--              Precast                 --
------------------------------------------
function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then return true end
    end
end
--JA Sets--
function pc_JA(spell, act)
    if spell.english == 'Elemental Sforzo' then
        ChangeGear(sets.JA.Sforzo)
    elseif spell.english == 'Swordplay' then
        ChangeGear(sets.JA.Swordplay)
    elseif spell.english == 'Vallation' or spell.english == 'Valiance' then
        ChangeGear(sets.JA.Vallation)
    elseif spell.english == 'Pflug' then
        ChangeGear(sets.JA.Pflug)
    elseif spell.english == 'Embolden' then
        ChangeGear(sets.JA.Embolden)
    elseif spell.english == 'Vivacious Pulse' then
        ChangeGear(sets.JA.Pulse)
    elseif spell.english == 'Gambit' then
        ChangeGear(sets.JA.Gambit)
    elseif spell.english == 'Battuta' then
        ChangeGear(sets.JA.Battuta)
    elseif spell.english == 'Rayke' then
        ChangeGear(sets.JA.Rayke)
    elseif spell.english == 'Liement' then
        ChangeGear(sets.JA.Liement)
    elseif spell.english == 'One For All' or spell.english == 'Sentinel' then
        ChangeGear(sets.JA.One)
    elseif spell.english == 'Odyllic Subterfuge' then
        ChangeGear(sets.JA.Subterfuge)
    elseif spell.english == 'Lunge' or spell.english == 'Swipe' then
        ChangeGear(sets.JA.Lunge)
    elseif spell.english == 'Meditate' then
        ChangeGear(sets.JA.Meditate)
    elseif spell.english == 'Provoke' then
        ChangeGear(sets.JA.Provoke)
    elseif spell.english == 'Warcry' then
        ChangeGear(sets.JA.Warcry)
	end
   
    --These spells can't override each other, and must be canceled--
    if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
        if buffactive['Valiance'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(535)
        elseif buffactive['Vallation'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(531)
        elseif buffactive['Liement'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(537)
        end
    end
 
    IgnoreWS = S { "Sanguine Blade", "Red Lotus Blade", "Flash Nova", "Realmrazer" }  -- Excluded from Moonshade TP override rule.
    BrutalWS = S { "Resolution"}
    STRWS = S {"Vorpal Blade", "Fell Cleave", "Circle Blade", "Swift Blade", "Shockwave", "Ground Strike" } -- Resolution Set bums
   
   
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Requiescat' then
            ChangeGear(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
        elseif spell.english == 'Dimidiation' or spell.english == 'Ground Strike' then
            ChangeGear(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_ind]])
        elseif spell.english == 'Resolution' or STRWS:contains(spell.english) then
            ChangeGear(sets.Resolution[sets.Resolution.index[Resolution_ind]])
        elseif spell.english == 'Savage Blade' then
            ChangeGear(sets.SavageBlade[sets.SavageBlade.index[SavageBlade_ind]])
        elseif spell.english == 'Realmrazer' then
            ChangeGear(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
        elseif spell.english == 'Black Halo' or 'Judgement' then
            ChangeGear(sets.BlackHalo[sets.BlackHalo.index[BlackHalo_ind]])
        elseif spell.english == 'Flash Nova' or spell.english == 'Red Lotus Blade' then
            ChangeGear(sets.FlashNova)
        elseif spell.english == 'Sanguine Blade' then
            ChangeGear(sets.SanguineBlade)
        end
        if player.tp > 2025 and player.equipment.main == 'Lionheart' and buffactive['TP Bonus'] then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2275 and player.equipment.main == 'Lionheart' then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2550 and buffactive['TP Bonus'] then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2775 then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        end
    end
 
    if string.find(spell.english,'Step') then
        ChangeGear(set_combine(sets.TwoHandedTP.AccuracyFull, sets.Utility.TH))
    elseif spell.english == 'Animated Flourish' then
        ChangeGear(sets.Enmity)
    end
end
 
function pc_Magic(spell, act)
    if spell.skill == 'Enhancing Magic' then
        ChangeGear(sets.precast.FastCast.Enhancing)
    else
        ChangeGear(sets.precast.FastCast.Standard)
     end
end
 
function pc_Item(spell, act)
end
 
 
------------------------------------------
-- Midcast                 --
------------------------------------------
function mc_JA(spell, act)
end
 
function mc_Magic(spell, act)
    if spell.skill == 'Enhancing Magic' then
        if buffactive['Embolden'] then
            if spell.english == 'Phalanx' then
                ChangeGear(set_combine(sets.Enhancing.Phalanx, {back="Evasionist's Cape"}))
            elseif string.find(spell.english,'Shell') or string.find(spell.english,'Protect') then
                ChangeGear(set_combine(sets.Enhancing.ProShell, {back="Evasionist's Cape"}))
            else
                ChangeGear(set_combine(sets.Enhancing.Duration, {back="Evasionist's Cape"}))
            end
        elseif spell.english == 'Refresh' then
            ChangeGear(sets.Enhancing.Refresh)
        elseif string.find(spell.english,'Regen')then
            ChangeGear(sets.Enhancing.Regen)
        elseif string.find(spell.english,'Bar') or spell.english=="Temper" then
            ChangeGear(sets.Enhancing.Skill)
        elseif spell.english == 'Phalanx' then
            ChangeGear(sets.Enhancing.Phalanx)
        elseif spell.english == 'Foil' then
            ChangeGear(sets.Enhancing.Foil)
        elseif string.find(spell.english,'Shell') or string.find(spell.english,'Protect') then
            ChangeGear(sets.Enhancing.ProShell)
        else
            ChangeGear(sets.Enhancing.Duration)
        end
    elseif spell.skill == 'Healing Magic' then
        if spell.target and spell.target.type == 'SELF' then
            ChangeGear(sets.Cures.SelfCures)
        else
            ChangeGear(sets.Cures)
        end
    end
 
    if BlueMagic_Enmity:contains(spell.english) then
        ChangeGear(sets.Enmity)
    elseif BlueMagic_Buffs:contains(spell.english) then
        ChangeGear(sets.TankingTP.Tank)
    elseif PhysicalSpells:contains(spell.english) then
        ChangeGear(sets.BlueMagic.STR)
    elseif BlueMagic_Healing:contains(spell.english) then
        if spell.target and spell.target.type == 'SELF' then
            ChangeGear(sets.Cures.SelfCures)
        else
            ChangeGear(sets.Cures)
        end
    elseif RUNMagic_Enmity:contains(spell.english) then
        ChangeGear(sets.Enmity)
    end
   
end
 
function mc_Item(spell, act)
end
 
 
------------------------------------------
-- After Cast               --
------------------------------------------
function ac_JA(spell)
end
 
function ac_Magic(spell)
end
 
function ac_Item(spell)
end
 
function ac_Global()
    if LockGearIndex == true then
        ChangeGear(LockGearSet)
        msg("Lock Gear is ON -- Swapping Gear")
    else
        if player.status == 'Engaged' then
            EngagedState()
        else
            IdleState()
        end
    end
end
 
------------------------------------------
-- Framework Core            --
------------------------------------------
function status_change(new, old)
    if new == 'Idle' then
        IdleState()
    elseif new == 'Resting' then
        RestingState()
    elseif new == 'Engaged' then
        EngagedState()
    end
   
    if player.status == 'Engaged' and TH == true then
        ChangeGear(set_combine(equipSet, sets.Utility.TH))         
    end
   
    if S{1,4,6,7,8,10,12}:contains(gearswap.res.items:with('en', player.equipment.main).skill) then --Checks mainhand weapon for TP set choice. See below for notes on #s
        TwoHandedTP = true
    else
        TwoHandedTP = false
    end
   
end
 
--Numbers in the 1H 2H TP mode rule:
--1 = Hand-to-Hand
--2 = Dagger
--3 = Sword
--4 = Great Sword
--5 = Axe
--6 = Great Axe
--7 = Scythe
--8 = Polearm
--9 = Katana
--10 = Great Katana
--11 = Club
--12 = Staff
 
 
function precast(spell, act)
    if spell_control(spell) then
        cancel_spell()
        return
    end
    if spell.action_type == 'Ability' then
        pc_JA(spell, act)
    elseif spell.action_type == 'Magic' then
        pc_Magic(spell, act)
    else
        pc_Item(spell, act)
    end
end
 
function midcast(spell, act)
    IgnoreSIRSpell = S { "Phalanx", "Temper"}  -- Excluded from Spell Interruption Rate override rule.
    if spell.action_type == 'Ability' then
        mc_JA(spell, act)
    elseif spell.action_type == 'Magic' then
        if SIR == true then
            if IgnoreSIRSpell:contains(spell.english) and not string.find(spell.english,'Bar') then
                mc_Magic(spell, act)
            else
                ChangeGear(sets.SIR)
            end
        else
            mc_Magic(spell, act)
        end
    else
        mc_Item(spell, act)
    end
end
 
function aftercast(spell, act)
    if spell.action_type == 'Ability' then
        ac_JA(spell)
    elseif spell.action_type == 'Magic' then
        ac_Magic(spell)
    else
        ac_Item(spell)
    end
    ac_Global()
   
    --Countdowns--
    if not spell.interrupted then
        if spell.english == "Meditate" then
            send_command('wait 170;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        elseif spell.english == "Sekkanoki" then
            send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        elseif spell.english == "Swordplay" then
            send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        elseif spell.english == "One for All" then
            send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        elseif spell.english == "Battuta" then
            send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        elseif spell.english == "Liement" then
            send_command('wait 170;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
        end
    end
   
    if S{4,6,7,8,10,12}:contains(gearswap.res.items:with('en', player.equipment.main).skill) then --Checks mainhand weapon for TP set choice. See bottom for notes on #s
        TwoHandedTP = true
    else
        TwoHandedTP = false
    end
   
end
   
   
function ChangeGear(GearSet)
    equipSet = GearSet
    equip(GearSet)
end
 
function LockGearSet(GearSet)
    LockedEquipSet = GearSet
    equip(GearSet)
    SetLocked = true
end
 
function UnlockGearSet()
    locked = false
    equip(equipSet)
end