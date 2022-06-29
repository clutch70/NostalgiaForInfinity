echo Displaying current commit hash
echo
git log --pretty=format:'%h' -n 1
oldCommit=$(git log --pretty=format:'%h' -n 1)
echo
echo Collected hash is $oldCommit
git config --global user.name 'clutch70'
git config --global user.email 'b.custard@outlook.com'
git pull --unshallow  # this option is very important, you would get
                      # complains about unrelated histories without it.
                      # (but actions/checkout@v2 can also be instructed
                      # to fetch all git depth right from the start)
git remote add upstream https://github.com/iterativv/NostalgiaForInfinity
git fetch upstream
git merge upstream/main
git push origin main
echo Displaying new commit hash
git log --pretty=format:'%h' -n 1
newCommit=$(git log --pretty=format:'%h' -n 1)
echo
echo Collected hash is $newCommit
