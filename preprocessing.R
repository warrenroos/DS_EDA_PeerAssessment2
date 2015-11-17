# pre-porcessing steps 
# -	Downloaded file from url 
#   o	Note due to folder / file length issue, renames file “house_power.txt”  
#   o	No other edits to the file made other than viewing in text editor 
# -	Opened in Text Editor 
#   o	Verified that there were no commas in the file 
#   o	Verified it was semi-colon delineated 
#   o	Verified Rows 
#    	2,075,261 
#   o	Verified Data Range 
#    	12/16/2006 - 11/26/2010 
# -	Noted from question 
#   o	Desired Date Range 
#    	2/1/2007 – 2/2/2007 
# -	In R Studio 
#   o	Did Date Diff on Start Date / End Date 
#    	1,441 days 
#   o	Did estimate of data points per day 
#    	2,075,261 / 1,441 ~= 1,440 
#   o	Did estimate of how many readings per day per problem 
#    	matches 60 * 24 for per minute measurements ~= 1,440 
#   o	Estimated per R calcs 
#    	Pre-Subset ~= 67,687 rows 
#    	Subset ~= 2,880 rows 
#    	Post-Subset ~=  2,006,133 rows 
#   o	Reading in subset (using above estimates as a guide / starting point and trial / error to get exact range 
#    	skip = 67,636 rows, with nrows = 2,880 rows 
# -	Used read.table to read into R Studio 
#      o	data.housePower <- read.table(
#            file = "house_power.txt", header = TRUE, sep = ";", na.strings = "?", 
#            skip = 66636, nrows = 2880, 
#            col.names = c("ReadDate", "ReadTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )
#          )
# -	viewed the resulting data.table 
#      o	double-check the resulting data to be processed 
# -	added columns with Date & Time format respectively to data.table per assignment recommendations 


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("..\\..\\Data\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("..\\..\\Data\\exdata_data_NEI_data\\Source_Classification_Code.rds")

# check unique values 
length(unique(NEI$SCC)) 
length(unique(SCC$SCC)) 

library(dplyr)
library(plyr)

SCC$SCC <- as.character(SCC$SCC)
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

# NEISCC <- arrange(join(NEI, SCC, id)) 
# NEISCC <- arrange(join(NEI, SCC, SCCID)) 
# NEISCC <- join(unlist(NEI$SCC), unlist(SCC$SCC), SCC)
# NEISCC <- merge.data.frame(NEI(NEI$SCC), unlist(SCC$SCC), SCC)

# Do the equivalent of a LEFT OUTER JOIN from SQL constructs... 
#   i.e. join the two datasets including all the observations even 
#   if the categorization lookup values are missing 
NEISCC = merge(x = NEI, y = SCC, by.x = "SCCID", by.y = "SCCID", x.all=TRUE)


# add Date formatted column for date 
# data.housePower <- mutate(data.housePower, ReadDate2 = as.Date(ReadDate, "%d/%m/%Y"))

# add Time formatted column for date 
# had to use cbind as mutate from dplyr does not support POSIXlt 
##data.housePower <- mutate(data.housePower, ReadTime2 = strptime(ReadTime, "%H:%M:%S"))
# data.housePower <- cbind(data.housePower, ReadTime2 = strptime(data.housePower$ReadTime, "%H:%M:%S"))

# Add Datetime column for time series plots... 
# data.housePower <- cbind(data.housePower, ReadDateTime6 = strptime(paste(data.housePower$ReadDate, data.housePower$ReadTime), "%d/%m/%Y %H:%M:%S"))
