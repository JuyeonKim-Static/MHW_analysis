library(raster)
library(RNetCDF)
library(ncdf4)
library(dplyr)
library(heatwaveR)

ncfile <- nc_open('OSTIA_1982_01_01_2021_12_31.nc')
latitude <- ncvar_get(ncfile, "lat")
longitude <- ncvar_get(ncfile, "lon")
time_var <- ncvar_get(ncfile, "time")
time_posix <- as.POSIXct(time_var, origin = "1981-01-01", tz = "UTC")
time_posix <- format(time_posix, format = "%Y-%m-%d")
sst_var <- ncvar_get(ncfile, "analysed_sst")


#Caution!!!! This code spends a lot of time (more than 3 hours)
lat_ex <- ncvar_get(ncfile, "lat")
long_ex<- ncvar_get(ncfile, "lon")
result_mhw_event <- data.frame()
for (i in 1:length(lat_ex)){
  for (j in 1: length(long_ex)){
    df <- data.frame()
    df_new <- data.frame()
    df <- data.frame( lat = lat_ex[i], lon = long_ex[j], t = time_posix,
                      temp = sst_var[ j, i ,])
    df_new <- df[c("t", "temp")]
    df_new$t <- as.Date(df_new$t, format =  "%Y-%m-%d")
    ts <- ts2clm(df_new, climatologyPeriod = c("1982-01-01", "2021-12-31"))
    mhw <- detect_event(ts)
    mhw_event  <-mhw$event
    mhw_event$lat  <-lat_ex[i]
    mhw_event$long  <-long_ex[j]
    result_mhw_event <- rbind(result_mhw_event, mhw_event)
  }
}
#write.csv(result_mhw_event, file = "mhw_event_all.csv", row.names = FALSE)
#This data is for MHW_clustering_kmeans.ipynb and EDA_mhw_event_all.ipynb.
#Since it's a large dataset, 
# I uploaded the dataset to Google Drive and conducted the analysis in Google Colab.
