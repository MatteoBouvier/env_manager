PREFIX = /usr

all:
	@echo Run \'make install\' to install pyenv

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p pyenv $(DESTDIR)$(PREFIX)/bin/pyenv
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/pyenv

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/pyenv

