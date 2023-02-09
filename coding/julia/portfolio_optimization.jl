using AlphaVantage,
     DataFrames, 
     StatsPlots, 
     Dates, 
     Statistics, 
     Distributions, 
     IterTools, 
     Plots

function fin_data(Tickers, days= 500, clientKey = "0VS2G38H6PKP03GX" )

    #extract the data 
    client = AlphaVantage.GLOBAL[]
    client.key = clientKey
    AlphaVantage.GLOBAL[]
    portfolio = []
    for i in Tickers 
        asset = DataFrame(time_series_daily_adjusted( i, outputsize= "full"))
        asset = asset[1:days,:]
        push!(portfolio, asset)
    end 
    return portfolio
end 

function calc_returns(portfolio)
    #calculate returns for each stock 
    for x in portfolio 
        price = x[!,"close"]
        returns = zeros(0)

        for i=2:length(price) 
            r = log(price[i]/price[i-1])
            append!(returns, r)
        end 
        #add null in the beginning of each column 
        prepend!(returns, 0) 
        x[!,"returns"] = returns # add to dataframe
    end

    #add all returns into one dataset 
    port_returns = DataFrame()
    for (x,y) in zip(portfolio, Tickers)
        port_returns[!,y] = x[!,"returns"]
    end 
    return port_returns
end 

#= 
make random allocation on weights to see the trade-off between risk and return 
Next plot all possible allocation to see total impact
In the end find optimal risk return combination  
=# 
function mpt(returns, simulations= 5000 )

    names_stock= names(port_returns)
    port = DataFrame(exp_return = Float64[],
                    port_var = Float64[]
                    )
    for i in names_stock
        port[:,"weight_"*i]= Float64[]
    end


    i = 1;

    while i <= simulations
        #set weights 
        weights = rand(size(port_returns)[2])
        total = sum(weights)

        w = weights/total
        Σ = cov(Matrix(port_returns))
        #calculate returns of the portfolio 
        port_return = Matrix(port_returns)*w

        expected_return = mean(port_return)*250

        #calculate variance of the profolio 
        σ²= 0
        for i in eachindex(w), j in eachindex(w)
            x = w[i]*w[j]*Σ[i,j]
            σ² +=x 
        end 

        port_var = (σ²*250)

        list = [expected_return, port_var, w]
        #decompose 
        results = collect(Iterators.flatten(list))

        push!(port, results )
        i += 1
    end 

    port[:,:port_std] = .√port[:,:port_var]
    return port
end 

port_sim = mpt(port_returns)
@df port_sim scatter(:port_std, :exp_return)
#calculate the sharp ratio 
function sharp_ration(port_sim, rf = 0.02)
    port_sim[:, :sharp_ratio] = (port_sim[:,:exp_return] .- rf )./port_sim[: , :port_std]
    return sort!(port_sim, :sharp_ratio)
end 

#utility function σ² - qE(Rₚ)
function utility_mpt(port_sim, q = 0 )

    port_sim[:,:utility] = abs.(port_sim[:,:port_var] - q*port_sim[:,:exp_return])
    return sort!(port_sim,:utility)
end 

