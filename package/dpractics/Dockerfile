FROM python:3.12-slim

WORKDIR /app/

RUN apt-get update --allow-insecure-repositories
RUN apt-get install -y build-essential gcc libc6-dev wget git
RUN apt-get update && apt-get install -y procps
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing libpq-dev musl-dev unzip libaio-dev


RUN pip install poetry
COPY ./package/pyproject.toml ./
RUN poetry install
RUN poetry update