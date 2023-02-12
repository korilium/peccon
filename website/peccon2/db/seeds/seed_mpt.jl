using SearchLight, Peccon2.Mpts 
using CSV 

Base.convert(::Type{String}, _::Missing) = ""
Base.convert(::Type{Int}, _::Missing) = 0
Base.convert(::Type{Int}, s::String) = parse(Int, s)

test = CSV.File("peccon2/db/seeds/ADAEUR.csv")
function seed()
    for row in CSV.Rows(joinpath(@__DIR__, "ADAEUR.csv"), limit= 500)
        m = Mpt()

        m.ticker = row.ticker
        m.timestamp = row.timestamp 
        # m.open = row.open 
        m.high =row.high 
        # m.low = row.low 
        # m.close = row.close 
        # m.adjusted_close = row.adjusted_clode
        # m.volume = row.volume 
        # m.dividend_amount  = row.dividend_amount 
        # m.split_coefficient = row.split_amount 

        save(m)
    end 
end 