.PHONY: all
# all: build install refresh publish clean
all: clean build publish clean

.PHONY: build
build: ## Build the meta-package
	PKGDEST=$(CURDIR) PKGEXT='.pkg.tar.zst' makepkg -sf

.PHONY: install
install: ## Install the meta-package
	SNAP_PAC_SKIP=true sudo -E pacman --noconfirm -U paks-sys-base-*.pkg.tar.zst

.PHONY: refresh
refresh: ## Refresh the backup lists
	backup-packages
	if [ -s unknown.list ]; then \
		xargs -a unknown.list sudo -E pacman -D --asdeps; \
	fi
	backup-packages

.PHONY: publish
publish: ## Publish the meta-package in the local repo
	for pkg in paks-*.pkg.tar.zst; do \
		gpg --detach-sign --yes $$pkg || exit 1; \
	done
	repo-add -s /var/cache/pacman/paks/paks.db.tar paks-*.pkg.tar.zst
	cp paks-*.pkg.tar.zst* /var/cache/pacman/paks/
	rsync -avh /var/cache/pacman/paks/. srv:/var/www/html/paks --delete

# .PHONY: aurs
# aurs: ## Publish the meta-package in the local repo
# 	for pkg in aurs/*.zst; do \
# 		# echo $$pkg; \
# 		# gpg --detach-sign --yes $$pkg; \
# 		repo-add -s /var/cache/pacman/paks/paks.db.tar $$pkg; \
# 		cp $$pkg* /var/cache/pacman/paks/; \
# 	done

.PHONY: clean
clean: ## Cleanup
	rm -rf pkg src *.pkg.tar* *.log

.PHONY: help
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

