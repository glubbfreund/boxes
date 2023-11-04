function fish_mode_prompt
    if [ $fish_key_bindings = fish_vi_key_bindings ]
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set -g fishvimode "default"  
            case insert
                set -g fishvimode "insert"
            case visual
                set -g fishvimode "visual"
            case replace_one
                set -g fishvimode "replace"
        end
    end
end
