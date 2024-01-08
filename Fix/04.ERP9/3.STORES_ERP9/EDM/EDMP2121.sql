IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab thông tin master chương trình học theo tháng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 06/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2121 @DivisionID = 'BE', @UserID = '', @APK = 'F7583E2C-3D2E-4C65-83C0-ACC295EA45EF',@LanguageID ='vi-VN'
	SELECT * FROM EDMT2120 
	EDMP2121 @DivisionID, @UserID, @APK,@LanguageID
----*/
CREATE PROCEDURE EDMP2121
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T01.APK,T01.DivisionID, T01.ProgrammonthID,T01.VoucherDate,T01.TranMonth,T01.TranYear, 
T01.TermID,
CASE WHEN T01.TranMonth < 10 THEN ''0''+CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) Else CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) END AS MonthID,
T01.GradeID, T05.GradeName, T01.ClassID, T09.ClassName,
T01.AttachUS, T01.AttachVN,
T01.Description,T01.CreateUserID,T06.FullName AS CreateUserName,T01.CreateDate,T01.LastModifyUserID,T07.FullName AS LastModifyUserName,T01.LastModifyDate
FROM EDMT2120 T01 WITH (NOLOCK)
LEFT JOIN EDMT1000 T05 WITH (NOLOCK) ON  T05.GradeID = T01.GradeID
LEFT JOIN AT1103 T06 WITH (NOLOCK) ON  T06.EmployeeID = T01.CreateUserID
LEFT JOIN AT1103 T07 WITH (NOLOCK) ON T07.EmployeeID = T01.LastModifyUserID
LEFT JOIN EDMT1040 T08 WITH(NOLOCK) ON T01.TermID = T08.SchoolYearID
LEFT JOIN EDMT1020 T09 WITH(NOLOCK) ON T01.ClassID = T09.ClassID

WHERE T01.APK = '''+@APK+''' 
'
 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO










