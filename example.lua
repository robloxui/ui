--[[
  My UI Configuration Script

  This script initializes the Draggable UI Framework and provides it with
  the specific title and button actions for this UI.
]]

-- IMPORTANT: You must place the "DraggableUIFramework.lua" module script
-- in a location like ReplicatedStorage. Update the path below to match
-- where you've saved the file.
local FRAMEWORK_PATH = game.ReplicatedStorage.DraggableUIFramework
local draggableUIFramework = require(FRAMEWORK_PATH)

-- Check if the framework was successfully loaded before continuing.
if not draggableUIFramework then
    warn("DraggableUIFramework not found. Please ensure the 'DraggableUIFramework.lua' module script is in ReplicatedStorage and spelled correctly.")
    return
end

-- Define your UI configuration here.
local config = {
    -- The title of your UI, which will be displayed in the frame.
    title = "My Custom UI",

    -- A list of buttons to create.
    -- Each button needs a "name" and an "action" function.
    buttons = {
        {
            name = "Click Me!",
            action = function()
                print("The 'Click Me!' button was pressed.")
            end
        },
        {
            name = "Another Button",
            action = function()
                local newPart = Instance.new("Part")
                newPart.Position = Vector3.new(0, 5, 0)
                newPart.Parent = workspace
                print("A new part was created.")
            end
        },
        {
            name = "Close UI",
            action = function()
                -- Assuming 'DraggableGUIScript' is the ScreenGui created by the framework
                local ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("DraggableGUIScript")
                if ui then
                    local frame = ui:FindFirstChild("MainFrame")
                    if frame then
                        frame.Visible = false
                    end
                end
            end
        }
    }
}

-- Initialize the UI by calling the createUI function from the framework.
draggableUIFramework.createUI(config)

-- You can also call it on player respawn if you'd like.
local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(function()
    draggableUIFramework.createUI(config)
end)
