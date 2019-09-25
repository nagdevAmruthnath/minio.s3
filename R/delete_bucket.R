#' @title Delete Bucket
#' @description Deletes an S3 bucket.
#'
#' @template bucket
#' @template dots
#'
#' @return \code{TRUE} if successful, \code{FALSE} otherwise. 
#' @references \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETE.html}{API Documentation}
#' @export
delete_bucket <- function(bucket, use_https, ...){
    r <- s3HTTP(verb = "DELETE", 
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
    return(r)
}
