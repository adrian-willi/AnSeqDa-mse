library(fpp2) #yields the data sets a10 and other needed dependencies

#hint: clean your R session deleting any object with the shortcut
#command (or ctrl) + shift + f10
#so that your environment is clean

#generate three fake time series, each of lenght 30
mydata <- cbind(rnorm(30),rnorm(30),rnorm(30))

# Look at the first few lines of mydata
# Apply head() to mydata in the R console to inspect the first few lines of the data.
head(mydata)

#Create a ts object called myts
#ts will automatically add the date  field
#Its agruments are: start: first date, frequency= number of observations per year, i.e.,lenght of the seasonality
myts <- ts(mydata, start = c(1981, 1), frequency = 4)

# To find the number of observations per unit time, use frequency()
frequency(myts) #4

#notice that  myts now contains the dates and the quarter indication
myts

#three different plots, one for each time series
autoplot(myts, facets = TRUE)

#series overlapped on the same plot
autoplot(myts, facets = FALSE)

#plot an individual time series such as gold
autoplot(gold)
frequency(gold) #1: gold has no seasonality

##SEASONAL PLOTS
#the time series a10 is monthly; it covers 17 years.
frequency(a10) # 12 : monthly data
autoplot(a10) #one year after each other
ggseasonplot(a10)  #compares each month across different  years 
ggseasonplot(a10, polar=TRUE)  #compares each month across different  years, polar format 


#consider now the beer data set, which is also monthly
frequency(beer) #12
#for each month, plot the data of different years close to each other. The blu line indicates the mean 
ggsubseriesplot(beer)

#example of the window function
#select throught the window function only the data of the 1992
beer1992 <- window(beer, start = 1992)


##AUTO-CORRELATION ANALYIS
#consider the oil data set, which is a ts object (yearly data)
#plot the ACF graph, with in blue the significance threshold
#autocorrelation is significant in the first four lags
ggAcf(oil)

##AUTOCORELATION FOR A SEASONAL TIME SERIES
#hyndsight: number of visitors to R. Hyndman's blog, https://robjhyndman.com/
#plot the data and try to guess how the auto-correlation will look
autoplot(hyndsight)

#you might consider a subset of data for better visualization
#hyndsight contains daily data for 53 weeks. 
# Time Series:
# Start = c(40, 4) 
# End = c(53, 4) 
#means that the time series starts in the 4-th day of the week of week 40 and 
#end in the 4=-th day of the week of week 53
#Let us consider only  the last four weeks, starting from the 1-st day of the 49-th week
#up to the last day of week 52
hyndsightShort <- window(hyndsight, start = c(49,1), end=c(52,7))
autoplot(hyndsightShort)
#the weekly pattern is now very clear

#the autocorrelation function peaks at lags 7/14/21 etc
#this function both plots and return a struct of results
hyndsightAcf <- ggAcf(hyndsight)
#the actual autocorrelation data are in the Acf object, within the data frame "data"
which.max(hyndsightAcf$data$ACF)

#other examples: you can check that the monthly data of Australian beer sales ("ausbeer") have an ACF peaked in 4/8/12 etc.
frequency(ausbeer)#12
head(beer)#inspect the beginning of the time series
autoplot(beer)
ggAcf(ausbeer)

dgoog <- diff(goog)
ggAcf(dgoog)

fc_mean <- meanf(goog, h=20)
autoplot(fc_mean)

fc_snaive <- snaive(goog, h=20)
autoplot(fc_snaive)

fc_naive <- naive(goog, h=20)
autoplot(fc_naive)

fc_drift <- rwf(goog, h=20, drift=TRUE)
autoplot(fc_drift)

fc_mean <- meanf(auscafe, h=20)
autoplot(fc_mean)

fc_snaive <- snaive(auscafe, h=20)
autoplot(fc_snaive)

fc_naive <- naive(auscafe, h=20)
autoplot(fc_naive)

fc_drift <- rwf(auscafe, h=20, drift=TRUE)
autoplot(fc_drift)

Box.test(res, lag = 10, fitdf = 0, type = "Lj")
checkresiduals(naive(goog200))

beer <- window(ausbeer, start=1992)
ggAcf(beer)
fc <- snaive(beer)
autoplot(fc)

checkresiduals(fc)
