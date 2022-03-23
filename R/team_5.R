#' Convert shape file into a data frame using team_5 lab2
#'
#' This function is generated based on team 5's solution from lab 2.
#' team_5 function allows you to create a data frame from  a `geometry` variable.
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
#' @importFrom rlang .data
#'
#' @examples
#' library("Lab3package")
#' data("Yemen")
#'
#' df <- team_5(Yemen, 0.1)
#'
#' \dontrun{
#' df %>%
#'   ggplot(aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill =HASC_1 ))
#' }
#'
team_5 <- function(file, tolerance) {

  if ("character" %in% class(file)) {
    oz <- read_sf(file)
    oz <- thin(oz)
  }

  if ("sf" %in% class(file)) {
    oz <- file
  }

  oz <- oz %>% mutate(
    data = .data$geometry %>% purrr::map(
      .f = function(x) {
        x %>% flatten() %>%
          map_df(.id = "group", .f =  function(dat) {
            data.frame(long = dat[,1], lat = dat[,2], group = rep(stats::rnorm(1), nrow(dat)))
          })
      }
    )
  ) %>% select(.data$HASC_1, .data$data)
  ozlong <- oz %>% tidyr::unnest(col = .data$data)
  ozlong %>% mutate(
    group = paste(.data$HASC_1, .data$group)
  )


}



