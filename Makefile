NAME = timefier
CC = gcc

LIBNOTIFY  = $(shell pkg-config --libs libnotify)
LIBNOTIFY += $(shell pkg-config --cflags libnotify)

FLAGS  = -Wall -Wextra -pedantic -std=c99 -Wconversion -Wsign-conversion

ifndef DEBUG
FLAGS += -s -g
FLAGS += -fPIE -fstack-protector-all -D_FORTIFY_SOURCE=2
endif

INSTALLDIR = /usr/bin

build: $(NAME)

clean:
	@rm -v $(NAME)

install: build
	cp -vf $(NAME) $(INSTALLDIR)/$(NAME)

uninstall:
	@rm -v $(INSTALLDIR)/$(NAME)

$(NAME): $(NAME).o
	$(CC) $(FLAGS) $(LIBNOTIFY) $< -o $@

$(NAME).o: $(NAME).c
	$(CC) $(FLAGS) $(LIBNOTIFY) $< -o $@ -c

.PHONY: build clean install uninstall
