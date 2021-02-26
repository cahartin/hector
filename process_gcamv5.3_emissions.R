
#1. process future emissions to get into Hector format
fut_emis <- read.csv("gcam-v5.3-climate-log.csv", header =T, sep = ",") %>% 
  # add "_emissions" to gas names
  mutate(gas=paste0(gas, "_emissions")) %>% 
  spread(gas, emissions) %>% 
  print(head()) %>% 
  
  ## Rename a few columns to match Hector
  rename( "ffi_emissions" = "CO2_emissions") %>% 
  rename( "luc_emissions" = "CO2NetLandUse_emissions") %>%
  rename( "NMVOC_emissions" = "NMVOCs_emissions") %>% 
  rename( "SO2_emissions" ="SO2tot_emissions") %>% 
  rename( "NOX_emissions" ="NOx_emissions") %>% 
  rename( "Date" = "year")

# NEED TO convert LUC NA's to zero after 2060
# then drop NAs every 5 years

  write.table(fut_emis,'gcam_v5.3_emissions.csv',sep=",",append=TRUE, row.names=FALSE)
