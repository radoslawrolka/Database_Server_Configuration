create table Webinars
(
    WebinarID             int                             not null
        primary key
        references Products,
    Title                 varchar(50)                     not null,
    Description           varchar(200)                    not null,
    CreatedDate           date          default getdate() not null,
    TeacherID             int                             not null
        references Teachers,
    TranslatorsLanguageID int           default NULL
        references TranslatorsLanguage,
    RecordingLink         nvarchar(255) default NULL
)
go

grant delete, insert, select, update on Webinars to Administrator
go

grant delete, insert, select, update on Webinars to Coordinator
go

grant delete, insert, select, update on Webinars to HeadAdministrator
go

