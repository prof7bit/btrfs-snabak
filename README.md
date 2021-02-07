# btrfs-snabak

daemon and commandline tool to perform snapshots and optioally back them up to an external disk, using incremental btrfs send and recveive.

# This is unfinished and incomplete!
this is currently less than alpha, completely unfinished, totally incomplete and not in working order because most of it is still missing, please do not use it as long as this warning is not removed.

# How it is supposed to work
Quite similar to snapper there will be a daemon started through systemd and running as root that does the actual work and a command line tool that can be used by unprivileged users. The communication between these two components will use a unix domain socket, so there is no need to have dbus or other sophisticated ipc framework installed.

For each subvolume there will be a configuration file that specifies when to take the snapshots, where the snapshots should be placed, how to clean up and optionally the configuration for backups on an external disk or server. The external backups will be incremental and very fast because it will use btrfs send/receive. The configuration will also specify which users or groups will be allowed to use the command line tool on a per subvolume basis.
