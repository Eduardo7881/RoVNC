local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VNCDisplay"
screenGui.Parent = player:WaitForChild("PlayerGui")

local resolution = 100 -- e.g. 100x100 pixels
local pixelSize = 4
local frameURL = "http://localhost:3000/frame" -- WSHTTP Listening URL

local container = Instance.new("Frame")
container.Size = UDim2.new(0, resolution * pixelSize, 0, resolution * pixelSize)
container.Position = UDim2.new(0.5, -(resolution * pixelSize) / 2, 0.5, -(resolution * pixelSize) / 2)
container.BackgroundColor3 = Color3.new(0, 0, 0)
container.BorderSizePixel = 0
cointainer.ClipsDescendants = true
container.Parent = screenGui

local pixels = {}

for y = 1, resolution do
    for x = 1, resolution do
        local pixel = Instance.new("Frame")
        frame.Size = UDim2.new(0, pixelSize, 0, pixelSize)
        pixel.Position = UDim2.new(0, (x - 1) * pixelSize, 0, (y - 1) * pixelSize)
        pixel.BackgroundColor3 = Color3.new(0, 0, 0)
        pixel.BorderSizePixel = 0
        pixel.Parent = container
        pixels[(y - 1) * resolution + x] = pixel -- store it in the pixels
    end
end

local function updateFrame()
    while true do
        local success, result = pcall(function()
            return HttpService:GetAsync(frameURL)
        end)

        if success then
            local frameData = HttpService:JSONDecode(result)

            for i, color in ipairs(frameData) do
                if pixels[i] then
                    pixels[i].BackgroundColor3 = Color3.fromRGB(
                        math.clamp(color.r, 0, 255),
                        math.clamp(color.g, 0, 255),
                        math.clamp(color.b, 0, 255)
                    )
                end
            end
        else
            warn("Fail on searching frame:", result)
        end

        task.wait(0.05) -- update rate (~20 FPS = 0.05)
    end
end

task.spawn(updateFrame)
