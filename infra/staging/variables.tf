variable "tags" {
  type = map(string)
  default = {
    Project     = "ec2-stop-lambda"
    Environment = "stg"
    Terraform   = "true"
  }
}
variable "region" {
  type    = string
  default = "ap-northeast-1"
}
variable "vpc_cidr" {
  type        = string
  description = "Main VPC CidrBlock"
}
variable "private_subnets" {
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
  description = "Private Subnets"
}
variable "key_pair_name" {
  type        = string
  description = "EC2で利用するキーペア(Terraformで直接秘密情報を扱わない)"
}
variable "vpc_endpoint" {
  # TODO: 型を丁寧に書く
  type        = map(any)
  description = "vpc_endpoint_setting"
}
