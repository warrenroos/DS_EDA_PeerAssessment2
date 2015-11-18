# plot1.R 

# as question requires preprocessing code to be in each of the plot r scripts, 
# it is included here as ### preprocessing code ### followed by a separate section 
# for ### plot code ### 

####################################################################
####################################################################
##################### preprocessing code ###########################
####################################################################
####################################################################

# pre-porcessing steps 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("..\\..\\Data\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("..\\..\\Data\\exdata_data_NEI_data\\Source_Classification_Code.rds")

# check unique values 
length(unique(NEI$SCC)) 
length(unique(SCC$SCC)) 

library(dplyr)
#library(plyr)

# look at some exploratory data items 
#SCC$SCC <- as.character(SCC$SCC)
head(SCC$SCC)
dim(SCC$SCC)
length(SCC$SCC)
class(SCC$SCC)
class(NEI$SCC)
class(SCC)
class(NEI)

# adjust ID field so it differs from the SCC table name 
myColnames <- colnames(SCC) 
myColnames[1] <- "SCCID" 
colnames(SCC) <- myColnames 

# adjust ID field so it differs from the SCC table name 
myColnames <- colnames(NEI) 
myColnames[2] <- "SCCID" 
colnames(NEI) <- myColnames 

# adjust year field colname 
myColnames <- colnames(NEI) 
myColnames[6] <- "Data.Year" 
colnames(NEI) <- myColnames 

# translate year column to a factor column 
# NEI$year <- as.factor(NEI$year)
#NEISCC$year <- as.factor(NEISCC$year)

# NEISCC <- arrange(join(NEI, SCC, id)) 
# NEISCC <- arrange(join(NEI, SCC, SCCID)) 
# NEISCC <- join(unlist(NEI$SCC), unlist(SCC$SCC), SCC)
# NEISCC <- merge.data.frame(NEI(NEI$SCC), unlist(SCC$SCC), SCC)

# Do the equivalent of a LEFT OUTER JOIN from SQL constructs... 
#   i.e. join the two datasets including all the observations even 
#   if the categorization lookup values are missing 
NEISCC = merge(x = NEI, y = SCC, by.x = "SCCID", by.y = "SCCID", x.all=TRUE)

# running out of memory... call garbage collection... 
gc()

# determine unique values 
unique(NEISCC$year) 
unique(NEISCC$Pollutant) 
unique(NEISCC$Data.Category) 
#unique(NEISCC$Short.Name) 
unique(NEISCC$SCC.Level.One) 
unique(NEISCC$SCC.Level.Two) 
unique(NEISCC$EI.Sector) 

#rename(NEISCC, Data.Year = year)

# summarize the data - group by Year
#NEISCC.GroupByYear <- ddply(NEISCC, "year", summarise, SumEmissions=sum(Emissions))
NEISCC.GroupByYear <- NEISCC %>% 
  group_by(Data.Year) %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  ) 

# summarize the data - group by Year, filter by fips == 24510 (Baltimore, MD)
NEISCC.GroupByYear.BMD <- NEISCC %>% 
  group_by(Data.Year) %>% 
  filter(fips == "24510") %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  )    

# summarize the data - group by Year and type, filter by fips == 24510 (Baltimore, MD)
NEISCC.EmissionsType.BMD <- NEISCC %>% 
  group_by(Data.Year, type) %>% 
  filter(fips == "24510") %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  )    

# summarize the data - group by Year and EI.Sector, filter by fips == 24510 (Baltimore, MD)
NEISCC.EISector.BMD <- NEISCC %>% 
  group_by(Data.Year, EI.Sector) %>% 
  filter(fips == "24510") %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  )    

# summarize the data - group by Year, filter by fips == 24510 (Baltimore, MD)
#   and on Coal-based items
NEISCC.Coal.BMD <- NEISCC %>% 
  group_by(Data.Year) %>% 
  filter(fips == "24510" & grepl("[Cc]oal", EI.Sector)) %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  ) 

# summarize the data - group by Year - all US 
#   and on Coal-based items
NEISCC.Coal.US <- NEISCC %>% 
  group_by(Data.Year) %>% 
  filter(grepl("[Cc]oal", EI.Sector)) %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  ) 

# summarize the data - group by Year, filter by fips == 24510 (Baltimore, MD)
#   and on Mobile On Road Gas (Motor Vehicle) - based items
NEISCC.MobileGas.BMD <- NEISCC %>% 
  group_by(Data.Year) %>% 
  filter(fips == "24510" & grepl("[Mm]obile - On-Road Gasoline", EI.Sector)) %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  ) 


# summarize the data - group by Year, filter by fips == 06037 (Los Angeles County, CA)
#   and on Mobile On Road Gas (Motor Vehicle) - based items
NEISCC.MobilGas.LAX <- NEISCC %>% 
  group_by(Data.Year) %>% 
  filter(fips == "06037" & grepl("[Mm]obile - On-Road Gasoline", EI.Sector)) %>% 
  summarize(
    sumEmissions = sum(Emissions, na.rm = TRUE) 
  ) 


####################################################################
####################################################################
######################### plot code ###############################
####################################################################
####################################################################

png("plot1.png", width = 480, height = 480, units = "px")

plot(
  x = NEISCC.GroupByYear$Data.Year, 
  y = NEISCC.GroupByYear$sumEmissions, 
  type = "l",
  main = "Total Emissions - PM2.5 vs. Year - US", 
  xlab = "Year", 
  ylab = "Total Emissions - PM2.5 (tons)"
)

dev.off()
 