# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from .items import WinningNumbersInfo


class DemoAPipeline:
    def process_item(self, item, spider):
        return item


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


