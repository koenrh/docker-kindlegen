FROM alpine:3.9.3@sha256:97e225314fd094c1e16209c4f0ad8103af20a57d45153e5bcfa04f3a2dc50099
LABEL maintainer "Koen Rouwhorst <info@koenrouwhorst.nl>"

# NOTE: https://www.amazon.com/gp/feature.html?docId=1000765211
ENV KINDLEGEN_VERSION="2.9"
ENV KINDLEGEN_CHECKSUM="9828db5a2c8970d487ada2caa91a3b6403210d5d183a7e3849b1b206ff042296"

RUN apk add --no-cache \
  ca-certificates=~20190108 \
  curl=~7 \
  tar=~1

ENV HOME /home/kindlegen
RUN adduser -u 1001 -D kindlegen \
  && chown -R kindlegen:kindlegen $HOME

WORKDIR /tmp

RUN curl "https://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v${KINDLEGEN_VERSION/\./_}.tar.gz" \
  -o "kindlegen-$KINDLEGEN_VERSION.tar.gz" \
  && echo "$KINDLEGEN_CHECKSUM  kindlegen-$KINDLEGEN_VERSION.tar.gz" | sha256sum -c - \
  && mkdir -p /app \
  && tar -xzf "kindlegen-$KINDLEGEN_VERSION.tar.gz" -C /app \
  && rm "kindlegen-$KINDLEGEN_VERSION.tar.gz"

WORKDIR /app
USER kindlegen

# NOTE: https://kindlegen.s3.amazonaws.com/Readme.txt
ENTRYPOINT ["/app/kindlegen"]
