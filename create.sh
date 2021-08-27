#!/bin/zsh

all=0
LANG_D=0
DIR=""
LANG=""






create_folder() {

    base_dir="/Users/buckneer/Documents/projects"
    project_dir=""

    if [[ $2 -eq 1 ]]
    then
        project_dir="$base_dir/$3/$1"
        echo "[+] Moved to language directory"

        # Check if folder already exists
        if [ -d "/Users/buckneer/Documents/projects/$3" ]
        then 
            echo "[+] Directory already exists"
            
        else
            echo "[+] Creating project directory"
            mkdir /Users/buckneer/Documents/projects/$3
            
        fi

    
        mkdir $project_dir
        cd $project_dir
        

    else
        # In home dir
        project_dir="$base_dir/$1"
        mkdir $project_dir
        cd $project_dir
    fi
    
    clear

    if [[ $4 -eq 1 ]]
    then 
        echo "[+] Creating repo $1"
    
        python3 /Users/buckneer/Documents/Automation/create/create_repo.py $DIR
        
        
        echo "# $DIR" >> README.md
        git init
        git add .
        git commit -m "first commit"
        git branch -M main
        git remote add origin https://github.com/buckneer/$DIR.git
        git push -u origin main
    
        clear

        echo "Created Repo"
    fi

    echo "[+] Project $1 created"

    echo "[+] Openning in code"
    sleep 5

    code .
}

Help()
{
   # Display Help
    echo
    echo "# Automate creating projects with simple bash script #"
    echo
    echo "Syntax: create [-g|h|n|l / --github/help/name/lang]"
    echo
    echo
    echo "Flags:"
    echo
    echo "   [-g | --github]     Add to Github Repository"
    echo "   [-h | --help]       Print this Help."
    echo "   [-n | --name]       Specify the name of the project"
    echo "   [-l | --lang]       Language for the project"
    echo
}


while true 
do
    case $1 in
        -h | --help)
            Help
            exit 0
            ;;
        -g | --github)
            all=1
            ;;
        -n | --name)
            
            DIR=$2
            if [[ $DIR -eq 0 ]] 
            then
                echo "ERROR: You must specify name of the project"
                exit 1
            fi
            shift
            ;;
        -l | --lang)
            LANG=$2
            LANG_D=1
            shift
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)
            break
    esac
    shift
done

          


create_folder $DIR $LANG_D $LANG $all




