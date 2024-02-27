create unique index Cities_CityID_uindex
    on Cities (CityID)
go

create index Cities_CityID_CityName_index
    on Cities (CityID, CityName)
go

