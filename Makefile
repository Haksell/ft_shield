NAME := ft_shield

PATH_SRCS := srcs
PATH_OBJS := objs

INCLUDES := ft_shield.h
SRCS := $(wildcard $(PATH_SRCS)/*.c)
OBJS := $(SRCS:$(PATH_SRCS)/%.c=$(PATH_OBJS)/%.o)

CC := cc -std=gnu17 -Wall -Wextra -Werror -g3

RESET := \033[0m
RED := \033[1m\033[31m
GREEN := \033[1m\033[32m
PURPLE := \033[1m\033[35m

define remove_target
@if [ -e "$(1)" ]; then \
	rm -rf "$(1)"; \
	echo "$(RED)[X] $(1) removed.$(RESET)"; \
fi
endef

all: $(NAME)

$(NAME): $(OBJS)
	@$(CC) $(OBJS) -o $@
	@echo "$(PURPLE)$@ is compiled.$(RESET)"

$(OBJS): $(PATH_OBJS)/%.o: $(PATH_SRCS)/%.c $(INCLUDES)
	@mkdir -p $(PATH_OBJS)
	@$(CC) -c $< -o $@
	@echo "$(GREEN)+++ $@$(RESET)"

clean:
	$(call remove_target,$(PATH_OBJS))

fclean: clean
	$(call remove_target,$(NAME))

re: fclean
	@$(MAKE) -s $(NAME)

rmvagrant: fclean
	$(RM) *VBox*.log
	vagrant destroy -f

.PHONY: all clean fclean re rmvagrant