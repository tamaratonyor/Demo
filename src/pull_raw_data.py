from sqlalchemy import create_engine
import pymysql
import pandas as pd
import boto3
import os
import yaml 

with open('../config/config.yaml', 'r') as file:
    credentials = yaml.safe_load(file)
    user = credentials['user']
    password = credentials['password']

FILE_NAME = "raw.csv"
AWS_S3_BUCKET = os.getenv("AWS_S3_BUCKET")
AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")

s3_client = boto3.client(
    "s3",
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
)

def pull_from_db():
    sqlEngine = create_engine(f'mysql+pymysql://{user}:{password}@127.0.0.1', pool_recycle=3600)
    dbConnection = sqlEngine.connect()
    raw_df = pd.read_sql("select * from demo_db.demo_table", dbConnection)
    return raw_df

def write_to_s3(raw_df):
    raw_df.to_csv(
    f"s3://{AWS_S3_BUCKET}/{FILE_NAME}",
    index=False,
    storage_options={
        "key": AWS_ACCESS_KEY_ID,
        "secret": AWS_SECRET_ACCESS_KEY,
    },
)

if __name__ == '__main__':
    raw_df = pull_from_db()
    write_to_s3(raw_df)