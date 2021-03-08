from django.urls import path

from .views import DemoAView, DemoBView, IrisPredictView, DiabetesPredictView, ContentBasedRecommendView

urlpatterns = [

    path('demo-a', DemoAView.as_view(), name='demo_a'),
    path('predict-species', IrisPredictView.as_view(), name="iris_predict"),
    path('predict-diabetes', DiabetesPredictView.as_view(), name='diabetes_predict'),

    path('demo-b', DemoBView.as_view(), name='demo_b'),
    path('recommend-by-content', ContentBasedRecommendView.as_view(), name="recommend_by_content")

]