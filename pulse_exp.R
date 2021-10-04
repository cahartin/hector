# Run pulse experiments for
# SSP245, 370
# 1 Gt of CO2
# 1 MT of CH4
# 1 MT(N) for N20
# pulse in 2030 out to 2300

# CH
# 10/04/2021

# Run reference cases and save output
library(devtools)
library(tidyr)
library(dplyr)

devtools::load_all("C:/Users/chartin/OneDrive - Environmental Protection Agency (EPA)/Documents/GitHub/hector")

library(hector)

ini_file <- system.file("input/hector_ssp245.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

ref_ssp245 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP245") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

#### Ref SSP370

ini_file <- system.file("input/hector_ssp370.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

ref_ssp370 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP370") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

# combine reference runs together

reference <- rbind(ref_ssp245, ref_ssp370)

#### CO2 pulse ####

ini_file <- system.file("input/hector_ssp370_pulse_CO2.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp370_CO2 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP370_CO2") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

ini_file <- system.file("input/hector_ssp245_pulse_CO2.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp245_CO2 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP245_CO2") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

pulse_CO2 <- rbind(pulse_ssp245_CO2, pulse_ssp370_CO2)

#### CH4 pulse ####

ini_file <- system.file("input/hector_ssp245_pulse_CH4.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp245_CH4 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP245_CH4") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))


ini_file <- system.file("input/hector_ssp370_pulse_CH4.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp370_CH4 <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP370_CH4") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

pulse_CH4 <- rbind(pulse_ssp245_CH4, pulse_ssp370_CH4)


#### N2O pulse ####

ini_file <- system.file("input/hector_ssp245_pulse_N2O.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp245_N2O <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP245_N2O") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))


ini_file <- system.file("input/hector_ssp370_pulse_N2O.ini", package="hector")
core<- newcore(ini_file)
core
run(core)

pulse_ssp370_N2O <- fetchvars(core, 1850:2300) %>%
    mutate(scenario = "SSP370_N2O") %>%
    filter(variable %in% c("Ca", "Ftot", "Tgav"))

pulse_N2O <- rbind(pulse_ssp245_N2O, pulse_ssp370_N2O)


# combine them all up into 1 file an save
combined <- rbind(pulse_CH4, pulse_CO2, pulse_N2O, reference)
write.csv(combined, file = "Hector_pulse_exp.csv", row.names = F)
