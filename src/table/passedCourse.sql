create table passedCourse
(
    PassedID  int identity
        constraint passedCourse_pk
            primary key,
    StudentID int not null
        constraint passedCourse__StudentID_fk
            references Students,
    CourseID  int not null
        constraint passedCourse__CourseID_fk
            references Courses
)
go

grant delete, insert, select, update on passedCourse to Administrator
go

grant delete, insert, select, update on passedCourse to Coordinator
go

grant delete, insert, select, update on passedCourse to HeadAdministrator
go

