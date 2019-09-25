#' @title Bucket exists?
#' @description Check whether a bucket exists and is accessible with the current authentication keys.
#' @template bucket
#' @template dots
#'
#' @return \code{TRUE} if bucket exists and is accessible, else \code{FALSE}.
#' @references \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketHEAD.html}{API Documentation}
#' @export
bucket_exists <- function(bucket, use_https, ...){
    s3HTTP(verb = "HEAD", 
           bucket = bucket,           
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
  
}

