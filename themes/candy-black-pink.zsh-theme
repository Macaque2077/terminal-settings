# Candy Black & Pink Theme (Apple magenta #EB52F7)
# Clean spacing for readability, tuned for black terminal backgrounds

autoload -U colors && colors

# Git prompt styling
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#EB52F7}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*%F{#EB52F7}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Right-side clock in dim gray
RPROMPT='%F{240}%D{[%H:%M]}%f'

# Main prompt with improved spacing:
# user @ host [cwd] (git)
# new line with pink arrow
PROMPT='%F{#EB52F7}%n%f @ %F{#EB52F7}%m%f  %F{white}[%~]%f $(git_prompt_info)
%F{#EB52F7}➜ %f'
