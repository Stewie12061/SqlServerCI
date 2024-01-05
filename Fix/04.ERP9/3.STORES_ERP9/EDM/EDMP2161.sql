IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load  Thông tin phiếu dự thu học phí master 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Nghiệp vụ \ Nghiệp vụ phiếu dự thu học phí\ Xem thông tin phiếu dự thu học phí
-- <History>
----Created by: Hồng Thảo , Date: 17/10/2018
-- <Example>
/*  
	EDMP2161 @DivisionID = 'Be', @UserID = 'ASOFTADMIN', @APK = '37E5EB12-2062-4CF6-8010-6E9CE93DD231',@LanguageID = 'vi-VN'

	EDMP2161 @DivisionID, @UserID, @APK,@LanguageID
*/
CREATE PROCEDURE EDMP2161 ( 
     @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @LanguageID NVARCHAR (50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''

     
SET @sSQL = @sSQL + N'
	SELECT T1.APK,T1.DivisionID,T1.EstimateID,T1.EstimateDate,T1.GradeID,T3.GradeName,T1.ClassID,T4.ClassName,
	T1.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), T9.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T9.DateTo, 103) + '')'' AS SchoolYearName,
	T1.SchoolYearID,
    CASE WHEN T1.TranMonth < 10 THEN ''0''+CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) Else CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) END AS MonthID,
	T1.TranMonth, T1.TranYear,T1.Description,T1.DeleteFlg,T1.CreateUserID,T7.FullName AS CreateUserName,T1.CreateDate,
	T1.LastModifyUserID,T8.FullName AS LastModifyUserName,T1.LastModifyDate
	FROM EDMT2160 T1 WITH (NOLOCK)
	LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T3.GradeID = T1.GradeID
	LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ClassID = T1.ClassID
	LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID,''@@@'') AND T7.EmployeeID = T1.CreateUserID
	LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T8.DivisionID IN (T1.DivisionID,''@@@'') AND T8.EmployeeID = T1.LastModifyUserID
	LEFT JOIN EDMT1040 T9 WITH(NOLOCK) ON T1.SchoolYearID = T9.SchoolYearID
	WHERE T1.APK = '''+@APK+''' 
'
EXEC (@sSQL)
--PRINT(@sSQL)

   




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
