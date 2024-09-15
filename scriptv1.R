library(readxl)
library(tidyverse)

HMHH_plot_list <- read_excel("HMHH_plot_list.xlsx")

plot <- HMHH_plot_list |>
  rename(plot_id = Plot_id)

HMHH_SOC <- read_excel("HMHH_SOC_LD_v1.xlsx",
                             sheet = "SOC")

hmhh_soc <- HMHH_SOC |>
  select(
    "plot_id",  "Column" ,  "Row" ,  "Plot_number", "layer",
          "Fresh mass from field form, g", "Tray empty mass g" ,                        
          "Sample+tray  dry mass g" , "Soil water content g g-1"    ,              
         "Soil water content ml ml-1 at 20C-25C","Volume of stones in sample ml",  
         "Total volume of composite sample cm3",  "bulk_density_g_per_cm3",                    
         "C concentr g cm-3" , "Layer C store kg m-2", "layer_c_t_per_ha"
    # ,"easting", "northing" , "lon", "lat", "Selected_for_Field", "Assessment"
         ) |>
  rename(soc = layer_c_t_per_ha) |>
## left join FRA plot tables for location, district, provinces
left_join(plot, by = "plot_id")

summary(hmhh_soc$soc)

HMHH_LD <- read_excel("HMHH_SOC_LD_v1.xlsx",
                       sheet = "LD")

hmhh_ld <- HMHH_LD |>
  select(
    "plot_id", "Column", "Row", "Plot_number","Nr of  litter sampling points",                
     "Litter total fresh mass g", "Litter sample fresh mass g", "Empty vessel g...11",                          
    "Vessel+litter dry mass g", "Litter sample Dry mass g", "Debris total fresh mass g",          
    "Debris sample fresh mass g", "Empty vessel g...16", "Vessel+debris dry mass g",                     
    "Debris sample dry mass g", "Litter Moisture Content g g-1", "Litter total dry mass g m-2",                  
    "Debris Moisture Content g g-1", "Litter C content g m-2",                   
    "Debris total dry mass g m-2", "Debris C content g m-2", 
    "Litter+debris total carbon content t ha-1"
    #, "easting","northing","lon", "lat","Selected_for_Field", "Assessment"    
  ) |>
  rename(ld_carbon = "Litter+debris total carbon content t ha-1") |>
  ## left join FRA plot tables for location, district, provinces
  left_join(plot, by = "plot_id")

summary(hmhh_ld$ld_carbon)

## calculate carbon content in soil layers

summary(hmhh_soc$soc)
