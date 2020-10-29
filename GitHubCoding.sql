#### Setting up and linking a github 

####installing Gedit (needed for this assignment)
pi@raspberrypi:~/GitHub $ sudo apt-get install gedit

####making new directory 
pi@raspberrypi:~ $ mkdir hubspot

####open directory
pi@raspberrypi:~ $ cd hubspot

####create repo 
pi@raspberrypi:~/hubspot $ git init
Initialized empty Git repository in /home/pi/hubspot/.git/

####linking to user 
pi@raspberrypi:~/hubspot $ git config --global user.mail "kevinseegers123@gmail.com"
pi@raspberrypi:~/hubspot $ git config --global user.name "Kavinskay"

####checking for connection
pi@raspberrypi:~/hubspot $ ls -a
.  ..  .git

####make and edit file 
pi@raspberrypi:~/hubspot $ gedit README.md

####Adding file to the waiting room
pi@raspberrypi:~/hubspot $ git add README.md

####overview of files waiting to be comitted 
pi@raspberrypi:~/hubspot $ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   README.md

#####comitting readme file to the repo skeleton
pi@raspberrypi:~/hubspot $ git commit -am "add README.md"
[master (root-commit) b30b8c0] add README.md
 1 file changed, 3 insertions(+)
 create mode 100644 README.md

####adding other files to the repo skeleton
pi@raspberrypi:~/hubspot $ git add --all
pi@raspberrypi:~/hubspot $ git commit -am "uploading recommender system files"
[master fb67a04] uploading recommender system files
 5 files changed, 5392 insertions(+)
 create mode 100644 Reccomender system /RecommenderCoding.sql
 create mode 100755 Reccomender system /moviesFromMetacritic.csv
 create mode 100644 Reccomender system /top50reccomendationsTitleforSocialNetwork.csv
 create mode 100644 Reccomender system /top50reccomendationsforSocialNetwork.csv
 create mode 100644 Reccomender system /topreccomendationsStarringforSocialNetwork.csv

####practise log function
pi@raspberrypi:~/hubspot $ git log README.md
commit b30b8c029d0d29fa98ef079c5833540465b0012d
Author: Kavinskay <kevinseegers123@gmail.com>
Date:   Wed Oct 28 17:18:53 2020 +0100

    add README.md

pi@raspberrypi:~/hubspot $ git log RecommenderCoding.sql
fatal: ambiguous argument 'RecommenderCoding.sql': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

####checking current repo status 
pi@raspberrypi:~/hubspot $ git status
On branch master
nothing to commit, working tree clean

####making branche 
pi@raspberrypi:~/hubspot $ git checkout -b lidar-version 
Switched to a new branch 'lidar-version'

####checking branche 
pi@raspberrypi:~/hubspot $ git branch
* lidar-version
  master

####changing to master and merging the branches 
pi@raspberrypi:~/hubspot $ git checkout master
Switched to branch 'master'
pi@raspberrypi:~/hubspot $ git merge lidar-version

####setting up and checking connection to the cloud 
pi@raspberrypi:~/hubspot $ git remote add origin kevinseegers123@gmail.com:Kavinskay/hubspot.git
pi@raspberrypi:~/hubspot $ git remote -v
origin	kevinseegers123@gmail.com:Kavinskay/hubspot.git (fetch)
origin	kevinseegers123@gmail.com:Kavinskay/hubspot.git (push)

####Removing a origin (when needed)
pi@raspberrypi:~/hubspot $ git remote rm origin
#Checking for sure
pi@raspberrypi:~/hubspot $ git remote -v

####pushing first files 
pi@raspberrypi:~/hubspot $ git push -u origin master
Username for 'https://github.com': Kavinskay
Password for 'https://Kavinskay@github.com': 
warning: redirecting to https://github.com/Kavinskay/hubspot.git/
Enumerating objects: 11, done.
Counting objects: 100% (11/11), done.
Delta compression using up to 4 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (11/11), 1.52 MiB | 767.00 KiB/s, done.
Total 11 (delta 0), reused 0 (delta 0)
To http://github.com/Kavinskay/hubspot.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
