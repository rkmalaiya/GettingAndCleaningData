Data <- data.frame(vote = sample(c(1,2,3,8,9,97,99),size=300,replace=TRUE),
                 region = sample(c(rep(1,3),rep(2,2),3,99),size=300,replace=TRUE),
                 income = exp(rnorm(300,sd=.7))*2000)



Data <- within(Data,{
  description(vote) <- "Vote intention"
  description(region) <- "Region of residence"
  description(income) <- "Household income"
  wording(vote) <- "If a general election would take place next tuesday,
  the candidate of which party would you vote for?"
  wording(income) <- "All things taken into account, how much do all
  household members earn in sum? hi"
  
})


codebook(Data)
