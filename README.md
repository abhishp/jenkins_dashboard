# Jenkins Dashboard

Jenkins CI Build Dashboard built using [Dashing](http://shopify.github.com/dashing).

## Example

![Alt text](http://rouanw.github.io/images/build_health_screenshot.png "Example build dashboard")

## Getting started

Run `bundle install`.

Edit `config/jenkins.yml` with the configuration for your jenkins server:

```
jenkins:
  baseURL: http://jenkins-url
  username: username
  password: password
  project: project

```

Edit `config/builds.yml` with the configuration for your builds:

```
builds:
  build_name:
    id: <build_id_on_jenkins>
    server: Jenkins
    size: #widget size for this build
      horizontal: <columns>
      vertical: <rows>

```

Run `dashing start`.

Runs at `http://localhost:3030/builds` by default.

Run `dashing start -d -p 3031` to run it as a daemon and to specify the port. You can stop the daemon with `dashing stop`.

See https://github.com/Shopify/dashing/wiki for more details.

## Docker support

You can spin up a Docker container with jenkins-dashboard by running:

`docker-compose up -d`

The application will be ready at `http://localhost:3030` (Linux) or at `http://<DOCKER_HOST_IP>:3030` (Windows/OS X).

You can also build the image and run a container separately, but [Docker Compose](https://docs.docker.com/compose/install/) makes this process much simpler.

## Contributing

Pull requests welcome. Run the tests with `rspec`.