FROM ubuntu:noble
WORKDIR /app
COPY ./autoreplyer.py  /app
COPY ./script.py  /app
RUN mkdir /app/db

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get dist-upgrade -yq \
    && apt-get install -yq python3 python3-pip python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV VENV="/opt/venv"
ENV PATH="$VENV/bin:$PATH"
RUN python3 -m venv --system-site-packages "$VENV" \
    && . "$VENV/bin/activate" \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir emails \
    && deactivate

CMD ["python3", "-u", "/app/script.py"]
