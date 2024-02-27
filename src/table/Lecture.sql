create table Lecture
(
    LectureID int identity
        primary key,
    MeetingID int      not null
        constraint Lecture__MeetingID_fk
            references Meetings,
    SubjectID int      not null
        references Subjects,
    TeacherID int      not null
        references Teachers,
    Date      datetime not null,
    Length    int      not null
        check ([Length] > 0),
    RoomID    int
        references Room,
    Link      varchar(50)
)
go

exec sp_addextendedproperty 'Column_Description', '>0', 'SCHEMA', 'dbo', 'TABLE', 'Lecture', 'COLUMN', 'Length'
go

grant delete, insert, select, update on Lecture to Administrator
go

grant delete, insert, select, update on Lecture to Coordinator
go

grant delete, insert, select, update on Lecture to HeadAdministrator
go

