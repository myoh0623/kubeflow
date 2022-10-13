import requests
import json
import warnings
warnings.filterwarnings("ignore")

HOST = "https://192.168.0.200:8080/"
USERNAME = "user@example.com"
PASSWORD = "12341234"

session = requests.Session()
response = session.get(HOST, verify=False) #ssl 접속시 verify=False 

headers = {
    "Content-Type": "application/x-www-form-urlencoded",
}

data = {"login": USERNAME, "password": PASSWORD}
session.post(response.url, headers=headers, data=data)
# session_cookie = session.cookies.get_dict()["authservice_session"]
session_cookie = session.cookies.get_dict()
print(session_cookie)

sklearn_iris_input={
    "instances": [
      [6.8,  2.8,  4.8,  1.4],
      [6.0,  3.4,  4.5,  1.6]
    ]
}

headers = {"Host": "sklearn-iris.kubeflow-user-example-com.example.com"}
res = session.post("https://192.168.0.200:8080/v1/models/sklearn-iris:predict", headers=headers, cookies=session_cookie, json=sklearn_iris_input)
print(res.text)
# print(res.json())