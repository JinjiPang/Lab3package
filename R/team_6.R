#' Convert shape file into a data frame using team_6 lab2
#'
#' @param file The file path to a shape file
#' @param tolerance The value used for thinning the polygon
#' @import sf
#' @import purrr
#' @import ggplot2
#' @importFrom dplyr %>%
#' @export
#' @return A data frame including geographic information of the polygons and the additional information
#' @examples
#' library(Lab3package)
#' data("France")
#'
#' df <- team_6(France, 0.1)
#'
#' \dontrun{
#' library(ggplot2)
#' df %>%
#'   ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
#' }
#'

team_6 <- function(file, tolerance = 0.1){
  if ("character" %in% class(file)) {
    ozbig <- sf::read_sf(file)
  }
  if ("sf" %in% class(file)) {
    ozbig <- file
  }
  if (".rds" %in% file){
    ozbig <- readRDS(file)
  }
  if (".rda" %in% file){
    paste("Your file is .rda, please load() it first and input the dataframe as file")
    ozbig <- file
  }
  if(is.data.frame(file)){
    ozbig <- file
  }
  if(!("geometry" %in% colnames(ozbig))){
    paste("You should name your polygon information: geometry")
  }
  oz <- thin(x = ozbig, tolerance = tolerance)
  df <- oz$geometry %>%
    purrr::flatten() %>%
    purrr::flatten() %>%
    purrr::map_df(.id ="group", .f = function(mat){
      data.frame(long = mat[, 1],
                 lat  = mat[, 2],
                 group = 1:nrow(mat),
                 order= 1:nrow(mat))
    })
  return(df)
}



