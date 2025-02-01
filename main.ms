clear 
display(5).clear "#94fdff"

spriteDisplayList = display(4).sprites

curentSpeed = 1
maxSpeed = 10
speedOverTheMinute = 1/1000

groundImg = file.loadImage("/usr/Textures/Ground.png")
plyerImg = file.loadImage("/usr/Textures/Duck.png")

playerSprite = new Sprite
playerSprite.image = plyerImg.getImage(0, 0, 18, 24)
playerSprite.y = 120
playerSprite.x = 60
playerSprite.scale = 3.5
spriteDisplayList.push playerSprite

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
	display(3).color = "#ffffff"
	display(3).clear
	display(3).row = 25
end function

min = function(a,b)
	if a <= b then return a
	return b
end function



while true
	clearTextScreen
	
	curentSpeed = min(curentSpeed+speedOverTheMinute, maxSpeed)
	
	for curentGroundSprite in groundSprites
		curentGroundSprite.x -= curentSpeed
		if curentGroundSprite.x<=-groundImg.width*groundScale then 
			curentGroundSprite.x = groundImg.width*groundScale*groundSprites.len - abs(curentGroundSprite.x -groundImg.width*groundScale)
		end if
	end for
	
	yield
end while