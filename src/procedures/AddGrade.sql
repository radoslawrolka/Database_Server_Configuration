CREATE PROCEDURE AddGrade
    @SubjectID int,
    @StudentID int,
    @Grade int
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT @SubjectID IN (
       SELECT SubjectID FROM Subjects
   )
   BEGIN
       PRINT 'Error: Subject does not exist.';
       RETURN;
   END

   IF NOT @StudentID IN (
       SELECT StudentID FROM Students
   )
   BEGIN
       PRINT 'Error: Student does not exist.';
       RETURN;
   END

   IF @Grade > 5 or @Grade < 2
   BEGIN
       PRINT 'Error: Incorrect Grade'
   end

   INSERT INTO Grades (SubjectID, StudentID, Grade)
    VALUES (@SubjectID, @StudentID, @Grade)
END;
go

grant execute on AddGrade to Coordinator
go

grant execute on AddGrade to Teacher
go

