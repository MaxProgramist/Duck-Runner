spriteDisplayList = display(4).sprites

curentSpeed = 1
maxSpeed = 10
speedOverTheMinute = 1/100

groundImg = file.loadImage("/usr/Textures/Ground.png")

groundSprite = new Sprite
groundSprite.image = groundImg
groundSprite.y = 25
groundSprite.x = 100
groundSprite.scale = 3.5
spriteDisplayList.push groundSprite


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
	groundSprite.x -= curentSpeed
	if groundSprite.x<0 then groundSprite.x= 960
	
	yield
end while