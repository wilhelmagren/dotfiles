function gcp --description 'alias gcp=git add -A && git commit -a -m && git push'
    git add -A && git commit -a -m $argv && git push
end
