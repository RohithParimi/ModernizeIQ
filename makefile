.PHONY: up down psql seed wipe-seed test eval

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
eval:
	uv run python scripts/run_eval.py
