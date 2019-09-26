#' @title Bucket location
#' @description Get the AWS region location of bucket.
#' @template bucket
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template dots
#'
#' @return A character string containing the region, if one has been set.
#' @references \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETlocation.html}{API Documentation}
#' @export
get_location <- function(bucket, use_https, ...){
    r <- s3HTTP(verb = "GET", 
                bucket = bucket,
                query = list(location = ""),
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
    if (!length(r)) {
        return("us-east-1")
    } else {
        return(r[[1L]])
    }
}
