#!/bin/bash

# Celebrity Developer Comparison module for GitHub CLI Horoscope Extension
# Compare your coding patterns with famous developers

# Wrap text for better terminal display
wrap_celebrity_text() {
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

# Famous developer profiles for comparison
declare -A CELEBRITY_DEVELOPERS

# Tech titans and their "mystical" characteristics
CELEBRITY_DEVELOPERS[torvalds]="🐧 **Linus Torvalds - The Kernel King** 
Primary Language: C (speaks directly to the machine's soul)
Coding Style: Brutally honest code reviews, efficient solutions
Archetype: The System Architecture Oracle
Known For: Creating Linux kernel and Git - basically, your computer's deity
Mystical Trait: Can debug kernel panics through pure willpower and Finnish determination
Quote: 'Talk is cheap. Show me the code.' ⚡"

CELEBRITY_DEVELOPERS[gvanrossum]="🐍**Guido van Rossum - The Python BDFL** 
Primary Language: Python (obviously)
Coding Style: Elegant, readable, Pythonic zen
Archetype: The Language Design Philosopher  
Known For: Creating Python - making programming accessible to mortals
Mystical Trait: Can make code so readable that non-programmers think they understand it
Quote: 'Beautiful is better than ugly. Explicit is better than implicit.' ✨"

CELEBRITY_DEVELOPERS[bradfitz]="⚡**Brad Fitzpatrick - The Performance Wizard**
Primary Language: Go (with occasional C magic)
Coding Style: Performance-obsessed, scalable solutions
Archetype: The Concurrency Conjurer
Known For: LiveJournal, memcached, Go contributions
Mystical Trait: Can optimize code so well it travels backwards in time
Quote: 'Make it work, make it right, make it fast.' 🚀"

CELEBRITY_DEVELOPERS[dhh]="💎**David Heinemeier Hansson - The Rails Revolutionary**
Primary Language: Ruby (with strong opinions)
Coding Style: Convention over configuration, developer happiness
Archetype: The Framework Freedom Fighter
Known For: Ruby on Rails, Basecamp, strong developer advocacy
Mystical Trait: Can create web applications that make developers weep with joy
Quote: 'Optimize for programmer happiness.' 😊"

CELEBRITY_DEVELOPERS[facebook]="📘**Meta/Facebook Engineering - The Scale Masters**
Primary Language: PHP/Hack/React (at massive scale)
Coding Style: Move fast, scale everything, A/B test reality
Archetype: The Billion-User Architects
Known For: Facebook, React, scaling to billions of users
Mystical Trait: Can handle more simultaneous users than there are thoughts in your head
Quote: 'Move fast and break things... then fix them at scale.' 📊"

CELEBRITY_DEVELOPERS[google]="🔍**Google Engineering - The Search Sages**
Primary Language: C++/Go/Python/Java (everything)
Coding Style: Algorithmic excellence, data-driven decisions
Archetype: The Information Organization Oracle
Known For: Search, Android, Chrome, making the world's information accessible
Mystical Trait: Can find any information in nanoseconds, including information you didn't know you needed
Quote: 'Focus on the user and all else will follow.' 🎯"

CELEBRITY_DEVELOPERS[rsc]="🔧**Russ Cox - The Go Guru**
Primary Language: Go (with deep systems knowledge)
Coding Style: Clear, efficient, well-documented systems code
Archetype: The Language Evolution Guide
Known For: Go development, Plan 9, systems programming excellence
Mystical Trait: Can make complex systems seem simple and elegant
Quote: 'Simplicity is the ultimate sophistication.' 🌟"

CELEBRITY_DEVELOPERS[antirez]="⚡**Salvatore Sanfilippo - The Redis Virtuoso**
Primary Language: C (with artistic flair)
Coding Style: Artistic code, performance poetry
Archetype: The Data Structure Artist
Known For: Redis, creative problem solving
Mystical Trait: Can turn data structures into performance art
Quote: 'Code is poetry written by developers for other developers.' 🎨"

CELEBRITY_DEVELOPERS[acolyer]="📚**Adrian Colyer - The Paper Prophet**
Primary Language: Research (translating papers to practice)
Coding Style: Research-driven, evidence-based development
Archetype: The Academic Bridge Builder
Known For: The Morning Paper, bridging academia and industry
Mystical Trait: Can distill complex research papers into actionable developer wisdom
Quote: 'There are no new ideas, just ideas whose time has come.' 🔬"

CELEBRITY_DEVELOPERS[spolsky]="🏢**Joel Spolsky - The Developer Advocate**
Primary Language: Varies (more about principles than syntax)
Coding Style: Human-centered, developer-friendly processes
Archetype: The Developer Experience Prophet
Known For: Joel on Software, Stack Overflow, developer advocacy
Mystical Trait: Can make complex business decisions feel like common sense
Quote: 'Good software takes time. Great software takes even longer.' ⏳"

# Comparison algorithm
compare_with_celebrity() {
    local username="$1"
    local celebrity="$2"
    local user_night_pct="${NIGHT_OWL_PERCENTAGE:-30}"
    local user_weekend_pct="${WEEKEND_PERCENTAGE:-20}"
    local user_total_commits="${TOTAL_COMMITS:-50}"
    local user_primary_lang="${PRIMARY_LANGUAGES[0]:-JavaScript}"
    local user_archetype=$(analyze_developer_archetype "$username" "${COMMIT_MESSAGES[*]}" "$user_night_pct" "$user_weekend_pct" "${REPO_COUNT:-5}")
    
    # Calculate similarity scores
    local compatibility_score=0
    local comparison_text=""
    
    case $celebrity in
        "torvalds")
            if [[ "$user_primary_lang" =~ (C|C\+\+|Rust|Assembly) ]]; then
                compatibility_score=$((compatibility_score + 25))
                comparison_text+="🔧 **System Language Kinship**: You share Linus's love for languages that speak directly to the machine. "
            fi
            if [[ "$user_archetype" =~ (Perfectionist|System|Architecture) ]]; then
                compatibility_score=$((compatibility_score + 20))
                comparison_text+="🎯 **Architectural Mindset**: Like Linus, you think about systems and architecture. "
            fi
            if [[ $user_total_commits -gt 1000 ]]; then
                compatibility_score=$((compatibility_score + 15))
                comparison_text+="💪 **Prolific Coder**: Your commit count rivals the dedication of kernel maintainers. "
            fi
            comparison_text+="🐧   **Linux Compatibility Score: $compatibility_score/100**"
            ;;
        "gvanrossum")
            if [[ "$user_primary_lang" =~ (Python) ]]; then
                compatibility_score=$((compatibility_score + 30))
                comparison_text+="🐍 **Pythonic Soul**: You speak the language of readability and elegance. "
            fi
            if [[ "$user_archetype" =~ (Perfectionist|Code_Poet|Documentation) ]]; then
                compatibility_score=$((compatibility_score + 25))
                comparison_text+="📖 **Readable Code Philosophy**: Like Guido, you believe code should be beautiful.   "
            fi
            if [[ $user_weekend_pct -lt 30 && $user_night_pct -lt 40 ]]; then
                compatibility_score=$((compatibility_score + 20))
                comparison_text+="⚖️ **Work-Life Balance**: You understand the Dutch approach to sustainable development.   "
            fi
            comparison_text+="🐍 **Python BDFL Compatibility Score: $compatibility_score/100**"
            ;;
        "dhh")
            if [[ "$user_primary_lang" =~ (Ruby) ]]; then
                compatibility_score=$((compatibility_score + 30))
                comparison_text+="💎 **Ruby Affinity**: You share DHH's love for developer happiness through elegant syntax. "
            fi
            if [[ "$user_archetype" =~ (Framework_Druid|Indie_Hacker|Startup_Hustler) ]]; then
                compatibility_score=$((compatibility_score + 25))
                comparison_text+="🚀 **Framework Thinking**: Like DHH, you understand that convention over configuration liberates creativity. "
            fi
            if [[ "${COMMIT_MESSAGES[*]}" =~ (convention|config|rails|framework) ]]; then
                compatibility_score=$((compatibility_score + 15))
                comparison_text+="🛤️ **Rails Philosophy**: Your commits show understanding of opinionated framework design. "
            fi
            comparison_text+="💎 **Rails Revolutionary Compatibility Score: $compatibility_score/100**"
            ;;
        *)
            # Generic celebrity comparison
            compatibility_score=$((50 + ($RANDOM % 30)))
            comparison_text="🎭 **Celebrity Developer Comparison**: Your coding patterns show $compatibility_score% alignment with $celebrity's legendary style!"
            ;;
    esac
    
    echo "$comparison_text"
}

# Get celebrity developer info
get_celebrity_info() {
    local celebrity="$1"
    if [[ -n "${CELEBRITY_DEVELOPERS[$celebrity]}" ]]; then
        echo "${CELEBRITY_DEVELOPERS[$celebrity]}"
    else
        echo "🤷‍♂️ **Unknown Celebrity**: This developer is either too legendary for our database or too underground for mainstream recognition!"
    fi
}

# Find your celebrity coding doppelganger
find_coding_doppelganger() {
    local username="$1"
    local user_night_pct="${NIGHT_OWL_PERCENTAGE:-30}"
    local user_weekend_pct="${WEEKEND_PERCENTAGE:-20}"
    local user_primary_lang="${PRIMARY_LANGUAGES[0]:-JavaScript}"
    local user_archetype=$(analyze_developer_archetype "$username" "${COMMIT_MESSAGES[*]}" "$user_night_pct" "$user_weekend_pct" "${REPO_COUNT:-5}")
    
    local best_match="torvalds"
    local best_score=0
    
    # Simple doppelganger logic based on primary language and archetype
    if [[ "$user_primary_lang" =~ (Python) ]]; then
        best_match="gvanrossum"
        best_score=75
    elif [[ "$user_primary_lang" =~ (Ruby) ]]; then
        best_match="dhh"  
        best_score=70
    elif [[ "$user_primary_lang" =~ (C|C\+\+|Rust) ]]; then
        best_match="torvalds"
        best_score=65
    elif [[ "$user_primary_lang" =~ (Go) ]]; then
        if [[ $((RANDOM % 2)) -eq 0 ]]; then
            best_match="bradfitz"
        else
            best_match="rsc"
        fi
        best_score=80
    elif [[ "$user_archetype" =~ (Performance|Optimization) ]]; then
        best_match="bradfitz"
        best_score=70
    elif [[ "$user_archetype" =~ (Data|Database) ]]; then
        best_match="antirez"
        best_score=65
    else
        # Random selection for variety
        local celebrities=("torvalds" "gvanrossum" "dhh" "bradfitz" "rsc")
        best_match="${celebrities[$((RANDOM % ${#celebrities[@]}))]}"
        best_score=$((60 + ($((RANDOM % 20)))))
    fi
    
    echo "$best_match:$best_score"
}

# Celebrity comparison display
display_celebrity_comparison() {
    local username="$1"
    local celebrity="$2"

    echo 
    echo "                     🌟 ✨ 🌟 ✨ **CELEBRITY DEVELOPER COMPARISON** ✨ 🌟 ✨ 🌟"
    echo
    echo "                    📊 **Comparing @$username with legendary developer $celebrity**"
    echo -e "\n"

    # Show celebrity info with elegant header and bullet points
    echo -e "\n"
    echo -e "${CYAN}${BOLD}"
    echo "    👑 **CELEBRITY PROFILE** 👑"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    
    # Display celebrity info with bullet points and spacing
    local celebrity_info=$(get_celebrity_info "$celebrity")
    echo "$celebrity_info" | while IFS= read -r line; do
        wrap_celebrity_text "$line"
    done
    echo -e "${RESET}"

    # Show comparison analysis with elegant header and bullet points
    echo -e "\n"
    echo -e "${CYAN}${BOLD}"
    echo "    🔍 **COMPARISON ANALYSIS** 🔍"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"

    # Display comparison with bullet points and spacing
    local comparison=$(compare_with_celebrity "$username" "$celebrity")
    echo "$comparison" | while IFS= read -r line; do
        wrap_celebrity_text "$line"
    done
    echo -e "${RESET}"
    echo
}

# Find and display coding doppelganger
display_coding_doppelganger() {
    local username="$1"

    echo "                                          🔍 **Scanning the celebrity developer database...**"
    echo "                                               📡 **Analyzing your coding DNA...**"
    sleep 1
    echo "                                           🧬 **Cross-referencing with legendary patterns...**"
    echo -e "\n"
    sleep 1
    echo

    local result=$(find_coding_doppelganger "$username")
    local celebrity=$(echo "$result" | cut -d':' -f1)
    local score=$(echo "$result" | cut -d':' -f2)

    echo "                                          🎉 **MATCH FOUND!** 🎉"
    echo -e "\n"
    echo -e "${CYAN}${BOLD}"
    echo "    🎭 **YOUR CODING DOPPELGANGER** 🎭"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"

    # Display doppelganger result with bullet point
    local doppelganger_msg="**@$username**, you are ${score}% similar to **$celebrity**!"
    echo "    • $doppelganger_msg"
    echo -e "${RESET}"
    echo -e "\n"

    display_celebrity_comparison "$username" "$celebrity"
}

# Calculate visual width of text (accounting for emojis)
calculate_visual_width() {
    local text="$1"
    local emoji_count=$(echo "$text" | grep -o "🔮\|🐧\|🐍\|💎\|⚡\|💼\|🔍\|🔧\|🛠️\|🏛️\|🚀\|🌟\|📚\|🎓\|👥\|🤝\|🔥\|🧘\|👤\|💪\|⚙️\|🗿\|📿\|🕯️\|⚱️\|🌱\|😌\|⚖️\|🌸\|🦋\|🦁\|💎\|⭐\|🔮\|🌙\|💫\|🌠\|☄️\|📊\|📈\|🔍\|🚀\|💻\|🌐\|📡\|🎨\|🧠\|💡\|🔬\|📖\|✨\|🌉\|🤗\|💬\|🎭\|🔄\|😊\|🛤️\|🌺\|🤝\|🌿\|💚\|🕊️\|❄️\|🎯\|🏢\|⏳\|🎯\|📜\|🃏\|👑\|🔥\|💝\|🏛️\|🚪\|🏆\|🌶️\|👁️\|🎴\|👯\|🤝\|🌍\|❄️\|🎯\|📘\|📡\|🎉\|🧬\|🎭\|🔬\|🌟\|✨\|📊\|👑\|🤷‍♂️\|🧘\|🛤️\|🕊️\|❄️\|🎯\|🏢\|⏳\|🎯\|📜\|🃏\|👑\|🔥\|💝\|🏛️\|🚪\|🏆\|🌶️\|👁️\|🎴\|👯\|🤝\|🌍\|❄️\|🎯" | wc -l)
    echo $(( ${#text} + emoji_count ))
}