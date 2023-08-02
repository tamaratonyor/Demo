from pyspark.sql.functions import col
from pyspark.context import SparkContext
from awsglue.context import GlueContext


sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

def raw_to_silver():
    raw_df = spark.read\
    .format("csv")\
    .option("header", "true")\
    .load("s3://raw-bucket-kubra-demo/raw.csv")
    silver_df = raw_df.filter(raw_df.Number_Of_Employees != '0').filter(raw_df.Founded != '0')
    silver_df.write.option("header",True).csv("s3://silver-bucket-kubra-demo/silver",mode="overwrite")
    return silver_df

def silver_to_gold(silver_df):
    gold_df = silver_df.filter(col("Website").like("%http%"))
    gold_df.write.option("header",True).csv("s3://gold-bucket-kubra-demo/gold",mode="overwrite")

if __name__ == '__main__':
    silver_df = raw_to_silver()
    silver_to_gold(silver_df)
    
