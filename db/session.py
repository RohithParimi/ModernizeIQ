# db/session.py
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session

# Default points at the docker-compose Postgres on port 5433.
# Override via env var for CI or other environments.
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+psycopg2://postgres:postgres@localhost:5433/mydb",
)

# The engine is the connection pool. One per process. Created at import time.
engine = create_engine(DATABASE_URL, echo=False, future=True)

# SessionLocal is a factory. Call it to get a new session for a unit of work.
SessionLocal = sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False,
    expire_on_commit=False,
)