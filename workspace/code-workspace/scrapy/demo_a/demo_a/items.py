# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class DemoAItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass

class WinningNumbersInfo(scrapy.Item):
    rnd = scrapy.Field() # getter / setter 만들기
    no1 = scrapy.Field()
    no2 = scrapy.Field()
    no3 = scrapy.Field()
    no4 = scrapy.Field()
    no5 = scrapy.Field()
    no6 = scrapy.Field()
    bno = scrapy.Field()

    def to_list(self):
        return [ self['rnd'], self['no1'], self['no2'], self['no3'], self['no4'], self['no5'], self['no6'], self['bno'] ]

