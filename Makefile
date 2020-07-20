NAME = timefier
CC = gcc
LIBNOTIFY_L = $(shell pkg-config --libs libnotify)
LIBNOTIFY_C = $(shell pkg-config --cflags libnotify)
CFLAGS = -Wall -Wextra -pedantic -std=c99

$(NAME): $(NAME).o
	$(CC) $(CFLAGS) $(LIBNOTIFY_L) $(LIBNOTIFY_C) $< -o $@

$(NAME).o: $(NAME).c
	$(CC) $(CFLAGS) $(LIBNOTIFY_L) $(LIBNOTIFY_C) $< -o $@ -c

