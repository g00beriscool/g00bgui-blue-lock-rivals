pcall(function()
    local function runScript(url)
        loadstring(game:HttpGet(url))()
    end

    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = "BlueLockGUI"
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 420, 0, 320)
    Main.Position = UDim2.new(0.5, -210, 0.5, -160)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Main.BorderSizePixel = 0
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = "Blue Lock Rivals UI - by Nova"
    Title.TextColor3 = Color3.fromRGB(100, 200, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold

    local TabHolder = Instance.new("Frame", Main)
    TabHolder.Size = UDim2.new(0, 110, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    Instance.new("UICorner", TabHolder).CornerRadius = UDim.new(0, 8)

    local ContentHolder = Instance.new("Frame", Main)
    ContentHolder.Size = UDim2.new(1, -120, 1, -50)
    ContentHolder.Position = UDim2.new(0, 120, 0, 45)
    ContentHolder.BackgroundTransparency = 1

    local function makeTab(name, callback)
        local btn = Instance.new("TextButton", TabHolder)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, #TabHolder:GetChildren() * 35 - 35)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(200, 200, 255)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseButton1Click:Connect(callback)
    end

    local function switchContent(func)
        for _, child in pairs(ContentHolder:GetChildren()) do
            child:Destroy()
        end
        func()
    end

    -- Styles Tab
    makeTab("Styles", function()
        switchContent(function()
            local styles = {"NEL Isagi", "Rin", "Sae", "Don Lorenzo", "Gojo", "Ego Jinpachi"}
            for i, style in ipairs(styles) do
                local b = Instance.new("TextButton", ContentHolder)
                b.Size = UDim2.new(1, -20, 0, 30)
                b.Position = UDim2.new(0, 10, 0, (i - 1) * 35)
                b.Text = "Set Style: " .. style
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
                b.Font = Enum.Font.GothamBold
                b.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
                b.TextSize = 14
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

                if style == "Ego Jinpachi" then
                    b.MouseButton1Click:Connect(function()
                        runScript("https://your-url.com/egojinpachi.lua") -- Replace with actual script
                    end)
                else
                    b.MouseButton1Click:Connect(function()
                        game.Players.LocalPlayer.PlayerStats.Style.Value = style
                    end)
                end
            end
        end)
    end)

    -- Speed Hack Tab
    makeTab("Speed", function()
        switchContent(function()
            local b = Instance.new("TextButton", ContentHolder)
            b.Size = UDim2.new(1, -20, 0, 30)
            b.Position = UDim2.new(0, 10, 0, 0)
            b.Text = "Activate TP Walk Speed (0.67)"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.GothamBold
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
            b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function()
                local tspeed = 0.67
                local hb = game:GetService("RunService").Heartbeat
                local lplr = game:GetService("Players").LocalPlayer
                local chr = lplr.Character or lplr.CharacterAdded:Wait()
                local hum = chr:FindFirstChildWhichIsA("Humanoid")
                spawn(function()
                    while chr and hum and hum.Parent do
                        hb:Wait()
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection * tspeed)
                        end
                    end
                end)
            end)
        end)
    end)

    -- Hollow Purple Tab
    makeTab("Hollow Purple", function()
        switchContent(function()
            local b = Instance.new("TextButton", ContentHolder)
            b.Size = UDim2.new(1, -20, 0, 30)
            b.Position = UDim2.new(0, 10, 0, 0)
            b.Text = "Use Hollow Purple (Get Ball)"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.GothamBold
            b.BackgroundColor3 = Color3.fromRGB(80, 30, 100)
            b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function()
                local args = {[1] = game.Players.LocalPlayer.Character}
                game:GetService("ReplicatedStorage"):WaitForChild("BallSystem"):WaitForChild("BallEvents"):WaitForChild("GetBall"):FireServer(unpack(args))
            end)
        end)
    end)

    -- Utility Tab
    makeTab("Utility", function()
        switchContent(function()
            local y = 0

            local function makeButton(txt, callback)
                local b = Instance.new("TextButton", ContentHolder)
                b.Size = UDim2.new(1, -20, 0, 30)
                b.Position = UDim2.new(0, 10, 0, y)
                y = y + 40
                b.Text = txt
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
                b.Font = Enum.Font.GothamBold
                b.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
                b.TextSize = 14
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
                b.MouseButton1Click:Connect(callback)
            end

            makeButton("Equip Angel Wings", function()
                cloneref(game:GetService("ReplicatedStorage")).Packages.Knit.Services.CustomizationService.RE.Customize:FireServer("Cosmetics", "Angel Wings")
            end)

            makeButton("Extend Ball (Goalkeeper)", function()
                loadstring(game:HttpGet("https://pastebin.com/raw/T5m4nwPq"))()
            end)

            makeButton("No Ability Cooldown", function()
                local AbilityController = require(cloneref(game:GetService("ReplicatedStorage")).Controllers.AbilityController)
                hookfunction(AbilityController.AbilityCooldown, function()
                    return 0
                end)
            end)

            makeButton("Toggle Ball Hitbox Size", function()
                local ball = workspace:FindFirstChild("Ball")
                if not ball then return end
                local originalBallSize = ball.Size
                local isBig = false

                local function modifyHitbox(enable)
                    if enable then
                        ball.Size = originalBallSize * 4
                    else
                        ball.Size = originalBallSize
                    end
                end

                isBig = not isBig
                modifyHitbox(isBig)
            end)
        end)
    end)
end)
