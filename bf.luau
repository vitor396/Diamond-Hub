local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rizeniii/diamond/refs/heads/main/ch.lua"))()

local Window = redzlib:MakeWindow({
  Title = "Diamond Hub",
  SubTitle = "",
  SaveFolder = "dex.lua"
})

local Tab1 = Window:MakeTab({"Main", "Sword"})

Tab1:AddDiscordInvite({
    Name = "Diamond Hub",
    Logo = "rbxassetid://122340386055007",
    Invite = "https://discord.gg/YKAWnHKJGW",
})

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

_G.AutoFarm = _G.AutoFarm or false
_G.FarmSpeed = 350
_G.AttackMode = "Default"
_G.BringMonster = true

local Mon, Qname, Qdata, NameMon, PosM, PosQ, PosMon
local TeamSelf = player.Team and player.Team.Name or "Pirates"
local World1 = true

local autoFarmConnection
local noclipConnection
local floatConnection
local bringMonsterConnection
local currentTarget = nil
local StartBring = false
local MonFarm = ""

World1 = game["PlaceId"] == 2753915549
World2 = game["PlaceId"] == 4442272183
World3 = game["PlaceId"] == 7449423635

local function CheckQuest()
    local x = player.Data.Level.Value
    if World1 then
        if x >= 1 and x <= 9 then
            if tostring(TeamSelf) == "Marines" then
                Mon = "Trainee"
                Qname = "MarineQuest"
                Qdata = 1
                NameMon = "Trainee"
                PosM = CFrame.new(-2709.67944, 24.5206585, 2104.24585)
                PosQ = CFrame.new(-2709.67944, 24.5206585, 2104.24585)
            else
                Mon = "Bandit"
                Qdata = 1
                Qname = "BanditQuest1"
                NameMon = "Bandit"
                PosM = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125)
                PosQ = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125)
            end
        elseif x >= 10 and x <= 14 then
            Mon = "Monkey"
            Qdata = 1
            Qname = "JungleQuest"
            NameMon = "Monkey"
            PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            PosM = CFrame.new(-1448.5180664062, 67.853012084961, 11.465796470642)
        elseif x >= 15 and x <= 29 then
            Mon = "Gorilla"
            Qdata = 2
            Qname = "JungleQuest"
            NameMon = "Gorilla"
            PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            PosM = CFrame.new(-1129.8836669922, 40.46354675293, -525.42370605469)
        elseif x >= 30 and x <= 39 then
            Mon = "Pirate"
            Qdata = 1
            Qname = "BuggyQuest1"
            NameMon = "Pirate"
            PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            PosM = CFrame.new(-1103.5134277344, 13.752052307129, 3896.0910644531)
        elseif x >= 40 and x <= 59 then
            Mon = "Brute"
            Qdata = 2
            Qname = "BuggyQuest1"
            NameMon = "Brute"
            PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            PosM = CFrame.new(-1140.0837402344, 14.809885025024, 4322.9213867188)
        elseif x >= 60 and x <= 74 then
            Mon = "Desert Bandit"
            Qdata = 1
            Qname = "DesertQuest"
            NameMon = "Desert Bandit"
            PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359)
            PosM = CFrame.new(924.7998046875, 6.4486746788025, 4481.5859375)
        elseif x >= 75 and x <= 89 then
            Mon = "Desert Officer"
            Qdata = 2
            Qname = "DesertQuest"
            NameMon = "Desert Officer"
            PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359)
            PosM = CFrame.new(1608.2822265625, 8.6142244338989, 4371.0073242188)
        elseif x >= 90 and x <= 99 then
            Mon = "Snow Bandit"
            Qdata = 1
            Qname = "SnowQuest"
            NameMon = "Snow Bandit"
            PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            PosM = CFrame.new(1354.3479003906, 87.272773742676, -1393.9465332031)
        elseif x >= 100 and x <= 119 then
            Mon = "Snowman"
            Qdata = 2
            Qname = "SnowQuest"
            NameMon = "Snowman"
            PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            PosM = CFrame.new(1343.7817382812, 104.66806030273, -1429.0643310547)
        elseif x >= 120 and x <= 149 then
            Mon = "Chief Petty Officer"
            Qdata = 1
            Qname = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            PosQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
            PosM = CFrame.new(-4881.2309570312, 22.652044296265, 4273.7524414062)
        elseif x >= 150 and x <= 174 then
            Mon = "Sky Bandit"
            Qdata = 1
            Qname = "SkyQuest"
            NameMon = "Sky Bandit"
            PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            PosM = CFrame.new(-4953.20703125, 295.74420166016, -2899.2290039062)
        elseif x >= 175 and x <= 189 then
            Mon = "Dark Master"
            Qdata = 2
            Qname = "SkyQuest"
            NameMon = "Dark Master"
            PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            PosM = CFrame.new(-5259.8447265625, 391.39767456055, -2229.0354003906)
        elseif x >= 190 and x <= 209 then
            Mon = "Prisoner"
            Qdata = 1
            Qname = "PrisonerQuest"
            NameMon = "Prisoner"
            PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514)
            PosM = CFrame.new(5098.9736328125, -0.3204058110714, 474.23733520508)
        elseif x >= 210 and x <= 249 then
            Mon = "Dangerous Prisoner"
            Qdata = 2
            Qname = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514)
            PosM = CFrame.new(5654.5634765625, 15.633401870728, 866.29919433594)
        elseif x >= 250 and x <= 274 then
            Mon = "Toga Warrior"
            Qdata = 1
            Qname = "ColosseumQuest"
            NameMon = "Toga Warrior"
            PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            PosM = CFrame.new(-1820.21484375, 51.683856964111, -2740.6650390625)
        elseif x >= 275 and x <= 299 then
            Mon = "Gladiator"
            Qdata = 2
            Qname = "ColosseumQuest"
            NameMon = "Gladiator"
            PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            PosM = CFrame.new(-1292.8381347656, 56.380882263184, -3339.0314941406)
        elseif x >= 300 and x <= 324 then
            Mon = "Military Soldier"
            Qdata = 1
            Qname = "MagmaQuest"
            NameMon = "Military Soldier"
            PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            PosM = CFrame.new(-5411.1645507812, 11.081554412842, 8454.29296875)
        elseif x >= 325 and x <= 374 then
            Mon = "Military Spy"
            Qdata = 2
            Qname = "MagmaQuest"
            NameMon = "Military Spy"
            PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            PosM = CFrame.new(-5787.0043945312, 75.8262939453125, 8651.69921875)
        elseif x >= 375 and x <= 399 then
            Mon = "Fishman Warrior"
            Qdata = 1
            Qname = "FishmanQuest"
            NameMon = "Fishman Warrior"
            PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            PosM = CFrame.new(60878.30078125, 18.482830047607, 1543.7574462891)
        elseif x >= 400 and x <= 449 then
            Mon = "Fishman Commando"
            Qdata = 2
            Qname = "FishmanQuest"
            NameMon = "Fishman Commando"
            PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            PosM = CFrame.new(61922.6328125, 18.482830047607, 1493.934814453)
        elseif x >= 450 and x <= 474 then
            Mon = "God's Guard"
            Qdata = 1
            Qname = "SkyExp1Quest"
            NameMon = "God's Guard"
            PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            PosM = CFrame.new(-4710.04199, 845.277161, -1927.3079)
        elseif x >= 475 and x <= 524 then
            Mon = "Shanda"
            Qdata = 2
            Qname = "SkyExp1Quest"
            NameMon = "Shanda"
            PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            PosM = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
        elseif x >= 525 and x <= 549 then
            Mon = "Royal Squad"
            Qdata = 1
            Qname = "SkyExp2Quest"
            NameMon = "Royal Squad"
            PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            PosM = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif x >= 550 and x <= 624 then
            Mon = "Royal Soldier"
            Qdata = 2
            Qname = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            PosM = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif x == 625 or x <= 649 then
            Mon = "Galley Pirate"
            Qdata = 1
            Qname = "FountainQuest"
            NameMon = "Galley Pirate"
            PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, .087131381, 0, .996196866, 0, 1, 0, -0.996196866, 0, .087131381)
            PosM = CFrame.new(5551.0219726562, 78.901351928711, 3930.4128417969)
        elseif x >= 650 then
            Mon = "Galley Captain"
            Qdata = 2
            Qname = "FountainQuest"
            NameMon = "Galley Captain"
            PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, .087131381, 0, .996196866, 0, 1, 0, -0.996196866, 0, .087131381)
            PosM = CFrame.new(5441.9516601562, 42.502059936523, 4950.09375)
        end
    elseif World2 then
        if x == 700 or x <= 724 then
            Mon = "Raider"
            Qdata = 1
            Qname = "Area1Quest"
            NameMon = "Raider"
            PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, .974368095, 0, -0.22495985)
            PosM = CFrame.new(-728.32672119141, 52.779319763184, 2345.7705078125)
        elseif x == 725 or x <= 774 then
            Mon = "Mercenary"
            Qdata = 2
            Qname = "Area1Quest"
            NameMon = "Mercenary"
            PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, .974368095, 0, -0.22495985)
            PosM = CFrame.new(-1004.3244018555, 80.158866882324, 1424.6193847656)
        elseif x == 775 or x <= 799 then
            Mon = "Swan Pirate"
            Qdata = 1
            Qname = "Area2Quest"
            NameMon = "Swan Pirate"
            PosQ = CFrame.new(638.43811, 71.769989, 918.282898, .139203906, 0, .99026376, 0, 1, 0, -0.99026376, 0, .139203906)
            PosM = CFrame.new(1068.6643066406, 137.61428833008, 1322.1060791016)
        elseif x == 800 or x <= 874 then
            Mon = "Factory Staff"
            Qname = "Area2Quest"
            Qdata = 2
            NameMon = "Factory Staff"
            PosQ = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-010, -0.999488771, 1.36326533e-010, 1, 8.92172336e-010, .999488771, -1.07732087e-010, -0.0319722369)
            PosM = CFrame.new(73.078674316406, 81.863441467285, -27.470672607422)
        elseif x == 875 or x <= 899 then
            Mon = "Marine Lieutenant"
            Qdata = 1
            Qname = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268)
            PosM = CFrame.new(-2821.3723144531, 75.897277832031, -3070.0891113281)
        elseif x == 900 or x <= 949 then
            Mon = "Marine Captain"
            Qdata = 2
            Qname = "MarineQuest3"
            NameMon = "Marine Captain"
            PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268)
            PosM = CFrame.new(-1861.2310791016, 80.176582336426, -3254.6975097656)
        elseif x == 950 or x <= 974 then
            Mon = "Zombie"
            Qdata = 1
            Qname = "ZombieQuest"
            NameMon = "Zombie"
            PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, .95628953, 0, -0.29242146)
            PosM = CFrame.new(-5657.7768554688, 78.969734191895, -928.68701171875)
        elseif x == 975 or x <= 999 then
            Mon = "Vampire"
            Qdata = 2
            Qname = "ZombieQuest"
            NameMon = "Vampire"
            PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, .95628953, 0, -0.29242146)
            PosM = CFrame.new(-6037.66796875, 32.184638977051, -1340.6597900391)
        elseif x == 1000 or x <= 1049 then
            Mon = "Snow Trooper"
            Qdata = 1
            Qname = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, .92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            PosM = CFrame.new(549.14733886719, 427.38705444336, -5563.6987304688)
        elseif x == 1050 or x <= 1099 then
            Mon = "Winter Warrior"
            Qdata = 2
            Qname = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, .92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            PosM = CFrame.new(1142.7451171875, 475.63980102539, -5199.4165039062)
        elseif x == 1100 or x <= 1124 then
            Mon = "Lab Subordinate"
            Qdata = 1
            Qname = "IceSideQuest"
            NameMon = "Lab Subordinate"
            PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, .453972578, 0, -0.891015649, 0, 1, 0, .891015649, 0, .453972578)
            PosM = CFrame.new(-5707.4716796875, 15.951709747314, -4513.3920898438)
        elseif x == 1125 or x <= 1174 then
            Mon = "Horned Warrior"
            Qdata = 2
            Qname = "IceSideQuest"
            NameMon = "Horned Warrior"
            PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, .453972578, 0, -0.891015649, 0, 1, 0, .891015649, 0, .453972578)
            PosM = CFrame.new(-6341.3666992188, 15.951770782471, -5723.162109375)
        elseif x == 1175 or x <= 1199 then
            Mon = "Magma Ninja"
            Qdata = 1
            Qname = "FireSideQuest"
            NameMon = "Magma Ninja"
            PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            PosM = CFrame.new(-5449.6728515625, 76.658744812012, -5808.2006835938)
        elseif x == 1200 or x <= 1249 then
            Mon = "Lava Pirate"
            Qdata = 2
            Qname = "FireSideQuest"
            NameMon = "Lava Pirate"
            PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            PosM = CFrame.new(-5213.3315429688, 49.737880706787, -4701.451171875)
        elseif x == 1250 or x <= 1274 then
            Mon = "Ship Deckhand"
            Qdata = 1
            Qname = "ShipQuest1"
            NameMon = "Ship Deckhand"
            PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
            PosM = CFrame.new(1212.0111083984, 150.79205322266, 33059.24609375)
        elseif x == 1275 or x <= 1299 then
            Mon = "Ship Engineer"
            Qdata = 2
            Qname = "ShipQuest1"
            NameMon = "Ship Engineer"
            PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
            PosM = CFrame.new(919.47863769531, 43.544013977051, 32779.96875)
        elseif x == 1300 or x <= 1324 then
            Mon = "Ship Steward"
            Qdata = 1
            Qname = "ShipQuest2"
            NameMon = "Ship Steward"
            PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
            PosM = CFrame.new(919.43853759766, 129.55599975586, 33436.03515625)
        elseif x == 1325 or x <= 1349 then
            Mon = "Ship Officer"
            Qdata = 2
            Qname = "ShipQuest2"
            NameMon = "Ship Officer"
            PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
            PosM = CFrame.new(1036.0179443359, 181.4390411377, 33315.7265625)
        elseif x == 1350 or x <= 1374 then
            Mon = "Arctic Warrior"
            Qdata = 1
            Qname = "FrostQuest"
            NameMon = "Arctic Warrior"
            PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, .358349502, 0, -0.933587909)
            PosM = CFrame.new(5966.24609375, 62.970020294189, -6179.3828125)
        elseif x == 1375 or x <= 1424 then
            Mon = "Snow Lurker"
            Qdata = 2
            Qname = "FrostQuest"
            NameMon = "Snow Lurker"
            PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, .358349502, 0, -0.933587909)
            PosM = CFrame.new(5407.0737304688, 69.194374084473, -6880.8803710938)
        elseif x == 1425 or x <= 1449 then
            Mon = "Sea Soldier"
            Qdata = 1
            Qname = "ForgottenQuest"
            NameMon = "Sea Soldier"
            PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, .990270376, 0, -0.13915664, 0, 1, 0, .13915664, 0, .990270376)
            PosM = CFrame.new(-3028.2236328125, 64.674514770508, -9775.4267578125)
        elseif x >= 1450 then
            Mon = "Water Fighter"
            Qdata = 2
            Qname = "ForgottenQuest"
            NameMon = "Water Fighter"
            PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, .990270376, 0, -0.13915664, 0, 1, 0, .13915664, 0, .990270376)
            PosM = CFrame.new(-3352.9013671875, 285.01556396484, -10534.841796875)
        end
    elseif World3 then
        if x == 1500 or x <= 1524 then
            Mon = "Pirate Millionaire"
            Qdata = 1
            Qname = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            PosQ = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625)
            PosM = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625)
        elseif x == 1525 or x <= 1574 then
            Mon = "Pistol Billionaire"
            Qdata = 2
            Qname = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            PosQ = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625)
            PosM = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625)
        elseif x == 1575 or x <= 1599 then
            Mon = "Dragon Crew Warrior"
            Qdata = 1
            Qname = "AmazonQuest"
            NameMon = "Dragon Crew Warrior"
            PosQ = CFrame.new(6779.0327148438, 111.16865539551, -801.21307373047)
            PosM = CFrame.new(6779.0327148438, 111.16865539551, -801.21307373047)
        elseif x == 1600 or x <= 1624 then
            Mon = "Dragon Crew Archer"
            Qname = "AmazonQuest"
            Qdata = 2
            NameMon = "Dragon Crew Archer"
            PosQ = CFrame.new(6955.8974609375, 546.66589355469, 309.04013061523)
            PosM = CFrame.new(6955.8974609375, 546.66589355469, 309.04013061523)
        elseif x == 1625 or x <= 1649 then
            Mon = "Hydra Enforcer"
            Qname = "VenomCrewQuest"
            Qdata = 1
            NameMon = "Hydra Enforcer"
            PosQ = CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492)
            PosM = CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492)
        elseif x == 1650 or x <= 1699 then
            Mon = "Venomous Assailant"
            Qname = "VenomCrewQuest"
            Qdata = 2
            NameMon = "Venomous Assailant"
            PosQ = CFrame.new(4697.5918, 1100.65137, 946.401978, .579397917, -4.19689783e-010, .81504482, -1.49287818e-010, 1, 6.21053986e-010, -0.81504482, -4.81513662e-010, .579397917)
            PosM = CFrame.new(4697.5918, 1100.65137, 946.401978, .579397917, -4.19689783e-010, .81504482, -1.49287818e-010, 1, 6.21053986e-010, -0.81504482, -4.81513662e-010, .579397917)
        elseif x == 1700 or x <= 1724 then
            Mon = "Marine Commodore"
            Qdata = 1
            Qname = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, .258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
            PosM = CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312)
        elseif x == 1725 or x <= 1774 then
            Mon = "Marine Rear Admiral"
            NameMon = "Marine Rear Admiral"
            Qname = "MarineTreeIsland"
            Qdata = 2
            PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            PosM = CFrame.new(3656.7736816406, 160.52406311035, -7001.5986328125)
        elseif x == 1775 or x <= 1799 then
            Mon = "Fishman Raider"
            Qdata = 1
            Qname = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            PosM = CFrame.new(-10407.526367188, 331.76263427734, -8368.5166015625)
        elseif x == 1800 or x <= 1824 then
            Mon = "Fishman Captain"
            Qdata = 2
            Qname = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            PosM = CFrame.new(-10994.701171875, 352.38140869141, -9002.1103515625)
        elseif x == 1825 or x <= 1849 then
            Mon = "Forest Pirate"
            Qdata = 1
            Qname = "DeepForestIsland"
            NameMon = "Forest Pirate"
            PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247)
            PosM = CFrame.new(-13274.478515625, 332.37814331055, -7769.5805664062)
        elseif x == 1850 or x <= 1899 then
            Mon = "Mythological Pirate"
            Qdata = 2
            Qname = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247)
            PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif x == 1900 or x <= 1924 then
            Mon = "Jungle Pirate"
            Qdata = 1
            Qname = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.836914062)
        elseif x == 1925 or x <= 1974 then
            Mon = "Musketeer Pirate"
            Qdata = 2
            Qname = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            PosM = CFrame.new(-13457.904296875, 391.54565429688, -9859.177734375)
        elseif x == 1975 or x <= 1999 then
            Mon = "Reborn Skeleton"
            Qdata = 1
            Qname = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
            PosM = CFrame.new(-8763.7236328125, 165.72299194336, 6159.8618164062)
        elseif x == 2000 or x <= 2024 then
            Mon = "Living Zombie"
            Qdata = 2
            Qname = "HauntedQuest1"
            NameMon = "Living Zombie"
            PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
            PosM = CFrame.new(-10144.131835938, 138.6266784668, 5838.0888671875)
        elseif x == 2025 or x <= 2049 then
            Mon = "Demonic Soul"
            Qdata = 1
            Qname = "HauntedQuest2"
            NameMon = "Demonic Soul"
            PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-9505.8720703125, 172.10482788086, 6158.9931640625)
        elseif x == 2050 or x <= 2074 then
            Mon = "Posessed Mummy"
            Qdata = 2
            Qname = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-9582.0224609375, 6.2515273094177, 6205.478515625)
        elseif x == 2075 or x <= 2099 then
            Mon = "Peanut Scout"
            Qdata = 1
            Qname = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-2143.2419433594, 47.721984863281, -10029.995117188)
        elseif x == 2100 or x <= 2124 then
            Mon = "Peanut President"
            Qdata = 2
            Qname = "NutsIslandQuest"
            NameMon = "Peanut President"
            PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-1859.3540039062, 38.103168487549, -10422.4296875)
        elseif x == 2125 or x <= 2149 then
            Mon = "Ice Cream Chef"
            Qdata = 1
            Qname = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-872.24658203125, 65.81957244873, -10919.95703125)
        elseif x == 2150 or x <= 2199 then
            Mon = "Ice Cream Commander"
            Qdata = 2
            Qname = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            PosM = CFrame.new(-558.06103515625, 112.04895782471, -11290.774414062)
        elseif x == 2200 or x <= 2224 then
            Mon = "Cookie Crafter"
            Qdata = 1
            Qname = "CakeQuest1"
            NameMon = "Cookie Crafter"
            PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-008, .288177818, 6.9301187e-008, 1, 7.51931211e-008, -0.288177818, -5.2032135e-008, .957576931)
            PosM = CFrame.new(-2374.13671875, 37.798263549805, -12125.30859375)
        elseif x == 2225 or x <= 2249 then
            Mon = "Cake Guard"
            Qdata = 2
            Qname = "CakeQuest1"
            NameMon = "Cake Guard"
            PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-008, .288177818, 6.9301187e-008, 1, 7.51931211e-008, -0.288177818, -5.2032135e-008, .957576931)
            PosM = CFrame.new(-1598.3070068359, 43.773197174072, -12244.581054688)
        elseif x == 2250 or x <= 2274 then
            Mon = "Baking Staff"
            Qdata = 1
            Qname = "CakeQuest2"
            NameMon = "Baking Staff"
            PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-008, .250778586, 4.74911062e-008, 1, 1.49904711e-008, -0.250778586, 2.64211941e-008, -0.96804446)
            PosM = CFrame.new(-1887.8099365234, 77.618507385254, -12998.350585938)
        elseif x == 2275 or x <= 2299 then
            Mon = "Head Baker"
            Qdata = 2
            Qname = "CakeQuest2"
            NameMon = "Head Baker"
            PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-008, .250778586, 4.74911062e-008, 1, 1.49904711e-008, -0.250778586, 2.64211941e-008, -0.96804446)
            PosM = CFrame.new(-2216.1882324219, 82.884521484375, -12869.293945312)
        elseif x == 2300 or x <= 2324 then
            Mon = "Cocoa Warrior"
            Qdata = 1
            Qname = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438)
            PosM = CFrame.new(-21.553283691406, 80.574996948242, -12352.387695312)
        elseif x == 2325 or x <= 2349 then
            Mon = "Chocolate Bar Battler"
            Qdata = 2
            Qname = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438)
            PosM = CFrame.new(582.59057617188, 77.188095092773, -12463.162109375)
        elseif x == 2350 or x <= 2374 then
            Mon = "Sweet Thief"
            Qdata = 1
            Qname = "ChocQuest2"
            NameMon = "Sweet Thief"
            PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688)
            PosM = CFrame.new(165.1884765625, 76.058853149414, -12600.836914062)
        elseif x == 2375 or x <= 2399 then
            Mon = "Candy Rebel"
            Qdata = 2
            Qname = "ChocQuest2"
            NameMon = "Candy Rebel"
            PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688)
            PosM = CFrame.new(134.86563110352, 77.247680664062, -12876.547851562)
        elseif x == 2400 or x <= 2449 then
            Mon = "Candy Pirate"
            Qdata = 1
            Qname = "CandyQuest1"
            NameMon = "Candy Pirate"
            PosQ = CFrame.new(-1150.0400390625, 20.378934860229, -14446.334960938)
            PosM = CFrame.new(-1310.5003662109, 26.016523361206, -14562.404296875)
        elseif x == 2450 or x <= 2474 then
            Mon = "Isle Outlaw"
            Qdata = 1
            Qname = "TikiQuest1"
            NameMon = "Isle Outlaw"
            PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566)
            PosM = CFrame.new(-16479.900390625, 226.6117401123, -300.31143188477)
        elseif x == 2475 or x <= 2499 then
            Mon = "Island Boy"
            Qdata = 2
            Qname = "TikiQuest1"
            NameMon = "Island Boy"
            PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566)
            PosM = CFrame.new(-16849.396484375, 192.86505126953, -150.78532409668)
        elseif x == 2500 or x <= 2524 then
            Mon = "Sun-kissed Warrior"
            Qdata = 1
            Qname = "TikiQuest2"
            NameMon = "kissed Warrior"
            PosM = CFrame.new(-16347, 64, 984)
            PosQ = CFrame.new(-16538, 55, 1049)
        elseif x == 2525 or x <= 2550 then
            Mon = "Isle Champion"
            Qdata = 2
            Qname = "TikiQuest2"
            NameMon = "Isle Champion"
            PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, .0410757065, 0, -0.999156058, 0, 1, 0, .999156058, 0, .0410757065)
            PosM = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688)
        elseif a >= 2551 and a <= 2574 then
				Mon = "Serpent Hunter"
				Qdata = 1;
				Qname = "TikiQuest3";
				NameMon = "Serpent Hunter"
				PosQ = CFrame.new(-16679.4785, 176.7473, 1474.3995)
				PosM = CFrame.new(-16679.4785, 176.7473, 1474.3995)
			elseif a >= 2575 and a <= 2599 then -- CHỈ TỚI 2599, để 2600 chuyển qua Submarine
				Mon = "Skull Slayer"
				Qdata = 2;
				Qname = "TikiQuest3";
				NameMon = "Skull Slayer"
				PosQ = CFrame.new(-16759.5898, 71.2837, 1595.3399)
				PosM = CFrame.new(-16759.5898, 71.2837, 1595.3399)
			elseif a >= 2600 and a <= 2624 then
				Mon = "Reef Bandit"
				Qdata = 1;
				Qname = "SubmergedQuest1";
				NameMon = "Reef Bandit"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226) -- NPC Submerged
				PosM = CFrame.new(10736.6191, -2087.8439, 9338.4882)
			elseif a >= 2625 and a <= 2649 then
				Mon = "Coral Pirate"
				Qdata = 2;
				Qname = "SubmergedQuest1";
				NameMon = "Coral Pirate"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(10965.1025, -2158.8842, 9177.2597)
			elseif a >= 2650 and a <= 2674 then
				Mon = "Sea Chanter"
				Qdata = 1;
				Qname = "SubmergedQuest2";
				NameMon = "Sea Chanter"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(10621.0342, -2087.8440, 10102.0332)
			elseif a >= 2675 and a <= 2699 then
				Mon = "Ocean Prophet"
				Qdata = 2;
				Qname = "SubmergedQuest2";
				NameMon = "Ocean Prophet"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(11056.1445, -2001.6717, 10117.4493)
			elseif a >= 2700 and a <= 2724 then
				Mon = "High Disciple"
				Qdata = 1;
				Qname = "SubmergedQuest3";
				NameMon = "High Disciple"
				PosQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
				PosM = CFrame.new(9828.087890625, -1940.908935546875, 9693.0634765625)
			elseif a >= 2725 and a <= 2800 then
				Mon = "Grand Devotee"
				Qdata = 2;
				Qname = "SubmergedQuest3";
				NameMon = "Grand Devotee"
				PosQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
				PosM = CFrame.new(9557.5849609375, -1928.0404052734375, 9859.1826171875)
        end
    end
    MonFarm = Mon
    PosMon = PosM
end

function AutoHaki()
    local l_Character_0 = game:GetService("Players").LocalPlayer.Character
    if l_Character_0 and not l_Character_0:FindFirstChild("HasBuso") then
        local l_CommF__0 = game:GetService("ReplicatedStorage").Remotes.CommF_
        if l_CommF__0 then
            l_CommF__0:InvokeServer("Buso")
        end
    end
end

local function Float()
    if _G.AutoFarm then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            char.HumanoidRootPart.Anchored = false
            char.Humanoid.PlatformStand = true
        end
    else
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.PlatformStand = false
        end
    end
end

local function topos(targetCFrame)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local speed = _G.FarmSpeed
    local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    return tween
end

local function HasQuest()
    local main = player.PlayerGui:FindFirstChild("Main")
    if not main then return false end
    local quest = main:FindFirstChild("Quest")
    return quest and quest.Visible
end

local function AttackTarget(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    local char = player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
        local modules = ReplicatedStorage:FindFirstChild("Modules")
        if modules then
            local attackRemote = modules.Net:FindFirstChild("RE/RegisterAttack")
            local hitRemote = modules.Net:FindFirstChild("RE/RegisterHit")
            if attackRemote and hitRemote then
                pcall(function()
                    attackRemote:FireServer(0)
                    hitRemote:FireServer(target.HumanoidRootPart, {{target, target.HumanoidRootPart}})
                end)
            end
        end
        local remote = ReplicatedStorage.Remotes:FindFirstChild("CommF_")
        if remote then
            pcall(function()
                remote:InvokeServer("TAP")
            end)
        end
    end
end

local function EnableNoClip()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if _G.AutoFarm then
            local char = player.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
    end)
end

local function StartAutoFarm()
    if autoFarmConnection then autoFarmConnection:Disconnect() end
    if floatConnection then floatConnection:Disconnect() end
    EnableNoClip()
    
    floatConnection = RunService.Heartbeat:Connect(function()
        Float()
    end)
    
    autoFarmConnection = RunService.Heartbeat:Connect(function()
        if not _G.AutoFarm then return end
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        AutoHaki()
        CheckQuest()
        
        if not HasQuest() then
            local distance = (char.HumanoidRootPart.Position - PosQ.Position).Magnitude
            if distance > 10 then
                topos(PosQ)
            else
                wait(0.5)
                local remote = ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                if remote then
                    pcall(function()
                        remote:InvokeServer("StartQuest", Qname, Qdata)
                    end)
                end
                StartBring = true
            end
            return
        end
        
        if not Mon then return end
        
        local enemies = workspace.Enemies:GetChildren()
        local target = nil
        local nearestDistance = math.huge
        
        for _, enemy in pairs(enemies) do
            if enemy.Name == Mon and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                if enemy.Humanoid.Health > 0 then
                    local distance = (char.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                    if distance < nearestDistance then
                        nearestDistance = distance
                        target = enemy
                    end
                end
            end
        end
        
        if target then
            currentTarget = target
            local targetPos = target.HumanoidRootPart.Position
            local farmPosition = CFrame.new(targetPos.X, targetPos.Y + 30, targetPos.Z)
            PosMon = CFrame.new(targetPos.X, targetPos.Y + 25, targetPos.Z)
            
            if (char.HumanoidRootPart.Position - farmPosition.Position).Magnitude > 5 then
                topos(farmPosition)
            end
            
            AttackTarget(target)
        else
            currentTarget = nil
            StartBring = false
            local distance = (char.HumanoidRootPart.Position - PosM.Position).Magnitude
            if distance > 50 then
                topos(PosM)
            end
        end
    end)
end

Tab1:AddToggle({
    Name = "Auto Farm",
    Default = _G.AutoFarm,
    Callback = function(value)
        _G.AutoFarm = value
        if value then
            StartAutoFarm()
        else
            if autoFarmConnection then
                autoFarmConnection:Disconnect()
                autoFarmConnection = nil
            end
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            if floatConnection then
                floatConnection:Disconnect()
                floatConnection = nil
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.PlatformStand = false
            end
            currentTarget = nil
            StartBring = false
        end
    end
})

game.Players.PlayerRemoving:Connect(function(plr)
    if plr == player then
        if autoFarmConnection then autoFarmConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        if floatConnection then floatConnection:Disconnect() end
        if bringMonsterConnection then bringMonsterConnection:Disconnect() end
    end
end)
