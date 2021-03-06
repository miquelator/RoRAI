
---- Adds a new artifact which allows AI to control the singleplayer character

-- Creates a new artifact with the name Artifact of RoRAI
local artifact = Artifact.new("RoRAI")
-- Make the artifact be unlocked by default
artifact.unlocked = true

-- Set the artifact's loadout info
artifact.loadoutSprite = Sprite.load("RoRAI_artifact.png", 2, 18, 18)
artifact.loadoutText = "Controls the player so you don't have to!"


local lMove = 1
local rMove = 0

-- Anything under the onPlayerStep callback will be run on every frame
registercallback("onPlayerStep", function(player)
	local upMove = 0
	local maxJump = player:get("pVmax")*8
	--print("height", maxJump) -- it's 3

	-- left decreases x, down increase y 
	print("player.x, player.y", player.x , player.y)
	if artifact.active then
		-- All necessary code should begin below this comment line
		-- Move right until you hit a wall, then turn around--
		if rMove == 1 and Stage.collidesRectangle(player.x + 2, player.y - 4, player.x+7, player.y + 4 ) then
			rMove = 0
			lMove = 1
			print("moving right & hit rectangle:", player.x + 2, player.y - 4, player.x+7, player.y + 4)
		-- Move left until you hit a wall, then turn around--
		elseif lMove == 1 and Stage.collidesRectangle(player.x - 7, player.y - 4, player.x-2, player.y + 4) then
			lMove = 0
			rMove = 1
			print("moving left & hit rectangle:", player.x - 7, player.y - 4, player.x-2, player.y + 4)
		else
			print("conditional:", Stage.collidesRectangle(player.x + 2, player.y - 4 + 1, player.x+7, player.y + 4) == not Stage.collidesRectangle(player.x - 7, player.y - 4 + 1 , player.x-2, player.y + 4))
			if Stage.collidesRectangle(player.x + 2, player.y - 4 + 1, player.x+7, player.y + 4) == not Stage.collidesRectangle(player.x - 7, player.y - 4 + 1 , player.x-2, player.y + 4) then
				upMove = 1
				print("jumping")
			end
		end
		player:set("moveLeft", lMove)
		player:set("moveRight", rMove)
		--player:set("moveUp", upMove)
		print("Moves:", lMove, " ", rMove, " ", upMove)
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