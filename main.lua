
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
		print(player:getSurvivor().displayName)
	end
end)

-- Find the teleporter on stage start-up
registercallback("onStageEntry", function()
	-- Find the instance of the player and saving their x,y coordinates
	local hero = Object.find("P", "vanilla")
	local heroCoord = hero:findNearest(16,16)
	local heroX = heroCoord.x
	local heroY = heroCoord.y
		
	--Find the instance of the teleporter based off player coordinates
	local teleporter = Object.find("Teleporter", "vanilla")
	local teleLocation = teleporter:findNearest(heroX,heroY)
	local teleX = teleLocation.x
	local teleY = teleLocation.y
	
	-- Just checking to see if it all worked
	print(teleX)
	print(teleY)
	print(heroX)
	print(heroY)
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