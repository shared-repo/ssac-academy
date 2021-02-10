from django.urls import path

from .views import MlHomeView, IrisPredictView, DiabetesPredictView

urlpatterns = [

    path('', MlHomeView.as_view(), name='home'),
    path('predict-species', IrisPredictView.as_view(), name="iris_predict"),
    path('predict-diabetes', DiabetesPredictView.as_view(), name='diabetes_predict'),

]