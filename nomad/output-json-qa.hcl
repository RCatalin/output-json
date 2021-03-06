job "output-json-job" {
  # Specify this job should run in the region named "us". Regions
  # are defined by the Nomad servers' configuration.
  region = "qa"

  datacenters = ["fra2"]

  # Run this job as a "service" type. Each job type has different
  # properties. See the documentation below for more examples.
  type = "service"

  # Specify this job to have rolling updates, two-at-a-time, with
  # 30 second intervals.
  update {
    max_parallel     = 1
    // min_healthy_time = "30s"
  }

  # A group defines a series of tasks that should be co-located
  # on the same client (host). All tasks within a group will be
  # placed on the same host.
  group "output-json-group" {
    # Specify the number of these tasks we want.
    count = 3

    # Create an individual task (unit of work). This particular
    # task utilizes a Docker container to front a web application.
    task "output-json-task" {
      # Specify the driver to be "docker". Nomad supports
      # multiple drivers.
      driver = "docker"

      # Configuration is specific to each driver.
      config {
        image = "delutz/output-json:latest"

        volumes = [
          "/var/nexmo/logs/${NOMAD_ALLOC_NAME}:/nexmo",
        ]
      }

      # The service block tells Nomad how to register this service
      # with Consul for service discovery and monitoring.
      // service {
      //   # This tells Consul to monitor the service on the port
      //   # labelled "http". Since Nomad allocates high dynamic port
      //   # numbers, we use labels to refer to them.
      //   port = "http"

      //   check {
      //     type     = "http"
      //     path     = "/health"
      //     interval = "10s"
      //     timeout  = "2s"
      //   }
      // }

      # It is possible to set environment variables which will be
      # available to the task when it runs.
      // env {
        // "DB_HOST" = "db01.example.com"
        // "DB_USER" = "web"
        // "DB_PASS" = "loremipsum"
      // }

      # Specify the maximum resources required to run the task,
      # include CPU, memory, and bandwidth.
      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
#           mbits = 100

          # This requests a dynamic port named "http". This will
          # be something like "46283", but we refer to it via the
          # label "http".
          port "http" {}

#           # This requests a static port on 443 on the host. This
#           # will restrict this task to running once per host, since
#           # there is only one port 443 on each host.
#           port "https" {
#              static = 443
#           }
        }
      }
    }
  }
}
