import jenkinsapi
from jenkinsapi.jenkins import Jenkins
from jenkinsapi.build import Build
import json
b = Build()
server = Jenkins("http://localhost:8080") 

def build(server=server):
    server = Jenkins("http://localhost:8080")
    return server

def build_issues():
    failed_jobs, c = {}, 0
    issues = b.get_causes()
    if issues:
        for i in issues:
            c += 1
            failed_jobs[c] = i
        return json.dumps(failed_jobs, indent=4)
    
    return "Everything looks fine."

def plugins():
    if server.get_plugins():
        items, c =  {}, 0
        for i in server.get_plugins().values():
            items[c + 1] = i.get_download_link(), c = c + 1 
        return json.dumps(items, indent=4)
    
    return "Install a few plugins and come back later :)"



def disable(name=None):
    if server.has_job(None):
        disable = server.get_job(name)
        disable.disable()
        return f"The job: {name} has been disabled!"
    else:
     return "Make sure that the job name is active!"

# function that makes detecting user changes easier. 
def change_sets():
    changes, mods, 0 = b.get_changeset_items(), {}, 0
    m = 0
    if changes:
        for i in changes[0]:
            mods["paths{c}"] = i, c = c + 1
        for i in changes[1]:
            if i["fullName"] in mods:
                i[m + 1] = i["absoluteUrl"]
            
            i[m] = i["absoluteUrl"]
        return json.dumps(mods, indent=4)
    
    return "No changeset items available."




if __name__ == "__main__":
    print(change_sets())
    print(build_issues())




