#!/bin/bash

# 🔮 GitHub CLI Horoscope Extension Setup Script
# Easy GitHub token configuration with validation and permissions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ASCII Art Banner
display_setup_banner() {
    echo -e "${MAGENTA}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                    🔮 HOROSCOPE SETUP WIZARD 🔮                      ║"
    echo "║                                                                      ║"
    echo "║              Setting up your mystical coding environment             ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
}

# Utility functions
print_success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

print_error() {
    echo -e "${RED}❌ $1${RESET}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${RESET}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${RESET}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Validate GitHub token format (basic check)
validate_github_token() {
    local token="$1"
    # GitHub tokens should start with certain prefixes and be a specific length
    if [[ ${#token} -lt 20 ]]; then
        return 1
    fi
    # Check for valid token prefixes (personal access token patterns)
    if [[ "$token" =~ ^(ghp_|gho_|ghu_|ghs_|ghr_) ]] || [[ ${#token} -eq 40 ]]; then
        return 0
    fi
    return 1
}

# Test GitHub token functionality
test_github_token() {
    local token="$1"
    print_info "Testing GitHub token functionality..."
    
    if command_exists gh; then
        # Test with GitHub CLI if available
        if GITHUB_TOKEN="$token" gh api user >/dev/null 2>&1; then
            print_success "GitHub token is valid and working!"
            return 0
        else
            print_error "GitHub token test failed - token may be invalid or expired"
            return 1
        fi
    else
        # Test with curl if gh CLI not available
        local response=$(curl -s -H "Authorization: token $token" https://api.github.com/user)
        if echo "$response" | grep -q '"login"'; then
            print_success "GitHub token is valid and working!"
            return 0
        else
            print_error "GitHub token test failed - token may be invalid or expired"
            return 1
        fi
    fi
}

# Main setup function
main() {
    display_setup_banner
    
    print_info "🌟 Welcome to the GitHub Horoscope Extension setup!"
    echo
    
    # Check for dependencies
    print_info "🔍 Checking system dependencies..."
    
    local missing_deps=()
    
    # Check for essential commands
    if ! command_exists curl; then
        missing_deps+=("curl")
    fi
    
    if ! command_exists jq; then
        missing_deps+=("jq")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        print_info "Please install missing dependencies and run setup again"
        print_info "Ubuntu/Debian: sudo apt install ${missing_deps[*]}"
        print_info "macOS: brew install ${missing_deps[*]}"
        exit 1
    fi
    
    print_success "All system dependencies found!"
    echo
    
    # Check GitHub CLI installation
    print_info "🔍 Checking GitHub CLI installation..."
    if command_exists gh; then
        print_success "GitHub CLI found: $(gh --version | head -n1)"
        
        # Check if already authenticated
        if gh auth status >/dev/null 2>&1; then
            print_success "GitHub CLI is already authenticated!"
            local current_user=$(gh api user --jq '.login' 2>/dev/null || echo "unknown")
            print_info "Authenticated as: $current_user"
            echo
        else
            print_warning "GitHub CLI is not authenticated"
            print_info "You can authenticate later with: gh auth login"
            echo
        fi
    else
        print_warning "GitHub CLI not found - some features will be limited"
        print_info "Install GitHub CLI for full functionality:"
        print_info "https://cli.github.com/"
        echo
    fi
    
    # Configuration directory setup
    print_info "📂 Setting up configuration directory..."
    CONFIG_DIR="$HOME/.gh-horoscope"
    mkdir -p "$CONFIG_DIR"
    chmod 700 "$CONFIG_DIR"  # Secure permissions
    print_success "Configuration directory created: $CONFIG_DIR"
    
    # Set up log directory
    LOG_DIR="$CONFIG_DIR/logs"
    mkdir -p "$LOG_DIR"
    chmod 700 "$LOG_DIR"
    print_success "Log directory created: $LOG_DIR"
    
    # GitHub Token Configuration
    print_info "🔑 GitHub Token Configuration..."
    echo
    
    local setup_token=false
    
    # Check existing token
    if [[ -n "$GITHUB_TOKEN" ]]; then
        print_info "Found GITHUB_TOKEN environment variable"
        if validate_github_token "$GITHUB_TOKEN"; then
            if test_github_token "$GITHUB_TOKEN"; then
                print_success "Existing GitHub token is valid!"
            else
                print_warning "Existing GitHub token failed validation"
                setup_token=true
            fi
        else
            print_warning "Existing GitHub token appears malformed"
            setup_token=true
        fi
    else
        print_info "No GITHUB_TOKEN environment variable found"
        setup_token=true
    fi
    
    # Interactive token setup if needed
    if [[ "$setup_token" == "true" ]]; then
        echo
        print_info "🎯 To get the full mystical experience, you'll need a GitHub token."
        print_info "Don't worry - I'll guide you through the process!"
        echo
        echo -e "${WHITE}Steps to create a GitHub token:${RESET}"
        echo "1. Visit: https://github.com/settings/tokens/new"
        echo "2. Give it a name like 'GitHub Horoscope'"  
        echo "3. Set expiration (or no expiration for convenience)"
        echo "4. Select scopes: 'public_repo' and 'read:user'"
        echo "5. Click 'Generate token' and copy it"
        echo
        
        read -p "Do you want to set up your GitHub token now? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo
            read -p "🔑 Paste your GitHub token here: " -s token
            echo
            echo
            
            if [[ -n "$token" ]]; then
                if validate_github_token "$token"; then
                    if test_github_token "$token"; then
                        # Save to config file securely
                        echo "export GITHUB_TOKEN=\"$token\"" > "$CONFIG_DIR/token"
                        chmod 600 "$CONFIG_DIR/token"
                        print_success "GitHub token saved securely!"
                        print_info "To use the token, source it: source ~/.gh-horoscope/token"
                        print_info "Or add this to your ~/.bashrc or ~/.zshrc:"
                        print_info "  source ~/.gh-horoscope/token"
                    else
                        print_error "Token validation failed - please check your token"
                    fi
                else
                    print_error "Token format appears invalid - please check your token"
                fi
            else
                print_warning "No token provided - you can set it up later"
            fi
        else
            print_info "No problem! You can set up your token later with:"
            print_info "  export GITHUB_TOKEN='your_token_here'"
        fi
    fi
    
    echo
    
    # Set executable permissions on main script
    print_info "🔧 Setting up script permissions..."
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    if [[ -f "$SCRIPT_DIR/gh-horoscope" ]]; then
        chmod +x "$SCRIPT_DIR/gh-horoscope"
        print_success "Made gh-horoscope executable"
    fi
    
    # Make all library scripts executable too
    if [[ -d "$SCRIPT_DIR/lib" ]]; then
        chmod +x "$SCRIPT_DIR/lib"/*.sh 2>/dev/null || true
        print_success "Set permissions on library scripts"
    fi
    
    # Final setup completion
    echo
    print_success "🎉 Setup completed successfully!"
    echo
    print_info "🚀 Quick start:"
    echo "  ./gh-horoscope --help      # See all options"
    echo "  ./gh-horoscope demo-user   # Try demo mode"
    echo "  ./gh-horoscope -i          # Interactive mystical experience"
    echo
    
    if [[ ! -n "$GITHUB_TOKEN" ]] && [[ ! -f "$CONFIG_DIR/token" ]]; then
        print_warning "💡 Pro tip: Set up GitHub authentication for full features:"
        echo "  gh auth login   # If you have GitHub CLI"
        echo "  OR"
        echo "  export GITHUB_TOKEN='your_token'   # Manual setup"
    fi
    
    echo
    print_info "🔮 Ready to divine your coding destiny!"
    echo -e "${MAGENTA}✨ May your commits be meaningful and your bugs be few! ✨${RESET}"
}

# Run main function
main "$@"
