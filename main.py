from github import Github
import argparse




def get_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument("name")


    args = parser.parse_args()
    return args



def check_dir(g, name):
    for repo in g.get_user().get_repos():
        if str(repo.name) == name:
            return False
        else:
            return True


project_name = get_arguments().name


access_token = "XXXXXXXXX" # Your github token

g = Github(access_token)



if check_dir(g, project_name):

    g.get_user().create_repo(project_name, private=True)
    
    if check_dir(g, project_name):
        print("[+] Github repository created")
    else:
        print("[-] There was a problem creating repo")

else:
    print("[-] Repository with same name already exists")
    exit()
