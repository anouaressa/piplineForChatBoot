# Stage 1: Build Stage
FROM python:3.8-slim-buster AS builder

WORKDIR /python-docker

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN python -m nltk.downloader punkt

COPY . .

# Stage 2: Production Stage
FROM python:3.8-slim-buster

WORKDIR /python-docker

COPY --from=builder /python-docker /python-docker

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0" ]
