#' @rdname notifications
#' @title Notifications
#' @description Get/put the notification configuration for a bucket.
#'
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template bucket
#' @param request_body A character string containing an XML request body, as defined in the specification in the \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTnotification.html}{API Documentation}.
#' @template dots
#'
#' @return A list containing the notification configuration, if one has been set.
#' @references 
#' \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETnotification.html}{API Documentation: GET}
#' \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTnotification.html}{API Documentation: PUT}
#' @export
get_notification <- function(bucket, use_https  = FALSE, ...){
    r <- s3HTTP(verb = "GET", 
                bucket = bucket,
                query = list(notification = ""),
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

#' @rdname notifications
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @export
put_notification <- function(bucket, request_body, use_https= FALSE,...){
    r <- s3HTTP(verb = "PUT", 
                bucket = bucket,
                query = list(notification = ""),
                request_body = request_body,
                headers = list(),
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
    structure(r, class = "s3_bucket")
}
