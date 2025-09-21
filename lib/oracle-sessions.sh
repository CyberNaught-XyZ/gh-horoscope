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

TECHNICAL_ORACLE[debugging]="🐛 **Debugging Wisdom:** Your bug is not your enemy, but your teacher. Listen to its whispers in the console logs. The answer lies not in the code you wrote, but in the code you didn't write. Check your assumptions like you check your syntax - carefully and often."

TECHNICAL_ORACLE[code_review]="👀 **Code Review Wisdom:** Review code as if you're mentoring your past self. Be kind but thorough, specific but not pedantic. The best reviews teach principles, not just point out problems. Remember: you're reviewing code, not critiquing the coder."

TECHNICAL_ORACLE[learning]="📚 **Learning Wisdom:** Every expert was once a beginner who refused to give up. Start small, build consistently, and embrace the confusion - it means you're growing. The path from 'I have no idea' to 'I got this' is shorter than you think."

TECHNICAL_ORACLE[career_start]="🌱 **Career Starting Wisdom:** Your first job won't be your last, your first language won't be your only one, and your first mistake won't define you. Focus on learning, asking good questions, and building things. The rest will follow."

# Technical Debt Oracle - Advanced technical debt analysis and advice
declare -A TECHNICAL_DEBT_ORACLE
declare -g DEBT_ANALYSIS_RESULTS=()
declare -g DEBT_SEVERITY_LEVEL=""
declare -g DEBT_COUNT=0

# Technical Debt Oracle responses and analysis
TECHNICAL_DEBT_ORACLE[architecture_debt]="🏗️ **Architecture Debt Oracle:** Your codebase has grown organically, like a city without urban planning. What once was a charming village of functions has become a sprawling metropolis of dependencies. Time to draw some maps, establish some districts, and maybe build a few bridges where there are currently only dark alleys."

TECHNICAL_DEBT_ORACLE[documentation_debt]="📚 **Documentation Debt Oracle:** Your code speaks in ancient tongues that only you can decipher. Future developers will need a Rosetta Stone to understand your intentions. The debt isn't in what you wrote, but in what you forgot to explain. Consider this: if your code is poetry, your comments should be the translation."

TECHNICAL_DEBT_ORACLE[testing_debt]="🧪 **Testing Debt Oracle:** You've built a beautiful glass house but forgotten to install smoke detectors. Your code works today, but will it work tomorrow? Testing debt is like insurance - boring until you need it, essential when disaster strikes. Start small: test the parts that would hurt most if they broke."

TECHNICAL_DEBT_ORACLE[refactoring_debt]="🔄 **Refactoring Debt Oracle:** Your code has accumulated layers like an archaeological site - each commit a new stratum of history. Some functions have grown so complex they deserve their own zip code. The Oracle sees three paths: divide the giants, simplify the tangles, or document the maze so others can navigate it."

TECHNICAL_DEBT_ORACLE[dependency_debt]="📦 **Dependency Debt Oracle:** Your package.json reads like a phone book from the early 2000s. You've collected dependencies like a digital hoarder - some useful, some forgotten, some actively harmful. Time for a Marie Kondo session: does this package spark joy? If not, thank it for its service and delete it."

TECHNICAL_DEBT_ORACLE[performance_debt]="⚡ **Performance Debt Oracle:** Your application runs, but with the grace of a three-legged elephant. Performance debt is often invisible until it becomes unbearable. The Oracle suggests: measure first, optimize second, and remember - the fastest code is the code that doesn't run at all."

TECHNICAL_DEBT_ORACLE[security_debt]="🔒 **Security Debt Oracle:** You've built fortifications from the outside but left the windows unlocked. Security debt compounds faster than credit card interest and can be just as devastating. Every TODO comment about 'fixing this later' is a potential vulnerability. Later is now."

TECHNICAL_DEBT_ORACLE[maintainability_debt]="🛠️ **Maintainability Debt Oracle:** Your code works, but maintaining it requires the skills of an archaeologist, the patience of a saint, and the courage of a debugger. Maintainability debt is the most insidious kind - it doesn't break things, it just makes everything harder. Invest in clarity today, thank yourself tomorrow."

TECHNICAL_DEBT_ORACLE[configuration_debt]="⚙️ **Configuration Debt Oracle:** Your project has more configuration files than a bureaucratic maze. Environment-specific settings are scattered like Easter eggs throughout your codebase. The Oracle sees a path: centralize the chaos, version the variables, and document the decisions."

TECHNICAL_DEBT_ORACLE[error_handling_debt]="🚨 **Error Handling Debt Oracle:** Your code assumes a world where nothing goes wrong - a beautiful but naive perspective. When exceptions happen (and they will), your application throws tantrums like a toddler in a toy store. Graceful failure is an art form worth mastering."

# Analyze technical debt patterns from GitHub data
analyze_technical_debt() {
    local username="$1"
    local commit_messages_text="${COMMIT_MESSAGES[*]}"
    local repo_count="$REPO_COUNT"
    local abandoned_repos="$ABANDONED_REPOS"
    
    local debt_indicators=()
    local severity_score=0
    
    # Architecture debt indicators
    if [[ "$commit_messages_text" =~ (refactor|restructure|reorganize|massive.*change|big.*refactor) ]]; then
        debt_indicators+=("architecture_debt")
        severity_score=$((severity_score + 15))
    fi
    
    # Documentation debt indicators
    if [[ "$commit_messages_text" =~ (add.*docs|document|readme|comment|explain) ]]; then
        debt_indicators+=("documentation_debt")
        severity_score=$((severity_score + 10))
    fi
    
    # Testing debt indicators
    if [[ "$commit_messages_text" =~ (add.*test|fix.*test|test.*coverage|testing) ]]; then
        debt_indicators+=("testing_debt")
        severity_score=$((severity_score + 20))
    fi
    
    # Dependency debt indicators
    if [[ "$commit_messages_text" =~ (update.*dep|upgrade|dependency|package|npm.*audit|security.*fix) ]]; then
        debt_indicators+=("dependency_debt")
        severity_score=$((severity_score + 12))
    fi
    
    # Performance debt indicators
    if [[ "$commit_messages_text" =~ (optimize|performance|slow|speed.*up|memory|leak) ]]; then
        debt_indicators+=("performance_debt")
        severity_score=$((severity_score + 18))
    fi
    
    # Security debt indicators
    if [[ "$commit_messages_text" =~ (security|vulnerable|cve|patch|auth.*fix|secure) ]]; then
        debt_indicators+=("security_debt")
        severity_score=$((severity_score + 25))
    fi
    
    # Error handling debt indicators
    if [[ "$commit_messages_text" =~ (catch.*error|handle.*exception|try.*catch|error.*handling) ]]; then
        debt_indicators+=("error_handling_debt")
        severity_score=$((severity_score + 8))
    fi
    
    # Configuration debt indicators
    if [[ "$commit_messages_text" =~ (config|environment|env.*var|settings) ]]; then
        debt_indicators+=("configuration_debt")
        severity_score=$((severity_score + 6))
    fi
    
    # Repository abandonment as debt indicator
    if [[ $repo_count -gt 0 ]] && [[ $abandoned_repos -gt 0 ]]; then
        local abandonment_ratio=$((abandoned_repos * 100 / repo_count))
        if [[ $abandonment_ratio -gt 50 ]]; then
            debt_indicators+=("maintainability_debt")
            severity_score=$((severity_score + abandonment_ratio / 5))
        fi
    fi
    
    # Determine debt severity level
    if [[ $severity_score -gt 80 ]]; then
        DEBT_SEVERITY_LEVEL="Critical"
    elif [[ $severity_score -gt 50 ]]; then
        DEBT_SEVERITY_LEVEL="High"
    elif [[ $severity_score -gt 25 ]]; then
        DEBT_SEVERITY_LEVEL="Moderate"
    else
        DEBT_SEVERITY_LEVEL="Low"
    fi
    
    # Store analysis results
    DEBT_ANALYSIS_RESULTS=("${debt_indicators[@]}")
    
    # Return 0 for success, set debt count in a global variable
    DEBT_COUNT=${#debt_indicators[@]}
    return 0
}

# Generate technical debt oracle consultation
provide_technical_debt_consultation() {
    local username="$1"
    
    display_section_header "🏗️ TECHNICAL DEBT ORACLE CONSULTATION"
    
    # Ensure we have basic data for analysis
    if [[ -z "$REPO_COUNT" ]]; then
        REPO_COUNT=7
    fi
    if [[ -z "$ABANDONED_REPOS" ]]; then
        ABANDONED_REPOS=2
    fi
    if [[ ${#COMMIT_MESSAGES[@]} -eq 0 ]]; then
        COMMIT_MESSAGES=("fix stuff" "update" "it works now" "refactor code" "documentation" "optimize performance")
    fi
    
    # Perform debt analysis
    analyze_technical_debt "$username"
    local debt_count=$DEBT_COUNT
    
    if [[ $debt_count -eq 0 ]]; then
        echo
        wrap_oracle_text "🌟 **Clean Code Oracle:** Your repositories show remarkable discipline! The technical debt spirits find little to criticize. Either you're a master of preventive programming, or you're very good at hiding your chaos. Keep up the excellent work, but remember - a little debt isn't always bad if it helps you ship faster." | sed 's/^/    /'
        echo
        return 0
    fi
    
    echo
    printf "    %-70s\n" "🎯 DEBT ANALYSIS SUMMARY"
    printf "    %-70s\n" "$(printf '═%.0s' {1..70})"
    echo
    printf "    • Debt Severity Level: %s\n" "$DEBT_SEVERITY_LEVEL"
    printf "    • Debt Categories Detected: %d\n" "$debt_count"
    echo
    
    # Provide specific oracle advice for detected debt types
    for debt_type in "${DEBT_ANALYSIS_RESULTS[@]}"; do
        echo
        wrap_oracle_text "${TECHNICAL_DEBT_ORACLE[$debt_type]}" | sed 's/^/    /'
        echo
        
        # Provide actionable advice based on debt type
        case $debt_type in
            "architecture_debt")
                wrap_oracle_text "📋 **Immediate Actions:** 1) Identify the largest source file 2) Extract reusable components 3) Define clear module boundaries 4) Create a refactoring roadmap" | sed 's/^/      /'
                ;;
            "documentation_debt")
                wrap_oracle_text "📋 **Immediate Actions:** 1) Document the most confusing function 2) Add a proper README 3) Comment any 'clever' code 4) Explain your architectural decisions" | sed 's/^/      /'
                ;;
            "testing_debt")
                wrap_oracle_text "📋 **Immediate Actions:** 1) Test your most critical function 2) Add integration tests for user flows 3) Set up continuous testing 4) Aim for 80% coverage, not 100%" | sed 's/^/      /'
                ;;
            "dependency_debt")
                wrap_oracle_text "📋 **Immediate Actions:** 1) Audit unused dependencies 2) Update security-critical packages 3) Pin versions for stability 4) Consider alternatives to large dependencies" | sed 's/^/      /'
                ;;
            "security_debt")
                wrap_oracle_text "📋 **Immediate Actions:** 1) Run security audit tools 2) Update vulnerable dependencies 3) Review authentication logic 4) Validate all user inputs" | sed 's/^/      /'
                ;;
        esac
        echo
    done
    
    # Overall debt management strategy
    echo
    printf "    %-70s\n" "🗺️ DEBT MANAGEMENT STRATEGY"
    printf "    %-70s\n" "$(printf '─%.0s' {1..70})"
    echo
    
    case $DEBT_SEVERITY_LEVEL in
        "Critical")
            wrap_oracle_text "🚨 **Crisis Mode:** Your technical debt has reached critical mass. Consider declaring a 'tech debt sprint' - dedicate 25% of your development time to addressing the most severe issues. Create a debt register and tackle items systematically." | sed 's/^/    /'
            ;;
        "High")
            wrap_oracle_text "⚠️ **Action Required:** Your technical debt is accumulating faster than you can pay it down. Implement the 'Scout Rule' - leave the code better than you found it. Address one debt item per feature development cycle." | sed 's/^/    /'
            ;;
        "Moderate")
            wrap_oracle_text "📊 **Manageable:** Your technical debt is at normal levels for active development. Monitor it regularly and address items before they become blocking issues. Consider monthly 'debt cleanup' sessions." | sed 's/^/    /'
            ;;
        "Low")
            wrap_oracle_text "✅ **Well Managed:** Your technical debt is minimal and well-controlled. Continue your current practices and be vigilant about preventing new debt from accumulating." | sed 's/^/    /'
            ;;
    esac
    
    echo
}

# Fortune cookie style quick advice
QUICK_ORACLE_WISDOM=(
    "🥠 The bug you fear to face is the breadcrumb to your best architecture. Follow it with curiosity, not fury."
    "🥠 Your finest code often grows from yesterday's tragic merge. Treat failures like compost for brilliance."
    "🥠 The framework that confuses you today will feel like home after one patient weekend. Bring snacks."
    "🥠 Every senior developer was once a junior who shipped something imperfect and learned from it. Ship and learn."
    "🥠 Code needn't be flawless to be useful; it must be readable, testable, and deployed. Prioritize the triad."
    "🥠 The best time to learn a technology was yesterday. The second best time is while the CI runs."
    "🥠 Collaboration isn't simultaneous typing—it's shared ownership over the same problems. Pair, then document."
    "🥠 Your commit message is a time capsule. Leave breadcrumbs future-you can follow without a map."
    "🥠 The riskiest refactor is the one left untested. Back it with small, safe experiments."
    "🥠 Documentation is empathy in plain text. Write it for the sleep-deprived future reader."
    "🥠 A mystery log line is a riddle from the system. Read between timestamps and you'll find the solution."
    "🥠 Working code is useful; understandable code scales. Choose the latter when you can."
    "🥠 Your best debugging tool is a coherent process: reproduce, hypothesize, test, verify, then sleep."
    "🥠 Tests prevent regret; they are a promise to future-you that you cared enough to protect them."
    "🥠 The best engineers fail fast, learn faster, and remember to apologize to their console history."
    "🥠 A mysterious 500 error at 2AM is often just a missing environment variable and excessive confidence."
    "🥠 Semver arguments are inevitable; document the decision and move on."
    "🥠 The smallest entropy you remove today saves hours of grief tomorrow. Start with the smallest friction." 
)

# Append a couple of very subtle hint-like fortune lines to the quick wisdom pool
QUICK_ORACLE_WISDOM+=(
    "🥠 Subtle hint: old-school controller rhythms sometimes open doors in playful UIs."
    "🥠 Subtle hint: listen for retro map names during celebratory sequences."
)

# Maybe emit a subtle easter-egg hint (10% chance). Hints are intentionally vague
# and only shown during interactive TTY sessions so CI/judges aren't spoiled.
maybe_emit_hint_oracle() {
    # Don't show hints in non-interactive or machine modes
    if [[ -n "$GH_HOROSCOPE_NONINTERACTIVE" || ! -t 1 ]]; then
        return 0
    fi

    local roll=$((RANDOM % 100))
    if [[ $roll -lt 10 ]]; then
        local hints=(
            "🥠 Whisper: Wasn't gaming actually good years ago? Ko."
            "🥠 Whisper: 7some achievements recall cinematic code moments; listen closely.00"
            "🥠 Whisper: hidden zombie maps sometimes leave clues in celebration text."
        )
        local idx=$((RANDOM % ${#hints[@]}))
        echo
        echo "${YELLOW}${BOLD}${hints[$idx]}${RESET}"
        echo
    fi
}

# Safe helper: return a random element from a named array, or empty string if array is empty.
# Usage: safe_random_from_array ARRAY_NAME
safe_random_from_array() {
    local arr_name="$1"
    # Use nameref if available for clarity
    if declare -p "$arr_name" >/dev/null 2>&1; then
        # Create nameref to array
        local -n arr_ref="$arr_name"
        local count=${#arr_ref[@]}
        if [[ $count -eq 0 ]]; then
            echo ""
            return 0
        fi
        echo "${arr_ref[RANDOM % count]}"
        return 0
    else
        echo ""
        return 0
    fi
}

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

# Interactive project guidance session with multiple queries
run_project_guidance_session() {
    while true; do
        clear
        echo -e "                         ${CYAN}${BOLD}🎯 **Project Guidance Oracle:**${RESET}"
        echo
        echo -e "  ${CYAN}What type of guidance do you seek?${RESET}"
        echo -e "      ${BOLD}[new]${RESET} ${CYAN}- Starting a new project${RESET}"
        echo -e "      ${BOLD}[stuck]${RESET} ${CYAN}- Stuck on current project${RESET}"  
        echo -e "      ${BOLD}[scaling]${RESET} ${CYAN}- Scaling/performance issues${RESET}"
        echo -e "      ${BOLD}[choosing_tech]${RESET} ${CYAN}- Technology decisions${RESET}"
        echo
        echo -ne "${CYAN}Enter guidance type: ${RESET}"
        read guidance_type
        echo
        
        # Get project guidance response and display with modern formatting
        local project_response=$(give_project_guidance "$guidance_type")
        display_mystical_insight "🎯 Project Guidance Oracle" "$project_response"
        
        echo
        echo -ne "${CYAN}Would you like guidance on another project type? ${BOLD}[y/n]${RESET}${CYAN}: ${RESET}"
        read continue_choice
        
        case $continue_choice in
            [yY]|[yY][eE][sS])
                continue
                ;;
            *)
                clear
                echo -e "\n${CYAN}${BOLD}              🎯 **The Project Oracle's guidance session concludes...**${RESET}\n"
                echo -e "${GREEN}\"May your projects flourish and your code be ever clean!\"${RESET}"
                break
                ;;
        esac
    done
}

# GitHub Data-Driven Oracle Analysis
# This provides personalized mystical insights based on actual GitHub patterns

# Analyze GitHub data and provide specific oracle consultation
analyze_github_oracle() {
    local username="$1"
    local consultation_type="$2"
    
    # For demo users or when we have minimal data, proceed anyway for oracle consultations
    # Only block if we have no commit data AND it's not a demo user
    if [[ $TOTAL_COMMITS -eq 0 && "$username" != "demo-user" && -z "$REPO_COUNT" ]]; then
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
        "technical-debt")
            provide_technical_debt_consultation "$username"
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
    
    display_comedy_section "🔮 **CAREER GUIDANCE ORACLE** 🔮"
    
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
        display_section_header "📈 Repository Portfolio"
        wrap_oracle_text "Your $REPO_COUNT repositories show entrepreneurial spirit! Consider product management, startup CTO, or consultant roles where your broad experience will pay off." | sed 's/^/  /'
        echo
    elif [[ $ABANDONED_REPOS -gt $((REPO_COUNT / 2)) ]]; then
        display_section_header "🔍 Exploration Pattern"
        wrap_oracle_text "Your exploration pattern suggests you thrive on variety. Consulting, contracting, or roles with diverse project exposure will feed your curiosity and prevent boredom." | sed 's/^/  /'
        echo
    fi
}

# Debugging wisdom based on commit patterns and messages
provide_debugging_wisdom() {
    local username="$1"
    local night_percentage=$(get_night_owl_score)
    local commit_messages="${COMMIT_MESSAGES[*]}"
    
    display_comedy_section "🐛 **DEBUGGING WISDOM ORACLE** 🐛"
    
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
        display_section_header "🔧 Your Fix Pattern"
        wrap_oracle_text "$fix_frequency debugging-related commits suggest you're comfortable diving deep into problems. Channel this persistence into systematic debugging: reproduce, isolate, fix, test, document. Your tenacity is your debugging superpower!" | sed 's/^/  /'
        echo
    fi

    if [[ "$commit_messages" =~ (please.*work|why|help|broken) ]]; then
        display_section_header "😅 Desperation Pattern Detected"
        wrap_oracle_text "Your commit messages reveal the beautiful human struggle with code! Remember: every bug is a teacher. When frustrated, step back, rubber duck debug, or explain the problem to a friend. Clarity comes with distance." | sed 's/^/  /'
        echo
    fi
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
    # Ensure sane defaults to avoid division by zero
    if [[ -z "$REPO_COUNT" || "$REPO_COUNT" -eq 0 ]]; then
        REPO_COUNT=1
    fi
    if [[ -z "$ABANDONED_REPOS" ]]; then
        ABANDONED_REPOS=0
    fi
    local abandonment_ratio=$((ABANDONED_REPOS * 100 / REPO_COUNT))
    
    display_section_header "🎯 PROJECT FOCUS ORACLE"

    if [[ $abandonment_ratio -gt 70 ]]; then
        wrap_oracle_text "🌪️ The Project Tornado: $abandonment_ratio% of your projects show signs of abandonment - you're a beautiful storm of ideas! Channel this creativity: pick ONE project as your 'flagship' and commit to finishing it. Let other ideas be experiments, but have one project that showcases your ability to ship." | sed 's/^/  /'
    elif [[ $abandonment_ratio -gt 40 ]]; then
        wrap_oracle_text "🔍 The Explorer: $abandonment_ratio% abandonment suggests you love learning through doing! This curiosity is valuable, but consider maintaining 2-3 'showcase' projects alongside your experiments. Quality portfolio beats quantity of repos." | sed 's/^/  /'
    else
        wrap_oracle_text "🏆 The Finisher: Only $abandonment_ratio% abandonment shows impressive follow-through! Your consistency is your superpower. You're the person teams depend on to see things through. Use this reliability to take on increasingly ambitious projects." | sed 's/^/  /'
    fi

    if [[ $REPO_COUNT -gt 50 ]]; then
        echo
        display_section_header "📊 Repository Abundance"
        wrap_oracle_text "$REPO_COUNT repositories detected. Consider consolidating similar projects, archiving experiments, and highlighting your top 5-10 most representative works. Quality curation makes a stronger impression than quantity." | sed 's/^/  /'
    fi
}

# Coding rhythm analysis from temporal patterns
provide_coding_rhythm() {
    local username="$1"
    local night_percentage=$(get_night_owl_score)
    local weekend_percentage=$(get_weekend_warrior_score) 
    
    display_section_header "🕰️ CODING RHYTHM ORACLE"

    if [[ $night_percentage -gt 50 ]]; then
        wrap_oracle_text "🌙 Night Owl Flow: $night_percentage% nocturnal commits reveal your peak creative hours in darkness. Embrace this rhythm but protect your sleep! Consider focused deep work blocks at night, morning review sessions, and afternoon collaboration time." | sed 's/^/  /'
    elif [[ $night_percentage -lt 20 ]]; then
        wrap_oracle_text "🌅 Morning Warrior: $night_percentage% night commits show your discipline! Your fresh morning mind is your secret weapon. Schedule challenging problems for AM hours and use evenings for lighter tasks like documentation and planning." | sed 's/^/  /'
    else
        wrap_oracle_text "⚖️ Balanced Rhythm: Your $night_percentage% night coding shows healthy temporal distribution. You adapt your coding to your life instead of sacrificing life to code. This sustainability will serve you well in long-term projects." | sed 's/^/  /'
    fi

    if [[ $weekend_percentage -gt 40 ]]; then
        echo
        display_section_header "🎮 Weekend Creator"
        wrap_oracle_text "$weekend_percentage% weekend commits suggest you use free time for passion projects! Balance this with rest to maintain creativity. Consider: one full rest day, morning coding (fresh mind), evening social time." | sed 's/^/  /'
    fi

    echo
    display_section_header "💡 Rhythm Optimization"
    wrap_oracle_text "Track your best coding hours for a week. Schedule important work during peak energy times, mundane tasks during low energy. Your natural rhythm is your ally!" | sed 's/^/  /'
}

# Technical growth recommendations  
provide_technical_growth() {
    local username="$1"
    local archetype=$(analyze_developer_archetype "$username" "${COMMIT_MESSAGES[*]}" "$(get_night_owl_score)" "$(get_weekend_warrior_score)" "$REPO_COUNT")
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    
    display_section_header "🚀 TECHNICAL GROWTH ORACLE"

    case $archetype in
        *"Stack_Overflow_Shaman"*)
            wrap_oracle_text "📚 From Shaman to Sage: You excel at finding solutions! Next level: contribute answers to Stack Overflow, write technical blogs, or create educational content. Transform your solution-finding skills into solution-teaching skills." | sed 's/^/  /'
            ;;
        *"Perfectionist"*)
            wrap_oracle_text "🔍 From Perfectionist to Pragmatist: Your attention to detail is exceptional! Growth path: learn to balance perfection with delivery. Practice MVP thinking, time-boxing optimization tasks, and embracing 'good enough' iterations." | sed 's/^/  /'
            ;;
        *"Night_Owl"*|*"Vampire"*)
            wrap_oracle_text "🦉 Night Owl Evolution: Your dark hours coding shows dedication! Growth areas: async programming patterns, distributed systems (different timezone thinking), and mentoring others about deep focus techniques." | sed 's/^/  /'
            ;;
        *"Weekend_Warrior"*)
            wrap_oracle_text "⚔️ Weekend Warrior Advancement: Your passion projects show drive! Channel this energy into open source leadership, community building, or side business development. Your self-motivated work ethic is a leadership superpower." | sed 's/^/  /'
            ;;
        *)
            wrap_oracle_text "🌟 Unique Path Forward: Your coding patterns suggest a distinctive approach to development. Consider technical writing, conference speaking, or mentoring to share your unique perspective with the broader developer community." | sed 's/^/  /'
            ;;
    esac

    # Language-specific technical growth
    case $primary_lang in
        "JavaScript"|"TypeScript")
            echo
            wrap_oracle_text "🟡 JS/TS Technical Growth: Master advanced async patterns, contribute to open source frameworks, or explore edge computing with Deno/Bun. Consider WebAssembly for performance bridges." | sed 's/^/  /'
            ;;
        "Python") 
            echo
            wrap_oracle_text "🐍 Python Technical Growth: Dive into CPython internals, async programming, or scientific computing. Consider creating your own packages or contributing to major Python libraries." | sed 's/^/  /'
            ;;
        "Go"|"Rust")
            echo
            wrap_oracle_text "⚡ Systems Technical Growth: Explore distributed systems, contribute to major infrastructure projects, or build performance tools. Your systems knowledge is increasingly rare." | sed 's/^/  /'
            ;;
    esac

}

# Open source path recommendations
provide_open_source_path() {
    local username="$1"
    local karma_score=$((ISSUE_KARMA + PR_KARMA))
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"

    display_section_header "🌟 OPEN SOURCE PATH ORACLE"

    if [[ $karma_score -lt 50 ]]; then
        wrap_oracle_text "🌱 Open Source Seedling: Your journey begins now! Start with: Find a project you actively use and love; look for 'good first issue' or 'help wanted' labels; start with documentation improvements - always needed; fix typos, improve examples, or clarify confusing sections. Small contributions build confidence and community connections." | sed 's/^/  /'
    elif [[ $karma_score -lt 200 ]]; then
        wrap_oracle_text "🌿 Growing Contributor: Karma score $karma_score shows emerging involvement! Your next steps: take on feature implementations, not just fixes; review others' PRs - teaching builds your reputation; participate in project discussions and architecture decisions; consider maintaining a small library in your domain." | sed 's/^/  /'
    else
        wrap_oracle_text "🌳 Open Source Leader: Karma score $karma_score suggests significant contributions! Mentor new contributors, start your own project addressing a real problem, speak at conferences about your open source experience, and bridge communities between related projects." | sed 's/^/  /'
    fi

    # Language-specific open source opportunities
    case $primary_lang in
        "JavaScript"|"TypeScript")
            echo
            wrap_oracle_text "🟡 JS/TS Open Source: Contribute to npm packages, the React ecosystem, or build developer tools. The JS community rewards innovation and accessibility improvements." | sed 's/^/  /'
            ;;
        "Python")
            echo
            wrap_oracle_text "🐍 Python Open Source: PyPI needs maintainers! Scientific computing, web frameworks, and CLI tools are always evolving. Python's community values mentorship and documentation." | sed 's/^/  /'
            ;;
        "Go"|"Rust")
            echo
            wrap_oracle_text "⚡ Systems Open Source: Infrastructure projects need your expertise! Contribute to Kubernetes, databases, or performance tools where systems programmers make a big impact." | sed 's/^/  /'
            ;;
    esac

    echo
}

# Language mastery guidance
provide_language_mastery() {
    local username="$1"
    local primary_lang="${PRIMARY_LANGUAGES[0]:-Unknown}"
    local lang_count=${#PRIMARY_LANGUAGES[@]}
    local secondary_lang="${PRIMARY_LANGUAGES[1]:-None}"

    display_section_header "🎯 LANGUAGE MASTERY ORACLE"
    printf "    %-70s\n" "🔤 Primary Language: $primary_lang"
    if [[ "$secondary_lang" != "None" ]]; then
        printf "    %-70s\n" "🔤 Secondary Language: $secondary_lang"
    fi
    printf "    %-70s\n" "📊 Language Portfolio: $lang_count total languages"
    echo

    if [[ $lang_count -eq 1 ]]; then
        wrap_oracle_text "🏹 Single Language Mastery Path: Your focused approach to $primary_lang is commendable! Deep specialization strategy: Master advanced language features and idioms; contribute to the language ecosystem (tools, libraries); become a community expert through teaching and writing; learn a complementary language to broaden perspective." | sed 's/^/  /'
    elif [[ $lang_count -le 3 ]]; then
        wrap_oracle_text "⚖️ Balanced Mastery Path: Your $lang_count languages show thoughtful progression! Choose your mastery focus: Deep dive: Pick one for expert-level mastery; T-shaped: Broad knowledge, deep in your primary language; Bridge expert: Connect different language communities." | sed 's/^/  /'
    else
        wrap_oracle_text "🌈 Polyglot Excellence Path: Your $lang_count languages reveal adaptability mastery! Polyglot strategy: Study language design patterns; master multiple paradigms; build tools that bridge ecosystems; design architectures that leverage each language's strengths." | sed 's/^/  /'
    fi

    # Specific mastery advice for primary language
    echo
    case $primary_lang in
        "JavaScript")
            wrap_oracle_text "🟡 JavaScript Mastery: Async mastery, prototype chains, closures, and the event loop. Build tools, not just apps." | sed 's/^/  /'
            ;;
        "TypeScript") 
            wrap_oracle_text "🔷 TypeScript Mastery: Advanced types, generics, conditional types. You're at the cutting edge of type-safe JavaScript!" | sed 's/^/  /'
            ;;
        "Python")
            wrap_oracle_text "🐍 Python Mastery: Metaclasses, decorators, async/await, C extensions. Python's depth is bottomless - dive deep!" | sed 's/^/  /'
            ;;
        "Go")
            wrap_oracle_text "🔵 Go Mastery: Concurrency patterns, performance tuning, and the simplicity philosophy. Master the 'less is more' mindset." | sed 's/^/  /'
            ;;
        "Rust")
            wrap_oracle_text "🦀 Rust Mastery: Lifetime system, unsafe code, proc macros. You're wielding one of the most powerful tools in computing!" | sed 's/^/  /'
            ;;
        "Java")
            wrap_oracle_text "☕ Java Mastery: JVM internals, concurrency, and enterprise patterns. Your enterprise skills are in high demand!" | sed 's/^/  /'
            ;;
        "C++")
            wrap_oracle_text "⚡ C++ Mastery: Template metaprogramming, memory management, and modern C++ features. You speak the language of performance!" | sed 's/^/  /'
            ;;
        *)
            wrap_oracle_text "🌟 $primary_lang Mastery: Every language has hidden depths. Explore advanced features, contribute to community, and teach others." | sed 's/^/  /'
            ;;
    esac

    echo
}

# Interactive oracle session
display_oracle_header() {
    clear
    # Use sparkly title format like other modules
    echo -e "${MAGENTA}${BOLD}"
    echo "                                👥 🤝 👥 🤝 👥"
    echo "                       🌟 🤝 TEAMWORK ORACLE WISDOM 🤝 🌟"
    echo "                                👥 🤝 👥 🤝 👥"
    echo
    echo "                      🔮 Ancient Coding Wisdom Revealed 🔮"
    echo -e "${RESET}"
}

# Oracle menu display is now handled by display.sh

ask_technical_question() {
    clear
    echo -e "${CYAN}${BOLD}🔮 **The Oracle listens to your technical question...**${RESET}"
    echo
    echo -ne "${CYAN}🗣️ What technical challenge troubles your code-spirit? ${RESET}"
    read question
    echo
    echo -e "${CYAN}⏳ The Oracle communes with the ancient servers...${RESET}"
    sleep 2
    echo
    
    # Show Oracle consultation loading
    display_oracle_loading "Consulting the ancient coding wisdom" 2
    
    # Clear screen after loading, like other Oracle options
    clear
    
    # Analyze question and provide contextual response
    local response=""
    # Convert question to lowercase for better matching
    local lower_question=$(echo "$question" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$lower_question" =~ (git|merge|conflict|branch|pull|push|commit|rebase) ]]; then
        response="${TECHNICAL_ORACLE[git_conflicts]}"
    elif [[ "$lower_question" =~ (test|testing|unit|integration|spec|tdd|coverage) ]]; then
        response="${TECHNICAL_ORACLE[testing]}"
    elif [[ "$lower_question" =~ (debug|debugging|bug|error|issue|problem|broken|fix|troubleshoot) ]]; then
        response="${TECHNICAL_ORACLE[debugging]}"
    elif [[ "$lower_question" =~ (performance|slow|speed|optimize|fast|memory|cpu|lag) ]]; then
        response="${TECHNICAL_ORACLE[performance]}"
    elif [[ "$lower_question" =~ (security|auth|vulnerability|encrypt|secure|hack|safe) ]]; then
        response="${TECHNICAL_ORACLE[security]}"
    elif [[ "$lower_question" =~ (documentation|docs|comment|readme|document|explain) ]]; then
        response="${TECHNICAL_ORACLE[documentation]}"
    elif [[ "$lower_question" =~ (review|pr|pull.*request|code.*review|feedback) ]]; then
        response="${TECHNICAL_ORACLE[code_review]}"
    elif [[ "$lower_question" =~ (learn|learning|start|starting|begin|beginning|new|beginner|first) ]]; then
        response="${TECHNICAL_ORACLE[learning]}"
    elif [[ "$lower_question" =~ (career|job|work|professional|interview|resume|junior|senior) ]]; then
        response="${TECHNICAL_ORACLE[career_start]}"
    else
        # Generic wisdom based on question sentiment
        if [[ "$lower_question" =~ (help|stuck|confused|lost|don.*know|struggling|difficult) ]]; then
            response="🔮 **The Oracle sees your confusion:** When lost in the forest of code, climb the tallest tree of understanding. Sometimes the path forward requires stepping back to see the bigger picture. Your confusion is not weakness - it's the beginning of clarity."
        elif [[ "$lower_question" =~ (best.*practice|should|how.*to|recommend|advice|suggest) ]]; then
            response="🔮 **The Oracle shares ancient wisdom:** The best practice is the one your team can consistently follow. Code for humans first, computers second. When in doubt, choose the solution that will be most understandable at 3 AM six months from now."
        else
            response="🔮 **The Oracle reflects:** '${question}' - A worthy question that shows wisdom in the asking. The answer you seek lies not just in knowing the 'what', but understanding the 'why'. Research deeply, experiment safely, and trust your growing intuition."
        fi
    fi
    
    display_mystical_insight "🧙‍♂️  The Oracle Responds" "$response"
    # Maybe emit an additional hint for curious seekers
    maybe_emit_hint_oracle || true
}

run_oracle_session() {
    display_oracle_header
    
    # Check if running in interactive mode
    if [[ ! -t 0 ]]; then
        echo "⚠️  Non-interactive mode detected. Providing random oracle wisdom..."
        echo
    local random_wisdom=$(safe_random_from_array QUICK_ORACLE_WISDOM)
        display_oracle_art "default"
        display_mystical_insight "🥠 Oracle Wisdom" "$random_wisdom"
        return 0
    fi
    
    while true; do
        display_oracle_menu
        echo -n "🔮 Choose your question for the Oracle (1-15): "
        read choice
        echo
        
        case $choice in
            1)
                clear
                display_oracle_art "debugging"
                display_mystical_insight "🐛 Oracle of Debugging" "${ORACLE_RESPONSES[debugging]}"
                ;;
            2)
                clear
                display_oracle_art "career"
                display_mystical_insight "💼 Career Oracle" "${ORACLE_RESPONSES[career]}"
                ;;
            3)
                clear
                display_oracle_art "learning"
                display_mystical_insight "📚 Learning Oracle" "${ORACLE_RESPONSES[learning]}"
                ;;
            4)
                clear
                display_oracle_art "teamwork"
                display_mystical_insight "👥 Teamwork Oracle" "${ORACLE_RESPONSES[teamwork]}"
                ;;
            5)
                clear
                display_oracle_art "burnout"
                display_mystical_insight "🔥 Burnout Oracle" "${ORACLE_RESPONSES[burnout]}"
                ;;
            6)
                clear
                display_oracle_art "confidence"
                display_mystical_insight "👤 Confidence Oracle" "${ORACLE_RESPONSES[imposter_syndrome]}"
                ;;
            7)
                clear
                display_oracle_art "technology"
                display_mystical_insight "🛠️ Technology Oracle" "${ORACLE_RESPONSES[technology_choice]}"
                ;;
            8)
                clear
                display_oracle_art "legacy"
                display_mystical_insight "🏛️ Legacy Code Oracle" "${ORACLE_RESPONSES[legacy_code]}"
                ;;
            9)
                clear
                display_oracle_art "projects"
                display_mystical_insight "🚀 Side Project Oracle" "${ORACLE_RESPONSES[side_projects]}"
                ;;
            10)
                clear
                display_oracle_art "opensource"
                display_mystical_insight "🌟 Open Source Oracle" "${ORACLE_RESPONSES[open_source]}"
                ;;
            11)
                clear
                local random_wisdom=$(safe_random_from_array QUICK_ORACLE_WISDOM)
                display_oracle_art "default"
                display_mystical_insight "🥠 Quick Oracle Wisdom" "$random_wisdom"
                ;;
            12)
                clear
                local random_mantra=$(safe_random_from_array CODING_MANTRAS)
                display_oracle_art "default"
                display_mystical_insight "🧘 Today's Coding Mantra" "$random_mantra"
                ;;
            13)
                ask_technical_question
                ;;
            14)
                run_project_guidance_session
                ;;
            15)
                clear
                echo -e "${CYAN}${BOLD}        🚪 **The Oracle fades into the digital mist...**${RESET}"
                echo
                echo -e "${MAGENTA}${BOLD}\"Remember, seeker: The wisdom was within you all along.\"${RESET}"
                echo -e "${MAGENTA}${BOLD}\"I merely helped you find the words for what you already knew.\"${RESET}"
                echo
                echo -e "${CYAN}${BOLD}       ✨ May your code compile and your logic flow true! ✨${RESET}"
                return 0
                ;;
            *)
                echo "❓ The Oracle does not understand. Please choose 1-15."
                ;;
        esac
        echo
        echo -n "Press Enter to continue your consultation..."
        read
        clear
        echo
    done
}