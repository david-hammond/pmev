#' Calculate the Earned Value of a Project Schedule to Date
#'
#' Given a set of project activities start times, end times, progress and costs,
#' this function calculates the Earned Value at a certain Date
#' @importFrom lubridate today
#' @importFrom zoo na.approx
#' @importFrom dplyr mutate
#' @importFrom rlang .data
#'
#' @param start Start Date of activity
#' @param end End Date of activity
#' @param progress Proportion between 0 and 1 representing percentage completed for each activity (1 = 100% complete)
#' @param planned_cost The planned costs of each activity
#' @param project_value The total value of the project
#' @param cost_to_date The total amount spent on the project to date
#' @param date Character date "YYYY-MM-DD". Defaults to today.
#'
#' @return A list of two data frames:
#' \itemize{
#' \item \strong{pv} Planned Value Schedule, a data frame with two columns:
#' \itemize{
#' \item \strong{date:} Daily Dates over Project Schedule
#' \item \strong{planned_value:} The Planned Value to be delivered at that date.
#' }
#' \item \strong{ev} Earned Value Calculations, a data frame with 15 columns:
#' \itemize{
#' \item \strong{date:} Date of calculation
#' \item \strong{total_value:} Total Value of the Project.
#' \item \strong{budget_at_completion:} Aggregate costs of all of the task budgets
#' \item \strong{project_complete:} Project Complete based on Earned Value and total Project Value.
#' \item \strong{schedule_complete:} The difference in Earned Value and Planned value as a proportion of the Total Value.
#' \item \strong{planned_value:} The amount of the project that is supposed to have been completed.
#' \item \strong{earned_value:} The amount of the project that is actually completed
#' \item \strong{actual_cost:} Actual Cost is the actual to-date cost of the project.
#' \item \strong{schedule_variance:} The amount that the project is ahead or behind schedule.
#' \item \strong{cost_variance:} How far the task is over or under budget.
#' \item \strong{cost_performance_index:} Relative amount of the variance to Planned Value.
#' \item \strong{estimate_at_completion:} What the overall project budget will be if everything else went according to plan.
#' \item \strong{estimate_to_complete:} How much money must be spent from this point forward, to complete the project.
#' \item \strong{variance_at_completion:} The forecasted cost variance (CV) at the completion of the project.
#' \item \strong{to_complete_performance_index:} What CPI would be necessary to finish the project on budget.
#' }
#' }
#'
#' @examples
#' data(project)
#' earned_value(start = project$start,
#'               end = project$end,
#'               progress = project$progress,
#'               planned_cost = project$planned_cost,
#'               project_value = 150000,
#'               cost_to_date = 10000,
#'               date = "2024-07-03")
#' @export
#'

earned_value = function(start,
                          end,
                          progress,
                          planned_cost,
                          project_value,
                          cost_to_date,
                          date = today()){
  date = as.Date(date)
  df = data.frame(start = as.Date(start), end = as.Date(end), progress, planned_cost) %>%
    mutate(planned_value = project_value*.data$planned_cost/sum(.data$planned_cost))
  planned_value = get_planned_value(df)
  earned_value = data.frame(date = date,
                            total_value = project_value,
                            budget_at_completion = sum(planned_cost),
                            planned_value = planned_value$planned_value[which(abs(planned_value$end - date) == min(abs(planned_value$end - date) ))],
                            earned_value = sum(df$progress*df$planned_value),
                            actual_cost = cost_to_date)
  earned_value = earned_value %>%
    mutate(schedule_variance = .data$earned_value - .data$planned_value,
           cost_variance = .data$earned_value-.data$actual_cost,
           cost_performance_index = .data$earned_value/.data$actual_cost,
           estimate_at_completion = project_value/.data$cost_performance_index,
           estimate_to_complete = .data$estimate_at_completion - cost_to_date,
           variance_at_completion = .data$budget_at_completion - .data$estimate_at_completion,
           to_complete_performance_index =  (project_value - .data$earned_value)/(project_value - cost_to_date),
           project_complete = .data$earned_value/project_value,
           schedule_complete = .data$schedule_variance/project_value)
  earned_value = earned_value[,c("date",
                                 "total_value",
                                 "budget_at_completion",
                                 "project_complete",
                                 "schedule_complete",
                                 "planned_value",
                                 "earned_value",
                                 "actual_cost",
                                 "schedule_variance",
                                 "cost_variance",
                                 "cost_performance_index",
                                 "estimate_at_completion",
                                 "estimate_to_complete",
                                 "variance_at_completion",
                                 "to_complete_performance_index")]
  earned_value[-1] = apply(earned_value[-1], 1, round, digits = 2)
  earned_value = list(pv = planned_value, ev = earned_value)
  return(earned_value)
}




