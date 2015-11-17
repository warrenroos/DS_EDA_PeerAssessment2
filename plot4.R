# plot4.R 


# please see PDF entitled "DS EDA - Proj 1 - Analysis Steps....pdf" 
# please see preprocessing.R script 
#   data loaded into a data.table names data.housePower 
#   data already subsetted 
#   preprocessing steps originally not included in every R script file as redundant and 
#   the same for all 4 plots hence, once the preprocessing.R script is run once, 
#   all 4 plots can be generated through simple plot commands.  

# as question requires preprocessing code to be in each of the 4 plot r scripts, 
# it is included here as ### preprocessing code ### followed by a separate section 
# for ### plot 4 code ### 

####################################################################
####################################################################
##################### preprocessing code ###########################
####################################################################
####################################################################


####################################################################
####################################################################
######################### plot 4 code ###############################
####################################################################
####################################################################

 

png("plot4.png", width = 480, height = 480, units = "px")

# create a 2 x 2 grid for the 4 plots 
par(mfcol = c(2,2), mar = c(4,4,2,1))

# note - 2 of the plots are from before - would functionalize, but 
# questions imply all code must be self-contained in each plot R script 

# plot2 - here placed Row 1, Column 1 
plot(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Global_active_power, 
  type = "l",
  xlab = "", 
  ylab = "Global Active Power"
)

# plot 3 - here placed Row 2, Column 1 
plot(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Sub_metering_1, 
  type = "n", 
  xlab = "", 
  ylab = "Energy sub metering" 
)

legend(
  "topright", pch = NULL, lty = 1, lwd = 2, 
  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  , bty = "o", y.intersp = 1
)

points(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Sub_metering_1, 
  type = "l", col = "black" 
)

points(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Sub_metering_2, 
  type = "l", col = "red" 
)

points(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Sub_metering_3, 
  type = "l", col = "blue" 
)

# plot-new - here placed Row 1, Column 2 
plot(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Voltage, 
  type = "l",
  xlab = "datetime", 
  ylab = "Voltage"
)

# plot-new - here placed Row 2, Column 2 
plot(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Global_reactive_power, 
  type = "l",
  xlab = "datetime", 
  ylab = "Global_reactive_power"
)

dev.off()
