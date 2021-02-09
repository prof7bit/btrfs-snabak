
.PHONY: all
all:
	@echo "nothing to build, just run make install as root"


.PHONY: clean
clean:
	@echo "nothing to clean"


.PHONY: install
install:
	install -m 755 src/btrfs-snabakd /usr/bin/
	install -m 755 src/btrfs-snabak /usr/bin/
	install -m 644 system-files/btrfs-snabak-completion.sh /etc/bash_completion.d/
	install -m 755 -d /etc/btrfs-snabak/configs
	rm -rf src/snabak_modules/__pycache__
	cp -r  src/snabak_modules /usr/lib/python3/dist-packages/
	install -m 644 system-files/btrfs-snabak.service /lib/systemd/system/
	systemctl daemon-reload
	systemctl enable btrfs-snabak.service
	systemctl start btrfs-snabak.service


.PHONY: uninstall
uninstall:
	systemctl stop btrfs-snabak.service || true
	systemctl disable btrfs-snabak.service || true
	rm -f /lib/systemd/system/btrfs-snabak.service
	rm -f /usr/bin/btrfs-snabakd
	rm -f /usr/bin/btrfs-snabak
	rm -rf /usr/lib/python3/dist-packages/snabak_modules
	rm -f /etc/bash_completion.d/btrfs-snabak-completion.sh
	systemctl daemon-reload
