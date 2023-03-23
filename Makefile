ifeq ($(ALIAS_PATH),)
	ALIAS_PATH := $(HOME)/.zshrc
endif

STR_ALIAS = 'alias pyenv=". ~/bin/pyenv"'

ALIAS_EXISTS = $(shell grep $(STR_ALIAS) $(ALIAS_PATH) | wc -l)

.SILENT: install

all:
	@echo Run \'make install\' to install pyenv

install:
	@mkdir -p ~/bin
	@cp -p pyenv ~/bin/pyenv
	@chmod 755 ~/bin/pyenv

ifeq ($(ALIAS_EXISTS),0)
	@printf "# >>>>>> PYENV ALIASES\n" | tee -a $(ALIAS_PATH)
	@printf "%s\n" $(STR_ALIAS) | tee -a $(ALIAS_PATH)
ifeq ($(ALIASES),true)
	@printf "alias cenv='. ~/bin/pyenv -c'\n" | tee -a $(ALIAS_PATH)
	@printf "alias senv='. ~/bin/pyenv -s'\n" | tee -a $(ALIAS_PATH)
	@printf "alias denv='. ~/bin/pyenv -d'\n" | tee -a $(ALIAS_PATH)
	@printf "alias renv='. ~/bin/pyenv -r'\n" | tee -a $(ALIAS_PATH)
endif
	@printf "# <<<<<< PYENV END\n" | tee -a $(ALIAS_PATH)
endif

uninstall:
	@rm -rf ~/bin/pyenv
	@sed -i '/# >>>>>> PYENV ALIASES/d' $(ALIAS_PATH)
	@sed -i '/alias pyenv=". ~\/bin\/pyenv"/d' $(ALIAS_PATH)
	@sed -i "/alias cenv='. ~\/bin\/pyenv -c'/d" $(ALIAS_PATH)
	@sed -i "/alias senv='. ~\/bin\/pyenv -s'/d" $(ALIAS_PATH)
	@sed -i "/alias denv='. ~\/bin\/pyenv -d'/d" $(ALIAS_PATH)
	@sed -i "/alias renv='. ~\/bin\/pyenv -r'/d" $(ALIAS_PATH)
	@sed -i '/# <<<<<< PYENV END/d' $(ALIAS_PATH)
