using SearchLight, Peccon2.Mpts 
using CSV 

Base.convert(::Type{String}, _::Missing) = ""
Base.convert(::Type{Int}, _::Missing) = 0
Base.convert(::Type{Int}, s::String) = parse(Int, s)


function seed()
    for row in CSV.File(joinpath(@__DIR__, "ADAEUR.csv"), limit= 500)
        m = Market()

        m.ticker = row.ticker
        m.timestamp = row.timestamp 
        m.open = row.open 
        m.high =row.high 
        m.low = row.low 
        m.close = row.close 
        m.adjusted_close = row.adjusted_close
        m.volume = row.volume 
        m.dividend_amount  = row.dividend_amount 
        m.split_coefficient = row.split_coefficient

        save(m)
    end 
end 