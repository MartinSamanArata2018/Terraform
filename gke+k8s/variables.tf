variable "prefix" {
  description = "Prefijo de los recursos"
  default     = "ms"
}

variable "location_gke" {
  description = "Region para aprovisionar los recursos en GKE"
  default     = "Brazil South"
}

variable "numero_nodos" {
  description = "Número de nodos"
  default     = 1
}

variable "machine_type_gke" {
  description = "Tipo de vm para los nodos en GKE"
  default     = "n1-standard-1"
}
