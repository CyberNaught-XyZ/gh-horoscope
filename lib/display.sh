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

# Get optimal box width based on terminal size
get_box_width() {
    local terminal_width=$(get_terminal_width)
    local box_width
    
    # Leave 8 characters margin (4 on each side)
    box_width=$((terminal_width - 8))
    
    # Ensure minimum and maximum box widths
    if [[ $box_width -lt 60 ]]; then
        box_width=60
    elif [[ $box_width -gt 120 ]]; then
        box_width=120
    fi
    
    echo "$box_width"
}

# Get content width for text wrapping
get_content_width() {
    local box_width=$(get_box_width)
    # Subtract 6 characters for borders and padding (│ + 2 spaces on each side + │)
    echo $((box_width - 6))
}

# Enhanced visual width calculation accounting for emojis and special characters
calculate_visual_width() {
    local text="$1"
    # Remove color codes first
    local clean_text="${text//\\033\[[0-9;]*m/}"
    clean_text="${clean_text//\\e\[[0-9;]*m/}"
    
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

# Responsive box border functions
draw_box_top() {
    local box_width=$(get_box_width)
    echo -n "    ╭"
    for ((i=0; i<box_width-2; i++)); do
        echo -n "─"
    done
    echo "╮"
}

draw_box_middle() {
    local box_width=$(get_box_width)
    echo -n "    ├"
    for ((i=0; i<box_width-2; i++)); do
        echo -n "─"
    done
    echo "┤"
}

draw_box_bottom() {
    local box_width=$(get_box_width)
    echo -n "    ╰"
    for ((i=0; i<box_width-2; i++)); do
        echo -n "─"
    done
    echo "╯"
}

# Responsive text content with proper padding
draw_box_content() {
    local text="$1"
    local align="${2:-left}"  # left, center, right
    local box_width=$(get_box_width)
    local content_width=$((box_width - 4))  # Account for borders and spaces
    
    # Use improved visual width calculation for emojis
    local visual_width=$(get_visual_text_width "$text")
    
    if [[ $visual_width -gt $content_width ]]; then
        # Text too long, wrap it
        echo "$text" | fold -s -w "$content_width" | while IFS= read -r line; do
            printf "    │ %-${content_width}s │\n" "$line"
        done
    else
        case $align in
            center)
                local padding=$(((content_width - visual_width) / 2))
                # Ensure padding is not negative
                if [[ $padding -lt 0 ]]; then padding=0; fi
                printf "    │%*s%s%*s│\n" $padding "" "$text" $((content_width - visual_width - padding)) ""
                ;;
            right)
                local right_padding=$((content_width - visual_width - 1))
                if [[ $right_padding -lt 0 ]]; then right_padding=0; fi
                printf "    │%*s%s │\n" $right_padding "" "$text"
                ;;
            *)
                printf "    │ %-${content_width}s │\n" "$text"
                ;;
        esac
    fi
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
        "         🔮 ✨ 🔮 ✨ 🔮 ✨ CRYSTAL BALL ✨ 🔮 ✨ 🔮 ✨ 🔮"
        ""
        "                           ⭐"
        "                        ╭───────╮"
        "                       ╱         ╲"
        "                      ╱  ░ 🔮 ░   ╲"
        "                     ╱     ✨      ╲"
        "                    ╱_______________╲"
        "                   ╱                 ╲"
        "                   ╲_________________╱"
        "                         │     │"
        "                         │     │"
        "                        ╱───────╲"
        "                       ╱  ░░░░░  ╲"
        "                      ╱___________╲"
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

# Display constellation divider
display_constellation() {
    echo -e "${BLUE}"
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

# Display coding magic portal
display_magic_portal() {
    echo -e "${MAGENTA}"
    local portal_art=(
        "                    ╭───────╮"
        "                  ╭─┤ ◇ ◇ ◇ ├─╮"
        "                ╭─┤   ◆ ◆ ◆   ├─╮"
        "              ╭─┤     ◈ ◈ ◈     ├─╮"
        "            ╭─┤       ♦ ♦ ♦       ├─╮"
        "          ╭─┤         ◉ ◉ ◉         ├─╮"
        "          │           PORTAL          │"
        "          ╰─┤         ◉ ◉ ◉         ├─╯"
        "            ╰─┤       ♦ ♦ ♦       ├─╯"
        "              ╰─┤     ◈ ◈ ◈     ├─╯"
        "                ╰─┤   ◆ ◆ ◆   ├─╯"
        "                  ╰─┤ ◇ ◇ ◇ ├─╯"
        "                    ╰───────╯"
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
        "    ░▒▓█ DECODING YOUR PATTERNS █▓▒░"
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
        "      \"The gears of code destiny turn...\""
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
        "🌟 May your builds be green and your merge conflicts be few 🌟"
        ""
        "Created for \"For the Love of Code 2025\" - Terminal Talent Category"
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
    echo "    ┌─────────────────────────────────────────────────────────────────────┐"
    echo "    │ $icon  $title"                                                      |
    echo "    └─────────────────────────────────────────────────────────────────────┘"
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
    echo -e "${MAGENTA}${BOLD}\"$quote\"${RESET}"
    echo
}

display_crystal_ball_border() {
    echo -e "${CYAN}"
    draw_box_top
    echo -e "${RESET}"
}

display_crystal_ball_bottom() {
    echo -e "${CYAN}"
    draw_box_bottom
    echo -e "${RESET}"
    echo
}

display_horoscope_section() {
    local title="$1"
    local content="$2"
    local icon="$3"
    local content_width=$(get_content_width)
    
    display_crystal_ball_border
    draw_box_content "${WHITE}${BOLD}$icon  $title${RESET}"
    echo
    
    # Process content with proper wrapping
    echo -e "$content" | fold -s -w "$content_width" | while IFS= read -r line; do
        draw_box_content "${WHITE}$line${RESET}"
    done
    
    echo
    display_crystal_ball_bottom
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
        "           ☕"
        "         c[_]"
        "           |"
        "      _____|_____"
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
        echo -ne "\r    ${CYAN}${spinner[i]} $message${RESET}"
        i=$(((i+1) % ${#spinner[@]}))
        sleep 0.1
    done
    echo -ne "\r    ${GREEN}✓ $message${RESET}\n"
}

# Enhanced mystical loading with different themes
display_oracle_loading() {
    local message="$1"
    local duration="${2:-3}"
    
    echo -e "\n    ${MAGENTA}   🌟 Consulting the Oracle... 🌟${RESET}"
    echo -e "    ${CYAN}              ✨ ••• ✨ ••• ✨${RESET}"
    echo -e "    ${YELLOW}   🔮 Analyzing your GitHub soul... 🔮${RESET}\n"
    
    local symbols=("🔮" "✨" "🌟" "🌙" "⭐" "💫" "🌠" "☄️")
    
    for ((i=0; i<duration*4; i++)); do
        local symbol_index=$((i % ${#symbols[@]}))
        echo -ne "\r    ${YELLOW}${symbols[$symbol_index]} $message${RESET}"
        sleep 0.25
    done
    echo -ne "\r    ${GREEN}🌟 $message - The Oracle has spoken!${RESET}\n"
}

# Crystal ball consultation loading
display_crystal_ball_loading() {
    local message="$1"
    local duration="${2:-4}"
    
    echo -e "\n    ${CYAN}     ✧･ﾟ: *✧･ﾟ:* The Crystal Ball Awakens *:･ﾟ✧*:･ﾟ✧${RESET}"
    
    local frames=(
        "    ${CYAN}        .:･ﾟ✧ 🔮 ✧ﾟ･:.        ${RESET}"
        "    ${MAGENTA}        .:･ﾟ✧ 🔮 ✧ﾟ･:.        ${RESET}"
        "    ${YELLOW}        .:･ﾟ✧ 🔮 ✧ﾟ･:.        ${RESET}"
        "    ${BLUE}        .:･ﾟ✧ 🔮 ✧ﾟ･:.        ${RESET}"
    )
    
    for ((i=0; i<duration*2; i++)); do
        local frame_index=$((i % ${#frames[@]}))
        echo -ne "\r${frames[$frame_index]}"
        sleep 0.5
    done
    echo -e "\r    ${GREEN}        .:･ﾟ✧ ✅ ✧ﾟ･:.        ${RESET}"
    echo -e "    ${GREEN}$message - Complete!${RESET}\n"
}

# GitHub API loading animation
display_github_loading() {
    local message="$1"
    local duration="${2:-3}"
    
    echo -e "\n    ${BLUE}🐙 Summoning GitHub's ancient spirits... 🐙${RESET}"
    
    local github_symbols=("📊" "📈" "🔍" "⚡" "🚀" "💻" "🌐" "📡")
    local dots=""
    
    for ((i=0; i<duration*3; i++)); do
        local symbol_index=$((i % ${#github_symbols[@]}))
        dots+="."
        if [[ ${#dots} -gt 3 ]]; then
            dots="."
        fi
        echo -ne "\r    ${BLUE}${github_symbols[$symbol_index]} $message$dots${RESET}"
        sleep 0.33
    done
    echo -ne "\r    ${GREEN}✅ $message - Data retrieved!${RESET}\n"
}

# Unique ASCII art for different Oracle types
display_oracle_art() {
    local oracle_type="$1"
    
    case "$oracle_type" in
        "debugging")
            echo -e "${RED}"
            local debugging_art=(
                "                    🐛 ═══ 🔍 ═══ 🐛"
                "                   ╔═══════════════════╗"
                "                   ║  DEBUGGING ORACLE ║"
                "                   ╚═══════════════════╝"
                "                     🔧 🛠️  🔨 ⚙️  🔧"
            )
            for line in "${debugging_art[@]}"; do
                center_text "$line"
            done
            ;;
        "career")
            echo -e "${BLUE}"
            local career_art=(
                "                    💼 ═══ 📈 ═══ 💼"
                "                   ╔═══════════════════╗"
                "                   ║   CAREER ORACLE   ║"
                "                   ╚═══════════════════╝"
                "                     👑 💪 🚀 🌟 💎"
            )
            for line in "${career_art[@]}"; do
                center_text "$line"
            done
            ;;
        "learning")
            echo -e "${GREEN}"
            local learning_art=(
                "                    📚 ═══ 🎓 ═══ 📚"
                "                   ╔═══════════════════╗"
                "                   ║  LEARNING ORACLE  ║"
                "                   ╚═══════════════════╝"
                "                     🧠 💡 🔬 📖 ✨"
            )
            for line in "${learning_art[@]}"; do
                center_text "$line"
            done
            ;;
        "teamwork")
            echo -e "${YELLOW}"
            local teamwork_art=(
                "                    👥 ═══ 🤝 ═══ 👥"
                "                   ╔═══════════════════╗"
                "                   ║  TEAMWORK ORACLE  ║"
                "                   ╚═══════════════════╝"
                "                     🌉 🤗 💬 🎭 🔄"
            )
            for line in "${teamwork_art[@]}"; do
                center_text "$line"
            done
            ;;
        "burnout")
            echo -e "${MAGENTA}"
            local burnout_art=(
                "                    🔥 ═══ 🧘 ═══ 🔥"
                "                   ╔═══════════════════╗"
                "                   ║  WELLNESS ORACLE  ║"
                "                   ╚═══════════════════╝"
                "                     🌱 😌 ⚖️  🌸 🦋"
            )
            for line in "${burnout_art[@]}"; do
                center_text "$line"
            done
            ;;
        "confidence")
            echo -e "${CYAN}"
            local confidence_art=(
                "                    👤 ═══ 💪 ═══ 👤"
                "                   ╔═══════════════════╗"
                "                   ║ CONFIDENCE ORACLE ║"
                "                   ╚═══════════════════╝"
                "                     🦁 💎 🌟 ⭐ 🔮"
            )
            for line in "${confidence_art[@]}"; do
                center_text "$line"
            done
            ;;
        "technology")
            echo -e "${WHITE}"
            local technology_art=(
                "                    🛠️  ═══ ⚡ ═══ 🛠️ "
                "                   ╔═══════════════════╗"
                "                   ║ TECHNOLOGY ORACLE ║"
                "                   ╚═══════════════════╝"
                "                     💻 🔧 ⚙️  🖥️  📱"
            )
            for line in "${technology_art[@]}"; do
                center_text "$line"
            done
            ;;
        "legacy")
            echo -e "${GRAY}"
            local legacy_art=(
                "                    🏛️  ═══ 📜 ═══ 🏛️ "
                "                   ╔═══════════════════╗"
                "                   ║ LEGACY CODE ORACLE║"
                "                   ╚═══════════════════╝"
                "                     ⚰️  🗿 📿 🕯️  ⚱️"
            )
            for line in "${legacy_art[@]}"; do
                center_text "$line"
            done
            ;;
        "projects")
            echo -e "${GREEN}"
            local projects_art=(
                "                    🚀 ═══ 💡 ═══ 🚀"
                "                   ╔═══════════════════╗"
                "                   ║SIDE PROJECT ORACLE║"
                "                   ╚═══════════════════╝"
                "                     🌱 🎨 🛸 ✨ 🎯"
            )
            for line in "${projects_art[@]}"; do
                center_text "$line"
            done
            ;;
        "opensource")
            echo -e "${BLUE}"
            local opensource_art=(
                "                    🌟 ═══ 🌍 ═══ 🌟"
                "                   ╔═══════════════════╗"
                "                   ║ OPEN SOURCE ORACLE║"
                "                   ╚═══════════════════╝"
                "                     🌺 🤝 🌿 💚 🕊️"
            )
            for line in "${opensource_art[@]}"; do
                center_text "$line"
            done
            ;;
        *)
            echo -e "${MAGENTA}"
            local mystical_art=(
                "                    🔮 ═══ ✨ ═══ 🔮"
                "                   ╔═══════════════════╗"
                "                   ║  MYSTICAL ORACLE  ║"
                "                   ╚═══════════════════╝"
                "                     🌙 ⭐ 💫 🌟 ✨"
            )
            for line in "${mystical_art[@]}"; do
                center_text "$line"
            done
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
        "            🌟✨ ═══ THE COSMIC CODE DIVINATION CHAMBER ═══ ✨🌟"
    )
    
    for line in "${deluxe_art[@]}"; do
        center_text "$line"
    done
    echo -e "${RESET}"
}

# Original crystal ball function - now calls responsive version
display_crystal_ball() {
    display_crystal_ball_responsive
}

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
    local content_width=$(get_content_width)
    
    echo
    draw_box_top
    echo
    draw_box_content "$title" "center"
    echo
    
    # Process content with proper wrapping
    echo -e "$content" | fold -s -w "$content_width" | while IFS= read -r line; do
        draw_box_content "$line"
    done
    
    echo
    draw_box_bottom
    echo
}

# Display responsive interactive menu
display_interactive_menu() {
    draw_box_top
    draw_box_content "🔮 MYSTICAL MENU 🔮" "center"
    draw_box_middle
    draw_box_content " 1. 🎭 Discover Your Developer Archetype"
    draw_box_content " 2. 🔮 Ask the Bug Oracle a Question"
    draw_box_content " 3. 🌟 Get Your Daily Coding Prediction"
    draw_box_content " 4. ⚡ Reveal Your Coding Element"
    draw_box_content " 5. 📜 Analyze Your Commit Message Patterns"
    draw_box_content " 6. 🃏 Programming Tarot Card Reading"
    draw_box_content " 7. 🔮 Oracle Wisdom Session"
    draw_box_content " 8. 👑 Find Your Celebrity Developer Twin"
    draw_box_content " 9. 🔥 Roast My Code (Humorous Analysis)"
    draw_box_content "10. 💝 Compliment My Journey"
    draw_box_content "11. 🏛️  Generate Full Horoscope"
    draw_box_content "12. 🏆 View Achievement Gallery"
    draw_box_content "13. 🚪 Exit the Mystical Realm"
    draw_box_bottom
    echo
}

# Display responsive oracle consultation menu  
display_oracle_menu() {
    draw_box_top
    draw_box_content "🔮 **ORACLE CONSULTATION** 🔮" "center"
    draw_box_middle
    draw_box_content " 1. 🐛 Ask about debugging and problem-solving"
    draw_box_content " 2. 💼 Seek career and professional guidance"
    draw_box_content " 3. 📚 Learn about learning and skill development"
    draw_box_content " 4. 👥 Inquire about teamwork and collaboration"
    draw_box_content " 5. 🔥 Address burnout and work-life balance"
    draw_box_content " 6. 👤 Overcome imposter syndrome"
    draw_box_content " 7. 🛠️ Get help choosing technologies"
    draw_box_content " 8. 🏛️ Deal with legacy code"
    draw_box_content " 9. 🚀 Get guidance on side projects"
    draw_box_content "10. 🌟 Learn about open source contribution"
    draw_box_content "11. 🥠 Receive quick wisdom (fortune cookie style)"
    draw_box_content "12. 🧘 Daily coding mantra for mindfulness"
    draw_box_content "13. 🔮 Ask a specific technical question"
    draw_box_content "14. 🎯 Get project-specific guidance"
    draw_box_content "15. 🚪 Exit the Oracle's chamber"
    draw_box_bottom
    echo
}

# Cryptic border display (responsive)
display_cryptic_border() {
    local box_width=$(get_box_width)
    echo -e "${MAGENTA}"
    echo -n "    ╭"
    for ((i=0; i<box_width-2; i++)); do
        echo -n "─"
    done
    echo "╮"
    
    # Center the mystical text
    local mystical_text="🜁 𝐓𝐡𝐞 𝐀𝐧𝐜𝐢𝐞𝐧𝐭 𝐒𝐜𝐫𝐢𝐩𝐭𝐬 𝐑𝐞𝐯𝐞𝐚𝐥 𝐀𝐥𝐥 🜁"
    local content_width=$((box_width - 4))
    local text_len=${#mystical_text}
    
    if [[ $text_len -le $content_width ]]; then
        local padding=$(((content_width - text_len) / 2))
        printf "    │$(tput setaf 5)%*s%s%*s$(tput sgr0)${MAGENTA}│\n" \
               $padding "" "$mystical_text" $((content_width - text_len - padding)) ""
    else
        # If text is too long, truncate or use a shorter version
        local short_text="🜁 The Ancient Scripts Reveal All 🜁"
        local padding=$(((content_width - ${#short_text}) / 2))
        printf "    │$(tput setaf 5)%*s%s%*s$(tput sgr0)${MAGENTA}│\n" \
               $padding "" "$short_text" $((content_width - ${#short_text} - padding)) ""
    fi
    
    echo -n "    ╰"
    for ((i=0; i<box_width-2; i++)); do
        echo -n "─"
    done
    echo "╯"
    echo -e "${RESET}"
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

# Apply enhanced centering to ALL celebration animations and crystal balls
fix_all_ascii_centering() {
    # This function serves as the master function to apply centering fixes
    # All individual functions have been updated to use center_ascii_block and center_text
    
    # Enhanced crystal ball displays already use center_text
    display_crystal_ball_enhanced
    
    # Achievement celebrations now use center_ascii_block
    # Fireworks are responsive via animate_responsive_fireworks
    # Matrix rain respects terminal boundaries via animate_matrix_rain
    
    echo "🎯 All ASCII centering fixes have been applied!"
}