.PHONY: all
all: build install refresh publish clean

.PHONY: build
build: ## Build the meta-package
	PKGEXT='.pkg.tar.zst' makepkg -sf

.PHONY: install
install: ## Install the meta-package
	SNAP_PAC_SKIP=true sudo -E pacman --noconfirm -U paks-base-*.pkg.tar.zst

.PHONY: refresh
refresh: ## Refresh the backup lists
	backup-packages
	if [ -s unknown.list ]; then \
		xargs -a unknown.list sudo -E pacman -D --asdeps; \
	fi
	backup-packages

.PHONY: publish
publish: ## Publish the meta-package in the local repo
	for type in base core desktop media-center hw-ettal; do \
		pkg=paks-$$type-*.pkg.tar.zst; \
		gpg --detach-sign --yes $$pkg; \
		repo-add -s /var/cache/pacman/paks/paks.db.tar $$pkg; \
		cp $$pkg* /var/cache/pacman/paks/; \
	done

.PHONY: aurs
aurs: ## Publish the meta-package in the local repo
	for pkg in aurs/*.zst; do \
		echo $$pkg; \
		# gpg --detach-sign --yes $$pkg; \
		repo-add -s /var/cache/pacman/paks/paks.db.tar $$pkg; \
		cp $$pkg* /var/cache/pacman/paks/; \
	done

.PHONY: clean
clean: ## Cleanup
	rm -rf pkg src *.pkg.tar* *.log

.PHONY: help
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

