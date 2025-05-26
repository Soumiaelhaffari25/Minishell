# Makefile for MiniShell by Soumia El Haffari

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -Werror -std=c99
DEBUG_FLAGS = -g -fsanitize=address
NAME = minishell

# Source files
SRCS = miniShell.c selp.c sel.c

# Object files
OBJS = $(SRCS:.c=.o)

# Header file
HEADER = miniShell.h

# Colors for output
GREEN = \033[0;32m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m # No Color

# Default target
all: $(NAME)

# Build the executable
$(NAME): $(OBJS)
	@echo "$(GREEN)🔗 Linking $(NAME)...$(NC)"
	@$(CC) $(CFLAGS) -o $(NAME) $(OBJS)
	@echo "$(GREEN)✅ $(NAME) compiled successfully!$(NC)"

# Compile source files to object files
%.o: %.c $(HEADER)
	@echo "$(BLUE)🔨 Compiling $<...$(NC)"
	@$(CC) $(CFLAGS) -c $< -o $@

# Debug build
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean $(NAME)
	@echo "$(GREEN)🐛 Debug build completed!$(NC)"

# Clean object files
clean:
	@echo "$(RED)🧹 Cleaning object files...$(NC)"
	@rm -f $(OBJS)

# Clean everything
fclean: clean
	@echo "$(RED)🗑️  Removing executable...$(NC)"
	@rm -f $(NAME)

# Rebuild everything
re: fclean all

# Run the shell
run: $(NAME)
	@echo "$(GREEN)🚀 Starting MiniShell...$(NC)"
	@./$(NAME)

# Install (copy to /usr/local/bin)
install: $(NAME)
	@echo "$(GREEN)📦 Installing $(NAME) to /usr/local/bin...$(NC)"
	@sudo cp $(NAME) /usr/local/bin/
	@echo "$(GREEN)✅ Installation completed!$(NC)"

# Uninstall
uninstall:
	@echo "$(RED)🗑️  Uninstalling $(NAME)...$(NC)"
	@sudo rm -f /usr/local/bin/$(NAME)
	@echo "$(RED)✅ Uninstallation completed!$(NC)"

# Help
help:
	@echo "$(BLUE)📖 Available targets:$(NC)"
	@echo "  all      - Build the minishell"
	@echo "  debug    - Build with debug flags"
	@echo "  clean    - Remove object files"
	@echo "  fclean   - Remove object files and executable"
	@echo "  re       - Clean and rebuild"
	@echo "  run      - Build and run the shell"
	@echo "  install  - Install to /usr/local/bin"
	@echo "  uninstall- Remove from /usr/local/bin"
	@echo "  help     - Show this help message"

# Declare phony targets
.PHONY: all clean fclean re debug run install uninstall help