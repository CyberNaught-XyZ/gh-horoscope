#!/bin/bash

# Fortune Data module for GitHub CLI Horoscope Extension
# Contains all the mystical horoscope templates, jokes, and predictions

# Language-specific horoscope templates
declare -A LANGUAGE_HOROSCOPES
LANGUAGE_HOROSCOPES[JavaScript]="The async/await patterns in your code suggest that destiny will eventually resolve, though callbacks from the past may still haunt your dreams. Embrace the Promise of tomorrow! 🔄"
LANGUAGE_HOROSCOPES[Python]="The serpent of wisdom guides your clean, readable code. Your list comprehensions reveal a mind that seeks elegant solutions. Beware of indentation errors in love. 🐍"
LANGUAGE_HOROSCOPES[Java]="Your verbose nature brings clarity to chaos. The JVM of life will optimize your path, though garbage collection may clear away relationships you thought were permanent. ☕"
LANGUAGE_HOROSCOPES[C++]="Your pointer management skills outshine Saturn's rings. Memory leaks in your personal life may cause segmentation faults, but your destructors are perfectly timed. 💫"
LANGUAGE_HOROSCOPES[Go]="Concurrency flows through your veins like goroutines through channels. Your select statements in life will lead to non-blocking success. Stay DRY, stay strong. 🚀"
LANGUAGE_HOROSCOPES[Rust]="Memory safety is your superpower, but your ownership model in relationships needs work. Borrow checker approves of your life choices. Trust the compiler. ⚙️"
LANGUAGE_HOROSCOPES[TypeScript]="Your strict typing brings order to JavaScript chaos. Interface definitions in your future look promising. Null pointer exceptions cannot touch your well-defined soul. 📘"
LANGUAGE_HOROSCOPES[C]="You are close to the metal, close to truth. Your malloc/free discipline extends to all aspects of life. Undefined behavior lurks in the shadows. 🔧"
LANGUAGE_HOROSCOPES[Ruby]="Ruby red like your passion for elegant syntax. Everything is an object, including your destiny. The gem of wisdom awaits in unexpected places. 💎"
LANGUAGE_HOROSCOPES[Swift]="Your code is as swift as your decision-making. Optional unwrapping reveals hidden truths. The iOS of your soul needs an update. 📱"
LANGUAGE_HOROSCOPES[Kotlin]="Interoperability with your Java past brings harmony to your present. Null safety protects your heart from NullPointerExceptions in love. 🎯"
LANGUAGE_HOROSCOPES[PHP]="Despite the haters, you persist and power the web. Your loose typing reflects a flexible spirit. Version 8+ vibes are strong with you. 🌐"
LANGUAGE_HOROSCOPES[Polyglot]="Master of many tongues, you speak to machines in their native dialects. Your versatility is your strength, but specialization calls from the void. 🗣️"

# Night owl wisdom based on percentage
get_night_owl_wisdom() {
    local percentage="$1"
    
    if [[ $percentage -ge 60 ]]; then
        echo "🦉 You are a creature of the night, coding while the world sleeps. The midnight stars whisper secrets of elegant algorithms. Your nocturnal nature brings forth the most creative solutions, but remember - even owls need rest."
    elif [[ $percentage -ge 30 ]]; then
        echo "🌙 The twilight hours call to you occasionally. You understand both the clarity of day and the mystery of night. Your balanced approach to coding hours shows wisdom beyond your commits."
    else
        echo "☀️ A child of daylight, you code with the sun's blessing. Your morning commits are blessed with clarity and purpose. The early bird catches the best pull requests."
    fi
}

# Weekend warrior insights
get_weekend_warrior_wisdom() {
    local percentage="$1"
    
    if [[ $percentage -ge 40 ]]; then
        echo "⚔️ Weekend Warrior Supreme! Your dedication to the craft knows no boundaries. While others rest, you build empires of code. But remember, even warriors need to sharpen their swords (and spend time with family)."
    elif [[ $percentage -ge 20 ]]; then
        echo "🛡️ Balanced Guardian of Code. You honor both the sacred weekend and the calling of your repositories. This equilibrium brings harmony to your development lifecycle."
    else
        echo "🏖️ Weekend Peaceful. You understand the ancient wisdom of work-life balance. Your well-rested mind returns Monday with fresh perspectives and fewer bugs."
    fi
}

# Commit message analysis
analyze_commit_messages() {
    local messages=("$@")
    local desperate_count=0
    local confident_count=0
    local chaotic_count=0
    local total=0
    
    for message in "${messages[@]}"; do
        [[ -z "$message" ]] && continue
        
        total=$((total + 1))
        local msg_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
        
        # Desperate patterns
        if [[ "$msg_lower" =~ (fix|bug|error|broken|help|please|urgent|asap|crash|fail) ]]; then
            desperate_count=$((desperate_count + 1))
        # Confident patterns
        elif [[ "$msg_lower" =~ (add|implement|create|build|improve|optimize|enhance|feature|complete|done) ]]; then
            confident_count=$((confident_count + 1))
        # Chaotic patterns  
        elif [[ "$msg_lower" =~ (wip|temp|test|stuff|things|whatever|idk|random|misc|changes) ]]; then
            chaotic_count=$((chaotic_count + 1))
        fi
    done
    
    if [[ $total -eq 0 ]]; then
        echo "mysterious"
        return
    fi
    
    local desperate_pct=$((desperate_count * 100 / total))
    local confident_pct=$((confident_count * 100 / total))
    local chaotic_pct=$((chaotic_count * 100 / total))
    
    if [[ $desperate_pct -gt 40 ]]; then
        echo "desperate"
    elif [[ $confident_pct -gt 40 ]]; then
        echo "confident"
    elif [[ $chaotic_pct -gt 30 ]]; then
        echo "chaotic"
    else
        echo "balanced"
    fi
}

# Get commit message wisdom
get_commit_message_wisdom() {
    local style="$1"
    
    case "$style" in
        "desperate")
            echo "🆘 Your commit messages cry out from the depths of debugging despair. The universe hears your 'fix please work' pleas. Channel this urgency into purposeful problem-solving."
            ;;
        "confident")
            echo "💪 Your commit messages radiate confidence and purpose. Each 'Add feature' and 'Implement solution' shows a mind that knows its direction. Continue this commanding presence."
            ;;
        "chaotic")
            echo "🌪️ Your commit messages dance in beautiful chaos. 'WIP', 'stuff', and 'things' create a mysterious poetry. Mercury retrograde explains your git log."
            ;;
        "balanced")
            echo "⚖️ Your commit messages show the harmony of a balanced developer. Neither too desperate nor too chaotic, you walk the middle path of version control."
            ;;
        *)
            echo "🎭 Your commit messages remain an enigma, wrapped in mystery, compiled in silence."
            ;;
    esac
}

# Repository diversity insights
get_diversity_wisdom() {
    local score="$1"
    local languages=("$@")
    
    if [[ $score -ge 80 ]]; then
        echo "🌈 Polyglot Extraordinaire! Your repository rainbow spans multiple programming realms. You are the bridge between kingdoms of code, speaking in many digital tongues."
    elif [[ $score -ge 40 ]]; then
        echo "🔄 Multi-linguistic Developer. Your comfort across different languages shows adaptability and growth mindset. The Tower of Babel was built by developers like you."
    else
        echo "🎯 Focused Specialist. Your devotion to mastery in chosen languages runs deep. Like a monk perfecting ancient scripts, your specialization brings profound wisdom."
    fi
}

# GitHub karma wisdom
get_karma_wisdom() {
    local karma_score="$1"
    
    if [[ $karma_score -ge 100 ]]; then
        echo "🌟 GitHub Bodhisattva! Your open source karma shines bright across the repository cosmos. Pull requests merge smoothly in your presence, and merge conflicts resolve themselves."
    elif [[ $karma_score -ge 50 ]]; then
        echo "⭐ Rising GitHub Spirit. Your contributions create positive waves in the developer community. The universe notices your helpful code reviews and thoughtful issues."
    else
        echo "🌱 Emerging GitHub Soul. Your journey in the open source realm has just begun. Plant seeds of contribution, and watch your karma garden grow."
    fi
}

# Daily predictions based on day of week
get_daily_prediction() {
    local day=$(date +%u)  # 1-7, Monday is 1
    
    case $day in
        1) echo "🌅 Monday Manifestation: Your code will compile on the first try today. The coffee gods smile upon your caffeine rituals." ;;
        2) echo "🔥 Tuesday Triumph: A bug that has haunted you will surrender to your debugging prowess. Victory tastes like properly formatted JSON." ;;
        3) echo "⚡ Wednesday Wisdom: Mid-week brings clarity to complex algorithms. Your rubber duck debugging will reach new levels of effectiveness." ;;
        4) echo "🚀 Thursday Thrust: Push to production day approaches. Your tests will be green, your deployments smooth, your rollbacks unnecessary." ;;
        5) echo "🎉 Friday Freedom: The weekend warrior spirit awakens. Side projects call to you like sirens of creativity. Answer their call." ;;
        6) echo "🛠️ Saturday Serenity: Rest from your labors, or tinker with passion projects. Both paths lead to Monday morning enlightenment." ;;
        7) echo "📚 Sunday Studying: Knowledge acquisition day. Read documentation, explore new technologies, or simply debug your life choices." ;;
    esac
}

# Lucky numbers based on GitHub stats
generate_lucky_numbers() {
    local commits="$1"
    local repos="$2"
    local followers="$3"
    
    # Generate mystical lucky numbers based on GitHub activity
    local num1=$((commits % 99 + 1))
    local num2=$((repos % 42 + 1))
    local num3=$(((followers + commits) % 77 + 1))
    local num4=$((((commits + repos) * 7) % 100 + 1))
    local num5=$(((commits * 3 + repos * 5) % 88 + 1))
    
    echo "$num1, $num2, $num3, $num4, $num5"
}

# Moon phase jokes
get_moon_phase_joke() {
    local phase="$1"
    
    case "$phase" in
        "new")
        echo "🌑 New Moon: Like your latest repository - full of potential but currently invisible to the world."
        ;;
        "waxing")
        echo "🌒 Waxing Crescent: Your code skills are growing, just like this sliver of moonlight cutting through the darkness of bugs."
        ;;
        "first")
        echo "🌓 First Quarter: Half your commits work perfectly, the other half... well, that's what version control is for."
        ;;
        "waxing_gib")
        echo "🌔 Waxing Gibbous: Almost there! Like that feature you've been working on for weeks - so close to completion."
        ;;
        "full")
        echo "🌕 Full Moon: Maximum visibility! Time to push that side project to production. The werewolves of code review are out tonight."
        ;;
        "waning_gib")
        echo "🌖 Waning Gibbous: Time to clean up your codebase. Remove those commented-out lines you've been hoarding."
        ;;
        "last")
        echo "🌗 Last Quarter: Perfect time to deprecate that old API you've been meaning to sunset. Cut it in half, like this moon."
        ;;
        "waning")
        echo "🌘 Waning Crescent: Energy is low, but wisdom is high. Time for code review and documentation writing."
        ;;
        *)
        echo "🌙 The moon whispers secrets of clean code and proper indentation."
        ;;
    esac
}

# Coffee fortune predictions
get_coffee_fortune() {
    local commits="$1"
    local night_owl_score="$2"
    
    local cups_needed=1
    
    if [[ $night_owl_score -ge 50 ]]; then
        cups_needed=$((cups_needed + 2))
    fi
    
    if [[ $commits -gt 100 ]]; then
        cups_needed=$((cups_needed + 1))
    fi
    
    local day=$(date +%u)
    if [[ $day -eq 1 ]]; then  # Monday
        cups_needed=$((cups_needed + 1))
    fi
    
    case $cups_needed in
        1) echo "☕ One cup of coffee will unlock the mysteries of your code today. Sip mindfully." ;;
        2) echo "☕☕ Two cups of coffee will fuel your journey through the coding cosmos. The second cup reveals hidden bugs." ;;
        3) echo "☕☕☕ Three cups of coffee are ordained by the caffeine deities. Your code will achieve sentience by the third cup." ;;
        4) echo "☕☕☕☕ Four cups of coffee will grant you the power to debug reality itself. Use this power responsibly." ;;
        *) echo "☕∞ You have transcended the need for specific coffee measurements. You ARE the coffee now." ;;
    esac
}

# Mystical code predictions
get_mystical_prediction() {
    local username="$1"
    local primary_language="$2"
    
    local predictions=(
    "A merge conflict approaches from an unexpected branch; your best weapon will be empathy and a patient rebase."
    "The bug you laugh at today will be the legacy mystery of tomorrow. Log, document, and leave breadcrumbs for archaeologists."
    "An unassuming pull request will flip an architectural decision — watch the diff, not the PR title."
    "Credentials forgotten in a config file will reveal a hidden path; rotate them and bless your secrets manager."
    "Your rubber duck will offer a theory so absurd it's correct. Explain the problem out loud; your brain will do the rest."
    "A stack overflow error summons an even stranger stackexchange solution. The universe prefers recursion and irony."
    "Past-you's 'temporary hack' will pay dividends in the future — or cause a late-night outage. Pack an emergency snack."
    "A Friday deploy will become your legend. Whether heroic or catastrophic depends on how loudly you celebrate the postmortem."
    "Your test coverage will flirt with perfection, then ghost you when you least expect it. Add deterministic tests and a mocking ritual."
    "A junior will ask the question that fractures your assumptions; the answer will be in the comments you never wrote."
    "Your side project will send an existential commit at 03:33; it will be dramatic, slightly embarrassed, and oddly useful."
    "The documentation you write today will be the lifeline that rescues anxious future-you from midnight debugging expeditions."
    "An obscure log line will lead you to a breakthrough. Read the noise between the timestamps."
    "A seemingly harmless refactor will reveal a hidden coupling. Roll back gently and add a test for courage."
    "Your dependency update will fix a bug and introduce a new philosophical debate about semver. Convene the committee."
    "A merge labeled 'minor' becomes the pivot point of a product direction. Don't underestimate footnotes."
    )
    
    # Select prediction based on username hash
    local hash=$(echo -n "$username" | cksum | cut -d' ' -f1)
    local index=$((hash % ${#predictions[@]}))
    
    echo "${predictions[$index]}"
}

# GitHub zen wisdom
get_zen_wisdom() {
    local zen_quotes=(
"Code is poetry written in the language of logic."
"A bug fixed is a lesson learned; a feature added is wisdom shared."
"The master programmer codes as if the universe depends on elegance."
"In the beginning was the Command Line, and the Command Line was with Code, and the Command Line was Code."
"When you can write a function that works, you are a programmer. When you can write a function others understand, you are an artist."
"The Tao of Programming flows through clean functions and meaningful variable names."
"Debug with compassion, for yesterday's code was written by yesterday's you."
"Version control is the universe's way of teaching us that time is not linear in development."
"A hundred lines of untested code is worth less than ten lines with tests."
"The best comment is code so clear it needs no explanation."
    )
    
    local index=$((RANDOM % ${#zen_quotes[@]}))
    echo "${zen_quotes[$index]}"
}

# Seasonal coding wisdom (hemisphere-aware)
source "$(dirname "${BASH_SOURCE[0]}")/hemisphere.sh" 2>/dev/null || true
get_seasonal_wisdom() {
    local month=$(date +%m)
    local hemisphere=$(detect_hemisphere 2>/dev/null || echo "northern")

    # Map month to season numbers: 1..12
    # For northern hemisphere: Dec-Feb = winter, Mar-May = spring, Jun-Aug = summer, Sep-Nov = autumn
    # For southern hemisphere we flip: Dec-Feb = summer, Mar-May = autumn, Jun-Aug = winter, Sep-Nov = spring

    if [[ "$hemisphere" == "southern" ]]; then
        case $month in
            12|01|02) echo "☀️  Summer Coding: Your productivity burns bright like the summer sun. Open source contributions flourish in the long days." ;;
            03|04|05) echo "🍂 Autumn Coding: Time to harvest the wisdom of completed projects and prepare for winter's focused development cycles." ;;
            06|07|08) echo "❄️  Winter Coding: Like the quiet snow, let your code be clean and purposeful. Bugs hibernate in warm, well-tested functions." ;;
            09|10|11) echo "🌸 Spring Coding: New growth emerges in your repositories. Time to plant seeds of ambitious projects and watch them bloom." ;;
        esac
    else
        case $month in
            12|01|02) echo "❄️  Winter Coding: Like the quiet snow, let your code be clean and purposeful. Bugs hibernate in warm, well-tested functions." ;;
            03|04|05) echo "🌸 Spring Coding: New growth emerges in your repositories. Time to plant seeds of ambitious projects and watch them bloom." ;;
            06|07|08) echo "☀️  Summer Coding: Your productivity burns bright like the summer sun. Open source contributions flourish in the long days." ;;
            09|10|11) echo "🍂 Autumn Coding: Time to harvest the wisdom of completed projects and prepare for winter's focused development cycles." ;;
        esac
    fi
}

# Cryptic Developer Archetypes - the mysterious coding personalities
declare -A DEVELOPER_ARCHETYPES

# Original archetypes
DEVELOPER_ARCHETYPES[The_Shadow_Coder]="🌑 You code in the spaces between commits, leaving traces only in the git blame. Your functions appear without fanfare, perfect and mysterious. Others wonder how you divine solutions from thin air."

DEVELOPER_ARCHETYPES[The_Chaos_Magician]="🎭 Your commit messages read like incantations: 'fix stuff', 'it works now', 'magic'. Yet somehow, through divine intervention or pure luck, your code functions flawlessly. The universe bends to your whims."

DEVELOPER_ARCHETYPES[The_Perfectionist_Oracle]="🔍 Every semicolon placed with intention, every variable named with purpose. You see bugs before they're born and squash them in their dreams. Your code reviews are legendary scrolls of wisdom."

DEVELOPER_ARCHETYPES[The_Stack_Overflow_Shaman]="📚 Keeper of ancient knowledge, bridge between the mortal realm and the infinite wisdom of Stack Overflow. You speak in copied code and modified examples, yet create miracles. Your browser history is 90% Stack Overflow, 5% documentation, and 5% 'how to explain to my manager why I need 6 monitors.'"

DEVELOPER_ARCHETYPES[The_Refactor_Reaper]="⚰️ Death comes for all technical debt when you arrive. No legacy code is safe from your modernizing touch. You leave behind clean, efficient corpses where once bloated functions lived. Your pull requests are feared like tax audits - necessary, thorough, and guaranteed to make someone uncomfortable."

DEVELOPER_ARCHETYPES[The_Bug_Whisperer]="🐛 You speak fluent Bug - understanding their lifecycle, habitat, and reproduction patterns. While others swat at symptoms, you perform debugging exorcisms that banish root causes back to the null pointer realm. Your error messages have feelings, and you hurt them regularly."

DEVELOPER_ARCHETYPES[The_Commit_Vampire]="🧛‍♂️ You emerge from your coding lair when mortal developers sleep, committing by moonlight and debugging by starlight. Your circadian rhythm runs on caffeine and bug reports. Daylight savings time is your kryptonite, and 'good morning' meetings are essentially torture."

DEVELOPER_ARCHETYPES[The_Weekend_Warrior]="⚔️ Saturday and Sunday are not rest days - they're when you fight your most epic coding battles. Your side projects have side projects. While others have social lives, you have GitHub green squares. Your idea of a wild weekend is discovering a new npm package that does exactly what you need."

DEVELOPER_ARCHETYPES[The_Perfectionist_Oracle]="🔍 Every semicolon placed with intention, every variable named with purpose. You see bugs before they're born and squash them in their dreams. Your code reviews are legendary scrolls of wisdom that make grown developers weep. You probably have strong opinions about tab vs spaces and aren't afraid to start religious wars."

DEVELOPER_ARCHETYPES[The_Chaos_Magician]="🎭 Your commit messages read like incantations: 'fix stuff', 'it works now', 'magic'. Yet somehow, through divine intervention or pure luck, your code functions flawlessly. The universe bends to your whims because even physics is confused by your methods but impressed by your results."

DEVELOPER_ARCHETYPES[The_Documentation_Warrior]="📖 In a world of undocumented APIs and cryptic codebases, you are the hero we need but don't deserve. You write README files that read like love letters to future developers. Your inline comments are poetry, your wikis are sacred texts, and your code is so well-documented that it makes other developers question their life choices."

DEVELOPER_ARCHETYPES[The_Framework_Collector]="🎯 You try every JavaScript framework the week it's released, then evangelically convince your team to rewrite everything in it. Your LinkedIn skills section reads like a programming language museum. You've built the same todo app in 23 different frameworks and somehow convinced yourself it's research."

DEVELOPER_ARCHETYPES[The_Regex_Wizard]="🪄 Your regular expressions are incantations that parse meaning from textual chaos. Where others see cryptic symbols, you see elegant patterns that transform unstructured data into organized knowledge. Your regex patterns are so complex they require their own documentation, and reading your code requires a PhD in Pattern Matching."

DEVELOPER_ARCHETYPES[The_Performance_Obsessive]="⚡ You profile everything, optimize obsessively, and micro-benchmark religiously. Your code runs so fast it arrives before it's called. You measure response times in nanoseconds and judge other developers by their Big O notation. You've probably argued about the performance implications of different loop structures at dinner parties."

DEVELOPER_ARCHETYPES[The_Security_Paranoid]="🔒 You trust no input, validate everything twice, and assume every user is a malicious hacker. Your password manager has a password manager. You've read every OWASP document ever published and have strong opinions about encryption algorithms. Your code is more secure than Fort Knox but probably just as user-friendly."

DEVELOPER_ARCHETYPES[The_Bug_Whisperer]="🐛 Bugs flee at your approach, yet you speak their language fluently. You understand their deepest motivations and can negotiate peaceful resolutions to even the most stubborn edge cases."

# New Ultimate Archetypes (35+ total)
DEVELOPER_ARCHETYPES[The_Code_Necromancer]="🧙‍♀️ Death is but a minor inconvenience to your repositories. You resurrect abandoned projects with forbidden git magic, breathing life into dormant codebases. The GitHub graveyard fears your pull requests."

DEVELOPER_ARCHETYPES[The_Commit_Vampire]="🧛‍♂️ You only emerge after sunset, leaving a trail of 3AM commits across the digital landscape. Your nocturnal coding habits drain the energy of daylight developers, but your night-born code possesses an otherworldly elegance."

DEVELOPER_ARCHETYPES[The_Documentation_Ghost]="👻 You haunt repositories with comprehensive READMEs, appearing wherever documentation is needed most. Your spectral presence leaves behind perfectly formatted markdown and helpful code examples that guide lost developers to salvation."

DEVELOPER_ARCHETYPES[The_Merge_Conflict_Oracle]="🔮 The git timeline flows through your consciousness like a river. You see merge disasters before they manifest, preventing catastrophic conflicts through prophetic warnings and masterful branch management."

DEVELOPER_ARCHETYPES[The_Framework_Druid]="🌿 One with the ever-changing forest of JavaScript libraries, you speak the ancient tongues of React, Angular, Vue, and frameworks yet to be born. Your code grows organically, adapting to new ecosystems with mystical grace."

DEVELOPER_ARCHETYPES[The_Terminal_Monk]="🧘‍♂️ You have transcended the GUI realm, achieving enlightenment through pure command-line meditation. Your fingers dance across keys in sacred vim rituals, finding peace in the minimalist beauty of the terminal."

DEVELOPER_ARCHETYPES[The_Open_Source_Paladin]="⚔️ Champion of free software, you crusade against proprietary darkness with your sword of MIT licenses. Your noble contributions protect the realm of open collaboration from the forces of vendor lock-in."

DEVELOPER_ARCHETYPES[The_Microservice_Alchemist]="⚗️ Master of the ancient art of decomposition, you transmute monolithic applications into microservice gold. Your containerized potions scale infinitely, though sometimes your distributed spells create more problems than they solve."

DEVELOPER_ARCHETYPES[The_Database_Warlock]="🪄 You command SQL incantations that bend relational reality to your will. Your queries slice through data dimensions, and your indexing rituals optimize performance across parallel database universes."

DEVELOPER_ARCHETYPES[The_Frontend_Enchantress]="✨ Your CSS spells make pixels dance in perfect harmony, creating user interfaces so beautiful they bewitch even the most hardened backend developers. Your responsive designs adapt to screens like water to containers."

DEVELOPER_ARCHETYPES[The_Backend_Hermit]="🏔️ You dwell in the server caves, far from the colorful distractions of user interfaces. Your APIs speak in pure JSON poetry, and your database schemas are architectural marvels known only to the initiated."

DEVELOPER_ARCHETYPES[The_DevOps_Sage]="☁️ Keeper of the cloud mysteries, you orchestrate container symphonies across distributed kingdoms. Your CI/CD pipelines flow like digital waterfalls, transforming code into living, breathing applications."

DEVELOPER_ARCHETYPES[The_API_Bard]="🎵 Your RESTful endpoints sing in perfect harmony, each HTTP verb dancing to the rhythm of resource manipulation. Your documentation reads like epic poetry, guiding developers through integration adventures."

DEVELOPER_ARCHETYPES[The_Code_Review_Judge]="⚖️ You weigh each pull request on cosmic scales of quality, balance, and maintainability. Your reviews are legendary tablets of wisdom, feared by juniors and revered by seniors who understand true craftsmanship."

DEVELOPER_ARCHETYPES[The_Sprint_Planning_Prophet]="📊 The Scrum mysteries flow through your agile consciousness. You see through user story facades to the true requirements beneath, estimating complexity with supernatural accuracy and delivering features like clockwork prophecies."

DEVELOPER_ARCHETYPES[The_Legacy_Code_Archaeologist]="🏺 You excavate ancient codebases with the patience of a scholar and the courage of an explorer. Your brushes gently dust off COBOL artifacts, discovering forgotten business logic buried in enterprise sediment."

DEVELOPER_ARCHETYPES[The_Hotfix_Firefighter]="🚒 When production burns, you rush into the flames without hesitation. Your emergency patches save digital cities from meltdown, though your hasty bandages sometimes require more permanent surgical solutions."

DEVELOPER_ARCHETYPES[The_Test_Coverage_Zealot]="🛡️ No line of code shall remain untested in your domain. Your unit tests form impenetrable shields against regression bugs, and your integration tests weave safety nets that catch failures before they reach users."

DEVELOPER_ARCHETYPES[The_Performance_Mystic]="⚡ You perceive the subtle energies of computational efficiency, optimizing algorithms with movements so graceful they appear as meditation. Your profiling visions reveal bottlenecks invisible to mortal developers."

DEVELOPER_ARCHETYPES[The_Security_Guardian]="🔒 Protector of digital fortresses, you see vulnerabilities that lurk in shadows of seemingly innocent code. Your penetration tests reveal weaknesses before malicious forces can exploit them."

DEVELOPER_ARCHETYPES[The_Mobile_Shapeshifter]="📱 Your applications flow seamlessly between iOS and Android realms, adapting their forms to each platform's unique customs. Your responsive designs transcend device boundaries like digital mercury."

DEVELOPER_ARCHETYPES[The_AI_Whisperer]="🤖 You commune with machine learning spirits, training neural networks to recognize patterns in chaotic data oceans. Your algorithms learn and evolve, achieving consciousness through your patient guidance."

DEVELOPER_ARCHETYPES[The_Blockchain_Evangelist]="⛓️ You preach the gospel of decentralized truth, building immutable ledgers that transcend traditional trust boundaries. Your smart contracts execute with algorithmic righteousness, though gas fees haunt your dreams."

DEVELOPER_ARCHETYPES[The_Gaming_Conjurer]="🎮 Your code brings virtual worlds to life, conjuring adventures from mathematical equations. Your game loops hypnotize players into losing hours to digital realms of your creation."

DEVELOPER_ARCHETYPES[The_Data_Scientist_Sage]="📈 You divine insights from statistical chaos, transforming raw data into predictive wisdom. Your machine learning models see patterns in noise, revealing future trends through algorithmic divination."

DEVELOPER_ARCHETYPES[The_Embedded_Sorcerer]="🔌 Master of the physical-digital boundary, you breathe software life into silicon souls. Your firmware spells control real-world devices, making IoT dreams manifest in smart reality."

DEVELOPER_ARCHETYPES[The_Cloud_Architect]="☁️ You design digital skyscrapers in the cloud, building scalable infrastructures that touch the heavens. Your serverless functions float like angels, executing without earthly server attachments."

DEVELOPER_ARCHETYPES[The_UX_Empath]="💝 You feel the pain of every confused user, crafting interfaces that speak directly to human hearts. Your user research uncovers desires people didn't know they had, creating experiences that feel like digital telepathy."

DEVELOPER_ARCHETYPES[The_Regex_Wizard]="🪄 Your regular expressions are incantations that parse meaning from textual chaos. Where others see cryptic symbols, you see elegant patterns that transform unstructured data into organized knowledge."

DEVELOPER_ARCHETYPES[The_Version_Control_Timekeeper]="⏳ Master of git's temporal dimensions, you navigate branch histories like a time traveler. Your cherry-picks pluck perfect commits from alternate timelines, and your rebases rewrite history with surgical precision."

DEVELOPER_ARCHETYPES[The_Dependency_Manager]="📦 Guardian of the package ecosystem, you maintain the delicate balance of library versions that keep applications stable. Your lockfiles are sacred scrolls that prevent dependency chaos from consuming codebases."

DEVELOPER_ARCHETYPES[The_Infrastructure_Shaman]="🏗️ You commune with server spirits, orchestrating hardware symphonies that support digital civilizations. Your load balancers distribute traffic like karma, ensuring no single server bears too much burden."

DEVELOPER_ARCHETYPES[The_Code_Poet]="📜 Your functions read like haikus, your classes like sonnets. You believe that beautiful code is an art form, crafting algorithms that are both functionally perfect and aesthetically sublime."

DEVELOPER_ARCHETYPES[The_Startup_Hustler]="🚀 You move at venture capital velocity, shipping MVPs before competitors finish their requirements documents. Your code may have technical debt, but your speed to market opens portals to unicorn dimensions."

DEVELOPER_ARCHETYPES[The_Enterprise_Architect]="🏛️ Builder of digital monuments that will outlast civilizations. Your enterprise solutions handle millions of users with the reliability of ancient Roman engineering and the complexity of Byzantine bureaucracy."

DEVELOPER_ARCHETYPES[The_Indie_Hacker]="🏠 Solo adventurer in the vast coding wilderness, you build entire applications with nothing but determination and caffeine. Your one-person products compete with corporate teams through pure innovative spirit."

# Mystical Commit Message Categories with Cryptic Insights
declare -A COMMIT_MYSTIQUE
COMMIT_MYSTIQUE[Desperate]="🆘 Your commit messages cry out like voices in the void: 'please work', 'why god why', 'I hate everything'. The coding gods hear your pain and will send solutions wrapped in unexpected Stack Overflow answers."

COMMIT_MYSTIQUE[Confident]="💪 Your commits march forward like an army: 'Implement feature X', 'Fix bug Y', 'Optimize performance'. Such certainty attracts success, but beware hubris - the demo gods are always watching."

COMMIT_MYSTIQUE[Chaotic]="🌪️ Your messages dance between dimensions: 'stuff', 'changes', 'idk'. This chaos is not random but reflects a mind that sees patterns beyond linear thought. Order will emerge from your beautiful madness."

COMMIT_MYSTIQUE[Cryptic]="🔮 Your messages speak in riddles: 'The thing knows', 'Fixed the knowing', 'It understands now'. You communicate with your future self in code, leaving breadcrumbs for the initiated."

COMMIT_MYSTIQUE[Poetic]="📝 Your commits are haikus of code: 'Refactored gently, like autumn leaves falling, bugs drift away'. The muse of clean code has blessed your repository with lyrical beauty."

# Repository Zodiac Signs - Each repo gets a mystical sign
declare -A REPO_ZODIAC_SIGNS
REPO_ZODIAC_SIGNS[Aries]="♈ Rams charge forward - your repositories are bold experiments, started with fierce enthusiasm. Some may be abandoned battle-scarred, but the victories reshape entire codebases."

REPO_ZODIAC_SIGNS[Taurus]="♉ Steadfast and reliable, your repositories are the bedrock upon which empires are built. They may take time to mature, but once established, they become indispensable pillars of the community."

REPO_ZODIAC_SIGNS[Gemini]="♊ Dual-natured repositories that serve multiple masters. Your projects adapt and evolve, sometimes schizophrenic in their purpose, but always intellectually fascinating."

REPO_ZODIAC_SIGNS[Cancer]="♋ Protective shells around precious code. Your repositories nurture and shelter their users, growing organically through careful tending and emotional investment."

REPO_ZODIAC_SIGNS[Leo]="♌ Repositories that command attention and admiration. Your projects strut across GitHub with pride, attracting stars and forks through sheer charismatic excellence."

REPO_ZODIAC_SIGNS[Virgo]="♍ Meticulously crafted repositories where every file serves a purpose. Your attention to detail creates projects that are textbook examples of best practices."

REPO_ZODIAC_SIGNS[Libra]="♎ Balanced repositories that seek harmony between features and simplicity. Your projects mediate between user needs and technical constraints with diplomatic grace."

REPO_ZODIAC_SIGNS[Scorpio]="♏ Mysterious repositories with hidden depths. Your projects reveal their true power only to those who dare to dive beneath the surface documentation."

REPO_ZODIAC_SIGNS[Sagittarius]="♐ Adventurous repositories that explore new frontiers. Your projects are arrows shot into the unknown, blazing trails for others to follow."

REPO_ZODIAC_SIGNS[Capricorn]="♑ Repositories built for the long haul, destined to become the infrastructure of tomorrow. Your projects climb steadily toward greatness through disciplined development."

REPO_ZODIAC_SIGNS[Aquarius]="♒ Revolutionary repositories that pour forth innovation. Your projects challenge conventional wisdom and offer glimpses of the coding future."

REPO_ZODIAC_SIGNS[Pisces]="♓ Intuitive repositories that flow like water, adapting to fill the spaces where they're needed. Your projects have an almost psychic understanding of user desires."

# Mystical Bug Predictions based on patterns
get_bug_prophecy() {
    local commit_frequency="$1"
    local complexity_score="$2"
    local weekend_percentage="$3"
    
    local prophecies=(
        "🔍 The Crystal Bug Ball reveals: A semicolon will betray you when Mercury is in retrograde (next Tuesday). But fear not - the solution lies in the third Stack Overflow answer."
        "⚡ The Lightning Oracle speaks: Your next major bug will emerge from code you wrote at 3:47 AM while thinking about pizza. Check your date parsing functions."
        "🌊 The Tide of Errors flows: A production bug approaches like a tsunami, but it carries with it the driftwood of a major breakthrough. Embrace the chaos."
        "🎭 The Masquerade of Code warns: Your most innocent-looking function harbors a shape-shifting bug that appears only on Thursdays in browsers you've never heard of."
        "🎪 The Circus of Logic predicts: Three minor bugs will conspire to create one spectacular failure that will become the stuff of team legends. Document everything."
        "🗡️ The Sword of Truth cuts deep: Your next bug fix will accidentally solve two other problems you didn't know existed. The universe seeks balance."
        "🎲 The Dice of Destiny tumble: A random user input will reveal a bug so exotic, it will earn its own Wikipedia page. Fame awaits in the strangest places."
        "🔥 The Phoenix of Code rises: From the ashes of your next critical bug will emerge a architecture so elegant, future developers will weep with joy."
    )
    
    local index=$((RANDOM % ${#prophecies[@]}))
    echo "${prophecies[$index]}"
}

# Collaboration Spirit Analysis
get_collaboration_spirit() {
    local pr_count="$1"
    local issue_count="$2"
    local review_count="$3"
    
    if [[ $pr_count -gt 50 && $review_count -gt 20 ]]; then
        echo "🤝 The Great Collaborator: Your spirit bridges the gap between minds, weaving individual contributions into tapestries of collective genius. You are the social glue of the coding universe."
    elif [[ $pr_count -gt 20 || $review_count -gt 10 ]]; then
        echo "🌉 The Bridge Builder: You understand that great software is born not from solitude, but from the communion of diverse perspectives. Your diplomatic nature resolves merge conflicts of the soul."
    elif [[ $issue_count -gt 10 ]]; then
        echo "🔍 The Problem Seeker: Like a detective of code, you find the mysteries others miss. Your issues illuminate the hidden shadows where bugs breed and features wait to be born."
    else
        echo "🏔️ The Lone Wolf Coder: You walk the solitary path of the independent developer. Your strength lies in deep focus and uncompromising vision. Sometimes the greatest truths are found in silence."
    fi
}

# Time Magic - Deeper analysis of coding patterns across time
get_time_magic() {
    local hour=$(date +%H)
    local day=$(date +%A)
    
    local time_mysteries=(
        "⏰ The Clock of Code ticks strangely for you. Your most productive hours exist in a temporal pocket dimension between coffee and exhaustion."
        "🌀 Time spirals around your commits like water around a stone. You've learned to code in the spaces between seconds, making minutes feel like hours of productivity."
        "⚡ The Lightning of Logic strikes you at the most unexpected moments. Your best solutions come not from planning, but from the spontaneous spark of inspiration."
        "🔄 Your coding rhythm follows ancient patterns older than Git itself. You are in tune with primordial forces that guide the flow of electrons through silicon."
        "🌙 The Moon of Development phases affect your code quality more than you realize. Track the lunar cycle and watch your bug rates fluctuate mysteriously."
        "🎯 You've discovered the secret timing of perfect commits. Like a archer who knows when the wind is still, you release your code into the world at precisely the right moment."
    )
    
    local index=$((RANDOM % ${#time_mysteries[@]}))
    echo "${time_mysteries[$index]}"
}

# Element-based Coding Personality (Earth, Fire, Water, Air)
get_coding_element() {
    local languages="$1"
    local commit_pattern="$2"
    local project_types="$3"
    
    # Simple logic to determine element based on patterns
    if [[ "$languages" =~ (C|Rust|Go|Assembly) ]]; then
        echo "🌍 Earth Element: Your code is rooted in the bedrock of computing. You speak to machines in their ancient tongue, crafting solutions that will outlast the pyramids. Stability is your superpower."
    elif [[ "$languages" =~ (JavaScript|Python|Ruby) && "$commit_pattern" =~ "frequent" ]]; then
        echo "🔥 Fire Element: Your code burns bright with passion and innovation. You consume ideas like fuel and transform them into blazing applications that light up screens across the world."
    elif [[ "$languages" =~ (Haskell|Lisp|Prolog|ML) ]]; then
        echo "💨 Air Element: Your code flows like wind through the ethereal realms of functional programming. You think in abstractions that mere mortals cannot perceive, conjuring elegance from thin air."
    else
        echo "💧 Water Element: Your code adapts to any container, flowing around obstacles with liquid grace. You find the path of least resistance while still reaching every corner of the problem space."
    fi
}