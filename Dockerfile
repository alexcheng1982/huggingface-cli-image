FROM python:3.12-alpine AS build

WORKDIR /app

RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    musl-dev \
    linux-headers \
    gfortran \
    bash

COPY requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

FROM python:3.12-alpine

WORKDIR /app

COPY --from=build /install /usr/local

COPY . .

CMD ["hf"]
