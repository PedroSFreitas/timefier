#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <errno.h>
#include <time.h>
#include <libnotify/notify.h>

int main(int argc, char *argv[])
{
    NotifyNotification *nt;
    unsigned int ch;

    struct {
        char *title;
        char *message;
        unsigned long delay;
    } args;

    char *appname = argv[0];

    struct option longopts[] = {
        {"title", required_argument, NULL, 't'},
        {"message", required_argument, NULL, 'm'},
        {"delay", required_argument, NULL, 'd'},
        {NULL, 0, NULL, 0}
    };

    while ((ch = getopt_long(argc, argv, "t:m:d:", longopts, NULL)) != -1) {
        char *n;

        switch (ch) {
        case 't':
            args.title = optarg;
            break;
        case 'm':
            args.message = optarg;
            break;
        case 'd':
            args.delay = strtoul(optarg, &n, 10);
            if (errno == ERANGE) {
                fprintf(stderr, "Out of range at %d.\n", __LINE__);
                return 1;
            }
            break;
        }
    }

    if (!notify_init(appname)) {
        fprintf(stderr, "Couldn't create notify_init at %d\n.", __LINE__);
        return 1;
    }

    if (!(nt = notify_notification_new(args.title, args.message, NULL))) {
        fprintf(stderr, "Couldn't create notify_notification at %d\n.", __LINE__);
        return 1;
    }

    notify_notification_set_urgency(nt, NOTIFY_URGENCY_CRITICAL);

    if (fork() == 0) {
        sleep(args.delay);
        notify_notification_show(nt, NULL);
    }

    notify_uninit();
    return 0;
}
