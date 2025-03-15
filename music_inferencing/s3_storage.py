import boto3


def upload_file(binary_data, bucket_name, key):
    s3 = boto3.resource("s3")
    object = s3.Object(bucket_name, key)
    object.put(Body=binary_data)
