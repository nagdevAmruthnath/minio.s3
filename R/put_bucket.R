#' @title Create bucket
#' @description Creates a new S3 bucket.
#' @template bucket
#' @template acl
#' @param headers List of request headers for the REST call.
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template dots
#' @return \code{TRUE} if successful.
#' @details Bucket policies regulate who has what access to a bucket and its contents. The \code{header} argument can beused to specify \dQuote{canned} policies and \code{\link{put_bucket_policy}} can be used to specify a more complex policy. The \href{https://awspolicygen.s3.amazonaws.com/policygen.html}{AWS Policy Generator} can be useful for creating the appropriate JSON policy structure.
#' @examples
#' \dontrun{
#'   put_bucket("examplebucket")
#'   
#'   # set a "canned" ACL to, e.g., make bucket publicly readable
#'   put_bucket("examplebucket", headers = list(`x-amz-acl` = "public-read"), use_https=F)
#' 
#' }
#' @references 
#' \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUT.html}{API Documentation}
#' \href{https://awspolicygen.s3.amazonaws.com/policygen.html}{AWS Policy Generator}
#' @seealso \code{\link{bucketlist}}, \code{\link{get_bucket}}, \code{\link{delete_bucket}}, \code{\link{put_object}}
#' @export
put_bucket <- 
function(bucket, 
         acl = c("private", "public-read", "public-read-write", 
                 "aws-exec-read", "authenticated-read", 
                 "bucket-owner-read", "bucket-owner-full-control"),
         headers = list(), 
         use_https = FALSE,
         ...){
    region = Sys.getenv("AWS_DEFAULT_REGION")
    b <- paste0('<CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><LocationConstraint>', 
                region, '</LocationConstraint></CreateBucketConfiguration>')
    r <- s3HTTP(verb = "PUT", 
                bucket = bucket,
                request_body = b,
                headers = headers,
                check_region = FALSE,
                encode = "raw",
                write_disk = NULL,
                accelerate = FALSE,
                dualstack = FALSE,
                parse_response = TRUE, 
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
