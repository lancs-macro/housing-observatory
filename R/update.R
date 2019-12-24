library(jsonlite)
library(httr)

ukhp_get <- function(frequency = "monthly", classification = "aggregate", release = "latest") {
  endpoint <- "https://lancs-macro.github.io/uk-house-prices"
  query <- paste(endpoint, "releases", release, frequency, paste0(classification, ".json"), sep = "/")
  request <- GET(query)
  stop_for_status(request)
  parse_json(request, simplifyVector = TRUE)
} 


library(uklr)
library(dplyr)
library(tidyverse)

lr <- uklr::ukhp_get("england")

lr_tidy <- lr %>% 
  mutate(region = str_to_title(region)) %>% 
  select(Date = date, region, "Land Registry" = housePriceIndex)


ho <- as_tibble(ukhp_get(classification = "countries"))
ho_tidy <- ho %>% 
  mutate(Date = as.Date(Date)) %>% 
  select(-Wales) %>% 
  pivot_longer(-Date, names_to = "region", values_to = "Housing Observatory")


tbl <- full_join(lr_tidy, ho_tidy) %>% 
  filter(Date >= "1995-02-01") %>% 
  pivot_longer(cols = c("Land Registry", "Housing Observatory")) %>% 
  group_by(name) %>% 
  mutate(value = value/value[1])

ggplot(tbl, aes(Date, value, col = name)) +
  geom_line( size = 0.9) +
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  theme_bw() +
  ggtitle("House Price Index", sub = "England and Wales") +
  scale_color_manual(values = c("red", "#a6d71c")) +
  theme(
    axis.title = element_blank(),
    legend.title = element_blank(),
    legend.position = c(0.25, 0.85),
    legend.background = element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(size = 10)
  )

library(here)

ggsave(here("assets", "img", "comparison.png"), width = 5, height = 4)



# stats -------------------------------------------------------------------

library(nationwider)
library(glue)

ldiff <- function(x, n = 4) log(x) - dplyr::lag(log(x), n = n)

uk_data <- ntwd_get("quarterly") %>%
  filter(key == "Index Q1 1993=100") %>% 
  mutate(stat1 = ldiff(value)) %>% tail(1)

release_date <- uk_data %>%
  mutate(release_date = paste0(lubridate::year(Date), " Q",lubridate::quarter(Date))) %>% 
  pull(release_date)

stat1_num <-  uk_data %>% 
   pull(stat1) %>% `*`(100) %>% round(2)

stat2_num <- ntwd_get("seasonal_regional") %>%  
  filter(region == "London", type == "Index") %>% 
  mutate(stat2 = ldiff(value)) %>% 
  tail(1) %>% pull(stat2) %>% `*`(100) %>% round(1)

jspath <- here("assets", "js", "stat.js")
jscode <- readLines(jspath, warn = FALSE)
json_df <- jsonlite::toJSON(
  data.frame(release = release_date, stat1 = stat1_num, stat2 = stat2_num), dataframe = "columns")
jscode[1] <- glue("var txt = '{json_df}';")
cat(jscode, sep = "\n", file = jspath)
