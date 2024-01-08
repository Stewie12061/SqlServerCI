IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1408]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1408]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Hoang Trong Khanh
-----Created date: 12/03/2012
-----purpose: Xóa các dữ liệu của các bảng liên quan khi xóa một nhân viên (Chuyển từ trigger HX1400 qua)
----- Edited by Bao Anh		Date: 23/12/2012	Xoa thong tin luu tru
---- Modified on 29/12/2015 by Phương Thảo: Bổ sung xóa bảng AT1103 (Người dùng) nếu @IsAutoCreateUser = 1. 
---- Modified on 22/02/2016 by Hoàng Vũ: Fixbug xóa dữ liệu rác, xóa nhân viên nhưng không xóa bổ sung

CREATE PROCEDURE 	[dbo].[HP1408]  
					@DivisionID nvarchar(50),
					@EmployeeID nvarchar(50)
AS

Declare @IsAutoCreateUser Tinyint,
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

IF(@IsAutoCreateUser = 1)
BEGIN
	DELETE AT1103
	WHERE EmployeeID = @EmployeeID And DivisionID = @DivisionID
END

DELETE HT1403_1
From HT1403_1  inner join HT1400 DEL On DEL.EmployeeID = HT1403_1.EmployeeID and DEL.DivisionID = HT1403_1.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1301 
FROM HT1301 inner join HT1400 DEL On DEL.EmployeeID = HT1301.EmployeeID and DEL.DivisionID = HT1301.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1405 
From HT1405 inner join HT1400 DEL On DEL.EmployeeID = HT1405.EmployeeID and DEL.DivisionID = HT1405.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1404 
From HT1404  inner join HT1400 DEL On DEL.EmployeeID = HT1404.EmployeeID and DEL.DivisionID = HT1404.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1403
From HT1403  inner join HT1400 DEL On DEL.EmployeeID = HT1403.EmployeeID and DEL.DivisionID = HT1403.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1402
From HT1402  inner join HT1400 DEL On DEL.EmployeeID = HT1402.EmployeeID and DEL.DivisionID = HT1402.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1401
From HT1401  inner join HT1400 DEL On DEL.EmployeeID = HT1401.EmployeeID and DEL.DivisionID = HT1401.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1407
From HT1407  inner join HT1400 DEL On DEL.EmployeeID = HT1407.EmployeeID and DEL.DivisionID = HT1407.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1408
From HT1408  inner join HT1400 DEL On DEL.EmployeeID = HT1408.EmployeeID and DEL.DivisionID = HT1408.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1412
From HT1412  inner join HT1400 DEL On DEL.EmployeeID = HT1412.EmployeeID and DEL.DivisionID = HT1412.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID

DELETE HT1413
From HT1413  inner join HT1400 DEL On DEL.EmployeeID = HT1413.EmployeeID and DEL.DivisionID = HT1413.DivisionID
Where DEL.EmployeeID = @EmployeeID And DEL.DivisionID = @DivisionID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
