from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = '''
    サンプルコマンド
    '''

    def handle(self, *args, **options):
        print("サンプルコマンド実行")
