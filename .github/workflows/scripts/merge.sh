oldCommit=$(git log --pretty=format:'%h' -n 1)
echo Collected hash is $oldCommit
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
newCommit=$(git log --pretty=format:'%h' -n 1)
echo Collected hash is $newCommit
if [[ "$oldCommit" == "$newCommit" ]]
then
  echo Commit is unchanged!!!
  exit
fi

if [[ "$oldCommit" != "$newCommit" ]]
then
  echo Commit is updated!!! New commit hash is $newCommit
fi
