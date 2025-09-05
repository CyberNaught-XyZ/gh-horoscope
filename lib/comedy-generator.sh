#!/bin/bash

# Wrap text for better terminal display
wrap_and_indent_text() {
    local text="$1"
    local indent="    • "
    local width=75  # Leave some margin for terminal edges
    
    # Return early if content is empty or only whitespace
    if [[ -z "$text" || -z "${text//[[:space:]]/}" ]]; then
        echo "    • No content available."
        echo
        return
    fi
    
    # Use fold to wrap text at word boundaries, then add proper indentation
    echo "$text" | fold -w $((width - ${#indent})) -s | while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            echo "$indent$line"
            indent="      "  # Continuation lines get extra indent
        fi
    done
    echo
}

# Comedy Generator module for GitHub CLI Horoscope Extension
# Handles roasting, compliments, and humorous code analysis

# Roast categories and jokes
declare -A COMMIT_MESSAGE_ROASTS
declare -A REPOSITORY_ROASTS
declare -A CODING_PATTERN_ROASTS
declare -A LANGUAGE_ROASTS

# Expanded Commit Message Roasts - More brutal patterns
COMMIT_MESSAGE_ROASTS[fix_stuff]="🔥 **'fix stuff'** - Ah yes, the ancient incantation of clarity! Shakespeare wept. Your commit messages read like a toddler's first attempt at poetry. But hey, at least you're consistent in your beautiful chaos!"

COMMIT_MESSAGE_ROASTS[wip]="🚧 **'WIP' commits everywhere** - Work In Progress? More like 'Will Ignore Problems'! Your git history looks like a construction site that's been abandoned for 6 months. The archaeologists of the future will study your WIP commits to understand the collapse of civilization."

COMMIT_MESSAGE_ROASTS[it_works]="✨ **'it works now'** - The battle cry of developers everywhere! Your commit messages have the descriptive power of a fortune cookie written by a caffeinated squirrel. But we admire your optimism - 'it works now' implies it definitely won't work tomorrow!"

COMMIT_MESSAGE_ROASTS[various_changes]="🌪️ **'various changes'** - Ah, the literary masterpiece! You've managed to make git log as informative as a blank stare. 'Various changes' is the commit message equivalent of saying 'I did things to stuff'. Future you will thank present you for this crystal-clear documentation!"

COMMIT_MESSAGE_ROASTS[update]="📝 **'update'** - Update what? Update where? Update why? Your commit message strategy is like GPS directions that only say 'drive'. It's beautifully minimalist, like a haiku written by someone who doesn't understand haikus!"

COMMIT_MESSAGE_ROASTS[typo]="🤦‍♂️ **Typo fixes everywhere** - You're like a literary ninja, sneaking through codebases correcting the English language one commit at a time. Your dedication to fixing 'usuaer' to 'user' deserves a Nobel Prize in Spelling. Keep fighting the good fight against typography!"

COMMIT_MESSAGE_ROASTS[desperate_pleas]="🆘 **Desperate Debugging Pleas** - 'please work', 'why god why', 'I'll try anything at this point' - Your commit messages read like prayer requests to the coding gods. You've documented your descent into madness one commit at a time. At least future developers will understand your pain!"

COMMIT_MESSAGE_ROASTS[weekend_confessions]="📅 **Weekend/Late Night Confessions** - 'Saturday 2am commit', 'Sunday coding session why', 'it's 3am and I hate everything' - You're creating a permanent record of your work-life balance disasters. Your commit timestamps are a cry for help that only git log can hear!"

COMMIT_MESSAGE_ROASTS[emoji_overload]="🎭 **Emoji Explosion Expert** - 🔥🚀✨🎉💯🌟⚡ Your commit messages look like a teenager's text messages! You use more emojis than actual words. Your git history is so colorful it needs sunglasses. At least debugging is more fun when every commit looks like a party invitation!"

COMMIT_MESSAGE_ROASTS[all_caps_rage]="😤 **ALL CAPS COMMITMENT** - EVERY COMMIT MESSAGE IS SHOUTED LIKE YOU'RE PERMANENTLY STUCK IN CAPS LOCK! YOUR GIT HISTORY SOUNDS LIKE AN ANGRY INTERNET COMMENT SECTION! We hear you loud and clear - both the code changes and your frustration levels!"

COMMIT_MESSAGE_ROASTS[passive_aggressive]="💬 **Passive Aggressive Artisan** - 'Fixed the obvious bug that everyone else missed', 'Cleaned up the mess from previous developer', 'Actually made it work this time' - Your commit messages are more passive-aggressive than a office memo about dirty dishes!"

COMMIT_MESSAGE_ROASTS[shakespeare_syndrome]="🎭 **Shakespearean Dramatist** - Your commit messages read like soliloquies! 'To merge or not to merge, that is the question'. You've elevated git log to high art. Your commits have more drama than a soap opera and twice the existential crisis!"

# Enhanced Repository Pattern Roasts - More brutal patterns
REPOSITORY_ROASTS[too_many_repos]="📦 **Repository Collector Supreme** - You create repositories like other people collect Pokemon cards! %d repos and counting... Your GitHub profile looks like a digital hoarder's paradise. Do you actually maintain all these, or are they just there to make you look productive?"

REPOSITORY_ROASTS[empty_repos]="👻 **The Ghost Repository Specialist** - Empty repositories haunt your profile like digital tumbleweeds. You're the master of the 'Hello World' README that never evolves. It's like you plant seeds but forget to water them - beautiful ambition, questionable follow-through!"

REPOSITORY_ROASTS[abandoned_projects]="🏚️ **The Project Abandoner** - You start projects with the enthusiasm of a kid in a candy store, then abandon them faster than New Year's resolutions. Your repos have more 'Last commit: 2 years ago' than a digital graveyard. But hey, at least you're good at beginnings!"

REPOSITORY_ROASTS[forked_everything]="🍴 **The Serial Forker** - You fork repositories like it's going out of style! Your profile is %d%% forks - you're like the digital equivalent of someone who only retweets but never tweets. Original content is overrated anyway, right?"

REPOSITORY_ROASTS[single_commit_repos]="🎯 **The One-Hit Wonder** - Repositories with single commits! You're like the musical artist who had that one song everyone remembers. 'Initial commit' - and then, silence. The digital equivalent of dropping the mic and walking away forever."

REPOSITORY_ROASTS[README_collector]="📄 **README Perfectionist** - You have more README files than actual code! Your repositories are like museums - 90%% documentation, 10%% exhibits. You've perfected the art of describing what you're going to build instead of actually building it. At least your intentions are well-documented!"

REPOSITORY_ROASTS[todo_app_creator]="✅ **Todo App Connoisseur** - You've created the same todo application in 47 different frameworks! You're like the developer equivalent of someone who keeps starting diet plans on Monday. But hey, at least you're consistent in your inconsistency!"

REPOSITORY_ROASTS[unfinished_masterpieces]="🎨 **Unfinished Masterpiece Curator** - Your repositories are like art galleries full of half-finished paintings. 'This will be the next Facebook!' - commits 3 times, then crickets. You're the developer equivalent of someone with 50 hobbies and expertise in none!"

REPOSITORY_ROASTS[branch_hoarder]="🌿 **Branch Hoarder** - You create branches like they're going out of style and then forget they exist! Your repositories have more dead branches than a winter forest. 'feature/fix-login-maybe-v2-final-ACTUALLY-FINAL' - we can feel the desperation through the branch name!"

REPOSITORY_ROASTS[commit_message_novelist]="📚 **Commit Message Novelist** - Your commit messages are longer than the code changes themselves! You write git logs like you're documenting the complete history of human civilization. Meanwhile, other developers write 'fix' and call it a day. Your thoroughness is both admirable and exhausting!"

REPOSITORY_ROASTS[framework_collector]="🎯 **Framework Collector Supreme** - You've built the same app in React, Vue, Angular, Svelte, and probably some frameworks that don't exist yet! Your LinkedIn skills section looks like a JavaScript museum. You collect frameworks like Pokemon cards, but with more npm install commands!"

REPOSITORY_ROASTS[dependency_nightmare]="📦 **Dependency Hell Architect** - Your package.json files are longer than epic novels! You add dependencies for things that could be solved with 5 lines of vanilla code. Your node_modules folder is so large it has its own gravitational field!"

REPOSITORY_ROASTS[naming_chaos]="🏷️ **Repository Name Chaos Artist** - 'my-project', 'test-repo', 'untitled-1', 'asdf', 'new-project-final-v2-actually-final' - Your repository names read like the random thoughts of a caffeinated developer at 3am! You're the poet laureate of uninformative project names!"

REPOSITORY_ROASTS[license_rebel]="⚖️ **License Chaos Agent** - Some repos have MIT, others have GPL, a few are Apache, and the rest are license-free zones! You treat open source licensing like a mystery grab bag. Your legal compliance strategy is 'maybe nobody will notice!'"

REPOSITORY_ROASTS[gitignore_anarchist]="🙈 **Gitignore Anarchist** - You commit node_modules, .DS_Store files, your IDE configs, and that one file with your API keys. Your repositories are archaeological sites where future developers can study your complete desktop environment circa 2023!"

REPOSITORY_ROASTS[version_tag_avoider]="🏷️ **Version Tag Allergist** - What's a semantic version? Your releases are labeled 'v1', 'final', 'actually-final', and 'please-work'. You treat version numbers like they're cursed artifacts that shouldn't be touched!"

REPOSITORY_ROASTS[issue_template_ignorant]="📋 **Issue Template Rebel** - Bug reports? Feature requests? Templates are for the weak! Your issues section is a lawless wasteland where 'it doesn't work' is considered sufficient detail. You're pioneering a new form of minimalist project management!"

# Coding Pattern Roasts  
CODING_PATTERN_ROASTS[night_owl_extreme]="🦉 **The 4AM Code Vampire** - %d%% of your commits happen after midnight! You code like a vampire who's allergic to sunlight and productivity tools. Your circadian rhythm is more broken than Internet Explorer. But hey, bugs are easier to catch when they're also tired!"

CODING_PATTERN_ROASTS[weekend_warrior]="⚔️ **Weekend Code Warrior** - %d%% weekend commits! While others are out touching grass, you're touching keyboards. Your social life has fewer commits than your repos. Dating apps must love your 'always available except during deployments' energy!"

CODING_PATTERN_ROASTS[commit_spammer]="🌊 **The Commit Flood** - %d commits! You commit more often than people blink. Your git history reads like a live-tweet of your consciousness. 'Fixed semicolon', 'Fixed the fix', 'Fixed the fix of the fix' - are you coding or performing performance art?"

CODING_PATTERN_ROASTS[sporadic_coder]="🎢 **The Roller Coaster Developer** - Your commit pattern looks like a seismograph during an earthquake. You disappear for months, then suddenly commit 47 times in one day. Consistency is overrated when you have such beautiful chaos!"

CODING_PATTERN_ROASTS[perfectionist_paralysis]="🔍 **The Perfectionist Paradox** - You spend so much time making code perfect that you forget to actually ship anything. Your repositories are like museum pieces - beautiful, polished, and completely untouched by actual users. But hey, at least your variable names are works of art!"

# Programming Language Roasts - Enhanced with brutal but funny content
LANGUAGE_ROASTS[JavaScript]="🟡 **JavaScript Chaos Engineer** - You've voluntarily entered the realm where '==' and '===' are mortal enemies, where 'this' changes its meaning more often than a politician's promises, and where you can add an array to an object and get NaN. Your code works in mysterious ways - even to you! You've mastered the art of callback hell and emerged speaking in Promises. Async/await? That's just your life philosophy now!"

LANGUAGE_ROASTS[JavaScript_framework_junkie]="🎪 **Framework Circus Master** - React today, Vue tomorrow, Angular next week, and Svelte because why not! You change JavaScript frameworks more often than people change their Netflix passwords. Your package.json reads like a tech conference agenda. You've been to JavaScript framework rehab, but you relapsed when you saw that shiny new build tool!"

LANGUAGE_ROASTS[JavaScript_npm_addict]="📦 **NPM Dependency Dealer** - Why write 3 lines of code when you can install 47 packages? Your node_modules folder is so large it appears on satellite imagery. You've never met a left-pad utility you didn't like. Your computer's hard drive is 73% node_modules and 27% everything else. You're the reason JavaScript is the most bloated ecosystem - and somehow proud of it!"

LANGUAGE_ROASTS[Python]="🐍 **Python Zen Master** - You've achieved enlightenment through readable code, but you still rage-quit when you mix tabs and spaces. You think list comprehensions are poetry, and you're not wrong. Your code is so clean it could be used in a medical facility, but your deployment process involves more virtual environments than a VR arcade. Import this, import that - your solution to everything is 'there's a library for that!'"

LANGUAGE_ROASTS[Python_data_scientist]="📊 **Data Whisperer** - You speak fluent Pandas, NumPy, and matplotlib, but your production code looks like a Jupyter notebook that escaped into the wild. You can predict the future with machine learning models but can't predict when your script will finish running. Your computer has more virtual environments than a Hollywood studio. 'It works on my machine' - where 'machine' is a very specific combination of Anaconda, pip, and prayer!"

LANGUAGE_ROASTS[Python_web_developer]="🌐 **Django/Flask Conjurer** - You build web apps faster than people build sandwiches, but your templates are more tangled than Christmas lights. You've mastered the art of MVC until you realize you have 47 different models.py files. Your migrations folder looks like an archaeological dig site. 'Just pip install django' - famous last words before dependency hell!"

LANGUAGE_ROASTS[PHP]="🐘 **PHP Warrior** - You've chosen the language that's been 'dead' for 15 years but somehow still runs 78%% of the internet. You're like the developer equivalent of someone who still uses Internet Explorer by choice. But hey, job security is real when everyone else is too scared to touch legacy PHP!"

LANGUAGE_ROASTS[Java]="☕ **Java Purist** - You love your verbosity like a novelist loves adjectives. Why use 5 lines when you can use 50? Your code is so enterprise-grade that it needs its own HR department. But hey, at least when the apocalypse comes, Java will still be running somewhere, maintaining backward compatibility with the stone age!"

LANGUAGE_ROASTS[C]="⚡ **C Minimalist** - You code like it's 1972 and you love it! While others use frameworks, you manually allocate memory like a digital archaeologist. Your idea of dependency management is 'copy the .h file.' You're the developer equivalent of someone who still uses a flip phone because 'it just works.'"

LANGUAGE_ROASTS[CPlusPlus]="🔥 **C++ Gladiator** - You've chosen the language that's powerful enough to build anything and complex enough to break everything. You manage memory manually because you don't trust anyone else to do it right. Your template errors read like ancient curses written in a long-dead language!"

LANGUAGE_ROASTS[Go]="🔵 **Go Minimalist** - You've embraced the philosophy that less is more, except when it comes to error handling - then more is definitely more! 'if err != nil' is basically your personal mantra. You write code so simple that other developers think you're hiding the complexity somewhere else!"

LANGUAGE_ROASTS[Rust]="🦀 **Rust Evangelist** - You've discovered the holy grail of programming languages and won't let anyone forget it! You fight the borrow checker more often than most people fight traffic. But hey, at least when your code compiles, you KNOW it's safe - safer than a helicopter parent watching their kid cross the street!"

LANGUAGE_ROASTS[TypeScript]="🔷 **TypeScript Perfectionist** - JavaScript wasn't complicated enough for you, so you added types! You spend more time arguing with the TypeScript compiler than most people spend arguing with their spouse. But at least your 'any' type usage clearly shows your commitment to type safety!"

# Additional sophisticated roasting patterns
COMMIT_MESSAGE_ROASTS[emotional]="😭 **Emotional Commit Messages** - Your commit history reads like a developer's diary! 'WHY DOESN'T THIS WORK', 'finally got it working', 'I hate this project' - it's like watching someone's mental health journey through git log. At least you're honest about the struggle!"

COMMIT_MESSAGE_ROASTS[timestamps]="⏰ **Timestamp Confessions** - Your commit messages include timestamps like '3am fix' and 'friday night debugging session'. You're documenting your poor life choices in version control! Future archaeologists will study your commits to understand the decline of work-life balance in the 21st century!"

COMMIT_MESSAGE_ROASTS[profanity]="🤬 **Colorful Language Artist** - Your commit messages would make a sailor blush! You've turned git log into an R-rated experience. At least when someone runs 'git blame', they'll know EXACTLY how you felt about that particular piece of code!"

COMMIT_MESSAGE_ROASTS[novel_length]="📚 **The Commit Novelist** - Your commit messages are longer than most people's emails! You write commit descriptions like you're documenting the complete history of human civilization. Meanwhile, other developers write 'fix' and call it a day. The contrast is... educational!"

COMMIT_MESSAGE_ROASTS[cryptic_codes]="🔐 **Cryptic Code Master** - Your commit messages look like secret agent codes: 'BUG-1337: refactor xyz module w/ new algo'. You've turned version control into a puzzle game! Future developers will need a decoder ring to understand what you actually changed!"

# Repository pattern roasts with more humor
REPOSITORY_ROASTS[README_collector]="📄 **README Collector** - You have more README files than actual code! Your repositories are like museums - 90%% documentation, 10%% exhibits. You've perfected the art of describing what you're going to build instead of actually building it. At least your intentions are well-documented!"

REPOSITORY_ROASTS[todo_app_creator]="✅ **Todo App Connoisseur** - You've created the same todo application in 47 different frameworks! You're like the developer equivalent of someone who keeps starting diet plans on Monday. But hey, at least you're consistent in your inconsistency!"

REPOSITORY_ROASTS[unfinished_masterpieces]="🎨 **Unfinished Masterpiece Curator** - Your repositories are like art galleries full of half-finished paintings. 'This will be the next Facebook!' - commits 3 times, then crickets. You're the developer equivalent of someone with 50 hobbies and expertise in none!"

REPOSITORY_ROASTS[branch_hoarder]="🌿 **Branch Hoarder** - You create branches like they're going out of style and then forget they exist! Your repositories have more dead branches than a winter forest. 'feature/fix-login-maybe-v2-final-ACTUALLY-FINAL' - we can feel the desperation through the branch name!"

REPOSITORY_ROASTS[commit_message_novelist]="📚 **Commit Message Novelist** - Your commit messages are longer than the code changes themselves! You write git logs like you're documenting the complete history of human civilization. Meanwhile, other developers write 'fix' and call it a day. Your thoroughness is both admirable and exhausting!"

REPOSITORY_ROASTS[framework_collector]="🎯 **Framework Collector Supreme** - You've built the same app in React, Vue, Angular, Svelte, and probably some frameworks that don't exist yet! Your LinkedIn skills section looks like a JavaScript museum. You collect frameworks like Pokemon cards, but with more npm install commands!"

REPOSITORY_ROASTS[dependency_nightmare]="📦 **Dependency Hell Architect** - Your package.json files are longer than epic novels! You add dependencies for things that could be solved with 5 lines of vanilla code. Your node_modules folder is so large it has its own gravitational field!"

REPOSITORY_ROASTS[commit_timestamp_confessor]="⏰ **Timestamp Confessor** - Your commit messages document your poor life choices: '3AM fix', 'Sunday debugging', 'why am I doing this at midnight'. You're creating a permanent record of your self-destructive coding habits. Future archaeologists will study your commits to understand developer burnout!"

# Coding pattern enhancements with more sophisticated detection
CODING_PATTERN_ROASTS[documentation_avoider]="📝 **The Documentation Ghost** - You write code like you're protecting state secrets. Your functions are mysteries, your variables are riddles, and your README is a haiku of confusion. Comments? Those are for other developers - you live dangerously!"

CODING_PATTERN_ROASTS[refactoring_perfectionist]="🔄 **The Eternal Refactorer** - You refactor code more often than people change clothes. Your git history shows the same function being rewritten 47 times. You're like a digital sculptor who never stops chiseling, convinced that perfection is just one more refactor away!"

CODING_PATTERN_ROASTS[feature_branch_abandoner]="🏚️ **The Feature Branch Cemetery** - Your repositories are graveyards of abandoned feature branches. 'feature/add-login', 'hotfix/maybe-this-works', 'experimental/probably-broken' - each one a monument to good intentions and short attention spans!"

CODING_PATTERN_ROASTS[merge_conflict_warrior]="⚔️ **The Merge Conflict Warrior** - You resolve merge conflicts like you're negotiating peace treaties between warring code factions. Your git history reads like a diplomatic crisis. You've seen things in diff tools that would make other developers weep!"

CODING_PATTERN_ROASTS[copy_paste_artist]="🎨 **The Copy-Paste Virtuoso** - You've elevated code reuse to an art form! Stack Overflow is your gallery, and you're the curator. Your browser bookmarks are 90% programming solutions. You don't just stand on the shoulders of giants - you photocopy their entire bodies!"

LANGUAGE_ROASTS[Java]="☕ **Java Verbosity Master** - You write code so verbose it needs its own table of contents. Your 'Hello World' program is longer than most novels. You've mastered the art of saying in 100 lines what Python says in 5. But those enterprise paychecks though..."

LANGUAGE_ROASTS[C++]="⚡ **C++ Masochist** - You voluntarily manage memory in an age of garbage collectors. You're like someone who chooses to walk everywhere when Uber exists. Your pointers have better navigation skills than most GPS systems. Respect for the old-school dedication!"

LANGUAGE_ROASTS[Python]="🐍 **Python Zen Master** - Your code is so readable that non-programmers think they can code. You've embraced the 'batteries included' philosophy so hard you've forgotten how to implement a linked list. But hey, life's too short for curly braces!"

LANGUAGE_ROASTS[Go]="🚀 **Go Minimalist** - You've chosen the language that makes simplicity feel complicated. Your error handling has more 'if err != nil' than actual logic. You're building the future with goroutines and channels while everyone else is still arguing about async/await!"

LANGUAGE_ROASTS[Rust]="🦀 **Rust Safety Evangelist** - You've chosen the language that makes C++ developers feel like they've been living dangerously. Your code compiles once and runs forever, but writing it takes longer than the heat death of the universe. Your borrow checker is more overprotective than helicopter parents!"

LANGUAGE_ROASTS[CSS]="🎨 **CSS Wizard** - You make pixels dance with magic spells like 'display: flex' and 'position: absolute'. You've memorized browser compatibility tables like they're religious texts. Your divs are centered both horizontally and vertically, which makes you basically a superhero!"

# Compliment system (for balance)
declare -A COMPLIMENTS

COMPLIMENTS[consistent_coder]="🌟 **The Consistency Champion** - Your commit pattern shows the discipline of a Zen master! Regular commits, steady progress, and reliable contribution patterns. You're the developer equivalent of a Swiss watch - precise, dependable, and quietly impressive."

COMPLIMENTS[helpful_contributor]="🤝 **The Community Hero** - Your repositories and contributions show genuine care for helping others. You write documentation like love letters to future developers. The open source community is better because developers like you exist!"

COMPLIMENTS[polyglot_programmer]="🗣️ **The Code Polyglot** - You speak multiple programming languages with fluency that would make United Nations translators jealous! Your ability to adapt between different paradigms and ecosystems is genuinely impressive. You're a Swiss Army knife of software development!"

COMPLIMENTS[learning_journey]="📚 **The Eternal Student** - Your repository diversity shows a beautiful learning journey. You're not afraid to try new technologies, make mistakes, and grow from them. This curiosity and growth mindset is what separates good developers from great ones."

COMPLIMENTS[problem_solver]="🧩 **The Problem Solving Virtuoso** - Your commit messages and code patterns reveal someone who thinks deeply about problems before coding solutions. You're the developer who actually reads documentation and considers edge cases. The world needs more thoughtful coders like you!"

COMPLIMENTS[maintainer_dedication]="🛠️ **The Maintainer Marvel** - You don't just create code - you nurture it. Your long-term commitment to projects shows the kind of dedication that makes open source possible. You're building digital infrastructure that others can depend on."

# Dynamic result generation to eliminate repetition
declare -A ROAST_VARIATIONS
declare -A USED_ROASTS
declare -g ROAST_SESSION_ID=""

# Initialize dynamic roast system
init_dynamic_roasting() {
    ROAST_SESSION_ID=$(date +%s%N | cut -b1-13)  # Unique session ID
    USED_ROASTS=()
    
    # Create multiple variations for popular roast types
    ROAST_VARIATIONS[fix_stuff]="fix_stuff fix_stuff_v2 fix_stuff_v3"
    ROAST_VARIATIONS[javascript]="JavaScript JavaScript_framework_junkie JavaScript_npm_addict"
    ROAST_VARIATIONS[python]="Python Python_data_scientist Python_web_developer"
    ROAST_VARIATIONS[too_many_repos]="too_many_repos repository_collector repo_hoarder"
    ROAST_VARIATIONS[night_owl]="night_owl_extreme coding_vampire midnight_warrior"
}

# Enhanced roast selection with dynamic variations
select_dynamic_roast() {
    local base_roast="$1"
    local variations="${ROAST_VARIATIONS[$base_roast]:-$base_roast}"
    local variation_array=($variations)
    
    # Filter out already used roasts in this session
    local available_variations=()
    for variation in "${variation_array[@]}"; do
        if [[ -z "${USED_ROASTS[$variation]}" ]]; then
            available_variations+=("$variation")
        fi
    done
    
    # If all variations used, reset and use any variation
    if [[ ${#available_variations[@]} -eq 0 ]]; then
        available_variations=("${variation_array[@]}")
    fi
    
    # Select random variation
    local random_index=$(($RANDOM % ${#available_variations[@]}))
    local selected_roast="${available_variations[$random_index]}"
    
    # Mark as used
    USED_ROASTS[$selected_roast]=1
    
    echo "$selected_roast"
}

# Generate contextual roast variations
generate_contextual_variations() {
    local username="$1"
    local base_roast="$2"
    local context_data="$3"
    
    # Create user-specific hash for consistent but varied responses
    local user_hash=$(echo "$username$ROAST_SESSION_ID" | cksum | cut -d' ' -f1)
    local variation_seed=$((user_hash % 100))
    
    # Add contextual modifiers based on user data
    local modifiers=()
    if [[ $variation_seed -gt 75 ]]; then
        modifiers+=("legendary" "epic" "ultimate")
    elif [[ $variation_seed -gt 50 ]]; then
        modifiers+=("advanced" "seasoned" "experienced")
    elif [[ $variation_seed -gt 25 ]]; then
        modifiers+=("enthusiastic" "dedicated" "passionate")
    else
        modifiers+=("budding" "emerging" "aspiring")
    fi
    
    # Return modifier for dynamic text generation
    local random_modifier_index=$(($RANDOM % ${#modifiers[@]}))
    echo "${modifiers[$random_modifier_index]}"
}

# Main roasting functions - Enhanced with dynamic analysis
analyze_for_roasting() {
    local username="$1"
    local commit_messages="$2"
    local night_percentage="$3"
    local weekend_percentage="$4"
    local repo_count="$5"
    local total_commits="$6"
    
    local roasts=()
    
    # Initialize dynamic roasting system
    init_dynamic_roasting
    
    # Enhanced commit message pattern analysis with better detection
    if [[ "$commit_messages" =~ (fix.*stuff|fix.*things|stuff.*fixed|things.*updated) ]]; then
        roasts+=("$(select_dynamic_roast "fix_stuff")")
    fi
    
    if [[ "$commit_messages" =~ (wip|work.*in.*progress|still.*working|ongoing) ]]; then
        roasts+=("wip")
    fi
    
    if [[ "$commit_messages" =~ (it.*works|works.*now|finally.*working|success) ]]; then
        roasts+=("it_works")
    fi
    
    if [[ "$commit_messages" =~ (update|various|changes|modifications|adjustments) ]]; then
        roasts+=("various_changes")
    fi
    
    if [[ "$commit_messages" =~ (typo|fix.*typo|spelling|grammar|oops) ]]; then
        roasts+=("typo")
    fi
    
    # Enhanced emotional pattern detection
    if [[ "$commit_messages" =~ (please.*work|why.*god|hate.*this|frustrated|angry|wtf|damn|argh) ]]; then
        roasts+=("desperate_pleas")
    fi
    
    # Weekend/late night confession detection
    if [[ "$commit_messages" =~ (3am|midnight|2am|4am|late.*night|saturday|sunday|weekend) ]]; then
        roasts+=("weekend_confessions")
    fi
    
    # Emoji overload detection
    local emoji_count=$(echo "$commit_messages" | grep -o '[🔥💥✨🎉🚀🐛🎨📝🔧⚡🗑️💡🚨🔀📦🎯💎🌟⭐]' | wc -l)
    if [[ $emoji_count -gt 5 ]]; then
        roasts+=("emoji_overload")
    fi
    
    # All caps detection
    local caps_count=$(echo "$commit_messages" | grep -o '[A-Z][A-Z][A-Z][A-Z]*' | wc -l)
    if [[ $caps_count -gt 3 ]]; then
        roasts+=("all_caps_rage")
    fi
    
    # Advanced repository pattern analysis
    if [[ $repo_count -gt 50 ]]; then
        roasts+=("$(select_dynamic_roast "too_many_repos")")
    elif [[ $repo_count -gt 30 ]]; then
        roasts+=("repository_collector")
    fi
    
    # Enhanced coding pattern analysis
    if [[ $night_percentage -gt 70 ]]; then
        roasts+=("$(select_dynamic_roast "night_owl")")
    fi
    
    if [[ $weekend_percentage -gt 50 ]]; then
        roasts+=("weekend_warrior")
    fi
    
    if [[ $total_commits -gt 2000 ]]; then
        roasts+=("commit_spammer")
    fi
    
    # Language-specific pattern detection (enhanced)
    local primary_language="${PRIMARY_LANGUAGES[0]:-Unknown}"
    case "$primary_language" in
        "JavaScript"|"TypeScript")
            if [[ "$commit_messages" =~ (npm.*install|package.*json|node_modules|framework) ]]; then
                roasts+=("$(select_dynamic_roast "javascript")")
            fi
            ;;
        "Python")
            if [[ "$commit_messages" =~ (pip.*install|requirements|virtualenv|conda|jupyter) ]]; then
                roasts+=("$(select_dynamic_roast "python")")
            fi
            ;;
    esac
    
    # Return contextually appropriate roast with user-specific variation
    if [[ ${#roasts[@]} -gt 0 ]]; then
        local random_index=$(($RANDOM % ${#roasts[@]}))
        local selected_roast="${roasts[$random_index]}"
        
        # Add contextual modifier
        local modifier=$(generate_contextual_variations "$username" "$selected_roast" "$commit_messages")
        echo "${selected_roast}:${modifier}"
    else
        echo "general_roast:balanced"
    fi
}

generate_roast() {
    local roast_type_full="$1"
    local username="$2" 
    local night_percentage="$3"
    local weekend_percentage="$4"
    local repo_count="$5"
    local total_commits="$6"
    
    # Extract base roast type (remove :modifier if present)
    local roast_type="${roast_type_full%%:*}"
    
    # Check COMMIT_MESSAGE_ROASTS first
    if [[ -n "${COMMIT_MESSAGE_ROASTS[$roast_type]}" ]]; then
        printf "%s\n" "${COMMIT_MESSAGE_ROASTS[$roast_type]}"
        return
    fi
    
    # Check REPOSITORY_ROASTS
    if [[ -n "${REPOSITORY_ROASTS[$roast_type]}" ]]; then
        printf "${REPOSITORY_ROASTS[$roast_type]}\n" "$repo_count"
        return
    fi
    
    # Check CODING_PATTERN_ROASTS  
    if [[ -n "${CODING_PATTERN_ROASTS[$roast_type]}" ]]; then
        if [[ "$roast_type" == "commit_spammer" ]]; then
            printf "${CODING_PATTERN_ROASTS[$roast_type]}\n" "$total_commits"
        else
            printf "${CODING_PATTERN_ROASTS[$roast_type]}\n" "$night_percentage"
        fi
        return
    fi
    
    # Check for dynamic variants (fix_stuff_v2, fix_stuff_v3, etc.)
    case $roast_type in
        fix_stuff*|wip*|it_works*|various_changes*|update*|typo*|emotional*|timestamps*|novel_length*|cryptic_codes*|profanity*)
            # Map variants back to base types for commit message roasts
            local base_type=""
            case $roast_type in
                fix_stuff*) base_type="fix_stuff" ;;
                wip*) base_type="wip" ;;
                it_works*) base_type="it_works" ;;
                various_changes*) base_type="various_changes" ;;
                update*) base_type="update" ;;
                typo*) base_type="typo" ;;
                emotional*) base_type="emotional" ;;
                timestamps*) base_type="timestamps" ;;
                novel_length*) base_type="novel_length" ;;
                cryptic_codes*) base_type="cryptic_codes" ;;
                profanity*) base_type="profanity" ;;
            esac
            if [[ -n "$base_type" && -n "${COMMIT_MESSAGE_ROASTS[$base_type]}" ]]; then
                printf "%s\n" "${COMMIT_MESSAGE_ROASTS[$base_type]}"
                return
            fi
            ;;
        night_owl*|coding_vampire*|midnight_warrior*)
            # Map night owl variants
            if [[ -n "${CODING_PATTERN_ROASTS[night_owl_extreme]}" ]]; then
                printf "${CODING_PATTERN_ROASTS[night_owl_extreme]}\n" "$night_percentage"
                return
            fi
            ;;
        JavaScript*|Python*|too_many_repos*|repository_collector*|repo_hoarder*)
            # Handle language and repo variants - these might not have specific roasts yet
            # so fall through to default for now
            ;;
    esac
    
    # Fallback for unmatched roast types
    echo "🎭 **You're Actually Pretty Great!** - We searched high and low for roast material, but your coding patterns are frustratingly reasonable. Your commit messages make sense, your repositories are well-maintained, and your coding habits are admirably balanced. How dare you be this competent! We'll have to roast you for being too good at this. The audacity!"
}

generate_language_roast() {
    local primary_language="$1"
    
    if [[ -n "${LANGUAGE_ROASTS[$primary_language]}" ]]; then
        echo "${LANGUAGE_ROASTS[$primary_language]}"
    else
        echo "🤖 **Language Hipster** - You code in $primary_language, which is either so cutting-edge it hasn't been invented yet, or so obscure that only 12 people on Earth understand it. Either way, you're definitely more interesting at programming meetups than the rest of us vanilla developers!"
    fi
}

analyze_for_compliments() {
    local username="$1"
    local commit_messages="$2"
    local night_percentage="$3"
    local weekend_percentage="$4"
    local repo_count="$5"
    local total_commits="$6"
    
    local compliments=()
    
    # Analyze for positive patterns
    if [[ $total_commits -gt 100 && $weekend_percentage -lt 30 && $night_percentage -lt 50 ]]; then
        compliments+=("consistent_coder")
    fi
    
    if [[ "$commit_messages" =~ (docs|documentation|readme|help|example) ]]; then
        compliments+=("helpful_contributor")
    fi
    
    if [[ $repo_count -gt 10 && $repo_count -lt 50 ]]; then
        compliments+=("maintainer_dedication")
    fi
    
    # Check for learning journey
    if [[ $repo_count -gt 5 ]]; then
        compliments+=("learning_journey")
    fi
    
    # Always include these as fallbacks
    compliments+=("problem_solver" "polyglot_programmer")
    
    # Return random compliment
    local random_index=$(($RANDOM % ${#compliments[@]}))
    echo "${compliments[$random_index]}"
}

generate_compliment() {
    local compliment_type="$1"
    
    # Return the compliment if it exists
    if [[ -n "${COMPLIMENTS[$compliment_type]}" ]]; then
        echo "${COMPLIMENTS[$compliment_type]}"
    else
        # Fallback compliment for missing types
        echo "🌟 **The Unique Developer** - Your coding style and patterns are distinctively yours! You bring a fresh perspective to development that makes the tech community more diverse and interesting. Keep coding with your unique approach - it's what makes you valuable!"
    fi
}

display_roast_header() {
    echo
    echo "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"
    echo "🔥                                                                🔥"
    echo "🔥           💀 ROAST MODE ACTIVATED 💀                          🔥" 
    echo "🔥                                                                🔥"
    echo "🔥     \"Where code meets comedy and feelings get compiled away\"    🔥"
    echo "🔥                                                                🔥"
    echo "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"
    echo
    echo "📝 Remember: If you can't laugh at your code, who can? 😄"
    echo
}

display_compliment_header() {
    echo
    echo "✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨"
    echo "✨                                                                ✨"
    echo "✨           💝 COMPLIMENT MODE ACTIVATED 💝                      ✨" 
    echo "✨                                                                ✨"
    echo "✨     \"Celebrating the beautiful chaos that is your code\"        ✨"
    echo "✨                                                                ✨"
    echo "✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨"
    echo
    echo "🌟 **Because every developer deserves recognition for their journey!** 🌟"
    echo
}

run_roast_mode() {
    local username="$1"
    
    display_roast_header
    
    echo "🔍 **Analyzing @$username's code for prime roasting material...** 🔍"
    echo
    echo
    sleep 2
    
    # Analyze user data for roasting (using globals from github-analyzer)
    local commit_msgs="${COMMIT_MESSAGES[*]}"
    local night_pct=$(get_night_owl_score)
    local weekend_pct=$(get_weekend_warrior_score) 
    local repo_cnt="${REPO_COUNT:-5}"
    local total_commits="${TOTAL_COMMITS:-50}"
    local primary_lang="${PRIMARY_LANGUAGES[0]:-JavaScript}"
    
    # Get roast material
    local roast_type=$(analyze_for_roasting "$username" "$commit_msgs" "$night_pct" "$weekend_pct" "$repo_cnt" "$total_commits")
    
    display_comedy_section "🎯 **THE MAIN ROAST** 🎯"
    wrap_and_indent_text "$(generate_roast "$roast_type" "$username" "$night_pct" "$weekend_pct" "$repo_cnt" "$total_commits")"
    
    display_comedy_section "🗣️ **LANGUAGE CHOICE ROAST** 🗣️"
    wrap_and_indent_text "$(generate_language_roast "$primary_lang")"
    
    echo "🎭 **But seriously...** You're awesome for letting us roast your code!"
    echo "💻 Keep coding, keep improving, and keep having fun with it!"
    echo
}

run_compliment_mode() {
    local username="$1"
    
    display_compliment_header
    
    echo "🔍 **Analyzing @$username's code for amazing qualities...** 🔍"
    echo
    sleep 1
    
    # Analyze user data for compliments (using globals from github-analyzer)
    local commit_msgs="${COMMIT_MESSAGES[*]}"
    local night_pct="${NIGHT_OWL_PERCENTAGE:-30}"
    local weekend_pct="${WEEKEND_PERCENTAGE:-20}"
    local repo_cnt="${REPO_COUNT:-5}"
    local total_commits="${TOTAL_COMMITS:-50}"
    
    # Get compliment material
    local compliment_type=$(analyze_for_compliments "$username" "$commit_msgs" "$night_pct" "$weekend_pct" "$repo_cnt" "$total_commits")
    
    display_comedy_section "🌟 **YOUR CODING SUPERPOWERS** 🌟"
    wrap_and_indent_text "$(generate_compliment "$compliment_type")"
    
    echo "🎉 **Keep being awesome!** The coding world is better with developers like you!"
    echo "🚀 Your journey and dedication inspire others to keep learning and growing!"
    echo
}