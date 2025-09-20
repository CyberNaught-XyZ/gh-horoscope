#!/bin/bash

# Display module for GitHub CLI Horoscope Extension
# Handles all terminal formatting, colors, and ASCII art

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# Rainbow colors for mystical effects
RAINBOW_COLORS=(
    '\033[0;31m'  # Red
    '\033[1;33m'  # Yellow
    '\033[0;32m'  # Green
    '\033[0;36m'  # Cyan
    '\033[0;34m'  # Blue
    '\033[0;35m'  # Magenta
)

# Terminal width detection and responsive box sizing
get_terminal_width() {
    local width
    # First try COLUMNS environment variable, then tput
    if [[ -n "$COLUMNS" ]]; then
        width="$COLUMNS"
    elif command -v tput >/dev/null 2>&1; then
        width=$(tput cols 2>/dev/null) || width=80
    else
        width=80
    fi
    # Ensure reasonable bounds
    if [[ $width -lt 60 ]]; then
        width=60
    elif [[ $width -gt 200 ]]; then
        width=200
    fi
    echo "$width"
}



# Enhanced visual width calculation accounting for emojis and special characters
calculate_visual_width() {
    local text="$1"
    # Remove ANSI color codes first - handle both escape sequence styles
    local clean_text="$text"
    # Remove \033[...m sequences
    clean_text="${clean_text//\\033\[[0-9;]*m/}"
    # Remove \e[...m sequences  
    clean_text="${clean_text//\\e\[[0-9;]*m/}"
    # Remove actual escape sequences (when variables are expanded)
    clean_text=$(echo "$clean_text" | sed 's/\x1b\[[0-9;]*m//g')
    
    # Count common emojis that appear in our text (they display as 2 chars but count as 1)
    local emoji_count=0
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🔮" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎭" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🌟" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "⭐" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎪" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎉" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "✨" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "💫" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🌙" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "☀️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o  "⚡" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "📜" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🃏" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "👑" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🔥" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "💝" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🏛️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🚪" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🏆" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🌶️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "👁️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎴" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "👯" | wc -l)))
    # Add menu emojis
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🐛" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "💼" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "📚" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "👥" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "👤" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🛠️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🚀" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🥠" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🧘" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎯" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🤝" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🌍" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "❄️" | wc -l)))
    emoji_count=$((emoji_count + $(echo "$clean_text" | grep -o "🎯" | wc -l)))
    
    # Calculate visual width: regular chars + extra space for emojis
    local regular_length=${#clean_text}
    local visual_width=$((regular_length + emoji_count))
    
    echo "$visual_width"
}

# Ultimate centering function that handles ALL ASCII elements
center_ascii_block() {
    local content="$1"
    local terminal_width=$(get_terminal_width)
    local max_line_width=0
    
    # Find the widest line accounting for emoji visual width
    while IFS= read -r line; do
        local visual_width=$(calculate_visual_width "$line")
        [[ $visual_width -gt $max_line_width ]] && max_line_width=$visual_width
    done <<< "$content"
    
    # Center each line individually
    local left_padding=$(( (terminal_width - max_line_width) / 2 ))
    [[ $left_padding -lt 0 ]] && left_padding=0
    
    while IFS= read -r line; do
        printf "%*s%s\n" $left_padding "" "$line"
    done <<< "$content"
}

# Backward compatibility wrapper
get_visual_text_width() {
    calculate_visual_width "$1"
}

# Center text within terminal width
center_text() {
    local text="$1" 
    local width=$(get_terminal_width)
    local visual_width=$(get_visual_text_width "$text")
    local padding=$(( (width - visual_width) / 2 ))
    
    # Ensure padding is not negative
    if [[ $padding -lt 0 ]]; then
        padding=0
    fi
    
    printf "%*s%s\n" $padding "" "$text"
}



# Display functions
display_header() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    cat << 'EOF'
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                       🔮 GITHUB CRYSTAL BALL                         ║
    ║                                                                      ║
    ║             ✨ Mystical Analysis of Your Coding Patterns             ║
    ║                                                                      ║
    ║         .-.                                                          ║
    ║       .'{o}'.                                                        ║
    ║      (_/_\_)           "The commits reveal all..."                   ║
    ║       d'b                                                            ║
    ║                                                                      ║
    ╚══════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    echo
}
# Crystal ball for interactive mode
display_crystal_ball() {
    echo -e "${MAGENTA}${BOLD}"
    local crystal_art=(
        "           🔮 ✨ 🔮 ✨ 🔮 ✨ CRYSTAL BALL ✨ 🔮 ✨ 🔮 ✨ 🔮"
        ""
        "                    🌟"
        "                 ✨ 💫 ✨"
        "               💫 ✨ 🔮 ✨ 💫"
        "             ✨ 🌟 💫 🔮 💫 🌟 ✨"
        "           💫 ✨ 🔮 ✨ 🌟 ✨ 🔮 ✨ 💫"
        "         ✨ 🌟 💫 🔮 ✨ 🔮 ✨ 🔮 💫 🌟 ✨"
        "       🌟 ✨ 💫 🔮 ✨ 🌟 💫 🌟 ✨ � �💫 ✨ 🌟"
        "     💫 ✨ 🌟 💫 🔮 ✨ 🔮 🌟 🔮 ✨ 🔮 💫 🌟 ✨ 💫"
        "       🌟 ✨ 💫 🔮 ✨ 🌟 💫 🌟 ✨ 🔮 💫 ✨ 🌟"
        "         ✨ 🌟 💫 🔮 ✨ 🔮 ✨ 🔮 💫 🌟 ✨"
        "           💫 ✨ 🔮 ✨ 🌟 ✨ 🔮 ✨ 💫"
        "             ✨ 🌟 💫 🔮 💫 🌟 ✨"
        "               💫 ✨ 🔮 ✨ 💫"
        "                 ✨ 💫 ✨"
        "                     🌟"
        ""
        "        💫 The sphere of infinite possibilities 💫"
        ""
    )
    
    # Use the center function to properly align each line
    for line in "${crystal_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}
# Display magical divider
display_mystical_divider() {
    echo -e "${CYAN}"
    echo "    ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦"
    echo -e "${RESET}"
}

# Display coding magic portal
display_magic_portal() {
    echo -e "${MAGENTA}"
    local portal_art=(
        "                   ╭───────╮"
        "                  ╭─┤ ◇ ◇ ◇ ├─╮"
        "                ╭─┤   ◆ ◆ ◆   ├─╮"
        "              ╭─┤     ◈ ◈ ◈     ├─╮"
        "            ╭─┤       ♦ ♦ ♦       ├─╮"
        "          ╭─┤         ◉ ◉ ◉         ├─╮"
        "          │           PORTAL          │"
        "          ╰─┤         ◉ ◉ ◉         ├─╯"
        "           ╰─┤       ♦ ♦ ♦       ├─╯"
        "            ╰─┤     ◈ ◈ ◈     ├─╯"
        "              ╰─┤   ◆ ◆ ◆   ├─╯"
        "                ╰─┤ ◇ ◇ ◇ ├─╯"
        "                  ╰───────╯"
    )
    
    for line in "${portal_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Display code matrix effect
display_code_matrix() {
    echo -e "${GREEN}"
    local matrix_art=(
        "    01001000 01100101 01101100 01101100 01101111"
        "    01010111 01101111 01110010 01101100 01100100"
        "         ░▒▓█ DECODING YOUR PATTERNS █▓▒░"
        "    01000011 01001111 01000100 01000101 01010010"
        "    01001101 01000001 01000111 01001001 01000011"
    )
    
    for line in "${matrix_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Display mystical gears
display_mystical_gears() {
    echo -e "${YELLOW}"
    local gears_art=(
         "           ⚙️      ⚙️       ⚙️"
          "         ⚙️ ⚙️   ⚙️ ⚙️   ⚙️ ⚙️"
         "           ⚙️      ⚙️       ⚙️"
        "\"The gears of code destiny turn...\""
    )
    
    for line in "${gears_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

display_footer() {
    echo
    echo -e "${GRAY}${DIM}"
    local footer_art=(
        "────────────────────────────────────────────────────────────────────────"
        "   🌟 May your builds be green and your merge conflicts be few 🌟"
        ""
        "   Created for \"For the Love of Code 2025\" - Terminal Talent Category"
        "────────────────────────────────────────────────────────────────────────"
    )
    
    for line in "${footer_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

display_section_header() {
    local title="$1"
    local icon="$2"
    echo -e "${CYAN}${BOLD}"
    echo "    ┌─────────────────────────────────────────────────────────────────┐"
    echo "    │                                   $icon  $title                 |"
    echo "    └─────────────────────────────────────────────────────────────────┘"
    echo -e "${RESET}"
}

display_info() {
    echo -e "${BLUE}ℹ️  $1${RESET}"
}

display_success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

display_warning() {
    echo -e "${YELLOW}⚠️  $1${RESET}"
}

display_error() {
    echo -e "${RED}❌ $1${RESET}"
}

display_mystical_quote() {
    local quote="$1"
    echo -e "${MAGENTA}${BOLD}"
    
    # Wrap and center the quote properly
    local wrapped_quote="\"$(echo "$quote" | fold -s -w 73)\""
    center_text "$wrapped_quote"
    echo -e "${RESET}"
    echo
}



display_horoscope_section() {
    local title="$1"
    local content="$2"
    local icon="$3"
    
    # Use the clean header + separator format with cyan color
    echo -e "${CYAN}${BOLD}"
    display_mystical_section "$icon  $title"
    echo -e "${WHITE}"
    
    # Process content with proper wrapping and single bullet point
    echo -n "    • "
    wrap_mystical_text "$content" | sed '1!s/^/      /'
    echo -e "${RESET}"
    
    echo
}

display_stats_line() {
    local label="$1"
    local value="$2"
    local color="$3"
    
    printf "    %-25s ${color}${BOLD}%s${RESET}\n" "$label:" "$value"
}

display_rainbow_text() {
    local text="$1"
    local i=0
    local char_count=0
    
    for ((i=0; i<${#text}; i++)); do
        char="${text:i:1}"
        if [[ "$char" != " " && "$char" != $'\t' && "$char" != $'\n' ]]; then
            color_index=$((char_count % ${#RAINBOW_COLORS[@]}))
            echo -ne "${RAINBOW_COLORS[$color_index]}$char${RESET}"
            ((char_count++))
        else
            echo -n "$char"
        fi
    done
    echo
}

display_progress_bar() {
    local current="$1"
    local total="$2"
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    
    echo -n "    ["
    for ((i=0; i<filled; i++)); do
        echo -ne "${GREEN}█${RESET}"
    done
    for ((i=filled; i<width; i++)); do
        echo -ne "${GRAY}░${RESET}"
    done
    echo "] ${percentage}%"
}

display_constellation() {
    echo -e "${YELLOW}"
    local constellation_art=(
        "         *   .  *       .             *"
        "    .        *   .        .    *"
        "        .     ✨        .        .  *"
        "    *     .     *     .     *     ."
        "        .   *     .     .    ."
        "    .     *   .   *   .      .   *"
        "         .     *     .   *    ."
        "    *   .   *    .     *    .   *"
    )
    
    for line in "${constellation_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

display_moon_phase() {
    local phase="$1"
    case "$phase" in
        "new")        echo "🌑 New Moon" ;;
        "waxing")     echo "🌒 Waxing Crescent" ;;
        "first")      echo "🌓 First Quarter" ;;
        "waxing_gib") echo "🌔 Waxing Gibbous" ;;
        "full")       echo "🌕 Full Moon" ;;
        "waning_gib") echo "🌖 Waning Gibbous" ;;
        "last")       echo "🌗 Last Quarter" ;;
        "waning")     echo "🌘 Waning Crescent" ;;
        *)            echo "🌙 Moon" ;;
    esac
}

display_coffee_cup() {
    echo -e "${YELLOW}"
    local coffee_art=(
        "                ☕"
        "              c[_]"
        "                |"
        "           _____|_____"
    )
    
    for line in "${coffee_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

display_loading_animation() {
    local message="$1"
    local duration="${2:-3}"
    local spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i=0
    
    echo -n "    "
    for ((t=0; t<duration*10; t++)); do
        echo -ne "\r${CYAN}${spinner[i]} $message${RESET}"
        i=$(((i+1) % ${#spinner[@]}))
        sleep 0.1
    done
    echo -ne "\r${GREEN}✓ $message${RESET}\n"
}

# Enhanced mystical loading with different themes
display_oracle_loading() {
    local message="$1"
    local duration="${2:-3}"

    echo -e "\n ${YELLOW}🌟 Consulting the Oracle... 🌟${RESET}"
    echo -e "         ${MAGENTA}✨ ••• ✨ ••• ✨${RESET}"
    echo -e "${CYAN}🔮 Analyzing your GitHub soul... 🔮${RESET}\n"

    local symbols=("🔮" "✨" "🌟" "🌙" "⭐" "💫" "🌠" "☄️")
    
    for ((i=0; i<duration*4; i++)); do
        local symbol_index=$((i % ${#symbols[@]}))
        echo -ne "\r${YELLOW}${symbols[$symbol_index]} $message${RESET}"
        sleep 0.25
    done
    echo -ne "\r${GREEN}🌟 $message - The Oracle has spoken!${RESET}\n"
}

# Crystal ball consultation loading
display_crystal_ball_loading() {
    local message="$1"
    local duration="${2:-4}"
    
    echo -e "\n${MAGENTA}✧･ﾟ: *✧･ﾟ:* The Crystal Ball Awakens *:･ﾟ✧*:･ﾟ✧${RESET}"
    
    local frames=(
        "           ${CYAN}.:･ﾟ✧ 🔮 ✧ﾟ･:.${RESET}"
        "           ${MAGENTA}.:･ﾟ✧ 🔮 ✧ﾟ･:.${RESET}"
        "           ${YELLOW}.:･ﾟ✧ 🔮 ✧ﾟ･:.${RESET}"
        "           ${BLUE}.:･ﾟ✧ 🔮 ✧ﾟ･:.${RESET}"
    )
    
    for ((i=0; i<duration*2; i++)); do
        local frame_index=$((i % ${#frames[@]}))
        echo -ne "\r       ${frames[$frame_index]}"
        sleep 0.5
    done
    echo -e "\r                     ${GREEN}.:･ﾟ✧ ✅ ✧ﾟ･:.${RESET}"
    echo -e "${GREEN}$message - Complete!${RESET}\n"
}

# GitHub API loading animation
display_github_loading() {
    local message="$1"
    local duration="${2:-3}"
    
    echo -e "\n${CYAN}🐙 Summoning GitHub's ancient spirits... 🐙${RESET}"
    
    local github_symbols=("📊" "📈" "🔍" "⚡" "🚀" "💻" "🌐" "📡")
    local dots=""
    
    for ((i=0; i<duration*3; i++)); do
        local symbol_index=$((i % ${#github_symbols[@]}))
        dots+="."
        if [[ ${#dots} -gt 3 ]]; then
            dots="."
        fi
        echo -ne "\r${BLUE}${github_symbols[$symbol_index]} $message$dots${RESET}"
        sleep 0.33
    done
    echo -ne "\r${GREEN}✅ $message - Data retrieved!${RESET}\n"
}

# Unique ASCII art for different Oracle types
display_oracle_art() {
    local oracle_type="$1"
    
    case "$oracle_type" in
        "debugging")
            echo -e "${RED}"
            echo "                            🐛 ═══ 🔍 ═══ 🐛"
            echo "                          ╔══════════════════╗"
            echo "                          ║ DEBUGGING ORACLE ║"
            echo "                          ╚══════════════════╝"
            echo "                             🔧 🛠️  🔨 ⚙️  🔧"
            ;;
        "career")
            echo -e "${BLUE}"
            echo "                             💼 ═══ 📈 ═══ 💼"
            echo "                          ╔═══════════════════╗"
            echo "                          ║   CAREER ORACLE   ║"
            echo "                          ╚═══════════════════╝"
            echo "                             👑 💪 🚀 🌟 💎"
            ;;
        "learning")
            echo -e "${GREEN}"
            echo "                            📚 ═══ 🎓 ═══ 📚"
            echo "                          ╔═══════════════════╗"
            echo "                          ║  LEARNING ORACLE  ║"
            echo "                          ╚═══════════════════╝"
            echo "                             🧠 💡 🔬 📖 ✨"
            ;;
        "teamwork")
            echo -e "${YELLOW}"
            echo "                            👥 ═══ 🤝 ═══ 👥"
            echo "                          ╔═══════════════════╗"
            echo "                          ║  TEAMWORK ORACLE  ║"
            echo "                          ╚═══════════════════╝"
            echo "                             🌉 🤗 💬 🎭 🔄"
            ;;
        "burnout")
            echo -e "${MAGENTA}"
            echo "                            🔥 ═══ 🧘 ═══ 🔥"
            echo "                          ╔═══════════════════╗"
            echo "                          ║  WELLNESS ORACLE  ║"
            echo "                          ╚═══════════════════╝"
            echo "                             🌱 😌 ⚖️  🌸 🦋"
            ;;
        "confidence")
            echo -e "${CYAN}"
            echo "                            👤 ═══ 💪 ═══ 👤" 
            echo "                          ╔═══════════════════╗"
            echo "                          ║ CONFIDENCE ORACLE ║"
            echo "                          ╚═══════════════════╝"
            echo "                             🦁 💎 🌟 ⭐ 🔮"
            ;;
        "technology")
            echo -e "${WHITE}"
            echo "                            🛠️  ═══ ⚡ ═══ 🛠️ "
            echo "                          ╔═══════════════════╗"
            echo "                          ║ TECHNOLOGY ORACLE ║"
            echo "                          ╚═══════════════════╝"
            echo "                             💻 🔧 ⚙️  🖥️ 📱"
            ;;
        "legacy")
            echo -e "${GRAY}"
            echo "                           🏛️  ═══ 📜 ═══ 🏛️ "
            echo "                          ╔═══════════════════╗"
            echo "                          ║ LEGACY CODE ORACLE║"
            echo "                          ╚═══════════════════╝"
            echo "                             ⚰️ 🗿 📿 🕯️ ⚱️"
            ;;
        "projects")
            echo -e "${GREEN}"
            echo "                            🚀 ═══ 💡 ═══ 🚀"
            echo "                          ╔═══════════════════╗"
            echo "                          ║SIDE PROJECT ORACLE║"
            echo "                          ╚═══════════════════╝"
            echo "                             🌱 🎨 🛸 ✨ 🎯"
            ;;
        "opensource")
            echo -e "${BLUE}"
            echo "                            🌟 ═══ 🌍 ═══ 🌟"
            echo "                          ╔═══════════════════╗"
            echo "                          ║ OPEN SOURCE ORACLE║"
            echo "                          ╚═══════════════════╝"
            echo "                             🌺 🤝 🌿 💚 🕊️"
            ;;
        *)
            echo -e "${MAGENTA}"
            echo "                            🔮 ═══ ✨ ═══ 🔮"
            echo "                          ╔═══════════════════╗"
            echo "                          ║  MYSTICAL ORACLE  ║"
            echo "                          ╚═══════════════════╝"
            echo "                             🌙 ⭐ 💫 🌟 ✨"
            ;;
    esac
    echo -e "${RESET}"
    echo
}

# Mystical divider with dynamic centering
display_mystical_divider() {
    local width=$(get_terminal_width)
    local sparkle_pattern=""
    
    if [[ $width -lt 80 ]]; then
        sparkle_pattern="✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦"
    elif [[ $width -lt 120 ]]; then
        sparkle_pattern="✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦"
    else
        sparkle_pattern="✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦"
    fi
    
    echo -e "${MAGENTA}"
    center_text "$sparkle_pattern"
    echo -e "${RESET}"
    echo
}

# Crystal ball display for interactive mode
# Responsive ASCII art scaling
display_crystal_ball_responsive() {
    local width=$(get_terminal_width)
    case $width in
        60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80)
            display_compact_crystal_ball
            ;;
        81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|120)
            display_standard_crystal_ball
            ;;
        *)
            display_deluxe_crystal_ball
            ;;
    esac
}

# Compact crystal ball for narrow terminals (60-80 cols)
display_compact_crystal_ball() {
    echo -e "${CYAN}"
    local compact_art=(
        "              ･ﾟ✧*:･ﾟ✧"
        "           ･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "      .:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧:."
        "      .:*･ﾟ  ────────  ﾟ･*:."
        "     .:*･ﾟ   ✦ 🔮 ✦   ﾟ･*:."
        "      '*･ﾟ  ────────  ﾟ･*'"
        "       '*･ﾟ✧:..:･ﾟ✧*'"
        "         '*･ﾟ✧*'"
        "           '*'"
    )
    
    for line in "${compact_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Standard crystal ball for medium terminals (80-120 cols) 
display_standard_crystal_ball() {
    echo -e "${CYAN}"
    local standard_art=(
        "                               ･ﾟ✧*:･ﾟ✧"
        "                           ･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                       ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                     ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                    ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                  .:･ﾟ✧*:･ﾟ✧   ･ﾟ✧*:･ﾟ✧:."
        "                 .:*･ﾟ ──────────  ﾟ･*:."
        "                 .:*･ﾟ  ✦  🔮  ✦  ﾟ･*:."
        "                 '*･ﾟ  ──────────  ﾟ･*'"
        "                  '*･ﾟ✧:..:･ﾟ✧*'"
        "                      '*･ﾟ✧*'"
        "                        '*'"
    )
    
    for line in "${standard_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Deluxe crystal ball for wide terminals (160+ cols)
display_deluxe_crystal_ball() {
    echo -e "${CYAN}"
    local deluxe_art=(
        "                            ✧･ﾟ: *✧･ﾟ:*  ✧･ﾟ: *✧･ﾟ:*"
        "                          ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                        ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                          ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                      .:･ﾟ✧*:･ﾟ✧*:･ﾟ✧   ･ﾟ✧*:･ﾟ✧*:･ﾟ✧:."
        "                     .:*･ﾟ*:･ﾟ ────────────  ﾟ･*:ﾟ･*:."
        "                    .:*･ﾟ*:･ﾟ   ✦✨ 🔮 ✨✦   ﾟ･*:ﾟ･*:."
        "                     '*･ﾟ*:･ﾟ  ────────────  ﾟ･*:ﾟ･*'"
        "                       '*･ﾟ✧*:･ﾟ✧:..:･ﾟ✧*:･ﾟ✧*'"
        "                           '*･ﾟ✧*:･ﾟ✧*'"
        "                             '*･ﾟ*'"
        "          🌟✨ ═══ THE COSMIC CODE DIVINATION CHAMBER ═══ ✨🌟"
    )
    
    for line in "${deluxe_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Original crystal ball function uses the hardcoded ASCII art
# The main display_crystal_ball() function is defined earlier in the file

# Enhanced crystal ball display
display_enhanced_crystal_ball() {
    echo -e "${CYAN}"
    local enhanced_art=(
        "                        ･ﾟ✧*:･ﾟ✧"
        "                      ･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                    ･ﾟ✧*:･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                      ･ﾟ✧*:･ﾟ✧*:･ﾟ✧"
        "                  .:･ﾟ✧*:･ﾟ✧   ･ﾟ✧*:･ﾟ✧:."
        "                 .:*･ﾟ ────────── ﾟ･*:."
        "                .:*･ﾟ   ✦  🔮  ✦  ﾟ･*:."
        "                 '*･ﾟ  ────────── ﾟ･*'"
        "                  '*･ﾟ✧:..:･ﾟ✧*'"
        "                      '*･ﾟ✧*'"
        "                        '*'"
        ""
        "      🌟✨ THE COSMIC CODE DIVINATION CHAMBER ✨🌟"
    )
    
    for line in "${enhanced_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Simple section separator function for comedy generator
# Simple section separator function for mystical content - like comedy generator  
display_mystical_section() {
    local title="$1"
    local separator_length=75  # Standard length for consistency
    
    echo "    $title"
    printf "    "
    for ((i=0; i<separator_length; i++)); do
        printf "═"
    done
    echo
    echo
}

# Text wrapping function for mystical content
wrap_mystical_text() {
    local text="$1"
    echo "$text" | fold -s -w 75
}

# Simple section separator function for comedy generator
display_comedy_section() {
    local title="$1"
    local separator_length=63  # Standard length for consistency
    
    echo -e "${CYAN}${BOLD}"
    echo "    $title"
    printf "    "
    for ((i=0; i<separator_length; i++)); do
        printf "═"
    done
    echo
    echo -e "${RESET}"
    echo
}

# Animated mystical loading
display_mystical_loading() {
    local message="$1"
    local symbols=("🌑" "🌒" "🌓" "🌔" "🌕" "🌖" "🌗" "🌘")
    
    echo -n "    "
    for i in {0..20}; do
        local symbol_index=$((i % ${#symbols[@]}))
        echo -ne "\r    ${YELLOW}${symbols[$symbol_index]} $message${RESET}"
        sleep 0.15
    done
    echo -ne "\r    ${GREEN}✨ $message - Complete!${RESET}\n"
}

# Display mystical insight in a beautiful responsive box
display_mystical_insight() {
    local title="$1"
    local content="$2"
    
    # Use the clean header + separator format with cyan color
    echo -e "${CYAN}${BOLD}"
    display_mystical_section "$title"
    echo -e "${WHITE}"
    
    # Process content with proper wrapping and single bullet point
    echo -n "    • "
    wrap_mystical_text "$content" | sed '1!s/^/      /'
    echo -e "${RESET}"
    
    echo
}

# Display responsive interactive menu/don't know why 2 pipes in each menu has to be on a space out.
# But it does, or it won't align properly on output, weird, but dont question it.
display_interactive_menu() {
    echo -e "${CYAN}${BOLD}"
    cat << 'EOF'
                           ╔══════════════════════════════════════════════════════════════════════╗
                           ║                         🔮 MYSTICAL MENU 🔮                          ║
                           ╠══════════════════════════════════════════════════════════════════════╣
                           ║  1. 🎭 Discover Your Developer Archetype                             ║
                           ║  2. 🔮 Ask the Bug Oracle a Question                                 ║
                           ║  3. 🌟 Get Your Daily Coding Prediction                              ║
                           ║  4. ⚡ Reveal Your Coding Element                                    ║
                           ║  5. 📜 Analyze Your Commit Message Patterns                          ║
                           ║  6. 🃏 Programming Tarot Card Reading                                ║
                           ║  7. 🔮 Oracle Wisdom Session                                         ║
                           ║  8. 👑 Find Your Celebrity Developer Twin                            ║
                           ║  9. 🔥 Roast My Code (Humorous Analysis)                             ║
                           ║ 10. 💝 Compliment My Journey                                         ║
                           ║ 11. 🏛️  Generate Full Horoscope                                       ║
                           ║ 12. 🏆 View Achievement Gallery                                      ║
                           ║ 13. 🚪 Exit the Mystical Realm                                       ║
                           ╚══════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    echo
}

# Display responsive oracle consultation menu  
display_oracle_menu() {
    echo -e "${MAGENTA}${BOLD}"
    cat << 'EOF'
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                      🔮 ORACLE CONSULTATION 🔮                       ║
    ╠══════════════════════════════════════════════════════════════════════╣
    ║  1. 🐛 Ask about debugging and problem-solving                       ║
    ║  2. 💼 Seek career and professional guidance                         ║
    ║  3. 📚 Learn about learning and skill development                    ║
    ║  4. 👥 Inquire about teamwork and collaboration                      ║
    ║  5. 🔥 Address burnout and work-life balance                         ║
    ║  6. 👤 Overcome imposter syndrome                                    ║
    ║  7. 🛠️  Get help choosing technologies                                ║
    ║  8. 🏛️  Deal with legacy code                                         ║
    ║  9. 🚀 Get guidance on side projects                                 ║
    ║ 10. 🌟 Learn about open source contribution                          ║
    ║ 11. 🥠 Receive quick wisdom (fortune cookie style)                   ║
    ║ 12. 🧘 Daily coding mantra for mindfulness                           ║
    ║ 13. 🔮 Ask a specific technical question                             ║
    ║ 14. 🎯 Get project-specific guidance                                 ║
    ║ 15. 🚪 Exit the Oracle's chamber                                     ║
    ╚══════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    echo
}



# Responsive fireworks animation that adapts to terminal width
animate_responsive_fireworks() {
    local terminal_width=$(get_terminal_width)
    local fireworks_content=""
    
    if [[ $terminal_width -lt 80 ]]; then
        # Compact fireworks for narrow terminals
        fireworks_content="        
  ✨ * ✨ * ✨ * ✨
✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
  * ✦ CELEBRATION! ✦ *
✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
  ✨ * ✨ * ✨ * ✨"
    elif [[ $terminal_width -lt 120 ]]; then
        # Standard fireworks
        fireworks_content="
  ✨   💫   ✨   💫   ✨   💫   ✨
✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
   * ✦ ✨ EPIC CELEBRATION! ✨ ✦ *
✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
  ✨   💫   ✨   💫   ✨   💫   ✨"
    else
        # Deluxe fireworks for wide terminals
        fireworks_content="        
    ✨   💫   ⭐   💫   ✨   💫   ⭐   💫   ✨
  ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
     * ✦ ✨ 🎉 LEGENDARY CELEBRATION! 🎉 ✨ ✦ *
  ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨ ･ﾟ✧*:･ﾟ✧ ✨
    ✨   💫   ⭐   💫   ✨   💫   ⭐   💫   ✨"
    fi
    
    echo -e "${YELLOW}${BOLD}"
    center_ascii_block "$fireworks_content"
    echo -e "${RESET}"
}

# Matrix code rain that respects terminal boundaries
animate_matrix_rain() {
    local duration="${1:-3}"
    local terminal_width=$(get_terminal_width)
    local terminal_height="${2:-10}"
    
    echo -e "${GREEN}${BOLD}"
    local matrix_patterns=(
        "01001000 01100101 01101100 01101100 01101111"
        "01010111 01101111 01110010 01101100 01100100"
        "01000011 01001111 01000100 01000101 01010010"
        "01001101 01000001 01000111 01001001 01000011"
        "░▒▓█ DECODING YOUR PATTERNS █▓▒░"
        "System.out.println(\"Hello World\");"
        "console.log('debugging reality...');"
        "import { success } from 'achievement';"
        "def unlock_potential(): return True"
    )
    
    # Create matrix rain effect that fits terminal width
    for ((i=0; i<terminal_height; i++)); do
        local line_content=""
        local patterns_per_line=$((terminal_width / 45))  # ~45 chars per pattern
        
        if [[ $patterns_per_line -lt 1 ]]; then
            patterns_per_line=1
        fi
        
        for ((j=0; j<patterns_per_line; j++)); do
            local pattern_index=$((RANDOM % ${#matrix_patterns[@]}))
            if [[ $j -eq 0 ]]; then
                line_content="${matrix_patterns[$pattern_index]}"
            else
                line_content="$line_content ${matrix_patterns[$pattern_index]}"
            fi
        done
        
        # Ensure line doesn't exceed terminal width
        if [[ ${#line_content} -gt $terminal_width ]]; then
            line_content="${line_content:0:$((terminal_width-3))}..."
        fi
        
        center_text "$line_content"
        sleep 0.2
    done
    echo -e "${RESET}"
}

# Enhanced crystal ball display with better sparkle centering
display_crystal_ball_enhanced() {
    local width=$(get_terminal_width)
    local sparkle_line="･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧"
    
    # Adjust sparkles based on terminal width
    if [[ $width -lt 80 ]]; then
        sparkle_line="･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧"
    elif [[ $width -gt 120 ]]; then
        sparkle_line="･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧ ✦ ･ﾟ✧*:･ﾟ✧"
    fi
    
    echo -e "${MAGENTA}"
    center_text "$sparkle_line"
    echo -e "${RESET}"
    
    # Call the responsive crystal ball display
    display_crystal_ball_responsive
}

# Beautiful archetype reveal display
display_archetype_reveal() {
    local archetype_name="$1"
    local archetype_description="$2"
    
    clear
    echo -e "${MAGENTA}${BOLD}"
    
    # Theatrical archetype announcement - aligned more to the left
    echo "                                        ✨ 🎭 ✨ 🎭 ✨"
    echo "                                🌟 The Ancient Codex Speaks 🌟"
    echo "                                        ✨ 🎭 ✨ 🎭 ✨"
    echo
    echo "                               🔮 Your True Coding Identity: 🔮"
    echo
    
    # Display the archetype name prominently - aligned more to the left
    echo -e "${YELLOW}${BOLD}"
    echo "                          🧙‍♂️ ═══════════════════════════════════ 🧙‍♂️"
    echo
    echo "                                    ✨ $archetype_name ✨"
    echo
    echo "                          🧙‍♂️ ═══════════════════════════════════ 🧙‍♂️"
    echo -e "${RESET}"
    echo
    
    # Display the description with mystical formatting
    echo -e "${CYAN}${BOLD}"
    display_mystical_section "🌟 Your Mystical Coding Essence"
    echo -e "${WHITE}"
    echo -n "    • 🎭 "
    wrap_mystical_text "$archetype_description" | sed '1!s/^/      /'
    echo -e "${RESET}"
    echo
    
    # Add some mystical sparkles - aligned to the left
    echo -e "${MAGENTA}"
    echo "                     ✨ ･ﾟ✧*:･ﾟ✧ ✦ The spirits have spoken ✦ ･ﾟ✧*:･ﾟ✧ ✨"
    echo -e "${RESET}"
    echo
}

# Mystical archetype analysis loading animation
display_archetype_loading() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    
    # Title
    echo "                     🎭 THE SPIRITS REVEAL YOUR DEVELOPER ARCHETYPE 🎭"
    echo
    
    # Ancient scroll animation - aligned to the left
    echo "                                    📜 ✨ 📜 ✨ 📜"
    echo "                             Consulting the Ancient Scrolls"
    echo "                                    📜 ✨ 📜 ✨ 📜"
    echo
    
    # Loading animation with mystical symbols - aligned to the left
    local mystical_symbols=("🔮" "🎭" "🧙‍♂️" "📜" "✨" "🌟" "💫" "🎪")
    echo -e "${CYAN}"
    
    for ((i=0; i<20; i++)); do
        local symbol_index=$((i % ${#mystical_symbols[@]}))
        echo -ne "\r                          ${mystical_symbols[$symbol_index]} Analyzing your coding soul... ${mystical_symbols[$symbol_index]}"
        sleep 0.2
    done
    
    echo -e "\n"
    echo -e "${GREEN}"
    echo "                    🌟 ✨ The ancient wisdom has been deciphered! ✨ 🌟"
    echo -e "${RESET}"
    sleep 1
}

# Bug Oracle awakening display
display_bug_oracle_awakening() {
    clear
    echo -e "${CYAN}${BOLD}"
    
    # Oracle awakening art
    echo "                                🔮 THE BUG ORACLE AWAKENS 🔮"
    echo
    echo "                                     ✨ 🐛 ✨ 🐛 ✨"
    echo "                              🌟 Ancient Debug Wisdom Stirs 🌟"
    echo "                                     ✨ 🐛 ✨ 🐛 ✨"
    echo
    echo "                              🔮 Speak Your Coding Troubles 🔮"
    echo
    echo -e "${MAGENTA}"
    echo "                      ✨ ･ﾟ✧*:･ﾟ✧ ✦ The Oracle Listens ✦ ･ﾟ✧*:･ﾟ✧ ✨"
    echo -e "${RESET}"
    echo
}

# Bug Oracle consultation loading
display_bug_oracle_loading() {
    local question="$1"
    
    clear
    echo -e "${CYAN}${BOLD}"
    
    # Show the question prominently/ size depends on question entered - aligned more to the right to "align small questions"
    echo "                                 🔮 YOUR CODING QUERY 🔮"
    echo
    echo "                                     💭 \"$question\""
    echo
    
    # Oracle consultation animation
    echo "                                    📚 ✨ 📚 ✨ 📚"
    echo "                          Consulting the Ethereal Bug Database"
    echo "                                    📚 ✨ 📚 ✨ 📚"
    echo 
    
    # Loading animation
    local oracle_symbols=("🔮" "🐛" "💻" "📚" "✨" "🌟" "⚡" "🔍")
    echo -e "${YELLOW}"
    
    for ((i=0; i<15; i++)); do
        local symbol_index=$((i % ${#oracle_symbols[@]}))
        echo -ne "\r                   ${oracle_symbols[$symbol_index]} The Oracle peers through the digital veil... ${oracle_symbols[$symbol_index]}"
        sleep 0.3
    done
    
    echo -e "\n"
    echo -e "${GREEN}"
    echo "                    🌟 ✨ The ancient debugging wisdom emerges! ✨ 🌟"
    echo -e "${RESET}"
    sleep 1
}

# Bug Oracle response display
display_bug_oracle_response() {
    local question="$1"
    local response="$2"
    
    clear
    echo -e "${MAGENTA}${BOLD}"
    
    # Oracle speaks header
    echo "                                         ✨ 🔮 ✨ 🔮 ✨"
    echo "                                   🌟 The Bug Oracle Speaks 🌟"
    echo "                                         ✨ 🔮 ✨ 🔮 ✨"
    echo
    echo "                                  🪄 Ancient Debugging Wisdom 🪄"
    echo
    
    # Display the mystical response
    echo -e "${YELLOW}${BOLD}"
    echo "                          🧙‍♂️ ═══════════════════════════════════ 🧙‍♂️"
    echo
    echo "                                    ✨ Oracle's Prophecy ✨"
    echo
    echo "                          🧙‍♂️ ═══════════════════════════════════ 🧙‍♂️"
    echo -e "${RESET}"
    echo
    
    # Display the response with mystical formatting
    echo -e "${CYAN}${BOLD}"
    echo "   🌟 The Sacred Debug Revelation"
    printf "   "
    for ((i=0; i<75; i++)); do
        printf "═"
    done
    echo
    echo
    echo -e "${WHITE}"
    echo -n "    • "
    echo "$response" | fold -s -w 75 | sed '1!s/^/      /'
    echo -e "${RESET}"
    echo
    
    # Mystical closing
    echo -e "${MAGENTA}"
    echo "             ✨ ･ﾟ✧*:･ﾟ✧ ✦ May your bugs be few and your fixes swift ✦ ･ﾟ✧*:･ﾟ✧ ✨"
    echo -e "${RESET}"
    echo
}

# Beautiful emoji-decorated titles like the archetype reveal
display_sparkle_title() {
    local title="$1"
    local emoji="${2:-✨}"
    local color="${3:-${CYAN}}"
    
    echo -e "${color}${BOLD}"
    
    # Create thematic decoration based on the emoji provided
    local decoration_line
    if [[ "$emoji" == "👤" ]]; then
        decoration_line="👤 🎭 👤 🎭 👤"  # Identity theme
    elif [[ "$emoji" == "🗣️" ]]; then
        decoration_line="💻 🗣️ 💻 🗣️ 💻"  # Language theme
    elif [[ "$emoji" == "🕐" ]]; then
        decoration_line="⏰ 🕐 ⏰ 🕐 ⏰"  # Time theme
    elif [[ "$emoji" == "✍️" ]]; then
        decoration_line="📝 ✍️ 📝 ✍️ 📝"  # Writing theme
    elif [[ "$emoji" == "📚" ]]; then
        decoration_line="📚 🏛️ 📚 🏛️ 📚"  # Repository theme
    elif [[ "$emoji" == "🌟" ]]; then
        decoration_line="⚖️ 🌟 ⚖️ 🌟 ⚖️"  # Karma theme
    elif [[ "$emoji" == "🌙" ]]; then
        decoration_line="🔮 🌙 🔮 🌙 🔮"  # Mystical theme
    elif [[ "$emoji" == "🔢" ]]; then
        decoration_line="🎰 🔢 🎰 🔢 🎰"  # Numbers theme
    elif [[ "$emoji" == "☯️" ]]; then
        decoration_line="🧘 ☯️ 🧘 ☯️ 🧘"  # Zen theme
    elif [[ "$emoji" == "�" ]]; then
        decoration_line="�🎭 🎪 🎭 🎪 🎭"  # Archetype theme
    elif [[ "$emoji" == "♈" ]]; then
        decoration_line="✨ ♈ ✨ ♈ ✨"  # Astrological theme
    elif [[ "$emoji" == "🔮" ]]; then
        decoration_line="📜 🔮 📜 🔮 📜"  # Mystique theme
    elif [[ "$emoji" == "�" ]]; then
        decoration_line="🔥 🌊 🔥 🌊 🔥"  # Elemental theme
    elif [[ "$emoji" == "🔬" ]]; then
        decoration_line="🧠 🔬 🧠 🔬 🧠"  # Analysis theme
    elif [[ "$emoji" == "⚡" ]]; then
        decoration_line="🔮 ⚡ 🔮 ⚡ 🔮"  # Prophecy theme
    elif [[ "$emoji" == "🌀" ]]; then
        decoration_line="⏰ 🌀 ⏰ 🌀 ⏰"  # Time magic theme
    else
        decoration_line="$emoji ✨ $emoji ✨ $emoji"  # Generic sparkle theme
    fi
    
    # Hardcoded centered spacing instead of center_text for perfect alignment
    if [[ "$emoji" == "👤" ]]; then
        echo "                                              👤 🎭 👤 🎭 👤"
        echo "                                    🌟 $title 🌟"
        echo "                                              👤 🎭 👤 🎭 👤"
    elif [[ "$emoji" == "🗣️" ]]; then
        echo "                                               💻 🗣️ 💻 🗣️ 💻"
        echo "                                     🌟 $title 🌟"
        echo "                                               💻 🗣️ 💻 🗣️ 💻"
    elif [[ "$emoji" == "🕐" ]]; then
        echo "                                              ⏰ 🕐 ⏰ 🕐 ⏰"
        echo "                                    🌟 $title 🌟"
        echo "                                              ⏰ 🕐 ⏰ 🕐 ⏰"
    elif [[ "$emoji" == "✍️" ]]; then
        echo "                                                📝 ✍️ 📝 ✍️ 📝"
        echo "                                    🌟 $title 🌟"
        echo "                                                📝 ✍️ 📝 ✍️ 📝"
    elif [[ "$emoji" == "📚" ]]; then
        echo "                                               📚 🏛️ 📚 🏛️ 📚"
        echo "                                    🌟 $title 🌟"
        echo "                                               📚 🏛️ 📚 🏛️ 📚"
    elif [[ "$emoji" == "🌟" ]]; then
        echo "                                                 ⚖️  🌟 ⚖️ 🌟 ⚖️"
        echo "                                      🌟 $title 🌟"
        echo "                                                 ⚖️  🌟 ⚖️ 🌟 ⚖️"
    elif [[ "$emoji" == "🌙" ]]; then
        echo "                                              🔮 🌙 🔮 🌙 🔮"
        echo "                                      🌟 $title 🌟"
        echo "                                              🔮 🌙 🔮 🌙 🔮"
    elif [[ "$emoji" == "🔢" ]]; then
        echo "                                                  🎰 🔢 🎰 🔢 🎰"
        echo "                                           🌟 $title 🌟"
        echo "                                                  🎰 🔢 🎰 🔢 🎰"
    elif [[ "$emoji" == "☯️" ]]; then
        echo "                                                 🧘 ☯️ 🧘 ☯️ 🧘"
        echo "                                     🌟 $title 🌟"
        echo "                                                 🧘 ☯️ 🧘 ☯️ 🧘"
    elif [[ "$emoji" == "🎪" ]]; then
        echo "                                                 🎭 🎪 🎭 🎪 🎭"
        echo "                                     🌟 $title 🌟"
        echo "                                                 🎭 🎪 🎭 🎪 🎭"
    elif [[ "$emoji" == "♈" ]]; then
        echo "                                                ✨ ♈ ✨ ♈ ✨"
        echo "                                   🌟 $title 🌟"
        echo "                                                ✨ ♈ ✨ ♈ ✨"
    elif [[ "$emoji" == "🔮" ]]; then
        echo "                                                📜 🔮 📜 🔮 📜"
        echo "                                      🌟 $title 🌟"
        echo "                                                📜 🔮 📜 🔮 📜"
    elif [[ "$emoji" == "🌊" ]]; then
        echo "                                                 🔥 🌊 🔥 🌊 🔥"
        echo "                                      🌟 $title 🌟"
        echo "                                                 🔥 🌊 🔥 🌊 🔥"
    elif [[ "$emoji" == "🔬" ]]; then
        echo "                                                🧠 🔬 🧠 🔬 🧠"
        echo "                                     🌟 $title 🌟"
        echo "                                                🧠 🔬 🧠 🔬 🧠"
    elif [[ "$emoji" == "⚡" ]]; then
        echo "                                                🔮 ⚡ 🔮 ⚡ 🔮"
        echo "                                    🌟 $title 🌟"
        echo "                                                🔮 ⚡ 🔮 ⚡ 🔮"
    elif [[ "$emoji" == "🌀" ]]; then
        echo "                                                ⏰ 🌀 ⏰ 🌀 ⏰"
        echo "                                    🌟 $title 🌟"
        echo "                                                ⏰ 🌀 ⏰ 🌀 ⏰"
    else
        echo "                                          $emoji ✨ $emoji ✨ $emoji"
        echo "                                   🌟 $title 🌟"
        echo "                                          $emoji ✨ $emoji ✨ $emoji"
    fi
    echo -e "${RESET}"
    echo
}

# Mystical section header with emoji decorations
display_mystical_header() {
    local title="$1"
    local subtitle="$2"
    local main_emoji="${3:-🔮}"
    local color="${4:-${MAGENTA}}"
    
    echo -e "${color}${BOLD}"
    
    # Create sparkle pattern around the title
    local decoration="✨ $main_emoji ✨ $main_emoji ✨"
    center_text "$decoration"
    center_text "$title"
    center_text "$decoration"
    
    # Add subtitle if provided
    if [[ -n "$subtitle" ]]; then
        echo
        center_text "$subtitle"
    fi
    
    echo -e "${RESET}"
    echo
}

# Replace the old display_section_header with sparkly version
display_section_header() {
    local title="$1"
    local icon="$2"
    
    # Use the icon as the decorative emoji, fallback to sparkles
    local decoration_emoji="${icon:-✨}"
    
    # Use sparkle title with thematic emojis
    display_sparkle_title "$title" "$decoration_emoji" "${CYAN}"
}

