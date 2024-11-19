import requests
import json

url = "http://localhost:9000/api/user_tokens/generate"

def get_token(url=url):
    token = requests.post(params=url, data={"name": "access-token"})
    

