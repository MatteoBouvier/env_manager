ifeq ($(ALIAS_PATH),)
	ALIAS_PATH := $(HOME)/.zshrc
endif

STR_ALIAS = 'alias pyenv=". ~/bin/pyenv"'

ALIAS_EXISTS = $(shell grep $(STR_ALIAS) $(ALIAS_PATH) | wc -l)

all:
	@echo Run \'make install\' to install pyenv

install:
	@mkdir -p ~/bin
	@cp -p pyenv ~/bin/pyenv
	@cp -p gitinit ~/bin/gitinit
	@chmod 755 ~/bin/pyenv
	@chmod 755 ~/bin/gitinit

ifeq ($(ALIAS_EXISTS),0)
	@echo "# >>>>>> PYENV ALIASES" | tee -a $(ALIAS_PATH)
	@printf "%s\n" $(STR_ALIAS) | tee -a $(ALIAS_PATH)
ifeq ($(ALIASES),true)
	@echo "alias cenv='. ~/bin/pyenv -c'" | tee -a $(ALIAS_PATH)
	@echo "alias senv='. ~/bin/pyenv -s'" | tee -a $(ALIAS_PATH)
	@echo "alias denv='. ~/bin/pyenv -d'" | tee -a $(ALIAS_PATH)
	@echo "alias renv='. ~/bin/pyenv -r'" | tee -a $(ALIAS_PATH)
endif
	@echo "# <<<<<< PYENV END" | tee -a $(ALIAS_PATH)
endif

uninstall:
	@rm -rf ~/bin/pyenv
	@rm -rf ~/bin/gitinit

	@sed -i '/# >>>>>> PYENV ALIASES/d' $(ALIAS_PATH)
	@sed -i '/alias pyenv=". ~\/bin\/pyenv"/d' $(ALIAS_PATH)
	@sed -i "/alias cenv='. ~\/bin\/pyenv -c'/d" $(ALIAS_PATH)
	@sed -i "/alias senv='. ~\/bin\/pyenv -s'/d" $(ALIAS_PATH)
	@sed -i "/alias denv='. ~\/bin\/pyenv -d'/d" $(ALIAS_PATH)
	@sed -i "/alias renv='. ~\/bin\/pyenv -r'/d" $(ALIAS_PATH)
	@sed -i '/# <<<<<< PYENV END/d' $(ALIAS_PATH)
