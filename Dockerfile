FROM alpine:edge

RUN apk add --no-cache \
  ca-certificates \
  curl \
  tar

# NOTE: https://www.amazon.com/gp/feature.html?docId=1000765211
RUN curl "https://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz" \
  -o /tmp/kg.tar.gz \
  && mkdir -p /usr/src/kg \
  && tar -xzf /tmp/kg.tar.gz -C /usr/src/kg \
  && rm /tmp/kg.tar.gz* \
  && ls -la /usr/src/kg/

WORKDIR /usr/src/kg

# https://kindlegen.s3.amazonaws.com/Readme.txt
ENTRYPOINT ["/usr/src/kg/kindlegen"]