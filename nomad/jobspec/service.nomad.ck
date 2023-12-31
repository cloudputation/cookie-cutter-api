job "{{.Service.Name}}" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${attr.unique.hostname}"
    value     = "{{.Service.Network.TargetHost}}"
  }

  type = "service"

  group "{{.Service.Group}}" {
    count = 1
    network {
      port "port" {
        static = {{.Service.Port}}
      }
    }

    task "{{.Service.Name}}-docker-deployment" {
      driver = "docker"

      config {
        image = "registry.gitlab.com/{{.Service.Repository.RepoConfig.RepositoryOwner}}/{{.Service.Name}}:latest"
        ports = ["port"]
        auth {
          username = "{{.Service.Repository.RepoConfig.RepositoryOwner}}"
          password = "{{.Service.Repository.RepoConfig.RegistryToken}}"
        }
      }

      resources {
        cpu = 200
        memory = 256
      }

      service {
        name = "${NOMAD_JOB_NAME}"
{{- $length := len .Service.Tags -}}
        tags = [
{{- range $i, $tag := .Service.Tags -}}
                "{{ $tag }}"{{ if lt $i (sub $length 1) }},{{ end }}
{{- end -}}
        ]
        port = "port"

        check {
          name     = "{{.Service.Name}} Alive"
          type     = "http"
          path     = "/health"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
