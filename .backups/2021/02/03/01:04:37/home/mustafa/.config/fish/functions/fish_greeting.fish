function fish_greeting
    set -l art_path $HOME"/repos/Ascii_arts/ascii_files/"
    
    set -l alien "$art_path""alien"
    set -l amongus "$art_path""amongus"
    set -l bird "$art_path""bird"
    set -l c "$art_path""c"
    set -l debian "$art_path""debian"
    set -l dog "$art_path""dog"
    set -l ferris "$art_path""ferris"
    set -l ferris2 "$art_path""ferris2"
    set -l godot "$art_path""godot"
    set -l horn "$art_path""horn"
    set -l poison "$art_path""poison"
    set -l rust "$art_path""rust"
    set -l skull "$art_path""pukeskull"
    set -l ts "$art_path""ts"
    
    switch (random 0 15)
	case 0
	    fish_logo
	case 1
	    cat $skull
	case 2
	    cat $poison | lolcat
	case 3
	    cat $horn
	case 4
	    cat $dog | lolcat
	case 5
	    cat $bird
	case 6
	    cat $alien
	case 7
	    cat $amongus
	case 8
	    python_logo
	case 9
	    cat $godot
	case 10
	    cat $c
	case 11
	    cat $ts
	case 12
	    cat $rust
	case 13
	    cat $ferris
	case 14
	    cat $debian
	case 15
	    cat $ferris2

    end
end
