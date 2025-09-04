#!/bin/bash

# Oracle Sessions module for GitHub CLI Horoscope Extension
# Interactive mystical coding advice system

# Oracle wisdom database
declare -A ORACLE_RESPONSES

# Coding advice by category
ORACLE_RESPONSES[debugging]="🔍 **The Debug Oracle speaks:** Your bug is not your enemy, but your teacher. Listen to its whispers in the console logs. The answer lies not in the code you wrote, but in the code you didn't write. Check your assumptions like you check your syntax - carefully and often."

ORACLE_RESPONSES[career]="💼 **The Career Oracle reveals:** Your next opportunity will come disguised as a problem you've never solved before. Embrace the unknown languages, the scary architectures, the impossible deadlines. Growth lives in the gap between comfort and capability."

ORACLE_RESPONSES[learning]="📚 **The Learning Oracle whispers:** The best developers are not those who know everything, but those who know how to learn anything. Your curiosity is your superpower. Follow the threads that fascinate you - they lead to mastery."

ORACLE_RESPONSES[teamwork]="👥 **The Collaboration Oracle counsels:** The strongest code is written by the humblest developers. Listen more than you speak in code reviews. Teach without condescension, learn without ego. Your team is your greatest compiler - let them optimize your thinking."

ORACLE_RESPONSES[burnout]="🔥 **The Wellness Oracle warns:** Code is infinite, but you are not. Rest is not the absence of productivity, but the foundation of it. Your best solutions come not from grinding, but from stepping back and seeing the forest for the trees."

ORACLE_RESPONSES[imposter_syndrome]="👤 **The Confidence Oracle affirms:** Every expert was once a beginner. Every master once searched Stack Overflow for basic syntax. Your journey is valid, your progress is real, and your questions are welcome. You belong here."

ORACLE_RESPONSES[technology_choice]="🛠️ **The Technology Oracle advises:** The best framework is the one your team understands. The best language is the one that solves your problem. The best architecture is the one you can maintain. Choose simplicity over cleverness, clarity over performance, unless performance truly matters."

ORACLE_RESPONSES[legacy_code]="🏛️ **The Legacy Oracle sighs:** This code was written by developers who faced different constraints, different deadlines, different knowledge. Honor their effort while improving their work. Refactor with respect, not judgment."

ORACLE_RESPONSES[side_projects]="🚀 **The Side Project Oracle encourages:** Your side projects are not just code - they are dreams given form. Some will fly, some will crash, but all will teach you something you couldn't learn at work. Keep building, keep dreaming."

ORACLE_RESPONSES[open_source]="🌟 **The Open Source Oracle enlightens:** Contributing to open source is like leaving flowers on the path for other travelers. Your pull request, no matter how small, makes the developer ecosystem a little bit better for everyone who comes after you."

# Text wrapping function for oracle responses
wrap_oracle_text() {
    local text="$1"
    echo "$text" | fold -s -w 75
}

# Specific technical advice
declare -A TECHNICAL_ORACLE

TECHNICAL_ORACLE[git_conflicts]="🌿 **Git Wisdom:** Merge conflicts are not failures, they are conversations between different versions of truth. Take time to understand what each side was trying to accomplish before choosing the path forward."

TECHNICAL_ORACLE[testing]="🧪 **Testing Wisdom:** Tests are love letters to your future self. Write them as if the person maintaining your code is a violent psychopath who knows where you live - and that person is you, six months from now."

TECHNICAL_ORACLE[performance]="⚡ **Performance Wisdom:** Premature optimization is the root of all evil, but so is ignoring performance until it's too late. Measure first, optimize second, profile always."

TECHNICAL_ORACLE[security]="🔒 **Security Wisdom:** Trust is a vulnerability. Validate all inputs as if they come from your most creative adversary. Security is not a feature you add - it's a mindset you adopt."

TECHNICAL_ORACLE[documentation]="📝 **Documentation Wisdom:** Code tells you how, comments tell you why, documentation tells you when to care. Write docs for the developer you were six months ago - confused, eager, and slightly panicked."

TECHNICAL_ORACLE[code_review]="👁️ **Code Review Wisdom:** Review code like you're reviewing a work of art - look for beauty, clarity, and intention. Be firm with standards but gentle with people. Every 'please change this' should come with a 'here's why'."

# Fortune cookie style quick advice
QUICK_ORACLE_WISDOM=(
    "🥠 The bug you fear to face is exactly the bug you need to conquer for growth."
    "🥠 Your best code will be written after your worst mistakes."
    "🥠 The framework that confuses you today will make perfect sense tomorrow."
    "🥠 Every senior developer was once a junior who refused to give up."
    "🥠 Your code doesn't have to be perfect to be valuable."
    "🥠 The best time to learn a new technology was yesterday. The second best time is now."
    "🥠 Collaboration is not about writing code together, it's about solving problems together."
    "🥠 Your commit message is a letter to future developers - make it worth reading."
    "🥠 The scariest refactor is often the most necessary one."
    "🥠 Documentation is code for humans - make it beautiful."
    "🥠 Every bug is a mystery waiting to teach you something about your assumptions."
    "🥠 The code that works is less important than the code that can be understood."
    "🥠 Your greatest debugging tool is not your IDE - it's your ability to step away and think."
    "🥠 Tests are not about finding bugs - they're about preventing regret."
    "🥠 The best developers are not the ones who never break things - they're the ones who break things elegantly."
)

# Daily coding mantras
CODING_MANTRAS=(
    "🧘 \"Today I code with intention, not just instinct.\""
    "🧘 \"I embrace the bugs that teach me patience.\""
    "🧘 \"My code is a reflection of my current understanding - and that's enough.\""
    "🧘 \"I write code that future me will thank present me for.\""
    "🧘 \"Every error message is a teacher in disguise.\""
    "🧘 \"I build not just for users, but for the developers who come after me.\""
    "🧘 \"My best solutions come when I listen before I code.\""
    "🧘 \"I am a student of code, and every day brings new lessons.\""
    "🧘 \"The complexity I create today is the simplicity I must find tomorrow.\""
    "🧘 \"I code with humility, knowing that perfect code is a journey, not a destination.\""
)

# Project guidance based on common scenarios
give_project_guidance() {
    local project_type="$1"
    
    case $project_type in
        "new")
            echo "🌱 **New Project Oracle:** Start with the simplest thing that could possibly work. Perfect is the enemy of shipped. Your first version should solve one problem really well, not ten problems adequately."
            ;;
        "stuck")
            echo "🪨 **Stuck Project Oracle:** When you're stuck, the answer is rarely more code - it's often better understanding. Step back, rubber duck debug your problem, or explain it to someone who knows nothing about your domain."
            ;;
        "scaling")
            echo "📈 **Scaling Oracle:** Don't scale your technology until you've scaled your understanding. Most performance problems are solved by doing less, not doing more faster."
            ;;
        "choosing_tech")
            echo "🛠️ **Technology Choice Oracle:** Choose boring technology for important projects. Choose exciting technology for learning projects. Never choose exciting technology for important projects unless you have no choice."
            ;;
        *)
            echo "🔮 **General Project Oracle:** Every great project starts with a problem worth solving and ends with a solution worth maintaining. Focus on the problem first, the technology second."
            ;;
    esac
}

# GitHub Data-Driven Oracle Analysis
# This provides personalized mystical insights based on actual GitHub patterns

# Analyze GitHub data and provide specific oracle consultation
analyze_github_oracle() {
    local username="$1"
    local consultation_type="$2"
    
    # Make sure we have GitHub data analyzed
    if [[ $TOTAL_COMMITS -eq 0 && "$username" != "demo-user" ]]; then
        echo "⚠️ Unable to analyze GitHub data. Using general wisdom..."
        return 1
    fi
    
    case $consultation_type in
        "career-guidance")
            provide_career_guidance "$username"
            ;;
        "debugging-wisdom") 
            provide_debugging_wisdom "$username"
            ;;
        "burnout-check")
            provide_burnout_check "$username" 
            ;;
        "skill-development")
            provide_skill_development "$username"
            ;;
        "team-collaboration")
            provide_team_collaboration "$username"
            ;;
        "project-focus") 
            provide_project_focus "$username"
            ;;
        "coding-rhythm")
            provide_coding_rhythm "$username"
            ;;
        "technical-growth")
            provide_technical_growth "$username"
            ;;
        "open-source-path")
            provide_open_source_path "$username"
            ;;
        "language-mastery")
            provide_language_mastery "$username"
            ;;
        *)
            echo "🔮 **The Oracle is confused by your request:** Please specify a valid consultation type."
            echo "Available types: career-guidance, debugging-wisdom, burnout-check, skill-development,"
            echo "team-collaboration, project-focus, coding-rhythm, technical-growth, open-source-path, language-mastery"
            return 1
            ;;
    esac
}

# Career guidance based on languages and repository patterns
provide_career_guidance() {
    local username="$1"
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    local lang_count=${#PRIMARY_LANGUAGES[@]}
    local repo_diversity=$(get_repo_diversity_score)
    
    echo "    🔮 **CAREER GUIDANCE ORACLE** 🔮"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo
    
    if [[ $lang_count -gt 5 ]]; then
        echo "    • 🌟 **The Polyglot Path:** Your mastery of $lang_count languages"
        echo "      reveals a mind that adapts and evolves. Consider roles in"  
        echo "      technical leadership, architecture, or developer advocacy."
        echo "      Your diversity is your superpower - embrace full-stack roles!"
        echo
    elif [[ $lang_count -gt 2 ]]; then
        echo "    • ⚖️ **The Balanced Developer:** Your comfort with $lang_count"
        echo "      languages shows thoughtful specialization. Focus on deepening"
        echo "      expertise while staying curious. Senior individual contributor" 
        echo "      or team lead roles await your balanced approach."
        echo
    else
        echo "    • 🎯 **The Specialist's Path:** Your deep focus on $primary_lang"
        echo "      suggests mastery over breadth. Consider becoming the go-to"
        echo "      expert in your domain. Staff engineer or principal roles"
        echo "      reward deep specialization in complex problem spaces."
        echo
    fi
    
    if [[ $REPO_COUNT -gt 20 ]]; then
        echo "│                                                                   │"
        echo "│ 📈 Your $REPO_COUNT repositories show entrepreneurial spirit!      │"
        echo "│ Consider product management, startup CTO, or consultant roles.   │"
    elif [[ $ABANDONED_REPOS -gt $((REPO_COUNT / 2)) ]]; then
        echo "│                                                                   │"  
        echo "│ 🔍 Your exploration pattern suggests you thrive on variety.      │"
        echo "      Consulting, contracting, or roles with diverse project"
        echo "      exposure will feed your curiosity and prevent boredom."
        echo
    fi
}

# Debugging wisdom based on commit patterns and messages
provide_debugging_wisdom() {
    local username="$1"
    local night_percentage=$(get_night_owl_score)
    local commit_messages="${COMMIT_MESSAGES[*]}"
    
    echo "    🐛 **DEBUGGING WISDOM ORACLE** 🐛"
    echo "    ═══════════════════════════════════════════════════════════════"
    echo
    
    if [[ $night_percentage -gt 40 ]]; then
        echo "    • 🌙 **Night Owl Debugging Pattern:** $night_percentage% of your commits"
        echo "      happen in darkness. Night debugging is like surgery by candlelight"
        echo "      - you see clearly, but miss the bigger picture. Schedule morning"
        echo "      review sessions to catch logic errors your tired brain missed."
        echo
    elif [[ $night_percentage -lt 10 ]]; then
        echo "    • ☀️ **Daylight Developer:** Your $night_percentage% night commits show"
        echo "      discipline! Your fresh morning mind catches bugs before they"
        echo "      multiply. Trust your instincts during peak mental clarity."
        echo
    fi
    
    if [[ "$commit_messages" =~ (fix|bug|debug|error) ]]; then
        local fix_frequency=$(echo "$commit_messages" | grep -o -i "fix\|bug\|debug\|error" | wc -l)
        echo "│                                                                   │"
        echo "│ 🔧 **Your Fix Pattern:** $fix_frequency debugging-related commits    │"
        echo "│ suggest you're comfortable diving deep into problems. Channel     │"
        echo "│ this persistence into systematic debugging: reproduce, isolate,   │"
        echo "│ fix, test, document. Your tenacity is your debugging superpower! │"
    fi
    
    if [[ "$commit_messages" =~ (please.*work|why|help|broken) ]]; then
        echo "│                                                                   │"
        echo "│ 😅 **Desperation Pattern Detected:** Your commit messages reveal  │"
        echo "│ the beautiful human struggle with code! Remember: every bug is   │"
        echo "│ a teacher. When frustrated, step back, rubber duck debug, or     │"
        echo "│ explain the problem to a friend. Clarity comes with distance.    │"
    fi
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Burnout check based on commit frequency patterns  
provide_burnout_check() {
    local username="$1"
    local weekend_percentage=$(get_weekend_warrior_score)
    local commits_per_day=$((TOTAL_COMMITS / 365)) # Rough estimate
    
    echo
    printf "%-75s\n" "🔥 BURNOUT CHECK ORACLE 🔥"
    printf "%-75s\n" "$(printf '═%.0s' {1..75})"
    
    if [[ $weekend_percentage -gt 60 ]]; then
        wrap_oracle_text "• ⚠️ Weekend Warrior Warning: $weekend_percentage% weekend commits suggest you code more on weekends than weekdays! Your passion is admirable, but even magical systems need downtime for updates. Schedule deliberate rest - your Monday morning self will thank your Sunday evening wisdom. Protect your creative energy!" | sed 's/^/  /'
    elif [[ $weekend_percentage -gt 30 ]]; then
        wrap_oracle_text "• ⚖️ Healthy Balance Detected: $weekend_percentage% weekend coding shows you're engaged without being consumed. You understand that sustainable coding is a marathon, not a sprint. Keep this rhythm!" | sed 's/^/  /'
    else
        wrap_oracle_text "• 🧘 Zen Master Mode: $weekend_percentage% weekend commits show excellent work-life boundaries! Your rested mind produces better code than your exhausted one. You've mastered the art of sustainable development - teach others your wisdom!" | sed 's/^/  /'
    fi
    
    if [[ $commits_per_day -gt 5 ]]; then
        echo
        wrap_oracle_text "• 🚨 High Velocity Alert: ~$commits_per_day commits/day average suggests intense coding activity. Monitor your energy levels and ensure you're solving problems, not just creating activity. Quality over quantity - let your code breathe between commits." | sed 's/^/  /'
    fi
    
    echo
}

# Skill development recommendations based on language patterns
provide_skill_development() {
    local username="$1" 
    local lang_count=${#PRIMARY_LANGUAGES[@]}
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    
    echo
    printf "%-75s\n" "📚 SKILL DEVELOPMENT ORACLE 📚"
    printf "%-75s\n" "$(printf '═%.0s' {1..75})"
    
    if [[ $lang_count -eq 1 ]]; then
        wrap_oracle_text "• 🎯 Specialization Path: Your focus on $primary_lang shows commitment to mastery. Consider expanding horizontally: Study $primary_lang's ecosystem deeply (frameworks, tools), learn a complementary language (different paradigm), explore architecture patterns specific to your domain." | sed 's/^/  /'
    elif [[ $lang_count -gt 5 ]]; then
        wrap_oracle_text "• 🌈 Polyglot Mastery: Your $lang_count languages show incredible adaptability! Focus on deepening rather than widening: Choose 2-3 languages for deep specialization, study language design principles and paradigms, become a bridge between different tech stacks in your team." | sed 's/^/  /'
    else
        wrap_oracle_text "• ⚖️ Balanced Growth: Your $lang_count languages show thoughtful progression. Your next learning path depends on your goals: For leadership: study system design and architecture. For expertise: dive deeper into $primary_lang advanced features. For versatility: add a language from a different paradigm." | sed 's/^/  /'
    fi
    
    # Language-specific recommendations
    case $primary_lang in
        "JavaScript"|"TypeScript")
            echo
            wrap_oracle_text "• 🟡 JS/TS Growth Path: Explore modern frameworks, async patterns, and backend Node.js. Consider learning Rust or Go for performance-critical thinking, or Python for data work." | sed 's/^/  /'
            ;;
        "Python")
            echo
            wrap_oracle_text "• 🐍 Python Mastery Path: Dive into async/await, data science libraries, or web frameworks. Learn Go or Rust for systems thinking, or JavaScript for full-stack versatility." | sed 's/^/  /'
            ;;
        "Go"|"Rust")
            echo
            wrap_oracle_text "• ⚡ Systems Language Mastery: Your low-level focus is excellent! Consider distributed systems, kubernetes, or performance optimization. Add a high-level language for rapid prototyping (Python, JavaScript)." | sed 's/^/  /'
            ;;
    esac
    
    echo
}

# Team collaboration insights from commit and PR patterns
provide_team_collaboration() {
    local username="$1"
    local commit_messages="${COMMIT_MESSAGES[*]}"
    local emoji_personality=$(get_emoji_personality)
    
    echo
    printf "%-75s\n" "👥 TEAM COLLABORATION ORACLE 👥"
    printf "%-75s\n" "$(printf '═%.0s' {1..75})"
    
    # Analyze commit message style for collaboration insights
    if [[ "$commit_messages" =~ (feat|fix|docs|style|refactor|test|chore) ]]; then
        wrap_oracle_text "• ✨ Conventional Commit Master: Your structured commit messages show respect for your future self and teammates! This discipline makes you a joy to work with. Your git history tells a story that others can follow. Consider mentoring others in this art." | sed 's/^/  /'
    elif [[ "$commit_messages" =~ (WIP|wip|temp|temporary) ]]; then
        wrap_oracle_text "• 🚧 Work-in-Progress Communicator: Your WIP commits show transparency about incomplete work. This honesty builds trust! Consider using feature branches for experimental work to keep main branch clean while maintaining your open communication." | sed 's/^/  /'
    elif [[ "$commit_messages" =~ (stuff|things|changes|update) ]]; then
        wrap_oracle_text "• 🎭 Mysterious Committer: Your cryptic commit messages add mystery to your work! While entertaining, consider your team members who might need to understand your changes at 3am during an emergency. Add a bit more context for your future heroes." | sed 's/^/  /'
    fi
    
    # Emoji analysis for team communication
    case $emoji_personality in
        *"Expressive Communicator"*)
            echo
            wrap_oracle_text "• 🎭 Your expressive emoji use brings joy to code reviews and makes technical communication more human. You're the team member who makes everyone smile during stressful deployments!" | sed 's/^/  /'
            ;;
        *"Minimalist Coder"*)
            echo
            wrap_oracle_text "• 🗿 Your minimalist style focuses on substance over style. While your code speaks volumes, don't underestimate the power of a well-placed emoji in team chat to build connections." | sed 's/^/  /'
            ;;
    esac
    
    echo
}

# Project focus advice based on repository patterns
provide_project_focus() {
    local username="$1"
    local abandonment_ratio=$((ABANDONED_REPOS * 100 / REPO_COUNT))
    
    echo "╭─────────────────────────────────────────────────────────────────────╮"
    echo "│                🎯 **PROJECT FOCUS ORACLE** 🎯                       │"
    echo "├─────────────────────────────────────────────────────────────────────┤"
    
    if [[ $abandonment_ratio -gt 70 ]]; then
        echo "│ 🌪️ **The Project Tornado:** $abandonment_ratio% of your projects │"
        echo "│ show signs of abandonment - you're a beautiful storm of ideas!    │"
        echo "│ Channel this creativity: pick ONE project as your 'flagship' and  │"
        echo "│ commit to finishing it. Let other ideas be experiments, but       │"
        echo "│ have one project that showcases your ability to ship.             │"
    elif [[ $abandonment_ratio -gt 40 ]]; then
        echo "│ 🔍 **The Explorer:** $abandonment_ratio% abandonment suggests you │"
        echo "│ love learning through doing! This curiosity is valuable, but      │"
        echo "│ consider maintaining 2-3 'showcase' projects alongside your       │"
        echo "│ experiments. Quality portfolio beats quantity of repos.           │"
    else
        echo "│ 🏆 **The Finisher:** Only $abandonment_ratio% abandonment shows │"
        echo "│ impressive follow-through! Your consistency is your superpower.   │"
        echo "│ You're the person teams depend on to see things through. Use     │"
        echo "│ this reliability to take on increasingly ambitious projects.     │"
    fi
    
    if [[ $REPO_COUNT -gt 50 ]]; then
        echo "│                                                                   │"
        echo "│ 📊 **Repository Abundance:** $REPO_COUNT repositories! Consider  │"
        echo "│ consolidating similar projects, archiving experiments, and       │"
        echo "│ highlighting your top 5-10 most representative works. Quality   │"
        echo "│ curation makes a stronger impression than quantity.              │"
    fi
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Coding rhythm analysis from temporal patterns
provide_coding_rhythm() {
    local username="$1"
    local night_percentage=$(get_night_owl_score)
    local weekend_percentage=$(get_weekend_warrior_score) 
    
    echo "╭─────────────────────────────────────────────────────────────────────╮"
    echo "│               🕰️ **CODING RHYTHM ORACLE** 🕰️                       │"
    echo "├─────────────────────────────────────────────────────────────────────┤"
    
    if [[ $night_percentage -gt 50 ]]; then
        echo "│ 🌙 **Night Owl Flow:** $night_percentage% nocturnal commits reveal │"
        echo "│ your peak creative hours in darkness. Embrace this rhythm but     │"
        echo "│ protect your sleep! Consider: focused deep work blocks at night,  │"
        echo "│ morning review sessions, and afternoon collaboration time.        │"
    elif [[ $night_percentage -lt 20 ]]; then
        echo "│ 🌅 **Morning Warrior:** $night_percentage% night commits show your │"
        echo "│ discipline! Your fresh morning mind is your secret weapon.        │"
        echo "│ Schedule challenging problems for AM hours and use evenings       │"
        echo "│ for lighter tasks like documentation and planning.                │"
    else
        echo "│ ⚖️ **Balanced Rhythm:** Your $night_percentage% night coding shows │"
        echo "│ healthy temporal distribution. You adapt your coding to your      │"
        echo "│ life instead of sacrificing life to code. This sustainability    │"
        echo "│ will serve you well in long-term projects.                       │"
    fi
    
    if [[ $weekend_percentage -gt 40 ]]; then
        echo "│                                                                   │"
        echo "│ 🎮 **Weekend Creator:** $weekend_percentage% weekend commits      │"
        echo "│ suggest you use free time for passion projects! Balance this     │"
        echo "│ with rest to maintain creativity. Consider: one full rest day,   │"
        echo "│ morning coding (fresh mind), evening social time.                │"
    fi
    
    # Provide rhythm optimization advice
    echo "│                                                                   │"
    echo "│ 💡 **Rhythm Optimization:** Track your best coding hours for a    │"
    echo "│ week. Schedule important work during peak energy times, mundane   │"
    echo "│ tasks during low energy. Your natural rhythm is your ally!       │"
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Technical growth recommendations  
provide_technical_growth() {
    local username="$1"
    local archetype=$(analyze_developer_archetype "$username" "${COMMIT_MESSAGES[*]}" "$(get_night_owl_score)" "$(get_weekend_warrior_score)" "$REPO_COUNT")
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    
    echo "╭─────────────────────────────────────────────────────────────────────╮"
    echo "│              🚀 **TECHNICAL GROWTH ORACLE** 🚀                      │"
    echo "├─────────────────────────────────────────────────────────────────────┤"
    
    case $archetype in
        *"Stack_Overflow_Shaman"*)
            echo "│ 📚 **From Shaman to Sage:** You excel at finding solutions!     │"
            echo "│ Next level: contribute answers to Stack Overflow, write         │"
            echo "│ technical blogs, or create educational content. Transform       │"
            echo "│ your solution-finding skills into solution-teaching skills.    │"
            ;;
        *"Perfectionist"*)
            echo "│ 🔍 **From Perfectionist to Pragmatist:** Your attention to      │"
            echo "│ detail is exceptional! Growth path: learn to balance           │"
            echo "│ perfection with delivery. Practice MVP thinking, time-boxing   │"
            echo "│ optimization tasks, and embracing 'good enough' iterations.    │"
            ;;
        *"Night_Owl"*|*"Vampire"*)
            echo "│ 🦉 **Night Owl Evolution:** Your dark hours coding shows       │"
            echo "│ dedication! Growth areas: async programming patterns,          │"
            echo "│ distributed systems (different timezone thinking), and        │"
            echo "│ mentoring others about deep focus techniques.                 │"
            ;;
        *"Weekend_Warrior"*)
            echo "│ ⚔️ **Weekend Warrior Advancement:** Your passion projects      │"
            echo "│ show drive! Channel this energy into open source leadership,  │"
            echo "│ community building, or side business development. Your        │"
            echo "│ self-motivated work ethic is a leadership superpower.        │"
            ;;
        *)
            echo "│ 🌟 **Unique Path Forward:** Your coding patterns suggest a     │"
            echo "│ distinctive approach to development. Consider: technical      │"
            echo "│ writing, conference speaking, or mentoring to share your     │"
            echo "│ unique perspective with the broader developer community.     │"
            ;;
    esac
    
    # Language-specific technical growth
    case $primary_lang in
        "JavaScript"|"TypeScript")
            echo "│                                                                   │"
            echo "│ 🟡 **JS/TS Technical Growth:** Master advanced async patterns,   │"
            echo "│ contribute to open source frameworks, or explore edge computing │"
            echo "│ with Deno/Bun. Consider WebAssembly for performance bridges.    │"
            ;;
        "Python") 
            echo "│                                                                   │"
            echo "│ 🐍 **Python Technical Growth:** Dive into CPython internals,    │"
            echo "│ async programming, or scientific computing. Consider creating   │"
            echo "│ your own packages or contributing to major Python libraries.    │"
            ;;
        "Go"|"Rust")
            echo "│                                                                   │"
            echo "│ ⚡ **Systems Technical Growth:** Explore distributed systems,   │"
            echo "│ contribute to major infrastructure projects, or build          │"
            echo "│ performance tools. Your systems knowledge is increasingly rare. │"
            ;;
    esac
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Open source path recommendations
provide_open_source_path() {
    local username="$1"  
    local karma_score=$((ISSUE_KARMA + PR_KARMA))
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    
    echo "╭─────────────────────────────────────────────────────────────────────╮"
    echo "│              🌟 **OPEN SOURCE PATH ORACLE** 🌟                      │"
    echo "├─────────────────────────────────────────────────────────────────────┤"
    
    if [[ $karma_score -lt 50 ]]; then
        echo "│ 🌱 **Open Source Seedling:** Your journey begins now! Start with: │"
        echo "│ • Find a project you actively use and love                       │"
        echo "│ • Look for 'good first issue' or 'help wanted' labels           │"
        echo "│ • Start with documentation improvements - always needed!         │"
        echo "│ • Fix typos, improve examples, or clarify confusing sections    │"
        echo "│ Small contributions build confidence and community connections.  │"
    elif [[ $karma_score -lt 200 ]]; then
        echo "│ 🌿 **Growing Contributor:** Karma score $karma_score shows       │"
        echo "│ emerging involvement! Your next steps:                           │" 
        echo "│ • Take on feature implementations, not just fixes               │"
        echo "│ • Review others' PRs - teaching builds your reputation         │"
        echo "│ • Participate in project discussions and architecture decisions │"
        echo "│ • Consider maintaining a small library in your domain          │"
    else
        echo "│ 🌳 **Open Source Leader:** Karma score $karma_score suggests     │"
        echo "│ significant contributions! Your leadership path:                 │"
        echo "│ • Mentor new contributors in projects you care about           │"
        echo "│ • Start your own project addressing a real problem             │"
        echo "│ • Speak at conferences about your open source experience       │"
        echo "│ • Bridge communities between related projects                  │"
    fi
    
    # Language-specific open source opportunities
    case $primary_lang in
        "JavaScript"|"TypeScript")
            echo "│                                                                   │"
            echo "│ 🟡 **JS/TS Open Source:** Contribute to npm packages, React      │"
            echo "│ ecosystem, or build developer tools. The JS community rewards   │"
            echo "│ innovation and accessibility improvements.                       │"
            ;;
        "Python")
            echo "│                                                                   │"
            echo "│ 🐍 **Python Open Source:** PyPI needs maintainers! Scientific  │"
            echo "│ computing, web frameworks, and CLI tools are always evolving.  │"
            echo "│ Python's community values mentorship and documentation.        │"
            ;;
        "Go"|"Rust")
            echo "│                                                                   │"
            echo "│ ⚡ **Systems Open Source:** Infrastructure projects need your   │"
            echo "│ expertise! Kubernetes, databases, and performance tools        │"
            echo "│ welcome systems programmers who understand efficiency.         │"
            ;;
    esac
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Language mastery guidance
provide_language_mastery() {
    local username="$1"
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    local lang_count=${#PRIMARY_LANGUAGES[@]}
    local secondary_lang="${PRIMARY_LANGUAGES[1]:-None}"
    
    echo "╭─────────────────────────────────────────────────────────────────────╮"
    echo "│              🎯 **LANGUAGE MASTERY ORACLE** 🎯                       │"
    echo "├─────────────────────────────────────────────────────────────────────┤"
    
    echo "│ 🔤 **Primary Language:** $primary_lang                             │"
    if [[ "$secondary_lang" != "None" ]]; then
        echo "│ 🔤 **Secondary Language:** $secondary_lang                         │"
    fi
    echo "│ 📊 **Language Portfolio:** $lang_count total languages               │"
    echo "│                                                                   │"
    
    if [[ $lang_count -eq 1 ]]; then
        echo "│ 🏹 **Single Language Mastery Path:**                             │"
        echo "│ Your focused approach to $primary_lang is commendable!          │"
        echo "│ Deep specialization strategy:                                    │"
        echo "│ • Master advanced language features and idioms                  │"
        echo "│ • Contribute to the language ecosystem (tools, libraries)      │"
        echo "│ • Become a community expert through teaching and writing       │"
        echo "│ • Learn a complementary language to broaden perspective         │"
    elif [[ $lang_count -le 3 ]]; then
        echo "│ ⚖️ **Balanced Mastery Path:**                                     │"
        echo "│ Your $lang_count languages show thoughtful progression!          │"
        echo "│ Choose your mastery focus:                                       │"
        echo "│ • Deep dive: Pick one for expert-level mastery                 │"
        echo "│ • T-shaped: Broad knowledge, deep in your primary language     │"
        echo "│ • Bridge expert: Connect different language communities        │"
    else
        echo "│ 🌈 **Polyglot Excellence Path:**                                 │"
        echo "│ Your $lang_count languages reveal adaptability mastery!         │"
        echo "│ Polyglot strategy:                                               │"
        echo "│ • Language design patterns: Study what makes languages unique  │"
        echo "│ • Paradigm mastery: Functional, OOP, systems programming       │"
        echo "│ • Tool building: Create bridges between language ecosystems    │"
        echo "│ • Architecture: Design systems that leverage each lang's best  │"
    fi
    
    # Specific mastery advice for primary language
    echo "│                                                                   │"
    case $primary_lang in
        "JavaScript")
            echo "│ 🟡 **JavaScript Mastery:** Async mastery, prototype chains,      │"
            echo "│ closures, and the event loop. Build tools, not just apps.       │"
            ;;
        "TypeScript") 
            echo "│ 🔷 **TypeScript Mastery:** Advanced types, generics, conditional │"
            echo "│ types. You're at the cutting edge of type-safe JavaScript!      │"
            ;;
        "Python")
            echo "│ 🐍 **Python Mastery:** Metaclasses, decorators, async/await,    │"
            echo "│ C extensions. Python's depth is bottomless - dive deep!         │"
            ;;
        "Go")
            echo "│ 🔵 **Go Mastery:** Concurrency patterns, performance tuning,    │"
            echo "│ and simplicity philosophy. Master the 'less is more' mindset.   │"
            ;;
        "Rust")
            echo "│ 🦀 **Rust Mastery:** Lifetime system, unsafe code, proc macros. │"
            echo "│ You're wielding one of the most powerful tools in computing!    │"
            ;;
        "Java")
            echo "│ ☕ **Java Mastery:** JVM internals, concurrency, enterprise     │"
            echo "│ patterns. Your enterprise skills are in high demand!           │"
            ;;
        "C++")
            echo "│ ⚡ **C++ Mastery:** Template metaprogramming, memory management, │"
            echo "│ modern C++ features. You speak the language of performance!     │"
            ;;
        *)
            echo "│ 🌟 **$primary_lang Mastery:** Every language has hidden depths. │"
            echo "│ Explore advanced features, contribute to community, teach!      │"
            ;;
    esac
    
    echo "╰─────────────────────────────────────────────────────────────────────╯"
}

# Interactive oracle session
display_oracle_header() {
    clear
    echo "🔮 ✨ 🔮 ✨ 🔮 ✨ **THE CODING ORACLE AWAKENS** ✨ 🔮 ✨ 🔮 ✨ 🔮"
    echo
    echo "                       🏛️"
    echo "                      ╭─────╮"
    echo "                      │ 👁️‍🗨️ │"
    echo "                      │ ☯️  │"
    echo "                      │ 🔮  │"
    echo "                      ╰─────╯"
    echo "                    ╭───────────╮"
    echo "                    │  ORACLE   │"
    echo "                    ╰───────────╯"
    echo
    echo "\"Seeker of code wisdom, I have been expecting you...\""
    echo "\"Your questions shall be answered, your path illuminated.\""
    echo
}

# Oracle menu display is now handled by display.sh

ask_technical_question() {
    echo "🔮 **The Oracle listens to your technical question...**"
    echo
    read -p "🗣️ What technical challenge troubles your code-spirit? " question
    echo
    echo "⏳ The Oracle communes with the ancient servers..."
    sleep 2
    echo
    
    # Show Oracle consultation loading
    display_oracle_loading "Consulting the ancient coding wisdom" 2
    
    # Analyze question and provide contextual response
    local response=""
    if [[ "$question" =~ (git|merge|conflict|branch) ]]; then
        response="${TECHNICAL_ORACLE[git_conflicts]}"
    elif [[ "$question" =~ (test|testing|unit|integration) ]]; then
        response="${TECHNICAL_ORACLE[testing]}"
    elif [[ "$question" =~ (performance|slow|speed|optimize) ]]; then
        response="${TECHNICAL_ORACLE[performance]}"
    elif [[ "$question" =~ (security|auth|vulnerability|encrypt) ]]; then
        response="${TECHNICAL_ORACLE[security]}"
    elif [[ "$question" =~ (documentation|docs|comment|readme) ]]; then
        response="${TECHNICAL_ORACLE[documentation]}"
    elif [[ "$question" =~ (review|pr|pull.*request) ]]; then
        response="${TECHNICAL_ORACLE[code_review]}"
    else
        # Generic wisdom based on question sentiment
        if [[ "$question" =~ (help|stuck|confused|lost|don.*know) ]]; then
            response="🔮 **The Oracle sees your confusion:** When lost in the forest of code, climb the tallest tree of understanding. Sometimes the path forward requires stepping back to see the bigger picture. Your confusion is not weakness - it's the beginning of clarity."
        elif [[ "$question" =~ (best.*practice|should|how.*to) ]]; then
            response="🔮 **The Oracle shares ancient wisdom:** The best practice is the one your team can consistently follow. Code for humans first, computers second. When in doubt, choose the solution that will be most understandable at 3 AM six months from now."
        else
            response="🔮 **The Oracle reflects:** '${question}' - A worthy question that shows wisdom in the asking. The answer you seek lies not just in knowing the 'what', but understanding the 'why'. Research deeply, experiment safely, and trust your growing intuition."
        fi
    fi
    
    display_mystical_insight "🧙‍♂️ The Oracle Responds" "$response"
}

run_oracle_session() {
    display_oracle_header
    
    while true; do
        display_oracle_menu
        read -p "🔮 Choose your question for the Oracle (1-15): " choice
        echo
        
        case $choice in
            1)
                display_oracle_art "debugging"
                display_mystical_insight "🐛 Oracle of Debugging" "${ORACLE_RESPONSES[debugging]}"
                ;;
            2)
                display_oracle_art "career"
                display_mystical_insight "💼 Career Oracle" "${ORACLE_RESPONSES[career]}"
                ;;
            3)
                display_oracle_art "learning"
                display_mystical_insight "📚 Learning Oracle" "${ORACLE_RESPONSES[learning]}"
                ;;
            4)
                display_oracle_art "teamwork"
                display_mystical_insight "👥 Teamwork Oracle" "${ORACLE_RESPONSES[teamwork]}"
                ;;
            5)
                display_oracle_art "burnout"
                display_mystical_insight "🔥 Burnout Oracle" "${ORACLE_RESPONSES[burnout]}"
                ;;
            6)
                display_oracle_art "confidence"
                display_mystical_insight "👤 Confidence Oracle" "${ORACLE_RESPONSES[imposter_syndrome]}"
                ;;
            7)
                display_oracle_art "technology"
                display_mystical_insight "🛠️ Technology Oracle" "${ORACLE_RESPONSES[technology_choice]}"
                ;;
            8)
                display_oracle_art "legacy"
                display_mystical_insight "🏛️ Legacy Code Oracle" "${ORACLE_RESPONSES[legacy_code]}"
                ;;
            9)
                display_oracle_art "projects"
                display_mystical_insight "🚀 Side Project Oracle" "${ORACLE_RESPONSES[side_projects]}"
                ;;
            10)
                display_oracle_art "opensource"
                display_mystical_insight "🌟 Open Source Oracle" "${ORACLE_RESPONSES[open_source]}"
                ;;
            11)
                local random_wisdom=${QUICK_ORACLE_WISDOM[$RANDOM % ${#QUICK_ORACLE_WISDOM[@]}]}
                display_oracle_art "default"
                display_mystical_insight "🥠 Quick Oracle Wisdom" "$random_wisdom"
                ;;
            12)
                local random_mantra=${CODING_MANTRAS[$RANDOM % ${#CODING_MANTRAS[@]}]}
                display_oracle_art "default"
                display_mystical_insight "🧘 Today's Coding Mantra" "$random_mantra"
                ;;
            13)
                ask_technical_question
                ;;
            14)
                echo "🎯 **Project Guidance Oracle:**"
                echo "What type of guidance do you seek?"
                echo "  [new] - Starting a new project"
                echo "  [stuck] - Stuck on current project"  
                echo "  [scaling] - Scaling/performance issues"
                echo "  [choosing_tech] - Technology decisions"
                echo
                read -p "Enter guidance type: " guidance_type
                echo
                echo "╭─────────────────────────────────────────────────────────────────────╮"
                echo "│ $(give_project_guidance "$guidance_type") │"
                echo "╰─────────────────────────────────────────────────────────────────────╯"
                ;;
            15)
                echo "🚪 **The Oracle fades into the digital mist...**"
                echo
                echo "\"Remember, seeker: The wisdom was within you all along.\""
                echo "\"I merely helped you find the words for what you already knew.\""
                echo
                echo "✨ May your code compile and your logic flow true! ✨"
                return 0
                ;;
            *)
                echo "❓ The Oracle does not understand. Please choose 1-15."
                ;;
        esac
        echo
        read -p "Press Enter to continue your consultation..." 
        echo
    done
}