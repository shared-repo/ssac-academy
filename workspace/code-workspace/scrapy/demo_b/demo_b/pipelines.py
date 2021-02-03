# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter


class DemoBPipeline:
    def process_item(self, item, spider):
        return item


class RecruitInfoItemPipeline:

    def open_spider(self, spider):
        if spider.name == 'jobkorea':
            import pymysql
            conn = pymysql.connect(host='localhost',
                                   database='pydemodb',
                                   user='root',
                                   password='Pa$$w0rd',
                                   charset='utf8')

            self.conn = conn # process_item, close_spider에서 사용할 수 있도록 객체에 저장


    def process_item(self, item, spider):
        if spider.name == 'jobkorea':
            with self.conn.cursor() as cursor:
                sql = """
                    insert into tbl_recruit (cname, title, exp, edu, loc) 
                    values (%s, %s, %s, %s, %s)
                """
                cursor.execute(sql, item.to_list())

                self.conn.commit()

        return item

    def close_spider(self, spider):
        if spider.name == 'jobkorea':
            self.conn.close()
