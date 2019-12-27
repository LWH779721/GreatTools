@echo off
set   root_dir=%cd%\..\..\..\..\..
set   win32_x86_bin_path=%root_dir%\platforms\win32-x86\bin
set   cmd_minised=%win32_x86_bin_path%\minised.exe
set   cmd_7z=%win32_x86_bin_path%\7z.exe
set   compiler_jar_path=%win32_x86_bin_path%\compiler.jar
set   yuicompressor_jar_path=%win32_x86_bin_path%\yuicompressor-2.4.2.jar
set   sys_src_path=%root_dir%\apps\app\sys
set   path_relative_src_http=project\src\apps\app\ipc\data\http
set   path_relative_src_sys=project\src\apps\app\sys
set   mipc_ver_file=mipc_ver.txt

:main

set file_path=%1
set ver_tmp=%2
set all=%3
set webv=%4
set pack=%5

:: check the parm
if "%file_path%" == "help" (
  call:Help %0
)
if "%file_path%" == "" (
  call:Help %0
)
if "%ver_tmp%" == "" (
 echo ver can't be null
 call:Help %0
)
if "%all%" == "" (
  echo all can't be null
  call:Help %0
)
if "%webv%" == "" (
  echo web can't be null
  call:Help %0
)

:: prepare mipc_ver as date
set mipc_ver=
if exist %mipc_ver_file% (
  echo !!!---------------%mipc_ver_file% exist.---------------!!!
  echo !!!-------do you need a new version for mipc,----------!!!
  echo !!!if need please delete %mipc_ver_file% then continue,!!!
  echo !!!------------else continue directly.-----------------!!!
  pause
)
if exist %mipc_ver_file% (
 for /F "" %%i IN ('type %mipc_ver_file%') do (set mipc_ver=%%i)
)
if "%mipc_ver%" == "" (  
  if "%time:~0,1%" == " " (
    set mipc_ver=%date:~2,2%%date:~5,2%%date:~8,2%0%time:~1,1%%time:~3,2%
  ) else (
    set mipc_ver=%date:~2,2%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%
  )
)
:: echo %mipc_ver% > %mipc_ver_file%

:: 设置参数
set ver=%ver_tmp%.%mipc_ver%
set temp_path=%file_path%\tmp
set log=%file_path%\log.txt

:: Prepare src
if exist %temp_path% (
  rd/s/Q %temp_path%
)
md "%temp_path%\%path_relative_src_http%"
md "%temp_path%\%path_relative_src_http%\mme"
md "%temp_path%\%path_relative_src_http%\css"
md "%temp_path%\%path_relative_src_http%\imgs"
md "%temp_path%\%path_relative_src_http%\oem"
md "%temp_path%\%path_relative_src_http%\scripts"
copy mme\mme.swf %temp_path%\%path_relative_src_http%\mme
if "%webv%" == "v1" (
 if "%all%" == "1" (
  copy mme\*.* %temp_path%\%path_relative_src_http%\mme
 )
 copy css\*.css %temp_path%\%path_relative_src_http%\css
 del /f /s /q %temp_path%\%path_relative_src_http%\css\web_v3.css
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 del /f /s /q %temp_path%\%path_relative_src_http%\imgs\background.png
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy index.htm %temp_path%\%path_relative_src_http%
 copy index.debug.htm %temp_path%\%path_relative_src_http%
 copy main.htm %temp_path%\%path_relative_src_http%
 copy main.debug.htm %temp_path%\%path_relative_src_http%
 copy mipc_play*.htm %temp_path%\%path_relative_src_http%
 copy __mining*.htm %temp_path%\%path_relative_src_http%
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\web_*.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\test2.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\update*.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\ismobile.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\cacs.const.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\clicm.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\jquery.easing.1.3.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\language.js
 xcopy oem %temp_path%\%path_relative_src_http%\oem /e
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\avuecam\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\hentek\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\ruifeng_chcv\doc
)
if "%webv%" == "all" (
 if "%all%" == "1" (
  copy mme\*.* %temp_path%\%path_relative_src_http%\mme
 )
 copy css\*.css %temp_path%\%path_relative_src_http%\css
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy *.htm %temp_path%\%path_relative_src_http%
 del /f /s /q %temp_path%\%path_relative_src_http%\download.htm
 del /f /s /q %temp_path%\%path_relative_src_http%\privacy.htm
 del /f /s /q %temp_path%\%path_relative_src_http%\test2.htm
 del /f /s /q %temp_path%\%path_relative_src_http%\update_wireless.htm
 del /f /s /q %temp_path%\%path_relative_src_http%\weixin_test.htm
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\web_new.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\web_sdk.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\test2.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\update*.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\ismobile.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\cacs.const.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\clicm.js
 del /f /s /q %temp_path%\%path_relative_src_http%\scripts\jquery.easing.1.3.js
 xcopy oem %temp_path%\%path_relative_src_http%\oem /e
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\avuecam\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\hentek\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\ruifeng_chcv\doc
)
if "%webv%" == "v2o" (
 copy css\*.css %temp_path%\%path_relative_src_http%\css
 del /f /s /q %temp_path%\%path_relative_src_http%\css\web_v3.css
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 del /f /s /q %temp_path%\%path_relative_src_http%\imgs\background.png
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy index.htm %temp_path%\%path_relative_src_http%
 copy index.v2o.debug.htm %temp_path%\%path_relative_src_http%
 copy main.htm %temp_path%\%path_relative_src_http%
 copy main.v2o.debug.htm %temp_path%\%path_relative_src_http%
)
if "%webv%" == "v2n" (
 copy css\*.css %temp_path%\%path_relative_src_http%\css
 del /f /s /q %temp_path%\%path_relative_src_http%\css\web_v3.css
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 del /f /s /q %temp_path%\%path_relative_src_http%\imgs\background.png
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy index.htm %temp_path%\%path_relative_src_http%
 copy index.v2n.debug.htm %temp_path%\%path_relative_src_http%
 copy main.htm %temp_path%\%path_relative_src_http%
 copy main.v2n.debug.htm %temp_path%\%path_relative_src_http%
)
if "%webv%" == "v3" (
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 del /f /s /q %temp_path%\%path_relative_src_http%\imgs\mipc_img.png
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy css\web_v3.css %temp_path%\%path_relative_src_http%\css
 copy index.v3.htm %temp_path%\%path_relative_src_http%
 copy index.v3.debug.htm %temp_path%\%path_relative_src_http%
 copy main.v3.htm %temp_path%\%path_relative_src_http%
 copy main.v3.debug.htm %temp_path%\%path_relative_src_http%
 xcopy oem %temp_path%\%path_relative_src_http%\oem /e
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\avuecam\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\hentek\doc
 rd/s/Q %temp_path%\%path_relative_src_http%\oem\ruifeng_chcv\doc
)
if "%webv%" == "test" (
 copy imgs\* %temp_path%\%path_relative_src_http%\imgs
 del /f /s /q %temp_path%\%path_relative_src_http%\imgs\background.png
 copy scripts\*.js %temp_path%\%path_relative_src_http%\scripts
 copy test_tool*.htm %temp_path%\%path_relative_src_http%
)

:: Prepare sys
if "%webv%" == "v1" (
 call:Prepare_sys
)
if "%webv%" == "all" (
 call:Prepare_sys
)
 
:: Update index.htm
cd %temp_path%\%path_relative_src_http%
if "%webv%" == "v1" (
 %cmd_minised% "s/main.htm[?v]*[0-9.]*/main.htm?%ver%/g" index.htm > index.htm.tmp
 del index.htm
 rename index.htm.tmp index.htm
 %cmd_minised% "s/main.debug.htm[?v]*[0-9.]*/main.debug.htm?%ver%/g" index.debug.htm > index.debug.htm.tmp
 del index.debug.htm
 rename index.debug.htm.tmp index.debug.htm
 %cmd_7z% a index.htm.gz index.htm -mx=9 -mfb=255
)
if "%webv%" == "v2o" (
 %cmd_minised% "s/main.htm[?v]*[0-9.]*/main.v2o.htm?%ver%/g" index.htm > index.v2o.htm.tmp
 del index.htm
 rename index.v2o.htm.tmp index.v2o.htm
 %cmd_minised% "s/main.v2o.debug.htm[?v]*[0-9.]*/main.v2o.debug.htm?%ver%/g" index.v2o.debug.htm > index.v2o.debug.htm.tmp
 del index.v2o.debug.htm
 rename index.v2o.debug.htm.tmp index.v2o.debug.htm
 %cmd_7z% a index.v2o.htm.gz index.v2o.htm -mx=9 -mfb=255
)
if "%webv%" == "v2n" (
 %cmd_minised% "s/main.htm[?v]*[0-9.]*/main.v2n.htm?%ver%/g" index.htm > index.v2n.htm.tmp
 del index.htm
 rename index.v2n.htm.tmp index.v2n.htm
 %cmd_minised% "s/main.v2n.debug.htm[?v]*[0-9.]*/main.v2n.debug.htm?%ver%/g" index.v2n.debug.htm > index.v2n.debug.htm.tmp
 del index.v2n.debug.htm
 rename index.v2n.debug.htm.tmp index.v2n.debug.htm
 %cmd_7z% a index.v2n.htm.gz index.v2n.htm -mx=9 -mfb=255
)
if "%webv%" == "v3" (
 %cmd_minised% "s/main.v3.htm[?v]*[0-9.]*/main.v3.htm?%ver%/g" index.v3.htm > index.v3.htm.tmp
 del index.v3.htm
 rename index.v3.htm.tmp index.v3.htm
 %cmd_minised% "s/main.v3.debug.htm[?v]*[0-9.]*/main.v3.debug.htm?%ver%/g" index.v3.debug.htm > index.v3.debug.htm.tmp
 del index.v3.debug.htm
 rename index.v3.debug.htm.tmp index.v3.debug.htm
 %cmd_7z% a index.v3.htm.gz index.v3.htm -mx=9 -mfb=255
)
if "%webv%" == "all" (
 %cmd_minised% "s/main.htm[?v]*[0-9.]*/main.htm?%ver%/g" index.htm > index.htm.tmp
 del index.htm
 rename index.htm.tmp index.htm
 %cmd_minised% "s/main.debug.htm[?v]*[0-9.]*/main.debug.htm?%ver%/g" index.debug.htm > index.debug.htm.tmp
 del index.debug.htm
 rename index.debug.htm.tmp index.debug.htm
 %cmd_7z% a index.htm.gz index.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/main.htm?a/main.v2o.htm?a/g" index.htm > index.v2o.htm.tmp
 rename index.v2o.htm.tmp index.v2o.htm
 %cmd_minised% "s/main.v2o.debug.htm[?v]*[0-9.]*/main.v2o.debug.htm?%ver%/g" index.v2o.debug.htm > index.v2o.debug.htm.tmp
 del index.v2o.debug.htm
 rename index.v2o.debug.htm.tmp index.v2o.debug.htm
 %cmd_7z% a index.v2o.htm.gz index.v2o.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/main.htm?a/main.v2n.htm?a/g" index.htm > index.v2n.htm.tmp
 rename index.v2n.htm.tmp index.v2n.htm
 %cmd_minised% "s/main.v2n.debug.htm[?v]*[0-9.]*/main.v2n.debug.htm?%ver%/g" index.v2n.debug.htm > index.v2n.debug.htm.tmp
 del index.v2n.debug.htm
 rename index.v2n.debug.htm.tmp index.v2n.debug.htm
 %cmd_7z% a index.v2n.htm.gz index.v2n.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/main.v3.htm[?v]*[0-9.]*/main.v3.htm?%ver%/g" index.v3.htm > index.v3.htm.tmp
 del index.v3.htm
 rename index.v3.htm.tmp index.v3.htm
 %cmd_minised% "s/main.v3.debug.htm[?v]*[0-9.]*/main.v3.debug.htm?%ver%/g" index.v3.debug.htm > index.v3.debug.htm.tmp
 del index.v3.debug.htm
 rename index.v3.debug.htm.tmp index.v3.debug.htm
 %cmd_7z% a index.v3.htm.gz index.v3.htm -mx=9 -mfb=255
)

:: Update main.htm
if "%webv%" == "v1" (
 %cmd_minised% "s/mipc.min.js[?v]*[0-9.]*/mipc.min.js?%ver%/g" main.htm > main.htm.tmp
 del main.htm
 rename main.htm.tmp main.htm
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" main.htm > main.htm.tmp
 del main.htm
 rename main.htm.tmp main.htm
 %cmd_7z% a main.htm.gz main.htm -mx=9 -mfb=255
)
if "%webv%" == "v2o" (
 %cmd_minised% "s/mipc.min.js[?v]*[0-9.]*/mipc.v2o.min.js?%ver%/g" main.htm > main.v2o.htm.tmp
 del main.htm
 rename main.v2o.htm.tmp main.v2o.htm
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.v2o.min.css?%ver%/g" main.v2o.htm > main.v2o.htm.tmp
 del main.v2o.htm
 rename main.v2o.htm.tmp main.v2o.htm
 %cmd_7z% a main.v2o.htm.gz main.v2o.htm -mx=9 -mfb=255
)
if "%webv%" == "v2n" (
 %cmd_minised% "s/mipc.min.js[?v]*[0-9.]*/mipc.v2n.min.js?%ver%/g" main.htm > main.v2n.htm.tmp
 del main.htm
 rename main.v2n.htm.tmp main.v2n.htm
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.v2n.min.css?%ver%/g" main.v2n.htm > main.v2n.htm.tmp
 del main.v2n.htm
 rename main.v2n.htm.tmp main.v2n.htm
 %cmd_7z% a main.v2n.htm.gz main.v2n.htm -mx=9 -mfb=255
)
if "%webv%" == "v3" (
 %cmd_minised% "s/mipc.v3.min.js[?v]*[0-9.]*/mipc.v3.min.js?%ver%/g" main.v3.htm > main.v3.htm.tmp
 del main.v3.htm
 rename main.v3.htm.tmp main.v3.htm
 %cmd_minised% "s/mipc.v3.min.css[?v]*[0-9.]*/mipc.v3.min.css?%ver%/g" main.v3.htm > main.v3.htm.tmp
 del main.v3.htm
 rename main.v3.htm.tmp main.v3.htm
 %cmd_7z% a main.v3.htm.gz main.v3.htm -mx=9 -mfb=255
)
if "%webv%" == "test" (
 %cmd_minised% "s/mipc_test.min.js?t[0-9.]*/mipc_test.min.js?%ver%/g" test_tool.htm > test_tool.htm.tmp
 del test_tool.htm
 rename test_tool.htm.tmp test_tool.htm
 %cmd_7z% a test_tool.htm.gz test_tool.htm -mx=9 -mfb=255
)
if "%webv%" == "all" (
 %cmd_minised% "s/mipc.min.js[?v]*[0-9.]*/mipc.min.js?%ver%/g" main.htm > main.htm.tmp
 del main.htm
 rename main.htm.tmp main.htm
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" main.htm > main.htm.tmp
 del main.htm
 rename main.htm.tmp main.htm
 %cmd_7z% a main.htm.gz main.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/mipc.min.js/mipc.v2o.min.js/g" main.htm > main.v2o.htm.tmp
 rename main.v2o.htm.tmp main.v2o.htm
 %cmd_7z% a main.v2o.htm.gz main.v2o.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/mipc.min.js/mipc.v2n.min.js/g" main.htm > main.v2n.htm.tmp
 rename main.v2n.htm.tmp main.v2n.htm
 %cmd_7z% a main.v2n.htm.gz main.v2n.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/mipc.v3.min.js[?v]*[0-9.]*/mipc.v3.min.js?%ver%/g" main.v3.htm > main.v3.htm.tmp
 del main.v3.htm
 rename main.v3.htm.tmp main.v3.htm
 %cmd_minised% "s/mipc.v3.min.css[?v]*[0-9.]*/mipc.v3.min.css?%ver%/g" main.v3.htm > main.v3.htm.tmp
 del main.v3.htm
 rename main.v3.htm.tmp main.v3.htm
 %cmd_7z% a main.v3.htm.gz main.v3.htm -mx=9 -mfb=255
 
 %cmd_minised% "s/mipc_test.min.js[?v]*[0-9.]*/mipc_test.min.js?%ver%/g" test_tool.htm > test_tool.htm.tmp
 del test_tool.htm
 rename test_tool.htm.tmp test_tool.htm
 %cmd_7z% a test_tool.htm.gz test_tool.htm -mx=9 -mfb=255
)

:: Update web.js
cd %temp_path%\%path_relative_src_http%\scripts
if "%webv%" == "all" (
 copy core.js + dh.js + md5.js + cryptojs_md5.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web.js /B mipc.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" web.js > web.js.tmp
 del web.js
 rename web.js.tmp web.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 java -jar %compiler_jar_path% --js mipc.js --js_output_file mipc.min.js
 %cmd_7z% a mipc.min.js.gz mipc.min.js -mx=9 -mfb=255 >%log%
 del mipc.min.js
 del mipc.js
 
 copy cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.core.base.js + mlib.core.hack.js + mlib.core.json.js + mlib.core.localstorage.js + mlib.core.cookie.js + mlib.core.drag.js + mlib.core.tips.js + mlib.core.mme.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.cloud.agent.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web_v2n.js /B mipc.v2n.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" web_v2n.js > web_v2n.js.tmp
 del web_v2n.js
 rename web_v2n.js.tmp web_v2n.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 java -jar %compiler_jar_path% --js mipc.v2n.js --js_output_file mipc.v2n.min.js
 %cmd_7z% a mipc.v2n.min.js.gz mipc.v2n.min.js -mx=9 -mfb=255 >%log%
 del mipc.v2n.min.js
 del mipc.v2n.js
 
 copy core.js + dh.js + md5.js + cryptojs_md5.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web_v2o.js /B mipc.v2o.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" web_v2o.js > web_v2o.js.tmp
 del web_v2o.js
 rename web_v2o.js.tmp web_v2o.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 java -jar %compiler_jar_path% --js mipc.v2o.js --js_output_file mipc.v2o.min.js
 %cmd_7z% a mipc.v2o.min.js.gz mipc.v2o.min.js -mx=9 -mfb=255 >>%log%
 del mipc.v2o.min.js
 del mipc.v2o.js
 
 copy jquery-1.8.3.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.core.base.js + mlib.core.hack.js + mlib.core.mme.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.cloud.agent.js + language.js + web_v3.js /B mipc.v3.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" web_v3.js > web_v3.js.tmp
 del web_v3.js
 rename web_v3.js.tmp web_v3.js
 %cmd_minised% "s/loading2.gif[?v]*[0-9.]*/loading2.gif?%ver%/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 java -jar %compiler_jar_path% --js mipc.v3.js --js_output_file mipc.v3.min.js
 %cmd_7z% a mipc.v3.min.js.gz mipc.v3.min.js -mx=9 -mfb=255 >>%log%
 del mipc.v3.min.js
 del mipc.v3.js
 
 copy cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.base.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.core.mme.js + mlib.core.localstorage.js + mlib.cloud.agent.js + web_test.js /B mipc_test.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc_test.js > mipc_test.js.tmp
 del mipc_test.js
 rename mipc_test.js.tmp mipc_test.js
 java -jar %compiler_jar_path% --js mipc_test.js --js_output_file mipc_test.min.js
 %cmd_7z% a mipc_test.min.js.gz mipc_test.min.js -mx=9 -mfb=255 >>%log%
 del mipc_test.min.js
 del mipc_test.js
)
if "%webv%" == "v1" (
 copy core.js + dh.js + md5.js + cryptojs_md5.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web.js /B mipc.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" web.js > web.js.tmp
 del web.js
 rename web.js.tmp web.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.min.css?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.js > mipc.js.tmp
 del mipc.js
 rename mipc.js.tmp mipc.js
 java -jar %compiler_jar_path% --js mipc.js --js_output_file mipc.min.js
 %cmd_7z% a mipc.min.js.gz mipc.min.js -mx=9 -mfb=255 >%log%
 del mipc.min.js
 del mipc.js
)

if "%webv%" == "v2n" (
 copy cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.core.base.js + mlib.core.hack.js + mlib.core.json.js + mlib.core.localstorage.js + mlib.core.cookie.js + mlib.core.drag.js + mlib.core.tips.js + mlib.core.mme.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.cloud.agent.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web_v2n.js+ avc-codec-orig.js+ avc.js /B mipc.v2n.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" web_v2n.js > web_v2n.js.tmp
 del web_v2n.js
 rename web_v2n.js.tmp web_v2n.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.v2n.min.css?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.v2n.js > mipc.v2n.js.tmp
 del mipc.v2n.js
 rename mipc.v2n.js.tmp mipc.v2n.js
 java -jar %compiler_jar_path% --js mipc.v2n.js --js_output_file mipc.v2n.min.js
 %cmd_7z% a mipc.v2n.min.js.gz mipc.v2n.min.js -mx=9 -mfb=255 >%log%
 del mipc.v2n.min.js
 del mipc.v2n.js
 rename web_v2n.js web_v2n.js.tmp
 del /f /s /q *.js
 rename web_v2n.js.tmp web_v2n.js
)

if "%webv%" == "v2o" (
 copy core.js + dh.js + md5.js + cryptojs_md5.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + jquery-1.8.3.js + jquery-ui.min.js + slider.js + jquery.mousewheel.js + jquery.mCustomScrollbar.js + jquery.ui.datepicker.js + jquery.ui.datepicker-zh-CN.js + jquery-ui-timepicker-addon.js + jquery-ui-timepicker-zh-CN.js + jquery.jNice.js + jquery.tzSelect.js + heartcode-canvasloader.js + jquery.ibutton.js + jquery.metadata.js + business.js + web_v2o.js /B mipc.v2o.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/web_client_v:\"[v]*[0-9.]*\"/web_client_v:\"%ver%\"/g" web_v2o.js > web_v2o.js.tmp
 del web_v2o.js
 rename web_v2o.js.tmp web_v2o.js
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/loading.gif[?v]*[0-9.]*/loading.gif?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.v2o.min.css?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/apk[?v]*[0-9.]*/apk?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 %cmd_minised% "s/zip[?v]*[0-9.]*/zip?%ver%/g" mipc.v2o.js > mipc.v2o.js.tmp
 del mipc.v2o.js
 rename mipc.v2o.js.tmp mipc.v2o.js
 java -jar %compiler_jar_path% --js mipc.v2o.js --js_output_file mipc.v2o.min.js
 %cmd_7z% a mipc.v2o.min.js.gz mipc.v2o.min.js -mx=9 -mfb=255 >>%log%
 del mipc.v2o.min.js
 del mipc.v2o.js
 rename web_v2o.js web_v2o.js.tmp
 del /f /s /q *.js
 rename web_v2o.js.tmp web_v2o.js
)

if "%webv%" == "v3" (
 copy jquery-1.8.3.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.core.base.js + mlib.core.hack.js + mlib.core.mme.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.cloud.agent.js + language.js + web_v3.js /B mipc.v3.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 %cmd_minised% "s/web_client_v=\"[v]*[0-9.]*\"/web_client_v=\"%ver%\"/g" web_v3.js > web_v3.js.tmp
 del web_v3.js
 rename web_v3.js.tmp web_v3.js
 %cmd_minised% "s/background.png[?v]*[0-9.]*/background.png?%ver%/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 %cmd_minised% "s/mipc.min.css[?v]*[0-9.]*/mipc.v3.min.css?%ver%/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 %cmd_minised% "s/loading2.gif[?v]*[0-9.]*/loading2.gif?%ver%/g" mipc.v3.js > mipc.v3.js.tmp
 del mipc.v3.js
 rename mipc.v3.js.tmp mipc.v3.js
 java -jar %compiler_jar_path% --js mipc.v3.js --js_output_file mipc.v3.min.js
 %cmd_7z% a mipc.v3.min.js.gz mipc.v3.min.js -mx=9 -mfb=255 >>%log%
 del mipc.v3.min.js
 del mipc.v3.js
 rename web_v3.js web_v3.js.tmp
 rename language.js language.js.tmp
 del /f /s /q *.js
 rename web_v3.js.tmp web_v3.js
 rename language.js.tmp language.js
)

if "%webv%" == "test" (
 copy cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mlib.core.base.js + mlib.core.evt.js + mlib.core.codec.js + mlib.core.rpc.js + mlib.crypt.dh.js + mlib.crypt.md5.js + mlib.cloud.account.js + mlib.core.mme.js + mlib.core.localstorage.js + mlib.cloud.agent.js + web_test_list.js + web_test.js /B mipc_test.js
 %cmd_minised% "s/mipc_img.png[?t]*[0-9.]*/mipc_img.png?%ver%/g" mipc_test.js > mipc_test.js.tmp
 del mipc_test.js
 rename mipc_test.js.tmp mipc_test.js
 java -jar %compiler_jar_path% --js mipc_test.js --js_output_file mipc_test.min.js
if "%pack%" == "1" (
 %cmd_7z% a mipc_test.min.js.gz mipc_test.min.js -mx=9 -mfb=255 >>%log%
 rename web_test.js web_test.js.tmp
 rename web_test_list.js web_test_list.js.tmp
 del /f /s /q *.js
 rename web_test.js.tmp web_test.js
 rename web_test_list.js.tmp web_test_list.js
) else (
 rename mipc_test.min.js mipc_test.min.js.tmp
 rename web_test.js web_test.js.tmp
 rename web_test_list.js web_test_list.js.tmp
 del /f /s /q *.js
 rename mipc_test.min.js.tmp mipc_test.min.js
 rename web_test.js.tmp web_test.js
 rename web_test_list.js.tmp web_test_list.js
)
)

:: Update mipc_play.js and mipc_play_x.js
if "%webv%" == "v1" (
 call:Update_play
)
if "%webv%" == "all" (
 call:Update_play
)

:: Update web.css
cd %temp_path%\%path_relative_src_http%\css
if "%webv%" == "v1" (
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.css
 call:Update_css ""
)
if "%webv%" == "v2o" (
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.v2o.css
 call:Update_css ".v2o"
 del /f /s /q *.css
)
if "%webv%" == "v2n" (
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.v2n.css
 call:Update_css ".v2n"
 del /f /s /q *.css
)
if "%webv%" == "v3" (
 copy web_v3.css /B mipc.v3.css
 call:Update_css ".v3"
)
if "%webv%" == "all" (
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.css
 call:Update_css ""
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.v2o.css
 call:Update_css ".v2o"
 copy slider.css + jquery.mCustomScrollbar.css + date-timepicker.css + jquery.tzSelect.css + jquery.ibutton.css + web.css /B mipc.v2n.css
 call:Update_css ".v2n"
 copy web_v3.css /B mipc.v3.css
 call:Update_css ".v3"
)

:: Prepare oem
cd %temp_path%\%path_relative_src_http%\oem
if "%webv%" == "v1" (
 for /f "delims=" %%i in ('dir /b %temp_path%\%path_relative_src_http%\oem') do (
  if exist %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css (
      copy %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css + %temp_path%\%path_relative_src_http%\css\mipc.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.css
  ) else (
      copy %temp_path%\%path_relative_src_http%\css\mipc.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.css
  )
  cd %temp_path%\%path_relative_src_http%\oem\%%i\css
  call:Update_css ""
  del mipc.css
  
  :: Image 准备oem内的图片资源
  cd %temp_path%\%path_relative_src_http%\oem\%%i\imgs
  for /f "delims=" %%a in ('dir /b %temp_path%\%path_relative_src_http%\imgs\') do (
     if not exist %%a (
       copy %temp_path%\%path_relative_src_http%\imgs\%%a %%a 
     )
  )
 ) 
)
if "%webv%" == "v3" (
 for /f "delims=" %%i in ('dir /b %temp_path%\%path_relative_src_http%\oem') do (
  if exist %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css (
      copy %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css + %temp_path%\%path_relative_src_http%\css\mipc.v3.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.v3.css
      del /f /s /q %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css
  ) else (
      copy %temp_path%\%path_relative_src_http%\css\mipc.v3.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.v3.css
  )
  cd %temp_path%\%path_relative_src_http%\oem\%%i\css
  call:Update_css ".v3"
  del mipc.v3.css 
  :: Image 准备oem内的图片资源
  cd %temp_path%\%path_relative_src_http%\oem\%%i\imgs
  for /f "delims=" %%a in ('dir /b %temp_path%\%path_relative_src_http%\imgs\') do (
     if not exist %%a (
       copy %temp_path%\%path_relative_src_http%\imgs\%%a %%a 
     )
  )
  del /f /s /q mipc_img.png
 )
)
if "%webv%" == "all" (
 for /f "delims=" %%i in ('dir /b %temp_path%\%path_relative_src_http%\oem') do (
  if exist %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css (
      copy %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css + %temp_path%\%path_relative_src_http%\css\mipc.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.css
      copy %temp_path%\%path_relative_src_http%\oem\%%i\css\data.css + %temp_path%\%path_relative_src_http%\css\mipc.v3.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.v3.css
  ) else (
      copy %temp_path%\%path_relative_src_http%\css\mipc.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.css
      copy %temp_path%\%path_relative_src_http%\css\mipc.v3.css /B %temp_path%\%path_relative_src_http%\oem\%%i\css\mipc.v3.css
  )
  cd %temp_path%\%path_relative_src_http%\oem\%%i\css
  call:Update_css ""
  call:Update_css ".v3"
  del mipc.css
  del mipc.v3.css
  
  :: Image 准备oem内的图片资源
  cd %temp_path%\%path_relative_src_http%\oem\%%i\imgs
  for /f "delims=" %%a in ('dir /b %temp_path%\%path_relative_src_http%\imgs\') do (
     if not exist %%a (
       copy %temp_path%\%path_relative_src_http%\imgs\%%a %%a 
     )
  )
 )  
)
cd %temp_path%\%path_relative_src_http%\css
del /f /s /q mipc*.css

call:Package

pause
goto :EOF

:Help
echo Usage:%1 [options]
echo Available options:
echo     path   path to store the packect(x:....)
echo     ver    packect version(vx.x.x)
echo     all    packect all (0 or 1)
echo     web    web version (v1 or v2o or v2n or v3 or test or all)
echo     pack   if pack the test js  ( only for test )
pause
exit
goto :EOF

:Prepare_sys
md "%temp_path%\%path_relative_src_sys%\conf"
md "%temp_path%\%path_relative_src_sys%\data\http\scripts"
copy %sys_src_path%\data\http\*.htm %temp_path%\%path_relative_src_sys%\data\http
del %temp_path%\%path_relative_src_sys%\data\http\*mme*.htm
xcopy %sys_src_path%\data\http\scripts %temp_path%\%path_relative_src_sys%\data\http\scripts
del /f /s /q %temp_path%\%path_relative_src_sys%\data\http\scripts\*mme*
md "%temp_path%\%path_relative_src_sys%\data\run"
xcopy %sys_src_path%\data\run %temp_path%\%path_relative_src_sys%\data\run
goto :EOF

:Package
cd %file_path%
%cmd_7z% a web.%ver%.tar %temp_path%\project -mx=9 -mfb=255 
%cmd_7z% a web.%ver%.tar.gz web.%ver%.tar -mx=9 -mfb=255 
del web.%ver%.tar
rd/s/Q %temp_path%
goto :EOF

:Update_css
if not "%webv%" == "v3" (
 %cmd_minised% "s/mipc_img.png[?v]*[0-9.]*/mipc_img.png?%ver%/g" mipc%1.css > mipc%1.css.tmp
) else (
 %cmd_minised% "s/background.png[?v]*[0-9.]*/background.png?%ver%/g" mipc%1.css > mipc%1.css.tmp
)
del mipc%1.css
rename mipc%1.css.tmp mipc%1.css
java -jar %yuicompressor_jar_path% --type css --charset utf-8 mipc%1.css -o mipc%1.min.css
%cmd_7z% a mipc%1.min.css.gz mipc%1.min.css -mx=9 -mfb=255
del mipc%1.min.css
goto :EOF

:Update_play
cd %temp_path%\%path_relative_src_http%
%cmd_minised% "s/play.min.js?[v]*[0-9.]*/play.min.js?%ver%/g" mipc_play_test.htm > mipc_play_test.htm.tmp
del mipc_play_test.htm
rename mipc_play_test.htm.tmp mipc_play_test.htm

%cmd_minised% "s/.htm?[v]*[0-9.]*/.htm?%ver%/g" mipc_play_index.htm > mipc_play_index.htm.tmp
del mipc_play_index.htm
rename mipc_play_index.htm.tmp mipc_play_index.htm
%cmd_minised% "s/.js?[v]*[0-9.]*/.js?%ver%/g" mipc_play_index.htm > mipc_play_index.htm.tmp
del mipc_play_index.htm
rename mipc_play_index.htm.tmp mipc_play_index.htm

%cmd_minised% "s/.js?[v]*[0-9.]*/.js?%ver%/g" mipc_play_main.htm > mipc_play_main.htm.tmp
del mipc_play_main.htm
rename mipc_play_main.htm.tmp mipc_play_main.htm

%cmd_minised% "s/.js?[v]*[0-9.]*/.js?%ver%/g" mipc_play_main.debug.htm > mipc_play_main.debug.htm.tmp
del mipc_play_main.debug.htm
rename mipc_play_main.debug.htm.tmp mipc_play_main.debug.htm

cd %temp_path%\%path_relative_src_http%\scripts
%cmd_minised% "s/index.htm?[v]*[0-9.]*/index.htm?%ver%/g" mipc_play.js > mipc_play.js.tmp
del mipc_play.js
rename mipc_play.js.tmp mipc_play.js

java -jar %compiler_jar_path% --js mipc_play.js --js_output_file mipc_play.min.js
%cmd_7z% a mipc_play.min.js.gz mipc_play.min.js -mx=9 -mfb=255
del mipc_play.min.js

copy core.js + dh.js + md5.js + cryptojs_md5.js + cryptojs_tripledes.js + cryptojs_pad-nopadding-min.js + mipc_play_main.js /B mipc_play_x.js
java -jar %compiler_jar_path% --js mipc_play_x.js --js_output_file mipc_play_x.min.js
%cmd_7z% a mipc_play_x.min.js.gz mipc_play_x.min.js -mx=9 -mfb=255
del mipc_play_x.js
del mipc_play_x.min.js
goto :EOF