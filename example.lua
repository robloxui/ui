local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local uiModule = nil

-- The main function to initialize and run the UI
local function Init(config)
    -- Check if the module has already been loaded
    if uiModule then
        return uiModule
    end

    local success, loadedModule = pcall(function()
        -- Load and execute the code directly from the URL
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxui/ui/main/ui.lua"))()
    end)
    
    if not success then
        warn("Failed to load and execute UI module: " .. tostring(loadedModule))
        return nil
    end

    if not loadedModule then
        warn("UI module did not return a valid table.")
        return nil
    end

    -- If the module has an Init function, call it
    if loadedModule.Init then
        loadedModule:Init(config)
    else
        warn("UI module does not have an 'Init' function.")
    end

    uiModule = loadedModule
    return uiModule
end

local config = {
    title = "My UI",
    buttons = {
        {name = "Button 1", action = function() print("Button 1 pressed") end},
        {name = "Button 2", action = function() print("Button 2 pressed") end},
        {name = "Button 3", action = function() print("Button 3 pressed") end},
    }
}

-- Initialize the UI
Init(config)
