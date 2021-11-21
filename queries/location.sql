
CREATE TABLE [DBO].[location]
( European_City NVARCHAR(max)  NULL,
    European_Postal_code NVARCHAR(max)  NULL,
    Country_ISO_3166_2  NVARCHAR(max)  NULL,
    Latitude float NULL, 
    Longitude float NULL)


INSERT INTO [DBO].[location]
SELECT 
    European_City,
    European_Postal_code,
    ec.Country_ISO_3166_2,
    ec.Latitude, 
    ec.Longitude
FROM [DBO].[europeanCities] ec
INNER JOIN [DBO].[europeanPostcodes] ep
    on ec.Latitude = ep.Latitude 
    and ec.Longitude = ep.Longitude
