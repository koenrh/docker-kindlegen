# KindleGen

Amazon's [KindleGen](https://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211)
dockerized.

## Usage

```bash
docker run -it --rm \
  --volume "$PWD:/home/kindlegen" \
  koenrh/kindlegen \
  /home/kindlegen/helpfulhackers.epub
```

You could make this command more easily accessible by putting it an executable,
and make sure that it is available in your `$PATH`. Alternative, you could create
wrapper functions for your `docker run` commands ([example](https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc)).
