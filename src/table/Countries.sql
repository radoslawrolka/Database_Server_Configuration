create table Countries
(
    CountryID   int identity
        primary key,
    CountryName varchar(50) not null
)
go

grant delete, insert, select, update on Countries to Administrator
go

grant delete, insert, select, update on Countries to HeadAdministrator
go

