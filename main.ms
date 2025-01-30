spriteDisplayList = display(4).sprites

clearScreen = function()
	display(3).clear
	display(3).row = 25
end function

min = function(a,b)
	if a <= b then return a
	if a >= b then return b
end function

curentSpeed = 1
maxSpeed = 10
speedOverTheMinute = 0.0000005

while true
	clearScreen
	
	print curentSpeed
	
	curentSpeed = min(curentSpeed+speedOverTheMinute, maxSpeed)
	
	yield
end while