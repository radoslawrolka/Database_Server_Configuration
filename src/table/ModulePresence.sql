create table ModulePresence
(
    ModulePresenceID int identity
        primary key,
    StudentID        int not null
        references Students,
    ModuleID         int not null
        references Modules,
    WasPresent       bit default 0
)
go

grant delete, insert, select, update on ModulePresence to Administrator
go

grant delete, insert, select, update on ModulePresence to Coordinator
go

grant delete, insert, select, update on ModulePresence to HeadAdministrator
go

grant delete, insert, update on ModulePresence to Teacher
go

