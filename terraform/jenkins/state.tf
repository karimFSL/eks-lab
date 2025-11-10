terraform {
  backend "s3" {
    bucket = "fk-terraform-test"
    key    = "states/jennkins/terraform.state"
    region = "eu-west-3"
    # remote backend locking to prevent concurrent modifications
    //    dynamodb_table = "terraform-lock-table"
  }
}