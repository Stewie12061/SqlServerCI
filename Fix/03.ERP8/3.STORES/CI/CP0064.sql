IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0064]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP0064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Insert dữ liệu mặt hàng vào bảng mặt hàng trên POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/07/2017 by Cao Thị Phượng
---- Modify by Thị Phượng Date: 01/03/2018: Bỏ customize index = 79 sử dụng cho chuẩn có sử dụng POS 
---- Modify by Thị Phượng Date: 07/03/2018: Chỉnh sửa Insert tất cả các DivisionID trường hợp dùng chung 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
---- EXEC CP0064 'HCM', 'DANHTEST_MH3','PHUONG'

CREATE PROCEDURE CP0064
( 
	@DivisionID AS NVARCHAR(50),
	@InventoryID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50)
) 
AS 
DECLARE 
		@ShopID NVARCHAR(250),
		@INDivisionID NVARCHAR(250),
		@cur CURSOR,
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0010' AND xtype = 'U')
BEGIN 

SET @cur = CURSOR SCROLL KEYSET FOR
	Select ShopID, DivisionID From POST0010 WITH (NOLOCK)
OPEN @cur
FETCH NEXT FROM @cur INTO @ShopID, @INDivisionID
WHILE @@FETCH_STATUS = 0
  BEGIN	
  IF NOT EXISTS (SELECT TOP 1 1 FROM POST0030 WITH (NOLOCK) WHERE  InventoryID =@InventoryID and ShopID = @ShopID and DivisionID = @INDivisionID)
  BEGIN 
		IF EXISTS (SELECT TOP 1 1 FROM AT1302 WITH (NOLOCK) WHERE  InventoryID =@InventoryID and IsCommon = 1)
		BEGIN
			Insert InTO POST0030 (DivisionID, ShopID, Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			Select  @INDivisionID, @ShopID, Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID , CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
			From AT1302 M WITH (NOLOCK)
			where   M.DivisionID IN ('@@@',@DivisionID) AND M.InventoryID =@InventoryID
		END
		ELSE 
		BEGIN
		IF EXISTS  (SELECT TOP 1 1 FROM POST0010 WITH (NOLOCK) WHERE  ShopID =@ShopID and DivisionID = @DivisionID)
			Insert InTO POST0030 (DivisionID, ShopID, Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			Select  @DivisionID, @ShopID, Barcode, InventoryID, InventoryName, InventoryTypeID, UnitID, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID , CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
			From AT1302 M WITH (NOLOCK)
			where  M.DivisionID IN ('@@@',@DivisionID) AND M.InventoryID =@InventoryID
		END
	END
	FETCH NEXT FROM @cur INTO  @ShopID, @INDivisionID
END
CLOSE @cur	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO