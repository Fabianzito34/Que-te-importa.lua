-- Main Functions

local LocalPlayer = game:GetService("Players").LocalPlayer

-- ESP
espRToggled = false
espBToggled = false
espIToggled = false
espCuToogled = false

workspace.Camera.ChildAdded:Connect(
    function(child)
        if child.Name == "m_Zombie" then
            local Origin = child:WaitForChild("Orig")
            if Origin.Value ~= nil then
                local zombie = Origin.Value:WaitForChild("Zombie")
                if espRToggled then
                    if zombie.WalkSpeed > 16 then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = child
                        Highlight.Adornee = child
                    end
                end
                if espBToggled then
                    if child:FindFirstChild("Barrel") ~= nil then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = child
                        Highlight.Adornee = child
                        Highlight.FillColor = Color3.fromRGB(65,105,225)
                    end
                end
                if espIToggled then 
                    if child:FindFirstChild("Whale Oil Lantern") ~= nil then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = child
                        Highlight.Adornee = child
                        Highlight.FillColor = Color3.fromRGB(255,255,51)
                    end
                end
                if espCuToogled then
                    if child:FindFirstChild("Sword") ~= nil then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = child
                        Highlight.Adornee = child
                        Highlight.FillColor = Color3.fromRGB(65,105,225)  
                    end
                end       
            end
        end
    end
)


-- ESP Players

espLifeToggled = false

function checkPlayersLife()
    if espLifeToggled == false then
        print("False!")
        local Players = workspace.Players:GetChildren()
        for i, player in pairs(Players) do
            if player:FindFirstChild("Highlight") ~= nil then
                player:FindFirstChild("Highlight"):Destroy()
            end
        end
    end

    while espLifeToggled do
        local Players = workspace.Players:GetChildren()
        for i, player in pairs(Players) do
            if player:waitForChild("Humanoid").Health < 60 and player.Name ~= LocalPlayer.Name and LocalPlayer.Backpack:FindFirstChild("Medical Supplies") or LocalPlayer.Character:FindFirstChild("Medical Supplies") and LocalPlayer.Character["Medical Supplies"]:IsA("Tool") then
                if player:FindFirstChild("Highlight") == nil then
                    local Highlight = Instance.new("Highlight")
                    Highlight.Parent = player
                    Highlight.Adornee = player
                    Highlight.FillColor = Color3.fromRGB(255, 169, 108)
                    Highlight.FillTransparency = 0.8
                    Highlight.OutlineColor = Color3.fromRGB(255, 206, 108)
                    Highlight.OutlineTransparency = 0.2
                end
            else
                if player:FindFirstChild("Highlight") ~= nil then
                    player:FindFirstChild("Highlight"):Destroy()
                end
            end

            if LocalPlayer.Backpack:FindFirstChild("Mercy") or LocalPlayer.Character:FindFirstChild("Mercy") and LocalPlayer.Character["Mercy"]:IsA("Tool")then
                if player:waitForChild("UserStates").Infected.Value > 10 and player:FindFirstChild("Highlight") == nil then
                    if player:waitForChild("UserStates").Infected.Value > 89 then
                        if player:FindFirstChild("Highlight") ~= nil then
                            local Highlight = player:FindFirstChild("Highlight")
                            Highlight.FillColor = Color3.fromRGB(178,34,34)
                        else
                            local Highlight = Instance.new("Highlight")
                            Highlight.Parent = player
                            Highlight.Adornee = player
                            Highlight.FillColor = Color3.fromRGB(178,34,34)
                        end
                    else
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = player
                        Highlight.Adornee = player
                        Highlight.FillColor = Color3.fromRGB(255, 169, 108)
                        Highlight.FillTransparency = 0.8
                        Highlight.OutlineColor = Color3.fromRGB(255, 206, 108)
                        Highlight.OutlineTransparency = 0.2
                    end
                else 
                    if player:FindFirstChild("Highlight") ~= nil and player:waitForChild("UserStates").Infected.Value == 0 then
                        player:FindFirstChild("Highlight"):Destroy()
                    end
                end
            end
        end
        task.wait(2.0)
    end
end

toolEquip = true

-- Kill Aura
observerOnline = false
killAuraToggled = false
isDead = false

local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local params = OverlapParams.new()
params.FilterDescendantsInstances = {LocalPlayer.Character}

function detectEnemy(hitbox, hrp)
    print("Detect enemy Start!")
    while true do
        if killAuraToggled == false then
            print("detectEnemy killed!")
            isDead = false
            observerOnline = false
            return nil
        end

        local parts = workspace:GetPartsInPart(hitbox, params)
        for i, part in pairs(parts) do
            if part.parent and part.parent.Name == "m_Zombie" then
                local Origin = part.parent:WaitForChild("Orig")
                if Origin.Value ~= nil then
                    local zombie = Origin.Value:WaitForChild("Zombie")
                    local childrens = LocalPlayer.Character:GetChildren()
                    if toolEquip then
                        local hit = Origin.Value
                        local zombieHead = workspace:Raycast(hrp.CFrame.Position, hit.Head.CFrame.Position - hrp.CFrame.Position)
                        local calc = (zombieHead.Position - hrp.CFrame.Position)

                        if calc:Dot(calc) > 1 then
                            calc = calc.Unit
                        end

                        if LocalPlayer:DistanceFromCharacter(Origin.Value:FindFirstChild("HumanoidRootPart").CFrame.Position) < 13 then
                            if zombie.WalkSpeed > 16 then
                                game:GetService("ReplicatedStorage").Remotes.Gib:FireServer(hit, "Head", hit.Head.CFrame.Position, zombieHead.Normal, true)
                                game:GetService("Workspace").Players[LocalPlayer.Name]["Heavy Sabre"].RemoteEvent:FireServer("Swing", "Thrust")
                                game:GetService("Workspace").Players[LocalPlayer.Name]["Heavy Sabre"].RemoteEvent:FireServer("HitZombie", hit, hit.Head.CFrame.Position, true, calc * 25, "Head", zombieHead.Normal)
                            else
                                if part.Parent:FindFirstChild("Barrel") == nil then
                                    game:GetService("ReplicatedStorage").Remotes.Gib:FireServer(hit, "Head", hit.Head.CFrame.Position, zombieHead.Normal, true)
                                    game:GetService("Workspace").Players[LocalPlayer.Name]["Heavy Sabre"].RemoteEvent:FireServer("Swing", "Thrust")
                                    game:GetService("Workspace").Players[LocalPlayer.Name]["Heavy Sabre"].RemoteEvent:FireServer("HitZombie", hit, hit.Head.CFrame.Position, true, calc * 25, "Head", zombieHead.Normal)
                                end
                            end
                        end
                    end
                end 
            end
        end
    end
end

function createHitBox()
    if LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("Hitbox") ~= nil then
        if observerOnline == false then
            observerOnline = true
            detectEnemy(LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("Hitbox"), LocalPlayer.Character:WaitForChild("HumanoidRootPart"))
        end

        return true
    else
        local torso = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local hitbox = Instance.new("Part", torso)
        hitbox.Name = "Hitbox"
        hitbox.Anchored = false
        hitbox.Massless = true
        hitbox.CanCollide = false
        hitbox.CanTouch = false
        hitbox.Transparency  = 1
        hitbox.Size = Vector3.new(13, 7, 12.5)
        hitbox.CFrame = torso.CFrame * CFrame.new(0, 0, -7.8)

        local weld = Instance.new("WeldConstraint", torso)
        weld.Part0 = hitbox
        weld.Part1 = LocalPlayer.Character.HumanoidRootPart

        if observerOnline == false then
            observerOnline = true
            detectEnemy(hitbox, LocalPlayer.Character:WaitForChild("HumanoidRootPart"))
        end

        return true
    end
end

-- Saint Lights
function onLights()
    local ligthPost = game:GetService("Workspace"):waitForChild("Saint Petersburg").Modes.Holdout:waitForChild("LampPosts"):GetChildren()

    for i, part in pairs(ligthPost) do
        if part:FindFirstChild("Metal") ~= nil then
            local Metal = part:FindFirstChild("Metal")
            Metal.Light.PointLight.Enabled = true
            Metal.Light.Visible = true
        end
    end
end

-- WalkSpeed
local connection = nil

local function changeWalkSpeed(newValue, walkSpeedToggled)
    local workPlayer = LocalPlayer.Character
    workPlayer.Humanoid.WalkSpeed = newValue
    if walkSpeedToggled then
        print("Connected!")
        connection = workPlayer.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function() workPlayer.Humanoid.WalkSpeed = newValue end)
    else
        if connection ~= nil then
            print("Disconnected!")
            connection:Disconnect()
        end
    end
end

walkSpeedToggled = false
walkSpeedValue = 16
workspace.Players.ChildAdded:Connect(
   function(child)
    changeWalkSpeed(walkSpeedValue, walkSpeedToggled)
   end
)


-- Music
local namecall
autoplay = false

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod():lower()

    if not checkcaller() and self.Name == "RemoteEvent" and method == "fireserver" then
        if autoplay then
            if args[1] ~= nil then
                if args[1] == "UpdateAccuracy" then
                    args[2] = 100
                    print("[DEBUG] AutoPlay Working!")
                    return namecall(self, unpack(args))
                end
            end
        return namecall(self, unpack(args))
        end
    end
    return namecall(self, ...)
end)


-- 255, 169, 108 - 255, 206, 108 ( Outline )
-- HeadLock

-- Bayonet Support

local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = workspace.CurrentCamera
game:GetService("RunService")
local v_u_4 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RbxUtil"):WaitForChild("Maid"))
local v_u_5 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("World"):WaitForChild("SoundSystem"))
local v_u_6 = game.ReplicatedStorage:WaitForChild("GameStates"):WaitForChild("Gameplay"):WaitForChild("FriendlyFire")
local v7 = game.Players.LocalPlayer:WaitForChild("Options")
local v_u_8 = v7:WaitForChild("HoldToAim")
local v_u_9 = v7:WaitForChild("FPArmTransparency")
local v_u_10 = v7:WaitForChild("ADSSens")
local v_u_11 = v7:WaitForChild("Gore")
local v_u_12 = v7:WaitForChild("WeaponStains")
local v_u_13 = v7:WaitForChild("UnlockDirAtUnEquip")
local v_u_14 = game.ReplicatedStorage:WaitForChild("RecoilEvent")
local v_u_15 = {
    ["Fire"] = "rbxassetid://14228569908",
    ["Reload"] = "rbxassetid://14228570786",
    ["BayonetAttack"] = "rbxassetid://14228880526",
    ["BayonetToggle"] = "rbxassetid://14228572871",
    ["Buttstock"] = "rbxassetid://17219734067",
    ["CancelAim"] = "rbxassetid://14229391966",
    ["ADS_On"] = "rbxassetid://13137621651",
    ["ADS_Off"] = "rbxassetid://9952047700"
}
v_u_1.Icons = v_u_15
local v_u_16 = UDim2.fromScale(1.55, 1.55)
local v_u_17 = UDim2.new(0.5, 0, 0.5, 0)
local v_u_18 = game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RbxUtil")

local FlintLock = require(game:GetService("ReplicatedStorage").Modules.Weapons:waitForChild("Flintlock"))
local originFunction_ = FlintLock.BayonetHitCheck

function v_u_1.BayonetHitCheck(p115, p116, p117, p118, p119)
    local v120 = workspace:Raycast(p116, p117, p118)
    if v120 then
        if v120.Instance.Parent.Name == "m_Zombie" then
            local v121 = p118.FilterDescendantsInstances
            local v122 = v120.Instance
            table.insert(v121, v122)
            p118.FilterDescendantsInstances = v121
            local v123 = v120.Instance.Parent:FindFirstChild("Orig")
            if v123 then
                local Head = ""
                for i, part in pairs(v120.Instance.Parent:GetChildren()) do
                    if part.Name == "Head" and part.ClassName == "Part" or part.ClassName == "MeshPart" then
                        Head = part
                    end
                end
                print(Head)
                p115.remoteEvent:FireServer("Bayonet_HitZombie", v123.Value, Head.CFrame.Position, true, "Head")
                local v_u_124 = v123.Value
                local v_u_125 = tick()
                v_u_124:SetAttribute("WepHitID", tick())
                v_u_124:SetAttribute("WepHitDirection", p117 * 10)
                v_u_124:SetAttribute("WepHitPos", v120.Position)
                task.delay(0.2, function()
                    if v_u_124:GetAttribute("WepHitID") == v_u_125 then
                        v_u_124:SetAttribute("WepHitDirection", nil)
                        v_u_124:SetAttribute("WepHitPos", nil)
                        v_u_124:SetAttribute("WepHitID", nil)
                    end
                end)
            end
            return 1
        end
        local v126 = v120.Instance.Parent:FindFirstChild("DoorHit") or v120.Instance:FindFirstChild("BreakGlass")
        if v126 and not table.find(p119, v126) then
            table.insert(p119, v126)
            p115.remoteEvent:FireServer("Bayonet_HitCon", v120.Instance, v120.Position, v120.Normal, v120.Material)
            return 2
        end
        local v127 = v120.Instance.Parent:FindFirstChild("Humanoid") or v120.Instance.Parent.Parent:FindFirstChild("Humanoid")
        if v127 and not table.find(p119, v127) then
            table.insert(p119, v127)
            p115.remoteEvent:FireServer("Bayonet_HitPlayer", v127, v120.Position)
            return 2
        end
    end
    return 0
end

function changeBayonet(value)
   if value then
      print("Function Changed! - Bayonet")
      FlintLock.BayonetHitCheck = v_u_1.BayonetHitCheck
   else
      FlintLock.BayonetHitCheck = originFunction_
   end
end

local MeleeBase = require(game:GetService("ReplicatedStorage").Modules.Weapons:waitForChild("MeleeBase"))
local originFunction = MeleeBase.MeleeHitCheck

local u1 = {}
u1.__index = u1
local u2 = game:GetService("UserInputService")
local u3 = workspace.CurrentCamera
game:GetService("RunService")
local u4 = game.ReplicatedStorage:WaitForChild("LocalUpdateCrosshair")
local v5 = game.ReplicatedStorage:WaitForChild("GameStates"):WaitForChild("Gameplay")
local u6 = v5:WaitForChild("FriendlyFire")
local u7 = v5:WaitForChild("PVP")
local u8 = game:GetService("CollectionService")
local u9 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("World"):WaitForChild("SoundSystem"))
local u10 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RbxUtil"):WaitForChild("DebugVisualizer"))
local v11 = game.Players.LocalPlayer:WaitForChild("Options")
local u12 = v11:WaitForChild("FPArmTransparency")
local u13 = v11:WaitForChild("FlipHorizontalSwing")
local u14 = v11:WaitForChild("Gore")
local u15 = v11:WaitForChild("WeaponStains")
local u16 = v11:WaitForChild("UnlockDirAtUnEquip")
local u17 = {
    ["Swing"] = "rbxassetid://14228572354",
    ["Charge"] = "rbxassetid://14228574464",
    ["AxeFront"] = "rbxassetid://18550335136",
    ["AxeBack"] = "rbxassetid://18550335251"
}

function u1.MeleeHitCheck(p100, p101, p102, p103, p104, p105)
    local v106 = workspace:Raycast(p101, p102, p103)
    if v106 then
        if v106.Instance.Parent.Name == "m_Zombie" then
            local v107 = p103.FilterDescendantsInstances
            local v108 = v106.Instance
            table.insert(v107, v108)
            p103.FilterDescendantsInstances = v107
            local v109 = v106.Instance.Parent:FindFirstChild("Orig")
            if v109 then
                if p100.sharp and shared.Gib ~= nil then
                    if v109.Value then
                        local v110 = v109.Value:FindFirstChild("Zombie")
                        local v111 = not p100.Stats.HeadshotMulti and 2.3 or p100.Stats.HeadshotMulti
                        if v110 and v110.Health - p100.Stats.Damage * v111 <= 0 then
                            shared.Gib(v109.Value, v106.Instance.Name, v106.Position, v106.Normal, true)
                        end
                    else
                        shared.Gib(v109.Value, v106.Instance.Name, v106.Position, v106.Normal, true)
                    end
                end
                if not p104[v109] or p104[v109] < (p100.Stats.MaxHits or 3) then
                    if p105 then
                        p100.remoteEvent:FireServer("ThrustCharge", v109.Value, v106.Position, v106.Normal)
                    else

                        local Head = ""
                        for i, part in pairs(v106.Instance.Parent:GetChildren()) do
                            if part.Name == "Head" and part.ClassName == "Part" or part.ClassName == "MeshPart" then
                                Head = part
                            end
                        end
                        local u112 = v109.Value
                        local v113 = Head.CFrame.Position - p101
                        if v113:Dot(v113) > 1 then
                            v113 = v113.Unit
                        end
                        local v114 = v113 * 25
                        p100.remoteEvent:FireServer("HitZombie", u112, Head.CFrame.Position, true, v114, "Head", v106.Normal)
                        if not u112:GetAttribute("WepHitDirection") then
                            local u115 = tick()
                            u112:SetAttribute("WepHitID", tick())
                            u112:SetAttribute("WepHitDirection", v114)
                            u112:SetAttribute("WepHitPos", v106.Position)
                            task.delay(0.2, function() --[[Anonymous function at line 887]]
                                --[[
                                Upvalues:
                                    [1] = u112
                                    [2] = u115
                                --]]
                                if u112:GetAttribute("WepHitID") == u115 then
                                    u112:SetAttribute("WepHitDirection", nil)
                                    u112:SetAttribute("WepHitPos", nil)
                                    u112:SetAttribute("WepHitID", nil)
                                end
                            end)
                        end
                        u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                        u10:CastSphere("PartPosition", CFrame.new(v106.Position), Color3.fromRGB(255, 85, 0))
                        u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(0, 255, 0), p102.Magnitude / 1)
                    end
                    if p104[v109] then
                        p104[v109] = p104[v109] + 1
                    else
                        table.insert(p104, v109)
                        p104[v109] = 1
                        if u14.Value and (u15.Value and p100.player:GetAttribute("Platform") ~= "Console") then
                            local v116 = p100.bloodSaturation + 0.1
                            p100.bloodSaturation = math.min(v116, 1)
                        end
                    end
                end
            end
            return 1
        end
        if not p105 then
            local v117 = v106.Instance.Parent:FindFirstChild("DoorHit") or v106.Instance:FindFirstChild("BreakGlass")
            if v117 and not table.find(p104, v117) then
                table.insert(p104, v117)
                p100.remoteEvent:FireServer("HitCon", v106.Instance)
                u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                return 2
            end
            local v118 = v106.Instance.Parent:FindFirstChild("Humanoid") or v106.Instance.Parent.Parent:FindFirstChild("Humanoid")
            if v118 and not table.find(p104, v118) then
                table.insert(p104, v118)
                p100.remoteEvent:FireServer("HitPlayer", v118, v106.Position)
                u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(0, 255, 0), p102.Magnitude / 1)
                return 2
            end
            if u7:GetAttribute("Active") == true then
                local v119 = v106.Instance.Parent:FindFirstChild("BuildingHealth") or v106.Instance.Parent.Parent:FindFirstChild("BuildingHealth")
                if v119 ~= nil and not table.find(p104, v119) then
                    table.insert(p104, v119)
                    local v120 = v119.Parent:FindFirstChild("Creator")
                    if v120 then
                        v120 = v120.Value
                    end
                    if v120 ~= nil and (v120.Neutral == false and (p100.player.Team ~= nil and (v120.Team ~= nil and p100.player.Team.Name == v120.Team.Name))) then
                        return 2
                    end
                    p100.remoteEvent:FireServer("HitBuilding", v119.Parent)
                    u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                    u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                    return 2
                end
            end
            if p100.Stats.BreaksDown and u8:HasTag(v106.Instance, "Breakable") then
                local v121 = OverlapParams.new()
                v121.FilterDescendantsInstances = p103.FilterDescendantsInstances
                local v122 = workspace:GetPartBoundsInRadius(v106.Position, 0.1, v121)
                local v123 = {}
                for v124 = 1, #v122 do
                    if u8:HasTag(v122[v124], "Breakable") then
                        local v125 = v122[v124]
                        table.insert(v123, v125)
                    end
                end
                p100.remoteEvent:FireServer("HitBreakable", v123, (v106.Position - p101).Unit)
                u10:CastSphere("MeleeHitValid", CFrame.new(p101), Color3.fromRGB(0, 255, 0))
                u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 255, 0), p102.Magnitude / 1)
                return 2
            end
            u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 0, 0), p102.Magnitude / 1)
        end
    else
        u10:CastLine("MeleeHit", CFrame.new(p101, p101 + p102) * CFrame.new(0, 0, -p102.Magnitude / 2), Color3.fromRGB(255, 0, 0), p102.Magnitude / 1)
    end
    return 0
end

function changeMelee(value)
   if value then
      print("Function Changed!")
      MeleeBase.MeleeHitCheck = u1.MeleeHitCheck
   else
      MeleeBase.MeleeHitCheck = originFunction
   end
end

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window =
    Rayfield:CreateWindow(
    {
        Name = "G&B Hub - Xavier I.N.C",
        Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
        LoadingTitle = "Xabisco on youtube.",
        LoadingSubtitle = "by Xabisco",
        Theme = "Default",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "G&B Hub"
        },
        Discord = {
            Enabled = true,
            Invite = "v8hYqpn2",
            RememberJoins = true
        },
        KeySystem = true,
        KeySettings = {
            Title = "G&B Hub - Xavier I.N.C",
            Subtitle = "Key System",
            Note = "Enter in your Discord! :D\n(discord.gg/v8hYqpn2)",
            FileName = "Key",
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = {"xabisco_inc"}
        }
    }
)

Rayfield:Notify({
   Title = "Discord",
   Content = "The discord invitation link has been copied to your clipboard automatically :)",
   Duration = 6.5,
   Image = 4483362458,
})

setclipboard(tostring("https://discord.gg/85tHp3jp"))

local Tab = Window:CreateTab("Main", "album")
local Section = Tab:CreateSection("Main Functions")

local esp_Tab = Window:CreateTab("ESP", "target")
local esp_Section = esp_Tab:CreateSection("ESP Functions")

local player_Tab = Window:CreateTab("Player", "person-standing")
local player_Section = player_Tab:CreateSection("Aux. Player Functions")

local player_esp =
    player_Tab:CreateToggle(
    {
        Name = "Medic Player ESP",
        CurrentValue = false,
        Flag = "player_esp", 
        Callback = function(Value)
            espLifeToggled = Value
            checkPlayersLife()
        end
    }
)

local priest_esp =
    player_Tab:CreateToggle(
    {
        Name = "Father Infection ESP",
        CurrentValue = false,
        Flag = "father_infection", 
        Callback = function(Value)
            espLifeToggled = Value
            checkPlayersLife()
        end
    }
)

local walkSpeed =
    Tab:CreateToggle(
    {
        Name = "WalkSpeed Freeze",
        CurrentValue = false,
        Flag = "WalkSpeed", 
        Callback = function(Value)
            walkSpeedToggled = Value
            changeWalkSpeed(walkSpeedValue, walkSpeedToggled)
        end
    }
)

local Input = Tab:CreateInput({
   Name = "WalkSpeed",
   CurrentValue = "16",
   PlaceholderText = "WalkSpeed",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Value)
    Value = tonumber(Value)
    walkSpeedValue = Value
    changeWalkSpeed(Value, walkSpeedToggled)
   end,
})


local headToggle =
    Tab:CreateToggle(
    {
        Name = "Head Lock",
        CurrentValue = false,
        Flag = "HeadLock", 
        Callback = function(Value)
            changeBayonet(Value)
            changeMelee(Value)
        end
    }
)

local Lights =
    Tab:CreateButton(
    {
        Name = "Lights On (Saint Petersburg)",
        CurrentValue = false,
        Flag = "Saint", 
        Callback = function(Value)
            onLights()
        end
    }
)

local autoPlay =
    Tab:CreateToggle(
    {
        Name = "Auto Play",
        CurrentValue = false,
        Flag = "auto_play", 
        Callback = function(Value)
            autoplay = Value
        end
    }
)

local esp_Runner =
    esp_Tab:CreateToggle(
    {
        Name = "ESP Runner",
        CurrentValue = false,
        Flag = "ESP_1",
        Callback = function(Value)
            espRToggled = Value
        end
    }
)

local esp_Bomber =
    esp_Tab:CreateToggle(
    {
        Name = "ESP Bomber",
        CurrentValue = false,
        Flag = "ESP_2",
        Callback = function(Value)
            espBToggled = Value
        end
    }
)

local esp_Igniter =
    esp_Tab:CreateToggle(
    {
        Name = "ESP Igniter",
        CurrentValue = false,
        Flag = "ESP_3",
        Callback = function(Value)
            espIToggled = Value
        end
    }
)

local esp_Curss =
    esp_Tab:CreateToggle(
    {
        Name = "ESP Cuirassier",
        CurrentValue = false,
        Flag = "ESP_4",
        Callback = function(Value)
            espCuToogled = Value
        end
    }
)  
