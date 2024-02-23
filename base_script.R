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
#length(plant_foliar_data.raw)
#class(plant_foliar_data.raw)

#plant_foliar_data.raw$categoricalCodes_10026
#View(plant_foliar_data.raw)

d1<- (plant_foliar_data.raw$cfc_carbonNitrogen)
d2<- (plant_foliar_data.raw$cfc_chemistrySubsampling)
d3<- (plant_foliar_data.raw$cfc_chlorophyll)
d4<- (plant_foliar_data.raw$cfc_elements)
d5<- (plant_foliar_data.raw$cfc_fieldData)
d6<- (plant_foliar_data.raw$cfc_lignin)
d7<- (plant_foliar_data.raw$cfc_LMA)
d8<- (plant_foliar_data.raw$cfc_shapefile)
d9<- (plant_foliar_data.raw$issueLog_10026)

View(info)
ncol(info)
info<- tapply(d3$analyticalRepNumber, d3$namedLocation, sum)
info2<- as.data.frame.table(info)

info2<- info2 %>% 
  arrange(Var1)

View(d5)

## max/min 1
max1<- as.data.frame.table(tapply(d5$subsample1Height, d5$namedLocation, max))
min1<- as.data.frame.table(tapply(d5$subsample1Height, d5$namedLocation, min))
max1<- as.data.frame(max1)
min1<- as.data.frame(min1)

names(max1)[2] <- "max1"
names(min1)[2] <- "min1"

a<- full_join(min1, max1, by="Var1")

## max/min 2
max2<- as.data.frame.table(tapply(d5$subsample2Height, d5$namedLocation, max))
min2<- as.data.frame.table(tapply(d5$subsample2Height, d5$namedLocation, min))
max2<- as.data.frame(max2)
min2<- as.data.frame(min2)

names(max2)[2] <- "max2"
names(min2)[2] <- "min2"

b<- full_join(min2, max2, by="Var1")

## max/min 3
max3<- as.data.frame.table(tapply(d5$subsample3Height, d5$namedLocation, max))
min3<- as.data.frame.table(tapply(d5$subsample3Height, d5$namedLocation, min))
max3<- as.data.frame(max3)
min3<- as.data.frame(min3)

names(max3)[2] <- "max3"
names(min3)[2] <- "min3"

c<- full_join(min3, max3, by="Var1")

d<- full_join(a, b, by="Var1")

min_max_check_by_plot<- full_join(d, c, by="Var1")

names(min_max_check_by_plot)[1]<- "Sample Heights by NamedLocation"

View(min_max_check_by_plot)


View(d5)

#info_d5<- tapply(d5$)
info2_d5<- as.data.frame.table(info_d5)

info2_d5<- info2_d5 %>% 
  arrange(Var1)



