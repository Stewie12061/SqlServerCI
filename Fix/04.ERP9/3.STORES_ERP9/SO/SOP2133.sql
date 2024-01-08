IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2133]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2133]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Kiều Nga, date: 18/08/2021
----purpose: In báo giá kỹ thuật
---- exec SOP2133 @DivisionID=N'SGNP',@APK=N'6ce5daf1-d873-4fdd-aaf7-7cb5e27c05b2'

CREATE PROCEDURE [dbo].[SOP2133] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

Declare @sSQL AS nvarchar(max) ='';

SET @sSQL= 'SELECT T1.APK,T1.DivisionID,T1.VouCherNo,T1.VouCherDate,T1.ObjectID,T2.ObjectName,T2.Tel AS AccountTel, T2.Email AS AccountEmail, T2.Address
,T3.FullName, T3.Tel, T3.Email,T1.Ana01ID,T4.AnaName as Ana01Name,T1.ProjectAddress
FROM SOT2120 T1 WITH (NOLOCK)
LEFT JOIN AT1202 T2 WiTH(NOLOCK) ON T1.ObjectID = T2.ObjectID AND T2.DivisionID IN(''@@@'', T1.DivisionID)
LEFT JOIN AT1103 T3 WiTH(NOLOCK) ON T1.EmployeeID = T3.EmployeeID AND T3.DivisionID IN(''@@@'', T1.DivisionID)
LEFT JOIN AT1011 T4 WITH(NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T1.Ana01ID = T4.AnaID AND T4.AnaTypeID = ''A01''
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = '''+ @APK+'''

SELECT T1.APK,T1.DivisionID,T1.InventoryID,T3.InventoryName,T1.Specification,T1.S01ID,T1.S02ID,T1.S03ID, T1.UnitID, T2.UnitName,T1.QuoQuantity,T1.UnitPrice,T1.OriginalAmount,
T1.Notes 
FROM SOT2121 T1 WITH (NOLOCK)
LEFT JOIN AT1304 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.UnitID = T2.UnitID 
LEFT JOIN AT1302 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'',T1.DivisionID) AND T1.InventoryID = T3.InventoryID 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APKMaster = '''+ @APK+'''
'

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
