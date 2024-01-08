IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2166_HIPC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2166_HIPC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







----Created by: Nhật Quang, date: 20/02/2023
---- exec MP2166_HIPC @Divisionid=N'HIP',@APK=N''

CREATE PROCEDURE [dbo].[MP2166_HIPC] 
				@DivisionID AS NVARCHAR(50),
				@APK AS NVARCHAR(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.VoucherNo, O1.VoucherDate, A1.ObjectName, A1.CountryID AS Country, O1.SuppliesDate, M1.Description AS OrderStatus
					 , A2.FullName AS EmployeeName, A3.DepartmentName, O1.Description, A4.InventoryName AS ProductName, O2.ProductID,
					 O2.ProductQuantity AS Quantity

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
