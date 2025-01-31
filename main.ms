clear

spriteDisplayList = display(4).sprites

curentSpeed = 3
maxSpeed = 10
speedOverTheMinute = 1/25

groundImg = file.loadImage("/usr/Textures/Ground.png")
groundScale = 3.5

groundSprites = []
for x in range(-groundImg.width*groundScale,960+groundImg.width*groundScale,groundImg.width*groundScale)
	curentGroundSprite = new Sprite
	curentGroundSprite.image = groundImg
	curentGroundSprite.y = 25
	curentGroundSprite.x = x
	curentGroundSprite.scale = groundScale
	spriteDisplayList.push curentGroundSprite
	groundSprites.push curentGroundSprite
end for


clearScreen = function()
	display(3).clear
	display(3).row = 25
end function

min = function(a,b)
	if a <= b then return a
	return b
end function



while true
	clearScreen
	
	curentSpeed = min(curentSpeed+speedOverTheMinute, maxSpeed)
	
	for curentGroundSprite in groundSprites
		curentGroundSprite.x -= curentSpeed
		if curentGroundSprite.x<=-groundImg.width*groundScale then 
			curentGroundSprite.x = groundImg.width*groundScale*groundSprites.len - abs(curentGroundSprite.x -groundImg.width*groundScale)
		end if
	end for
	
	yield
end while