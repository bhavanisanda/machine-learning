library(plotly)
library(arules)
library(arulesViz)
library(RColorBrewer)
library(datasets)

# Load the dataset.
data('Groceries')

str(Groceries)

class(Groceries)

data <- as.matrix(Groceries@data)
rownames(data) <- Groceries@itemInfo$labels
data

head(Groceries@itemInfo,n=10)

summary(Groceries)

rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.80))

summary(rules)

# Show the top 10 rules, but only 2 digits
options(digits=2)
inspect(rules[1:10])

rules_sorted <- sort(rules, by="confidence", decreasing=TRUE)

# Show the top 20 rules, but only 2 digits
inspect(rules_sorted[1:20])

rules_new <- apriori(Groceries, 
                     parameter = list(supp = 0.001, 
                                      conf = 0.8, 
                                      maxlen=3))

arules::itemFrequencyPlot(Groceries,
                          topN=20,
                          col=brewer.pal(8,'Dark2'),
                          main='Absolute Item Frequency Plot',
                          type="absolute",
                          ylab="Item Frequency (Absolute)")

arules::itemFrequencyPlot(Groceries,
                          topN=20,
                          col=brewer.pal(8,'Dark2'),
                          main='Relative Item Frequency Plot',
                          type="relative",
                          ylab="Item Frequency (Relative)")

# Limit rules to top 20.
subrules2 <- rules[1:20]
plot(subrules2, method="graph")

plot(rules[1:20],
     method = "paracoord",
     control = list(reorder = TRUE))

arulesViz::plotly_arules(rules)

Groceries

Subset <- Groceries[,itemFrequency(Groceries)>0.1]

Subset

rules <- apriori(Subset, parameter = list(sup = 0.005, conf = 0.5))

inspect(rules)

subrules3 <- rules
plot(subrules3, method="graph")
