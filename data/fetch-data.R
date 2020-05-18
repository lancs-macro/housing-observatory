library(tidyverse)
library(ihpdr)

diff4 <- function(x) log(x) - dplyr::lag(log(x), n = 4L)

main <- ihpd_get("raw") %>%
  select(date = Date, country, hpi) %>%
  pivot_wider(names_from = country, values_from = hpi)

main %>%
  purrr::map_df(round, 2) %>%
  write_csv("level.csv")

main %>%
  purrr::modify_if(is.numeric, diff4) %>%
  purrr::map_df(round, 2) %>%
  write_csv("growth.csv")
