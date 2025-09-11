#!/bin/bash

# Niteshift Development Environment Setup Script
# This script automates the setup of a development environment for jonshea/config-files

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Install dependencies based on OS
install_dependencies() {
    local os=$(detect_os)
    
    log_info "Installing dependencies for $os..."
    
    case $os in
        "macos")
            install_macos_dependencies
            ;;
        "linux")
            install_linux_dependencies
            ;;
        *)
            log_warning "Unknown OS type: $OSTYPE. Skipping dependency installation."
            ;;
    esac
}

install_macos_dependencies() {
    log_info "Installing Homebrew and packages..."
    
    # Install Homebrew if not present
    if ! command_exists brew; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for this session
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
    
    # Update brew
    brew update
    
    # Check if Brewfile exists and use it
    if [[ -f "Brewfile" ]]; then
        log_info "Installing packages from Brewfile..."
        brew bundle install --file=Brewfile || log_warning "Some packages from Brewfile failed to install"
    else
        log_warning "Brewfile not found, skipping package installation"
    fi
}

install_linux_dependencies() {
    log_info "Installing Linux packages..."
    
    # Detect package manager
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y \
            git \
            zsh \
            tmux \
            wget \
            curl \
            build-essential \
            python3 \
            python3-pip \
            nodejs \
            npm \
            redis-server \
            postgresql \
            postgresql-contrib \
            ripgrep \
            fd-find
            
        # Install fzf manually on Ubuntu/Debian
        if ! command_exists fzf; then
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install --all
        fi
        
    elif command_exists yum; then
        sudo yum update -y
        sudo yum install -y \
            git \
            zsh \
            tmux \
            wget \
            curl \
            python3 \
            python3-pip \
            nodejs \
            npm \
            redis \
            postgresql \
            postgresql-contrib
            
    elif command_exists dnf; then
        sudo dnf update -y
        sudo dnf install -y \
            git \
            zsh \
            tmux \
            wget \
            curl \
            python3 \
            python3-pip \
            nodejs \
            npm \
            redis \
            postgresql \
            postgresql-contrib
    else
        log_warning "No supported package manager found. Please install dependencies manually."
    fi
}

# Setup shell configurations
setup_shell_configs() {
    log_info "Setting up shell configurations..."
    
    local configs_dir="$(pwd)"
    local config_files=(".zshrc" ".emacs" ".irbrc" ".gitconfig" "functions.el" ".bash_completion" ".gemrc" ".ripgreprc" ".bashrc" ".bash_aliases" ".inputrc" ".screenrc" ".sqliterc")
    
    for file in "${config_files[@]}"; do
        if [[ -f "${configs_dir}/${file}" ]]; then
            log_info "Linking $file..."
            ln -sf "${configs_dir}/${file}" ~/"${file}"
        fi
    done
    
    # Handle DefaultKeyBinding.dict for macOS
    if [[ $(detect_os) == "macos" && -f "${configs_dir}/DefaultKeyBinding.dict" ]]; then
        mkdir -p ~/Library/KeyBindings
        ln -sf "${configs_dir}/DefaultKeyBinding.dict" ~/Library/KeyBindings/DefaultKeyBinding.dict
    fi
    
    # Set zsh as default shell if not already
    if command_exists zsh && [[ "$SHELL" != */zsh ]]; then
        log_info "Setting zsh as default shell..."
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
        chsh -s "$(which zsh)"
    fi
}

# Setup development services
setup_services() {
    log_info "Setting up development services..."
    
    # Redis
    if command_exists redis-server; then
        log_info "Starting Redis..."
        case $(detect_os) in
            "macos")
                brew services start redis || log_warning "Failed to start Redis"
                ;;
            "linux")
                if systemctl is-active --quiet redis; then
                    log_info "Redis is already running"
                else
                    sudo systemctl enable redis
                    sudo systemctl start redis || log_warning "Failed to start Redis"
                fi
                ;;
        esac
    fi
    
    # PostgreSQL
    if command_exists postgres || command_exists psql; then
        log_info "Setting up PostgreSQL..."
        case $(detect_os) in
            "macos")
                brew services start postgresql || log_warning "Failed to start PostgreSQL"
                ;;
            "linux")
                if systemctl is-active --quiet postgresql; then
                    log_info "PostgreSQL is already running"
                else
                    sudo systemctl enable postgresql
                    sudo systemctl start postgresql || log_warning "Failed to start PostgreSQL"
                fi
                ;;
        esac
        
        # Create development database if it doesn't exist
        if command_exists createdb; then
            createdb development 2>/dev/null || log_info "Development database already exists or couldn't be created"
        fi
    fi
}

# Setup Node.js environment
setup_node_environment() {
    log_info "Setting up Node.js environment..."
    
    # Install global npm packages commonly used in development
    if command_exists npm; then
        local global_packages=(
            "yarn"
            "nodemon"
            "pm2"
            "@nestjs/cli"
            "create-react-app"
            "typescript"
            "ts-node"
        )
        
        for package in "${global_packages[@]}"; do
            if ! npm list -g "$package" &>/dev/null; then
                log_info "Installing global package: $package"
                npm install -g "$package" || log_warning "Failed to install $package"
            fi
        done
    fi
}

# Setup Python environment
setup_python_environment() {
    log_info "Setting up Python environment..."
    
    if command_exists pyenv; then
        # Install latest stable Python version
        local python_version="3.11.5"
        if ! pyenv versions | grep -q "$python_version"; then
            log_info "Installing Python $python_version via pyenv..."
            pyenv install "$python_version" || log_warning "Failed to install Python $python_version"
            pyenv global "$python_version"
        fi
    fi
    
    # Install common Python packages
    if command_exists pip3; then
        local python_packages=(
            "virtualenv"
            "pipenv"
            "black"
            "flake8"
            "pytest"
            "requests"
            "flask"
            "django"
        )
        
        for package in "${python_packages[@]}"; do
            pip3 install "$package" || log_warning "Failed to install Python package: $package"
        done
    fi
}

# Initialize database schemas (if any exist)
initialize_schemas() {
    log_info "Checking for database schema files..."
    
    # Look for SQL files in common locations
    local schema_files=(
        "schema.sql"
        "db/schema.sql"
        "database/schema.sql"
        "migrations/*.sql"
    )
    
    for pattern in "${schema_files[@]}"; do
        if ls $pattern 1>/dev/null 2>&1; then
            log_info "Found schema files matching: $pattern"
            if command_exists psql; then
                log_info "Run the following to initialize your database:"
                echo "psql -d development -f <schema_file>"
            fi
        fi
    done
}

# Run any local setup script
run_local_setup() {
    if [[ -f "setup-local.sh" ]]; then
        log_info "Running local setup script..."
        source setup-local.sh
    fi
}

# Main setup function
main() {
    log_info "Starting Niteshift development environment setup..."
    log_info "Working directory: $(pwd)"
    
    # Ensure we're in the right directory
    if [[ ! -f ".zshrc" ]] || [[ ! -f ".gitconfig" ]] || [[ ! -f "Brewfile" ]]; then
        log_error "This doesn't appear to be the config-files repository root."
        log_error "Please run this script from the repository root directory."
        log_error "Required files: .zshrc, .gitconfig, Brewfile"
        exit 1
    fi
    
    # Run setup steps
    install_dependencies
    setup_shell_configs
    setup_services
    setup_node_environment
    setup_python_environment
    initialize_schemas
    run_local_setup
    
    log_success "Niteshift development environment setup complete!"
    log_info "Please restart your terminal or run 'source ~/.zshrc' to load the new configuration."
    log_info ""
    log_info "Services started:"
    log_info "  - Redis (if installed)"
    log_info "  - PostgreSQL (if installed)"
    log_info ""
    log_info "To customize this setup for your local environment, create a 'setup-local.sh' file."
}

# Run main function
main "$@"