import scrapy

class QuotesSpider(scrapy.Spider):

    name = 'quotes'
    
    # start_urls = ['http://quotes.toscrape.com/']

    def start_requests(self):
        urls = [
            'http://quotes.toscrape.com/page/1/',
            'http://quotes.toscrape.com/page/2/',
        ]
        
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse) # yield : return한 후에 다시 돌아오는 명령 ( 호출하는 쪽에서는 반복문에서 사용 )

    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f'quotes-{page}.html' # f'string' : 문자열 내부에 외부의 변수를 직접 삽입할 수 있는 문자열
        with open(filename, 'wb') as f:
            f.write(response.body)



