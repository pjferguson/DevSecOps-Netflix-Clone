import jenkinsapi
from jenkinsapi.jenkins import Jenkins
from jenkinsapi.build import Build

server = Jenkins("http://localhost:8080") 
def version(server=server):
    return server.version()
    


if __name__ == "__main__":
    print(version())


