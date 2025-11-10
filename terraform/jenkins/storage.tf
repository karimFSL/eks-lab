# create S3 Bucket
resource "aws_s3_bucket" "jenkins_artifacts" {

  bucket = "jenkins-artifacts-${random_id.randomness.hex}"

  tags = {
    Application = "Jenkins"
  }
}

# Create random number for s3 bucket name
resource "random_id" "randomness" {
  byte_length = 10
}