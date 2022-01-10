# 区切り文字やアイコン（一目でなにか分かる名前にしておく）
set -l separator_triangle   \ue0b0
set -l icon_cross           \uf00d
set -l icon_plus                    \uf067  # 追加
set -l icon_three_point_reader      \uf6d7  # 追加
set -l icon_octocat                 \uf113  # 追加 
# 区切り文字などを、少し抽象的な名前で登録する
set segment_separator               $separator_triangle         # 追加
set icon_miss                       $icon_cross                 # 追加
set icon_untracked                  $icon_three_point_reader    # 追加
set icon_git_symbol                 $icon_octocat               # 追加
set icon_git_dirty                  $icon_plus                  # 追加
 
set icon_home                       \uf7db  # 追加
set icon_folder                     \uf07c  # 追加

set segment_separator       $separator_triangle
set icon_miss               $icon_cross
 
set color_user
set color_git_status_bar    #追加
 
function _segment
    set_color -b $argv[1] $argv[2]
    echo -n "$segment_separator "
end
 
function _prompt_dir
    printf ' %s ' (prompt_pwd)
    _segment $color_user $color_dark
end
 
function _prompt_user
    printf '%s ' (set_color $white)(whoami)
 
    # 〜ここから〜
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        _change_color_git_status_bar
        _segment $color_git_status_bar $color_user;
    else
        _segment normal $color_user
    end
    # 〜ここまでを追加〜
end
 
# 〜ここから〜
function _change_color_git_status_bar
    if [ (_is_git_dirty) ]; set color_git_status_bar $color_git_dirty
    else; set color_git_status_bar $color_git_main; end
end
 
function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end
 
function _prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
        _change_color_git_status_bar
        set_color -b $color_git_status_bar
        printf '%s ' (set_color $black)$git_branch
        _segment normal $color_git_status_bar
    end
end
# 〜ここまでを追加〜
 
function fish_prompt
 
    set -l last_status $status
 
    set_color -b $color_dark $white
 
    if [ $last_status -gt 0 ]
        echo -n (set_color $white)" $icon_miss "
        set color_user $color_warning
    else
        set color_user $color_main
    end
 
    _prompt_dir
    _prompt_user
    _prompt_git      # 追加
end
