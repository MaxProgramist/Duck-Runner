clear 
display(5).clear "#94fdff"
display(3).color = "#4aabce"

spriteDisplayList = display(4).sprites



curentSpeed = 2
maxSpeed = 16
speedOverTheMinute = 1/60/25
coins = 0



groundImg = file.loadImage("/usr/Textures/Ground.png")
plyerImgSheet = file.loadImage("/usr/Textures/Duck.png")
otherImgSheet = file.loadImage("/usr/Textures/Other.png")
particleImg = file.loadImage("/usr/Textures/Particle.png")

plyerImgFrames = []
for i in range(0, 3)
	plyerImgFrames.push plyerImgSheet.getImage(i * 18, 0, 18, 24)
end for

otherImgs = []
for i in range(0, 2)
	otherImgs.push otherImgSheet.getImage(i * 16, 0, 16, 16)
end for



Vector2 = {"x":0, "y":0}
Vector2_Zero = new Vector2

PrticleSystem = {"position":Vector2_Zero, "count":0, "size":[0,0], "speed":0, "lifetime":0, "image": null, "particles":[], "directions":[]}
PrticleSystem.update = function()
	for curentIndex in range(0,self.particles.len-1)
		self.particles[curentIndex].x += self.directions[curentIndex].x * self.speed
		self.particles[curentIndex].y += self.directions[curentIndex].y * self.speed
		self.lifetime -= 1
		self.particles[curentIndex].scale -= self.particles[curentIndex].scale/self.lifetime
	end for
end function

PrticleSystem.getLifeTime = function()
	return self.lifetime
end function

PrticleSystem.delete = function()
	for curentParticle in self.particles
		spritesOnDisplay.remove spritesOnDisplay.indexOf(curentParticle)
	end for
	self.particles = []
	self.directions = []
end function

PrticleSystem.newParticleSystem = function()
	for i in range(0,self.count)
		self.newParticle = new Sprite
		self.newParticle.image = particleImg
		self.newParticle.tint = self.color
		
		self.newParticle.scale = self.size[0] + rnd()*(self.size[1]-self.size[0])
		self.newParticle.x = self.position.x
		self.newParticle.y = self.position.y
		
		self.newParticleDirection = new Vector2
		self.newParticleDirection.x = 1 - 2*rnd()
		self.newParticleDirection.y = 1 - 2*rnd()
		
		spritesOnDisplay.push self.newParticle
		self.particles.push self.newParticle
		self.directions.push self.newParticleDirection
		
	end for
end function



otherSprites = []
timeBtwSpawnObjects = 3
timeOfLastSpawnObjects = 0

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
isAlive = true

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

newObject = function()
	newOtherSprite = new Sprite
	newOtherSprite.image = otherImgs[rnd()*otherImgs.len]
	newOtherSprite.y = 105
	newOtherSprite.x = 1000
	newOtherSprite.scale = 3.5
	
	newOtherSprite.localBounds = new Bounds
	newOtherSprite.localBounds.width = newOtherSprite.image.width
	newOtherSprite.localBounds.height = newOtherSprite.image.height
	
	spriteDisplayList.push newOtherSprite
	otherSprites.push newOtherSprite
end function



startTime = time
curentTime = time-startTime
timeOfLastSpawnObjects = startTime

while isAlive
	clearTextScreen
	print "Coins: " + coins
	print 
	print "Speed = " + curentSpeed
	print "Velocity = " + playerVelocity
	print "Time = " + (curentTime)
	print "Spawn = " + (curentTime - timeOfLastSpawnObjects) + ":" + timeBtwSpawnObjects
	
	curentTime = time-startTime
	
	if curentTime - timeOfLastSpawnObjects > timeBtwSpawnObjects then
		newObject
		
		timeOfLastSpawnObjects = curentTime
	end if
	
	playerSprite.image = plyerImgFrames[(time * playerAnimSpeed + curentSpeed) % plyerImgFrames.len]
	
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
		
		playerSprite.scale = playerScale
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
	
	for curentOtherSprite in otherSprites
		curentOtherSprite.x -= curentSpeed
		
		if curentOtherSprite.overlaps(playerSprite) then
			if curentOtherSprite.image == otherImgs[0] then
				spriteDisplayList.remove spriteDisplayList.indexOf (curentOtherSprite)
				otherSprites.remove otherSprites.indexOf (curentOtherSprite)
				
				coins += 1
			else
				spriteDisplayList.remove spriteDisplayList.indexOf (playerSprite)
				isAlive = false
				break
			end if
		end if
	end for
	
	yield
end while