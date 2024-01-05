IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab thông tin xem chi tiet so tinh tien cho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>	
---- 
---- 
-- <History>
----Created by:Trà Giang 20/09/2018
-- <Example>
---- 
/*-- <Example>
	NMP2041 @DivisionID = 'BS', @UserID = '', @APK = '827A4AFD-A63B-4C24-85A0-51E8E6B224B8'

----*/
CREATE PROCEDURE NMP2041
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'

  SELECT N40.APK,N40.DivisionID,N40.VoucherNo,N40.VoucherDate,N40.InvestigateVoucherNo,N40.SurplusMonth,N40.SurplusDay,N40.QuotaUnitPrice,
   N40.TotalStudent, N40.Description, N41.MaterialsID,A02.InventoryName AS MaterialsName,
    N41.UnitID, A04.UnitName,N41.WarehouseID,A03.WareHouseName, N41.SupplierID,A12.ObjectName AS SupplierName, N41.ActualQuantity, N41.UnitPrice, N41.Amount
 from NMT2040 N40 WITH (NOLOCK) inner join NMT2041 N41 WITH (NOLOCK)  on N40.APK=N41.APKMaster
 LEFT JOIN AT1302 A02 WITH (NOLOCK) ON N41.MaterialsID= A02.InventoryID AND A02.DivisionID  IN (N40.DivisionID,''@@@'')
 LEFT JOIN AT1304 A04 WITH (NOLOCK) ON N41.UnitID= A04.UnitID AND   A04.DivisionID  IN (N40.DivisionID,''@@@'')
 LEFT JOIN AT1303 A03 WITH (NOLOCK) ON N41.WareHouseID= A03.WareHouseID AND   A03.DivisionID  IN (N40.DivisionID,''@@@'') 
  LEFT JOIN AT1202 A12 WITH (NOLOCK) ON N41.SupplierID= A12.ObjectID AND A12.DivisionID IN (N40.DivisionID,''@@@'') 
  WHERE N40.DeleteFlg = 0 and N40.DivisionID='''+@DivisionID+''' and N40.APK = '''+@APK+''''

 EXEC (@sSQL)
 -- PRINT @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


