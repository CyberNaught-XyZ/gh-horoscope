#!/bin/bash

# Tarot System module for GitHub CLI Horoscope Extension
# Full programming-themed tarot deck with mystical readings

# Wrap text for better terminal display
wrap_tarot_text() {
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

# Programming Tarot Deck - Major Arcana
declare -A PROGRAMMING_TAROT

# Major Arcana (22 cards)
PROGRAMMING_TAROT[0_The_Programmer]="🃏 **The Programmer (The Fool)** - New project adventures await! You stand at the precipice of infinite possibility, your IDE open, cursor blinking with potential. Like the Fool, you leap into unknown codebases with faith that your skills will guide you. Embrace beginner's mind."

PROGRAMMING_TAROT[1_The_Stack_Overflow]="🎩 **The Stack Overflow (The Magician)** - Master of external knowledge! You have learned to channel the collective wisdom of millions of developers. Your power comes not from memorizing every API, but from knowing how to ask the right questions and adapt solutions to your needs."

PROGRAMMING_TAROT[2_The_Documentation]="📚 **The Documentation (The High Priestess)** - Hidden knowledge revealed! The answers you seek lie not in frantic googling, but in the patient study of official documentation. Trust in the wisdom of those who built the tools you wield."

PROGRAMMING_TAROT[3_The_Senior_Dev]="👑 **The Senior Dev (The Emperor)** - Authority through experience! Your word carries weight in code reviews, your architecture decisions shape entire systems. With great power comes great responsibility to mentor those who follow your path."

PROGRAMMING_TAROT[4_The_Tech_Lead]="🏛️ **The Tech Lead (The Hierophant)** - Keeper of team knowledge! You bridge the gap between individual brilliance and collective success. Your role is to teach, to standardize, and to ensure that wisdom is shared across your digital congregation."

PROGRAMMING_TAROT[5_The_Pair_Programming]="💕 **The Pair Programming (The Lovers)** - Perfect code harmony! Two minds, one keyboard, infinite possibilities. This card speaks of collaboration so deep that bugs flee before your combined intellect. Choose your coding partner wisely."

PROGRAMMING_TAROT[6_The_Git_Merge]="🚗 **The Git Merge (The Chariot)** - Control through determination! Multiple branches of development converge under your skilled direction. Victory comes through mastering the tools of version control and maintaining focus despite conflicting changes."

PROGRAMMING_TAROT[7_The_Code_Review]="⚖️ **The Code Review (Justice)** - Balance and judgment! Your PR stands before the scales of quality, maintainability, and performance. Truth emerges through honest feedback and the courage to refactor when necessary."

PROGRAMMING_TAROT[8_The_Debugging]="🔍 **The Debugging (The Hermit)** - Solo introspection required! Sometimes the path to truth winds through dark forests of stack traces and mysterious errors. Take your debugging lantern and venture alone into the depths of your code."

PROGRAMMING_TAROT[9_The_CI_CD]="⚙️ **The CI/CD (Wheel of Fortune)** - Automated destiny turns! Your pipeline spins with tests, builds, and deployments. Sometimes green, sometimes red, but always teaching you about the cyclical nature of software development."

PROGRAMMING_TAROT[10_The_Load_Balancer]="💪 **The Load Balancer (Strength)** - Power through distribution! True strength comes not from one mighty server, but from gracefully distributing load across many. Tame the beast of traffic through gentle redirection."

PROGRAMMING_TAROT[11_The_Technical_Debt]="🙃 **The Technical Debt (The Hanged Man)** - Perspective through sacrifice! Sometimes you must accept temporary inefficiency for the greater good of shipping. View your shortcuts from a different angle - they may teach valuable lessons."

PROGRAMMING_TAROT[12_The_Legacy_Code]="💀 **The Legacy Code (Death)** - Transformation is inevitable! Fear not the ancient codebase, for within its demise lies the seed of modern architecture. What dies makes room for something better to grow."

PROGRAMMING_TAROT[13_The_Refactoring]="🔄 **The Refactoring (Temperance)** - Balance through gradual change! Like water slowly carving canyons, patient refactoring transforms monoliths into elegant architectures. Blend old wisdom with new techniques."

PROGRAMMING_TAROT[14_The_Production_Bug]="😈 **The Production Bug (The Devil)** - Bound by poor decisions! The shortcuts you took in development now chain you to midnight debugging sessions. Freedom comes through facing your technical debt honestly."

PROGRAMMING_TAROT[15_The_System_Crash]="🏗️ **The System Crash (The Tower)** - Sudden upheaval! Your perfectly crafted architecture crumbles under unexpected load. From the rubble, you'll build something stronger. Disaster teaches what stability cannot."

PROGRAMMING_TAROT[16_The_Open_Source]="⭐ **The Open Source (The Star)** - Hope and inspiration flow freely! Your code shines like a beacon, guiding other developers toward elegant solutions. Share your light, and it multiplies across the community."

PROGRAMMING_TAROT[17_The_Moonlighting]="🌙 **The Moonlighting (The Moon)** - Illusion and side projects! What seems like a simple weekend project reveals hidden complexities. Trust your instincts, but prepare for more scope creep than you expect."

PROGRAMMING_TAROT[18_The_Code_Quality]="☀️ **The Code Quality (The Sun)** - Pure joy in clean code! Your functions sing with clarity, your variables dance with meaning. This is the happiness that comes from craft mastered and pride in workmanship."

PROGRAMMING_TAROT[19_The_Code_Review_Response]="🎺 **The Code Review Response (Judgement)** - Your code is called to account! The time has come to defend your architectural choices and explain your naming conventions. Rise to meet constructive criticism with grace."

PROGRAMMING_TAROT[20_The_Production_Deploy]="🌍 **The Production Deploy (The World)** - Completion and fulfillment! Your code has traveled from local development through testing to live in the real world, serving real users. The cycle is complete, but new cycles await."

PROGRAMMING_TAROT[21_The_Debug_Serenity]="🧘 **The Debug Serenity (The Empress)** - Calm through breakpoints. You nurture failing tests back to health with patience, unit tests, and strategic console.log therapy. Growth happens when you scaffold the fragile parts of your system."

PROGRAMMING_TAROT[22_The_Refactor_Ritual]="🔧 **The Refactor Ritual (The Hermit Revisited)** - Quiet wisdom guides your tidy changes. Small, well-tested refactors are like pruning a bonsai: the aesthetic emerges over many careful cuts."

PROGRAMMING_TAROT[23_The_AdHoc_Solution]="🩹 **The Ad-Hoc Solution (The Fool's Bandage)** - Quick fixes applied in crisis. Sometimes necessary, rarely elegant. Remember to record your battlefield medicine in task trackers so peace can follow."

PROGRAMMING_TAROT[24_The_Monitoring_Oracle]="📈 **The Monitoring Oracle (The Seer)** - Logs, metrics, traces — the stars of your system. When alarms sing, listen to their melody; they often tell you where the architecture aches."

PROGRAMMING_TAROT[25_The_Refinement_Circle]="🔁 **The Refinement Circle (The Wheel of Improvement)** - Iteration is not failure; it is craft. Release, learn, polish, repeat. Your small feedback loops compound into major breakthroughs."

# Programming-themed Minor Arcana suits
PROGRAMMING_TAROT[Ace_of_Commits]="🌱 **Ace of Commits** - The seed of a new repository! A fresh start, an empty main branch waiting for your first commit. Pure potential crystallized into git init. The beginning of something beautiful."

PROGRAMMING_TAROT[Two_of_Commits]="⚖️ **Two of Commits** - Choosing between approaches! Two different solutions present themselves. Your decision here will shape the entire architecture. Consider maintainability over cleverness."

PROGRAMMING_TAROT[Three_of_Commits]="👥 **Three of Commits** - Collaborative creativity! Multiple developers contribute to a shared vision. Your individual commits become part of something larger than yourself. Teamwork makes the dream work."

PROGRAMMING_TAROT[Ace_of_Bugs]="🐛 **Ace of Bugs** - A new challenge emerges! What appears to be a simple bug may reveal deeper architectural issues. Sometimes the smallest error teaches the biggest lessons about system design."

PROGRAMMING_TAROT[King_of_Frameworks]="👑 **King of Frameworks** - Mastery of tools! You wield React, Angular, Vue with equal skill. Your framework knowledge is vast, but remember: tools serve the solution, not the reverse."

PROGRAMMING_TAROT[Queen_of_APIs]="👸 **Queen of APIs** - Elegant interface design! Your endpoints flow like poetry, your documentation reads like love letters to future developers. You understand that good APIs are gifts to humanity."

PROGRAMMING_TAROT[Knight_of_DevOps]="🏇 **Knight of DevOps** - Swift deployment! You ride into production with containers and pipelines as your weapons. Your CI/CD charges forward, bringing development and operations into harmony."

# Subtle hint-cards (rarely drawn) that nudge seekers toward hidden features
PROGRAMMING_TAROT[Hint_Button_Sequence]="🃏 **The Button Sequence (Subtle Hint)** - Somewhere in the interface, a sequence of directional taps from classic controllers echoes a secret. Pay attention to rhythmic prompts during celebrations."

PROGRAMMING_TAROT[Hint_Retro_Map]="🃏 **Retro Map Echo (Subtle Hint)** - Nostalgia sometimes hides in names. A retro multiplayer map title might resurface in celebratory messages — listen for playful place-names."

# Tarot reading functions
# Small helper: emit a subtle easter-egg hint with a low probability (~10%).
# Hints are intentionally vague and TTY-guarded to avoid revealing mechanics in CI.
maybe_emit_hint() {
    # Only emit hints in interactive TTY sessions unless overridden
    if [[ -n "$GH_HOROSCOPE_NONINTERACTIVE" || ! -t 1 ]]; then
        return 0
    fi

    # 10% chance
    local roll=$((RANDOM % 100))
    if [[ $roll -lt 10 ]]; then
        # Pick a subtle hint message (do not reveal exact internals)
        local hints=(
            "🥠 Hint: listen for classic controller rhythms hidden in the interface."
            "🥠 Hint: sometimes old school button sequences unlock playful surprises."
            "🥠 Hint: a retro shooter map name might echo in your celebration messages."
        )
        local idx=$((RANDOM % ${#hints[@]}))
        echo
        echo "${YELLOW}${BOLD}${hints[$idx]}${RESET}"
        echo
    fi
}

draw_single_card() {
    local cards=(
        "0_The_Programmer" "1_The_Stack_Overflow" "2_The_Documentation" "3_The_Senior_Dev"
        "4_The_Tech_Lead" "5_The_Pair_Programming" "6_The_Git_Merge" "7_The_Code_Review"
        "8_The_Debugging" "9_The_CI_CD" "10_The_Load_Balancer" "11_The_Technical_Debt"
    "12_The_Legacy_Code" "13_The_Refactoring" "14_The_Production_Bug" "15_The_System_Crash"
    "16_The_Open_Source" "17_The_Moonlighting" "18_The_Code_Quality" "19_The_Code_Review_Response"
    "20_The_Production_Deploy" "21_The_Debug_Serenity" "22_The_Refactor_Ritual" "23_The_AdHoc_Solution"
    "24_The_Monitoring_Oracle" "25_The_Refinement_Circle" "Ace_of_Commits" "Two_of_Commits" "Three_of_Commits"
    "Ace_of_Bugs" "King_of_Frameworks" "Queen_of_APIs" "Knight_of_DevOps"
    )
    
    local random_index=$(($RANDOM % ${#cards[@]}))
    echo "${cards[$random_index]}"
}

draw_daily_card() {
    # Use today's date as seed for consistent daily card
    local cards=(
        "0_The_Programmer" "1_The_Stack_Overflow" "2_The_Documentation" "3_The_Senior_Dev"
        "4_The_Tech_Lead" "5_The_Pair_Programming" "6_The_Git_Merge" "7_The_Code_Review"
        "8_The_Debugging" "9_The_CI_CD" "10_The_Load_Balancer" "11_The_Technical_Debt"
    "12_The_Legacy_Code" "13_The_Refactoring" "14_The_Production_Bug" "15_The_System_Crash"
    "16_The_Open_Source" "17_The_Moonlighting" "18_The_Code_Quality" "19_The_Code_Review_Response"
    "20_The_Production_Deploy" "21_The_Debug_Serenity" "22_The_Refactor_Ritual" "23_The_AdHoc_Solution"
    "24_The_Monitoring_Oracle" "25_The_Refinement_Circle" "Ace_of_Commits" "Two_of_Commits" "Three_of_Commits"
    "Ace_of_Bugs" "King_of_Frameworks" "Queen_of_APIs" "Knight_of_DevOps"
    )
    
    # Get today's date as a number (YYYYMMDD format)
    local today_seed=$(date '+%Y%m%d')
    
    # Use date as seed for consistent daily card selection
    local daily_index=$((today_seed % ${#cards[@]}))
    echo "${cards[$daily_index]}"
}

draw_three_card_spread() {
    # Beautiful title like other functions
    echo -e "${MAGENTA}${BOLD}"
    echo "                                            🔮 ⏰ 🔮 ⏰ 🔮"
    echo "                                    🌟 ⏰ THREE CARD READING ⏰ 🌟"
    echo "                                            🔮 ⏰ 🔮 ⏰ 🔮"
    echo
    echo "                                    📜 Past • Present • Future 📜"
    echo -e "${RESET}"
    echo
    
    local past_card=$(draw_single_card)
    local present_card=$(draw_single_card)
    local future_card=$(draw_single_card)
    
    # Ensure no duplicates in the spread
    while [[ "$present_card" == "$past_card" ]]; do
        present_card=$(draw_single_card)
    done
    
    while [[ "$future_card" == "$past_card" || "$future_card" == "$present_card" ]]; do
        future_card=$(draw_single_card)
    done
    
    echo -e "${CYAN}${BOLD}"
    echo "    🕰️ **YOUR CODING PAST** 🕰️"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$past_card]}"
    
    echo -e "${CYAN}${BOLD}"
    echo "    ⚡ **YOUR CODING PRESENT** ⚡"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$present_card]}"
    
    echo -e "${CYAN}${BOLD}"
    echo "    🌟 **YOUR CODING FUTURE** 🌟"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$future_card]}"
    echo -e "${RESET}"
}

draw_single_daily_card() {
    # Beautiful title like other functions
    echo -e "${MAGENTA}${BOLD}"
    echo "                                              🃏 ✨ 🃏 ✨ 🃏"
    echo "                                    🌟 ✨ DAILY PROGRAMMING TAROT ✨ 🌟"
    echo "                                              🃏 ✨ 🃏 ✨ 🃏"
    echo
    echo "                                   🔮 Today's Mystical Coding Guidance 🔮"
    echo -e "${RESET}"
    echo
    
    local daily_card=$(draw_daily_card)
    
    # Beautiful centered section with consistent formatting
    echo -e "${YELLOW}${BOLD}"
    echo "                                 🌟 ═══════════════════════════════════ 🌟"
    echo
    echo "                                           ✨ Card of the Day ✨"
    echo
    echo "                                 🌟 ═══════════════════════════════════ 🌟"
    echo -e "${RESET}"
    echo
    
    # Display reading with proper wrapping
    echo -e "${CYAN}${BOLD}"
    echo "    🃏 Your Programming Tarot"
    echo "    ═══════════════════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$daily_card]}"
    echo -e "${RESET}"
}

draw_career_guidance_spread() {
    # Beautiful title
    echo -e "${MAGENTA}${BOLD}"
    echo "                                                💼 🌟 💼 🌟 💼"
    echo "                                    🌟 💼 CAREER DEVELOPMENT TAROT 💼 🌟"
    echo "                                                💼 🌟 💼 🌟 💼"
    echo
    echo "                                    🔮 Your Professional Path Revealed 🔮"
    echo -e "${RESET}"
    echo
    
    local skills_card=$(draw_single_card)
    local opportunities_card=$(draw_single_card)
    local challenges_card=$(draw_single_card)
    local advice_card=$(draw_single_card)
    
    # Ensure no duplicates
    while [[ "$opportunities_card" == "$skills_card" ]]; do
        opportunities_card=$(draw_single_card)
    done
    
    while [[ "$challenges_card" == "$skills_card" || "$challenges_card" == "$opportunities_card" ]]; do
        challenges_card=$(draw_single_card)
    done
    
    while [[ "$advice_card" == "$skills_card" || "$advice_card" == "$opportunities_card" || "$advice_card" == "$challenges_card" ]]; do
        advice_card=$(draw_single_card)
    done
    
    echo -e "${CYAN}${BOLD}"
    echo "    💪 **YOUR TECHNICAL STRENGTHS** 💪"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$skills_card]}"
    
    echo -e "${CYAN}${BOLD}"
    echo "    🚀 **OPPORTUNITIES AHEAD** 🚀"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$opportunities_card]}"
    
    echo -e "${CYAN}${BOLD}"
    echo "    ⚠️  **CHALLENGES TO FACE** ⚠️"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$challenges_card]}"
    
    echo -e "${CYAN}${BOLD}"
    echo "    🧙‍♂️  **THE ORACLE'S ADVICE** 🧙‍♂️"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo -e "${WHITE}"
    wrap_tarot_text "${PROGRAMMING_TAROT[$advice_card]}"
    echo -e "${RESET}"
}

display_tarot_menu() {
    echo -e "${RED}${BOLD}"
    cat << 'EOF'
         ╔══════════════════════════════════════════════════════════════════════╗
         ║                     🔮 PROGRAMMING TAROT ORACLE 🔮                   ║
         ╠══════════════════════════════════════════════════════════════════════╣
         ║  1. 🃏 Draw Single Daily Card                                        ║
         ║  2. 🔮 Three-Card Spread (Past, Present, Future)                     ║
         ║  3. 💼 Career Guidance Spread                                        ║
         ║  4. 🎯 Random Programming Wisdom                                     ║
         ║  5. 🚪 Return to Main Menu                                           ║
         ╚══════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
    echo
}

run_tarot_session() {
    clear
    
    # Use sparkly title format like other modules
    echo -e "${MAGENTA}${BOLD}"
    echo "                                    🃏 🔮 ✨ 🔮 🃏"
    echo "                         🌟 🔮 PROGRAMMING TAROT CARDS 🔮 🌟"
    echo "                                    🃏 🔮 ✨ 🔮 🃏"
    echo
    echo "                        📜 Mystical Cards of Code Destiny 📜"
    echo -e "${RESET}"
    echo
    
    echo "           Welcome to the mystical realm of Programming Tarot! These cards reveal"
    echo "         the hidden patterns of your coding journey and illuminate the path ahead."
    echo
    
    # Check if running in interactive mode
    if [[ ! -t 0 ]]; then
        echo "⚠️  Non-interactive mode detected. Drawing a single card for you..."
        echo
        draw_single_daily_card
        return 0
    fi
    
    while true; do
    display_tarot_menu
    echo -n "🔮 Choose your tarot experience (1-5): "
    read choice
    # Clear the menu display so subsequent output replaces it
    clear
        echo
        
        case $choice in
            1)
                draw_single_daily_card
                maybe_emit_hint
                ;;
            2)
                draw_three_card_spread
                ;;
            3)
                draw_career_guidance_spread
                ;;
            4)
                echo -e "${CYAN}${BOLD}"
                echo "    🎯 **RANDOM PROGRAMMING WISDOM** 🎯"
                echo "    ═══════════════════════════════════════════════════════════════"
                echo -e "${WHITE}"
                local random_card=$(draw_single_card)
                wrap_tarot_text "${PROGRAMMING_TAROT[$random_card]}"
                maybe_emit_hint
                echo -e "${RESET}"
                ;;
            5)
                echo -e "               ${CYAN}${BOLD}🚪 The tarot cards bid you farewell... until next time!${RESET}"
                echo
                echo -e "             ${RED}${BOLD}\"The cards whisper: Your future is written in lines of code...\"${RESET}"
                echo -e "              ${CYAN}${BOLD}✨ May your commits be clean and your merges conflict-free! ✨${RESET}"
                return 0
                ;;
            *)
                echo "❓ The cards do not understand. Please choose 1-5."
                ;;
        esac
        echo
        echo -n "Press Enter to continue your tarot journey..."
        read
        echo
    done
}