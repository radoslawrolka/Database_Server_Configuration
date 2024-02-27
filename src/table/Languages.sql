create table Languages
(
    LanguageID int identity
        primary key,
    Language   varchar(20) not null
)
go

grant delete, insert, select, update on Languages to Administrator
go

grant delete, insert, select, update on Languages to HeadAdministrator
go

