clear

spriteDisplayList = display(4).sprites

curentSpeed = 1
maxSpeed = 10
speedOverTheMinute = 1/25

groundImg = file.loadImage("/usr/Textures/Ground.png")

groundSprites = []
for x in range(0.1-groundImg.width*3.5,960+groundImg.width*3.5,groundImg.width*3.5)
	curentGroundSprite = new Sprite
	curentGroundSprite.image = groundImg
	curentGroundSprite.y = 25
	curentGroundSprite.x = x
	curentGroundSprite.scale = 3.5
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
	
	//curentSpeed = min(curentSpeed+speedOverTheMinute, maxSpeed)
	
	for curentGroundSprite in groundSprites
		curentGroundSprite.x -= curentSpeed
		if curentGroundSprite.x<=-groundImg.width*3.5 then curentGroundSprite.x = 960 + groundImg.width*3.5 - curentSpeed
	end for
	
	yield
end while