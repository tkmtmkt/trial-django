from django.apps import AppConfig


class App2Config(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'app2'

    # ap_scheduler起動処理を追加
    def ready(self):
        from .ap_scheduler import start
        start()
