CREATE PROCEDURE AddRoom
    @RoomName varchar (30)
AS
BEGIN
    SET NOCOUNT ON;

    IF @RoomName IN (
       SELECT RoomName FROM Room
   )
   BEGIN
       PRINT 'Error: Room already exist.';
       RETURN;
   END

   INSERT INTO Room (RoomName)
    VALUES (@RoomName)
END;
grant execute on dbo.AddGrade to Coordinator;
go

