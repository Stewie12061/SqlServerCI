IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Load dữ liệu master phiếu báo giá Sale
----Created by: Đình Hoà, date: 06/08/2021
----Edit by : DDinhf hoaf, date : 25/08/2021 : Bổ sung cột load dữ liệu


CREATE PROCEDURE [dbo].[SOP2123] 
				@DivisionID AS nvarchar(50),
				@APK AS varchar(50)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT S1.APK, S1.VouCherNo, S1.VouCherDate, S2.ObjectName, S2.Tel AS AccountTel, S2.Email AS AccountEmail, S2.Address, S3.FullName, S3.Tel, S3.Email
, S4.AnaName AS ProjectName, S1.Ana01ID AS ProjectID, S1.ProjectAddress
FROM SOT2120 S1 WITH(NOLOCK)
LEFT JOIN AT1202 S2 WiTH(NOLOCK) ON S1.ObjectID = S2.ObjectID AND S2.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1103 S3 WiTH(NOLOCK) ON S1.EmployeeID = S3.EmployeeID AND S3.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1011 S4 WITH(NOLOCK) ON S4.DivisionID IN (S1.DivisionID,''@@@'') AND S1.Ana01ID = S4.AnaID AND S4.AnaTypeID = ''A01''
WHERE S1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.APK) = ''' + @APK + ''''


EXEC (@sSQL)
PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
