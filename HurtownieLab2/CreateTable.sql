IF OBJECT_ID('dbo.zestaw6_fakt_operacje', 'U') IS NOT NULL DROP TABLE [dbo].[zestaw6_fakt_operacje]; 
IF OBJECT_ID('dbo.zestaw6_wymiar_loty', 'U') IS NOT NULL DROP TABLE [dbo].[zestaw6_wymiar_loty]; 
IF OBJECT_ID('dbo.zestaw6_wymiar_porty_lotnicze', 'U') IS NOT NULL DROP TABLE [dbo].[zestaw6_wymiar_porty_lotnicze]; 
IF OBJECT_ID('dbo.zestaw6_wymiar_linie_lotnicze', 'U') IS NOT NULL DROP TABLE [dbo].[zestaw6_wymiar_linie_lotnicze]; 

/*CREATE DB TABLES*/ 
CREATE TABLE [dbo].[zestaw6_wymiar_porty_lotnicze] (
    [IATA lotniska] varchar(50),
    [typ lotniska] varchar(50),
    [kontynent] varchar(50),
    [kraj] varchar(50),
    [region] varchar(50),
    [miasto] varchar(50),
    [nazwa lotniska] varchar(150),
    [wspolrzedne GPS lotniska] varchar(100),
    CONSTRAINT PK_kod_IATA_lotniska PRIMARY KEY CLUSTERED ([IATA lotniska])
)

CREATE TABLE [dbo].[zestaw6_wymiar_linie_lotnicze] (
    [aktywna] varchar(50),
    [kraj] varchar(100),
    [linia lotnicza] varchar(100),
    [kod IATA] varchar(50),
    [kod ICAO] varchar(50),
    CONSTRAINT PK_kod_IATA_lini_lotniczej PRIMARY KEY CLUSTERED ([kod IATA])
)

CREATE TABLE [dbo].[zestaw6_wymiar_loty] (
    [numer lotu] bigint IDENTITY(1,1),
    [linia lotnicza IATA] varchar(50),
    [kontynent src] varchar(50),
    [kontynent dst] varchar(50),
    [kraj src] varchar(50),
    [kraj dst] varchar(50),
    [lotnisko src] varchar(50),
    [lotnisko dst] varchar(50),
    [liczba miedzyladowan] varchar(50),
    [maszyny obslugujace lot] varchar(50),
    CONSTRAINT PK_numer_lotu PRIMARY KEY CLUSTERED ([numer lotu]),
    CONSTRAINT FK_lotnisko_src FOREIGN KEY ([lotnisko src])
    REFERENCES [dbo].[zestaw6_wymiar_porty_lotnicze] ([IATA lotniska]),
    CONSTRAINT FK_lotnisko_dst FOREIGN KEY ([lotnisko dst])
    REFERENCES [dbo].[zestaw6_wymiar_porty_lotnicze] ([IATA lotniska]),
    CONSTRAINT FK_linia_lotnicza FOREIGN KEY ([linia lotnicza IATA])
    REFERENCES [dbo].[zestaw6_wymiar_linie_lotnicze] ([kod IATA])
)

CREATE TABLE [dbo].[zestaw6_fakt_operacje](
[numer lotu] bigint, 
[id] bigint IDENTITY(1,1), 
[start] datetime,
[ladowanie] datetime, 
[ilosc pasazerow na pokladzie] int, 
[procentowe oblozenie miejsc na pokladzie] real, 
CONSTRAINT PK_id_operacji PRIMARY KEY CLUSTERED (id), 
CONSTRAINT FK_numer_lotu FOREIGN KEY ([numer lotu]) 
REFERENCES [dbo].[zestaw6_wymiar_loty]([numer lotu]))
