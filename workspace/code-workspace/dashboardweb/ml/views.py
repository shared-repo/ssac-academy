from django.shortcuts import render

from django.views.generic.base import View, TemplateView

from django.http.response import HttpResponse

# Create your views here.

class MlHomeView(TemplateView):
    template_name = 'ml/home.html'
