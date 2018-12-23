workflow "Build all branches" {
  on = "push"
  resolves = [
    "Build",
    "Hadolint",
  ]
}

action "Build" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t koenrh/kindlegen ."
}

action "Hadolint" {
  uses = "actions/docker/cli@76ff57a"
  args = "run --rm --interactive hadolint/hadolint < Dockerfile"
}
