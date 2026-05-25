variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "actions" {
  type = list(string)
}

variable "resources" {
  type = list(string)
}