ERR_OK                      = 0
ERR_DAEMON                  = 1
ERR_NOT_IMPLEMENTED         = 2
ERR_USAGE                   = 3
ERR_INVALID_CONFIG_NAME     = 4
ERR_UNKNOWN_EXCEPTION       = 5
ERR_UNKNOWN_COMMAND         = 6
ERR_CONFIGURATION           = 7
ERR_PERMISSION              = 8

UNIX_SOCKET                 = "/var/run/btrfs-snabak.sock"
UNIX_SOCKET_PERMS           = 0o666

# systemd error levels
LOG_0_EMERGENCY             = 0
LOG_1_ALERT                 = 1
LOG_2_CRITICAL              = 2
LOG_3_ERROR                 = 3
LOG_4_WARNING               = 4
LOG_5_NOTICE                = 5
LOG_6_INFO                  = 6
LOG_7_DEBUG                 = 7

CONF_DIR                    = '/etc/btrfs-snabak/configs'

NULL_BYTE                   = b'\x00'
