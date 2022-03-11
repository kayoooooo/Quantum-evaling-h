library("ggplot2")
library("dplyr")

wavelength = c(635,590,560,480)
dat = data.frame(wavelength)
dat$wavelength = dat$wavelength * 10 ** (-9)
dat = mutate(dat, freq = 299792458/dat$wavelength)
voltage = c(1.416,1.615,1.662,1.874)
dat = mutate(dat, voltage)

ggplot(dat, aes(x = freq, y = voltage)) + 
  geom_point()

print(lm(voltage ~ dat$freq))