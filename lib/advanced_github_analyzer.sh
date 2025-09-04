#!/bin/bash

# Advanced GitHub Analyzer module for GitHub CLI Horoscope Extension
# Provides deep user profiling with full GitHub API integration
# Complements the existing github-analyzer.sh with advanced features

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