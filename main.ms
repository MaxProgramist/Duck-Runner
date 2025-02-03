clear 
display(5).clear "#94fdff"
display(3).color = "#4aabce"

spriteDisplayList = display(4).sprites



curentSpeed = 2
maxSpeed = 16
speedOverTheMinute = 1/60/25

groundImg = file.loadImage("/usr/Textures/Ground.png")
plyerImgSheet = file.loadImage("/usr/Textures/Duck.png")
otherImgSheet = file.loadImage("/usr/Textures/Other.png")
particleImg = file.loadImage("/usr/Textures/Particle.png")

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
playerSprite.localBounds.width = plyerImgFrames[0].width
playerSprite.localBounds.height = plyerImgFrames[0].height

spriteDisplayList.push playerSprite

playerScaleBase = 3.5
playerScaleChanger = 0.4
playerVelocity = 0
playerJumpVelocity = 15
grvityForce = 0.4
playerAnimSpeed = 7
playerScale = [playerScaleBase, playerScaleBase]
onGround = true

isJumping = false
jumpingAnimation = 0.2
curentJumpingAnimtion = 0
jumpTimeStart = 0

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

jumpAnimation = function(timeChanger)
	
end function



startTime = time
curentTime = time-startTime

while true
	clearTextScreen
	print "Speed = " + curentSpeed
	print "Velocity = " + playerVelocity
	print "Time = " + (curentTime)
	print "Jump = " + curentJumpingAnimtion
	
	curentTime = time-startTime
	
	playerSprite.image = plyerImgFrames[(time * playerAnimSpeed + curentSpeed) % plyerImgFrames.len]
	
	playerSprite.scale = playerScale
	
	isJump = key.pressed("w") or key.pressed("up") or key.pressed("space") ;
	if isJumping then
		if curentJumpingAnimtion > 0.5*jumpingAnimation then
			playerScale[0] -= playerScaleChanger
			playerScale[1] += playerScaleChanger
		else
			playerScale[0] += playerScaleChanger
			playerScale[1] -= playerScaleChanger
		end if
		
		if curentJumpingAnimtion<0 then 
			isJumping = false
			curentJumpingAnimtion = 0
			playerScale[0] = playerScaleBase
			playerScale[1] = playerScaleBase
		else
			curentJumpingAnimtion = jumpingAnimation - (time - jumpTimeStart)	
		end if
	end if
	
	if not onGround then 
		playerVelocity -= grvityForce
	else
		playerVelocity = 0
	end if
	
	if isJump and onGround then 
		playerVelocity = playerJumpVelocity
		onGround = false
		
		isJumping = true
		curentJumpingAnimtion = jumpingAnimation
		jumpTimeStart = curentTime
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