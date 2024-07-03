#' pmev: Calculate Earned Value from a Project Schedule and Associated Costs.
#'
#' \code{pmev} implements project management tracking metrics as outlined in the
#'  Project Management Body of Knowledge (PMBOK) manual which can be found
#'  \href{https://www.pmi.org/pmbok-guide-standards/foundational/pmbok}{here}.
#'
#' From an inputted list of project activities, start and end dates,
#' planned costs, progress and costs to date, it calculates the following
#' PMBOK metrics:
#'
#' \itemize{
#' \item \strong{Planned Value (PV)} Planned Value is the amount of the task
#' that is supposed to have been completed, in terms of the task budget.
#' It is calculated from the project budget by:
#' \itemize{
#' \item PV = Percent Complete (planned) x Task Budget.
#' }
#' \item \strong{Earned Value (EV)} Earned Value is the amount of the task
#' that is actually completed.  It is also calculated from the project budget.
#' \itemize{
#' \item EV = Percent Complete (actual) x Task Budget.
#' }
#' \item \strong{Actual Cost (AC)} Actual Cost is the actual to-date cost of
#' the task.
#' \item \strong{Schedule Variance (SV)} A value which tells you the amount
#' that the task is ahead or behind schedule.
#' \itemize{
#' \item SV = EV – PV.
#' \itemize{
#' \item If SV is negative, the task is behind schedule.
#' \item If SV is zero, the task is on schedule
#' \item If SV is positive, the task is ahead of schedule.
#' }
#' }
#' \item \strong{Schedule Performance Index (SPI)} The SPI, similar to the SV,
#' also indicates ahead or behind schedule but gives the project manager a
#' sense of the relative amount of the variance.
#' \itemize{
#' \item SPI = EV / PV
#' \itemize{
#' \item If SPI < 1, the task is behind schedule
#' \item If SPI = 1, the task is on schedule
#' \item If SPI > 1, the task is ahead of schedule
#' }
#' }
#' \item \strong{Cost Variance (CV)} Cost Variance tells the project manager
#' how far the task is over or under budget.
#' \itemize{
#' \item CV = EV – AC
#' \itemize{
#' \item If CV is negative, the task is over budget
#' \item If CV is zero, the project is on budget
#' \item If CV is positive, the project is under budget
#' }
#' }
#' \item \strong{Cost Performance Index (CPI)} The CPI, similar to the CV,
#' also indicates over or under budget but gives the project manager a sense
#' of the relative amount of the variance.
#' \itemize{
#' \item CPI = EV / AC
#' \itemize{
#' \item If CPI < 1, the task is over budget
#' \item If CPI = 1, the task is on budget
#' \item If CPI > 1, the task is under budget
#' }
#' }
#' \item \strong{Budget at Completion (BAC)} It is simply the total project
#' budget, which is the aggregate of all of the task budgets.
#' \item \strong{Estimate at Completion (EAC)} This value tells the project
#' manager what the overall project budget will be if everything else went
#' according to plan.
#' \itemize{
#' \item \code{pmev} calculates this as EAC = BAC / CPI.
#' }
#' \item \strong{Estimate to Complete (ETC)} This value tells the project
#' manager how much money must be spent from this point forward, to complete
#' the project.
#' \itemize{
#' \item ETC = EAC – AC
#' }
#' \item \strong{Variance at Completion (VAC)} This value tells the project
#' manager the forecasted cost variance (CV) at the completion of the project.
#' \itemize{
#' \item VAC = BAC – EAC
#' }
#' \item \strong{To Complete Performance Index (TCPI)} This value tells the
#' project manager what CPI would be necessary to finish the project on budget.
#' It gives an indication of how much efficiency needs to be found in the
#' remainder of the project to make up for past negative variances.
#' \itemize{
#' \item \code{pmev} calculates this as TCPI = (BAC – EV) / (BAC – AC)
#' }
#'}
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
