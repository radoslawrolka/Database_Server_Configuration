create table Grades
(
    GradeID   int identity
        primary key,
    SubjectID int  not null
        references Subjects,
    StudentID int  not null
        references Students,
    Grade     real not null
        check ([Grade] >= 0)
)
go

exec sp_addextendedproperty 'Column_Description', '>0', 'SCHEMA', 'dbo', 'TABLE', 'Grades', 'COLUMN', 'Grade'
go

grant delete, insert, select, update on Grades to Administrator
go

grant delete, insert, select, update on Grades to Coordinator
go

grant delete, insert, select, update on Grades to HeadAdministrator
go

