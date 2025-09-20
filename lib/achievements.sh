#!/bin/bash

# Achievement System for GitHub CLI Horoscope Extension
# Tracks and celebrates developer progress through mystical achievements

# Wrap text for better terminal display
wrap_achievement_text() {
    local text="$1"
    local indent="    • "
    local width=75  # Leave some margin for terminal edges
    
    # Use fold to wrap text at word boundaries, then add proper indentation
    echo "$text" | fold -w $((width - ${#indent})) -s | while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            echo "$indent$line"
            indent="      "  # Continuation lines get extra indent
        fi
    done
    echo
}

# Achievement data directory
ACHIEVEMENT_DIR="${HOME}/.github-horoscope"
ACHIEVEMENT_FILE="$ACHIEVEMENT_DIR/achievements.json"
STATS_FILE="$ACHIEVEMENT_DIR/stats.json"

# Initialize achievement system
init_achievement_system() {
    if [[ ! -d "$ACHIEVEMENT_DIR" ]]; then
        mkdir -p "$ACHIEVEMENT_DIR"
    fi
    
    if [[ ! -f "$ACHIEVEMENT_FILE" ]]; then
        echo '{"unlocked": [], "progress": {}}' > "$ACHIEVEMENT_FILE"
    fi
    
    if [[ ! -f "$STATS_FILE" ]]; then
        echo '{"total_uses": 0, "first_use": "", "consecutive_days": 0, "last_use": "", "roast_count": 0, "oracle_questions": 0, "tarot_draws": 0, "celebrity_comparisons": 0, "interactive_sessions": 0}' > "$STATS_FILE"
    fi
}

# Achievement definitions (50+ achievements as requested)
declare -A ACHIEVEMENTS

# Basic Exploration
ACHIEVEMENTS["first_steps"]=" 🔮 First Steps - Complete first horoscope reading"
ACHIEVEMENTS["identity_crisis"]=" 🎭 Identity Crisis - Discover your developer archetype"
ACHIEVEMENTS["card_sharp"]=" 🃏 Card Sharp - Draw your first tarot card"
ACHIEVEMENTS["celebrity_crush"]=" 👑 Celebrity Crush - Compare with first celebrity"

# Usage Milestones
ACHIEVEMENTS["roast_rookie"]=" 🔥 Roast Rookie - Survive your first roast (1)"
ACHIEVEMENTS["coffee_bean"]=" ☕ Coffee Bean - Get roasted 10 times"
ACHIEVEMENTS["chili_master"]=" 🌶️ Chili Master - Get roasted 25 times"
ACHIEVEMENTS["flame_lord"]=" 🔥 Flame Lord - Get roasted 50 times"

# Oracle Wisdom
ACHIEVEMENTS["oracle_apprentice"]=" 🧙‍♂️ Oracle Apprentice - Ask Oracle 1 question"
ACHIEVEMENTS["crystal_gazer"]=" 🔮 Crystal Gazer - Ask Oracle 10 questions"
ACHIEVEMENTS["all_seeing_eye"]=" 👁️ All-Seeing Eye - Ask Oracle 25 questions"
ACHIEVEMENTS["oracle_master"]=" 🌟 Oracle Master - Ask Oracle 50 questions"

# Tarot Mastery
ACHIEVEMENTS["card_collector"]=" 🃏 Card Collector - Draw 10 cards"
ACHIEVEMENTS["deck_master"]=" 🎴 Deck Master - Draw 50 cards"
ACHIEVEMENTS["fortune_teller"]=" 🔮 Fortune Teller - Draw 100 cards"
ACHIEVEMENTS["tarot_royalty"]=" 👑 Tarot Royalty - Draw all 78 unique cards"

# Celebrity Comparisons
ACHIEVEMENTS["starstruck"]=" ⭐ Starstruck - Compare with 5 celebrities"
ACHIEVEMENTS["hollywood_hacker"]=" 🎬 Hollywood Hacker - Compare with 20 celebrities"
ACHIEVEMENTS["celebrity_collector"]=" 👑 Celebrity Collector - Compare with all available celebrities"

# Time-Based Achievements
ACHIEVEMENTS["night_owl"]=" 🌙 Night Owl - Use horoscope between 2-4AM"
ACHIEVEMENTS["early_bird"]=" ☀️ Early Bird - Use horoscope between 5-7AM"
ACHIEVEMENTS["halloween_hacker"]=" 🎃 Halloween Hacker - Use on October 31st"
ACHIEVEMENTS["christmas_coder"]=" 🎄 Christmas Coder - Use on December 25th"
ACHIEVEMENTS["new_year_ninja"]=" 🎊 New Year Ninja - Use on January 1st"
ACHIEVEMENTS["valentine_virtuoso"]=" 💘 Valentine Virtuoso - Use on February 14th"
ACHIEVEMENTS["lucky_leprechaun"]=" ☘️ Lucky Leprechaun - Use on March 17th"

# Usage Patterns
ACHIEVEMENTS["daily_devotee"]=" 📅 Daily Devotee - Use 7 days in a row"
ACHIEVEMENTS["weekly_warrior"]=" 🗓️ Weekly Warrior - Use 30 days in a row"
ACHIEVEMENTS["monthly_master"]=" 📆 Monthly Master - Use 100 days total"
ACHIEVEMENTS["legendary_legend"]=" 🏆 Legendary Legend - Use 365 days total"

# Feature Discovery
ACHIEVEMENTS["interactive_explorer"]=" 🎪 Interactive Explorer - Use interactive mode"
ACHIEVEMENTS["combo_master"]=" 🎯 Combo Master - Use command combinations (-ort, -cra)"
ACHIEVEMENTS["power_user"]=" 🔧 Power User - Use all single-letter flags in one session"

# Hidden Secrets
ACHIEVEMENTS["konami_code"]=" 🕹️ Konami Code - Enter secret developer sequence"
ACHIEVEMENTS["easter_egg_hunter"]=" 🎮 Easter Egg Hunter - Discover 5 easter eggs"
ACHIEVEMENTS["secret_seeker"]=" 🔍 Secret Seeker - Find 10 hidden features"
ACHIEVEMENTS["ghost_in_shell"]=" 👻 Ghost in Shell - Find ultra-secret developer mode"

# Social Features
ACHIEVEMENTS["doppelganger_detector"]=" 👯 Doppelganger Detector - Find your GitHub twin"
ACHIEVEMENTS["friend_maker"]=" 🤝 Friend Maker - Match with 10 similar users"
ACHIEVEMENTS["global_connector"]=" 🌍 Global Connector - Match with users from 5 countries"

# Advanced Analytics
ACHIEVEMENTS["pattern_analyst"]=" 🔬 Pattern Analyst - Unlock all developer archetypes"
ACHIEVEMENTS["mind_reader"]=" 🧠 Mind Reader - Get accurate personality analysis"
ACHIEVEMENTS["bullseye"]=" 🎯 Bullseye - Get 90%+ accuracy prediction"

# Seasonal Celebrations
ACHIEVEMENTS["autumn_analyzer"]=" 🍂 Autumn Analyzer - Use during October-November"
ACHIEVEMENTS["winter_wizard"]=" ❄️ Winter Wizard - Use during December-February"
ACHIEVEMENTS["spring_sprinter"]=" 🌸 Spring Sprinter - Use during March-May"
ACHIEVEMENTS["summer_sage"]=" ☀️ Summer Sage - Use during June-August"

# Language Mastery
ACHIEVEMENTS["polyglot"]=" 💻 Polyglot - Have 5+ primary languages"
ACHIEVEMENTS["python_charmer"]=" 🐍 Python Charmer - Python as primary language"
ACHIEVEMENTS["java_junkie"]=" ☕ Java Junkie - Java as primary language"
ACHIEVEMENTS["javascript_jedi"]=" ⚡ JavaScript Jedi - JavaScript as primary language"
ACHIEVEMENTS["rust_ranger"]=" 🦀 Rust Ranger - Rust as primary language"
ACHIEVEMENTS["go_gopher"]=" 🐹 Go Gopher - Go as primary language"

# Update user statistics
update_stats() {
    local stat_key="$1"
    local increment="${2:-1}"
    local current_date=$(date '+%Y-%m-%d')
    
    init_achievement_system
    
    # Read current stats or create default
    local current_value=0
    if [[ -f "$STATS_FILE" ]]; then
        # Extract current value using grep and sed (bash-compatible JSON parsing)
        current_value=$(grep -o "\"$stat_key\": [0-9]*" "$STATS_FILE" | sed 's/.*: //' || echo "0")
    fi
    
    # Increment the value
    local new_value=$((current_value + increment))
    
    # Update the stats file
    if [[ -f "$STATS_FILE" ]]; then
        # Replace the existing value
        sed -i "s/\"$stat_key\": [0-9]*/\"$stat_key\": $new_value/" "$STATS_FILE"
    else
        # Create new stats file
        cat > "$STATS_FILE" << EOF
{"total_uses": 0, "first_use": "$current_date", "consecutive_days": 1, "last_use": "$current_date", "roast_count": 0, "oracle_questions": 0, "tarot_draws": 0, "celebrity_comparisons": 0, "interactive_sessions": 0}
EOF
        # Set the specific stat
        sed -i "s/\"$stat_key\": [0-9]*/\"$stat_key\": $new_value/" "$STATS_FILE"
    fi
    
    # Update last_use date
    sed -i "s/\"last_use\": \"[^\"]*\"/\"last_use\": \"$current_date\"/" "$STATS_FILE"
    
    # Show the update (only show actual incremented values)
    if [[ $new_value -gt 0 ]]; then
        echo -e "${WHITE}Stats updated: $stat_key = $new_value (was $current_value)${RESET}" >&2
    fi
}

# Check if achievement should be unlocked
check_achievement() {
    local achievement_id="$1"
    
    # Read current stats for checking milestones
    local stats_file="$ACHIEVEMENT_DIR/stats.json"
    local current_hour=$(date +%H)
    local current_date=$(date +%m-%d)
    local current_month=$(date +%m)
    
    case "$achievement_id" in
        "first_steps")
            # Always unlock on first use
            unlock_achievement "$achievement_id"
            ;;
        "interactive_explorer")
            unlock_achievement "$achievement_id"
            ;;
        "roast_rookie")
            unlock_achievement "$achievement_id"
            ;;
        "oracle_apprentice")
            unlock_achievement "$achievement_id"
            ;;
        "card_sharp")
            unlock_achievement "$achievement_id"
            ;;
        "celebrity_crush")
            unlock_achievement "$achievement_id"
            ;;
        "identity_crisis")
            unlock_achievement "$achievement_id"
            ;;
        *)
            # Complex achievements that check stats
            check_milestone_achievements "$achievement_id"
            check_time_achievements "$achievement_id" "$current_hour" "$current_date" "$current_month"
            ;;
    esac
}

# Check milestone-based achievements
check_milestone_achievements() {
    local achievement_id="$1"
    local stats_file="$ACHIEVEMENT_DIR/stats.json"
    
    if [[ ! -f "$stats_file" ]]; then
        return
    fi
    
    # Extract various stats
    local roast_count=$(grep -o '"roast_count": [0-9]*' "$stats_file" | sed 's/.*: //' || echo "0")
    local oracle_questions=$(grep -o '"oracle_questions": [0-9]*' "$stats_file" | sed 's/.*: //' || echo "0")
    local tarot_draws=$(grep -o '"tarot_draws": [0-9]*' "$stats_file" | sed 's/.*: //' || echo "0")
    local celebrity_comparisons=$(grep -o '"celebrity_comparisons": [0-9]*' "$stats_file" | sed 's/.*: //' || echo "0")
    local total_uses=$(grep -o '"total_uses": [0-9]*' "$stats_file" | sed 's/.*: //' || echo "0")
    
    case "$achievement_id" in
        "coffee_bean")
            [[ $roast_count -ge 10 ]] && unlock_achievement "$achievement_id"
            ;;
        "chili_master")
            [[ $roast_count -ge 25 ]] && unlock_achievement "$achievement_id"
            ;;
        "flame_lord")
            [[ $roast_count -ge 50 ]] && unlock_achievement "$achievement_id"
            ;;
        "crystal_gazer")
            [[ $oracle_questions -ge 10 ]] && unlock_achievement "$achievement_id"
            ;;
        "all_seeing_eye")
            [[ $oracle_questions -ge 25 ]] && unlock_achievement "$achievement_id"
            ;;
        "oracle_master")
            [[ $oracle_questions -ge 50 ]] && unlock_achievement "$achievement_id"
            ;;
        "card_collector")
            [[ $tarot_draws -ge 10 ]] && unlock_achievement "$achievement_id"
            ;;
        "deck_master")
            [[ $tarot_draws -ge 50 ]] && unlock_achievement "$achievement_id"
            ;;
        "fortune_teller")
            [[ $tarot_draws -ge 100 ]] && unlock_achievement "$achievement_id"
            ;;
        "starstruck")
            [[ $celebrity_comparisons -ge 5 ]] && unlock_achievement "$achievement_id"
            ;;
        "hollywood_hacker")
            [[ $celebrity_comparisons -ge 20 ]] && unlock_achievement "$achievement_id"
            ;;
        "monthly_master")
            [[ $total_uses -ge 100 ]] && unlock_achievement "$achievement_id"
            ;;
        "legendary_legend")
            [[ $total_uses -ge 365 ]] && unlock_achievement "$achievement_id"
            ;;
    esac
}

# Check time-based achievements  
check_time_achievements() {
    local achievement_id="$1"
    local current_hour="$2"
    local current_date="$3"
    local current_month="$4"
    
    # Remove leading zeros to avoid octal interpretation
    current_hour=${current_hour#0}
    current_month=${current_month#0}
    
    case "$achievement_id" in
        "night_owl")
            # 2-4AM (02-04 in 24hr format)
            [[ $current_hour -ge 2 && $current_hour -le 4 ]] && unlock_achievement "$achievement_id"
            ;;
        "early_bird")
            # 5-7AM
            [[ $current_hour -ge 5 && $current_hour -le 7 ]] && unlock_achievement "$achievement_id"
            ;;
        "halloween_hacker")
            [[ "$current_date" == "10-31" ]] && unlock_achievement "$achievement_id"
            ;;
        "christmas_coder")
            [[ "$current_date" == "12-25" ]] && unlock_achievement "$achievement_id"
            ;;
        "new_year_ninja")
            [[ "$current_date" == "01-01" ]] && unlock_achievement "$achievement_id"
            ;;
        "valentine_virtuoso")
            [[ "$current_date" == "02-14" ]] && unlock_achievement "$achievement_id"
            ;;
        "lucky_leprechaun")
            [[ "$current_date" == "03-17" ]] && unlock_achievement "$achievement_id"
            ;;
        "autumn_analyzer")
            # September (9), October (10), November (11) 
            [[ $current_month -eq 9 || $current_month -eq 10 || $current_month -eq 11 ]] && unlock_achievement "$achievement_id"
            ;;
        "winter_wizard")
            [[ $current_month -eq 12 || $current_month -eq 1 || $current_month -eq 2 ]] && unlock_achievement "$achievement_id"
            ;;
        "spring_sprinter")
            [[ $current_month -ge 3 && $current_month -le 5 ]] && unlock_achievement "$achievement_id"
            ;;
        "summer_sage")
            [[ $current_month -ge 6 && $current_month -le 8 ]] && unlock_achievement "$achievement_id"
            ;;
    esac
}

# Unlock an achievement
unlock_achievement() {
    local achievement_id="$1"
    
    init_achievement_system
    
    # Check if already unlocked - first check the log file
    if [[ -f "$ACHIEVEMENT_DIR/unlocked.log" ]] && grep -q "^$achievement_id$" "$ACHIEVEMENT_DIR/unlocked.log" 2>/dev/null; then
        return 0  # Already unlocked, don't show celebration again
    fi
    
    # Add to unlocked achievements
    display_achievement_celebration "$achievement_id"
    
    # Mark as unlocked (save just the achievement ID for easier checking)
    echo "$achievement_id" >> "$ACHIEVEMENT_DIR/unlocked.log"
}

# Display achievement celebration animation with enhanced centering
display_achievement_celebration() {
    local achievement_id="$1"
    local achievement_text="${ACHIEVEMENTS[$achievement_id]}"
    
    # Create dramatic celebration header based on achievement type
    local celebration_header=""
    local header_color=""
    
    # Determine achievement category and create themed header
    if [[ "$achievement_id" == *"roast"* || "$achievement_id" == *"flame"* || "$achievement_id" == *"chili"* || "$achievement_id" == *"coffee"* ]]; then
        header_color="${RED}${BOLD}"
        celebration_header="
        🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥
        💀 🌶️ 🔥 🌶️ 🔥 ROAST ACHIEVEMENT UNLOCKED! 🔥 🌶️ 🔥 🌶️ 💀
        🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥💀🔥"
    elif [[ "$achievement_id" == *"oracle"* || "$achievement_id" == *"crystal"* || "$achievement_id" == *"seeing"* ]]; then
        header_color="${CYAN}${BOLD}"
        celebration_header="
                               👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮
                               🔮   ✨ 👁️ ✨ 🔮 ORACLE ACHIEVEMENT UNLOCKED! 🔮 ✨ 👁️ ✨   🔮
                               👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮👁️ 🔮"
    elif [[ "$achievement_id" == *"tarot"* || "$achievement_id" == *"card"* || "$achievement_id" == *"deck"* || "$achievement_id" == *"fortune"* ]]; then
        header_color="${MAGENTA}${BOLD}"
        celebration_header="
    🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴
    🎴   ✨ 🃏 ✨ 🔮 TAROT ACHIEVEMENT UNLOCKED! 🔮 ✨ 🃏 ✨  🎴
    🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴🃏🎴"
    elif [[ "$achievement_id" == *"celebrity"* || "$achievement_id" == *"crush"* || "$achievement_id" == *"hollywood"* || "$achievement_id" == *"starstruck"* ]]; then
        header_color="${MAGENTA}${BOLD}"
        celebration_header="

    👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑
    ⭐ 🌟 👑 🌟 ✨ CELEBRITY ACHIEVEMENT UNLOCKED! ✨ 🌟 👑 🌟 ⭐
    👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑⭐👑"
    elif [[ "$achievement_id" == *"night"* || "$achievement_id" == *"early"* || "$achievement_id" == *"halloween"* || "$achievement_id" == *"christmas"* || "$achievement_id" == *"valentine"* || "$achievement_id" == *"leprechaun"* || "$achievement_id" == *"autumn"* || "$achievement_id" == *"winter"* || "$achievement_id" == *"spring"* || "$achievement_id" == *"summer"* ]]; then
        header_color="${BLUE}${BOLD}"
        celebration_header="
    ⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐
    🕐   ✨ ⏰ ✨ 🌟 TIME ACHIEVEMENT UNLOCKED! 🌟 ✨ ⏰ ✨   🕐
    ⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐⏰🕐"
    elif [[ "$achievement_id" == *"python"* || "$achievement_id" == *"java"* || "$achievement_id" == *"javascript"* || "$achievement_id" == *"rust"* || "$achievement_id" == *"go_gopher"* || "$achievement_id" == *"polyglot"* ]]; then
        header_color="${CYAN}${BOLD}"
        celebration_header="
    💻🐍💻☕💻⚡💻🦀💻🐹💻🔤💻🐍💻☕💻⚡💻🦀💻🐹💻🔤💻🐍💻☕💻⚡💻🦀💻    
    🔤   🌟 💻 🌟 ⚡ LANGUAGE ACHIEVEMENT UNLOCKED! ⚡ 🌟 💻 🌟   🔤
    💻🐍💻☕💻⚡💻🦀💻🐹💻🔤💻🐍💻☕💻⚡💻🦀💻🐹💻🔤💻🐍💻☕💻⚡💻🦀💻"
    elif [[ "$achievement_id" == *"konami"* || "$achievement_id" == *"easter"* || "$achievement_id" == *"secret"* || "$achievement_id" == *"ghost"* ]]; then
        header_color="${YELLOW}${BOLD}"
        celebration_header="
    🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️
    🔍   ✨ 🕵️ ✨ 🌟 SECRET ACHIEVEMENT UNLOCKED! 🌟 ✨ 🕵️  ✨   🔍
    🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️🔍🕵️"
    elif [[ "$achievement_id" == *"monthly"* || "$achievement_id" == *"legendary"* || "$achievement_id" == *"daily"* || "$achievement_id" == *"weekly"* ]]; then
        header_color="${YELLOW}${BOLD}"
        celebration_header="
    🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆🏆💎🏆💎🏆💎🏆
    💎   ✨ 🏆 ✨ 🌟 MILESTONE ACHIEVEMENT UNLOCKED! 🌟 ✨ 🏆 ✨   💎
    🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆💎🏆🏆💎🏆"
    elif [[ "$achievement_id" == *"doppelganger"* || "$achievement_id" == *"friend"* || "$achievement_id" == *"global"* || "$achievement_id" == *"connector"* ]]; then
        header_color="${GREEN}${BOLD}"
        celebration_header="
    🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝
    👥   ✨ 🤝 ✨ 🌟 SOCIAL ACHIEVEMENT UNLOCKED! 🌟 ✨ 🤝 ✨   👥
    🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝🌍🤝 🌐🤝👥🤝🌍🤝🌐🤝👥🤝🌍🤝🌐🤝👥🤝"
    elif [[ "$achievement_id" == *"interactive"* || "$achievement_id" == *"combo"* || "$achievement_id" == *"power_user"* || "$achievement_id" == *"explorer"* ]]; then
        header_color="${MAGENTA}${BOLD}"
        celebration_header="
     🎪⚙️🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪 
     🔧 ✨ 🛠️ ✨ 🌟 FEATURE ACHIEVEMENT UNLOCKED! 🌟 ✨ 🛠️ ✨ 🔧
     🎪⚙️🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪⚡🎪🛠️ 🎪⚙️ 🎪🔧🎪 "
    else
        header_color="${GREEN}${BOLD}"
        celebration_header="
    ✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨
    ✨  🎉 🏆 🎉 💫 EPIC ACHIEVEMENT UNLOCKED! 💫 🎉 🏆 🎉  ✨
    🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟✨🌟"
    fi
    
    echo
    echo -e "$header_color"
    center_ascii_block "$celebration_header"
    echo -e "${RESET}"
    echo
    
    # Center the achievement text using enhanced centering
    echo -e "${GREEN}${BOLD}"
    center_text "$achievement_text"
    echo -e "${RESET}"
    echo
    
    # Display celebration animation based on achievement type
    if [[ "$achievement_id" == *"roast"* || "$achievement_id" == *"flame"* || "$achievement_id" == *"chili"* || "$achievement_id" == *"coffee"* ]]; then
        display_roast_celebration
    elif [[ "$achievement_id" == *"oracle"* || "$achievement_id" == *"crystal"* || "$achievement_id" == *"seeing"* ]]; then
        display_oracle_celebration  
    elif [[ "$achievement_id" == *"tarot"* || "$achievement_id" == *"card"* || "$achievement_id" == *"deck"* || "$achievement_id" == *"fortune"* ]]; then
        display_tarot_celebration
    elif [[ "$achievement_id" == *"celebrity"* || "$achievement_id" == *"crush"* || "$achievement_id" == *"hollywood"* || "$achievement_id" == *"starstruck"* ]]; then
        display_celebrity_celebration
    elif [[ "$achievement_id" == *"night"* || "$achievement_id" == *"early"* || "$achievement_id" == *"halloween"* || "$achievement_id" == *"christmas"* || "$achievement_id" == *"valentine"* || "$achievement_id" == *"leprechaun"* || "$achievement_id" == *"autumn"* || "$achievement_id" == *"winter"* || "$achievement_id" == *"spring"* || "$achievement_id" == *"summer"* ]]; then
        display_time_celebration
    elif [[ "$achievement_id" == *"python"* || "$achievement_id" == *"java"* || "$achievement_id" == *"javascript"* || "$achievement_id" == *"rust"* || "$achievement_id" == *"go_gopher"* || "$achievement_id" == *"polyglot"* ]]; then
        display_language_celebration
    elif [[ "$achievement_id" == *"konami"* || "$achievement_id" == *"easter"* || "$achievement_id" == *"secret"* || "$achievement_id" == *"ghost"* ]]; then
        display_secret_celebration
    elif [[ "$achievement_id" == *"monthly"* || "$achievement_id" == *"legendary"* || "$achievement_id" == *"daily"* || "$achievement_id" == *"weekly"* ]]; then
        display_milestone_celebration
    elif [[ "$achievement_id" == *"doppelganger"* || "$achievement_id" == *"friend"* || "$achievement_id" == *"global"* || "$achievement_id" == *"connector"* ]]; then
        display_social_celebration
    elif [[ "$achievement_id" == *"interactive"* || "$achievement_id" == *"combo"* || "$achievement_id" == *"power_user"* || "$achievement_id" == *"explorer"* ]]; then
        display_feature_celebration
    else
        display_generic_celebration
    fi
    
    # Create dramatic closing celebration that matches the header theme
    local closing_celebration=""
    if [[ "$achievement_id" == *"roast"* || "$achievement_id" == *"flame"* || "$achievement_id" == *"chili"* || "$achievement_id" == *"coffee"* ]]; then
        closing_celebration="🔥💀 ROAST MASTERY ACHIEVED! 💀🔥"
    elif [[ "$achievement_id" == *"oracle"* || "$achievement_id" == *"crystal"* || "$achievement_id" == *"seeing"* ]]; then
        closing_celebration="  👁️🔮 ORACLE WISDOM FLOWS THROUGH YOU! 🔮👁️"
    elif [[ "$achievement_id" == *"tarot"* || "$achievement_id" == *"card"* || "$achievement_id" == *"deck"* || "$achievement_id" == *"fortune"* ]]; then
        closing_celebration="   🃏🎴 THE CARDS HAVE CHOSEN YOU! 🎴🃏"
    elif [[ "$achievement_id" == *"celebrity"* || "$achievement_id" == *"crush"* || "$achievement_id" == *"hollywood"* || "$achievement_id" == *"starstruck"* ]]; then
        closing_celebration="👑⭐ CODING STARDOM AWAITS! ⭐👑"
    elif [[ "$achievement_id" == *"night"* || "$achievement_id" == *"early"* || "$achievement_id" == *"halloween"* || "$achievement_id" == *"christmas"* || "$achievement_id" == *"valentine"* || "$achievement_id" == *"leprechaun"* || "$achievement_id" == *"autumn"* || "$achievement_id" == *"winter"* || "$achievement_id" == *"spring"* || "$achievement_id" == *"summer"* ]]; then
        closing_celebration="  ⏰🕐 TIME LORD STATUS ACHIEVED! 🕐⏰"
    elif [[ "$achievement_id" == *"python"* || "$achievement_id" == *"java"* || "$achievement_id" == *"javascript"* || "$achievement_id" == *"rust"* || "$achievement_id" == *"go_gopher"* || "$achievement_id" == *"polyglot"* ]]; then
        closing_celebration="💻🔤 POLYGLOT POWER ACTIVATED! 🔤💻"
    elif [[ "$achievement_id" == *"konami"* || "$achievement_id" == *"easter"* || "$achievement_id" == *"secret"* || "$achievement_id" == *"ghost"* ]]; then
        closing_celebration="🕵️🔍 SECRET MASTER REVEALED! 🔍🕵️"
    elif [[ "$achievement_id" == *"monthly"* || "$achievement_id" == *"legendary"* || "$achievement_id" == *"daily"* || "$achievement_id" == *"weekly"* ]]; then
        closing_celebration="�💎 LEGENDARY STATUS UNLOCKED! 💎�"
    elif [[ "$achievement_id" == *"doppelganger"* || "$achievement_id" == *"friend"* || "$achievement_id" == *"global"* || "$achievement_id" == *"connector"* ]]; then
        closing_celebration="🤝� SOCIAL CODING LEGEND! �🤝"
    elif [[ "$achievement_id" == *"interactive"* || "$achievement_id" == *"combo"* || "$achievement_id" == *"power_user"* || "$achievement_id" == *"explorer"* ]]; then
        closing_celebration="�🔧 FEATURE MASTER SUPREME! 🔧�"
    else
        closing_celebration="�✨ EPIC ACHIEVEMENT COMPLETED! ✨�"
    fi
    
    # Display themed closing celebration
    echo -e "$header_color"
    center_text "$closing_celebration"
    echo -e "${RESET}\n"
    
    # Wait for user to appreciate the moment
    read -p "Press Enter to continue your mystical journey..."
    clear
}

# Roast achievement celebration with dynamic centering
display_roast_celebration() {
    local roast_celebration="
     🔥════════════════════════════════════🔥
     ║     🌶️  ROAST MASTER LEVEL UP!  🌶️     ║
     ║                                      ║  
     ║        You can handle the heat!      ║
     ║     🔥 Your code burns brighter 🔥   ║
     🔥════════════════════════════════════🔥"

    echo -e "${RED}${BOLD}"
    center_ascii_block "$roast_celebration"
    echo -e "${RESET}"
    
    # Add fireworks for epic celebration
    animate_responsive_fireworks
}

# Oracle achievement celebration with dynamic centering
display_oracle_celebration() {
    local oracle_celebration="
     👁️✨═══════════════════════════════════✨👁️
     ║       🔮 ORACLE WISDOM GAINED! 🔮      ║
     ║                                        ║
     ║    Your questions unlock the secrets   ║
     ║       👁️ All-Seeing Knowledge 👁️         ║
     👁️✨═══════════════════════════════════✨👁️"

    echo -e "${CYAN}${BOLD}"
    center_ascii_block "$oracle_celebration"
    echo -e "${RESET}"
    
    # Add matrix rain effect for oracle achievements
    animate_matrix_rain 2 5
}

# Tarot achievement celebration with dynamic centering
display_tarot_celebration() {
    local tarot_celebration="
     🃏✨═══════════════════════════════════✨🃏
     ║      🎴 TAROT MASTER ACHIEVED! 🎴       ║
     ║                                         ║
     ║     The cards reveal your destiny       ║
     ║        🔮 Fortune Favors You 🔮         ║
     🃏✨═══════════════════════════════════✨🃏"

    echo -e "${MAGENTA}${BOLD}"
    center_ascii_block "$tarot_celebration"
    echo -e "${RESET}"
    
    # Add mystical sparkles for tarot achievements
    echo -e "${MAGENTA}"
    center_text "   ✨ ･ﾟ✧*:･ﾟ✧ The Cards Have Spoken! ･ﾟ✧*:･ﾟ✧ ✨"
    echo -e "${RESET}"
}

# Generic achievement celebration with dynamic centering
display_generic_celebration() {
    local generic_celebration="
   🌟✨═══════════════════════════════════✨🌟
   ║        🏆 MILESTONE REACHED! 🏆         ║ 
   ║                                         ║
   ║        Your legend continues to         ║
   ║           ✨ Grow Stronger ✨           ║
   🌟✨═══════════════════════════════════✨🌟"

    echo -e "${GREEN}${BOLD}"
    center_ascii_block "$generic_celebration"
    echo -e "${RESET}"
    
    # Add light fireworks for generic achievements
    animate_responsive_fireworks
}

# Celebrity achievement celebration with purple/magenta colors
display_celebrity_celebration() {
    local celebrity_celebration="
    👑✨═══════════════════════════════════✨👑
    ║      🌟 CELEBRITY STATUS UNLOCKED! 🌟   ║
    ║                                         ║    
    ║  You walk among the coding legends      ║
    ║         👑 Star Power Activated 👑      ║
    👑✨═══════════════════════════════════✨👑"

    echo -e "${MAGENTA}${BOLD}"
    center_ascii_block "$celebrity_celebration"
    echo -e "${RESET}"
    
    # Add golden sparkles for celebrity achievements
    echo -e "${YELLOW}"
    center_text "  ✨ ⭐ 🌟 ⭐ HOLLYWOOD CODING LEGEND! ⭐ 🌟 ⭐ ✨"
    echo -e "${RESET}"
}

# Time-based achievement celebration with blue colors
display_time_celebration() {
    local time_celebration="
     ⏰✨═══════════════════════════════════✨⏰
     ║       🕐 PERFECT TIMING MASTER! 🕐      ║
     ║                                         ║
     ║    Your temporal coding skills shine    ║
     ║         ⏰ Time Lord Status ⏰          ║
     ⏰✨═══════════════════════════════════✨⏰"

    echo -e "${BLUE}${BOLD}"
    center_ascii_block "$time_celebration"
    echo -e "${RESET}"
    
    # Add clock ticking effect
    echo -e "${CYAN}"
    center_text "🕐 ➤ 🕑 ➤ 🕒 ➤ TIME ACHIEVEMENT UNLOCKED! ➤ 🕒 ➤ 🕑 ➤ 🕐"
    echo -e "${RESET}"
}

# Language mastery achievement celebration with bright colors
display_language_celebration() {
    local language_celebration="
     💻✨═══════════════════════════════════✨💻
     ║      🔤 LANGUAGE MASTERY ACHIEVED! 🔤   ║
     ║                                         ║
     ║   Your polyglot powers are legendary    ║
     ║        💻 Code Linguist Elite 💻        ║
     💻✨═══════════════════════════════════✨💻"

    echo -e "${CYAN}${BOLD}"
    center_ascii_block "$language_celebration"
    echo -e "${RESET}"
    
    # Add programming language symbols
    echo -e "${CYAN}"
    center_text "🐍 ☕ ⚡ 🦀 🐹 { } [ ] < /> POLYGLOT POWER! < /> [ ] { } 🐹 🦀 ⚡ ☕ 🐍"
    echo -e "${RESET}"
}

# Hidden/Secret achievement celebration with mysterious colors
display_secret_celebration() {
    local secret_celebration="
     🔍✨═══════════════════════════════════✨🔍
     ║         🕵️ SECRET DISCOVERED! 🕵️          ║
     ║                                         ║
     ║      You've uncovered hidden mysteries  ║
     ║          🔍 Master Detective 🔍         ║
     🔍✨═══════════════════════════════════✨🔍"

    echo -e "${YELLOW}${BOLD}"
    center_ascii_block "$secret_celebration"
    echo -e "${RESET}"
    
    # Add mysterious matrix effect
    animate_matrix_rain 1 3
}

# Milestone achievement celebration with golden colors
display_milestone_celebration() {
    local milestone_celebration="
    🏆✨═══════════════════════════════════✨🏆
    ║       📈 EPIC MILESTONE REACHED! 📈     ║
    ║                                         ║
    ║    Your dedication has paid dividends   ║
    ║         🏆 Legendary Status 🏆          ║
    🏆✨═══════════════════════════════════✨🏆"

    echo -e "${YELLOW}${BOLD}"
    center_ascii_block "$milestone_celebration"
    echo -e "${RESET}"
    
    # Add epic fireworks for major milestones
    animate_responsive_fireworks
}

# Social achievement celebration with warm colors
display_social_celebration() {
    local social_celebration="
     🤝✨═══════════════════════════════════✨🤝
     ║     🌍 SOCIAL CONNECTOR UNLOCKED! 🌍   ║
     ║                                        ║
     ║  Your networking skills are legendary  ║
     ║        🤝 Community Builder 🤝         ║
     🤝✨═══════════════════════════════════✨🤝"

    echo -e "${GREEN}${BOLD}"
    center_ascii_block "$social_celebration"
    echo -e "${RESET}"
    
    # Add community connection symbols
    echo -e "${GREEN}"
    center_text " 👥 🌐 🤝 🌍 BUILDING BRIDGES IN CODE! 🌍 🤝 🌐 👥"
    echo -e "${RESET}"
}

# Feature discovery achievement celebration with rainbow colors
display_feature_celebration() {
    local feature_celebration="
     🎪✨═══════════════════════════════════✨🎪
     ║      🔧 FEATURE EXPLORER MASTER! 🔧     ║
     ║                                         ║
     ║    You've mastered the hidden tools     ║
     ║         🎪 Power User Elite 🎪          ║
     🎪✨═══════════════════════════════════✨🎪"

    echo -e "${MAGENTA}${BOLD}"
    center_ascii_block "$feature_celebration"
    echo -e "${RESET}"
    
    # Add tool symbols
    echo -e "${CYAN}"
    center_text "       🔧 ⚙️ 🛠️ ⚡ TOOL MASTERY UNLOCKED! ⚡ 🛠️ ⚙️ 🔧"
    echo -e "${RESET}"
}

# Track feature usage
track_usage() {
    local feature="$1"
    
    # Ensure error handling doesn't break interactive mode
    update_stats "total_uses" || true
    
    case "$feature" in
        "interactive")
            update_stats "interactive_sessions" || true
            check_achievement "interactive_explorer" || true
            ;;
        "roast")
            update_stats "roast_count" || true
            check_achievement "roast_rookie" || true
            # Check milestone achievements
            check_achievement "coffee_bean" || true
            check_achievement "chili_master" || true
            check_achievement "flame_lord" || true
            ;;
        "oracle")
            update_stats "oracle_questions" || true
            check_achievement "oracle_apprentice" || true
            # Check milestone achievements
            check_achievement "crystal_gazer" || true
            check_achievement "all_seeing_eye" || true
            check_achievement "oracle_master" || true
            ;;
        "tarot")
            update_stats "tarot_draws" || true
            check_achievement "card_sharp" || true
            # Check milestone achievements
            check_achievement "card_collector" || true
            check_achievement "deck_master" || true
            check_achievement "fortune_teller" || true
            ;;
        "celebrity")
            update_stats "celebrity_comparisons" || true
            check_achievement "celebrity_crush" || true
            # Check milestone achievements
            check_achievement "starstruck" || true
            check_achievement "hollywood_hacker" || true
            ;;
        *)
            check_achievement "first_steps" || true
            ;;
    esac
    
    # Always check time-based and milestone achievements
    check_all_achievements || true
}

# Check all achievements (called periodically)
check_all_achievements() {
    # Check time-based achievements
    check_achievement "night_owl"
    check_achievement "early_bird"
    check_achievement "halloween_hacker"
    check_achievement "christmas_coder"
    check_achievement "new_year_ninja"
    check_achievement "valentine_virtuoso"
    check_achievement "lucky_leprechaun"
    check_achievement "autumn_analyzer"
    check_achievement "winter_wizard"
    check_achievement "spring_sprinter"
    check_achievement "summer_sage"
    
    # Check usage milestones
    check_achievement "monthly_master"
    check_achievement "legendary_legend"
}

# Display achievement progress
show_achievements() {
    init_achievement_system
    
    # Beautiful sparkly title like other modules
    echo -e "${MAGENTA}${BOLD}"
    echo "                                       🏆 ✨ 🏆 ✨ 🏆"
    echo "                              🌟 ✨ ACHIEVEMENT GALLERY ✨ 🌟"
    echo "                                       🏆 ✨ 🏆 ✨ 🏆"
    echo
    echo "                             🎖️ Your Coding Accomplishments 🎖️"
    echo -e "${RESET}"
    echo
    
    # Beautiful centered section
    echo -e "${YELLOW}${BOLD}"
    echo "                         🌟 ═══════════════════════════════════ 🌟"
    echo
    echo "                                ✨ Unlocked Achievements ✨"
    echo
    echo "                         🌟 ═══════════════════════════════════ 🌟"
    echo -e "${RESET}"
    echo
    

    local unlocked_ids=()
    local locked_ids=()
    local unlocked_count=0
    local locked_count=0

    # Collect unlocked and locked achievement IDs
    for achievement_id in "${!ACHIEVEMENTS[@]}"; do
        if [[ -f "$ACHIEVEMENT_DIR/unlocked.log" ]] && grep -q "^$achievement_id$" "$ACHIEVEMENT_DIR/unlocked.log" 2>/dev/null; then
            unlocked_ids+=("$achievement_id")
        else
            locked_ids+=("$achievement_id")
        fi
    done

    # Paging for unlocked achievements
    local page_size=8
    local total_unlocked=${#unlocked_ids[@]}
    local page=0
    while (( page * page_size < total_unlocked )); do
        clear
        echo -e "${MAGENTA}${BOLD}"
        echo "                                       � ✨ 🏆 ✨ 🏆"
        echo "                              🌟 ✨ ACHIEVEMENT GALLERY ✨ 🌟"
        echo "                                       🏆 ✨ 🏆 ✨ 🏆"
        echo
        echo "                             🎖️ Your Coding Accomplishments 🎖️"
        echo -e "${RESET}"
        echo
        echo -e "${YELLOW}${BOLD}"
        echo "                         🌟 ═══════════════════════════════════ 🌟"
        echo
        echo "                                ✨ Unlocked Achievements ✨"
        echo
        echo "                         🌟 ═══════════════════════════════════ 🌟"
        echo -e "${RESET}"
        echo
        echo -e "${CYAN}${BOLD}"
        echo "    🎉 UNLOCKED ACHIEVEMENTS:"
        echo -e "${RESET}"
        echo
        for ((i = page * page_size; i < (page + 1) * page_size && i < total_unlocked; i++)); do
            local achievement_id="${unlocked_ids[$i]}"
            local achievement_text="${ACHIEVEMENTS[$achievement_id]}"
            echo -e "${CYAN}${BOLD}"
            wrap_achievement_text "✅ $achievement_text"
            echo -e "${RESET}"
            echo
            unlocked_count=$((unlocked_count + 1))
        done
        if (( (page + 1) * page_size < total_unlocked )); then
            read -p "Press Enter to see next page of unlocked achievements, or type 'q' to exit: " choice
            if [[ "$choice" =~ ^[qQ]$ ]]; then
                break
            fi
        else
            # Last page
            read -p "Press Enter to continue to locked achievements..."
            break
        fi
        page=$((page + 1))
    done

    # Separator if any unlocked
    if [[ $unlocked_count -gt 0 ]]; then
        echo -e "${CYAN}"
        echo "    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e "${RESET}"
        echo
    fi

    # Paging for locked achievements
    local total_locked=${#locked_ids[@]}
    page=0
    while (( page * page_size < total_locked )); do
        clear
        echo -e "${MAGENTA}${BOLD}"
        echo "                                       🏆 ✨ 🏆 ✨ 🏆"
        echo "                              🌟 ✨ ACHIEVEMENT GALLERY ✨ 🌟"
        echo "                                       🏆 ✨ 🏆 ✨ 🏆"
        echo
        echo "                             🎖️ Your Coding Accomplishments 🎖️"
        echo -e "${RESET}"
        echo
        echo -e "${YELLOW}${BOLD}"
        echo "                         🌟 ═══════════════════════════════════ 🌟"
        echo
        echo "                                ✨ Locked Achievements ✨"
        echo
        echo "                         🌟 ═══════════════════════════════════ 🌟"
        echo -e "${RESET}"
        echo
        echo -e "${CYAN}"
        echo "    🔒 LOCKED ACHIEVEMENTS:"
        echo -e "${RESET}"
        echo
        for ((i = page * page_size; i < (page + 1) * page_size && i < total_locked; i++)); do
            local achievement_id="${locked_ids[$i]}"
            local achievement_text="${ACHIEVEMENTS[$achievement_id]}"
            echo -e "${CYAN}"
            wrap_achievement_text "🔒 $achievement_text"
            echo -e "${RESET}"
            locked_count=$((locked_count + 1))
        done
        if (( (page + 1) * page_size < total_locked )); then
            read -p "Press Enter to see next page of locked achievements, or type 'q' to exit: " choice
            if [[ "$choice" =~ ^[qQ]$ ]]; then
                break
            fi
        else
            # Last page
            if (( locked_count < ${#ACHIEVEMENTS[@]} )); then
                echo -e "${CYAN}"
                echo "    • ... and many more hidden achievements!"
                echo -e "${RESET}"
            fi
            read -p "Press Enter to finish viewing achievements..."
            break
        fi
        page=$((page + 1))
    done

    echo
    echo -e "${CYAN}"
    echo "    📊 Progress: $unlocked_count unlocked • $((${#ACHIEVEMENTS[@]} - unlocked_count)) remaining"
    echo -e "${RESET}"
    echo
}

# Test function to display all achievement celebration types
test_achievement_celebrations() {
    echo -e "${YELLOW}${BOLD}"
    echo "                    🧪 COMPLETE ACHIEVEMENT CELEBRATION TEST 🧪"
    echo "                         Testing every achievement type..."
    echo -e "${RESET}"
    echo
    
    # Create array of all achievement IDs for systematic testing
    local all_achievements=(
        "first_steps" "identity_crisis" "card_sharp" "celebrity_crush"
        "roast_rookie" "coffee_bean" "chili_master" "flame_lord"
        "oracle_apprentice" "crystal_gazer" "all_seeing_eye" "oracle_master"
        "card_collector" "deck_master" "fortune_teller" "tarot_royalty"
        "starstruck" "hollywood_hacker" "celebrity_collector"
        "night_owl" "early_bird" "halloween_hacker" "christmas_coder"
        "new_year_ninja" "valentine_virtuoso" "lucky_leprechaun"
        "daily_devotee" "weekly_warrior" "monthly_master" "legendary_legend"
        "interactive_explorer" "combo_master" "power_user"
        "konami_code" "easter_egg_hunter" "secret_seeker" "ghost_in_shell"
        "doppelganger_detector" "friend_maker" "global_connector"
        "pattern_analyst" "mind_reader" "bullseye"
        "autumn_analyzer" "winter_wizard" "spring_sprinter" "summer_sage"
        "polyglot" "python_charmer" "java_junkie" "javascript_jedi" "rust_ranger" "go_gopher"
    )
    
    local count=1
    local total=${#all_achievements[@]}
    
    echo -e "${CYAN}${BOLD}Found $total achievements to test!${RESET}"
    echo
    read -p "Press Enter to start testing all achievements..."
    
    for achievement_id in "${all_achievements[@]}"; do
        clear
        echo -e "${YELLOW}${BOLD}Testing Achievement $count/$total: ${CYAN}$achievement_id${RESET}"
        echo -e "${WHITE}Description: ${ACHIEVEMENTS[$achievement_id]}${RESET}"
        echo
        
        # Display the full achievement celebration
        display_achievement_celebration "$achievement_id"
        
        count=$((count + 1))
        
        # Give option to skip or continue
        echo -e "${YELLOW}Press Enter for next achievement, 's' to skip remaining, 'q' to quit...${RESET}"
        read -n 1 choice
        
        case $choice in
            [sS])
                echo
                echo -e "${YELLOW}Skipping remaining achievements...${RESET}"
                break
                ;;
            [qQ])
                echo
                echo -e "${RED}Quitting achievement test...${RESET}"
                return 0
                ;;
        esac
    done
    
    clear
    echo -e "${GREEN}${BOLD}🎉 ACHIEVEMENT CELEBRATION TEST COMPLETE! 🎉${RESET}"
    echo
    echo -e "${CYAN}Tested $((count - 1)) achievements successfully!${RESET}"
    echo
    echo -e "${YELLOW}Individual celebration component tests:${RESET}"
    echo
    
    read -p "Press Enter to test individual celebration components..."
    clear
    
    echo -e "${RED}${BOLD}1. Roast Celebration Component:${RESET}"
    display_roast_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${CYAN}${BOLD}2. Oracle Celebration Component:${RESET}"
    display_oracle_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${MAGENTA}${BOLD}3. Tarot Celebration Component:${RESET}"
    display_tarot_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${GREEN}${BOLD}4. Generic Celebration Component:${RESET}"
    display_generic_celebration
    echo
    
    echo -e "${YELLOW}${BOLD}🎉 All celebration tests complete! 🎉${RESET}"
    echo
    echo -e "${CYAN}You can now verify alignment, colors, and functionality!${RESET}"
    echo
}

# Quick test function for just celebration components (no full achievements)
test_celebration_components() {
    echo -e "${YELLOW}${BOLD}🧪 ALL CELEBRATION COMPONENTS TEST 🧪${RESET}"
    echo -e "${CYAN}Testing all 11 celebration types with their unique colors!${RESET}"
    echo
    
    echo -e "${RED}${BOLD}1. Roast Celebration (Red):${RESET}"
    display_roast_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${CYAN}${BOLD}2. Oracle Celebration (Cyan):${RESET}"
    display_oracle_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${MAGENTA}${BOLD}3. Tarot Celebration (Magenta):${RESET}"
    display_tarot_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${MAGENTA}${BOLD}4. Celebrity Celebration (Purple):${RESET}"
    display_celebrity_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${BLUE}${BOLD}5. Time Celebration (Blue):${RESET}"
    display_time_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${CYAN}${BOLD}6. Language Celebration (Bright Cyan):${RESET}"
    display_language_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${YELLOW}${BOLD}7. Secret Celebration (Yellow):${RESET}"
    display_secret_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${YELLOW}${BOLD}8. Milestone Celebration (Golden):${RESET}"
    display_milestone_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${GREEN}${BOLD}9. Social Celebration (Green):${RESET}"
    display_social_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${MAGENTA}${BOLD}10. Feature Celebration (Rainbow):${RESET}"
    display_feature_celebration
    echo
    read -p "Press Enter for next..."
    
    echo -e "${GREEN}${BOLD}11. Generic Celebration (Green):${RESET}"
    display_generic_celebration
    echo
    
    echo -e "${YELLOW}${BOLD}🎉 All 11 celebration component tests complete! 🎉${RESET}"
    echo -e "${CYAN}Each achievement category now has its own unique color scheme!${RESET}"
}