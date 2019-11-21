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

local module = {}

module.Average = function(a,b,c)-- a=0, b=0, c=0
local Players = game.Players:GetChildren() --Get all players

for i=1,#Players do
	if game.ServerScriptService:FindFirstChild("Artic's Anti-Fly"):FindFirstChild(tostring(Players[i])) ~= nil then --Check if Player exists in main script
	local Y = game.ServerScriptService:FindFirstChild("Artic's Anti-Fly"):FindFirstChild(tostring(Players[i])):FindFirstChild("RestrictedArea"):FindFirstChild("Y").Value -- Get value of player's Y value
	a = a + tonumber(Y) -- A letter represents a sum of all valueses in game 
	c = #Players -- C letter represents number of all players in game
	end
end

return a/c -- returns average Y value of all players in game 

end

return module
