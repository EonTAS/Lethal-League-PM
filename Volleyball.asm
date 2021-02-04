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

#Items Added 
#/*
#Things required to add an item to a stage:
#  create()/[stClassInfo] function needs to allocate 0x100 more space per item being alloc'ed
#  __ct()/[stage] needs to alloc two gfArchive objects within the extra space alloc'ed above, one 0x80 in, per item added
#  __dt()/[stage] needs to destroy the gfArchives created above
#  getItemPac()/[stage] need to point rel to read this from within the rel, and write the locations of the two gfArchives to r4 and r5, using r3 as offset 0, and r6 being the item ID to check against
#  createObj()/[stage] needs to check that archives with correct file index existed, and then populate the two gfArchives specified above
#     gfArchive that is stored into r4 in getItemPac is model, into r5 is psa file
#example below is my planned edits to training rooms rel
#*/
#
##ct
#op li r3, 0x500 @ $81160270 #alloc'ed size, original size 0x1E8, alloced 0x118 extra (only need 0x100)
##op li r3, 0x400 @ $81160270 #extra 0x100 for a second item
#
#op beq 0x3C @ $81160298 #skip the hook below, original branch 0x38 (functionally identical)
#
#HOOK @ $811602D0
#{
##item1
#    addi r3, r30, 0x200
#    lis r12, 0x8001
#    ori r12, r12, 0x370c
#    mtctr r12
#    bctrl 
#    addi r3, r30, 0x280
#    lis r12, 0x8001
#    ori r12, r12, 0x370C
#    mtctr r12
#    bctrl 
#
##item2
#    addi r3, r30, 0x300
#    lis r12, 0x8001
#    ori r12, r12, 0x370c
#    mtctr r12
#    bctrl 
#    addi r3, r30, 0x380
#    lis r12, 0x8001
#    ori r12, r12, 0x370C
#    mtctr r12
#    bctrl 
##item3
#    addi r3, r30, 0x400
#    lis r12, 0x8001
#    ori r12, r12, 0x370c
#    mtctr r12
#    bctrl 
#    addi r3, r30, 0x480
#    lis r12, 0x8001
#    ori r12, r12, 0x370C
#    mtctr r12
#    bctrl 
#    mr r3, r30
#}
#
##dt
#HOOK @ $8115FB50
#{
#    #gfArchive at offset 0x280
#    addi r3, r30, 0x280
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#    #gfArchive at offset 0x200
#    addi r3, r30, 0x200
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#
##second custom item
#    addi r3, r30, 0x380
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#    addi r3, r30, 0x300
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#
##second custom item
#    addi r3, r30, 0x480
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#    addi r3, r30, 0x400
#    li r4, -1
#    lis r12, 0x8001
#    ori r12, r12, 0x3B1C
#    mtctr r12
#    bctrl 
#    
#    mr r3, r30
#    cmpwi
#}
#
##to go in the getItemPac function, currently not pointing anywhere, will do later
#HOOK @ $8092F508 
#{
#    cmpwi r6, 0x4B
#    beq firstCustom
#    cmpwi r6, 0x4C
#    beq secondCustom
#    cmpwi r6, 0x4D
#    beq thirdCustom
#    blr
#firstCustom:
#    addi r6, r3, 0x280
#    stw r6, 0(r4)
#    addi r6, r3, 0x200
#    stw r6, 0(r5)
#    blr 
#secondCustom:
#    addi r6, r3, 0x380
#    stw r6, 0(r4)
#    addi r6, r3, 0x300
#    stw r6, 0(r5)
#    blr 
#
#thirdCustom:
#    addi r6, r3, 0x480
#    stw r6, 0(r4)
#    addi r6, r3, 0x400
#    stw r6, 0(r5)
#    blr 
#}
#
##createObj
#HOOK @ $8115fbB8
#{
#    mr r28, r3
#getFirstModels:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r3)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10001
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq getFirstPSA
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x280
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#getFirstPSA:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r28)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10002
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq getSecondModels
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x200
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#getSecondModels:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r28)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10003
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq getSecondPSA
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x380
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#getSecondPSA:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r28)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10004
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq getThirdModels
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x300
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#
#getThirdModels:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r28)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10004
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq getThirdPSA
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x480
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#getThirdPSA:
#    lis r4, 0x0001
#    subi r0, r4, 2
#    lwz r3, 0x1A0(r28)
#    addi r6, r1, 0xC
#    rlwinm r7, r0, 0, 16, 31
#    li r4, 1
#    li r5, 10006
#    lis r12, 0x8001
#    ori r12, r12, 0x5E14
#    mtctr r12
#    bctrl 
#    cmpwi r3, 0
#    beq end
#    lwz r5, 0xC(r1)
#    mr r4, r3
#    addi r3, r28, 0x400
#    li r6, 17
#    lis r12, 0x8001
#    ori r12, r12, 0x4890
#    mtctr r12
#    bctrl 
#
#end:
#    mr r3, r28
#}