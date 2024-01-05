IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab thông tin tổng khung chương trình 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 13/09/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2111 @DivisionID = 'BE', @UserID = '', @APK = '3484C4BF-A340-45F5-AAC1-58CB4D326B8F'
	
	EDMP2111 @DivisionID, @UserID, @APK
----*/
CREATE PROCEDURE EDMP2111
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.ProgramID,T1.VoucherDate, T1.FromDate,T1.ToDate, T1.Description,
T1.TermID + '' ('' + CONVERT(VARCHAR(10), T6.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T6.DateTo, 103) + '')'' AS TermID,
T1.CreateUserID,T4.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T5.FullName AS LastModifyUserName,T1.LastModifyDate
FROM EDMT2110 T1  WITH (NOLOCK)
LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT1040 T6 WITH(NOLOCK) ON T1.TermID = T6.SchoolYearID
WHERE T1.APK = '''+@APK+''''
 --PRINT @sSQL
 EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO









