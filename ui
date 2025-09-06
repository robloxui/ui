--[[
	Draggable UI Framework - Module

	This script is a reusable library that can be required by other scripts.
	It contains all the functions to create a draggable UI with customizable
	buttons and a clean theme.
--]]

-- SERVICES
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')

-- Get the local player and the PlayerGui.
local player = Players.LocalPlayer
local playerGui = player:WaitForChild('PlayerGui')

-- A table to hold our public functions.
local draggableUI = {}

-- THEME COLORS
local Colors = {
    -- A dark gray for the main background
    Frame = Color3.fromRGB(0, 0, 0),
    -- A dark gray for the button
    Button = Color3.fromRGB(25, 25, 25),
    -- A slightly lighter gray for hover
    ButtonHover = Color3.fromRGB(35, 35, 35),
    -- Pure white for text and other elements
    Text = Color3.fromRGB(255, 255, 255),
    -- A slightly lighter gray for the border stroke
    Stroke = Color3.fromRGB(50, 50, 50),
}

-- PRIVATE FUNCTIONS
-- A function to handle the dragging of a GUI element.
local function setupDraggable(element, dragHandle)
    local isDragging = false
    local initialMousePosition = Vector2.new(0, 0)
    local initialElementPosition = UDim2.new(0, 0, 0, 0)

    local connection = nil

    dragHandle.InputBegan:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            isDragging = true
            initialMousePosition = UserInputService:GetMouseLocation()
            initialElementPosition = element.Position

            -- Bring the UI to the front when dragging starts
            element:RaiseToTop()

            -- Create a new connection to smoothly move the UI
            connection = RunService.RenderStepped:Connect(function()
                if isDragging then
                    local mouseDelta = UserInputService:GetMouseLocation()
                        - initialMousePosition
                    local newPosition = UDim2.new(
                        initialElementPosition.X.Scale,
                        initialElementPosition.X.Offset + mouseDelta.X,
                        initialElementPosition.Y.Scale,
                        initialElementPosition.Y.Offset + mouseDelta.Y
                    )

                    -- Use Lerp to create the smooth, "heavenly" lag
                    element.Position = element.Position:Lerp(newPosition, 0.1)
                end
            end)
        end
    end)

    dragHandle.InputEnded:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            isDragging = false
            if connection then
                connection:Disconnect() -- Disconnect the connection when dragging stops
            end
        end
    end)
end

-- A function to handle the hover animations for a button.
local function setupHover(button)
    local defaultColor = button.BackgroundColor3
    local hoverTweenInfo =
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            hoverTweenInfo,
            { BackgroundColor3 = Colors.ButtonHover }
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService
            :Create(button, hoverTweenInfo, { BackgroundColor3 = defaultColor })
            :Play()
    end)
end

-- PUBLIC FUNCTIONS
function draggableUI.createUI(config)
    -- Clean up any existing UI to prevent duplicates
    if playerGui:FindFirstChild('DraggableGUIScript') then
        playerGui.DraggableGUIScript:Destroy()
    end

    local ScreenGui = Instance.new('ScreenGui')
    ScreenGui.Name = 'DraggableGUIScript'
    ScreenGui.Parent = playerGui

    -- MAIN BUTTON
    local DraggableButton = Instance.new('TextButton')
    DraggableButton.Name = 'DraggableButton'
    DraggableButton.AnchorPoint = Vector2.new(0.5, 0.5)
    DraggableButton.Position = UDim2.new(0.5, 0, 0.2, 0)
    DraggableButton.Size = UDim2.new(0, 100, 0, 40)
    DraggableButton.Text = 'Open UI'
    DraggableButton.TextColor3 = Colors.Text
    DraggableButton.BackgroundColor3 = Colors.Button
    DraggableButton.Font = Enum.Font.SourceSansBold
    DraggableButton.TextSize = 16
    DraggableButton.ZIndex = 2
    DraggableButton.BorderSizePixel = 0
    DraggableButton.Parent = ScreenGui

    -- Add rounded corners to the button
    local buttonCorner = Instance.new('UICorner')
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = DraggableButton

    -- MAIN GUI FRAME
    local MainFrame = Instance.new('Frame')
    MainFrame.Name = 'MainFrame'
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 250)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Visible = false
    MainFrame.ZIndex = 1
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Colors.Frame
    MainFrame.Parent = ScreenGui

    -- Add rounded corners, and stroke to the frame
    local frameCorner = Instance.new('UICorner')
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = MainFrame

    local frameStroke = Instance.new('UIStroke')
    frameStroke.Color = Colors.Stroke
    frameStroke.Thickness = 2
    frameStroke.Transparency = 0.5
    frameStroke.Parent = MainFrame

    -- Add a title to the main frame
    local titleLabel = Instance.new('TextLabel')
    titleLabel.Name = 'TitleLabel'
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = config.title or 'Draggable UI'
    titleLabel.TextColor3 = Colors.Text
    titleLabel.BackgroundColor3 = Colors.Button
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansSemibold
    titleLabel.BorderSizePixel = 0
    titleLabel.Parent = MainFrame

    -- Add padding to the button container
    local container = Instance.new('Frame')
    container.Name = 'ButtonContainer'
    container.Size = UDim2.new(1, 0, 1, -40)
    container.Position = UDim2.new(0, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = MainFrame

    -- Add a UIListLayout to organize the buttons
    local listLayout = Instance.new('UIListLayout')
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.Padding = UDim.new(0, 10)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Parent = container

    -- Loop through the buttons from the config and create them
    for _, buttonData in pairs(config.buttons or {}) do
        local button = Instance.new('TextButton')
        button.Name = buttonData.name:gsub(' ', '') .. 'Button'
        button.Text = buttonData.name
        button.Size = UDim2.new(1, -20, 0, 40)
        button.BackgroundColor3 = Colors.Button
        button.TextColor3 = Colors.Text
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.Parent = container

        -- Rounded corners
        local buttonCorner = Instance.new('UICorner')
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button

        -- Connect to the action function
        button.MouseButton1Click:Connect(buttonData.action)

        -- Add hover animations
        setupHover(button)
    end

    -- DRAG LOGIC
    -- Connect the drag logic to the main button and the GUI frame's title bar
    setupDraggable(DraggableButton, DraggableButton)
    setupDraggable(MainFrame, titleLabel)

    -- ANIMATION LOGIC
    local function animateGUI(isOpening)
        local sizeTweenInfo =
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local transparencyTweenInfo =
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        if isOpening then
            MainFrame.Visible = true
            TweenService:Create(
                MainFrame,
                sizeTweenInfo,
                { Size = UDim2.new(0, 400, 0, 250) }
            ):Play()
            TweenService:Create(
                MainFrame,
                transparencyTweenInfo,
                { BackgroundTransparency = 0 }
            ):Play()
        else
            TweenService
                :Create(
                    MainFrame,
                    sizeTweenInfo,
                    { Size = UDim2.new(0, 0, 0, 0) }
                )
                :Play()
            local transparencyTween = TweenService:Create(
                MainFrame,
                transparencyTweenInfo,
                { BackgroundTransparency = 1 }
            )
            transparencyTween:Play()
            transparencyTween.Completed:Wait()
            MainFrame.Visible = false
        end
    end

    -- OPEN/CLOSE LOGIC
    DraggableButton.MouseButton1Click:Connect(function()
        if MainFrame.Visible then
            animateGUI(false)
        else
            animateGUI(true)
        end
    end)

    -- BUTTON HOVER ANIMATIONS
    setupHover(DraggableButton)
end

return draggableUI
