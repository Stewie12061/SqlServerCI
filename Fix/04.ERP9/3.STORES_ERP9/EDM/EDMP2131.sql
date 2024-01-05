IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load thông tin master đăng ký dịch vụ 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 08/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2131 @DivisionID = 'BE', @UserID = '', @APK = 'BEF13F63-AB42-4A7D-9CC3-035AA6830879',@LanguageID ='vi-VN'

	EDMP2131 @DivisionID, @UserID, @APK,@LanguageID
----*/
CREATE PROCEDURE EDMP2131
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT  T01.APK,T01.DivisionID,T01.VoucherNo,T01.ReceiptTypeID, T02.ReceiptTypeName, T01.ExtracurricularActivity,T01.Cost,T01.ServiceTypeID, 
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T09.Description' ELSE 'T09.DescriptionE' END +' as ServiceTypeName, 
T01.TranMonth,T01.TranYear,
CASE WHEN T01.TranMonth < 10 THEN ''0''+CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) Else CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) END AS MonthID,
T01.ActivityTypeID,T03.ActivityTypeName,T01.ActivityID,T04.ActivityName,T01.Description,
T01.SchoolYearID, T01.FromDate, T01.ToDate, 
T01.DateSchedule,T01.Place, T01.DeleteFlg,T01.CreateUserID,T07.FullName AS CreateUserName, T01.CreateDate,T01.LastModifyUserID,
T08.FullName AS LastModifyUserName, T01.LastModifyDate,T01.AnaID,
Stuff(isnull((	Select  '', '' + X.GradeName From  
												(	Select DISTINCT EDMT2132.APKMaster, EDMT2132.DivisionID, EDMT2132.GradeID, T3.GradeName
													From EDMT2132 WITH (NOLOCK)
													LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T3.GradeID = EDMT2132.GradeID
													WHERE EDMT2132.DeleteFlg = 0
												) X
								Where X.APKMaster = Convert(varchar(50),T01.APK) and X.DivisionID= T01.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS GradeName,
Stuff(isnull((	Select  '', '' + Y.ClassName From  
												(	Select DISTINCT EDMT2133.APKMaster, EDMT2133.DivisionID, EDMT2133.ClassID, T4.ClassName
													From EDMT2133 WITH (NOLOCK)
													LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = EDMT2133.ClassID
													WHERE EDMT2133.DeleteFlg = 0 
												) Y
								Where Y.APKMaster = Convert(varchar(50),T01.APK) and Y.DivisionID= T01.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS ClassName,

Stuff(isnull((	Select  '', '' + Z.GradeID From  
												(	Select DISTINCT EDMT2132.APKMaster, EDMT2132.DivisionID, EDMT2132.GradeID
													From EDMT2132 WITH (NOLOCK)
													WHERE EDMT2132.DeleteFlg = 0 
												) Z
								Where Z.APKMaster = Convert(varchar(50),T01.APK) and Z.DivisionID= T01.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS GradeID,

Stuff(isnull((	Select  '', '' + T.ClassID From  
												(	Select DISTINCT EDMT2133.APKMaster, EDMT2133.DivisionID, EDMT2133.ClassID
													From EDMT2133 WITH (NOLOCK)
													WHERE EDMT2133.DeleteFlg = 0 
												) T
								Where T.APKMaster = Convert(varchar(50),T01.APK) and T.DivisionID= T01.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS ClassID


FROM EDMT2130 T01 WITH (NOLOCK)
LEFT JOIN EDMT1050 T02 WITH (NOLOCK) ON T02.DivisionID IN (T01.DivisionID, ''@@@'') AND T02.ReceiptTypeID = T01.ReceiptTypeID
LEFT JOIN EDMT1060 T03 WITH (NOLOCK) ON T03.DivisionID IN (T01.DivisionID, ''@@@'') AND  T03.ActivityTypeID = T01.ActivityTypeID
LEFT JOIN EDMT1061 T04 WITH (NOLOCK) ON T04.DivisionID IN (T01.DivisionID, ''@@@'') AND  T03.APK = T04.APKMaster AND T01.ActivityID = T04.ActivityID
LEFT JOIN EDMT1040 T05 WITH(NOLOCK) ON T01.SchoolYearID = T05.SchoolYearID
LEFT JOIN AT1103 T07 WITH (NOLOCK) ON T07.DivisionID IN (T01.DivisionID,''@@@'') AND T07.EmployeeID = T01.CreateUserID
LEFT JOIN AT1103 T08 WITH (NOLOCK) ON T08.DivisionID IN (T01.DivisionID,''@@@'') AND T08.EmployeeID = T01.LastModifyUserID
LEFT JOIN EDMT0099 T09 WITH (NOLOCK) ON T09.ID = T01.ServiceTypeID AND T09.CodeMaster=''ServiceTypeID''


WHERE T01.APK = '''+@APK+''' 
'


 --PRINT @sSQL
 EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
