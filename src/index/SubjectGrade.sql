create index SubjectGrade_SubjectGradeID_StudentID_SubjectID_index
    on SubjectGrade (SubjectGradeID, StudentID, SubjectID)
go

create index SubjectGrade_SubjectGradeID_SubjectID_StudentID_index
    on SubjectGrade (SubjectGradeID, SubjectID, StudentID)
go

