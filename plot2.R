# plot2.R 


# please see PDF entitled "DS EDA - Proj 1 - Analysis Steps....pdf" 
# please see preprocessing.R script 
#   data loaded into a data.table names data.housePower 
#   data already subsetted 
#   preprocessing steps originally not included in every R script file as redundant and 
#   the same for all 4 plots hence, once the preprocessing.R script is run once, 
#   all 4 plots can be generated through simple plot commands.  

# as question requires preprocessing code to be in each of the 4 plot r scripts, 
# it is included here as ### preprocessing code ### followed by a separate section 
# for ### plot 2 code ### 

####################################################################
####################################################################
##################### preprocessing code ###########################
####################################################################
####################################################################



####################################################################
####################################################################
######################### plot 2 code ###############################
####################################################################
####################################################################
 

png("plot2.png", width = 480, height = 480, units = "px")

plot(
  x = data.housePower$ReadDateTime6, 
  y = data.housePower$Global_active_power, 
  type = "l",
  xlab = "", 
  ylab = "Global Active Power (kilowatts)"
)

dev.off()
