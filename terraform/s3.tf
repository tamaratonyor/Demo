resource "aws_s3_bucket" "raw_bucket" {
    bucket = "raw-bucket-kubra-demo" 
    acl = "private"   
}

resource "aws_s3_bucket" "silver_bucket" {
    bucket = "silver-bucket-kubra-demo" 
    acl = "private"   
}

resource "aws_s3_bucket" "gold_bucket" {
    bucket = "gold-bucket-kubra-demo" 
    acl = "private"   
}

resource "aws_s3_bucket" "output_bucket" {
    bucket = "output-bucket-kubra-demo" 
    acl = "private"   
}