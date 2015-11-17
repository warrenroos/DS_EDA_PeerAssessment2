# plot3.R 


# please see PDF entitled "DS EDA - Proj 1 - Analysis Steps....pdf" 
# please see preprocessing.R script 
#   data loaded into a data.table names data.housePower 
#   data already subsetted 
#   preprocessing steps originally not included in every R script file as redundant and 
#   the same for all 4 plots hence, once the preprocessing.R script is run once, 
#   all 4 plots can be generated through simple plot commands.  

# as question requires preprocessing code to be in each of the 4 plot r scripts, 
# it is included here as ### preprocessing code ### followed by a separate section 
# for ### plot 3 code ### 

####################################################################
####################################################################
##################### preprocessing code ###########################
####################################################################
####################################################################



####################################################################
####################################################################
######################### plot 3 code ###############################
####################################################################
####################################################################
 

png("plot3.png", width = 480, height = 480, units = "px")

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

dev.off()
