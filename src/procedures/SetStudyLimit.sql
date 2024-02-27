CREATE PROCEDURE SetStudyLimit
    @StudyID int

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Limit int
    SET @Limit = (SELECT MIN(Meetings.Limit) FROM Meetings WHERE Meetings.StudyID = @StudyID)

END;
go

