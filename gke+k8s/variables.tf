variable "prefix" {
  description = "Prefijo de los recursos"
  default     = "ms"
}

variable "project" {
  description = "Project id"
  default     = "ci-cd-demo-275102"
}

variable "credentials" {
  default = "credentials.json"
}

variable "location_gke" {
  description = "Region para aprovisionar los recursos en GKE"
  default     = "us-east1"
}

variable "numero_nodos" {
  description = "Número de nodos"
  default     = 1
}

variable "machine_type_gke" {
  description = "Tipo de vm para los nodos en GKE"
  default     = "g1-small"
}
