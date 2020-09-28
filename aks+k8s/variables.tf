variable "prefix" {
  description = "Prefijo de los recursos"
  default     = "ms"
}

variable "location_aks" {
  description = "Region para aprovisionar los recursos en AKS"
  default     = "Brazil South"
}

variable "numero_nodos" {
  description = "Número de nodos"
  default     = 1
}

variable "vm_size_aks" {
  description = "Tipo de vm para los nodos en AKS"
  default     = "Standard_B2s"
}


