#' Thin large shape files
#'
#' This function allows you to thin the number of points in shape files.
#'
#'
#' @param x is a shape file.
#' @param tolerance is the value used for thinning the shape file,default is 0.1.
#' @export
#' @import rmapshaper
#' @return The return value is a data frame with the thinned geographical
#'  information.
#' @examples
#' library("Lab3package")
#' data("Yemen")
#' dframe <- thin(Yemen)
#'
thin <- function(x, tolerance = 0.1){
  rmapshaper::ms_simplify(x, snap_interval = tolerance)
}
