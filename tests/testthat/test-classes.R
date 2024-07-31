test_that("earned_value works", {
  data(project)
  expected <- earned_value(start = project$start,
                           end = project$end,
                           progress = project$progress,
                           planned_cost = project$planned_cost,
                           project_value = 164000,
                           cost_to_date = 7500,
                           date = "2024-07-03")
  expect_s3_class(expected$ev, "data.frame")
})

test_that("panned_value works", {
  data(project)
  expected <- earned_value(start = project$start,
                           end = project$end,
                           progress = project$progress,
                           planned_cost = project$planned_cost,
                           project_value = 164000,
                           cost_to_date = 7500,
                           date = "2024-07-03")
  expect_s3_class(expected$pv, "data.frame")
})

test_that("ev$new works", {
  data(project)
  expected <- ev$new(start = project$start,
                     end = project$end,
                     progress = project$progress,
                     planned_cost = project$planned_cost,
                     project_value = 164000,
                     cost_to_date = 7500,
                     date = "2024-07-03")
  expect_s3_class(expected, "ev")
})

test_that("plot works", {
  require(vdiffr)
  data(project)
  expected <- ev$new(start = project$start,
                     end = project$end,
                     progress = project$progress,
                     planned_cost = project$planned_cost,
                     project_value = 164000,
                     cost_to_date = 7500,
                     date = "2024-07-03")
  expect_doppelganger("ggplot plot", print(plot(expected)))
})
