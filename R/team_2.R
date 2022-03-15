#' Convert shape file into a data frame using team_2 lab2
#'
#' This function is generated based on team 2's solution from lab 2.
#' team_2 function allows you to create a data frame from  a `geometry` variable.
#'
#'
#' @param file is a file path to a shape file.
#' @param tolerance is the value used for thinning the polygon,default is 0.1.
#'
#' @return The return value is a data frame of the geographic information of
#' the polygons and the additional information.
#'
#' @export
#' @import sf purrr ggplot2 tidyr dplyr
#'
#' @examples
#' library("Lab3package")
#' data("Yemen")
#'
#' df <- team_2(Yemen, 0.1)
#'
#' \dontrun{
#' df %>%
#'   ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
#' }
#'
team_2 <- function(file, tolerance) {

  if ("character" %in% class(file)) {
    oz <- read_sf(file)
    oz <- thin(oz)
  }

  if ("sf" %in% class(file)) {
    oz <- file
  }

  ozgeo = oz$geometry

  f = function(l){
    l = l %>% flatten() %>% flatten()
    for(i in 1:length(l)){
      l[[i]] = data.frame(l[[i]])
      colnames(l[[i]]) = c('long', 'lat')
      l[[i]]$order = 1:nrow(l[[i]])
      l[[i]]$group = i
    }
    do.call(rbind, l)
  }

  df = f(ozgeo)

}

