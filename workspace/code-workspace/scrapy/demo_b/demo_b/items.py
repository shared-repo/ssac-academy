# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class DemoBItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass

class RecruitInfoItem(scrapy.Item):
    cname = scrapy.Field()
    title = scrapy.Field()
    exp = scrapy.Field()
    edu = scrapy.Field()
    loc = scrapy.Field()

    def to_list(self):
        return [ self['cname'], self['title'], self['exp'], self['edu'], self['loc'] ]
