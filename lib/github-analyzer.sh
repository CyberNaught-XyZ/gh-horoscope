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

# Enhanced emotion detection from code analysis
declare -g EMOTIONAL_STATE=""
declare -g EMOTION_INTENSITY=0
declare -g DOMINANT_EMOTIONS=()
declare -g CODING_MOOD_PATTERN=""

# Analyze emotional patterns in commit messages with enhanced detection
analyze_emotional_patterns() {
    local -a messages=("$@")
    local positive_emotions=("awesome" "great" "amazing" "love" "happy" "excited" "perfect" "excellent" "fantastic" "wonderful" "brilliant" "success" "achieved" "accomplished" "proud" "satisfied" "delighted")
    local negative_emotions=("hate" "frustrated" "annoying" "stupid" "terrible" "awful" "sucks" "horrible" "disaster" "nightmare" "broken" "failing" "impossible" "ridiculous" "pathetic" "hopeless")
    local stressed_emotions=("urgent" "panic" "desperate" "crisis" "emergency" "help" "stuck" "lost" "confused" "overwhelmed" "tired" "exhausted")
    local neutral_emotions=("update" "change" "modify" "adjust" "tweak" "refactor" "improve" "optimize" "implement" "add" "remove" "fix")
    local humorous_emotions=("oops" "whoops" "lol" "haha" "silly" "funny" "derp" "facepalm" "wtf" "omg" "yolo")
    
    local positive_count=0
    local negative_count=0
    local stressed_count=0
    local neutral_count=0
    local humorous_count=0
    
    for message in "${messages[@]}"; do
        local classified=false
        local message_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
        
        # Check positive emotions
        for emotion in "${positive_emotions[@]}"; do
            if [[ "$message_lower" =~ $emotion ]] && [[ $classified == false ]]; then
                ((positive_count++))
                classified=true
                break
            fi
        done
        
        # Check negative emotions
        if [[ $classified == false ]]; then
            for emotion in "${negative_emotions[@]}"; do
                if [[ "$message_lower" =~ $emotion ]]; then
                    ((negative_count++))
                    classified=true
                    break
                fi
            done
        fi
        
        # Check stressed emotions
        if [[ $classified == false ]]; then
            for emotion in "${stressed_emotions[@]}"; do
                if [[ "$message_lower" =~ $emotion ]]; then
                    ((stressed_count++))
                    classified=true
                    break
                fi
            done
        fi
        
        # Check humorous emotions
        if [[ $classified == false ]]; then
            for emotion in "${humorous_emotions[@]}"; do
                if [[ "$message_lower" =~ $emotion ]]; then
                    ((humorous_count++))
                    classified=true
                    break
                fi
            done
        fi
        
        # Default to neutral
        if [[ $classified == false ]]; then
            ((neutral_count++))
        fi
    done
    
    local total_emotional_commits=$((positive_count + negative_count + stressed_count + humorous_count))
    local total_commits=${#messages[@]}
    
    # Calculate emotion intensity (percentage of emotional vs neutral commits)
    if [[ $total_commits -gt 0 ]]; then
        EMOTION_INTENSITY=$((total_emotional_commits * 100 / total_commits))
    else
        EMOTION_INTENSITY=0
    fi
    
    # Determine dominant emotional pattern
    local max_count=0
    local dominant_emotion="neutral"
    
    if [[ $positive_count -gt $max_count ]]; then
        max_count=$positive_count
        dominant_emotion="positive"
    fi
    
    if [[ $negative_count -gt $max_count ]]; then
        max_count=$negative_count
        dominant_emotion="negative"
    fi
    
    if [[ $stressed_count -gt $max_count ]]; then
        max_count=$stressed_count
        dominant_emotion="stressed"
    fi
    
    if [[ $humorous_count -gt $max_count ]]; then
        max_count=$humorous_count
        dominant_emotion="humorous"
    fi
    
    # Set global emotional state variables
    EMOTIONAL_STATE="$dominant_emotion"
    DOMINANT_EMOTIONS=("positive:$positive_count" "negative:$negative_count" "stressed:$stressed_count" "humorous:$humorous_count" "neutral:$neutral_count")
    
    # Determine coding mood pattern based on emotional distribution
    if [[ $EMOTION_INTENSITY -gt 60 ]]; then
        if [[ "$dominant_emotion" == "negative" ]] || [[ "$dominant_emotion" == "stressed" ]]; then
            CODING_MOOD_PATTERN="Turbulent Coder"
        elif [[ "$dominant_emotion" == "positive" ]]; then
            CODING_MOOD_PATTERN="Joyful Developer"
        elif [[ "$dominant_emotion" == "humorous" ]]; then
            CODING_MOOD_PATTERN="Comedy Programmer"
        fi
    elif [[ $EMOTION_INTENSITY -gt 30 ]]; then
        CODING_MOOD_PATTERN="Emotionally Balanced"
    else
        CODING_MOOD_PATTERN="Zen Programmer"
    fi
    
    echo "positive:$positive_count,negative:$negative_count,stressed:$stressed_count,humorous:$humorous_count,neutral:$neutral_count,intensity:$EMOTION_INTENSITY,pattern:$CODING_MOOD_PATTERN"
}

# Detect frustration patterns in code changes
detect_frustration_indicators() {
    local -a messages=("$@")
    local frustration_indicators=()
    
    for message in "${messages[@]}"; do
        local message_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
        
        # Multiple question marks indicate confusion/frustration
        if [[ "$message" =~ \?\?\?+ ]]; then
            frustration_indicators+=("confusion")
        fi
        
        # Multiple exclamation marks indicate frustration/excitement
        if [[ "$message" =~ \!\!\!+ ]]; then
            frustration_indicators+=("intensity")
        fi
        
        # All caps words indicate shouting/frustration
        local caps_words=$(echo "$message" | grep -o '[A-Z][A-Z][A-Z][A-Z]*' | wc -l)
        if [[ $caps_words -gt 2 ]]; then
            frustration_indicators+=("shouting")
        fi
        
        # Time-based frustration indicators
        if [[ "$message_lower" =~ (why.*work|doesn.*t.*work|not.*working|still.*broken) ]]; then
            frustration_indicators+=("persistent_issues")
        fi
        
        # Desperation indicators
        if [[ "$message_lower" =~ (please.*work|i.*give.*up|can.*t.*figure|what.*hell) ]]; then
            frustration_indicators+=("desperation")
        fi
    done
    
    echo "${#frustration_indicators[@]}"
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
# Enhanced collaboration analysis
declare -g COLLABORATION_STYLE=""
declare -g TEAM_INTERACTION_SCORE=0
declare -g MENTORSHIP_INDICATORS=0
declare -g CONFLICT_RESOLUTION_STYLE=""

analyze_collaboration_depth() {
    local username="$1"
    
    # Enhanced collaboration analysis with deeper insights
    local collaboration_indicators=()
    local mentorship_patterns=()
    local conflict_resolution_patterns=()
    
    # Analyze commit message patterns for collaboration clues
    local commit_messages_text="${COMMIT_MESSAGES[*]}"
    
    # Team interaction indicators
    if [[ "$commit_messages_text" =~ (pair.*program|paired.*with|thanks.*to|helped.*by|reviewed.*by) ]]; then
        collaboration_indicators+=("pair_programming")
    fi
    
    if [[ "$commit_messages_text" =~ (team.*effort|collaborative|together|group.*work) ]]; then
        collaboration_indicators+=("team_oriented")
    fi
    
    if [[ "$commit_messages_text" =~ (merge.*from|cherry.*pick|backport) ]]; then
        collaboration_indicators+=("integration_focused")
    fi
    
    # Mentorship indicators
    if [[ "$commit_messages_text" =~ (teach|explain|document|guide|help.*understand) ]]; then
        mentorship_patterns+=("teacher")
    fi
    
    if [[ "$commit_messages_text" =~ (learn.*from|inspired.*by|following.*example) ]]; then
        mentorship_patterns+=("learner")
    fi
    
    if [[ "$commit_messages_text" =~ (onboard|welcome|introduce|first.*time) ]]; then
        mentorship_patterns+=("welcomer")
    fi
    
    # Conflict resolution patterns
    if [[ "$commit_messages_text" =~ (resolve.*conflict|fix.*merge|address.*feedback) ]]; then
        conflict_resolution_patterns+=("diplomatic")
    fi
    
    if [[ "$commit_messages_text" =~ (revert|rollback|undo) ]]; then
        conflict_resolution_patterns+=("decisive")
    fi
    
    if [[ "$commit_messages_text" =~ (discuss|consensus|agreement|compromise) ]]; then
        conflict_resolution_patterns+=("consultative")
    fi
    
    # Mock collaboration metrics (in real implementation, would analyze PR/issue interactions)
    local user_hash=$(echo "$username" | cksum | cut -d' ' -f1)
    PR_REVIEW_COUNT=$(($user_hash % 50))
    ISSUE_PARTICIPATION=$(($user_hash % 30))
    COLLAB_PROJECTS=$(($user_hash % 15))
    
    # Determine collaboration style
    local collaboration_indicators_count=${#collaboration_indicators[@]}
    local mentorship_count=${#mentorship_patterns[@]}
    local conflict_count=${#conflict_resolution_patterns[@]}
    
    TEAM_INTERACTION_SCORE=$((collaboration_indicators_count * 25 + PR_REVIEW_COUNT))
    MENTORSHIP_INDICATORS=$mentorship_count
    
    # Determine collaboration style based on patterns
    if [[ $collaboration_indicators_count -gt 3 ]]; then
        COLLABORATION_STYLE="Team Player"
    elif [[ $collaboration_indicators_count -gt 1 ]]; then
        COLLABORATION_STYLE="Collaborative Developer"  
    elif [[ $PR_REVIEW_COUNT -gt 20 ]]; then
        COLLABORATION_STYLE="Community Contributor"
    else
        COLLABORATION_STYLE="Independent Developer"
    fi
    
    # Determine conflict resolution style
    if [[ " ${conflict_resolution_patterns[*]} " =~ "diplomatic" ]]; then
        CONFLICT_RESOLUTION_STYLE="Diplomatic Resolver"
    elif [[ " ${conflict_resolution_patterns[*]} " =~ "decisive" ]]; then
        CONFLICT_RESOLUTION_STYLE="Decisive Leader"
    elif [[ " ${conflict_resolution_patterns[*]} " =~ "consultative" ]]; then
        CONFLICT_RESOLUTION_STYLE="Consensus Builder"
    else
        CONFLICT_RESOLUTION_STYLE="Conflict Avoider"
    fi
}

# Analyze communication patterns in commits
analyze_communication_patterns() {
    local -a messages=("$@")
    local communication_styles=()
    
    for message in "${messages[@]}"; do
        local message_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
        
        # Formal communication style
        if [[ "$message_lower" =~ (implement|refactor|optimize|enhance|address) ]]; then
            communication_styles+=("formal")
        fi
        
        # Casual communication style  
        if [[ "$message_lower" =~ (fix.*up|clean.*up|tweak|polish|tidy) ]]; then
            communication_styles+=("casual")
        fi
        
        # Explanatory style
        if [[ "$message_lower" =~ (because|since|due.*to|in.*order.*to) ]]; then
            communication_styles+=("explanatory")
        fi
        
        # Emotional/expressive style
        if [[ "$message_lower" =~ (finally|awesome|terrible|love|hate) ]]; then
            communication_styles+=("expressive")
        fi
        
        # Technical precision
        if [[ "$message" =~ (v[0-9]+\.[0-9]+|bug.*#[0-9]+|issue.*#[0-9]+|pr.*#[0-9]+) ]]; then
            communication_styles+=("precise")
        fi
    done
    
    # Count style frequencies
    declare -A style_counts
    for style in "${communication_styles[@]}"; do
        ((style_counts[$style]++))
    done
    
    # Find dominant communication style
    local max_count=0
    local dominant_style="balanced"
    
    for style in "${!style_counts[@]}"; do
        if [[ ${style_counts[$style]} -gt $max_count ]]; then
            max_count=${style_counts[$style]}
            dominant_style="$style"
        fi
    done
    
    echo "$dominant_style"
}

# Analyze leadership and initiative patterns
analyze_leadership_patterns() {
    local username="$1"
    local commit_messages_text="${COMMIT_MESSAGES[*]}"
    
    local leadership_indicators=()
    
    # Initiative taking
    if [[ "$commit_messages_text" =~ (initial.*commit|start.*project|create.*repo|bootstrap) ]]; then
        leadership_indicators+=("initiator")
    fi
    
    # Architecture decisions
    if [[ "$commit_messages_text" =~ (architecture|design|structure|framework.*choice) ]]; then
        leadership_indicators+=("architect")
    fi
    
    # Process improvement
    if [[ "$commit_messages_text" =~ (improve.*process|setup.*ci|add.*linting|standardize) ]]; then
        leadership_indicators+=("process_improver")
    fi
    
    # Problem solving
    if [[ "$commit_messages_text" =~ (solve|solution|approach|strategy) ]]; then
        leadership_indicators+=("problem_solver")
    fi
    
    # Team coordination
    if [[ "$commit_messages_text" =~ (coordinate|organize|plan|schedule) ]]; then
        leadership_indicators+=("coordinator")
    fi
    
    echo "${#leadership_indicators[@]}"
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

# ===============================================================================
# ADVANCED GITHUB ANALYSIS FEATURES
# ===============================================================================
# The following functions provide deep user profiling with full GitHub API integration
# These advanced features complement the existing analysis with enhanced insights

# Global variables for advanced analysis
declare -g ADVANCED_USER_PROFILE=()
declare -g SOCIAL_METRICS=()
declare -g CONTRIBUTION_PATTERNS=()
declare -g CODE_REVIEW_STATS=()
declare -g ISSUE_INTERACTION_STATS=()
declare -g REPOSITORY_HEALTH_METRICS=()
declare -g COLLABORATION_NETWORK=()
declare -g COMMIT_TIME_ANALYSIS=()
declare -g LANGUAGE_EVOLUTION=()
declare -g PROJECT_LIFECYCLE_ANALYSIS=()

# Enhanced user profiling with comprehensive GitHub data
analyze_advanced_user_profile() {
    local username="$1"
    
    display_oracle_loading "Conducting deep profile analysis" 4
    
    # Basic user data with extended fields
    local user_data=$(gh api "users/$username" --jq '{
        login, name, email, bio, company, location, blog, twitter_username,
        public_repos, public_gists, followers, following,
        created_at, updated_at, type, site_admin, gravatar_id,
        hireable, plan: .plan.name
    }' 2>/dev/null)
    
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    # Calculate account age and activity metrics
    local created_date=$(echo "$user_data" | jq -r '.created_at')
    local account_age_days=$(( ($(date +%s) - $(date -d "$created_date" +%s)) / 86400 ))
    local account_age_years=$((account_age_days / 365))
    
    # Store advanced profile data
    ADVANCED_USER_PROFILE=(
        "account_age_days:$account_age_days"
        "account_age_years:$account_age_years"
        "total_public_repos:$(echo "$user_data" | jq -r '.public_repos')"
        "total_gists:$(echo "$user_data" | jq -r '.public_gists')"
        "follower_count:$(echo "$user_data" | jq -r '.followers')"
        "following_count:$(echo "$user_data" | jq -r '.following')"
        "has_bio:$(echo "$user_data" | jq -r '.bio != null')"
        "has_company:$(echo "$user_data" | jq -r '.company != null')"
        "has_location:$(echo "$user_data" | jq -r '.location != null')"
        "has_blog:$(echo "$user_data" | jq -r '.blog != null and .blog != ""')"
        "has_twitter:$(echo "$user_data" | jq -r '.twitter_username != null')"
        "is_hireable:$(echo "$user_data" | jq -r '.hireable == true')"
    )
    
    return 0
}

# Analyze social coding metrics and network effects
analyze_social_coding_metrics() {
    local username="$1"
    
    display_crystal_ball_loading "Analyzing social coding patterns" 3
    
    # Get following/followers ratio for influence analysis
    local follower_count=$(echo "${ADVANCED_USER_PROFILE[*]}" | grep -o "follower_count:[0-9]*" | cut -d: -f2)
    local following_count=$(echo "${ADVANCED_USER_PROFILE[*]}" | grep -o "following_count:[0-9]*" | cut -d: -f2)
    
    local influence_ratio=0
    if [[ $following_count -gt 0 ]]; then
        influence_ratio=$((follower_count * 100 / following_count))
    fi
    
    # Analyze starred repositories for interests
    local starred_repos=$(gh api "users/$username/starred" --paginate --jq '.[].language' 2>/dev/null | sort | uniq -c | sort -nr | head -10)
    
    # Get user's organizations for community involvement
    local organizations=$(gh api "users/$username/orgs" --jq '.[].login' 2>/dev/null | wc -l)
    
    SOCIAL_METRICS=(
        "influence_ratio:$influence_ratio"
        "organizations:$organizations"
        "starred_languages:$starred_repos"
    )
    
    return 0
}

# Deep contribution pattern analysis
analyze_contribution_patterns() {
    local username="$1"
    
    display_github_loading "Mapping contribution constellation" 4
    
    # Get recent events for activity pattern analysis
    local events=$(gh api "users/$username/events" --paginate --jq '.[] | {type: .type, created_at: .created_at, repo: .repo.name}' 2>/dev/null)
    
    # Analyze event types and frequency
    local push_events=$(echo "$events" | jq -r 'select(.type == "PushEvent")' | wc -l)
    local pr_events=$(echo "$events" | jq -r 'select(.type == "PullRequestEvent")' | wc -l)
    local issue_events=$(echo "$events" | jq -r 'select(.type == "IssuesEvent")' | wc -l)
    local fork_events=$(echo "$events" | jq -r 'select(.type == "ForkEvent")' | wc -l)
    local star_events=$(echo "$events" | jq -r 'select(.type == "WatchEvent")' | wc -l)
    local create_events=$(echo "$events" | jq -r 'select(.type == "CreateEvent")' | wc -l)
    
    # Calculate activity diversity score
    local total_events=$((push_events + pr_events + issue_events + fork_events + star_events + create_events))
    local activity_diversity=0
    if [[ $total_events -gt 0 ]]; then
        # Calculate entropy-based diversity
        local diversity_score=0
        for event_count in $push_events $pr_events $issue_events $fork_events $star_events $create_events; do
            if [[ $event_count -gt 0 ]]; then
                local probability=$((event_count * 100 / total_events))
                diversity_score=$((diversity_score + probability))
            fi
        done
        activity_diversity=$((diversity_score / 6)) # Normalize
    fi
    
    CONTRIBUTION_PATTERNS=(
        "push_events:$push_events"
        "pr_events:$pr_events"
        "issue_events:$issue_events"
        "fork_events:$fork_events"
        "star_events:$star_events"
        "create_events:$create_events"
        "activity_diversity:$activity_diversity"
        "total_recent_events:$total_events"
    )
    
    return 0
}

# Advanced repository health analysis
analyze_repository_health() {
    local username="$1"
    
    display_oracle_loading "Evaluating repository health metrics" 5
    
    # Get detailed repository information
    local repos=$(gh api "users/$username/repos" --paginate --jq '.[] | select(.fork == false) | {
        name, stargazers_count, watchers_count, forks_count, open_issues_count,
        size, language, created_at, updated_at, pushed_at,
        has_issues, has_projects, has_wiki, has_pages,
        archived, disabled, default_branch
    }' 2>/dev/null)
    
    # Calculate repository health metrics
    local total_stars=$(echo "$repos" | jq -s 'map(.stargazers_count) | add // 0')
    local total_forks=$(echo "$repos" | jq -s 'map(.forks_count) | add // 0')
    local total_watchers=$(echo "$repos" | jq -s 'map(.watchers_count) | add // 0')
    local total_open_issues=$(echo "$repos" | jq -s 'map(.open_issues_count) | add // 0')
    
    local repos_with_readme=$(echo "$repos" | jq -s 'map(select(.name | test("README|readme"))) | length')
    local repos_with_wiki=$(echo "$repos" | jq -s 'map(select(.has_wiki == true)) | length')
    local repos_with_issues=$(echo "$repos" | jq -s 'map(select(.has_issues == true)) | length')
    local repos_with_pages=$(echo "$repos" | jq -s 'map(select(.has_pages == true)) | length')
    local archived_repos=$(echo "$repos" | jq -s 'map(select(.archived == true)) | length')
    
    # Calculate maintenance score
    local repo_count=$(echo "$repos" | jq -s 'length')
    local maintenance_score=0
    if [[ $repo_count -gt 0 ]]; then
        local active_repos=$((repo_count - archived_repos))
        local documentation_score=$((repos_with_readme * 25 / repo_count))
        local community_score=$((repos_with_issues * 25 / repo_count))
        local presentation_score=$((repos_with_wiki * 25 / repo_count))
        local activity_score=$((active_repos * 25 / repo_count))
        maintenance_score=$((documentation_score + community_score + presentation_score + activity_score))
    fi
    
    REPOSITORY_HEALTH_METRICS=(
        "total_stars:$total_stars"
        "total_forks:$total_forks"
        "total_watchers:$total_watchers"
        "total_open_issues:$total_open_issues"
        "repos_with_wiki:$repos_with_wiki"
        "repos_with_issues:$repos_with_issues"
        "repos_with_pages:$repos_with_pages"
        "archived_repos:$archived_repos"
        "maintenance_score:$maintenance_score"
    )
    
    return 0
}

# Analyze collaboration network and code review patterns
analyze_collaboration_network() {
    local username="$1"
    
    display_mystical_loading "Decoding collaboration mysteries" 4
    
    # Get user's repositories for collaboration analysis
    local user_repos=$(gh api "users/$username/repos" --paginate --jq '.[] | select(.fork == false) | .name' 2>/dev/null)
    
    local total_contributors=0
    local pr_reviews_given=0
    local pr_reviews_received=0
    local collaborator_diversity=0
    
    # Sample a few repositories for detailed analysis (to avoid rate limits)
    echo "$user_repos" | head -5 | while read -r repo; do
        if [[ -n "$repo" ]]; then
            # Get contributors for collaboration diversity
            local contributors=$(gh api "repos/$username/$repo/contributors" --jq '.[].login' 2>/dev/null | wc -l)
            total_contributors=$((total_contributors + contributors))
            
            # Get pull requests for review analysis
            local prs=$(gh api "repos/$username/$repo/pulls" --jq '.[] | {user: .user.login, requested_reviewers: .requested_reviewers}' 2>/dev/null)
            # Count would be complex to calculate accurately here, using approximation
        fi
    done
    
    # Calculate collaboration scores (simplified for demo)
    local repo_count=$(echo "$user_repos" | wc -l)
    local avg_contributors_per_repo=0
    if [[ $repo_count -gt 0 ]]; then
        avg_contributors_per_repo=$((total_contributors / repo_count))
    fi
    
    # Determine collaboration style
    local collaboration_style="Solo Developer"
    if [[ $avg_contributors_per_repo -gt 5 ]]; then
        collaboration_style="Team Leader"
    elif [[ $avg_contributors_per_repo -gt 2 ]]; then
        collaboration_style="Collaborative Developer"
    elif [[ $avg_contributors_per_repo -gt 1 ]]; then
        collaboration_style="Pair Programmer"
    fi
    
    COLLABORATION_NETWORK=(
        "avg_contributors_per_repo:$avg_contributors_per_repo"
        "collaboration_style:$collaboration_style"
        "estimated_network_size:$total_contributors"
    )
    
    return 0
}

# Analyze commit timing patterns for productivity insights
analyze_commit_timing_patterns() {
    local username="$1"
    
    display_crystal_ball_loading "Analyzing temporal coding patterns" 3
    
    # Get recent commits across repositories for timing analysis
    local repos=$(gh api "users/$username/repos" --paginate --jq '.[] | select(.fork == false and .size > 0) | .name' 2>/dev/null | head -10)
    
    local morning_commits=0    # 6 AM - 12 PM
    local afternoon_commits=0  # 12 PM - 6 PM
    local evening_commits=0    # 6 PM - 12 AM
    local night_commits=0      # 12 AM - 6 AM
    local weekday_commits=0
    local weekend_commits=0
    
    echo "$repos" | while read -r repo; do
        if [[ -n "$repo" ]]; then
            # Get recent commits with timestamps
            local commits=$(gh api "repos/$username/$repo/commits" --jq '.[] | .commit.author.date' 2>/dev/null | head -20)
            
            echo "$commits" | while read -r commit_date; do
                if [[ -n "$commit_date" ]]; then
                    local hour=$(date -d "$commit_date" +%H)
                    local dow=$(date -d "$commit_date" +%u)  # 1-7, Monday-Sunday
                    
                    # Categorize by time of day
                    if [[ $hour -ge 6 && $hour -lt 12 ]]; then
                        morning_commits=$((morning_commits + 1))
                    elif [[ $hour -ge 12 && $hour -lt 18 ]]; then
                        afternoon_commits=$((afternoon_commits + 1))
                    elif [[ $hour -ge 18 && $hour -lt 24 ]]; then
                        evening_commits=$((evening_commits + 1))
                    else
                        night_commits=$((night_commits + 1))
                    fi
                    
                    # Categorize by day of week
                    if [[ $dow -le 5 ]]; then
                        weekday_commits=$((weekday_commits + 1))
                    else
                        weekend_commits=$((weekend_commits + 1))
                    fi
                fi
            done
        fi
    done
    
    local total_analyzed_commits=$((morning_commits + afternoon_commits + evening_commits + night_commits))
    
    # Calculate productivity rhythm
    local productivity_rhythm="Balanced"
    local peak_period="Morning"
    
    if [[ $total_analyzed_commits -gt 0 ]]; then
        local morning_pct=$((morning_commits * 100 / total_analyzed_commits))
        local afternoon_pct=$((afternoon_commits * 100 / total_analyzed_commits))
        local evening_pct=$((evening_commits * 100 / total_analyzed_commits))
        local night_pct=$((night_commits * 100 / total_analyzed_commits))
        
        # Determine peak period
        local max_pct=$morning_pct
        peak_period="Morning"
        
        if [[ $afternoon_pct -gt $max_pct ]]; then
            max_pct=$afternoon_pct
            peak_period="Afternoon"
        fi
        
        if [[ $evening_pct -gt $max_pct ]]; then
            max_pct=$evening_pct
            peak_period="Evening"
        fi
        
        if [[ $night_pct -gt $max_pct ]]; then
            max_pct=$night_pct
            peak_period="Night"
        fi
        
        # Determine rhythm type
        if [[ $max_pct -gt 50 ]]; then
            productivity_rhythm="Concentrated"
        elif [[ $max_pct -gt 35 ]]; then
            productivity_rhythm="Focused"
        else
            productivity_rhythm="Distributed"
        fi
    fi
    
    COMMIT_TIME_ANALYSIS=(
        "morning_commits:$morning_commits"
        "afternoon_commits:$afternoon_commits"
        "evening_commits:$evening_commits"
        "night_commits:$night_commits"
        "weekday_commits:$weekday_commits"
        "weekend_commits:$weekend_commits"
        "productivity_rhythm:$productivity_rhythm"
        "peak_period:$peak_period"
        "total_analyzed:$total_analyzed_commits"
    )
    
    return 0
}

# Analyze language evolution and technology adoption patterns
analyze_language_evolution() {
    local username="$1"
    
    display_oracle_loading "Tracing language evolution journey" 4
    
    # Get repositories sorted by creation date to track language evolution
    local repos=$(gh api "users/$username/repos" --paginate --jq '.[] | select(.fork == false and .language != null) | {name: .name, language: .language, created_at: .created_at}' 2>/dev/null)
    
    # Extract unique languages and their first appearance
    local languages=($(echo "$repos" | jq -r '.language' | sort | uniq))
    local language_timeline=()
    local current_languages=()
    local abandoned_languages=()
    
    # Analyze recent vs historical language usage
    local recent_cutoff=$(date -d '1 year ago' --iso-8601)
    local recent_languages=($(echo "$repos" | jq -r --arg cutoff "$recent_cutoff" 'select(.created_at >= $cutoff) | .language' | sort | uniq))
    local historical_languages=($(echo "$repos" | jq -r --arg cutoff "$recent_cutoff" 'select(.created_at < $cutoff) | .language' | sort | uniq))
    
    # Calculate language diversity and evolution metrics
    local total_languages=${#languages[@]}
    local recent_language_count=${#recent_languages[@]}
    local historical_language_count=${#historical_languages[@]}
    
    # Determine evolution pattern
    local evolution_pattern="Stable"
    if [[ $recent_language_count -gt $historical_language_count ]]; then
        evolution_pattern="Expanding"
    elif [[ $recent_language_count -lt $((historical_language_count / 2)) ]]; then
        evolution_pattern="Focusing"
    elif [[ $recent_language_count -eq 0 ]] && [[ $historical_language_count -gt 0 ]]; then
        evolution_pattern="Dormant"
    fi
    
    LANGUAGE_EVOLUTION=(
        "total_languages:$total_languages"
        "recent_languages:$recent_language_count"
        "historical_languages:$historical_language_count"
        "evolution_pattern:$evolution_pattern"
        "primary_recent:$(echo "${recent_languages[0]}" | head -1)"
        "language_diversity_score:$((total_languages * 10))"
    )
    
    return 0
}

# Main advanced analysis orchestrator
analyze_github_user_advanced() {
    local username="$1"
    
    if [[ -z "$username" ]]; then
        echo "Error: Username required for advanced analysis" >&2
        return 1
    fi
    
    # Check if user exists and is accessible
    if ! gh api "users/$username" >/dev/null 2>&1; then
        echo "Error: User '$username' not found or not accessible" >&2
        return 1
    fi
    
    display_mystical_loading "Initiating deep mystical analysis" 3
    echo
    
    # Run all advanced analysis functions
    local analysis_functions=(
        "analyze_advanced_user_profile"
        "analyze_social_coding_metrics"
        "analyze_contribution_patterns"
        "analyze_repository_health"
        "analyze_collaboration_network"
        "analyze_commit_timing_patterns"
        "analyze_language_evolution"
    )
    
    local completed=0
    local total=${#analysis_functions[@]}
    
    for func in "${analysis_functions[@]}"; do
        if $func "$username"; then
            completed=$((completed + 1))
            local progress=$((completed * 100 / total))
            display_info "Advanced analysis progress: ${progress}%"
        else
            display_warning "Warning: $func failed - continuing with available data"
        fi
        echo
    done
    
    display_success "✨ Advanced analysis completed! Deep insights available."
    return 0
}

# Generate advanced insights summary
generate_advanced_insights_summary() {
    local username="$1"
    
    echo
    display_section_header "🔮 ADVANCED MYSTICAL INSIGHTS"
    
    # Account maturity insights
    local account_age=$(echo "${ADVANCED_USER_PROFILE[*]}" | grep -o "account_age_years:[0-9]*" | cut -d: -f2)
    if [[ $account_age -gt 0 ]]; then
        if [[ $account_age -gt 10 ]]; then
            display_mystical_insight "🏛️ Ancient Developer: With $account_age years on GitHub, you've witnessed the evolution of code itself!"
        elif [[ $account_age -gt 5 ]]; then
            display_mystical_insight "🎓 Seasoned Practitioner: $account_age years of digital wisdom flows through your repositories."
        else
            display_mystical_insight "🌱 Growing Developer: $account_age years into your coding journey, your potential is still unfolding."
        fi
    fi
    
    # Social influence insights
    local influence_ratio=$(echo "${SOCIAL_METRICS[*]}" | grep -o "influence_ratio:[0-9]*" | cut -d: -f2)
    if [[ $influence_ratio -gt 200 ]]; then
        display_mystical_insight "⭐ Coding Influencer: Your influence ratio suggests you're a beacon in the developer community!"
    elif [[ $influence_ratio -gt 100 ]]; then
        display_mystical_insight "🌟 Community Presence: You have a positive influence in the coding sphere."
    fi
    
    # Collaboration style insights
    local collab_style=$(echo "${COLLABORATION_NETWORK[*]}" | grep -o "collaboration_style:[^:]*" | cut -d: -f2)
    if [[ -n "$collab_style" ]]; then
        display_mystical_insight "🤝 Collaboration Oracle: You are a $collab_style, bringing unique energy to team dynamics."
    fi
    
    # Productivity rhythm insights
    local productivity_rhythm=$(echo "${COMMIT_TIME_ANALYSIS[*]}" | grep -o "productivity_rhythm:[^:]*" | cut -d: -f2)
    local peak_period=$(echo "${COMMIT_TIME_ANALYSIS[*]}" | grep -o "peak_period:[^:]*" | cut -d: -f2)
    if [[ -n "$productivity_rhythm" ]] && [[ -n "$peak_period" ]]; then
        display_mystical_insight "⏰ Temporal Wisdom: Your $productivity_rhythm coding rhythm peaks in the $peak_period - the stars align with your natural cycles!"
    fi
    
    # Language evolution insights
    local evolution_pattern=$(echo "${LANGUAGE_EVOLUTION[*]}" | grep -o "evolution_pattern:[^:]*" | cut -d: -f2)
    if [[ -n "$evolution_pattern" ]]; then
        case "$evolution_pattern" in
            "Expanding")
                display_mystical_insight "🚀 Technology Explorer: You're expanding your language horizons - the universe rewards the curious!"
                ;;
            "Focusing")
                display_mystical_insight "🎯 Specialization Seeker: You're focusing your energies - mastery comes through dedicated practice!"
                ;;
            "Stable")
                display_mystical_insight "⚖️ Balanced Technologist: You've found your technological equilibrium - wisdom in stability!"
                ;;
        esac
    fi
    
    echo
}

# Display a mystical insight with proper formatting
display_mystical_insight() {
    local insight="$1"
    echo
    echo "    ✨ $insight"
    echo
}

# Display section header for advanced insights
display_section_header() {
    local title="$1"
    echo
    echo "╭────────────────────────────────────────────────────────────────────╮"
    echo "│                          $title                          │"
    echo "╰────────────────────────────────────────────────────────────────────╯"
    echo
}