
set volleyPath=E:\Martin\Games\Netplay\Modding\VolleyballConcept\
set sdPath=E:\Martin\Games\Netplay\Project+\Build\Project+\
set dolphinPath="E:\Martin\Games\Netplay\Dolphin - P+\User\Maps/RSBE01.map"

COPY %volleyPath%/st_volleyball.rel %sdPath"/pf/module/st_volleyball.rel
COPY %volleyPath%/STGVolleyball.pac %sdPath"/pf/stage/melee/STGVolleyball.pac
COPY %volleyPath%/Training.param %sdPath"/pf/stage/stageinfo/Training.param
COPY %volleyPath%/Volleyball.asm %sdPath"/Source/Extras/Volleyball.asm

echo & echo.| call %sdPath%/GCTRealMate.exe -g -l %sdPath%/RSBE01.txt
move /Y %volleyPath%/codeset.txt %volleyPath%/Log\RSBE01.txt
move /Y %volleyPath%/log.txt %volleyPath%/Log\RSBE01Log.txt
echo & echo.| call %sdPath%/GCTRealMate.exe -g -l %sdPath%/BOOST.txt
move /Y %volleyPath%/codeset.txt %volleyPath%/Log\BOOST.txt
move /Y %volleyPath%/log.txt %volleyPath%/Log\BOOSTLog.txt

COPY %volleyPath%RSBE01.map %dolphinPath%
TIMEOUT 5

"E:\Martin\Games\Netplay\SD Card Maker P+\VSDSync.exe"