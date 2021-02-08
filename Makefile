PREFIX ?= /usr/local
SYSTEMD = /lib/systemd/system

.PHONY: all
all:
	@echo "nothing to build, just run make install as root"


.PHONY: clean
clean:
	@echo "nothing to clean"


.PHONY: install
install:
	install -m 755 src/btrfs-snabakd $(PREFIX)/bin/
	install -m 755 src/btrfs-snabak $(PREFIX)/bin/
	install -m 644 system-files/btrfs-snabak-completion.sh /etc/bash_completion.d/
	install -m 755 -d /etc/btrfs-snabak/configs
	PREFIX=$(PREFIX) envsubst < system-files/btrfs-snabak.service > $(SYSTEMD)/btrfs-snabak.service
	systemctl daemon-reload
	systemctl enable btrfs-snabak.service
	systemctl start btrfs-snabak.service


.PHONY: uninstall
uninstall:
	systemctl stop btrfs-snabak.service || true
	systemctl disable btrfs-snabak.service || true
	rm -f $(SYSTEMD)/btrfs-snabak.service
	rm -f $(PREFIX)/bin/btrfs-snabakd
	rm -f $(PREFIX)/bin/btrfs-snabak
	rm -f /etc/bash_completion.d/btrfs-snabak-completion.sh
	systemctl daemon-reload
