create table AttendanceAndGrade
(
    StudentID    int
        constraint AttendanceAndGradeView_Students_StudentID_fk
            references Students,
    SubjectID    int
        constraint AttendanceAndGradeView_Subjects_SubjectID_fk
            references Subjects,
    [Percent]    float not null,
    AverageGrade int,
    Status       varchar(10)
)
go

grant delete, insert, select, update on AttendanceAndGrade to HeadAdministrator
go

