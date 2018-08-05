#!/usr/bin/Rscript

library(ggplot2)

data <- read.csv('license_plates.csv', row.names = 1)
print(data)
