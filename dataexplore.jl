using CSV, 
      DataFrames, 
      Plots, 
      Dates,
      ODBC, 
      DataFramesMeta,
      MySQL,
      DBInterface,
      BenchmarkTools, 
      TextAnalysis, 
      StringEncodings, 
      GeoJSON, 
      VegaLite

###################
### Preperation ###
###################

    #read in the data note not right encoding need to change that 
    Original = DataFrame(CSV.File(open(read, "data/ignace_transactions.csv", enc"windows-1250"), dateformat="dd/mm/yyyy", decimal=',', delim=";"))
    #Original=CSV.read("data/ignace_transactions.csv",DataFrame, delim=";", decimal=',', dateformat="d/m/Y")
    #select valuable columns 
    data = select!(Original, Not(["Rekeningnummer", "Naam van de rekening"]))
    #check type of each column 
    eltype.(eachcol(data)) #ok! 
    # create row number column 
    data.row =  rownumber.(eachrow(data))
    


   
    # connect to server and load in the location of all cities/villages in Europe 
    ODBC.drivers()
    ODBC.adddsn("KORILIUM1/SQLEXPRESS", "SQL Server Native Client RDA 11.0";
                SERVER = "KORILIUM1\\SQLEXPRESS",
                DATABASE = "PECON",
                Trusted_Connection = "True",
                UID="sa", 
                PWD="passwd")

    conn = DBInterface.connect(ODBC.Connection, "KORILIUM1/SQLEXPRESS")
    location = DBInterface.execute(conn, "SELECT * FROM dbo.location") |> DataFrame
    location.European_City = lowercase.(location.European_City)
#########################
### Data manipulation ###
#########################

    #create the account based on the transactions 
    #first change the missing values to 0 
    replace!(data.Bedrag, missing => 0)
    data.bedrag_pos  = replace(x -> x< 0 ? 0 : x, data.Bedrag)
    data.bedrag_neg = replace(x -> x > 0 ? 0 : x, data.Bedrag)



    data.account = cumsum(data.Bedrag)

    plot(data.Boekingsdatum, data.account)
    plot!(data.Boekingsdatum,data.Bedrag)

##################################
### create an overview by year ### 
##################################


    years =  Dates.year.(data.Boekingsdatum)
    data.years = years

combine(
    groupby(data, ["years"]),
    df -> DataFrame(account_avg = mean(df.account)),
    df -> DataFrame(spending_avg = mean(df.bedrag_neg)),
    df -> DataFrame(income_avg = mean(df.bedrag_pos) )
    )
################################################
### mapping transactions to locations on map ###
################################################



# first replace missing value in beschrijving 
data.Omschrijving = replace!(data.Omschrijving, missing => " ")




#create a corpus of each word in omschrijving 
y = Corpus([])
for i in data.row
x = StringDocument(lowercase(data.Omschrijving[i]))
push!(y, x)
end 


update_lexicon!(y)
lexicon(y)
lexical_frequency(y, "BEL")
update_inverse_index!(y)
inverse_index(y)

y


#normalize the amounts 

normalize(vec) = [(x - minimum(vec))/(maximum(vec) - minimum(vec)) for x in vec]
data.NBedrag = normalize(data.Bedrag)
municipalities = lowercase.(df[:,:NAME_4])

# add city column 
data[:,:city] .= "missing"

for i in municipalities
    x  = y[i]
    if x  != Int64[]
     data[x,:city] .= i
    end
end



names(data, findall(x -> eltype(x) <: Union{Missing,Number}, eachcol(data)))


map_data = data[:,[:city, :NBedrag]]

map_data = combine(groupby(map_data, :city), "NBedrag" .=> sum∘skipmissing .=> "NBedrag")
map_data = map_data[setdiff(1:end, 1),:]
Fmap_data = leftjoin(df, map_data, on= "NAME_4" => "city" )
Fmap_data.NBedrag = replace!(Fmap_data.NBedrag, missing => 0)

# colors to plot
colormap = :heat
colors = Array([cgrad(colormap)[value] for value in Fmap_data.NBedrag])

plot(size=(500, 600), axis=false, ticks=false)

for i = 1:nrow(Fmap_data)
    p=plot!(Fmap_data[1, :Shape], color=colors[i])
end

communities= open_shapefile("data/BEL_adm/BEL_adm4.shp")
Fmap_data.Shape= convert(Array{Shapefile.Polygon},Fmap_data.Shape)
Fmap_data.NBedrag = convert(Array{Float64}, Fmap_data.NBedrag)
plotshape(Fmap_data.Shape)
eltype.(eachcol())