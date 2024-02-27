create table LecturePresence
(
    LecturePresenceID int identity
        primary key,
    StudentID         int not null
        references Students,
    LectureID         int not null
        references Lecture,
    WasPresent        bit default 0
)
go

grant delete, insert, select, update on LecturePresence to Administrator
go

grant delete, insert, select, update on LecturePresence to Coordinator
go

grant delete, insert, select, update on LecturePresence to HeadAdministrator
go

grant delete, insert, update on LecturePresence to Teacher
go

