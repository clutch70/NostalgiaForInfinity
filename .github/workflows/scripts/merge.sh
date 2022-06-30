oldCommit=$(git log --pretty=format:'%h' -n 1)
#echo Collected hash is $oldCommit
echo GHUSER is $GHUSER
echo GHEMAIL is $GHEMAIL
git config --global user.name $GHUSER
git config --global user.email $GHEMAIL
git pull --unshallow  # this option is very important, you would get
                      # complains about unrelated histories without it.
                      # (but actions/checkout@v2 can also be instructed
                      # to fetch all git depth right from the start)
git remote add upstream https://github.com/iterativv/NostalgiaForInfinity
git fetch upstream
git merge upstream/main
git push origin main

# Delete the next 3 lines if you don't have any other forks.
# Rename "short" if you do
git checkout short
git merge upstream/main
git push origin short
newCommit=$(git log --pretty=format:'%h' -n 1)
#echo Collected hash is $newCommit
if [[ "$oldCommit" == "$newCommit" ]]
then
  echo Commit $newCommit is unchanged!!!
  exit
fi

if [[ "$oldCommit" != "$newCommit" ]]
then
  echo Commit is updated!!! New commit hash is $newCommit
  git clone https://github.com/clutch70/pushover
  cd pushover
  echo $POTOKEN > pushover_api
  python3 pushover.py "NFI Fork Updated" "GH workflows have automatically merged upstream NFI changes to the CN fork." "0"
fi
