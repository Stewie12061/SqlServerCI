IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2166]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2166]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







----Created by: Trọng Kiên, date: 26/04/2021
---- exec MP2166 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[MP2166] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.VoucherNo, O1.VoucherDate, A1.ObjectName, O1.SuppliesDate, M1.Description AS OrderStatus
					 , A2.FullName AS EmployeeName, A3.DepartmentName, O1.Description, A4.InventoryName AS ProductName
					 , CASE WHEN ISNULL(O2.S01ID, '''') <> '''' AND ISNULL(O2.S02ID, '''') <> '''' AND ISNULL(O2.S03ID, '''') <> ''''
								 THEN CONCAT (O2.S01ID, '' x '', O2.S02ID, '' x '', O2.S03ID)
							WHEN ISNULL(O2.S01ID, '''') <> '''' AND ISNULL(O2.S02ID, '''') <> '''' AND ISNULL(O2.S03ID, '''') = ''''
								 THEN CONCAT (O2.S01ID, '' x '', O2.S02ID)
							END AS SizeProduct
FROM OT2201 O1 WITH (NOLOCK)
LEFT JOIN OT2202 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
LEFT JOIN AT1202 A1 WITH (NOLOCK) ON O1.ObjectID = A1.ObjectID
LEFT JOIN MT0099 M1 WITH (NOLOCK) ON O1.OrderStatus = M1.ID AND M1.CodeMaster =''StatusManufacturing''
LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O1.EmployeeID = A2.EmployeeID
LEFT JOIN AT1102 A3 WITH (NOLOCK) ON O1.DepartmentID = A3.DepartmentID
LEFT JOIN AT1302 A4 WITH (NOLOCK) ON O2.ProductID = A4.InventoryID
WHERE O1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O1.APK) = ''' + @APK + ''''


EXEC (@sSQL)
PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
