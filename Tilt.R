# Load necessary libraries
library(readr)
library(knitr)
library(DT)
library(kableExtra)
library(rmarkdown)

#Set working directory to folder with Trackman file
setwd("~/Desktop/Wareham/Data/Games")

# Change
df <- read.csv("20240731-CCBLBourne-1_unverified.csv") 
date <- "2024_07_31"
opp <- "Bourne"

# Replace "TwoSeamFastball" and "FourSeamFastball" with "Fastball"
df2 <- df %>%
  mutate(TaggedPitchType = ifelse(TaggedPitchType %in% c("TwoSeamFastBall", "FourSeamFastBall"), 
                                  "Fastball", TaggedPitchType))

fastball_only <- filter(df2, TaggedPitchType %in% c("Fastball", "Sinker"))
# Build Count Column
fastball_only$Count <- paste(fastball_only$Balls, fastball_only$Strikes, sep = "-")

#Filter for desired team
gatemen = filter(fastball_only, PitcherTeam == "WAR_GAT") %>% select(Pitcher, TaggedPitchType, Tilt, Batter, Count)

#Output to a folder with the day's reports
dir.create(paste0("~/Desktop/Wareham/Data/Reports/", date, "_", opp), recursive = TRUE)
setwd(paste0("~/Desktop/Wareham/Data/Reports/", date, "_", opp))
kable(gatemen, format = "latex") %>%
  save_kable(paste0("Tilt_", date, "_", opp, ".pdf"))

