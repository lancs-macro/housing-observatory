library(tidyverse)
library(lubridate)

# Download dashboardthemes functions --------------------------------------

download.file("https://raw.githubusercontent.com/nik01010/dashboardthemes/master/R/dashboardthemes.R", 
              "R/dashboardthemes-functions.R")


# Download shapefiles

download.file("http://geoportal1-ons.opendata.arcgis.com/datasets/01fd6b2d7600446d8af768005992f76a_4.zip",
        destfile = "data/nuts1/Shapefile.zip")
zip::unzip("data/nuts1/Shapefile.zip", exdir = "data/nuts1")


download.file("http://geoportal1-ons.opendata.arcgis.com/datasets/48b6b85bb7ea43699ee85f4ecd12fd36_4.zip",
              destfile = "data/nuts2/Shapefile.zip")
zip::unzip("data/nuts2/Shapefile.zip", exdir = "data/nuts2")


download.file("http://geoportal1-ons.opendata.arcgis.com/datasets/473aefdcee19418da7e5dbfdeacf7b90_4.zip",
              destfile = "data/nuts3/Shapefile.zip")
zip::unzip("data/nuts3/Shapefile.zip", exdir = "data/nuts3")


# Exuber ------------------------------------------------------------------

library(here)
source(here("R", "00-functions.R"))
source(here("R", "01-read.R"))

# Create variables in appropriate format ----------------------------------

price <- ntwd_data %>% 
  select(Date, region, rhpi) %>% 
  spread(region, rhpi)

afford <- ntwd_data %>% 
  select(Date, region, afford) %>% 
  spread(region, afford)

# Estimation & Critical Values --------------------------------------------

library(exuber)

radf_price <- price %>%
  radf(lag = 1, minw = 37)

radf_afford <- 
  price_afford %>%
  radf(lag = 1, minw = 37)

cv_price <- mc_cv(NROW(price), opt_bsadf = "conservative", minw = 37)

cv_afford <- mc_cv(NROW(afford), opt_bsadf = "conservative", minw = 37)

# Summary -----------------------------------------------------------------

summary_price <- 
  radf_price %>% 
  summary(cv = cv_price)

summary_afford <- 
  radf_afford %>% 
  summary(cv = cv_afford)

# diagnostics -------------------------------------------------------------

rejected_price <- 
  radf_price %>% 
  diagnostics(cv = cv_price) %>% 
  .$rejected

rejected_afford <- 
  radf_afford %>% 
  diagnostics(cv = cv_afford) %>% 
  .$rejected

# datestamp ---------------------------------------------------------------

datestamp_price <- 
  radf_price %>%
  datestamp(cv = cv_price)

datestamp_afford <- 
  radf_afford %>%
  datestamp(cv = cv_afford)

# afford ------------------------------------------------------------------

autoplot_price <- 
  radf_price %>%
  autoplot(include = TRUE, cv = cv_price, arrange = FALSE) %>%
  map( ~.x + scale_custom(object = fortify(radf_price, cv = cv_price)) +
         theme(title = element_blank()))

autoplot_afford <- 
  radf_afford %>%
  autoplot(include = TRUE, cv = cv_afford, arrange = FALSE) %>%
  map( ~.x + scale_custom(object = fortify(radf_price, cv = cv_price)) +
         theme(title = element_blank()))

# autoplot datestamp ------------------------------------------------------

autoplot_datestamp_price <-
  datestamp_price %>%  
  autoplot(cv = cv_price) +
  scale_custom(fortify(radf_price, cv = cv_price)) + 
  scale_color_viridis_d()

autoplot_datestamp_afford <- 
  datestamp_afford %>% 
  autoplot(cv = cv_afford) + 
  scale_custom(fortify(radf_price, cv = cv_price)) + 
  scale_color_viridis_d()

# Overwrite datestamp --------------------------------------------------------

index_yq <- extract_yq(fortify(radf_price, cv = cv_price)) # Remake into yq

ds_yq <- function(ds) {
  start <- ds[, 1]
  start_ind <- which(index_yq$breaks %in% start)
  start_label <- index_yq[start_ind ,2]
  
  end <- ds[, 2]
  end_ind <- which(index_yq$breaks %in% end)
  if (anyNA(end)) end_ind <- c(end_ind, NA)
  end_label <- index_yq[end_ind ,2]
  
  ds[, 1] <- start_label 
  ds[, 2] <- end_label
  ds
}

datestamp_price_mod <-
  datestamp_price %>% 
  map(ds_yq)

datestamp_afford_mod <- 
  datestamp_afford %>% 
  map(ds_yq)

# Plotting ----------------------------------------------------------------

ind <- exuber::index(radf_price, trunc = TRUE)
ind2 <- exuber::index(radf_afford, trunc = TRUE)

# Price
plot_price <- list()
for (i in seq_along(nms$names)) {
  
  shade <- datestamp_price %>% "[["(nms$names[i])
  
  plot_price[[i]] <- 
    filter(price, Date <= ind[1]) %>% 
    ggplot() +
    geom_line(aes_string(x = "Date", y = as.name(nms$names[i])),
              size = 0.7, colour = "black") +
    scale_custom(object = fortify(radf_price, cv = cv_price)) +
    # geom_smooth(method = "lm", se = FALSE,
    #             aes_string("Date", as.name(slide_names[i]))) +
    theme_light() +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank()) +
    geom_rect(data = shade[, -3], fill = "grey", alpha = 0.35, #0.25
              aes_string(xmin = "Start", xmax = "End",
                         ymin = -Inf, ymax = +Inf))
}
names(plot_price) <- col_names(radf_price)

#afford
plot_afford <- list()
for (i in seq_along(slider_names)) {
  
  shade <- datestamp_afford %>% "[["(slider_names[i])
  
  plot_afford[[i]] <- ggplot(rhp_pdi) +
    geom_line(aes_string(x = "Date", y = as.name(slider_names[i])),
              size = 0.7, colour = "black") +
    scale_custom(object = fortify(radf_afford, cv = cv_afford)) +
    # geom_smooth(method = "lm", se = FALSE,
    #             aes_string("Date", as.name(slide_names[i]))) +
    theme_light() +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  if (!is.null(shade))
    plot_afford[[i]] <- plot_afford[[i]] + 
    geom_rect(data = shade[, -3], fill = "grey", alpha = 0.35, #0.25
              aes_string(xmin = "Start", xmax = "End",
                         ymin = -Inf, ymax = +Inf))
}
names(plot_afford) <- col_names(radf_afford)


# Make bsadf dataframe ----------------------------------------------------



price_bsadf_table <-
  radf_price %>%
  "[["("bsadf") %>% 
  as.tibble() %>%
  bind_cols(`Critical Values` = cv_price$bsadf_cv[-1, 2]) %>% 
  bind_cols(Date = ind) %>% 
  select(Date, `Critical Values`, UK, everything())

afford_bsadf_table <- 
  radf_afford %>%
  "[["("bsadf") %>% 
  as.tibble() %>%
  bind_cols(`Critical Values` = cv_afford$bsadf_cv[-1, 2]) %>% 
  bind_cols(Date = ind2) %>% 
  select(Date, `Critical Values`, UK, everything())


cv <- crit[[NROW(rhpi)]]

stat_table <- 
  tibble(
    Regions = slider_names,
    gsadf_rhpi = radf_price$gsadf,
    gsadf_hpi_dpi = radf_afford$gsadf,
    gsadf_cv90 = cv$gsadf_cv[1],
    gsadf_cv95 = cv$gsadf_cv[2],
    gsadf_cv99 = cv$gsadf_cv[3]
  )


# store -------------------------------------------------------------------
library(glue)

items <- c("price", "afford")
store <- c(items, glue("cv_{items}"), glue("autoplot_datestamp_{items}"), glue("radf_{items}"))

path_store <- paste0("data/RDS/", store, ".rds")

for (i in seq_along(store)) saveRDS(get(store[i]), file = path_store[i], "xz")
