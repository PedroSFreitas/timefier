## Timefier

A super simple timer with desktop notification written in C, using libnotify.

## Reason

1. To refresh and code something in C; and,
2. I constantly need to write some around `notify-send` to remember I have my
water heating up to brew a coffee, so I thought it was about time to code a
simple and quick application for it.

## Usage

```
-t | -title   : Title for the notification.
-m | -message : Message (body) off the notification.
-d | -delay   : Seconds to fire the notification.

Example:

timefier -t 'Coffeeeeeee!' -m 'Water should be ready now, darling' -d 120
```

## Build

```
make
```

## Dependencies

`libnotify`

