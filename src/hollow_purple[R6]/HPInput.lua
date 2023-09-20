--Detects input for our Hollow Purple Ability

local UIS = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local rp = game:GetService("ReplicatedStorage")
local Rojo = rp:WaitForChild("RojoRemoteEvents")
local HollowPurple = Rojo:FindFirstChild("HollowPurple")
local CursedEnergyDeduct = rp:WaitForChild("CEDeduct")

local debounce = false
local cooldown = 10

function cameraShake()
	local Character = Player.Character or Player.CharacterAdded:wait()
	local Humanoid = Character:FindFirstChild("Humanoid")
	
	local length = 95
	for i=1, length do
		Humanoid.CameraOffset = Vector3.new(0,0,0)
		local shake = math.random(-50,50)/100
		Humanoid.CameraOffset = Humanoid.CameraOffset + Vector3.new(shake,shake,shake)
		wait()
	end
	Humanoid.CameraOffset = Vector3.new(0,0,0)
	
end

UIS.InputBegan:Connect(function(input,isTyping)
	if not isTyping then
		if input.KeyCode == Enum.KeyCode.G then
			if debounce == false then
				debounce = true
				local PlrStats = Player:WaitForChild("PlrStats")
				local CursedEnergy = PlrStats:WaitForChild("CursedEnergy")
				local MaxCursedEnergy = PlrStats:WaitForChild("MaxCursedEnergy")

				local CEDeducted = math.floor(MaxCursedEnergy.Value * 0.2) + 30
				
				if CursedEnergy.Value >= CEDeducted then
					CursedEnergyDeduct:FireServer(CEDeducted)
			
				spawn(function()
					wait(3.5)
					cameraShake()
				end)
					
				HollowPurple:FireServer(Mouse.Hit)
				print("Move Fired!")
				else
					return
				end
			end
		end
	end
end)

HollowPurple.OnClientEvent:Connect(function()
	wait(cooldown)
	debounce = false
end)