-- Create procedure
CREATE PROCEDURE dbo.GetSumToPay
    @OrderID INT,
    @SumToPay MONEY OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @SumToPay = ISNULL(SUM(Price), 0)
    FROM dbo.OrderDetails
    WHERE OrderID = @OrderID;

    -- Print the result
    PRINT 'Sum to Pay for OrderID ' + CAST(@OrderID AS VARCHAR) + ': ' + CAST(@SumToPay AS VARCHAR);
END
go

