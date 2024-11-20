import requests
import json
# URL used to make request to Sonar API
# More information can be found via Sonar API docs: https://next.sonarqube.com/sonarqube/web_api/api/user_tokens?query=token
url = "http://localhost:9000/api/user_tokens/generate"

def get_token(url=url):
    token = requests.post(url,  data={"name": "access-token"})
    if token.status_code == 200:
        token = json.loads(token)
        return token["token"]
    
    return "Unsuccessful request, please ensure you are authenticated & authorized to the Sonar Server."




if __name__ == "__main__":
   print(get_token(url))

