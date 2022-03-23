#' Convert shape file into a data frame using team_6 lab2
#'
#' @param file The file path to a shape file
#' @param tolerance The value used for thinning the polygon
#' @import sf
#' @import purrr
#' @import ggplot2
#' @importFrom dplyr %>%
#' @importFrom stats rnorm
#' @export
#' @return A data frame including geographic information of the polygons and the additional information
#' @examples
#' library(Lab3package)
#' data("Yemen")
#'
#' df <- team_6(Yemen, 0.1)
#'
#' \dontrun{
#' library(tidyverse)
#' library(ggplot2)
#' df %>%
#'   ggplot(aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = NAME_1))
#' }
#'
team_6 <- function(file, tolerance = 0.1){
  NAME_1 <- NULL
  group <- NULL
  data0 <- NULL
  order <- NULL
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

    oz <- oz %>% mutate(
      data0 = oz$geometry %>% purrr::map(
        .f = function(x) {
          x %>% flatten() %>%
            map_df(.id = "group", .f =  function(dat) {
              data.frame(long = dat[,1], lat = dat[,2], group = rep(rnorm(1), nrow(dat)), order = 1:nrow(dat))
            })
        }
      )
    )
    ozlong <- oz %>% tidyr::unnest(col = data0)
    df <-  ozlong %>% mutate(group = paste(NAME_1,group))
    return(df)
}



