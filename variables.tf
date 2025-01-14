variable "rgname" {
  default = "python-flask-app"
}

variable "rglocation" {
  default = "east us"
}

variable "log_analytics_name" {
  default = "python-flask-app-log-analytics"
}

variable "container_app_environment_name" {
  default = "python-flask-app-encironment-name"
}

variable "container_app" {
  default = "python-flash-container-app"
}

variable "container" {
  default = {
    name:"python-flask-container"
    image:"docker.io/tejbahadur/flask-app:v1"
    cpu: 0.25
    memory: "0.5Gi"
  }
}