IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2167_HIPC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2167_HIPC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








---- Created by: Nhật Quang, date: 20/02/2023
---- Update by: Đức Tuyên, date: 08/05/2023 Sắp xếp theo đúng vị trí Orders
---- exec MP2167_HIPC @Divisionid=N'HIP',@APK=N''

CREATE PROCEDURE [dbo].[MP2167_HIPC] 
				@DivisionID AS NVARCHAR(50),
				@APK AS NVARCHAR(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.MaterialID, O1.MaterialName AS InventoryName, O1.UnitName, O1.MaterialQuantity AS Quantity, O1.MDescription
	   , CASE WHEN O1.IsChange = 0 THEN N''Không''
			  WHEN O1.IsChange = 1 THEN N''Có'' END AS IsChange
	   
FROM OT2203 O1 WITH (NOLOCK)
LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
ORDER BY Orders'


EXEC (@sSQL)
PRINT (@sSQL)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
