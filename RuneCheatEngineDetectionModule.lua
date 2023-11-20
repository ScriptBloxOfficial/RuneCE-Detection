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
	
	if (DataCount >= 1) then
		return true;
	end
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

return RuneDetectionModule;
