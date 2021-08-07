provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
    assume_role {
    role_arn     = "arn:aws:iam::667481606687:role/programatic-access"
  }
}
