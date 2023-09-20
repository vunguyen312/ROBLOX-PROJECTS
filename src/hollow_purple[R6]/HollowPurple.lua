--Receives the input from the RemoteEvent and fires the visual module

local rp = game:GetService("ReplicatedStorage")
local Specs = rp:WaitForChild("Specs")
local HollowPurple = Specs:FindFirstChild("HollowPurple")
local Debris = game:GetService("Debris")

local VFXModule = require(script.VFXModule)

HollowPurple.OnServerEvent:Connect(function(Player,direction)
	local Character = Player.Character or Player.CharacterAdded:wait()
	local Humanoid = Character.Humanoid
	local Humrp = Character.HumanoidRootPart
	
	Humanoid.WalkSpeed = 0
	
	wait(.5)
	local Action, length = VFXModule.getAnimation(Humanoid)
	Action:Play()
	
	local Folder = Instance.new("Folder")
	Folder.Name = Player.Name.."Hollow Purple"
	Folder.Parent = workspace
	game.Debris:AddItem(Folder,8)
	
	local Electricity = script.VFXModule.Meshes.Electricity
	local NewParticles = Electricity:Clone()
	NewParticles.Parent = Humrp
	Debris:AddItem(NewParticles, length)

	--Sorry for anybody looking at the code below
		
	spawn(function()
		Action:GetMarkerReachedSignal("CreateOrbs"):Connect(function()
			VFXModule.createOrbs(Folder,Humrp,direction,Player,Character)
			Action:GetMarkerReachedSignal("DestroyOrbs"):Connect(function()
				VFXModule.destroyOrbs(Folder,Humrp,direction,Player,Character)
				Action:GetMarkerReachedSignal("SpawnOrb"):Connect(function()
					VFXModule.create(Folder,Humrp,direction,Player,Character)
					Action:GetMarkerReachedSignal("FireOrb"):Connect(function()
						VFXModule.Shoot(Folder,Humrp,direction,Player,Character)
						VFXModule.Rocks(Folder,Humrp)
					end)
				end)
			end)
		end)
	end)
	wait(length)
	Humanoid.WalkSpeed = 16
	HollowPurple:FireClient(Player)
end)
