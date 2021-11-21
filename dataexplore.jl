using CSV, DataFrames, Plots, Dates,ODBC, DataFramesMeta, MySQL, DBInterface

###################
### Preperation ###
###################

    #read in the data
    Original=CSV.read("data/ignace_transactions.csv",DataFrame, delim=";", decimal=',', dateformat="d/m/Y")
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

#########################
### Data manipulation ###
#########################

    #create the account based on the transactions 
    #first change the missing values to 0 
    bedrag_adapted = replace!(data.Bedrag, missing => 0)
    data.bedrag_adapted = bedrag_adapted
    bedrag_neg  = replace!(data.bedrag_adapted,r"-." => 0 )

    for i in eachrow(data)
        i[:bedrag_pos] = replace(i[:bedrag_adapted],r"-^" => 0 )
    end 
    account = cumsum(data.Bedrag)

    plot(data.Boekingsdatum, account)
    plot!(data.Boekingsdatum,data.Bedrag)

##################################
### create an overview by year ### 
##################################


    years =  Dates.year.(data.Boekingsdatum)
    data.years = years


################################################
### mapping transactions to locations on map ###
################################################

# first replace missing value in beschrijving 
data.Omschrijving = replace!(data.Omschrijving, missing => " ")
#first tryout 
for i in data.row
    print(match(r"\- +[A-Z]+ \-", data.Omschrijving[i]))
end