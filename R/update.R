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

ggsave(here("assets", "img", "comparison.png"), width = 5, height = 4)
