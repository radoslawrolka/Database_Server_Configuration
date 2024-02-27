create table Meetings
(
    MeetingID int not null
        primary key
        references Products,
    StudyID   int not null
        references Studies,
    limit     int
)
go

grant delete, insert, select, update on Meetings to Administrator
go

grant delete, insert, select, update on Meetings to Coordinator
go

grant delete, insert, select, update on Meetings to HeadAdministrator
go

