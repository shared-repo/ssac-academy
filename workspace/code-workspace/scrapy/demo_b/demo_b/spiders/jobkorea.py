from scrapy import Spider, Request
from ..items import RecruitInfoItem

class JobkoreaSpider(Spider):
    
    name = 'jobkorea'
    
    allowed_domains = ['www.jobkorea.co.kr']
    
    def start_requests(self):

        self.page_no = 1 # 검색 결과가 다수인 경우 페이지별로 조회하기 위한 페이지 번호
        # self.searchword # 검색어 : scrapy crawl jobkorea -a searchword=검색어
        searchword = getattr(self, "searchword", None)
        if searchword is not None:
            # 요청 보내기
            url = "http://www.jobkorea.co.kr/Search/?stext={0}&tabType=recruit&Page_No={1}".format(searchword, self.page_no)
            yield Request(url=url, callback=self.parse)
            pass

    def parse(self, response):
        
        lis = response.css('div.recruit-info li[data-gno]')
        if lis is not None and len(lis) is not 0:
            # 응답 처리 ( html을 파싱해서 key-value 형식의 객체 반환 )
            for li in lis:
                info = RecruitInfoItem()
                info['cname'] = li.css(".post-list-corp a::text").get()
                info['title'] = li.css('.post-list-info a::text').get()
                info['exp'] = li.css('.post-list-info p.option .exp::text').get()
                info['edu'] = li.css('.post-list-info p.option .edu::text').get()     
                info['loc'] = li.css('.post-list-info p.option .loc.long::text').get()
                
                yield info

            # 재요청 보내기 (페이지 번호를 변경해서 다음 페이지 요청)
            self.page_no += 1
            url = "http://www.jobkorea.co.kr/Search/?stext={0}&tabType=recruit&Page_No={1}".format(self.searchword, self.page_no)
            yield Request(url=url, callback=self.parse)
