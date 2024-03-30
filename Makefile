.PHONY: help all deploy clear-cache test test-extra
SITENAME = right2organize.org

help:
	@echo  'Targets:'
	@echo  '  * all [deploy test]'
	@echo  '  * clear-cache - Deprecated'
	@echo  '  * test-extra - check with non managed dependencies (checkmake shellcheck)'

all: deploy test

deploy:
	./scripts/deploy.sh $(SITENAME)

clear-cache:
	./scripts/clear-cache.sh $(SITENAME)

test:
	linkchecker --check-extern https://$(SITENAME)

test-extra:
	shellcheck scripts/*.sh
	checkmake Makefile
