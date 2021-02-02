import scrapy

class QuotesSpider2(scrapy.Spider):

    name = 'quotes2'
    
    # start_urls --> 내부에 정의된 start_request 메서드를 자동으로 실행하는 
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
        'http://quotes.toscrape.com/page/2/',
    ]

    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f'quotes-{page}.html' # f'string' : 문자열 내부에 외부의 변수를 직접 삽입할 수 있는 문자열
        with open(filename, 'wb') as f:
            f.write(response.body)



