from django.shortcuts import render

from django.views.generic.base import View, TemplateView

from django.http.response import HttpResponse

# Create your views here.

class DemoAView(TemplateView):
    template_name = 'ml/demo-a.html'

class IrisPredictView(View):

    def __init__(self):
        # 예측 모델과 변환기 준비
        import joblib
        
        estimator = joblib.load('ml/estimators/iris-model.pkl')
        scaler = joblib.load('ml/estimators/iris-scaler.pkl')

        self.estimator = estimator
        self.scaler = scaler

    # def get(self, request): # get 요청을 처리하는 함수
    #     pass

    def post(self, request): # post 요청을 처리하는 함수
        # 요청 데이터를 읽기 (사용자가 브라우저에서 입력하고 전송한 데이터 읽기)
        sepal_length = float(request.POST.get('sepal_length'))
        sepal_width = float(request.POST.get('sepal_width'))
        petal_length = float(request.POST.get('petal_length'))
        petal_width = float(request.POST.get('petal_width'))

        # 테스트 코드
        print([sepal_length, sepal_width, petal_length, petal_width])

        # 입력 데이터에 대한 Scale 변환
        scaled_data = self.scaler.transform([[sepal_length, sepal_width, petal_length, petal_width]])

        # Scale 변환된 데이터로 예측 실행
        predicted_value = self.estimator.predict(scaled_data)

        # 예측 결과를 사용자 친화적인 표현으로 변경 (숫자 -> 문자열)
        predicted_str_value = 'setosa' if predicted_value[0] == 0 \
                                       else 'versicolor' if predicted_value[0] == 1 \
                                                         else 'virginica'

        # 테스트 코드
        print(predicted_value, predicted_str_value)

        # Json 형식의 응답 문자열 만들기
        import json

        json_value = json.dumps( { "predicted_value" : predicted_str_value }, ensure_ascii=False )

        # 요청에 대한 응답 전송
        return HttpResponse(json_value, content_type='application/json')


class DiabetesPredictView(View):

    def __init__(self):
        import joblib

        estimator = joblib.load('ml/estimators/diabetes-model.pkl')
        scaler = joblib.load('ml/estimators/diabetes-scaler.pkl')

        self.estimator = estimator
        self.scaler = scaler

    # def get(self, request):
    #     pass

    def post(self, request):
        # 요청 데이터를 읽기 (사용자가 브라우저에서 입력하고 전송한 데이터 읽기)
        pregnancies = float(request.POST.get('pregnancies'))
        glucose = float(request.POST.get('glucose'))
        blood_pressure = float(request.POST.get('blood_pressure'))
        skin_thickness = float(request.POST.get('skin_thickness'))
        insulin = float(request.POST.get('insulin'))
        bmi = float(request.POST.get('bmi'))
        diabetes_pedigree_function = float(request.POST.get('diabetes_pedigree_function'))
        age = float(request.POST.get('age'))

        # 테스트 코드
        print([pregnancies, glucose, blood_pressure, skin_thickness, insulin, bmi, diabetes_pedigree_function, age])

        # 입력 데이터에 대한 Scale 변환
        scaled_data = self.scaler.transform([[pregnancies, glucose, blood_pressure, skin_thickness, insulin, bmi, diabetes_pedigree_function, age]])

        # Scale 변환된 데이터로 예측 실행
        predicted_value = self.estimator.predict(scaled_data)

        # 예측 결과를 사용자 친화적인 표현으로 변경 (숫자 -> 문자열)
        predicted_str_value = 'No Diabetes' if predicted_value[0] == 0 else 'Diabetes'

        # 테스트 코드
        print(predicted_value, predicted_str_value)

        # Json 형식의 응답 문자열 만들기
        import json

        json_value = json.dumps( { "predicted_value" : predicted_str_value }, ensure_ascii=False )

        # 요청에 대한 응답 전송
        return HttpResponse(json_value, content_type='application/json')
