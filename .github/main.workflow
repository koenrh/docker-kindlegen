workflow "Build and push" {
  on = "push"
  resolves = [
    "Login to Docker Hub",
    "Push image to Docker Hub",
  ]
}

action "Build image" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t kindlegen ."
}

action "Tag and push branch filter" {
  uses = "actions/bin/filter@b2bea07"
  args = "branch master"
  needs = ["Build image"]
}

action "Login to Docker Hub" {
  uses = "actions/docker/login@76ff57a"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Tag image" {
  uses = "actions/docker/tag@76ff57a"
  args = "kindlegen koenrh/kindlegen"
  needs = [
    "Login to Docker Hub",
    "Tag and push branch filter",
  ]
}

action "Push image to Docker Hub" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Tag image"]
  args = "push koenrh/kindlegen"
  secrets = ["DOCKER_PASSWORD", "DOCKER_USERNAME"]
}
