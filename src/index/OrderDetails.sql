create index OrderDetails_OrderDetailsID_OrderID_ProductID_index
    on OrderDetails (OrderDetailsID, OrderID, ProductID)
go

