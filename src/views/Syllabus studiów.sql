CREATE view dbo.[Syllabus studiów] as
    select Studies.StudyID, Studies.Name as 'Studies name', Subjects.Syllabus
    FROM studies
             JOIN subjects ON studies.studyid = subjects.studyid
go

grant select on [Syllabus studiów] to Director
go

