# KindleGen

Amazon's [KindleGen](https://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211)
dockerized.

## Usage

You could run KindleGen in a container by executing the following `docker` command.

```bash
docker run -it --rm \
  --volume "$PWD:/home/kindlegen" \
  koenrh/kindlegen \
  /home/kindlegen/modern-vim.epub
```

You could make this command more easily accessible by putting it in an executable,
and make sure that it is available in your `$PATH`. Alternatively, you could create
wrapper functions for your `docker run` commands ([example](https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc)).

```bash
kindlegen() {
  docker run -it --rm \
    --volume "$PWD:/home/kindlegen" \
    --name kindlegen \
    koenrh/kindlegen "$@"
}
```
