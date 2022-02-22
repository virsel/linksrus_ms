.PHONY: dockerize push dockerize-and-push update

IMAGE = postgres
SHA = $(shell git rev-parse --short HEAD)
PREFIX = virsel/
NS = linksrus-data
PGUSER = postgres
DBNAME = linkgraph

dockerize-and-push: dockerize push

dockerize:
	@echo "[docker build] building ${IMAGE} (tags: ${PREFIX}${IMAGE}:latest, ${PREFIX}${IMAGE}:${SHA})"
	@docker build --file ./Dockerfile \
		--tag ${PREFIX}${IMAGE}:latest \
		--tag ${PREFIX}${IMAGE}:${SHA} \
		../

push:
	@echo "[docker push] pushing ${PREFIX}${IMAGE}:latest"
	@docker push ${PREFIX}${IMAGE}:latest 2>&1
	@echo "[docker push] pushing ${PREFIX}${IMAGE}:${SHA}"
	@docker push ${PREFIX}${IMAGE}:${SHA} 2>&1


# make db updates
ifeq ($(OS),Windows_NT)
    UPDATE_COUNT=$(shell dir .\made_updates /b | find "sql" /c)
else
    UPDATE_COUNT=$(shell ls -l ./made_updates | wc -l)
endif
update:
	@echo "${UPDATE_COUNT}"
	$(eval SQL_CMD=$(shell cat ./update/*))
	@echo ${SQL_CMD} > ./made_updates/${UPDATE_COUNT}_migrations.sql
	@kubectl exec -n ${NS} postgres-postgresql-0 -- psql -U ${PGUSER} -d ${DBNAME} -n ${NS} -c "${SQL_CMD}" -w
#@rm -rf ./update/*
