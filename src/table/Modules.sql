create table Modules
(
    ModuleID   int identity
        primary key,
    CourseID   int         not null
        references Courses,
    Title      varchar(50) not null,
    Date       datetime    not null,
    Length     int         not null
        check ([Length] > 0),
    TeacherID  int         not null,
    ModuleType int         not null
        references ModuleType,
    RoomID     int default NULL
        references Room,
    Link       varchar(50),
    Limit      int
        check ([Limit] > 0),
    FieldID    int         not null
        references FieldType
)
go

exec sp_addextendedproperty 'Column_Description', '>0', 'SCHEMA', 'dbo', 'TABLE', 'Modules', 'COLUMN', 'Length'
go

grant delete, insert, select, update on Modules to Administrator
go

grant delete, insert, select, update on Modules to Coordinator
go

grant delete, insert, select, update on Modules to HeadAdministrator
go

