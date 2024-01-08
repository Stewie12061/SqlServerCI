IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22942]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22942]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu đã chọn kế thừa ra màn hình cập nhật xuất kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Hồng Thắm , Date: 15/12/2023
-- <Example>
---- 
/*-- <Example>
	exec WMP22942 @DivisionID=N'HVH',@UserID=N'ADMIN',@PageNumber=NULL,@PageSize=NULL,@LstVoucherNo=N'XKMV/0053/12/23',@FormID=N'WMF2294',@Mode=1

----*/

CREATE PROCEDURE WMP22942
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LstVoucherNo VARCHAR(MAX),  ---- Danh sách APK check chọn ở lưới master
	 @FormID VARCHAR (50),
	 @Mode TINYINT -- 1: Load dữ liệu ra lưới detail 1 / detail 2
)
AS 
DECLARE @sSQL NVARCHAR(MAX)


IF @Mode=1
BEGIN
	SET @sSQL = '
		SELECT BT1002.VoucherNo , BT1002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, AT1304.UnitName AS ConvertedUnitID
			   ,BT1002.Quantity AS ConvertedQuantity, AT1302.SalePrice01 AS ConvertedPrice, BT1002.Quantity * AT1302.SalePrice01 AS ConvertedAmount
			   ,BT1002.Quantity AS ActualQuantity, AT1302.SalePrice01 AS UnitPrice ,BT1002.Quantity * AT1302.SalePrice01 AS ActualAmount, BT1002.SourceNo
			   ,BT1002.S01ID ,BT1002.S02ID ,BT1002.S03ID ,BT1002.S04ID ,BT1002.S05ID ,BT1002.S06ID ,BT1002.S07ID ,BT1002.S08ID ,BT1002.S09ID ,BT1002.S10ID
			   ,BT1002.S11ID ,BT1002.S12ID ,BT1002.S13ID ,BT1002.S14ID ,BT1002.S15ID ,BT1002.S16ID ,BT1002.S17ID ,BT1002.S18ID ,BT1002.S19ID ,BT1002.S20ID
			   , WT0096.DebitAccountID , (Select AT1005.AccountName FROM AT1005 WHERE WT0096.DebitAccountID = AT1005.AccountID) AS DebitAccountName
			   , WT0096.CreditAccountID , (Select AT1005.AccountName FROM AT1005 WHERE WT0096.CreditAccountID = AT1005.AccountID) AS CreditAccountName
			   , WT0096.Ana01ID as Ana01Name, WT0096.Ana02ID as Ana02Name, WT0096.Ana03ID as Ana03Name, WT0096.Ana04ID as Ana04Name, WT0096.Ana05ID as Ana05Name
			   , WT0096.Ana06ID as Ana06Name, WT0096.Ana07ID as Ana07Name, WT0096.Ana08ID as Ana08Name, WT0096.Ana09ID as Ana09Name, WT0096.Ana10ID as Ana10Name
			   , WT0096.DriverID as DriverName, WT0096.CarID as CarName, BT1002.InheritVoucherNo as ReVoucherNo
	    FROM BT1002 WITH (NOLOCK)  
	    LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (BT1002.DivisionID, ''@@@'') AND BT1002.InventoryID = AT1302.InventoryID 
	    LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (BT1002.DivisionID, ''@@@'') AND AT1302.UnitID = AT1304.UnitID 
		LEFT JOIN WT0096 WITH (NOLOCK) ON WT0096.DivisionID IN (BT1002.DivisionID, ''@@@'') AND WT0096.VoucherID = BT1002.InheritVoucherID AND WT0096.InventoryID = BT1002.InventoryID

	    
	    WHERE BT1002.DivisionID =  '''+@DivisionID+''' AND BT1002.VoucherNo IN ('''+@LstVoucherNo+''')
	    GROUP BY BT1002.VoucherNo , BT1002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName
				, BT1002.Quantity, AT1302.SalePrice01, BT1002.SourceNo , WT0096.DebitAccountID, WT0096.CreditAccountID
				,BT1002.S01ID ,BT1002.S02ID ,BT1002.S03ID ,BT1002.S04ID ,BT1002.S05ID ,BT1002.S06ID ,BT1002.S07ID ,BT1002.S08ID ,BT1002.S09ID ,BT1002.S10ID
			    ,BT1002.S11ID ,BT1002.S12ID ,BT1002.S13ID ,BT1002.S14ID ,BT1002.S15ID ,BT1002.S16ID ,BT1002.S17ID ,BT1002.S18ID ,BT1002.S19ID ,BT1002.S20ID
				, WT0096.Ana01ID, WT0096.Ana02ID, WT0096.Ana03ID, WT0096.Ana04ID, WT0096.Ana05ID
				, WT0096.Ana06ID, WT0096.Ana07ID, WT0096.Ana08ID, WT0096.Ana09ID, WT0096.Ana10ID
				, WT0096.DriverID, WT0096.CarID, BT1002.InheritVoucherNo'
END


EXEC (@sSQL)
PRINT (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
