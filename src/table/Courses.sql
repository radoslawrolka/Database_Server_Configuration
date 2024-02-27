create table Courses
(
    CourseID      int         not null
        primary key
        references Products,
    Title         varchar(50) not null,
    StartingDate  date        not null,
    CoordinatorID int         not null
        references Coordinator
)
go

grant delete, insert, select, update on Courses to Administrator
go

grant delete, insert, select, update on Courses to Coordinator
go

grant delete, insert, select, update on Courses to HeadAdministrator
go

