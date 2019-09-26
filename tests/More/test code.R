Sys.setenv("AWS_ACCESS_KEY_ID" = "test",
           "AWS_SECRET_ACCESS_KEY" = "denso123",
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_S3_ENDPOINT" = "10.74.87.26:32680")

s3HTTP(verb = "GET",
           bucket = "", 
           path = "", 
           query = NULL,
           headers = list(), 
           request_body = "",
           write_disk = NULL,
           accelerate = FALSE,
           dualstack = FALSE,
           parse_response = TRUE, 
           check_region = FALSE,
           url_style = c("path", "virtual"),
           base_url = Sys.getenv("AWS_S3_ENDPOINT"),
           verbose = getOption("verbose", FALSE),
           region = Sys.getenv("AWS_DEFAULT_REGION"), 
           key = Sys.getenv("AWS_ACCESS_KEY_ID"), 
           secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"), 
           session_token = NULL,
           use_https = use_https) 

get_bucket("dmat")

bucket_exists("dmtn", verbose = T)

copy_object(from_object = "na.txt", from_bucket = "dmat", to_bucket="dmtn", use_https = F)

delete_object(object = "na.txt", bucket = "dmtn", use_https = F)

delete_bucket("dmmi", use_https = F)

get_location(bucket = "dmat", use_https = F)

aa = get_object(object = "step1/23SUMMY.PPT", bucket = "tie", use_https = F)
typeof(aa)

put_bucket(bucket = "dmmi", 
acl = "public-read",
headers = list(), 
use_https = FALSE)
put_object("/home/lambdaadmin/Gits/aws.s3/drat.sh", object = "drat.sh", bucket = "dmat", use_https=F)
