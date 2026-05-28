.PHONY: up down psql

up:
	docker compose up -d
down:
	docker compose down
psql:
	docker exec -it pgvector_db psql -U postgres -d mydb
seed:
	uv run python scripts/generate.py
wipe-seed:
	uv run python scripts/generate.py --wipe
test:
	uv run pytest -v