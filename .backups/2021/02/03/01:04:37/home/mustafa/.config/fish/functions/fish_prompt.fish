set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_untrackedfiles '…'

set __fish_git_prompt_color_branch 9cdcfe
set __fish_git_prompt_color_cleanstate 74d349
set __fish_git_prompt_color_upstream 58ffde
set __fish_git_prompt_color_invalidstate d16969
set __fish_git_prompt_color_dirtystate ce9178
set __fish_git_prompt_color_stagedstate fde49e



set fish_color_command 0052e0
set fish_color_param $fish_color_normal

function __colorize
	 set -l text $argv[1]
	 set -l color $argv[2]
	 set_color $color
	 printf $text
	 set_color normal
end

function fish_right_prompt
	 __colorize (prompt_pwd) ce9178
	 set_color normal
end

function fish_prompt
	 printf "\n"
	 __colorize "><((" 6abafb
	 __fish_git_prompt "(%s)"	 
	 __colorize "❯ " 6abafb
end