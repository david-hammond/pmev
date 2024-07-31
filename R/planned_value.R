#' Calculate the Planned Value of a Project Schedule to Date
#'
#' Given a set of project activities start times, end times, progress and costs,
#' this function calculates the Planned Value across the Project Schedule
#' @importFrom lubridate today
#' @importFrom zoo na.approx
#' @importFrom dplyr select group_by left_join ungroup summarise mutate
#'
#' @param df A Data Frame of the Project
#' @param project_value The total value of the project
#'
#' @keywords internal



get_planned_value <- function(df, project_value) {
  start_at_zero <- data.frame(end = min(df$start), planned_value = 0)
  df <- df |> select(.data$end, .data$planned_value) |>
    group_by(.data$end) |>
    summarise(planned_value = sum(.data$planned_value)) |>
    ungroup() |>
    mutate(planned_value = cumsum(.data$planned_value))
  df <- start_at_zero |> rbind(df)
  df <- data.frame(end = seq.Date(min(df$end), max(df$end), "days")) |>
    left_join(df, by = "end") |>
    mutate(planned_value = na.approx(.data$planned_value))
  return(df)
}
