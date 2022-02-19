library(quantmod)

tips30 <- get(getSymbols('DFII30', src='FRED')) # Market Yield on U.S. Treasury Securities at 30-Year Constant Maturity, Inflation-Indexed
tips20 <- get(getSymbols('DFII20', src='FRED')) # Market Yield on U.S. Treasury Securities at 20-Year Constant Maturity, Inflation-Indexed
tips10 <- get(getSymbols('DFII10', src='FRED')) # Market Yield on U.S. Treasury Securities at 10-Year Constant Maturity, Inflation-Indexed
tips07 <- get(getSymbols('DFII7', src='FRED'))  # Market Yield on U.S. Treasury Securities at 7-Year Constant Maturity, Inflation-Indexed
tips05 <- get(getSymbols('DFII5', src='FRED'))  # Market Yield on U.S. Treasury Securities at 5-Year Constant Maturity, Inflation-Indexed

# plot(tips05, ylim=c(-2,5))
# lines(tips07, col=2)
# lines(tips10, col=3)
# lines(tips20, col=4)
# lines(tips30, col=5)
# 
# lines(ibond_rates_daily.xts,lty=2, col='blue' , lwd=2)
