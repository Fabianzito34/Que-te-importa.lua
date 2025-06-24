local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local AutoBlocksettings = {
 Enabled = false,
 Range = 17,
 blockKey = Enum.KeyCode.F
}
local AutoAttackSettings = {
    Enabled = false,
    Range = 16,
    Cooldown = 0.4,
}

local lastAttack = 0

local function attack()
    attacking = true
    local remote = game:GetService("ReplicatedStorage").Remotes.Attack
    remote:FireServer(true, nil, false)
    task.wait(0.1)
    remote:FireServer(false)
    attacking = false
end

-- 👁️ Verifica si hay enemigos cercanos
local function isEnemyNearby(range)
    local lpChar = LocalPlayer.Character
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return false end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - lpChar.HumanoidRootPart.Position).Magnitude
            if dist <= range then
                return true
            end
        end
    end
    return false
end
--logica de ataque
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AttackRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Attack")

local attacking = false

local function getClosestEnemyInRange(range)
    local lpChar = LocalPlayer.Character
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return nil end

    local closest, closestDist = nil, range
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - lpChar.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closest = plr
                closestDist = dist
            end
        end
    end
    return closest
end

local function doCombo()
    attacking = true
    for i = 1, 5 do
        AttackRemote:FireServer(true, nil, false)
        task.wait(0.12)
        AttackRemote:FireServer(false)
        task.wait(0.1)
    end
    attacking = false
end

RunService.RenderStepped:Connect(function()
    if AutoAttackSettings.Enabled and not attacking then
        local target = getClosestEnemyInRange(AutoAttackSettings.Range)
        if target then
            doCombo()
        end
    end
end)

-- Debug UI
local statusGui = Instance.new("BillboardGui")
statusGui.Name = "AutoBlockStatusGUI"
statusGui.Size = UDim2.new(0, 200, 0, 50)
statusGui.StudsOffset = Vector3.new(0, 3, 0)
statusGui.AlwaysOnTop = true


local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextStrokeTransparency = 0.5
textLabel.TextScaled = true
textLabel.Font = Enum.Font.Code
textLabel.Text = "AutoBlock: OFF | Blocking: NO"
textLabel.Parent = statusGui

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") and not statusGui.Parent then
        statusGui.Parent = char.Head
    end
end)

-- Animations list
local attackAnimationsByCharacter = {
["Rengoku"] = {
        ["rbxassetid://114068886686995"] = true, -- Uplift
        ["rbxassetid://108002554276799"] = true, -- Flame Barrage
        ["rbxassetid://84066243118051"] = true,  -- Rising Sun
        ["rbxassetid://106761166197595"] = true, -- M1 #1
        ["rbxassetid://93155337670452"] = true, -- M1 #2
        ["rbxassetid://139125145846285"] = true, -- M1 #3
        ["rbxassetid://128201550990985"] = true, -- M1 #4
        ["rbxassetid://139163597221496"] = true, -- M1 #5
    },
  ["Tanjiro"] = {
    ["rbxassetid://96676094765842"] = true,--WaterSurfaceSlash
    ["rbxassetid://115927777447806"] = true, --WaterWheel
    ["rbxassetid://106973744514210"] = true, --FlowingDanceNew
    ["rbxassetid://100530374984424"] = true, --ShiningSun
    ["rbxassetid://106761166197595"] = true, -- M1 #1
    ["rbxassetid://93155337670452"] = true, -- M1 #2
    ["rbxassetid://139125145846285"] = true, -- M1 #3
    ["rbxassetid://128201550990985"] = true, -- M1 #4
    ["rbxassetid://139163597221496"] = true, -- M1 #5
    },
    ["Gyutaro"] = {
      ["rbxassetid://89392454871969"] = true, --PoisonVein
      ["rbxassetid://107069754966883"] = true, --Start
      ["rbxassetid://129045814461449"] = true, --RampantArc
      ["rbxassetid://75463674781031"] = true, -- M1 #1
      ["rbxassetid://110289688662975"] = true, -- M1 #2
      ["rbxassetid://117030050957209"] = true, -- M1 #3
      ["rbxassetid://134509540723229"] = true, -- M1 #4
      ["rbxassetid://119602255090802"] = true, -- M1 #5
    },
 ["Tengen"] = {
   ["rbxassetid://131998274077612"] = true, --Resounding
   ["rbxassetid://72868248820702"] = true, --MusicalScore
   ["rbxassetid://106836365531794"] = true, --LoudAct
   ["rbxassetid://114613780645660"] = true, --Performance
   ["rbxassetid://135597777560035"] = true, -- M1 #1
    ["rbxassetid://80780446857840"] = true, -- M1 #2
    ["rbxassetid://121841233919833"] = true, -- M1 #3
    ["rbxassetid://117852461053412"] = true, -- M1 #4
    ["rbxassetid://88863557701908"] = true, -- M1 #5
    ["rbxassetid://124781932685589"] = true, -- M1 #6
   },
 -- nezt chr
 
}

local function getCharacterName(model)
    return model:GetAttribute("Moveset") or "Unknown"
end

local function isAttackAnimation(characterName, animationId)
    local list = attackAnimationsByCharacter[characterName]
    return list and list[animationId] or false
end

local function isEnemyAttackingNearby(range)
    local lpChar = LocalPlayer.Character
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return false end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - lpChar.HumanoidRootPart.Position).Magnitude
            if dist <= range then
                local characterName = getCharacterName(plr.Character)
                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        if isAttackAnimation(characterName, track.Animation.AnimationId) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

-- Nuevo sistema de AutoBlock usando RemoteEvent
local blocking = false

RunService.RenderStepped:Connect(function()
    local shouldBlock = AutoBlocksettings.Enabled and isEnemyAttackingNearby(AutoBlocksettings.Range)

    if shouldBlock and not blocking then
        blocking = true
        -- Enviar Remote para iniciar bloqueo
        game:GetService("ReplicatedStorage").Remotes.Block:FireServer(true)
    elseif not shouldBlock and blocking then
        blocking = false
        -- Enviar Remote para detener el bloqueo
        game:GetService("ReplicatedStorage").Remotes.Block:FireServer(false)
    end

    -- Actualizar texto debug
    if textLabel then
    textLabel.Text = string.format(
        "AutoBlock: %s | Blocking: %s\nAutoAttack: %s | Attacking: %s",
        AutoBlocksettings.Enabled and "ON" or "OFF",
        blocking and "YES" or "NO",
        AutoAttackSettings.Enabled and "ON" or "OFF",
        attacking and "YES" or "NO"
    )
  end
end)
-- Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AutoBlock Test",
   Icon = 0, 
   LoadingTitle = "AB test",
   LoadingSubtitle = "by fabianstyx",
   Theme = "Default",
   ToggleUIKeybind = "K",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "Ab test"
   },
   Discord = { Enabled = false },
   KeySystem = false,
})

local Main = Window:CreateTab("AutoBlock", 4483362458)
local Main2 = Window:CreateTab("AutoAttack",4483362458)

Main:CreateToggle({
   Name = "AutoBlock On/off",
   CurrentValue = AutoBlocksettings.Enabled,
   Flag = "Toggle1",
   Callback = function(Value)
     AutoBlocksettings.Enabled = Value
   end,
})

Main:CreateSlider({
   Name = "RangeAB",
   Range = {0, 100},
   Increment = 1,
   Suffix = "m",
   CurrentValue = AutoBlocksettings.Range,
   Flag = "Slider1",
   Callback = function(Value)
     AutoBlocksettings.Range = Value
   end,
})
Main2:CreateToggle({
   Name = "AutoAttack On/off",
   CurrentValue = AutoAttackSettings.Enabled,
   Flag = "Toggle1",
   Callback = function(Value)
     AutoAttackSettings.Enabled = Value
   end,
})
Main2:CreateSlider({
   Name = "RangeAA",
   Range = {0, 100},
   Increment = 5,
   Suffix = "m",
   CurrentValue = AutoAttackSettings.Range,
   Flag = "Slider1",
   Callback = function(Value)
     AutoAttackSettings.Range = Value
   end,
})
Main2:CreateSlider({
   Name = "CDAA",
   Range = {0.1, 1},
   Increment = 0.1,
   Suffix = "m",
   CurrentValue = AutoAttackSettings.Cooldown,
   Flag = "Slider1",
   Callback = function(Value)
     AutoAttackSettings.Cooldown = Value
   end,
})
