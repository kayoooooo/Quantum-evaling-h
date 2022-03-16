library("ggplot2")
library("dplyr")

wavelength = c(635,590,560,480)
dat = data.frame(wavelength)
dat$wavelength = dat$wavelength * (10 ** (-9))
dat = mutate(dat, freq = 299792458/dat$wavelength)
voltage = c(1.416,1.615,1.662,1.874)
dat = mutate(dat, voltage)
dat = mutate(dat, tolerance = c(15,15,15,40) * (10**(-9)))
dat = mutate(dat, minfreq = 299792458 / (dat$wavelength + dat$tolerance))
dat = mutate(dat, maxfreq = 299792458 / (dat$wavelength - dat$tolerance))

ggplot(dat, aes(x = freq, y = voltage)) + 
  xlab("Frequency (Hz)") + 
  ylab("Voltage (V)") + 
  geom_point() + 
  geom_point(data = dat, mapping = aes(x = minfreq, y = voltage, col = "red")) + 
  geom_point(data = dat, mapping = aes(x = maxfreq, y = voltage, col = "blue"))

print(lm(voltage ~ dat$freq))
print(lm(voltage ~ dat$minfreq))
print(lm(voltage ~ dat$maxfreq))