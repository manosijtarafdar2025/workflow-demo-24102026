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
variable "github_owner" {
  description = "GitHub username or organization that owns the repository"
  type        = string
  default     = "manosijtarafdar2025"
}

variable "github_repository" {
  description = "GitHub repository name, without the owner"
  type        = string
  default     = "workflow-demo-24102026"
}

variable "github_branch" {
  description = "Branch allowed to push images to ECR"
  type        = string
  default     = "master"
}

# GitHub repository IDs are needed for repositories using
# GitHub's immutable OIDC subject format.
variable "github_owner_id" {
  description = "GitHub owner ID; leave empty for the traditional subject format"
  type        = string
  default     = "291530542"
}

variable "github_repository_id" {
  description = "GitHub repository ID; leave empty for the traditional subject format"
  type        = string
  default     = "1431887997"
}
