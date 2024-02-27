create table Practises
(
    PractiseID    int identity
        primary key,
    StudyID       int           not null
        references Studies,
    StudentID     int           not null
        references Students,
    BegginingDate date          not null
        check (datepart(year, [BegginingDate]) >= 2019),
    CompanyName   nvarchar(255) not null,
    IsCompleted   bit default 0,
    EndDate       date
)
go

grant delete, insert, select, update on Practises to Administrator
go

grant delete, insert, select, update on Practises to HeadAdministrator
go

