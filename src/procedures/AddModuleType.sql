CREATE PROCEDURE AddModuleType
    @ModuleTypeName varchar (30)
AS
BEGIN
    SET NOCOUNT ON;

    IF @ModuleTypeName IN (
       SELECT Name FROM ModuleType
   )
   BEGIN
       PRINT 'Error: Module type already exist.';
       RETURN;
   END


   INSERT INTO ModuleType (Name)
    VALUES (@ModuleTypeName)
END;
go

