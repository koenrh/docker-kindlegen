FROM alpine:3.12.3@sha256:074d3636ebda6dd446d0d00304c4454f468237fdacf08fb0eeac90bdbfa1bac7
LABEL maintainer "Koen Rouwhorst <info@koenrouwhorst.nl>"

# NOTE: Amazon killed KindleGen https://www.amazon.com/gp/feature.html?docId=1000765211
ENV KINDLEGEN_VERSION="2.9"
ENV KINDLEGEN_CHECKSUM="9828db5a2c8970d487ada2caa91a3b6403210d5d183a7e3849b1b206ff042296"

RUN apk add --no-cache ca-certificates curl tar

ENV HOME /home/kindlegen
RUN adduser -u 1001 -D kindlegen \
  && chown -R kindlegen:kindlegen $HOME

WORKDIR /tmp

RUN curl "https://raw.githubusercontent.com/koenrh/docker-kindlegen/master/kindlegen/kindlegen_linux_2.6_i386_v${KINDLEGEN_VERSION/\./_}.tar.gz" \
  -o "kindlegen-$KINDLEGEN_VERSION.tar.gz" \
  && echo "$KINDLEGEN_CHECKSUM  kindlegen-$KINDLEGEN_VERSION.tar.gz" | sha256sum -c - \
  && mkdir -p /app \
  && tar -xzf "kindlegen-$KINDLEGEN_VERSION.tar.gz" -C /app \
  && rm "kindlegen-$KINDLEGEN_VERSION.tar.gz"

WORKDIR "$HOME"
USER kindlegen

# NOTE: https://kindlegen.s3.amazonaws.com/Readme.txt
ENTRYPOINT ["/app/kindlegen"]
