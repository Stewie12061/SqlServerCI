IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----Created by: Trọng Kiên, date: 29/04/2021
---- exec SOP2024 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[SOP2024] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) =''



SET @sSQL = N'SELECT O1.ObjectName AS Division01, O1.Address AS Address01, A1.Tel AS EmployeeTel
		      , A1.Email AS Email01, ISNULL(O1.Varchar01,'''') AS ProductName, O1.QuotationNo AS VoucherNo
		      , O1.QuotationDate AS VoucherDate, A2.FullName AS ObjectName, A2.Tel AS PhoneContactor
		      , A2.Email AS EmailTitle, A1.VATNo, (A3.VATPercent / 100) AS VATPercent, '''' AS FullName, O1.Description
			  FROM OT2101 O1 WITH (NOLOCK)
			  	  LEFT JOIN AT1202 A1 WITH (NOLOCK) ON O1.ObjectID = A1.ObjectID
			  	  LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O1.CreateUserID = A2.EmployeeID
			  	  INNER JOIN (SELECT TOP 1 O2.QuotationID, O2.VATPercent 
			  			      FROM OT2102 O2 WITH (NOLOCK)
			  				  WHERE O2.DivisionID IN (''@@@'',''' + @DivisionID + ''') AND O2.QuotationID = ''' + @APK + ''') A3 ON O1.QuotationID = A3.QuotationID
WHERE O1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O1.QuotationID) = ''' + @APK + ''''


EXEC (@sSQL)
PRINT (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
