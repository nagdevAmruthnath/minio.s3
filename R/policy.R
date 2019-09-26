#' @rdname policy
#' @title Bucket policies
#' @description Get/Put/Delete the bucket access policy for a bucket.
#' @template bucket
#' @param policy A character string containing a bucket policy.
#' @param parse_response A logical indicating whether to return the response as is, or parse and return as a list. Default is \code{FALSE}.
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template dots
#' @details Bucket policies regulate who has what access to a bucket and its contents. The \code{header} argument can beused to specify \dQuote{canned} policies and \code{\link{put_bucket_policy}} can be used to specify a more complex policy. The \href{https://awspolicygen.s3.amazonaws.com/policygen.html}{AWS Policy Generator} can be useful for creating the appropriate JSON policy structure.
#' @return For \code{get_policy}: A character string containing the JSON representation of the policy, if one has been set. For \code{delete_policy} and \code{put_policy}: \code{TRUE} if successful, \code{FALSE} otherwise. 
#' @references 
#' \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETpolicy.html}{API Documentation}
#' \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETEpolicy.html}{API Documentation}
#' \href{https://awspolicygen.s3.amazonaws.com/policygen.html}{AWS Policy Generator}
#' @export
get_bucket_policy <- function(bucket, parse_response = TRUE, use_https = FALSE, ...){
    r <- s3HTTP(verb = "GET", 
                bucket = bucket,
                query = alist(policy = ),
                parse_response = FALSE, 
                headers = list(), 
                request_body = "",
                write_disk = NULL,
                accelerate = FALSE,
                dualstack = FALSE,
                check_region = FALSE,
                url_style = c("path", "virtual"),
                base_url = Sys.getenv("AWS_S3_ENDPOINT"),
                verbose = getOption("verbose", FALSE),
                region = Sys.getenv("AWS_DEFAULT_REGION"), 
                key = Sys.getenv("AWS_ACCESS_KEY_ID"), 
                secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"), 
                session_token = NULL,
                use_https = use_https)
    if (isTRUE(parse_response)) {
        r <- content(r, "text", encoding = "UTF-8")
    }
    return(r)
}

#' @rdname policy
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @export
put_bucket_policy <- function(bucket, policy, use_https =FALSE, ...){
    r <- s3HTTP(verb = "PUT", 
                bucket = bucket,
                query = alist(policy = ),
                request_body = policy,
                encode = "raw",
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
    return(TRUE)
}

#' @rdname policy
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @export
delete_bucket_policy <- function(bucket, use_https = FALSE, ...){
    r <- s3HTTP(verb = "DELETE", 
                bucket = bucket,
                query = alist(policy = ),
                parse_response = FALSE,
                headers = list(), 
                request_body = "",
                write_disk = NULL,
                accelerate = FALSE,
                dualstack = FALSE, 
                check_region = FALSE,
                url_style = c("path", "virtual"),
                base_url = Sys.getenv("AWS_S3_ENDPOINT"),
                verbose = getOption("verbose", FALSE),
                region = Sys.getenv("AWS_DEFAULT_REGION"), 
                key = Sys.getenv("AWS_ACCESS_KEY_ID"), 
                secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"), 
                session_token = NULL,
                use_https = use_https)
    return(TRUE)
}
