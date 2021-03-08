from django.urls import path

from .views import DemoAView, IrisPredictView, DiabetesPredictView

urlpatterns = [

    path('demo-a', DemoAView.as_view(), name='demo_a'),
    path('predict-species', IrisPredictView.as_view(), name="iris_predict"),
    path('predict-diabetes', DiabetesPredictView.as_view(), name='diabetes_predict'),

]