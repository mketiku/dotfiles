Fix commits under wrong email/username
```sh
git filter-branch --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "<Old Name>" ];
        then
                GIT_COMMITTER_NAME="<New Name>";
                GIT_AUTHOR_NAME="<New Name>";
                GIT_COMMITTER_EMAIL="<New Email>";
                GIT_AUTHOR_EMAIL="<New Email>";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
```

```sh
#conditional commit history 
git filter-branch -f --env-filter "
GIT_AUTHOR_NAME='michael ketiku'
GIT_AUTHOR_EMAIL='mketiku@gmail.com'
GIT_COMMITTER_NAME='michael ketiku'
GIT_COMMITTER_EMAIL='mketiku@gmail.com'
" HEAD
#reset all commit history 
```