using AlphaVantage,
     DataFrames, 
     StatsPlots, 
     Dates, 
     Statistics, 
     Distributions, 
     IterTools

client = AlphaVantage.GLOBAL[]
client.key = "0VS2G38H6PKP03GX"
AlphaVantage.GLOBAL[]

Tickers = ["SPY", "ADAEUR", "VWCE.DE", "EUNH.DE", "GUNR", "VNQ"]

SP500 = DataFrame(time_series_daily_adjusted("SPY")) 
ADA = DataFrame(time_series_daily_adjusted("ADAEUR")) 
ALL_WORLD = DataFrame(time_series_daily_adjusted("VWCE.DE")) 
GOV_BOND = DataFrame(time_series_daily_adjusted("EUNH.DE")) 
RES = DataFrame(time_series_daily_adjusted("GUNR"))
REAL_EST = DataFrame(time_series_daily_adjusted("VNQ"))

ADA
SP500
ALL_WORLD
GOV_BOND 
RES

portfolio = [ SP500,ADA, ALL_WORLD, GOV_BOND, RES, REAL_EST]

#calculate returns for each stock 
for x in portfolio 
    price = x[!,"close"]
    returns = zeros(0)
    for i=2:length(price) 
        r = (price[i]- price[i-1])/price[i-1]
        append!(returns, r)
    end 
    prepend!(returns, 0)
    x[!,"returns"] = returns 
end

#add all returns into one dataset 
port_returns = DataFrame()
for (x,y) in zip(portfolio, Tickers)
    port_returns[!,y] = x[!,"returns"]
end 

# calculate standard deviation and covariance of the returns 
std_dev = std.(eachcol(port_returns))
covar = cov(Matrix(port_returns))
corr = cor(Matrix(port_returns))




#= 
make random allocation on weights to see the tradof between risk and return 
Next plots all possible allocation to see total impact
In the end find optimal risk return combination  
=# 

#set weights 
w = [0.5, 0.05, 0.2, 0.1, 0.1, 0.05]

#calculate returns of the portfolio 
port_return = Matrix(port_returns)*w

mean(port_return)

#calculate variance of the profolio 
σ = 0
for i in eachindex(w), j in eachindex(w)
    x = w[i]*w[j]*covar[i,j]
    σ+=x 
end 


port_std = √σ