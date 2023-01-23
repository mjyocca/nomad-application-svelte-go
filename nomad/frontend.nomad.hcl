job "frontend-app" {
	datacenters = ["dc1"]

	group "frontend" {
    count = 3
    network {
      port "http" {
        to = -1
      }
    }

    service {
      name = "frontend-app"
      port = "http"
      
			check {
      	type     = "http"
        path     = "/healthcheck"
        interval = "2s"
        timeout  = "2s"
      }
    }

		task "sveltekit" {

			env {
      	PORT    = "${NOMAD_PORT_http}"
        NODE_IP = "${NOMAD_IP_http}"
      }

			driver = "docker"

			config {
				image = "mjyocca/sveltekit-nomad:latest"
				ports = ["http"]
			}

			resources {
        cpu    = 200 # MHz
        memory = 128 # MB
      }
		}
	}
}