create table passedStudies
(
    id       int identity
        primary key,
    studyId  int not null
        constraint fk_passedStudies_studyId
            references Studies,
    userId   int not null
        constraint fk_passedStudies_userId
            references Students,
    passedAt date default getdate()
)
go

grant delete, insert, select, update on passedStudies to Administrator
go

grant delete, insert, select, update on passedStudies to Coordinator
go

grant delete, insert, select, update on passedStudies to HeadAdministrator
go

