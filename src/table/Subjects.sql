create table Subjects
(
    SubjectID     int identity
        primary key,
    Syllabus      nvarchar(255) not null,
    CoordinatorID int           not null
        references Coordinator,
    StudyID       int           not null
        references Studies,
    SubjectName   varchar(50)
)
go

grant delete, insert, select, update on Subjects to Administrator
go

grant delete, insert, select, update on Subjects to Coordinator
go

grant delete, insert, select, update on Subjects to HeadAdministrator
go

