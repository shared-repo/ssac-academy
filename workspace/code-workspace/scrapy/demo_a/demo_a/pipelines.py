# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from .items import WinningNumbersInfo
from scrapy.exceptions import DropItem

class DemoAPipeline:
    def process_item(self, item, spider):
        return item

class LottoDupCheckPipeline:
    def process_item(self, item, spider):        

        if type(item) is WinningNumbersInfo:
        
            import pymysql

            # 1. 연결하기
            conn = pymysql.connect(host='localhost',
                                database='pydemodb',
                                user='root',
                                password='Pa$$w0rd',
                                charset='utf8')

            # 2. 명령하기
            with conn.cursor() as cursor:
                sql = """
                    select count(*) from tbl_lotto where rnd = %s
                """
                cursor.execute(sql, (item['rnd']))

                row = cursor.fetchone()

                if row[0] > 0: # 중복 데이터 발견
                    raise DropItem('error') # 현재 처리중인 Item에 대한 처리 중단 (반환 값에서 제거)
                    
            conn.close()

        return item # 다음 파이프라인으로 전달 (필수)

class LottoInsertPipeline:
    def process_item(self, item, spider):        

        if type(item) is WinningNumbersInfo:
        
            import pymysql

            # 1. 연결하기
            conn = pymysql.connect(host='localhost',
                                database='pydemodb',
                                user='root',
                                password='Pa$$w0rd',
                                charset='utf8')

            # 2. 명령하기
            with conn.cursor() as cursor:
                sql = """
                    insert into tbl_lotto (rnd, no1, no2, no3, no4, no5, no6, bno) 
                    values (%s, %s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, item.to_list())

                conn.commit()

            conn.close()

        return item # 다음 파이프라인으로 전달 (필수)


