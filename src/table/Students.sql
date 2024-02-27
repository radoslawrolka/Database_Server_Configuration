create table Students
(
    StudentID   int identity
        primary key,
    FirstName   varchar(30) not null,
    LastName    varchar(30) not null,
    BirthDate   date        not null
        check (datepart(year, [BirthDate]) >= 1900),
    Email       varchar(50) not null
        unique
        check ([Email] like '%@%'),
    PhoneNumber varchar(12)
        check (NOT [PhoneNumber] like '%[^0-9]%')
)
go

grant delete, insert, select, update on Students to Administrator
go

grant delete, insert, select, update on Students to HeadAdministrator
go

