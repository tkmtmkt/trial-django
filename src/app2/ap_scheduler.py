from apscheduler.schedulers.background import BackgroundScheduler

def ap_scheduler(): # 任意の関数名
    # 定期実行対象の処理を実装
    print('10秒毎に定期実行---------------------------------')

def start():
    scheduler = BackgroundScheduler()
    scheduler.add_job(ap_scheduler, 'interval', hours=0, seconds=10)
    scheduler.start()
