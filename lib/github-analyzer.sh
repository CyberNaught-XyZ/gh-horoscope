#!/bin/bash

# GitHub Analyzer module for GitHub CLI Horoscope Extension
# Fetches and analyzes GitHub user data for mystical insights

# Global variables to store analysis results
declare -g USER_DATA
declare -g REPOS_DATA
declare -g COMMITS_DATA
declare -g NIGHT_OWL_COUNT=0
declare -g WEEKEND_COMMITS=0
declare -g TOTAL_COMMITS=0
declare -g COMMIT_MESSAGES=()
declare -g PRIMARY_LANGUAGES=()
declare -g REPO_COUNT=0
declare -g ABANDONED_REPOS=0
declare -g EMOJI_COUNT=0
declare -g ISSUE_KARMA=0
declare -g PR_KARMA=0

# Check GitHub CLI authentication
check_github_auth() {
    if ! gh auth status &>/dev/null; then
        return 1
    fi
    return 0
}

# Check if user exists and is accessible
check_user_exists() {
    local username="$1"
    
    # First check if we can authenticate
    if ! check_github_auth; then
        echo "GitHub CLI not authenticated. Some features may be limited." >&2
        return 2
    fi
    
    if gh api "users/$username" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Fetch basic user information
fetch_user_data() {
    local username="$1"
    
    display_github_loading "Fetching user profile data" 2
    
    USER_DATA=$(gh api "users/$username" 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    return 0
}

# Fetch user repositories
fetch_repos_data() {
    local username="$1"
    
    display_crystal_ball_loading "Analyzing repository constellation" 3
    
    # Fetch user's repositories (public ones)
    REPOS_DATA=$(gh api "users/$username/repos" --paginate --jq '.[] | select(.fork == false)' 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    # Count total repositories
    REPO_COUNT=$(echo "$REPOS_DATA" | jq -s 'length')
    
    # Count abandoned repositories (no activity in last 6 months)
    local six_months_ago=$(date -d '6 months ago' --iso-8601)
    ABANDONED_REPOS=$(echo "$REPOS_DATA" | jq -r --arg date "$six_months_ago" 'select(.updated_at < $date)' | jq -s 'length')
    
    # Extract primary languages
    local languages_json=$(echo "$REPOS_DATA" | jq -r 'select(.language != null) | .language' | sort | uniq -c | sort -nr | head -5)
    if [[ -n "$languages_json" ]]; then
        readarray -t PRIMARY_LANGUAGES < <(echo "$languages_json" | awk '{print $2}')
    fi
    
    return 0
}

# Analyze commit patterns from recent repositories
analyze_commit_patterns() {
    local username="$1"
    
    display_oracle_loading "Deciphering commit mysteries" 4
    
    # Get up to 10 most recently updated repositories for commit analysis
    local recent_repos=$(echo "$REPOS_DATA" | jq -r 'select(.size > 0) | .name' | head -10)
    
    TOTAL_COMMITS=0
    NIGHT_OWL_COUNT=0
    WEEKEND_COMMITS=0
    EMOJI_COUNT=0
    local commit_messages_raw=""
    
    while IFS= read -r repo; do
        [[ -z "$repo" ]] && continue
        
        # Get recent commits from this repo
        local commits=$(gh api "repos/$username/$repo/commits" --paginate --jq '.[0:50]' 2>/dev/null || echo "[]")
        
        if [[ "$commits" != "[]" && -n "$commits" ]]; then
            # Count total commits
            local repo_commit_count=$(echo "$commits" | jq '. | length')
            TOTAL_COMMITS=$((TOTAL_COMMITS + repo_commit_count))
            
            # Analyze commit times and messages
            while IFS= read -r commit_data; do
                [[ -z "$commit_data" ]] && continue
                
                local commit_date=$(echo "$commit_data" | jq -r '.commit.author.date')
                local commit_message=$(echo "$commit_data" | jq -r '.commit.message')
                
                # Skip if no valid data
                [[ "$commit_date" == "null" || "$commit_message" == "null" ]] && continue
                
                # Check if night owl (commits between 10 PM and 6 AM)
                local hour=$(date -d "$commit_date" +%H 2>/dev/null || echo "12")
                if [[ "$hour" -ge 22 || "$hour" -le 6 ]]; then
                    NIGHT_OWL_COUNT=$((NIGHT_OWL_COUNT + 1))
                fi
                
                # Check for weekend commits
                local day=$(date -d "$commit_date" +%u 2>/dev/null || echo "1")
                if [[ "$day" -ge 6 ]]; then
                    WEEKEND_COMMITS=$((WEEKEND_COMMITS + 1))
                fi
                
                # Count emojis in commit messages
                local emoji_in_message=$(echo "$commit_message" | grep -o '[🔥💥✨🎉🚀🐛🎨📝🔧⚡🗑️💡🚨🔀📦🎯💎🌟⭐🎪🎭🎨🎬🎮🎲🎸🎵🎶💻📱⌨️🖥️💿📀💾💽🎞️📹📷📺📻🔊🔇🔈🔉🎤🎧📢📣📯🔔🔕📳📴💰💎💍💸💳💲💱💹💫⭐🌟✨⚡☄️🔥💥💫🌙☀️⛅🌈🌍🌎🌏🌋🗻🏔️⛰️🏕️🏞️🌲🌳🌴🌱🌿🍀🎋🎍🍃🍂🍁🍄🌾🌺🌻🌷🌸💐🌹🥀🌼🌵🐱🐶🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐽🐸🐵🙈🙉🙊🦄🐴🦓🦒🦔🐣🐤🐥🐦🐧🕊️🦅🦆🦢🦉🦚🦜🐢🐍🦎🐙🦑🦐🦀🐡🐠🐟🐬🐳🐋🦈🐊🐆🐅🐃🐂🐄🦏🐪🐫🦌🦓🐎🐖🐗🐏🐑🐐🐕🐩🐈🦮🐕‍🦺🐅🐆🐯🦁🐻🐼🐨🐵🦍🦧🐒🦮🦺🌭🍔🍟🍕🌮🌯🥙🥗🥘🍝🍜🍲🍛🍣🍱🍤🍙🍚🍘🍥🍢🍡🍧🍨🍦🎂🧁🍰🎂🍮🍯🍼☕🍵🥤🍶🍾🥂🍻🍺🍷🥃🍸🍹🧃🧉🧊]' | wc -l)
                EMOJI_COUNT=$((EMOJI_COUNT + emoji_in_message))
                
                # Collect commit messages for analysis
                commit_messages_raw+="$commit_message"$'\n'
                
            done < <(echo "$commits" | jq -c '.[]')
        fi
    done < <(echo "$recent_repos")
    
    # Store commit messages for later analysis
    if [[ -n "$commit_messages_raw" ]]; then
        readarray -t COMMIT_MESSAGES < <(echo "$commit_messages_raw" | head -100)
    fi
    
    return 0
}

# Analyze GitHub karma (issues and PRs)
analyze_github_karma() {
    local username="$1"
    
    display_github_loading "Calculating GitHub karma balance" 3
    
    # This is a simplified karma analysis since we can't easily access all user's comments
    # In a real implementation, you'd analyze issue/PR comments, but that requires more API calls
    
    # For now, we'll base karma on public activity
    local public_repos=$(echo "$USER_DATA" | jq -r '.public_repos // 0')
    local followers=$(echo "$USER_DATA" | jq -r '.followers // 0')
    
    # Simple karma calculation based on available data
    ISSUE_KARMA=$((public_repos * 2 + followers / 10))
    PR_KARMA=$((public_repos * 3 + followers / 5))
    
    return 0
}

# Main analysis function
analyze_github_user() {
    local username="$1"
    
    # Check if user exists
    local user_check_result
    check_user_exists "$username"
    user_check_result=$?
    
    if [[ $user_check_result -eq 2 ]]; then
        # GitHub CLI not authenticated - provide offline demo
        display_warning "GitHub CLI not authenticated. Generating demonstration horoscope..."
        display_info "To get real data, run: gh auth login"
        echo
        
        # Set demo data
        USER_DATA='{"login":"'$username'","name":"Demo User","bio":"Demo profile for horoscope","followers":42,"following":13,"public_repos":7,"location":"The Cloud"}'
        REPO_COUNT=7
        ABANDONED_REPOS=2
        TOTAL_COMMITS=156
        NIGHT_OWL_COUNT=47
        WEEKEND_COMMITS=23
        EMOJI_COUNT=12
        ISSUE_KARMA=15
        PR_KARMA=25
        PRIMARY_LANGUAGES=("JavaScript" "Python" "Go")
        COMMIT_MESSAGES=("fix stuff" "update code" "debugging session" "it works now" "refactor module" "please work" "final attempt")
        ALL_COMMIT_MESSAGES="fix stuff update code debugging session it works now refactor module please work final attempt"
        
        return 0
    elif [[ $user_check_result -eq 1 ]]; then
        display_error "User '$username' not found or not accessible"
        return 1
    fi
    
    # Fetch user data
    if ! fetch_user_data "$username"; then
        display_error "Failed to fetch user data"
        return 1
    fi
    
    # Fetch repositories data
    if ! fetch_repos_data "$username"; then
        display_error "Failed to fetch repository data"
        return 1
    fi
    
    # Analyze commit patterns
    if ! analyze_commit_patterns "$username"; then
        display_error "Failed to analyze commit patterns"
        return 1
    fi
    
    # Analyze GitHub karma
    if ! analyze_github_karma "$username"; then
        display_error "Failed to analyze GitHub karma"
        return 1
    fi
    
    display_success "✨ Analysis complete! The patterns are revealed..."
    echo
    
    return 0
}

# Advanced Pattern Detection Algorithms

# Detect stress patterns in commit messages
detect_stress_patterns() {
    local -a messages=("$@")
    local stress_indicators=("fix" "Fix" "FIX" "hotfix" "urgent" "emergency" "critical" "broken" "bug" "error")
    local stressed_commits=0
    local total_messages=${#messages[@]}
    
    for message in "${messages[@]}"; do
        for indicator in "${stress_indicators[@]}"; do
            if [[ "$message" =~ $indicator ]]; then
                ((stressed_commits++))
                break
            fi
        done
    done
    
    if [[ $total_messages -gt 0 ]]; then
        echo $(( (stressed_commits * 100) / total_messages ))
    else
        echo 0
    fi
}

# Analyze perfectionist tendencies
analyze_perfectionist_patterns() {
    local -a messages=("$@")
    local perfectionist_words=("final" "Final" "perfect" "clean" "refactor" "optimize" "improve" "polish" "cleanup")
    local perfectionist_score=0
    
    for message in "${messages[@]}"; do
        for word in "${perfectionist_words[@]}"; do
            if [[ "$message" =~ $word ]]; then
                ((perfectionist_score++))
                break
            fi
        done
    done
    
    echo $perfectionist_score
}

# Detect confidence patterns in commit messages
detect_confidence_patterns() {
    local -a messages=("$@")
    local confidence_indicators=()
    local low_confidence=("sorry" "maybe" "try" "attempt" "think" "might" "probably")
    local high_confidence=("implement" "add" "create" "build" "complete" "done" "finished")
    
    local low_conf_count=0
    local high_conf_count=0
    
    for message in "${messages[@]}"; do
        for indicator in "${low_confidence[@]}"; do
            if [[ "$message" =~ $indicator ]]; then
                ((low_conf_count++))
                break
            fi
        done
        
        for indicator in "${high_confidence[@]}"; do
            if [[ "$message" =~ $indicator ]]; then
                ((high_conf_count++))
                break
            fi
        done
    done
    
    if [[ $high_conf_count -gt $low_conf_count ]]; then
        echo "confident"
    elif [[ $low_conf_count -gt $high_conf_count ]]; then
        echo "uncertain"
    else
        echo "balanced"
    fi
}

# Detect work-in-progress patterns
detect_wip_patterns() {
    local -a messages=("$@")
    local wip_indicators=("wip" "WIP" "work in progress" "todo" "TODO" "temp" "temporary" "draft")
    local wip_count=0
    
    for message in "${messages[@]}"; do
        for indicator in "${wip_indicators[@]}"; do
            if [[ "$message" =~ $indicator ]]; then
                ((wip_count++))
                break
            fi
        done
    done
    
    echo $wip_count
}

# Advanced repository behavioral analysis
analyze_repository_behavior() {
    local username="$1"
    local readme_quality=0
    local has_issues_template=0
    local branch_naming_style="standard"
    local release_frequency="unknown"
    
    # This would analyze README quality, issue templates, etc. in real implementation
    # For demo, we'll use placeholder logic
    readme_quality=$((RANDOM % 10 + 1))  # 1-10 scale
    
    echo "readme_quality:$readme_quality,issue_template:$has_issues_template,branches:$branch_naming_style,releases:$release_frequency"
}

# Detect crisis coding patterns (emergency commits)
detect_crisis_patterns() {
    local -a messages=("$@")
    local crisis_indicators=("hotfix" "urgent" "critical" "emergency" "production" "down" "broken" "fix asap")
    local crisis_commits=0
    
    for message in "${messages[@]}"; do
        for indicator in "${crisis_indicators[@]}"; do
            if [[ "$message" =~ $indicator ]]; then
                ((crisis_commits++))
                break
            fi
        done
    done
    
    echo $crisis_commits
}

# Analyze emotional patterns in commit messages
analyze_emotional_patterns() {
    local -a messages=("$@")
    local positive_emotions=("awesome" "great" "amazing" "love" "happy" "excited" "perfect" "excellent")
    local negative_emotions=("hate" "frustrated" "annoying" "stupid" "terrible" "awful" "sucks")
    local neutral_emotions=("update" "change" "modify" "adjust" "tweak")
    
    local positive_count=0
    local negative_count=0
    local neutral_count=0
    
    for message in "${messages[@]}"; do
        local classified=false
        
        for emotion in "${positive_emotions[@]}"; do
            if [[ "$message" =~ $emotion ]] && [[ $classified == false ]]; then
                ((positive_count++))
                classified=true
                break
            fi
        done
        
        if [[ $classified == false ]]; then
            for emotion in "${negative_emotions[@]}"; do
                if [[ "$message" =~ $emotion ]]; then
                    ((negative_count++))
                    classified=true
                    break
                fi
            done
        fi
        
        if [[ $classified == false ]]; then
            ((neutral_count++))
        fi
    done
    
    echo "positive:$positive_count,negative:$negative_count,neutral:$neutral_count"
}

# Getter functions for analysis results
get_user_info() {
    local field="$1"
    echo "$USER_DATA" | jq -r ".$field // \"N/A\""
}

get_night_owl_score() {
    if [[ $TOTAL_COMMITS -gt 0 ]]; then
        echo $(( (NIGHT_OWL_COUNT * 100) / TOTAL_COMMITS ))
    else
        echo 0
    fi
}

get_weekend_warrior_score() {
    if [[ $TOTAL_COMMITS -gt 0 ]]; then
        echo $(( (WEEKEND_COMMITS * 100) / TOTAL_COMMITS ))
    else
        echo 0
    fi
}

get_primary_language() {
    if [[ ${#PRIMARY_LANGUAGES[@]} -gt 0 ]]; then
        echo "${PRIMARY_LANGUAGES[0]}"
    else
        echo "Polyglot"
    fi
}

get_repo_diversity_score() {
    if [[ ${#PRIMARY_LANGUAGES[@]} -gt 1 ]]; then
        echo $((${#PRIMARY_LANGUAGES[@]} * 20))
    else
        echo 10
    fi
}

get_commitment_level() {
    local abandoned_ratio=0
    if [[ $REPO_COUNT -gt 0 ]]; then
        abandoned_ratio=$(( (ABANDONED_REPOS * 100) / REPO_COUNT ))
    fi
    
    if [[ $abandoned_ratio -lt 20 ]]; then
        echo "Highly Committed"
    elif [[ $abandoned_ratio -lt 50 ]]; then
        echo "Moderately Committed"
    else
        echo "Explorer of Ideas"
    fi
}

get_emoji_personality() {
    if [[ $EMOJI_COUNT -gt 50 ]]; then
        echo "Expressive Communicator 🎭"
    elif [[ $EMOJI_COUNT -gt 20 ]]; then
        echo "Balanced Expressionist 🎨"
    elif [[ $EMOJI_COUNT -gt 5 ]]; then
        echo "Subtle Communicator 📝"
    else
        echo "Minimalist Coder 🗿"
    fi
}

# Debug function to show analysis results
show_analysis_debug() {
    echo "=== DEBUG: Analysis Results ==="
    echo "Total Commits: $TOTAL_COMMITS"
    echo "Night Owl Commits: $NIGHT_OWL_COUNT"
    echo "Weekend Commits: $WEEKEND_COMMITS"
    echo "Repository Count: $REPO_COUNT"
    echo "Abandoned Repos: $ABANDONED_REPOS"
    echo "Primary Languages: ${PRIMARY_LANGUAGES[*]}"
    echo "Emoji Count: $EMOJI_COUNT"
    echo "Issue Karma: $ISSUE_KARMA"
    echo "PR Karma: $PR_KARMA"
    echo "=============================="
}

# Analyze developer archetype based on coding patterns
analyze_developer_archetype() {
    local username="$1"
    local commit_messages="$2"
    local night_percentage="$3"
    local weekend_percentage="$4"
    local repo_count="$5"
    
    # Calculate additional metrics for more sophisticated detection
    local user_hash=$(echo "$username" | cksum | cut -d' ' -f1)
    local primary_languages="${PRIMARY_LANGUAGES[*]}"
    local total_commits=$TOTAL_COMMITS
    
    # Advanced archetype detection based on multiple factors
    
    # Night coding patterns
    if [[ $night_percentage -gt 80 && "$commit_messages" =~ (3am|midnight|late|night|vampire) ]]; then
        echo "The_Commit_Vampire"
    elif [[ $night_percentage -gt 70 && "$commit_messages" =~ (fix|bug|error|debug) ]]; then
        echo "The_Shadow_Coder"
    
    # Death and resurrection patterns    
    elif [[ "$commit_messages" =~ (resurrect|revive|restore|bring.*back|necromancy) ]] || [[ $repo_count -gt 50 && "$commit_messages" =~ (old|legacy|ancient) ]]; then
        echo "The_Code_Necromancer"
    
    # Documentation patterns
    elif [[ "$commit_messages" =~ (readme|docs|documentation|comment|explain) ]] && [[ $(($user_hash % 10)) -gt 6 ]]; then
        echo "The_Documentation_Ghost"
    
    # Conflict resolution and git mastery
    elif [[ "$commit_messages" =~ (merge|conflict|rebase|cherry.*pick|resolve) ]] && [[ $repo_count -gt 30 ]]; then
        echo "The_Merge_Conflict_Oracle"
    
    # Framework and library usage
    elif [[ "$primary_languages" =~ (JavaScript|TypeScript) ]] && [[ "$commit_messages" =~ (react|angular|vue|framework|library) ]]; then
        echo "The_Framework_Druid"
    
    # Terminal and command line focus
    elif [[ "$commit_messages" =~ (cli|terminal|command|bash|shell|vim) ]] || [[ "$primary_languages" =~ (Shell|Bash) ]]; then
        echo "The_Terminal_Monk"
    
    # Open source dedication
    elif [[ "$commit_messages" =~ (open.*source|mit|license|contribute|community) ]] && [[ $repo_count -gt 15 ]]; then
        echo "The_Open_Source_Paladin"
    
    # Microservices and containers
    elif [[ "$commit_messages" =~ (docker|container|microservice|kubernetes|k8s|service) ]]; then
        echo "The_Microservice_Alchemist"
    
    # Database focus
    elif [[ "$commit_messages" =~ (sql|database|db|query|schema|migration) ]] || [[ "$primary_languages" =~ (SQL|PostgreSQL|MySQL) ]]; then
        echo "The_Database_Warlock"
    
    # Frontend specialization
    elif [[ "$primary_languages" =~ (CSS|HTML|JavaScript) ]] && [[ "$commit_messages" =~ (style|design|ui|frontend|css) ]]; then
        echo "The_Frontend_Enchantress"
    
    # Backend focus
    elif [[ "$primary_languages" =~ (Java|Python|Go|Rust|C\+\+) ]] && [[ "$commit_messages" =~ (api|server|backend|endpoint) ]]; then
        echo "The_Backend_Hermit"
    
    # DevOps and infrastructure
    elif [[ "$commit_messages" =~ (deploy|ci|cd|pipeline|aws|cloud|infrastructure) ]]; then
        echo "The_DevOps_Sage"
    
    # API development
    elif [[ "$commit_messages" =~ (api|endpoint|rest|graphql|swagger|openapi) ]] && [[ $repo_count -gt 10 ]]; then
        echo "The_API_Bard"
    
    # Code review patterns
    elif [[ "$commit_messages" =~ (review|pr|pull.*request|feedback|approve) ]]; then
        echo "The_Code_Review_Judge"
    
    # Project management
    elif [[ "$commit_messages" =~ (sprint|scrum|agile|story|epic|milestone) ]]; then
        echo "The_Sprint_Planning_Prophet"
    
    # Legacy code
    elif [[ "$commit_messages" =~ (legacy|old|ancient|cobol|fortran|maintain) ]]; then
        echo "The_Legacy_Code_Archaeologist"
    
    # Hotfixes and emergencies
    elif [[ "$commit_messages" =~ (hotfix|emergency|urgent|critical|prod|production) ]]; then
        echo "The_Hotfix_Firefighter"
    
    # Testing focus
    elif [[ "$commit_messages" =~ (test|spec|coverage|unit|integration|e2e) ]]; then
        echo "The_Test_Coverage_Zealot"
    
    # Performance optimization
    elif [[ "$commit_messages" =~ (optimize|performance|speed|fast|efficient|benchmark) ]]; then
        echo "The_Performance_Mystic"
    
    # Security focus
    elif [[ "$commit_messages" =~ (security|auth|encrypt|secure|vulnerability|CVE) ]]; then
        echo "The_Security_Guardian"
    
    # Mobile development
    elif [[ "$primary_languages" =~ (Swift|Kotlin|Java|Dart) ]] && [[ "$commit_messages" =~ (ios|android|mobile|app) ]]; then
        echo "The_Mobile_Shapeshifter"
    
    # AI and ML
    elif [[ "$primary_languages" =~ (Python|R|Julia) ]] && [[ "$commit_messages" =~ (ai|ml|neural|model|train|algorithm) ]]; then
        echo "The_AI_Whisperer"
    
    # Blockchain
    elif [[ "$commit_messages" =~ (blockchain|crypto|smart.*contract|ethereum|bitcoin|web3) ]]; then
        echo "The_Blockchain_Evangelist"
    
    # Gaming
    elif [[ "$commit_messages" =~ (game|unity|unreal|graphics|3d|animation) ]] || [[ "$primary_languages" =~ (C#|C\+\+) ]]; then
        echo "The_Gaming_Conjurer"
    
    # Data science
    elif [[ "$primary_languages" =~ (Python|R|Jupyter) ]] && [[ "$commit_messages" =~ (data|analysis|model|stats|pandas|numpy) ]]; then
        echo "The_Data_Scientist_Sage"
    
    # Embedded systems
    elif [[ "$primary_languages" =~ (C|C\+\+|Rust|Assembly) ]] && [[ "$commit_messages" =~ (embedded|firmware|iot|hardware) ]]; then
        echo "The_Embedded_Sorcerer"
    
    # Cloud architecture
    elif [[ "$commit_messages" =~ (serverless|lambda|function|cloud|aws|azure|gcp) ]]; then
        echo "The_Cloud_Architect"
    
    # UX focus
    elif [[ "$commit_messages" =~ (ux|user.*experience|usability|design|interface) ]]; then
        echo "The_UX_Empath"
    
    # Regex mastery
    elif [[ "$commit_messages" =~ (regex|regexp|pattern|match|parse|extract) ]]; then
        echo "The_Regex_Wizard"
    
    # Git mastery
    elif [[ "$commit_messages" =~ (git|branch|commit|push|pull|clone|fork) ]] && [[ $repo_count -gt 40 ]]; then
        echo "The_Version_Control_Timekeeper"
    
    # Package management
    elif [[ "$commit_messages" =~ (package|dependency|npm|pip|cargo|maven|gradle) ]]; then
        echo "The_Dependency_Manager"
    
    # Infrastructure
    elif [[ "$commit_messages" =~ (infrastructure|server|deploy|provision|terraform) ]]; then
        echo "The_Infrastructure_Shaman"
    
    # Code poetry
    elif [[ "$commit_messages" =~ (beautiful|elegant|clean|art|poetry|graceful) ]]; then
        echo "The_Code_Poet"
    
    # Startup speed
    elif [[ $total_commits -gt 1000 && "$commit_messages" =~ (mvp|launch|ship|release|fast) ]]; then
        echo "The_Startup_Hustler"
    
    # Enterprise patterns
    elif [[ "$primary_languages" =~ (Java|C#|Enterprise) ]] && [[ "$commit_messages" =~ (enterprise|corporate|business|scale) ]]; then
        echo "The_Enterprise_Architect"
    
    # Solo projects
    elif [[ $repo_count -gt 20 && "$commit_messages" =~ (solo|indie|personal|side.*project) ]]; then
        echo "The_Indie_Hacker"
    
    # Chaos patterns
    elif [[ "$commit_messages" =~ (stuff|changes|idk|whatever|fix|work|magic) ]] && [[ $(($RANDOM % 10)) -gt 6 ]]; then
        echo "The_Chaos_Magician"
    
    # Perfectionist patterns
    elif [[ "$commit_messages" =~ (implement|add|create|feature|refactor|optimize|clean|improve|enhance) ]] && [[ $night_percentage -lt 20 ]]; then
        echo "The_Perfectionist_Oracle"
    
    # Refactoring focus
    elif [[ "$commit_messages" =~ (refactor|optimize|clean|improve|enhance|restructure) ]] && [[ $repo_count -gt 20 ]]; then
        echo "The_Refactor_Reaper"
    
    # Bug hunting
    elif [[ $weekend_percentage -gt 50 && $night_percentage -gt 50 ]] && [[ "$commit_messages" =~ (bug|fix|debug) ]]; then
        echo "The_Bug_Whisperer"
    
    # Default to Stack Overflow Shaman
    else
        echo "The_Stack_Overflow_Shaman"
    fi
}

# Analyze commit message mystique category
analyze_commit_mystique() {
    local commit_messages="$1"
    
    # Count patterns in commit messages
    local desperate_count=$(echo "$commit_messages" | grep -i -c -E "(please|help|why|hate|kill|die|broken|fix.*please|work.*please|god|damn)" || true)
    local confident_count=$(echo "$commit_messages" | grep -i -c -E "(implement|add.*feature|optimize|enhance|complete|finish|deploy)" || true)
    local chaotic_count=$(echo "$commit_messages" | grep -i -c -E "(stuff|things|changes|idk|whatever|random|misc|various)" || true)
    local cryptic_count=$(echo "$commit_messages" | grep -i -c -E "(the.*knows|it.*understands|fixed.*knowing|magic|mystery|secret)" || true)
    local poetic_count=$(echo "$commit_messages" | grep -i -c -E "(gently|softly|gracefully|elegantly|beautiful|harmony|balance)" || true)
    
    # Determine dominant category
    local max_count=0
    local category="Chaotic"
    
    if [[ $desperate_count -gt $max_count ]]; then
        max_count=$desperate_count
        category="Desperate"
    fi
    if [[ $confident_count -gt $max_count ]]; then
        max_count=$confident_count
        category="Confident"
    fi
    if [[ $chaotic_count -gt $max_count ]]; then
        max_count=$chaotic_count
        category="Chaotic"
    fi
    if [[ $cryptic_count -gt $max_count ]]; then
        max_count=$cryptic_count
        category="Cryptic"
    fi
    if [[ $poetic_count -gt $max_count ]]; then
        max_count=$poetic_count
        category="Poetic"
    fi
    
    echo "$category"
}

# Assign zodiac sign to repository based on characteristics
assign_repo_zodiac() {
    local repo_name="$1"
    local creation_date="$2"
    local star_count="$3"
    local fork_count="$4"
    local language="$5"
    
    # Use repository name hash and characteristics to determine sign
    local name_hash=$(echo "$repo_name" | cksum | cut -d' ' -f1)
    local sign_index=$(($name_hash % 12))
    
    local signs=("Aries" "Taurus" "Gemini" "Cancer" "Leo" "Virgo" "Libra" "Scorpio" "Sagittarius" "Capricorn" "Aquarius" "Pisces")
    echo "${signs[$sign_index]}"
}

# Analyze streak patterns for mystical insights  
analyze_streak_magic() {
    local username="$1"
    
    # Get contribution data (simplified - in real implementation would parse more data)
    local current_streak=0
    local longest_streak=0
    local total_contributions=0
    
    # Mock data based on username hash for demo purposes
    local user_hash=$(echo "$username" | cksum | cut -d' ' -f1)
    current_streak=$(($user_hash % 30 + 1))
    longest_streak=$(($user_hash % 100 + current_streak))
    total_contributions=$(($user_hash % 1000 + 100))
    
    CURRENT_STREAK=$current_streak
    LONGEST_STREAK=$longest_streak
    TOTAL_CONTRIBUTIONS=$total_contributions
}

# Enhanced collaboration analysis
analyze_collaboration_depth() {
    local username="$1"
    
    # In a real implementation, this would analyze:
    # - PR review patterns
    # - Issue participation  
    # - Collaborative commit patterns
    # - Organization memberships
    
    # Mock data for demo
    local user_hash=$(echo "$username" | cksum | cut -d' ' -f1)
    PR_REVIEW_COUNT=$(($user_hash % 50))
    ISSUE_PARTICIPATION=$(($user_hash % 30))
    COLLAB_PROJECTS=$(($user_hash % 15))
}

# Analyze coding element based on multiple factors
determine_coding_element() {
    local languages="$1"
    local commit_frequency="$2" 
    local complexity_metrics="$3"
    
    # Earth: Systems languages, low-level, stable patterns
    if [[ "$languages" =~ (C|Rust|Go|Assembly|C\+\+) ]]; then
        echo "Earth"
    # Fire: Dynamic languages with high frequency commits
    elif [[ "$languages" =~ (JavaScript|Python|Ruby) ]] && [[ "$commit_frequency" == "high" ]]; then
        echo "Fire"  
    # Air: Functional languages, mathematical approaches
    elif [[ "$languages" =~ (Haskell|Lisp|Prolog|ML|Scala|Clojure) ]]; then
        echo "Air"
    # Water: Adaptable languages, web technologies
    else
        echo "Water"
    fi
}