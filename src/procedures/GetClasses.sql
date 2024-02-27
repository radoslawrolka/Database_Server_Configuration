CREATE PROCEDURE GetClasses
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @StudentID NOT IN (SELECT StudentID FROM Students)
    BEGIN
        PRINT('Student nie istnieje.')
        RETURN
    END;
    
    SELECT * FROM [Harmonogram zajęć dla studentów] WHERE StudentID = @StudentID
END;
go

grant execute on GetClasses to Student
go

