#' @title Delete object
#' @description Deletes one or more objects from an S3 bucket.
#'
#' @template object
#' @template bucket
#' @param quiet A logical indicating whether (when \code{object} is a list of multiple objects), to run the operation in \dQuote{quiet} mode. Ignored otherwise. See API documentation for details.
#' @param use_https True if connection is HTTPS and False if connection is HTTP
#' @template dots
#' @details \code{object} can be a single object key, an object of class \dQuote{s3_object}, or a list of either.
#'
#' @return \code{TRUE} if successful, otherwise an object of class aws_error details if not.
#' @references \href{http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectDELETE.html}{API Documentation}
#' @seealso \code{\link{put_object}}
#' @importFrom digest digest
#' @importFrom base64enc base64encode
#' @importFrom xml2 read_xml write_xml xml_add_child
#' @export
delete_object <- function(object, bucket, quiet = TRUE, use_https = FALSE, ...) {
    if (missing(bucket)) {
        bucket <- get_bucketname(object)
    }
    object <- get_objectkey(object)
    if (length(object) == 1) {
        r <- s3HTTP(verb = "DELETE", 
                    bucket = bucket,
                    path = paste0("/", object),
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
        return(TRUE)
    } else {
        xml <- read_xml(paste0('<?xml version="1.0" encoding="UTF-8"?><Delete><Quiet>', tolower(quiet),'</Quiet></Delete>'))
        for (i in seq_along(object)) {
            xml2::xml_add_child(xml, xml2::read_xml(paste0("<Object><Key>", get_objectkey(object[[i]]), "</Key></Object>")))
        }
        tmpfile <- tempfile()
        on.exit(unlink(tmpfile))
        xml2::write_xml(xml, tmpfile)
        md <- base64enc::base64encode(digest::digest(file = tmpfile, raw = TRUE))
        r <- s3HTTP(verb = "POST", 
                    bucket = bucket,
                    query = list(delete = ""),
                    request_body = tmpfile,
                    headers = list(`Content-Length` = file.size(tmpfile), 
                                   `Content-MD5` = md), 
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
}
