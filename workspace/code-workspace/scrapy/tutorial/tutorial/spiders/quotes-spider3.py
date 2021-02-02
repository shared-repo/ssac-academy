import scrapy

class QuotesSpider3(scrapy.Spider):

    name = 'quotes3'
    
    # start_urls --> 내부에 정의된 start_request 메서드를 자동으로 실행하는 
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
        'http://quotes.toscrape.com/page/2/',
    ]

    def parse(self, response):
        quotes = response.css('div.quote')
        for quote in quotes:
            yield {
                'text': quote.css('span.text::text').get(),
                'author': quote.css('small.author::text').get(),
                'tags': quote.css('div.tags a.tag::text').getall()
            }



