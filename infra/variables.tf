variable "subnet_ids" {
  type = list(string)
}

variable "app_identification" {
  type    = string
  default = "MaintainUserData"
}

variable "dotnet_environment" {
  type = string
}

variable "function_filename" {
  type    = string
  default = "MaintainUserData.zip"
}

variable "deploy_function_bucket_name" {
  type    = string
  default = "deploy-lambda-functions-rennan765"
}

variable "terraform_deployments_bucket_name" {
  type    = string
  default = "terraform-deployments-rennan765"
}