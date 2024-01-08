IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2046]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2046]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load đơn xin phép trong ngày điểm danh 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 30/7/2019
-- <Example>
---- 
--	EDMP2046 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN',@StudentID = '0000229', @AttendanceDate = '2019-09-25 00:00:00.000'


CREATE PROCEDURE [dbo].[EDMP2046]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @AttendanceDate DATETIME

)
AS 

DECLARE @SQL NVARCHAR(MAX) = '' 

BEGIN 

SET @SQL = '
SELECT * FROM APT0008 
WHERE DivisionID = '''+@DivisionID+''' 
AND StudentID = '''+@StudentID+'''
AND DeleteFlg = 0 
AND '''+CONVERT(VARCHAR(10),@AttendanceDate,126)+''' BETWEEN CONVERT(VARCHAR(10), CONVERT(DATE, FromDate,120), 126) AND CONVERT(VARCHAR(10), CONVERT(DATE, ToDate,120), 126)

'

END 


EXEC (@SQL)
---PRINT (@SQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
