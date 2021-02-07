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
	systemctl daemon-reload
