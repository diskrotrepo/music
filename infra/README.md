## Infrastructure

This handles the creation of the S3 bucket, Route 53 records, Cloudfront distribution, and ACM certificate generation. This will run for a few minutes due to the time required to create a cloudfront distribution.

## Variables

You'll want to update the variables in `terraform.tfvars` to match your environemnt. This has only been tested against us-east-1, so you'll likely find it explodes in your region unless you tweak something. D-:

## Installation

**Note** Due to the order of creation you'll need to run `terraform apply` at least twice to complete the process.

This assumes you've already installed terraform and that the environment you're deploying is the `default` profile 

1. Setup terraform: `terraform init`
2. Confirm the values look good: `terraform plan`
3. Apply to configuration: `terraform apply`

## IAM User

Finally create an IAM user with access to read and write data to an S3 bucket, and create credentials which you'll use when installing the AWS CLI tool.