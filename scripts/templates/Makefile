NAME		:= PROJECT_NAME
OBJFILES	:= src/PROJECT_NAME.o 
CFLAGS		:= -Wall -g
CC			:= clang

$(NAME): $(OBJFILES)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

run: $(NAME)
	./$(NAME)

clean:
	rm -f $(NAME) $(OBJFILES)
