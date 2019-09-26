#' @rdname copyobject
#' @title Copy Objects
#' @description Copy objects between S3 buckets
#' @details \code{copy_object} copies an object from one bucket to another without bringing it into local memory. For \code{copy_bucket}, all objects from one bucket are copied to another (limit 1000 objects). The same keys are used in the old bucket as in the new bucket.
#'
#' @param from_bucket A character string containing the name of the bucket you want to copy from.
#' @param to_bucket A character string containing the name of the bucket you want to copy into.
#' @param from_object A character string containing the name the object you want to copy.
#' @param to_object A character string containing the name the object should have in the new bucket.
#' @param headers List of request headers for the REST call.   
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template dots
#'
#' @return Something...
#' @references \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectCOPY.html}{API Documentation}
#' @export
copy_object <- function(from_object, to_object = from_object, from_bucket, to_bucket, headers = list(), use_https, ...) {
    from_bucket <- get_bucketname(from_bucket)
    to_bucket <- get_bucketname(to_bucket)
    from_object <- get_objectkey(from_object)
    to_object <- get_objectkey(to_object)
    r <- s3HTTP(verb = "PUT", 
                bucket = to_bucket,
                path = paste0("/", to_object),
                headers = c(headers, 
                            `x-amz-copy-source` = paste0("/",from_bucket,"/",from_object)), 
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

#' @rdname copyobject
#' @export
copy_bucket <- function(from_bucket, to_bucket, ...) {
    from_bucket <- get_bucketname(from_bucket)
    to_bucket <- get_bucketname(to_bucket)
    if (!to_bucket %in% sapply(bucketlist(...), `[[`, "Name")) { 
        n <- put_bucket(to_bucket, ...)
    }
    b <- get_bucket(from_bucket, max = Inf, ...)
    lapply(b, function(x) {
        copyobject(from_object = x, to_object = get_objectkey(x), from_bucket = from_bucket, to_bucket = to_bucket, ...)
    })
}
