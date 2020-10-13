
---- Adds a new artifact which allows AI to control the singleplayer character

-- Creates a new artifact with the name Artifact of RoRAI
local artifact = Artifact.new("RoRAI")
-- Make the artifact be unlocked by default
artifact.unlocked = true

-- Set the artifact's loadout info
artifact.loadoutSprite = Sprite.load("RoRAI_artifact.png", 2, 18, 18)
artifact.loadoutText = "Controls the player so you don't have to!"


-- Anything under the onPlayerStep callback will be run on every frame
registercallback("onPlayerStep", function(player)
	if artifact.active then
		-- All necessary code should begin below this comment line
		player:set("moveRight", 1)
	end
end)




--[[ below is sample code from the example mod

registercallback("onActorInit", function(actor)
	if artifact.active then
		local grav = actor:get("pGravity1")
		-- Check if the variable exists
		if grav ~= nil then
			-- Set the new gravity
			actor:set("pGravity1", grav * 0.5)
			-- Falling speed while holding jump
			actor:set("pGravity2", grav * 0.4)
		end
	end
end)
--]]