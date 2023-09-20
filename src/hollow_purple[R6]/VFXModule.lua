local Animations = script:WaitForChild("Animations")
local Meshes = script.Meshes

local KeyProvider = game:GetService("KeyframeSequenceProvider")

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local rp = game:GetService("ReplicatedStorage")
local VFX = rp:WaitForChild("VFX")
local rf = game:GetService("ReplicatedFirst")
local rd = require(rf:WaitForChild("Ragdoll"))

local dmgMulti = 3

local VFXModule = {
	Anims = {
		HPAnim = Animations.HPAnim
	}
}

function VFXModule.getAnimation(Humanoid)
	local length = 0

	local keysequence = KeyProvider:GetKeyframeSequenceAsync(VFXModule.Anims.HPAnim.AnimationId)
	local keyframes = keysequence:GetKeyframes()

	for i=1, #keyframes do
		local Time = keyframes[i].Time
		if Time > length then
			length = Time - .1
		end
	end

	return Humanoid.Animator:LoadAnimation(VFXModule.Anims.HPAnim),length
end

function VFXModule.createOrbs(Folder,Humrp,direction,Player,Character)
	local Sphere3 = Meshes.Sphere3:Clone()
	Sphere3.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(5,0,5))
	local spherePos = Sphere3.CFrame
	Sphere3.Parent = Folder

	local Sphere4 = Meshes.Sphere4:Clone()
	Sphere4.CFrame = Sphere3.CFrame
	Sphere4.Parent = Folder

	local Cel = Meshes.CelShade2:Clone()
	Cel.CFrame = Sphere3.CFrame
	Cel.Parent = Folder

	local Effects = Meshes.Effects2:Clone()
	Effects.CFrame = Sphere3.CFrame
	Effects.Parent = Folder

	local Sphere5 = Meshes.Sphere5:Clone()
	Sphere5.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(-5,0,5))
	local spherePos2 = Sphere5.CFrame
	Sphere5.Parent = Folder

	local Sphere6 = Meshes.Sphere6:Clone()
	Sphere6.CFrame = Sphere5.CFrame
	Sphere6.Parent = Folder

	local Cel2 = Meshes.CelShade3:Clone()
	Cel2.CFrame = Sphere5.CFrame
	Cel2.Parent = Folder

	local Effects2 = Meshes.Effects3:Clone()
	Effects2.CFrame = Sphere5.CFrame
	Effects2.Parent = Folder

	local CracklingSFX = Instance.new("Sound",Humrp)
	CracklingSFX.Name = "CracklingSFX"
	CracklingSFX.SoundId = "rbxassetid://525213244"
	CracklingSFX.PlaybackSpeed = 0.95
	CracklingSFX.Volume = 1
	Debris:AddItem(CracklingSFX,3)

	CracklingSFX:Play()

	TweenService:Create(Sphere3,TweenInfo.new(.75),{Size = Vector3.new(3,3,3)}):Play()
	TweenService:Create(Cel,TweenInfo.new(.75),{Size = Vector3.new(3.6,3.6,3.6)}):Play()
	TweenService:Create(Effects,TweenInfo.new(.75),{Size = Vector3.new(3.8,3.8,3.8)}):Play()

	TweenService:Create(Sphere5,TweenInfo.new(.75),{Size = Vector3.new(3,3,3)}):Play()
	TweenService:Create(Cel2,TweenInfo.new(.75),{Size = Vector3.new(3.6,3.6,3.6)}):Play()
	TweenService:Create(Effects2,TweenInfo.new(.75),{Size = Vector3.new(3.8,3.8,3.8)}):Play()

	function VFXModule.destroyOrbs(Folder,Humrp,direction,Player,Character)

		Sphere3.CFrame = spherePos
		Sphere5.CFrame = spherePos2

		local goal = {}
		goal.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(0,0,5))
		goal.Size = Sphere3.Size
		goal.Transparency = Sphere3.Transparency + (1 - Sphere3.Transparency)
		local info = TweenInfo.new(2,Enum.EasingStyle.Quint)

		local goal2 = {}
		goal2.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(0,0,5))
		goal2.Size = Sphere5.Size
		goal2.Transparency = Sphere5.Transparency + (1 - Sphere5.Transparency)
		local info2 = TweenInfo.new(2,Enum.EasingStyle.Quint)

		Sphere3.CFrame = spherePos
		Sphere5.CFrame = spherePos2

		TweenService:Create(Sphere3,info,goal):Play()
		TweenService:Create(Sphere4,info,goal):Play()
		TweenService:Create(Cel,info,goal):Play()
		TweenService:Create(Effects,info,goal):Play()

		TweenService:Create(Sphere5,info2,goal2):Play()
		TweenService:Create(Sphere6,info2,goal2):Play()
		TweenService:Create(Cel2,info2,goal2):Play()
		TweenService:Create(Effects2,info2,goal2):Play()
	end

end

function VFXModule.create(Folder,Humrp,direction,Player,Character)
	local length = 0

	local keysequence = KeyProvider:GetKeyframeSequenceAsync(VFXModule.Anims.HPAnim.AnimationId)
	local keyframes = keysequence:GetKeyframes()

	for i=1, #keyframes do
		local Time = keyframes[i].Time
		if Time > length then
			length = Time
		end
	end
	
	--[[Parts used in this build aren't available for download but you can replace them 
	    by using your own with the same name or by deleting some parts of the script.]]--

	local Sphere1 = Meshes.Sphere1:Clone()
	Sphere1.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(0,8,-16))
	local spherePos = Sphere1.CFrame
	Sphere1.Size = Vector3.new(1,1,1)
	Sphere1.Parent = Folder

	local Sphere2 = Meshes.Sphere2:Clone()
	Sphere2.CFrame = Sphere1.CFrame
	Sphere2.Size = Vector3.new(1.5,1.5,1.5)
	Sphere2.Parent = Folder


	local Cel = Meshes.CelShade:Clone()
	Cel.CFrame = Sphere1.CFrame
	Cel.Size = Vector3.new(1.6,1.6,1.6)
	Cel.Parent = Folder

	local Wind = Meshes.Wind:Clone()
	Wind.CFrame = Sphere1.CFrame
	Wind.Size = Vector3.new(1.7,1.7,1.7)
	Wind.Parent = Folder

	local Wind2 = Meshes.Wind2:Clone()
	Wind2.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(0,8,-10))
	Wind2.Transparency = 1
	Wind2.Parent = Folder

	local Effects = Meshes.Effects:Clone()
	Effects.CFrame = Sphere1.CFrame
	Effects.Size = Vector3.new(1.7,1.7,1.7)
	Effects.Parent = Folder

	local Hitbox = Meshes.Hitbox:Clone()
	Hitbox.CFrame = Sphere1.CFrame
	Hitbox.Size = Vector3.new(1.7,1.7,1.7)
	Hitbox.Parent = Folder

	local weld1 = Instance.new("ManualWeld",Sphere1)
	weld1.Part0 = Sphere1
	weld1.Part1 = Sphere2

	local weld2 = Instance.new("ManualWeld",Sphere1)
	weld2.Part0 = Sphere1
	weld2.Part1 = Cel

	local weld3 = Instance.new("ManualWeld",Sphere1)
	weld3.Part0 = Sphere1
	weld3.Part1 = Wind

	local weld4 = Instance.new("ManualWeld",Sphere1)
	weld4.Part0 = Sphere1
	weld4.Part1 = Effects

	local weld5 = Instance.new("ManualWeld",Sphere1)
	weld5.Part0 = Sphere1
	weld5.Part1 = Hitbox

	TweenService:Create(Sphere1,TweenInfo.new(1),{Size = Vector3.new(25,25,25)}):Play()
	TweenService:Create(Sphere2,TweenInfo.new(1),{Size = Vector3.new(22.5,22.5,22.5)}):Play()
	TweenService:Create(Cel,TweenInfo.new(1),{Size = Vector3.new(25.5,25.5,25.5)}):Play()
	TweenService:Create(Wind,TweenInfo.new(1),{Size = Vector3.new(25.8,25.8,25.8)}):Play()
	TweenService:Create(Effects,TweenInfo.new(1),{Size = Vector3.new(25.7,25.7,25.7)}):Play()
	TweenService:Create(Hitbox,TweenInfo.new(1),{Size = Vector3.new(25.6,25.6,25.6)}):Play()

	print("Move Created!")

	function VFXModule.Shoot(Folder,Humrp,direction,Player,Character)
		Sphere1.CFrame = spherePos

		local Players = game:GetService("Players")

		local connection

		connection = RunService.Heartbeat:Connect(function()
			Sphere1.CFrame = Sphere1.CFrame * CFrame.Angles(0,math.rad(-10),0)
		end) 

		local ShootSFX = Instance.new("Sound",Sphere1)
		ShootSFX.Name = "ShootSFX"
		ShootSFX.SoundId = "rbxassetid://6238439756"
		ShootSFX.TimePosition = 0.75
		ShootSFX.PlaybackSpeed = 1
		ShootSFX.Volume = 5
		Debris:AddItem(ShootSFX,2)

		ShootSFX:Play()

		local Vel = Instance.new("BodyVelocity",Sphere1)
		Vel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		Vel.Velocity = Humrp.CFrame.lookVector * 150

		Wind2.Transparency = 0
		TweenService:Create(Wind2,TweenInfo.new(1),{Transparency = 1, Size = Vector3.new(60,60,26)}):Play()

		Hitbox.Touched:Connect(function(hit)
			if hit then
				for _, Target in pairs(workspace:GetChildren()) do
					if Target:IsA("Model") and Target:FindFirstChild("Humanoid") then
						if Target ~= Character then
							local ehumanoid = Target:FindFirstChild("Humanoid")
							local ehumrp = Target:FindFirstChild("HumanoidRootPart")
							if ehumanoid and ehumrp then
								if(Hitbox.CFrame.p - ehumrp.CFrame.p).Magnitude <= 20 then
									if not ehumanoid:FindFirstChild(Player.Name.." Hollow Purple") then
										local debounce = Instance.new("BoolValue",ehumanoid)
										debounce.Name = Player.Name.." Hollow Purple"
										Debris:AddItem(debounce,4)
										
										rd.RagdollCharacter(ehumrp.Parent)

										local force = Instance.new("BodyVelocity")
										force.Name = "HP"
										force.Parent = ehumrp
										local dir = Humrp.CFrame.lookVector
										force.MaxForce = Vector3.new(1, 1, 1) * math.huge
										force.Velocity = (dir + Vector3.new(0, .75, 0)).Unit * (120)
										Debris:AddItem(force, .25)
										local timeknocked = 120 / 16

										task.delay(timeknocked, function()
											rd.UnRagdollCharacter(ehumrp.Parent)
										end)

									end
								end
							end
						end
					end
				end
			end
		end)
		delay(length / 4, function()
			if connection then
				Wind.Transparency = 0
				Sphere1.Anchored = true
				Sphere1:WaitForChild("BodyVelocity"):Destroy()
				Sphere2.Attachment.White:Destroy()
				Sphere2.Attachment.White2:Destroy()
				Sphere2.Attachment.Electricity:Destroy()
				TweenService:Create(Sphere1,TweenInfo.new(2),{Transparency = 1,Size = Vector3.new(75,75,75)}):Play()
				TweenService:Create(Sphere2,TweenInfo.new(2),{Transparency = 1,Size = Vector3.new(72.5,72.5,72.5)}):Play()
				TweenService:Create(Cel,TweenInfo.new(2),{Transparency = 1,Size = Vector3.new(75.5,75.5,75.5)}):Play()
				TweenService:Create(Wind,TweenInfo.new(2),{Transparency = 1,Size = Vector3.new(75.8,75.8,75.8)}):Play()
				TweenService:Create(Effects,TweenInfo.new(2),{Transparency = 1,Size = Vector3.new(75.7,75.7,75.7)}):Play()
				Hitbox:Destroy()
				wait(2)
				connection:Disconnect()
			end
		end)
	end
end

function VFXModule.Rocks(Folder,Humrp)
	local length = 0

	local keysequence = KeyProvider:GetKeyframeSequenceAsync(VFXModule.Anims.HPAnim.AnimationId)
	local keyframes = keysequence:GetKeyframes()

	for i=1, #keyframes do
		local Time = keyframes[i].Time
		if Time > length then
			length = Time
		end
	end

	local Trace = Meshes.Trace:Clone()
	Trace.Size = Vector3.new(25.6,25.6,25.6)
	Trace.CFrame = Humrp.CFrame:ToWorldSpace(CFrame.new(0,8,-20))
	Trace.Parent = Folder
	Debris:AddItem(Trace, length / 2)

	local Vel = Instance.new("BodyVelocity")
	Vel.Parent = Trace
	Vel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	Vel.Velocity = Humrp.CFrame.lookVector * 125

	local rayparams = RaycastParams.new()
	rayparams.FilterDescendantsInstances = {Folder}
	rayparams.FilterType = Enum.RaycastFilterType.Exclude

	for i=1, 25 do
		local Rocks = Meshes.Rocks:Clone()
		local size = 7
		Rocks.Position = Trace.Position - Vector3.new(0,10,0)

		local ray = workspace:Raycast(Rocks.CFrame.p,Rocks.CFrame.upVector * -5, rayparams)
		if ray then
			Rocks.CFrame = Trace.CFrame * CFrame.new(0,-size + -10,0)
			Rocks.Material = ray.Instance.Material
			Rocks.Color = ray.Instance.Color
			Rocks.Parent = Folder

			TweenService:Create(Rocks,TweenInfo.new(.5),{Position = Rocks.Position + Vector3.new(0,size - 2,0)}):Play()
			delay(2,function()
				TweenService:Create(Rocks,TweenInfo.new(.5),{Transparency = 1, Position = Rocks.Position + Vector3.new(0,-size,0)}):Play()
			end)
		end
		wait(0.08)
	end

end

return VFXModule