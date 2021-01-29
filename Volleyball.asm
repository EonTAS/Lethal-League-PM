Elastic Collisions and no Caps 
* 42000000 90000000
* 0502B77C 3F800000 #= wallbounce multiplier horziontal, set to 1
* 0502B780 3F800000 #= wallbounce multiplier vertical, set to 1
* 0502B784 3F800000 #= cieling bounce mult horiz
* 0502B788 3F800000 #= cieling bounce mult horiz
* 0502B72C 7f800000 #= vertical max cap = inf
* 0502B79C 7f800000 #= horizontal max cap = inf
.RESET

#melee volleybal mechanics

#max fallspeed = -2.3
#gravity = -0.051
#knockback decay is true -0.051 overall speed
#calc angle of movement, subtract 0.051 off mag, multiply each individual speed, reapply
#wall bounce = natural decay first, and then knockback*0.8, 