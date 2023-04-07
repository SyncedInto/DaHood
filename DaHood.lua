if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 2788229376 then return end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mode = "On"

local BindableFunction = Instance.new("BindableFunction")

local Whitelist = {
	2701262075,
	3039600246
}

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local ChangeMode = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

ScreenGui.Parent = Player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Frame.Position = UDim2.new(0.456204385, 0, 0.578022003, 0)
Frame.Size = UDim2.new(0.0750782043, 0, 0.083516486, 0)

Frame.Active = true
Frame.Selectable = true
Frame.Draggable = true

UICorner.Parent = Frame

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 0.210650072, 0)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Connection"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Close.Name = "Close"
Close.Parent = Frame
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.Position = UDim2.new(0.877808452, 0, 0, 0)
Close.Size = UDim2.new(0.117163219, 0, 0.210650072, 0)
Close.AutoButtonColor = false
Close.Font = Enum.Font.FredokaOne
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000

ChangeMode.Parent = Frame
ChangeMode.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
ChangeMode.Position = UDim2.new(0.218187541, 0, 0.358628929, 0)
ChangeMode.Size = UDim2.new(0.558038473, 0, 0.480967373, 0)
ChangeMode.Font = Enum.Font.FredokaOne
ChangeMode.Text = "On"
ChangeMode.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeMode.TextScaled = true
ChangeMode.TextSize = 14.000
ChangeMode.TextWrapped = true

UICorner_2.Parent = ChangeMode



Close.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)

ChangeMode.MouseButton1Click:Connect(function()
	if Mode == "On" then
		Mode = "Ask"
		ChangeMode.Text = Mode
	elseif Mode == "Ask" then
		Mode = "Off"
		ChangeMode.Text = Mode
	elseif Mode == "Off" then
		Mode = "On"
		ChangeMode.Text = Mode
	end
end)

local function listenMessage(v, Message)
	if Message == "/e !hlp" and Mode ~= "Off" then
		local Character = Player.Character
		local vCharacter = v.Character

		if Character and vCharacter and Character:FindFirstChild("HumanoidRootPart") and vCharacter:FindFirstChild("HumanoidRootPart") then
			if Mode == "On" then
				Character.HumanoidRootPart.CFrame = vCharacter.HumanoidRootPart.CFrame
			elseif Mode == "Ask" then
				function BindableFunction.OnInvoke(Value)
					if Value == "Accept" then
						Character.HumanoidRootPart.CFrame = vCharacter.HumanoidRootPart.CFrame
					end
				end

				game:GetService("StarterGui"):SetCore("SendNotification",{
					Title = "Needs help!",
					Text = "Do you wanna TP to " .. Player.Name,
					Icon = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
					Duration = 10,
					Callback = BindableFunction,
					Button1 = "Accept",
					Button2 = "Deny"
				})
			end
		end
	end
end

for _, v in pairs(Players:GetPlayers()) do
	if table.find(Whitelist, v.UserId) and v ~= Player then
		v.Chatted:Connect(function(Message)
			listenMessage(v, Message)
		end)
	end
end

Players.PlayerAdded:Connect(function(v)
	if table.find(Whitelist, v.UserId) and v ~= Player then
		v.Chatted:Connect(function(Message)
			listenMessage(v, Message)
		end)
	end
end)

-- Input

local function chat(text)
	local StarterGui = game:GetService('StarterGui')
	local A = false
	local ChatBar = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Chat'):WaitForChild('Frame'):WaitForChild('ChatBarParentFrame'):WaitForChild('Frame'):WaitForChild('BoxFrame'):WaitForChild('Frame'):FindFirstChildOfClass('TextBox')
	A = StarterGui:GetCore('ChatActive')
	StarterGui:SetCore('ChatActive', true)
	ChatBar:CaptureFocus()
	
	local oldtext = ChatBar.Text
	
	ChatBar.Text = text
	ChatBar.TextEditable = false
	wait()
	ChatBar:ReleaseFocus(true)
	ChatBar.TextEditable = true
	wait()
	StarterGui:SetCore('ChatActive', A)
	ChatBar.Text = oldtext
end

local Can = true
UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Enum.KeyCode.G and not Paused then
		pcall(function()
			if Can then
				Can = false
				chat("/e !hlp")
				wait(5)
				Can = true
			end
		end)
	end

	if Input.KeyCode == Enum.KeyCode.RightShift and not Paused then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)
