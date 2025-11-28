# create S3 Bucket
resource "aws_s3_bucket" "artifactory_artifacts" {

  bucket = "artifactory-artifacts-${random_id.randomness.hex}"

  tags = {
    Application = "Artifactory"
  }
}

# Create random number for s3 bucket name
resource "random_id" "randomness" {
  byte_length = 10
}