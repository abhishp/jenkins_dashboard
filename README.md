# Build Window

[![Build Status](https://travis-ci.org/rouanw/build-window.svg?branch=master)](https://travis-ci.org/rouanw/build-window)

Dashboard built using [Dashing](http://shopify.github.com/dashing). Currently supports Jenkins, Travis, TeamCity, Bamboo and Go.

## Example

![Alt text](http://rouanw.github.io/images/build_health_screenshot.png "Example build dashboard")

## Getting started

Run `bundle install`.

Edit `config/jenkins.yml` with the configuration for your builds:

```
jenkins:
  baseURL: http://jenkins-url
  username: username
  password: password
  project: project

```

Place your API credentials in a `.env` file at the root of the project. (Please note that authentication is currently only supported for Go CD.) Example:

```
GO_USER=view
GO_PASSWORD=password
```

Run `dashing start`.

Runs at `http://localhost:3030/builds` by default.

Run `dashing start -d -p 3031` to run it as a daemon and to specify the port. You can stop the daemon with `dashing stop`.

See https://github.com/Shopify/dashing/wiki for more details.

## Docker support

You can spin up a Docker container with build-window by running:

`docker-compose up -d`

The application will be ready at `http://localhost:3030` (Linux) or at `http://<DOCKER_HOST_IP>:3030` (Windows/OS X).

You can also build the image and run a container separately, but [Docker Compose](https://docs.docker.com/compose/install/) makes this process much simpler.

## Contributing

Pull requests welcome. Run the tests with `rspec`.

## Contributions

Thanks to Max Lincoln ([@maxlinc](https://github.com/maxlinc)) for coming up with the name __Build Window__.
