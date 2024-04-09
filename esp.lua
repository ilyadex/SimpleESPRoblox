local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
 
local RunService = game:GetService("RunService")
 
local playerSquares = {}
 
local function showPlayers()
    local function drawPlayers()
        for _, squareInfo in pairs(playerSquares) do
            squareInfo.Square:Destroy()
        end
        playerSquares = {}
 
        local localPlayer = game.Players.LocalPlayer
 
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local character = player.Character
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
 
                        local position = game.Workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
 
                        local sizeY = rootPart.Size.Y * 5.0 
                        local sizeX = rootPart.Size.X * 5.0
 
                        local playerSquare = Instance.new("Frame")
                        playerSquare.Size = UDim2.new(0, sizeX, 0, sizeY)
                        playerSquare.Position = UDim2.new(0, position.X - sizeX / 2, 0, position.Y - sizeY / 2)  
                        playerSquare.AnchorPoint = Vector2.new(0.5, 0.5)
                        playerSquare.BackgroundColor3 = Color3.new(1, 0, 0)
                        playerSquare.BackgroundTransparency = 0.5
                        playerSquare.Parent = screenGui
 
                        if player ~= localPlayer then
                            playerSquares[player] = {Square = playerSquare}
                        end
                    end
                end
            end
        end
    end
 
    drawPlayers()
 
    RunService.RenderStepped:Connect(function()
        drawPlayers()
    end)
end
 
showPlayers()
