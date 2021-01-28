
set volleyPath=E:\Martin\Games\Netplay\Modding\VolleyballConcept\
set sdPath=E:\Martin\Games\Netplay\Project+\Build\Project+\

COPY /Y st_volleyball.rel "%sdPath%pf\module\st_volleyball.rel"
COPY /Y STGVolleyball.pac "%sdPath%pf/stage/melee/STGVolleyball.pac"
COPY /Y Training.param "%sdPath%pf/stage/stageinfo/Training.param"
COPY /Y Volleyball.asm "%sdPath%Source/Extras/Volleyball.asm"

echo & echo.| call %sdPath%/GCTRealMate.exe -g -l %sdPath%/RSBE01.txt
move /Y %volleyPath%/codeset.txt %volleyPath%/Log\RSBE01.txt
move /Y %volleyPath%/log.txt %volleyPath%/Log\RSBE01Log.txt
echo & echo.| call %sdPath%/GCTRealMate.exe -g -l %sdPath%/BOOST.txt
move /Y %volleyPath%/codeset.txt %volleyPath%/Log\BOOST.txt
move /Y %volleyPath%/log.txt %volleyPath%/Log\BOOSTLog.txt

TIMEOUT 5

"E:\Martin\Games\Netplay\SD Card Maker P+\VSDSync.exe"