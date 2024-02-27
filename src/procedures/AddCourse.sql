CREATE PROCEDURE AddCourse
   @Title varchar(50),
   @StartingDate DATE,
   @CoordinatorID integer,
   @Price money
AS
BEGIN
   SET NOCOUNT ON;

   IF NOT @CoordinatorID IN (
       SELECT CoordinatorID FROM Coordinator
   )
   BEGIN
       PRINT 'Error: Coordinator does not exist.';
       RETURN;
   END

   IF @StartingDate < GETDATE()
    BEGIN
         PRINT 'Error: Starting date must be in the future.';
         RETURN;
    END

   DECLARE @CourseID integer;

   INSERT INTO Products(ProductTypeID, Price)
   VALUES (2, @Price)
   SET @CourseID = SCOPE_IDENTITY();
   INSERT INTO Courses (CourseID, Title, StartingDate, CoordinatorID)
   VALUES (@CourseID, @Title, @StartingDate, @CoordinatorID);

   PRINT 'Course added successfully.';
END;

grant execute on dbo.AddGrade to Coordinator;
go

