import scrapy

class QuotesSpider5(scrapy.Spider):

    name = 'quotes5'

    def start_requests(self): 
        url = 'http://quotes.toscrape.com/'
        # tag = self.tag
        tag = getattr(self, 'tag', None)
        # print("--------------------------------------------------------->", tag)
        if tag is not None:
            url = url + "tag/" + tag
        
        yield scrapy.Request(url, callback=self.parse)
        
    def parse(self, response):
        quotes = response.css('div.quote')
        for quote in quotes:
            yield {
                'text': quote.css('span.text::text').get(),
                'author': quote.css('small.author::text').get(),
                'tags': quote.css('div.tags a.tag::text').getall()
            }

        next_page = response.css('li.next a::attr(href)').get()
        if next_page is not None:
            yield response.follow(next_page, callback=self.parse)



