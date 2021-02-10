from django.urls import path

from .views import MlHomeView, IrisPredictView

urlpatterns = [

    path('', MlHomeView.as_view(), name='home'),
    path('predict-species', IrisPredictView.as_view(), name="iris_predict")

]