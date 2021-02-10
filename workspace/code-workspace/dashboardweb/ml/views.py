from django.shortcuts import render

from django.views.generic.base import View, TemplateView

from django.http.response import HttpResponse

# Create your views here.

class MlHomeView(TemplateView):
    template_name = 'ml/home.html'

class IrisPredictView(View):

    # def get(self, request): # get 요청을 처리하는 함수
    #     pass

    def post(self, request): # post 요청을 처리하는 함수
    
        pass
