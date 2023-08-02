import boto3
from botocore.exceptions import ClientError

def run_glue_job(event, context):
   session = boto3.session.Session()
   glue_client = session.client('glue')
   try:
      glue_client.start_job_run(JobName='kubra-demo-job')
   except ClientError as e:
      raise Exception( "boto3 client error in run_glue_job: " + e.__str__())
   except Exception as e:
      raise Exception( "Unexpected error in run_glue_job: " + e.__str__())

def handler(): 
   run_glue_job()