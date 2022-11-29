library(tidyverse)
library(lubridate)
library(clock)

logins <- read_csv(
  file = "data/r-sessions.csv",
  col_types = cols(
    pid = col_double(),
    username = col_character(),
    timestamp = col_double(),
    type = col_character(),
    data = col_character()
  )
) |>
  select(-data) |>
  mutate(
    time_stamp = as_datetime(timestamp / 1000, origin = origin, tz = "UTC"),
    year = date_group(time_stamp, "year"),
    month = date_group(time_stamp, "month"),
    quarter = date_group(time_stamp, "month", n = 3),
    week = date_group(time_stamp, "day", n = 7),
    day = date_group(time_stamp, "day")
  )

p1 <- logins |>
  filter(str_detect(username, "^[a-z]{2}[0-9]{5}$|^[a-z]{1}[0-9]{6}$")) |>
  filter(type == "session_start") |>
  group_by(quarter) |>
  mutate(quarterly_users = length(unique(username))) |>
  group_by(month) |>
  mutate(monthly_users = length(unique(username))) |>
  group_by(week) |>
  mutate(weekly_users = length(unique(username))) |>
  group_by(day) |>
  mutate(daily_users = length(unique(username))) |>
  pivot_longer(cols = contains("_user"),
               names_to = "time_period",
               values_to = "users") |>
  ggplot(aes(x = time_stamp, y = users, color = time_period)) +
  labs(
    x = NULL,
    y = "Users",
    title = "Active Workbench Users",
    subtitle = "A user is defined as having started a session on Workench"
  ) +
  theme_bw()
p1 + geom_line()