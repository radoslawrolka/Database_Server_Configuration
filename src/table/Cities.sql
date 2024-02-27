create table Cities
(
    CityID   int identity
        primary key,
    CityName varchar(50) not null
)
go

grant delete, insert, select, update on Cities to Administrator
go

grant alter, control, delete, insert, select, update on Cities to HeadAdministrator
go

