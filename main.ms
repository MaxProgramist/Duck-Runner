clear 
display(5).clear "#94fdff"
display(3).color = "#4aabce"

spriteDisplayList = display(4).sprites



curentSpeed = 2
maxSpeed = 18
speedOverTheMinute = 1/60/30

groundImg = file.loadImage("/usr/Textures/Ground.png")
plyerImgSheet = file.loadImage("/usr/Textures/Duck.png")

plyerImgFrames = []
for i in range(0, 3)
	plyerImgFrames.push plyerImgSheet.getImage(i * 18, 0, 18, 24)
end for

playerSprite = new Sprite
playerSprite.image = plyerImgFrames[0]
playerSprite.y = 120
playerSprite.x = 90
playerSprite.scale = 3.5
playerSprite.localBounds = new Bounds
playerSprite.localBounds.width = plyerImg.width
playerSprite.localBounds.height = plyerImg.height

spriteDisplayList.push playerSprite

playerVelocity = 0
playerJumpVelocity = 15
grvityForce = 0.4
playerAnimSpeed = 5

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
	display(3).color = "#4aabce"
	display(3).clear
	display(3).row = 25
end function

min = function(a,b)
	if a <= b then return a
	return b
end function

playerAnimation = function(startScale, endScale, curentTime)
	return startScale + (endScale-startScale)*curentTime
end function

easeInSine = function(x)
	return 1 - cos((@x * pi) / 2)
end function



startTime = time
curentTime = time-startTime

while true
	clearTextScreen
	print "Speed = " + curentSpeed
	print "Velocity = " + playerVelocity
	print "Time = " + (curentTime)
	print "Animation = " + easeInSine (curentTime)
	
	curentTime = time-startTime
	
	playerSprite.image = plyerImgFrames[(time * playerAnimSpeed + curentSpeed) % plyerImgFrames.len]
	
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
	
	yield
end while