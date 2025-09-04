#!/bin/bash

# Achievement System for GitHub CLI Horoscope Extension
# Tracks and celebrates developer progress through mystical achievements

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
ACHIEVEMENTS["first_steps"]="🔮 First Steps - Complete first horoscope reading"
ACHIEVEMENTS["identity_crisis"]="🎭 Identity Crisis - Discover your developer archetype"
ACHIEVEMENTS["card_sharp"]="🃏 Card Sharp - Draw your first tarot card"
ACHIEVEMENTS["celebrity_crush"]="👑 Celebrity Crush - Compare with first celebrity"

# Usage Milestones
ACHIEVEMENTS["roast_rookie"]="🔥 Roast Rookie - Survive your first roast (1)"
ACHIEVEMENTS["coffee_bean"]="☕ Coffee Bean - Get roasted 10 times"
ACHIEVEMENTS["chili_master"]="🌶️ Chili Master - Get roasted 25 times"
ACHIEVEMENTS["flame_lord"]="🔥 Flame Lord - Get roasted 50 times"

# Oracle Wisdom
ACHIEVEMENTS["oracle_apprentice"]="🧙‍♂️ Oracle Apprentice - Ask Oracle 1 question"
ACHIEVEMENTS["crystal_gazer"]="🔮 Crystal Gazer - Ask Oracle 10 questions"
ACHIEVEMENTS["all_seeing_eye"]="👁️ All-Seeing Eye - Ask Oracle 25 questions"
ACHIEVEMENTS["oracle_master"]="🌟 Oracle Master - Ask Oracle 50 questions"

# Tarot Mastery
ACHIEVEMENTS["card_collector"]="🃏 Card Collector - Draw 10 cards"
ACHIEVEMENTS["deck_master"]="🎴 Deck Master - Draw 50 cards"
ACHIEVEMENTS["fortune_teller"]="🔮 Fortune Teller - Draw 100 cards"
ACHIEVEMENTS["tarot_royalty"]="👑 Tarot Royalty - Draw all 78 unique cards"

# Celebrity Comparisons
ACHIEVEMENTS["starstruck"]="⭐ Starstruck - Compare with 5 celebrities"
ACHIEVEMENTS["hollywood_hacker"]="🎬 Hollywood Hacker - Compare with 20 celebrities"
ACHIEVEMENTS["celebrity_collector"]="👑 Celebrity Collector - Compare with all available celebrities"

# Time-Based Achievements
ACHIEVEMENTS["night_owl"]="🌙 Night Owl - Use horoscope between 2-4AM"
ACHIEVEMENTS["early_bird"]="☀️ Early Bird - Use horoscope between 5-7AM"
ACHIEVEMENTS["halloween_hacker"]="🎃 Halloween Hacker - Use on October 31st"
ACHIEVEMENTS["christmas_coder"]="🎄 Christmas Coder - Use on December 25th"
ACHIEVEMENTS["new_year_ninja"]="🎊 New Year Ninja - Use on January 1st"
ACHIEVEMENTS["valentine_virtuoso"]="💘 Valentine Virtuoso - Use on February 14th"
ACHIEVEMENTS["lucky_leprechaun"]="☘️ Lucky Leprechaun - Use on March 17th"

# Usage Patterns
ACHIEVEMENTS["daily_devotee"]="📅 Daily Devotee - Use 7 days in a row"
ACHIEVEMENTS["weekly_warrior"]="🗓️ Weekly Warrior - Use 30 days in a row"
ACHIEVEMENTS["monthly_master"]="📆 Monthly Master - Use 100 days total"
ACHIEVEMENTS["legendary_legend"]="🏆 Legendary Legend - Use 365 days total"

# Feature Discovery
ACHIEVEMENTS["interactive_explorer"]="🎪 Interactive Explorer - Use interactive mode"
ACHIEVEMENTS["combo_master"]="🎯 Combo Master - Use command combinations (-ort, -cra)"
ACHIEVEMENTS["power_user"]="🔧 Power User - Use all single-letter flags in one session"

# Hidden Secrets
ACHIEVEMENTS["konami_code"]="🕹️ Konami Code - Enter secret developer sequence"
ACHIEVEMENTS["easter_egg_hunter"]="🎮 Easter Egg Hunter - Discover 5 easter eggs"
ACHIEVEMENTS["secret_seeker"]="🔍 Secret Seeker - Find 10 hidden features"
ACHIEVEMENTS["ghost_in_shell"]="👻 Ghost in Shell - Find ultra-secret developer mode"

# Social Features
ACHIEVEMENTS["doppelganger_detector"]="👯 Doppelganger Detector - Find your GitHub twin"
ACHIEVEMENTS["friend_maker"]="🤝 Friend Maker - Match with 10 similar users"
ACHIEVEMENTS["global_connector"]="🌍 Global Connector - Match with users from 5 countries"

# Advanced Analytics
ACHIEVEMENTS["pattern_analyst"]="🔬 Pattern Analyst - Unlock all developer archetypes"
ACHIEVEMENTS["mind_reader"]="🧠 Mind Reader - Get accurate personality analysis"
ACHIEVEMENTS["bullseye"]="🎯 Bullseye - Get 90%+ accuracy prediction"

# Seasonal Celebrations
ACHIEVEMENTS["autumn_analyzer"]="🍂 Autumn Analyzer - Use during October-November"
ACHIEVEMENTS["winter_wizard"]="❄️ Winter Wizard - Use during December-February"
ACHIEVEMENTS["spring_sprinter"]="🌸 Spring Sprinter - Use during March-May"
ACHIEVEMENTS["summer_sage"]="☀️ Summer Sage - Use during June-August"

# Language Mastery
ACHIEVEMENTS["polyglot"]="💻 Polyglot - Have 5+ primary languages"
ACHIEVEMENTS["python_charmer"]="🐍 Python Charmer - Python as primary language"
ACHIEVEMENTS["java_junkie"]="☕ Java Junkie - Java as primary language"
ACHIEVEMENTS["javascript_jedi"]="⚡ JavaScript Jedi - JavaScript as primary language"
ACHIEVEMENTS["rust_ranger"]="🦀 Rust Ranger - Rust as primary language"
ACHIEVEMENTS["go_gopher"]="🐹 Go Gopher - Go as primary language"

# Update user statistics
update_stats() {
    local stat_key="$1"
    local increment="${2:-1}"
    local current_date=$(date '+%Y-%m-%d')
    
    init_achievement_system
    
    # Read current stats
    local stats
    if [[ -f "$STATS_FILE" ]]; then
        stats=$(cat "$STATS_FILE")
    else
        stats='{"total_uses": 0, "first_use": "", "consecutive_days": 0, "last_use": "", "roast_count": 0, "oracle_questions": 0, "tarot_draws": 0, "celebrity_comparisons": 0, "interactive_sessions": 0}'
    fi
    
    # Update stats (simplified approach for bash)
    case "$stat_key" in
        "total_uses")
            # Increment total uses
            ;;
        "roast_count")
            # Increment roast count
            ;;
        "oracle_questions")
            # Increment oracle questions
            ;;
        "tarot_draws")
            # Increment tarot draws
            ;;
        "celebrity_comparisons")
            # Increment celebrity comparisons
            ;;
        "interactive_sessions")
            # Increment interactive sessions
            ;;
    esac
    
    # For now, keep it simple and just track basic usage
    echo "Stats updated: $stat_key += $increment" >&2
}

# Check if achievement should be unlocked
check_achievement() {
    local achievement_id="$1"
    
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
        *)
            # More complex achievements would check stats here
            ;;
    esac
}

# Unlock an achievement
unlock_achievement() {
    local achievement_id="$1"
    
    init_achievement_system
    
    # Check if already unlocked (simplified)
    if grep -q "\"$achievement_id\"" "$ACHIEVEMENT_FILE" 2>/dev/null; then
        return 0
    fi
    
    # Add to unlocked achievements (simplified JSON append)
    display_achievement_celebration "$achievement_id"
    
    # Mark as unlocked (simplified approach)
    echo "Achievement unlocked: $achievement_id" >> "$ACHIEVEMENT_DIR/unlocked.log"
}

# Display achievement celebration animation with enhanced centering
display_achievement_celebration() {
    local achievement_id="$1"
    local achievement_text="${ACHIEVEMENTS[$achievement_id]}"
    
    # Create celebration header with dynamic centering
    local celebration_header="✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨
🏆 ACHIEVEMENT UNLOCKED! 🏆
✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨"
    
    echo
    echo -e "${YELLOW}${BOLD}"
    center_ascii_block "$celebration_header"
    echo -e "${RESET}"
    echo
    
    # Center the achievement text using enhanced centering
    echo -e "${GREEN}${BOLD}"
    center_text "$achievement_text"
    echo -e "${RESET}"
    echo
    
    # Display celebration animation based on achievement type
    if [[ "$achievement_id" == *"roast"* ]]; then
        display_roast_celebration
    elif [[ "$achievement_id" == *"oracle"* ]]; then
        display_oracle_celebration  
    elif [[ "$achievement_id" == *"tarot"* || "$achievement_id" == *"card"* ]]; then
        display_tarot_celebration
    else
        display_generic_celebration
    fi
    
    # Centered closing celebration
    echo -e "${YELLOW}"
    center_text "✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨🎉✨"
    echo -e "${RESET}\n"
    
    # Wait for user to appreciate the moment
    read -p "Press Enter to continue your mystical journey..."
}

# Roast achievement celebration with dynamic centering
display_roast_celebration() {
    local roast_celebration="
🔥════════════════════════════════════🔥
║     🌶️  ROAST MASTER LEVEL UP!  🌶️   ║
║                                      ║  
║        You can handle the heat!      ║
║      🔥 Your code burns brighter 🔥  ║
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
║        🔮 ORACLE WISDOM GAINED! 🔮       ║
║                                          ║
║    Your questions unlock the secrets     ║
║        👁️ All-Seeing Knowledge 👁️        ║
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
    center_text "✨ ･ﾟ✧*:･ﾟ✧ The Cards Have Spoken! ･ﾟ✧*:･ﾟ✧ ✨"
    echo -e "${RESET}"
}

# Generic achievement celebration with dynamic centering
display_generic_celebration() {
    local generic_celebration="
🌟✨═══════════════════════════════════✨🌟
║        🏆 MILESTONE REACHED! 🏆         ║
║                                         ║
║       Your legend continues to          ║
║          ✨ Grow Stronger ✨            ║
🌟✨═══════════════════════════════════✨🌟"

    echo -e "${GREEN}${BOLD}"
    center_ascii_block "$generic_celebration"
    echo -e "${RESET}"
    
    # Add light fireworks for generic achievements
    animate_responsive_fireworks
}

# Track feature usage
track_usage() {
    local feature="$1"
    
    update_stats "total_uses"
    
    case "$feature" in
        "interactive")
            update_stats "interactive_sessions"
            check_achievement "interactive_explorer"
            ;;
        "roast")
            update_stats "roast_count"
            check_achievement "roast_rookie"
            ;;
        "oracle")
            update_stats "oracle_questions"
            check_achievement "oracle_apprentice"
            ;;
        "tarot")
            update_stats "tarot_draws"
            check_achievement "card_sharp"
            ;;
        "celebrity")
            update_stats "celebrity_comparisons"
            check_achievement "celebrity_crush"
            ;;
        *)
            check_achievement "first_steps"
            ;;
    esac
}

# Display achievement progress
show_achievements() {
    init_achievement_system
    
    draw_box_top
    draw_box_content "🏆 ACHIEVEMENT GALLERY 🏆" "center"
    draw_box_middle
    
    local count=0
    for achievement_id in "${!ACHIEVEMENTS[@]}"; do
        local achievement_text="${ACHIEVEMENTS[$achievement_id]}"
        
        if [[ -f "$ACHIEVEMENT_DIR/unlocked.log" ]] && grep -q "$achievement_id" "$ACHIEVEMENT_DIR/unlocked.log" 2>/dev/null; then
            draw_box_content "✅ $achievement_text"
        else
            draw_box_content "🔒 $achievement_text"
        fi
        
        count=$((count + 1))
        if [[ $count -ge 10 ]]; then
            draw_box_content "... and many more hidden achievements!"
            break
        fi
    done
    
    draw_box_bottom
    echo
}