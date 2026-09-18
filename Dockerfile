FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jre-headless \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

WORKDIR /app
COPY . .

WORKDIR /app/samples/agent/adk/restaurant_finder
RUN uv sync --frozen --no-dev

CMD ["sh", "-c", "uv run . --host 0.0.0.0 --port ${PORT:-10000}"]
