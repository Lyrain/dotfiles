# Prompt is influenced by xxf.zsh-theme, a modification of oh-my-zsh's ys.zsh-theme
# Credit where credit is due:
# xxf.zsh-theme - http://xiafan.at
# ys.zsh-theme - https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/ys.zsh-theme
function fish_prompt -d "Write out the prompt"
    set -l last_pipelinestatus $pipestatus
    set -l normal (set_color normal)

    # Color the prompt differently where we're root
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '›'
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If were running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Write pipestatus
    set -l prompt_status \
       (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) \
        (set_color --bold $fish_color_status) $last_pipelinestatus)

    echo -n -s -e (set_color $fish_color_user) "$USER" $normal " at " \
       (set_color $color_host) (prompt_hostname) $normal ' in ' \
       (set_color $color_cwd) "[" (prompt_pwd) "]" $normal \
       (fish_vcs_prompt) $normal $prompt_status "\n" \
       $suffix " "
end
