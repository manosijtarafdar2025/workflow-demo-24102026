variable "ecr_repository_name" {
  description = "Name of the private ECR repository"
  type        = string
  default     = "python-app"
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten"
  type        = string
  default     = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Use MUTABLE or IMMUTABLE."
  }
}
