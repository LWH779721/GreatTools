import uiautomator2 as u2
import sys
import time
import schedule

def clockIn():
    #连接设备
    d = u2.connect('c746dd057d28')

    print(d.info)

    #点亮屏幕
    #d.screen_on()

    while 1:
        try:
            #打开程序
            d.app_start("com.weaver.emobile7")
    
            d(resourceId="com.weaver.emobile7:id/layout_three").wait(timeout=3.0)
            #
            d(resourceId="com.weaver.emobile7:id/layout_three").click()
            
            d(text="app016").wait(timeout=1.0)
            #
            d(text="app016").click()
        except Exception as e:
            d(resourceId="com.android.systemui:id/home").click()
            try:
                d.app_stop("com.weaver.emobile7")
            except Exception as e:
                pass
            continue
        
        try:
            d(text="打卡").wait(timeout=3.0)
            a = d(text="打卡").get_text() == '打卡'
        except Exception as e:
            pass
        else:
            try:
                d(text="打卡").click()
                time.sleep(1)
            except:
                pass
        
        try:
            a = d(text="更新打卡时间").get_text() == '更新打卡时间'
        except Exception as e:
            try:
                d.click(0.54, 0.826)
            except:
                pass
            d(resourceId="com.android.systemui:id/back").click()
        else:
            d(text="更新打卡时间").click()
            exit(0)  
        
        time.sleep(1)
    
schedule.clear()
#schedule.every(1).days.at("08:55").do(clockIn)
schedule.every().wednesday.at("08:48").do(clockIn)
schedule.every().monday.at("08:50").do(clockIn)
schedule.every().tuesday.at("08:51").do(clockIn)
schedule.every().thursday.at("08:40").do(clockIn)
schedule.every().friday.at("08:44").do(clockIn)
schedule.every().saturday.at("08:56").do(clockIn)
while 1:
    schedule.run_pending()
    time.sleep(1)
    
