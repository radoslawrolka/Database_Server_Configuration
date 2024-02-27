CREATE PROCEDURE dbo.UpdatePaidForOrder
    @StudentEmail VARCHAR(255),
    @OrderID INT,
    @NewPaid MONEY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentID INT;

    -- Assuming Students table has an Email column
    SELECT @StudentID = StudentID
    FROM dbo.Students
    WHERE Email = @StudentEmail;

    IF @StudentID IS NOT NULL
    BEGIN
        UPDATE dbo.[Order]
        SET Paid = @NewPaid
        WHERE OrderID = @OrderID AND StudentID = @StudentID;
    END
    ELSE
    BEGIN
        print 'Student not found for the given email.';
    END
END
go

