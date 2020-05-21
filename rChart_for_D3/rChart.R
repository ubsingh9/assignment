require(devtools)
install_github("rCharts", "ramnathv")
require(rCharts)


r1 <- rPlot(mpg ~wt , data= mtcars, type = 'point')
r1

# NVD3
hair_eye <- as.data.frame(HairEyeColor)
p2 <- nPlot(Freq ~ Hair, group = 'Eye', data = subset(hair_eye, Sex == "Female"), type = 'multiBarChart' )
p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
p2

# Morris
data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1

#2.1.4 Highcharts
h1 <- hPlot(x = "Wr.Hnd", y = "NW.Hnd", data = MASS::survey, type = c("line", "bubble", "scatter"), group = "Clap", size = "Age" )
h1
