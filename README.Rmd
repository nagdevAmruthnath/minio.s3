# MinIO S3 Client Package

This is a modified version of cloudyr aws.s3 package with support to MinIO S3 storage database. All credits goes to them. This can also be used to access AWS S3 storage. If you see aws.s3 reference, don't be surprised. Its a forked project. 

You can use this package for locally deployed (use `use_https = F`) and cloud deployed.

## Installation

This package is not yet on CRAN. To install the latest development version you can install from the github:

```R
library(devtools)
install_github("nagdevAmruthnath/minio.s3")
```

## Usage

By default, all packages for AWS/MinIO services allow the use of credentials specified in a number of ways, beginning with:

 1. User-supplied values passed directly to functions.
 2. Environment variables, which can alternatively be set on the command line prior to starting R or via an `Renviron.site` or `.Renviron` file, which are used to set environment variables in R during startup (see `? Startup`). Or they can be set within R:
 
    ```R
    Sys.setenv("AWS_ACCESS_KEY_ID" = "test", # enter your credentials
           "AWS_SECRET_ACCESS_KEY" = "test123", # enter your credentials
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_S3_ENDPOINT" = "192.168.1.1:8085")    # change it to your specific IP and port

    ```
For more information on aws usage, refer to aws.s3 package.  


### Code Examples

The package can be used to examine publicly accessible S3 buckets and publicly accessible S3 objects. 

```R
library("minio.s3")
bucketlist(add_region = FALSE)
```

If your credentials are incorrect, this function will return an error. Otherwise, it will return a list of information about the buckets you have access to.

### Buckets

#### Create a bucket
To create a new bucket, simply call

```R
put_bucket('my-bucket', acl = "public-read-write", use_https=F)
```
If successful, it should return `TRUE`

#### List Bucket Contents
To get a listing of all objects in a public bucket, simply call

```R
get_bucket(bucket = 'my-bucket', use_https = F)
```

#### Delete Bucket
To delete a bucket, simply call

```R
delete_bucket(bucket = 'my-bucket', use_https = F)
```


### Objects

There are eight main functions that will be useful for working with objects in S3:

 1. `s3read_using()` provides a generic interface for reading from S3 objects using a user-defined function
 2. `s3write_using()` provides a generic interface for writing to S3 objects using a user-defined function
 3. `get_object()` returns a raw vector representation of an S3 object. This might then be parsed in a number of ways, such as `rawToChar()`, `xml2::read_xml()`, `jsonlite::fromJSON()`, and so forth depending on the file format of the object
 4. `save_object()` saves an S3 object to a specified local file
 5. `put_object()` stores a local file into an S3 bucket
 6. `s3save()` saves one or more in-memory R objects to an .Rdata file in S3 (analogously to `save()`). `s3saveRDS()` is an analogue for `saveRDS()`
 7. `s3load()` loads one or more objects into memory from an .Rdata file stored in S3 (analogously to `load()`). `s3readRDS()` is an analogue for `saveRDS()`
 8. `s3source()` sources an R script directly from S3

They behave as you would probably expect:

```R
# save an in-memory R object into S3
s3save(mtcars, bucket = "my_bucket", object = "mtcars.Rdata", use_https = F)

# `load()` R objects from the file
s3load("mtcars.Rdata", bucket = "my_bucket", use_https = F)

# get file as raw vector
get_object("mtcars.Rdata", bucket = "my_bucket", use_https = F)
# alternative 'S3 URI' syntax:
get_object("s3://my_bucket/mtcars.Rdata", use_https = F)

# save file locally
save_object("mtcars.Rdata", file = "mtcars.Rdata", bucket = "my_bucket", use_https = F)

# put local file into S3
put_object(file = "mtcars.Rdata", object = "mtcars2.Rdata", bucket = "my_bucket", use_https = F)
```


