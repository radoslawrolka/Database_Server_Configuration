CREATE PROCEDURE AddStudy
   @StudyName varchar(50),
   @StudyDescription varchar(200),
   @StudyCoordinatorID integer,
   @StudyFieldID integer,
   @Price money
AS
BEGIN
   SET NOCOUNT ON;

   IF NOT @StudyCoordinatorID IN (
       SELECT CoordinatorID FROM Coordinator
   )
   BEGIN
       PRINT 'Error: Coordinator does not exist.';
       RETURN;
   END

   IF NOT @StudyFieldID IN (
       SELECT FieldType.FieldTypeID FROM FieldType
   )
   BEGIN
       PRINT 'Error: StudyField does not exist.';
       RETURN;
   END

   DECLARE @StudyID integer;

   INSERT INTO Products(ProductTypeID, Price)
   VALUES (4, @Price)
   SET @StudyID = SCOPE_IDENTITY();
   INSERT INTO Studies (StudyID, Name, Description, CoordinatorID, FieldID)
   VALUES (@StudyID, @StudyName, @StudyDescription, @StudyCoordinatorID, @StudyFieldID);

   PRINT 'Study added successfully.';
END;
grant execute on dbo.AddGrade to Coordinator;
go

