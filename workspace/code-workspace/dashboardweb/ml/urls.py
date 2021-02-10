from django.urls import path

from .views import MlHomeView

urlpatterns = [

    path('', MlHomeView.as_view(), 'home'),

]