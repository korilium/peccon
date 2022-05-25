using DataFrames, MarketData, CSV, Plots, StatsPlots, LoopVectorization,
StatsBase, Distributions, OnlineStats, HypothesisTests

#create profolio 

ticker = ["IBCI.AS", "IUSA.AS" , "IEMA.AS"]
amount_stock = [1,5,1]
dollar_value =  [241.64,41.331,34.98]
total_amount = sum(dollar_value .* amount_stock )

weights = (dollar_value .* amount_stock)./ total_amount
start_date = DateTime(2018,1,1)

function PORTFOLIO(ticker, weights, start_date)
portfolio = DataFrame()
portfolio.ticker = ticker
portfolio.weights = weights
portfolio.start_date .= start_date
    return portfolio
end 

portfolio = PORTFOLIO(ticker, weights, start_date)


#helper functions 






#pre-analysis wothout any portfolio 
#create returns 
#to do: take into account dividends 
function returns(portfolio, start_date)
    STOCKS= fill([], length(portfolio.ticker))
    STOCKS = map((STOCKS) -> yahoo(Symbol(STOCKS), YahooOpt(period1=start_date)), portfolio.ticker)
    #selecting prices for returns
    ret = fill([], length(portfolio.ticker))
    ret1 = map(price -> DataFrame(diff(log.(price.Open))), STOCKS)
    ret2 = hcat(select.(ret1, :Open)..., makeunique=true)
    DataFrames.rename!(ret2, portfolio.ticker)
    insertcols!(ret2, 1,:timestamp => ret1[1].timestamp)
    return TimeArray(dropmissing(ret2), timestamp = :timestamp)
end
 

test = returns(portfolio, start_date)
cols = colnames(test)


#plots for EDA 

@df test density(cols(2:length(portfolio.ticker)+1))

plot(layout = (length(portfolio.ticker),1))
@df test plot!(:timestamp, cols(2:(length(portfolio.ticker)+1)), subplot=1:length(portfolio.ticker))

plot(layout = (length(portfolio.ticker),1))
@df test histogram!(cols(2:length(portfolio.ticker)+1), subplot=1:length(portfolio.ticker))

plot(layout = (1,length(portfolio.ticker)))
@df test boxplot!(cols(2:length(portfolio.ticker)+1), subplot=1:length(portfolio.ticker))
@df test violin!(cols(2:length(portfolio.ticker)+1), subplot=1:length(portfolio.ticker))

@df test cornerplot(cols(2:4))

@df test corrplot(cols(2:4))


#do a univariate and multivariate normalty test. Package to use is HypothesisTests.jl 
#(still in development see https://github.com/JuliaStats/HypothesisTests.jl/issues/201)

#check for outliers


#moments of distributions 
function moments_dist(returns)
    cols = colnames(returns)
    moments = map(x -> fit!(Moments(), x), eachcol(values(returns)))
    mn = map(x -> mean(x), moments)
    standdev = map(x -> std(x), moments)
    skew =  map(x -> skewness(x), moments)
    kurt =  map(x -> kurtosis(x), moments)
    return df = DataFrame(ticker = cols, mean = mn, stdev = standdev, skewness= skew, kurtosis = kurt)
end



#fit distributions check if  they are correct note all models are wrong (not really implemented in julia)

fit_mle(Normal, values(test)[:,1])

#corr and cov 

cor(values(test))
cov(values(test))




# first prices 
function prices(portfolio, start_date)
    STOCKS= fill([], length(portfolio.ticker))
    STOCKS = map((STOCKS) -> yahoo(Symbol(STOCKS), YahooOpt(period1= start_date)), portfolio.ticker)
    ret = fill([], length(portfolio.ticker))
    ret1 = map(price -> DataFrame(price.Open), STOCKS)
    ret2 = hcat(select.(ret1, :Open)..., makeunique=true)
    DataFrames.rename!(ret2, portfolio.ticker)
    insertcols!(ret2, 1,:timestamp => ret1[1].timestamp)
    return ret2
end 

test2 = prices(portfolio, start_date)

plot(layout = (length(portfolio.ticker)),1)
@df test2 plot!(cols(2:4))




#random walk 
function rwalks(T,N,n)
    dt = T/N
    dW = sqrt(dt)*randn(n,N)
    W = zeros(n,N)
    W[:,1] = dW[:,1]
    for j = 2:N
        W[:,j] .= W[:,j-1] .+ dW[:,j]
    end
    transpose(W)
end


 W = rwalks(1,365, 10)

 plot(W)



