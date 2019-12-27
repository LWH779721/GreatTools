import uiautomator2 as u2
import sys
import time

#连接设备
d = u2.connect('f0e0e7d67d23')

#点亮屏幕
d.screen_on()

#打开程序
#d.app_start("com.tencent.mm")

while 1:
	#暂停播放
    d.click(350, 600)
    
    #添加关注
    d(resourceId="com.ss.android.ugc.aweme:id/b_a").click()
    
    #喜欢
    d(resourceId="com.ss.android.ugc.aweme:id/ca6").click()
    
    #评论
    #d(resourceId="com.ss.android.ugc.aweme:id/ca0").click()
    #d(resourceId="com.ss.android.ugc.aweme:id/ca0").click()
    #d(resourceId="com.ss.android.ugc.aweme:id/a7y").click()
    
    #进主页
    if d.exists(resourceId="com.ss.android.ugc.aweme:id/b_8"):
        d(resourceId="com.ss.android.ugc.aweme:id/b_8").click()
        
        #私信
        d(resourceId="com.ss.android.ugc.aweme:id/aj9").click()
        d(resourceId="com.ss.android.ugc.aweme:id/byj").set_text("测试")
        d(resourceId="com.ss.android.ugc.aweme:id/k7").click()
        d(resourceId="com.ss.android.ugc.aweme:id/by9").click()
        
        d(resourceId="com.ss.android.ugc.aweme:id/mg").click()
        time.sleep(2) 
	
	#滑动进入下一个视频 	
    d.swipe(350, 600, 350, 0)
    time.sleep(2)
    
#sys.exit(0)
