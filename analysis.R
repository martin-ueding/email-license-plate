#!/usr/bin/Rscript

library(dplyr)
library(ggplot2)
library(magrittr)
library(tidyr)

data <- read.csv('license_plates.csv', row.names = 1)

data %<>%
    separate(license_plate, c('city', 'number'), ' ', remove = FALSE) %>%
    separate(date, c('ymd', 'hms'), ' ', remove = FALSE) %>%
    separate(ymd, c('year', 'month', 'day'), '-') %>%
    filter(nchar(city) <= 3)

counts <- data %>%
    group_by(license_plate) %>%
    summarize(count = n()) %>%
    arrange(desc(count))

#ggplot(filter(counts, count > 1), aes(x = license_plate, y = count)) +
#    geom_col() +
#    coord_flip() +
#    labs(title = 'Wiederholungstäter',
#         x = 'Kennzeichen',
#         y = 'Anzahl Anzeigen')

png('plot-%d.png', res = 300, width = 7, height = 7, units = 'in')

ggplot(data, aes(x = city)) +
    geom_bar() +
    coord_flip() +
    labs(title = 'Verteilung nach Städten',
         x = 'Stadt',
         y = 'Anzahl Anzeigen')

ggplot(data, aes(x = interaction(year, month, lex.order = TRUE))) +
    geom_bar() +
    coord_flip() +
    labs(title = 'Verteilung nach Monaten',
         x = 'Jahr.Monat',
         y = 'Anzahl Anzeigen')

meta_counts <- counts %>%
    group_by(count) %>%
    summarize(meta_count = n())

ggplot(meta_counts, aes(x = count, y = meta_count)) +
    geom_col() +
    geom_label(aes(y = meta_count + max(meta_count) * 0.05, label = meta_count)) +
    labs(title = 'Wie häufig sind Wiederholungstäter?',
         x = 'Anzahl Anzeigen für festes Nummernschild',
         y = 'Häufigkeit')

dev.off()
