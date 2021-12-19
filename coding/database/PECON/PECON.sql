CREATE TABLE [dbo].[europeanCities] (
    [European_City]      NVARCHAR (MAX) NULL,
    [Country_ISO_3166_2] NVARCHAR (50)  NULL,
    [Latitude]           FLOAT (53)     NULL,
    [Longitude]          FLOAT (53)     NULL
);


GO

CREATE TABLE [dbo].[europeanPostcodes] (
    [European_Postal_Code] NVARCHAR (50)  NULL,
    [Country_ISO_3166_2]   NVARCHAR (MAX) NULL,
    [Latitude]             FLOAT (53)     NULL,
    [Longitude]            FLOAT (53)     NULL
);


GO

CREATE TABLE [dbo].[location] (
    [European_City]        NVARCHAR (MAX) NULL,
    [European_Postal_code] NVARCHAR (MAX) NULL,
    [Country_ISO_3166_2]   NVARCHAR (MAX) NULL,
    [Latitude]             FLOAT (53)     NULL,
    [Longitude]            FLOAT (53)     NULL
);


GO

