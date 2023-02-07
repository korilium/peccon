using AlphaVantage,
     DataFrames, 
     StatsPlots, 
     Dates, 
     Statistics, 
     Distributions, 
     IterTools, 
     Plots


client = AlphaVantage.GLOBAL[]
client.key = "0VS2G38H6PKP03GX"
AlphaVantage.GLOBAL[]

Tickers = ["SPY", "ADAEUR", "VWCE.DE", "EUNH.DE", "GUNR", "VNQ"]
days = 750
SP500 = DataFrame(time_series_daily_adjusted("SPY", outputsize= "full"))
ADA = DataFrame(time_series_daily_adjusted("ADAEUR", outputsize= "full"))
ALL_WORLD = DataFrame(time_series_daily_adjusted("VWCE.DE", outputsize= "full"))
GOV_BOND = DataFrame(time_series_daily_adjusted("EUNH.DE", outputsize= "full"))
RES = DataFrame(time_series_daily_adjusted("GUNR", outputsize= "full"))
REAL_EST = DataFrame(time_series_daily_adjusted("VNQ", outputsize= "full"))






SP500   = SP500[1:500, :] 
ADA  = ADA[1:500,:]
ALL_WORLD = ALL_WORLD[1:500,:]
GOV_BOND =  GOV_BOND[1:500,:]
RES = RES[1:500,:]
REAL_EST = REAL_EST[1:500,:] 

portfolio = [ SP500,
              ADA, 
                ALL_WORLD,
                GOV_BOND, 
                RES,
                REAL_EST
                ]

#calculate returns for each stock 
for x in portfolio 
    price = x[!,"close"]
    returns = zeros(0)
    for i=2:length(price) 
        r = log(price[i]/price[i-1])
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
make random allocation on weights to see the trade-off between risk and return 
Next plot all possible allocation to see total impact
In the end find optimal risk return combination  
=# 


port = DataFrame(exp_return = Float64[],
                    port_var = Float64[], 
                    w_SPY = Float64[],
                    w_ADAEUR = Float64[],
                    w_VWCE = Float64[],
                    w_EUNH = Float64[],
                    w_GUNR = Float64[],
                    w_VNQ = Float64[]
                    )


i = 1;

while i <= 50000
    #set weights 
    weights = rand(length(portfolio))
    total = sum(weights)

    w = weights/total

    #calculate returns of the portfolio 
    port_return = Matrix(port_returns)*w

    expected_return = mean(port_return)*250

    #calculate variance of the profolio 
    σ = 0
    for i in eachindex(w), j in eachindex(w)
        x = w[i]*w[j]*covar[i,j]
        σ+=x 
    end 

    port_var = √(σ*250)

    list = [expected_return, port_var, w]
    #decompose 
    results = collect(Iterators.flatten(list))

    push!(port, results )
    i += 1
end 


@df port scatter(:port_var, :exp_return)


rf = 0.0461

port[:, :sharp_ratio] = (port[:,:exp_return] .- rf )./port[: , :port_var]

sort!(port, :sharp_ratio)