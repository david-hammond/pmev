#' Get linearly scaled variable based on optimal bins
#'
#' Finds outliers and then bands between 0 and 1 on optimal bins of
#' non-outlier data
#'
#' @param start Start Date of activity
#' @param end End Date of activity
#' @param progress Proportion between 0 and 1 representing percentage completed
#' for each activity (1 = 100% complete)
#' @param planned_cost The planned costs of each activity
#' @param project_value The total value of the project
#' @param cost_to_date The total amount spent on the project to date
#' @param date Character date "YYYY-MM-DD". Defaults to today.
#'
#' @examples
#' data(project)
#' tmp <- ev$new(start = project$start,
#'                        end = project$end,
#'                        progress = project$progress,
#'                        planned_cost = project$planned_cost,
#'                        project_value = 150000,
#'                        cost_to_date = 10000,
#'                        date = "2024-07-03")
#' plot(tmp)
#'
#' @importFrom ggplot2 ggplot geom_line theme scale_y_continuous labs
#' geom_vline annotate aes sec_axis theme_bw
#' @importFrom scales dollar percent label_percent
#' @importFrom lubridate today days
#' @importFrom vdiffr expect_doppelganger
#'
#' @export
#'

# https://www.projectengineer.net/the-earned-value-formulas/

ev <- R6::R6Class("ev",
                       lock_objects = FALSE,
                       public = list(
                         #' @field planned_value (`numeric()`)\cr
                         #'   Planned value schedule
                         planned_value = NULL,
                         #' @field earned_value (`numeric()`)\cr
                         #'   Earned value calculations
                         #' @return A new `ev` object.
                         earned_value = NULL,
                         initialize = function(start,
                                               end,
                                               progress,
                                               planned_cost,
                                               project_value,
                                               cost_to_date,
                                               date = today()){
                           tmp <- earned_value(start,
                                               end,
                                               progress,
                                               planned_cost,
                                               project_value,
                                               cost_to_date,
                                               date)
                          self$planned_value <- tmp$pv
                          self$earned_value <- tmp$ev
                         },
                         #' @description Plots the planned and earned values
                         plot = function(){
                           date_today <- as.Date(self$earned_value$date)
                           pv <- data.frame(date = self$planned_value$end,
                                           type = 'Planned Value',
                                           value =
                                             self$planned_value$planned_value)
                           ev <- rbind(pv[1,] %>% mutate(type = "Earned Value"),
                                      data.frame(date = self$earned_value$date,
                                                 type = 'Earned Value',
                                                 value =
                                                   self$earned_value$earned_value))
                           ac <- rbind(pv[1,] %>% mutate(type = "Actual Cost"),
                                      data.frame(date = self$earned_value$date,
                                                 type = 'Actual Cost',
                                                 value =
                                                   self$earned_value$actual_cost))
                           ev <- pv %>% rbind(ev) %>% rbind(ac)
                           p <- ggplot(ev, aes(date, value, colour = type)) +
                             geom_line(linewidth = 1.5) +
                             scale_y_continuous(labels = dollar,
                                                name = "Total Value",
                                                sec.axis =
                                                  sec_axis(~ . / max(pv$value),
                                                labels = label_percent())) +
                             labs(colour = "",
                                  title = "Earned Value Chart",
                                  x = "") + theme_bw() +
                             theme(legend.position = "inside",
                                   legend.position.inside = c(0.8, 0.2)) +
                             geom_vline(xintercept = as.numeric(date_today),
                                        linetype = "dashed",
                                        color = "cornflowerblue") +
                             annotate("text",
                                      x = date_today + days(1),
                                      y = max(ev$value),
                                      label = "Today",
                                      hjust = 0,
                                      vjust = 1.5,
                                      color = "cornflowerblue")
                           return(p)
                         }
                       )

)
