IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0062]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP0062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Insert dữ liệu detail khi bảng giá kế thừa từ bảng giá OUT
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/07/2017 by Cao Thị Phượng
---- Modify by Thị Phượng bổ sung cột giá trả góp 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
---- EXEC CP0062 'MS', 'BG0002','BG002', 'PHUONG'

CREATE PROCEDURE CP0062
( 
	@DivisionID AS NVARCHAR(50),
	@ID AS NVARCHAR(50),
	@InheritID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50)
) 
AS 
DECLARE 
		@InventoryID NVARCHAR(250),
		@cur CURSOR,
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
If @CustomerName = 79 --Customize MINH SANG
BEGIN

SET @cur = CURSOR SCROLL KEYSET FOR
	Select InventoryID From OT1302_MS WITH (NOLOCK)
	Where DivisionID =@DivisionID and ID =@InheritID
Delete  from OT1302 WHERE DivisionID = @DivisionID and ID =@ID
OPEN @cur
FETCH NEXT FROM @cur INTO @InventoryID
WHILE @@FETCH_STATUS = 0
  BEGIN	
			Insert InTO OT1302 (DivisionID, DetailID, ID, InventoryID, UnitID, UnitPrice, Orders, CA, CAAmount, InstallmentPrice)
			Select M.DivisionID, 'PM'+cast(NewID() as Varchar(50)), @ID, M.InventoryID, D.UnitID, M.RealUnitPrice, M.OrderNo, M.CA, M.CAAmount, M.InstallmentPrice 
			From OT1302_MS M WITH (NOLOCK)
			LEFT JOIN AT1302 D WITH (NOLOCK) ON D.DivisionID IN ('@@@', M.DivisionID) AND M.InventoryID = D.InventoryID
			where  M.DivisionID = @DivisionID and M.ID =@InheritID and M.InventoryID =@InventoryID
	FETCH NEXT FROM @cur INTO  @InventoryID
  END
CLOSE @cur	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

