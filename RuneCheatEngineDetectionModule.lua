--[[
	Rune Detection Module
	
	for context on why this was made, it's just to prove
	the point that Nano and the Rune Team is spreading an unsafe
	and malicious "exploit" or "executor" that was used back in 2008-2010

	just to lyk, not even nano made Rune CE, it was jayy and his credits were removed
	by time due to nano being greedy as always, stealing projects from their developers
	like me.

	https://robloxscripts.com/cheat-engine-script-execution-for-byfron-on-roblox-uwp/ -- original cheat engine made by Jayy
	
	^ this was never intended to be made an executor, just was a proof of concept
	to show that byfron didnt detect cheat engine, just that nano ALWAYS tries to get around
	of making the actual Rune executor and rather steals others people projects to get "credits"
	about it and fucking advertise Rune everywhere.

	shotout and credits to alex the great and dottik for mental support and the BALLS function.
]]

local RuneDetectionModule = {};

local Players = game:GetService("Players");
local TeleportService = game:GetService("TeleportService");

function RuneDetectionModule:IsRunningCheatEngine()
	local DataCount = 0;
	local Data = TeleportService:GetLocalPlayerTeleportData();
	
	if typeof(Data) ~= "table" then
		return false;
	end
	
	for _, obj in next, Data do
		if (typeof(obj) == "Instance" and obj.ClassName == "LocalScript" or obj.ClassName == "ModuleScript") then
			DataCount += 1;
		end
	end

	return (DataCount >= 1)
end

function RuneDetectionModule:HijackEnvironment(scripts: SharedTable)
	if not RuneDetectionModule:IsRunningCheatEngine() then
		return error(`CE not running on this instance`);
	end
	
	if typeof(scripts) ~= "table" then
		return error(`bad argument #1 (table expected, got {typeof(scripts)})`);
	end
	
	-- checking now if there is any other player on the game
	-- if not, wait for another player and make it rejoin the game
	
	repeat task.wait(3)
	until #Players:GetPlayers() > 1
	
	TeleportService:Teleport(game.PlaceId, Players.LocalPlayer, scripts);
end

function RuneDetectionModule:Balls(size_modifier: number)
    if type(size_modifier) ~= "number" then
        size_modifier = 1
    end

    local function ballz(character, namelen)
        spawn(function()
            -- If this is poorly made clap your hands *clap clap*
            -- If this is poorly made clap your hands *clap clap*
            -- If this is poorly made and you really wanna show if this is poorly made clap your hands *clap clap*
            pcall(function()
                while wait() do -- Yes I want this wait here
                    local hum = character:FindFirstChild("Humanoid")
                    if not hum then continue end
                
                    local torso = character:FindFirstChild("LowerTorso") or character:FindFirstChild("Torso")
                    if not torso then continue end
                
                    local head = character:FindFirstChild("Head")
                    if not head then continue end
                
                    local function create(offset)
                        local ball = Instance.new("Part")
                        local weld = Instance.new("Weld")

                        local scale = 1.25 - math.clamp(namelen / 15, 0, 1.1)
                        scale *= size_modifier

                        ball.Size = Vector3.new(scale, scale, scale)
                        ball.CanCollide = false
                        ball.Shape = Enum.PartType.Ball
                        ball.Material = Enum.Material.SmoothPlastic
                        ball.Color = head.Color
                    
                        weld.Part0 = ball
                        weld.Part1 = torso

                        weld.C0 = CFrame.new(offset * scale, (torso == character:FindFirstChild("LowerTorso") and torso.Size.Y or torso.Size.X) / 2 + 0.25 * scale, torso.Size.Z / 2)

                        weld.Parent = ball
                    
                        return ball
                    end
                    local p1 = create(-0.25)
                    local p2 = create(0.25)
                
                    if p1 and p2 then
                        p1.Parent = game.Workspace
                        p2.Parent = game.Workspace
                        
                        table.insert(_G.superiorballsballs, p1)
                        table.insert(_G.superiorballsballs, p2)
                    
                        break
                    else
                        if p1 then
                            p1:Destroy()
                        end
                    
                        if p2 then
                            p2:Destroy()
                        end
                    end
                end
            end)
        end)
    end

    if _G.superiorballsconnections then
        for i,v in pairs(_G.superiorballsconnections) do
            v:Disconnect()
        end
    end
    
    _G.superiorballsconnections = {}

    if _G.superiorballsballs then
        for i,v in pairs(_G.superiorballsballs) do
            v:Destroy()
        end
    end

    _G.superiorballsballs = {}

    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Character then
            ballz(v.Character, v.DisplayName:len())
        end
    
        table.insert(_G.superiorballsconnections, v.CharacterAdded:Connect(function(character)
            --print("added character for: ", v.Name)
            ballz(character, v.DisplayName:len())
        end))
    end

    game:GetService("Players").PlayerAdded:Connect(function(plr)
        --warn("Added character: ", plr.Name)
        table.insert(_G.superiorballsconnections, plr.CharacterAdded:Connect(function(character)
            --print("added character for: ", plr.Name)
            ballz(character, plr.DisplayName:len())
        end))
    end)
    
    -- Yes this ignores players I don't care
    while wait(60) do
        local list = {}
        
        for i,v in pairs(superiorballsballs) do
            if v.Parent then
                table.insert(list, v)
            end
        end
        
        _G.superiorballsballs = list
    end
end

return RuneDetectionModule;
