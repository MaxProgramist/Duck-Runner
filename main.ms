clear 
display(5).clear "#94fdff"

spriteDisplayList = display(4).sprites

curentSpeed = 2
maxSpeed = 18
speedOverTheMinute = 1/60/20

groundImg = file.loadImage("/usr/Textures/Ground.png")
plyerImg = file.loadImage("/usr/Textures/Duck.png")

playerSprite = new Sprite
playerSprite.image = plyerImg.getImage(0, 0, 18, 24)
playerSprite.y = 120
playerSprite.x = 60
playerSprite.scale = 3.5
playerSprite.localBounds = new Bounds
playerSprite.localBounds.width = plyerImg.width
playerSprite.localBounds.height = plyerImg.height

spriteDisplayList.push playerSprite

playerVelocity = 0
playerJumpVelocity = 20
grvityForce = 1.1

onGround = true

groundScale = 3.5

groundSprites = []
for x in range(-groundImg.width*groundScale,960+groundImg.width*groundScale,groundImg.width*groundScale)
	curentGroundSprite = new Sprite
	curentGroundSprite.image = groundImg
	curentGroundSprite.y = 25
	curentGroundSprite.x = x
	
	curentGroundSprite.localBounds = new Bounds
	curentGroundSprite.localBounds.width = groundImg.width
	curentGroundSprite.localBounds.height = groundImg.height
	
	curentGroundSprite.scale = groundScale
	spriteDisplayList.push curentGroundSprite
	groundSprites.push curentGroundSprite
end for


clearTextScreen = function()
	display(3).color = "#000000FF"
	display(3).clear
	display(3).row = 25
end function

min = function(a,b)
	if a <= b then return a
	return b
end function



while true
	clearTextScreen
	print "Speed =" + curentSpeed
	print "Velocity =" + playerVelocity
	
	isJump = key.pressed("w");
	
	if not onGround then 
		playerVelocity -= grvityForce
	else
		playerVelocity = 0
	end if
	
	if isJump and onGround then 
		playerVelocity = playerJumpVelocity
		onGround = false
	end if
	
	playerSprite.y += playerVelocity
	
	curentSpeed = min(curentSpeed+speedOverTheMinute, maxSpeed)
	
	for curentGroundSprite in groundSprites
		curentGroundSprite.x -= curentSpeed
		if curentGroundSprite.x<=-groundImg.width*groundScale then 
			curentGroundSprite.x = groundImg.width*groundScale*groundSprites.len - abs(curentGroundSprite.x -groundImg.width*groundScale)
		end if
		
		if curentGroundSprite.overlaps(playerSprite) then
			onGround = true
			playerSprite.y = curentGroundSprite.y + groundImg.height*groundScale/2 + playerSprite.image.height/2 * 3.5
		end if
	end for
	
	wait 1/60
end while