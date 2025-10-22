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
PROMPT='%F{#EB52F7}%n%f  @  %F{#EB52F7}%m%f  %F{white}[%~]%f $(git_prompt_info)$(git_prompt_emoji)
%F{#EB52F7}➜ %f'

# --- Git repo state -> emoji (no arithmetic; extra-safe) ---
# 😡 if uncommitted changes; 😞 if ahead/behind or no upstream; 🐢 if clean & in sync
git_prompt_emoji() {
  git rev-parse --is-inside-work-tree &>/dev/null || return 0

  # Uncommitted changes?
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    echo " 😡"
    return 0
  fi

  # Need an upstream to be "in sync"
  local upstream
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null) || {
    echo " 😞"
    return 0
  }

  # Get "BEHIND AHEAD", sanitize to digits only
  local counts behind ahead
  counts=$(git rev-list --left-right --count "${upstream}...HEAD" 2>/dev/null || echo "0 0")

  # split to two fields
  read -r behind ahead <<<"$counts"
  behind=${behind//[^0-9]/}
  ahead=${ahead//[^0-9]/}
  [[ -z "$behind" ]] && behind=0
  [[ -z "$ahead"  ]] && ahead=0

  # string compare only (no arithmetic)
  if [[ "$ahead" != "0" ]]; then
    echo " 😞"   # commits to push
  elif [[ "$behind" != "0" ]]; then
    echo " 🥶"   # behind remote
  else
    echo " 🐢"   # clean & in sync
  fi
}
