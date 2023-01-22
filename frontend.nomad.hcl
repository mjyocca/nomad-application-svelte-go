job "frontend" {
	datacenters = ["dc1"]

	group "frontend" {
		count = 2

		service {
			provider = "nomad"
			name = "frontend-app"
			port = "http"
		}

		network {
			port "http" {
				to = 3000
			}
		}

		task "sveltekit" {
			driver = "docker"

			config {
				image = "mjyocca/sveltekit-nomad:v1"
				ports = ["http"]
			}

			resources {
        cpu    = 500 # MHz
        memory = 128 # MB
      }
		}
	}
}