NAME = timefier
CC = gcc
LIBNOTIFY_L = $(shell pkg-config --libs libnotify)
LIBNOTIFY_C = $(shell pkg-config --cflags libnotify)
CFLAGS = -Wall -Wextra -pedantic -std=c99
INSTALLDIR = /usr/bin

build: $(NAME)

clean:
	@rm -v $(NAME)

install: build
	cp -vf $(NAME) $(INSTALLDIR)/$(NAME)

uninstall:
	@rm -v $(INSTALLDIR)/$(NAME)

$(NAME): $(NAME).o
	$(CC) $(CFLAGS) $(LIBNOTIFY_L) $(LIBNOTIFY_C) $< -o $@

$(NAME).o: $(NAME).c
	$(CC) $(CFLAGS) $(LIBNOTIFY_L) $(LIBNOTIFY_C) $< -o $@ -c

.PHONY: build clean install uninstall
