workflow "Build all branches" {
  on = "push"
  resolves = [
    "Build"
  ]
}

action "Build" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t koenrh/kindlegen ."
}
