--Put this script in ServerScriptService please, okay?
local Module = require(script:FindFirstChild("Average"):WaitForChild("ModuleScript"))

local MaxY = 12 --IMPORTANT: (You will have to change this 100%) Change this to an value to where maximum Y normal player can achieve also include their jump which about 3 studs 


local MaxBoolCaughts = 3 -- Chnage this to how many times you allow player to do mistake before adding a score to script counter
local MaxCounter = 4 -- Change this to maximum counter (caughts)

--**Don't change these if you are not sure what you are doing**
--If player goes lower of any of those values while deviding values with other players makes it suspicious and and has higher chance of getting kicked  
--Minimum value is 0 and maximum 1 at this valueses, please keep it same as they are or try to experiment with changing small values (decimal valueses)

local AvreageDifference = 0.60 --This value is checking while diveding average value with localplayer's Y axis position
local AverageBoolAndGameTime = 0.50 -- This value is checking diveding time in restricted area with whole game time

--               _   _      _                      _   _        ______ _       
--    /\        | | (_)    ( )         /\         | | (_)      |  ____| |      
--   /  \   _ __| |_ _  ___|/ ___     /  \   _ __ | |_ _ ______| |__  | |_   _ 
--  / /\ \ | '__| __| |/ __| / __|   / /\ \ | '_ \| __| |______|  __| | | | | |
-- / ____ \| |  | |_| | (__  \__ \  / ____ \| | | | |_| |      | |    | | |_| |
--/_/    \_\_|   \__|_|\___| |___/ /_/    \_\_| |_|\__|_|      |_|    |_|\__, |
--                                                                        __/ |
--                                                                       |___/ 
--  Artic's Anti-Fly is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.

--  Artic's Anti-Fly is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.

--  You should have received a copy of the GNU General Public License
--  along with Artic's Anti-Fly.  If not, see <https://www.gnu.org/licenses/>.

game.Players.PlayerAdded:Connect(function(Player)
    local ValueS = Instance.new("IntValue") -- This value represents value of how many suspicous caughts for exploiting player recieved 
    local BoolCounter = Instance.new('IntValue')-- This value represents how many time player was in restricted area
    local BoolTurnedOFF = Instance.new('IntValue')-- This value represents how many time player was NOT in restricted area
    local Yaxis = Instance.new("IntValue") -- This value represents Localplayer's Y axis 
    local InGameTime = Instance.new('IntValue') -- This value represents how long player was in game
    local OnTouchedTime = Instance.new('IntValue') -- This value represents time when player goes in restricted area
    local OnOutTouchedTime = Instance.new('IntValue') --This value represents exact time when player leaves restricted area 
    local BoolValueS = Instance.new('BoolValue') -- This value is turned on TRUE when player is in restricted area else it turned on FALSE

    ValueS.Parent = script
    ValueS.Name = Player.Name
    
    BoolValueS.Parent = ValueS
    BoolValueS.Name = "RestrictedArea"

    BoolCounter.Parent = BoolValueS
    BoolCounter.Name = "Time"
    
    BoolTurnedOFF.Parent = BoolValueS
    BoolTurnedOFF.Name = "TurnedOFF"

    InGameTime.Parent = BoolValueS
    InGameTime.Name = "TimeInGame"

    Yaxis.Parent = BoolValueS
    Yaxis.Name = "Y"

    OnTouchedTime.Parent = BoolValueS
    OnTouchedTime.Name = "OnTouchedTime" 

    OnOutTouchedTime.Parent = BoolValueS
    OnOutTouchedTime.Name = "OnOutTouchedTime"

Player.CharacterAdded:Connect(function(Character)
   

local function WeldToHuman(A,B) 
    B.CFrame = A.CFrame
    local  Weld = Instance.new("Weld")
    Weld.Part0 = A
    Weld.C0 = A.CFrame:Inverse()
    Weld.Part1 = B
    Weld.C1 = B.CFrame:Inverse()
    Weld.Parent = A
    return Weld
end

WeldToHuman(Character:FindFirstChild("HumanoidRootPart"),Instance.new("Part",Character))
Character:WaitForChild("Part").Transparency = 1
Character:WaitForChild("Part").Locked = true


while true do
wait(1)

local function YaxisExists()
   if (Character:FindFirstChild('HumanoidRootPart')) ~= nil then --Check if HumanoidRootPart exists in player
     local Yaxis = Character:FindFirstChild('HumanoidRootPart').Position.Y
     return Yaxis
   else
	if (Character:FindFirstChild("Part")) ~= nil then
	  local YPartPosition = Character:FindFirstChild("Part").Position.Y --Check if Part exists in player
	  return YPartPosition
	     end
	end
  return false
end

local success, message = pcall(YaxisExists)
Yaxis.Value = message
script:FindFirstChild("Average").Value = tonumber(Module.Average(0,0,0))-- Call to get average value of all Y axis

if (success) ~= true then
	if (script:FindFirstChild(Player.Name)) ~= nil then -- Check if player's value still exists in script
     script[Player.Name]:Destroy() -- Destroy player from server's script
	 warn('Player: '.. Player.Name .. ' was caught exploiting with HumanoidRootPart')
     Player:Kick("We caught you exploiting with HumanoidRootPart")
	 --Add here things to happen once player is kicked or in PlayerRemoving function
   end
end

if (BoolTurnedOFF.Value) > 40 then --Check if palyer is in safe area for 40 seconds
	if (ValueS.Value) > 0 then -- Check if caughtsa are equals to 0
	ValueS.Value = ValueS.Value - 1
	BoolTurnedOFF.Value = 0
	end
end

while (BoolValueS.Value) == false do
	script:FindFirstChild("Average").Value = tonumber(Module.Average(0,0,0)) -- Call to get average value of all Y axis
	local success, message = pcall(YaxisExists)
	wait(1)
    InGameTime.Value = InGameTime.Value + 1 
	BoolTurnedOFF.Value = BoolTurnedOFF.Value + 1  
	
if (BoolTurnedOFF.Value) > 40 then --Check if palyer is in safe area for 40 seconds
	if (ValueS.Value) > 0 then -- Check if caughtsa are equals to 0
	ValueS.Value = ValueS.Value - 1
	BoolTurnedOFF.Value = 0
	end
end
	
	if (success) ~= false then -- Check if Y value exists
	 if (message) > (MaxY) then -- Check if  localplayer's Y axis is higher than Server's Max Y height
		if (BoolValueS.Value) ~= true or (BoolValueS.Value) ~= false then -- Pretty much useless if statment but okay		
		 BoolValueS.Value = true
		if (OnTouchedTime.Value) == 0 then -- Check if value was changed or not
		 OnTouchedTime.Value = BoolCounter.Value -- Changes time to time once player entered in restricted area 
		end
	     if (ValueS.Value) > (MaxCounter) then -- Check if player got caught as it's Server's max number of caughts 
		  if (BoolCounter.Value/InGameTime.Value) < (AverageBoolAndGameTime) then -- Devided Time how many time player was in restricted area with his whole game time 
			local avg = script.Average.Value
			if (avg/message) < (AvreageDifference) then -- Average value devided with player's current Y axis value
			if (script:FindFirstChild(Player.Name)) ~= nil then -- Check if player's value still exists in script
		       script[Player.Name]:Destroy() -- Destroy player from server's script
		       warn('Player: '.. Player.Name .. ' was caught exploiting')
		       Player:Kick("We caught you exploiting")
		       --Add here things to happen once player is kicked or in PlayerRemoving function
		        end
		      end
		     end
		   end
	    end
     end
   end
end

while (BoolValueS.Value) == true do
	script:FindFirstChild("Average").Value = tonumber(Module.Average(0,0,0))-- Call to get average value of all Y axis
	local success, message = pcall(YaxisExists)-- success = true or false, message = avreage value of Y axis 
	wait(1)
	
    InGameTime.Value = InGameTime.Value + 1
 if (Character:FindFirstChild("Humanoid").FloorMaterial) == Enum.Material.Air then
	if (Character:FindFirstChild("HumanoidRootPart").Velocity.Y) == 0 or (Character:FindFirstChild("Part").Velocity.Y) == 0 or ((0 < (Character:FindFirstChild("Part").Velocity.Y) and (Character:FindFirstChild("Part").Velocity.Y)  < 0.11)) or ((0 < (Character:FindFirstChild("HumanoidRootPart").Velocity.Y) and (Character:FindFirstChild("HumanoidRootPart").Velocity.Y) < 0.11)) then
	BoolCounter.Value = BoolCounter.Value + 1
	end
end

  if (BoolCounter.Value) > (MaxBoolCaughts) then --Check for how many times player was caught in restricted area if above MaxBoolCaughts it adds + 1 to ValueS's value
	ValueS.Value = ValueS.Value + 1
	BoolCounter.Value = 0
	wait(1)
 end

if (BoolTurnedOFF.Value) > 40 then --Check if palyer is in safe area for 40 seconds
	if (ValueS.Value) > 0 then -- Check if caughtsa are equals to 0
	ValueS.Value = ValueS.Value - 1
	BoolTurnedOFF.Value = 0
	end
end
	
    if (message) < (MaxY) then -- Check if player is still in restricted area
	  BoolValueS.Value = false
	  OnOutTouchedTime.Value = InGameTime.Value
	  local Counters = OnOutTouchedTime.Value-OnTouchedTime.Value
	if (Counters) > 100 then  -- Check how long player was in restricted area 
	  while (Counters) > 100 do -- Loop for penalty if there is one of coruse
	   ValueS.Value = ValueS.Value + 1
	   Counters = Counters - 100
	   wait(0.1)
	  end
	end
	  OnOutTouchedTime.Value = 0
	  OnTouchedTime.Value = 0 
   end
    
 	if (success) ~= false then -- Check if Y value exists
	 if (message) > (MaxY) then -- Check if  localplayer's Y axis is higher than Server's Max Y height
		if (BoolValueS.Value) ~= true or (BoolValueS.Value) ~= false then -- Pretty much useless if statment but okay		
		 BoolValueS.Value = true
		if (OnTouchedTime.Value) == 0 then -- Check if value was changed or not
		 OnTouchedTime.Value = BoolCounter.Value -- Changes time to time once player entered in restricted area 
		end
	     if (ValueS.Value) > (MaxCounter) then -- Check if player got caught as it's Server's max number of caughts 
		  if (BoolCounter.Value/InGameTime.Value) < (AverageBoolAndGameTime) then -- Devided Time how many time player was in restricted area with his whole game time 
			local avg = script.Average.Value
			if (avg/message) < (AvreageDifference) then -- Average value devided with player's current Y axis value
			if (script:FindFirstChild(Player.Name)) ~= nil then -- Check if player's value still exists in script
		       script[Player.Name]:Destroy() -- Destroy player from server's script
		       warn('Player: '.. Player.Name .. ' was caught exploiting')
		       Player:Kick("We caught you exploiting")
		       --Add here things to happen once player is kicked or in PlayerRemoving function
		        end
		      end
		     end
		   end
	     end
       end
     end
   end
end	

   end)
end)
