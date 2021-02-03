eval "$(ssh-agent -s)" && ssh-add ~/.ssh/gh_id_rsa && ssh -T git@github.com
