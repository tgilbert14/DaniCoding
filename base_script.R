## base script

library(neonUtilities)
library(tidyverse)

## DPID's Start for neon data ----
##Plant presence and percent cover
dp_plant_cover <- "DP1.10058.001"
##Plant foliar traits
dp_plant_foliar <- "DP1.10026.001"
##Plant foliar stable isotopes
dp_plant_isotopes <- "DP1.10053.001"
## DPID's Stop ----

plant_foliar_data.raw<- neonUtilities::loadByProduct(dp_plant_foliar,
                                                     site = "SRER",
                                                     startdate = "2020-01",
                                                     enddate = "2022-12",
                                                     check.size = F)
length(plant_foliar_data.raw)
class(plant_foliar_data.raw)

plant_foliar_data.raw$categoricalCodes_10026
View(plant_foliar_data.raw)