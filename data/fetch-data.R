library(tidyverse)
library(ihpdr)

diff4 <- function(x) (log(x) - dplyr::lag(log(x), n = 4L))*100

main <- ihpd_get("raw") %>%
  select(date = Date, country, hpi) %>%
  pivot_wider(names_from = country, values_from = hpi)

main %>%
  purrr::map_df(round, 2) %>%
  select(-`Aggregate - 2005 Fixed Weights`) %>%
  rename("Aggregate" = `Aggregate - Dynamic Weights`) %>%
  write_csv("data/level.csv")

main %>%
  purrr::modify_if(is.numeric, diff4) %>%
  purrr::map_df(round, 2) %>%
  select(-`Aggregate - 2005 Fixed Weights`) %>%
  rename("Aggregate" = `Aggregate - Dynamic Weights`) %>%
  write_csv("data/growth.csv")
