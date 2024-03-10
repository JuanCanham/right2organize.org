.PHONY: help all install test deploy clear-cache deploy-infra test-site test-extra
SITENAME = right2organize.org

help:
	@echo  'Targets:'
	@echo  '  * all [deploy clear-cache test-site]'
	@echo  '  * deploy [test deploy-infra sync]'
	@echo  '  * test-extra - check with non managed dependencies (checkmake shellcheck)'

all: deploy clear-cache test-site

test:
	./scripts/spellcheck.sh

test-extra:
	shellcheck scripts/*.sh
	checkmake Makefile

deploy: test deploy-infra sync

deploy-infra:
	./scripts/deploy.sh $(SITENAME)

sync:
	./scripts/sync.sh $(SITENAME)

clear-cache:
	./scripts/clear-cache.sh $(SITENAME)

test-site:
	linkchecker --check-extern https://$(SITENAME)
