CREATE TRIGGER trg_CheckPassedStudies
ON dbo.Grades
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @studyId INT, @userId INT, @subjectId INT, @numberOfGrades INT;
    set @subjectId = (SELECT SubjectID fROM inserted);
    set @studyId = (SELECT StudyID
                    FROM Subjects
                    WHERE Subjects.SubjectID = @subjectId);
    set @userId = (SELECT StudentID FROM inserted);
    set @numberOfGrades = (SELECT COUNT(*) FROM Subjects where StudyID = @studyId);
    if not exists (
        select 1
        from Practises
        where StudyID = @studyId and StudentID = @userId
    )
    Begin
        return;
    end

    --compare num of grades with num of grades in subject
    if @numberOfGrades > (SELECT COUNT(*)
                          FROM Grades
                          left join Subjects on Grades.SubjectID = Subjects.SubjectID
                          where StudyID = @studyId and StudentID = @userId)
    Begin
        return;
    end

    if exists (
        select 1
        from Grades
        left join Subjects on Grades.SubjectID = Subjects.SubjectID
        where StudyID = @studyId and StudentID = @userId and Grade < 3
    )
    Begin
        return;
    end
    Begin
        Insert Into PassedStudies (StudyID, userId) Values (@studyId, @userId);
    end
END;
go

