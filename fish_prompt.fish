function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd)

    # Display current path
    if not test $last_status -eq 0
        set_color --bold red
    else
        set_color --bold green 
    end
    echo ""
    echo -n "   " 
    set_color --bold magenta
    echo -n (basename $cwd)  
    echo -n " "
    set_color normal


    # Show git branch and dirty state
    if git_is_repo 
        set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
        set -l git_dirty (command git status -s --ignore-submodules=dirty 2> /dev/null)
        set -l git_changed (command git status -s -uno | wc -l)
        set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
        if test $commit_count
            set -l behind (echo $commit_count | cut -f 1)
            set -l ahead (echo $commit_count | cut -f 2)
            if test $behind -gt 0
                set git_meta ""
            end
            if test $ahead -gt 0
                set git_meta ""
            end
        end

        if test $git_changed -gt 0
            set git_meta "$git_meta~$git_changed"
        end
        if test -n "$git_branch"
            if test -n "$git_dirty"
                set_color black -b yellow
                echo -n "  $git_branch $git_meta " 
            else
                set_color black -b green
                echo -n "  $git_branch $git_meta "
            end
        end
    end
 

    # Add a space
    set_color normal
    echo -n ' '
    switch $fishvimode
        case "insert"
        case "visual"
            set_color black -b magenta
            echo -n "  Visual "
            set_color normal
            echo -ne" "
        case "replace"
            set_color black -b red
            echo -n "  Replace "
            set_color normal
            echo -n " "
        case default
            set_color black -b blue
            echo -n "  Normal "
            set_color normal
            echo -n " "
    end
    set_color normal
    echo -n " "
end
