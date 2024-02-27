create table Translators
(
    TranslatorID  int identity
        primary key,
    FirstName     varchar(30) not null,
    LastName      varchar(30) not null,
    BirthDate     date        not null
        check (datepart(year, [BirthDate]) >= 1900),
    HireDate      date default getdate(),
    Adress        varchar(30) not null,
    CountryCityID int         not null
        references CountryCity,
    PostalCode    varchar(10) not null,
    Email         varchar(50) not null
        unique
        check ([Email] like '%@%'),
    PhoneNumber   varchar(12)
        check (NOT [PhoneNumber] like '%[^0-9]%')
)
go

grant delete, insert, select, update on Translators to Administrator
go

grant delete, insert, select, update on Translators to HeadAdministrator
go

