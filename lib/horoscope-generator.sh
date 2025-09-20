#!/bin/bash

# Horoscope Generator module for GitHub CLI Horoscope Extension
# Generates personalized horoscopes based on GitHub analysis data

# Astrological sign determination based on date
get_astrological_sign() {
    local month="$1"
    local day="$2"
    
    # Convert month to number if needed
    case $month in
        "January" | "Jan" | "01" | "1") month=1 ;;
        "February" | "Feb" | "02" | "2") month=2 ;;
        "March" | "Mar" | "03" | "3") month=3 ;;
        "April" | "Apr" | "04" | "4") month=4 ;;
        "May" | "05" | "5") month=5 ;;
        "June" | "Jun" | "06" | "6") month=6 ;;
        "July" | "Jul" | "07" | "7") month=7 ;;
        "August" | "Aug" | "08" | "8") month=8 ;;
        "September" | "Sep" | "09" | "9") month=9 ;;
        "October" | "Oct" | "10") month=10 ;;
        "November" | "Nov" | "11") month=11 ;;
        "December" | "Dec" | "12") month=12 ;;
    esac
    
    if [[ $month -eq 1 && $day -ge 20 ]] || [[ $month -eq 2 && $day -le 18 ]]; then
        echo "Aquarius ♒"
    elif [[ $month -eq 2 && $day -ge 19 ]] || [[ $month -eq 3 && $day -le 20 ]]; then
        echo "Pisces ♓"
    elif [[ $month -eq 3 && $day -ge 21 ]] || [[ $month -eq 4 && $day -le 19 ]]; then
        echo "Aries ♈"
    elif [[ $month -eq 4 && $day -ge 20 ]] || [[ $month -eq 5 && $day -le 20 ]]; then
        echo "Taurus ♉"
    elif [[ $month -eq 5 && $day -ge 21 ]] || [[ $month -eq 6 && $day -le 20 ]]; then
        echo "Gemini ♊"
    elif [[ $month -eq 6 && $day -ge 21 ]] || [[ $month -eq 7 && $day -le 22 ]]; then
        echo "Cancer ♋"
    elif [[ $month -eq 7 && $day -ge 23 ]] || [[ $month -eq 8 && $day -le 22 ]]; then
        echo "Leo ♌"
    elif [[ $month -eq 8 && $day -ge 23 ]] || [[ $month -eq 9 && $day -le 22 ]]; then
        echo "Virgo ♍"
    elif [[ $month -eq 9 && $day -ge 23 ]] || [[ $month -eq 10 && $day -le 22 ]]; then
        echo "Libra ♎"
    elif [[ $month -eq 10 && $day -ge 23 ]] || [[ $month -eq 11 && $day -le 21 ]]; then
        echo "Scorpio ♏"
    elif [[ $month -eq 11 && $day -ge 22 ]] || [[ $month -eq 12 && $day -le 21 ]]; then
        echo "Sagittarius ♐"
    else
        echo "Capricorn ♑"
    fi
}

# Generate astrological insights based on sign
get_astrological_insight() {
    local sign="$1"
    local coding_data="$2"  # Pass additional coding context
    
    case $sign in
        "Aries ♈")
            echo "🐏 **Aries Energy**: Your code charges forward with ram-like determination. You initiate projects fearlessly, though you may need to revisit your first drafts. Your debugging style involves direct confrontation with errors - you don't back down from a challenge."
            ;;
        "Taurus ♉")
            echo "🐂 **Taurus Foundation**: You build digital foundations that last for millennia. Your preference for stable, tested technologies reflects your earth sign nature. Others may rush to new frameworks, but your methodical approach creates unshakeable systems."
            ;;
        "Gemini ♊")
            echo "👥 **Gemini Duality**: Your dual nature masters both frontend and backend realms effortlessly. You speak multiple programming languages as naturally as breathing, adapting your communication style for each project's unique personality."
            ;;
        "Cancer ♋")
            echo "🦀 **Cancer Nurturing**: You code with the protective instincts of a devoted parent. Your applications are safe havens, with thorough error handling and user-friendly interfaces that cradle users through complex processes."
            ;;
        "Leo ♌")
            echo "🦁 **Leo Majesty**: Your code has the regal bearing of a lion. You create applications that command attention and respect. Your architecture is bold, your user interfaces radiate confidence, and your commit messages declare your royal presence."
            ;;
        "Virgo ♍")
            echo "🌾 **Virgo Precision**: Every semicolon in your code serves a purpose. Your attention to detail borders on the mystical - bugs flee before your systematic analysis. You refactor with surgical precision, improving efficiency one line at a time."
            ;;
        "Libra ♎")
            echo "⚖️ **Libra Balance**: You seek harmony in all your code structures. Your APIs are perfectly balanced, your UI elements align in pleasing symmetry, and your team collaborations create beautiful consensus rather than conflict."
            ;;
        "Scorpio ♏")
            echo "🦂 **Scorpio Intensity**: You dive deep into the mysteries of complex systems. Your debugging sessions are archaeological expeditions into forgotten code. You're drawn to security, cryptography, and the hidden depths of system architecture."
            ;;
        "Sagittarius ♐")
            echo "🏹 **Sagittarius Adventure**: Your code travels across platforms and languages with adventurous spirit. You're the team member who suggests bold new approaches and isn't afraid to experiment with bleeding-edge technologies."
            ;;
        "Capricorn ♑")
            echo "🐐 **Capricorn Ambition**: You climb the mountain of technical challenges with steady determination. Your long-term vision shapes robust, scalable systems that grow more valuable over time. Leadership flows naturally from your reliable excellence."
            ;;
        "Aquarius ♒")
            echo "🏺 **Aquarius Innovation**: You pour forth revolutionary ideas that reshape how others think about code. Your solutions are wonderfully weird and surprisingly brilliant, challenging conventions with humanitarian purpose."
            ;;
        "Pisces ♓")
            echo "🐟 **Pisces Intuition**: Your intuitive understanding of user needs flows through every interface you create. You sense the emotional undercurrents in team dynamics and write code that feels empathetic and deeply human."
            ;;
        *)
            echo "✨ **Cosmic Mystery**: The stars haven't yet revealed your coding constellation. Your programming destiny remains beautifully undefined, full of infinite potential."
            ;;
    esac
}

# Determine astrological sign from GitHub activity
get_github_astrological_sign() {
    local username="$1"
    
    # Try to get the creation date of the first repository or account
    # This is a simplified approach using available data
    local current_month=$(date +%-m)
    local first_commit_month=${current_month}  # Placeholder - would be extracted from actual first commit
    
    # Use current date if no specific data available
    local day=15  # Use middle of month as default
    
    get_astrological_sign "$first_commit_month" "$day"
}

# Get planetary influence from most active month
get_planetary_influence() {
    local most_active_month="$1"
    
    case $most_active_month in
        1|"January") echo "🪐 **Saturn's Discipline** guides your winter coding sessions with methodical precision." ;;
        2|"February") echo "💫 **Venus's Creativity** infuses your code with beauty and elegant solutions." ;;
        3|"March") echo "♂️ **Mars's Energy** drives your aggressive debugging and fearless feature implementation." ;;
        4|"April") echo "🌱 **Venus's Growth** nurtures your spring projects with fresh, innovative approaches." ;;
        5|"May") echo "☿ **Mercury's Communication** enhances your documentation and team collaboration." ;;
        6|"June") echo "🌙 **Luna's Intuition** guides your user experience decisions with empathetic insight." ;;
        7|"July") echo "☀️ **Sol's Confidence** illuminates your leadership in summer development cycles." ;;
        8|"August") echo "🦁 **Leo's Pride** manifests in code architecture that commands respect and admiration." ;;
        9|"September") echo "🌾 **Virgo's Detail** brings methodical organization to your autumn refactoring." ;;
        10|"October") echo "⚖️ **Libra's Balance** harmonizes your team dynamics and code symmetry." ;;
        11|"November") echo "🦂 **Scorpio's Depth** drives your exploration of complex system architecture." ;;
        12|"December") echo "🏹 **Sagittarius's Vision** expands your projects toward ambitious new horizons." ;;
        *) echo "🌟 **Cosmic Forces** weave mysterious patterns through your coding journey." ;;
    esac
}

# Get current moon phase (simplified calculation)
get_moon_phase() {
    # Simplified moon phase calculation based on date
    local days_since_new_moon=$(( ($(date +%s) / 86400) % 30 ))
    
    if [[ $days_since_new_moon -lt 2 ]]; then
        echo "new"
    elif [[ $days_since_new_moon -lt 7 ]]; then
        echo "waxing"
    elif [[ $days_since_new_moon -lt 9 ]]; then
        echo "first"
    elif [[ $days_since_new_moon -lt 14 ]]; then
        echo "waxing_gib"
    elif [[ $days_since_new_moon -lt 16 ]]; then
        echo "full"
    elif [[ $days_since_new_moon -lt 21 ]]; then
        echo "waning_gib"
    elif [[ $days_since_new_moon -lt 23 ]]; then
        echo "last"
    else
        echo "waning"
    fi
}

# Generate the complete horoscope
generate_horoscope() {
    local username="$1"
    local verbose="$2"
    
    # Clear the screen but preserve header by redisplaying it
    clear
    display_header
    echo
    
    # Get current date and time for mystical calculations
    local current_date=$(date '+%B %d, %Y')
    local current_time=$(date '+%H:%M')
    
    display_mystical_divider
    display_mystical_quote "The GitHub stars have aligned... Your coding destiny unfolds..."
    
    # User introduction
    local user_name=$(get_user_info "name")
    local user_location=$(get_user_info "location")
    local user_bio=$(get_user_info "bio")
    local followers=$(get_user_info "followers")
    local following=$(get_user_info "following")
    local public_repos=$(get_user_info "public_repos")
    
    display_section_header "🎭 DIGITAL IDENTITY READING" "👤"
    
    if [[ "$user_name" != "N/A" && "$user_name" != "$username" ]]; then
        echo "    ✨ Known in the mortal realm as: $user_name"
    fi
    echo -e "    🏷️  GitHub handle: ${YELLOW}@$username${RESET}"
    if [[ "$user_location" != "N/A" ]]; then
        echo "    🌍 Coding from: $user_location"
    fi
    if [[ "$user_bio" != "N/A" ]]; then
        echo "    📜 Spiritual motto: \"$user_bio\""
    fi
    echo -e "    👥 ${BLUE}$followers${RESET} souls follow your journey, you follow ${BLUE}$following${RESET} paths"
    echo -e "    🏛️  ${GREEN}$public_repos repositories${RESET} hold your digital legacy"
    echo
    
    # Language-based horoscope
    local primary_language=$(get_primary_language)
    display_section_header "💻 LANGUAGE OF THE SOUL" "🗣️"
    
    if [[ -n "${LANGUAGE_HOROSCOPES[$primary_language]}" ]]; then
        display_horoscope_section "Your Primary Language Speaks" "${LANGUAGE_HOROSCOPES[$primary_language]}" "🔮"
    else
        display_horoscope_section "Universal Code Wisdom" "Your coding spirit transcends single languages, embracing the polyglot path of eternal learning. 🌟" "🔮"
    fi
    
    # Commit pattern analysis
    display_section_header "⏰ TEMPORAL CODING PATTERNS" "🕐"
    
    local night_owl_score=$(get_night_owl_score)
    local weekend_score=$(get_weekend_warrior_score)
    
    display_horoscope_section "Night Owl Reading ($night_owl_score% nocturnal)" "$(get_night_owl_wisdom $night_owl_score)" "🦉"
    display_horoscope_section "Weekend Warrior Analysis ($weekend_score% weekend commits)" "$(get_weekend_warrior_wisdom $weekend_score)" "⚔️"
    
    # Commit message analysis
    if [[ ${#COMMIT_MESSAGES[@]} -gt 0 ]]; then
        display_section_header "📝 COMMIT MESSAGE DIVINATION" "✍️"
        local message_style=$(analyze_commit_messages "${COMMIT_MESSAGES[@]}")
        display_horoscope_section "Your Commit Voice Reveals" "$(get_commit_message_wisdom "$message_style")" "💬"
    fi
    
    # Repository personality
    display_section_header "🏛️ REPOSITORY CONSTELLATION" "📚"
    
    local commitment_level=$(get_commitment_level)
    local diversity_score=$(get_repo_diversity_score)
    local emoji_personality=$(get_emoji_personality)
    
    display_horoscope_section "Commitment Level: $commitment_level" "$(get_diversity_wisdom $diversity_score)" "📊"
    display_horoscope_section "Communication Style" "$emoji_personality - Your emoji usage reveals the windows to your coding soul." "🎭"
    
    # GitHub karma
    display_section_header "⚖️  GITHUB KARMA BALANCE" "🌟"
    local total_karma=$((ISSUE_KARMA + PR_KARMA))
    display_horoscope_section "Cosmic Contribution Score: $total_karma" "$(get_karma_wisdom $total_karma)" "✨"
    
    # Daily and mystical predictions
    display_section_header "🔮 MYSTICAL PREDICTIONS" "🌙"
    
    display_horoscope_section "Today's Coding Fortune" "$(get_daily_prediction)" "📅"
    display_horoscope_section "Personal Code Prophecy" "$(get_mystical_prediction "$username" "$primary_language")" "🎯"
    display_horoscope_section "Seasonal Wisdom" "$(get_seasonal_wisdom)" "🍃"
    
    # Moon phase and coffee fortune
    local moon_phase=$(get_moon_phase)
    display_horoscope_section "Lunar Coding Humor" "$(get_moon_phase_joke "$moon_phase")" "$(display_moon_phase "$moon_phase")"
    display_horoscope_section "Coffee Oracle Prediction" "$(get_coffee_fortune $TOTAL_COMMITS $night_owl_score)" "☕"
    
    # Lucky numbers
    display_section_header "🎰 MYSTICAL NUMBERS" "🔢"
    local lucky_nums=$(generate_lucky_numbers "$TOTAL_COMMITS" "$public_repos" "$followers")
    echo "    🍀 Your GitHub Lucky Numbers: $lucky_nums"
    echo "    📊 Sacred Statistics: $TOTAL_COMMITS commits • $public_repos repos • $followers followers"
    echo
    
    # Zen wisdom
    display_section_header "🧘 ZEN WISDOM FOR THE CODER'S SOUL" "☯️"
    display_mystical_quote "$(get_zen_wisdom)"
    
    # New mystical sections
    display_section_header "🎭 DEVELOPER ARCHETYPE REVEALED" "🎪"
    local archetype=$(analyze_developer_archetype "$username" "$ALL_COMMIT_MESSAGES" "$NIGHT_OWL_PERCENTAGE" "$WEEKEND_PERCENTAGE" "$REPO_COUNT")
    display_mystical_insight "🧙‍♂️ Your Coding Spirit" "${DEVELOPER_ARCHETYPES[$archetype]}"
    
    # Astrological coding constellation
    display_section_header "✨ ASTROLOGICAL CODING CONSTELLATION" "♈"
    local coding_sign=$(get_github_astrological_sign "$username")
    local current_month=$(date +%-m)
    local planetary_influence=$(get_planetary_influence "$current_month")
    local astrological_insight=$(get_astrological_insight "$coding_sign" "coding_context")
    
    display_mystical_insight "🌟 Your Coding Constellation: $coding_sign" "$astrological_insight"
    display_mystical_insight "🪐 Current Planetary Influence" "$planetary_influence"
    
    display_section_header "📜 COMMIT MESSAGE MYSTIQUE" "🔮"
    local mystique=$(analyze_commit_mystique "$ALL_COMMIT_MESSAGES")
    display_mystical_insight "📝 Your Message Magic" "${COMMIT_MYSTIQUE[$mystique]}"
    
    display_section_header "⚡ ELEMENTAL CODING NATURE" "🌊"
    local element=$(determine_coding_element "${PRIMARY_LANGUAGES[*]}" "normal" "standard")
    display_mystical_insight "🔥 Your Code Element" "$(get_coding_element "${PRIMARY_LANGUAGES[*]}" "normal" "standard")"
    
    # Advanced psychological analysis
    display_section_header "🧠 PSYCHOLOGICAL CODE ANALYSIS" "🔬"
    local stress_level=$(detect_stress_patterns "${COMMIT_MESSAGES[@]}")
    local confidence_pattern=$(detect_confidence_patterns "${COMMIT_MESSAGES[@]}")
    local perfectionist_score=$(analyze_perfectionist_patterns "${COMMIT_MESSAGES[@]}")
    local wip_count=$(detect_wip_patterns "${COMMIT_MESSAGES[@]}")
    local crisis_count=$(detect_crisis_patterns "${COMMIT_MESSAGES[@]}")
    local emotional_analysis=$(analyze_emotional_patterns "${COMMIT_MESSAGES[@]}")
    
    local psychological_insight=""
    if [[ $stress_level -gt 30 ]]; then
        psychological_insight="🔥 **High Stress Coder**: Your commit messages reveal $stress_level% stress indicators. "
    elif [[ $stress_level -gt 15 ]]; then
        psychological_insight="⚖️ **Balanced Pressure**: You handle coding pressure with $stress_level% stress markers. "
    else
        psychological_insight="🧘 **Zen Coder**: Your peaceful commits show only $stress_level% stress patterns. "
    fi
    
    case $confidence_pattern in
        "confident") psychological_insight+="Your messages radiate confidence and decisive action. " ;;
        "uncertain") psychological_insight+="Your humble uncertainty shows wisdom and learning mindset. " ;;
        "balanced") psychological_insight+="You balance confidence with appropriate caution. " ;;
    esac
    
    if [[ $perfectionist_score -gt 5 ]]; then
        psychological_insight+="Strong perfectionist tendencies drive your code quality (${perfectionist_score} refinement commits)."
    elif [[ $wip_count -gt 3 ]]; then
        psychological_insight+="Your iterative approach shows comfort with work-in-progress states (${wip_count} WIP commits)."
    else
        psychological_insight+="You maintain healthy balance between iteration and completion."
    fi
    
    display_mystical_insight "🔬 Your Coding Psychology" "$psychological_insight"
    
    display_section_header "🔮 BUG PROPHECY & FUTURE VISIONS" "⚡"
    display_mystical_insight "🪄 The Oracle Speaks" "$(get_bug_prophecy "$TOTAL_COMMITS" "5" "$WEEKEND_PERCENTAGE")"
    
    display_section_header "⏰ TIME MAGIC & CODING RHYTHMS" "🌀"
    display_mystical_insight "🕰️ Temporal Mysteries" "$(get_time_magic)"
    
    # Analyze collaboration spirit
    analyze_collaboration_depth "$username"
    display_section_header "🤝 COLLABORATION CONSTELLATION" "🌟"
    display_mystical_insight "👥 Your Social Code" "$(get_collaboration_spirit "$PR_REVIEW_COUNT" "$ISSUE_PARTICIPATION" "$COLLAB_PROJECTS")"
    
    # Repository zodiac
    if [[ ${#REPO_LANGUAGES[@]} -gt 0 ]]; then
        display_section_header "♈ REPOSITORY ZODIAC SIGNS" "🔯"
        local repo_count=0
        for repo in "${!REPO_LANGUAGES[@]}"; do
            if [[ $repo_count -ge 3 ]]; then break; fi
            local zodiac_sign=$(assign_repo_zodiac "$repo" "2020-01-01" "10" "5" "${REPO_LANGUAGES[$repo]}")
            display_mystical_insight "📁 $repo" "${REPO_ZODIAC_SIGNS[$zodiac_sign]}"
            ((repo_count++))
        done
    fi

    # Verbose debug information
    if [[ "$verbose" == "true" ]]; then
        display_section_header "🔍 DETAILED ANALYSIS (DEBUG MODE)" "🔬"
        show_analysis_debug
    fi
    
    # Final constellation display
    echo
    display_constellation
    echo
    display_mystical_quote         "Go forth and commit with purpose, for the universe compiles your destiny!"
}