IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2132]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2132]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load thông tin detail đăng ký dịch vụ 
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
	exec EDMP2132 @DivisionID = 'BE', @UserID = 'asoftadmin', @APK = 'D15E163E-44D8-4D9D-91A2-A4FC23F95E11',@PageNumber = '1', @PageSize= '25' , @Mode ='0',@LanguageID = 'vi-VN'
	
	EDMP2132 @DivisionID, @UserID, @APK,@PageNumber,@PageSize,@LanguageID,@Mode
----*/
CREATE PROCEDURE EDMP2132
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT,
	 @LanguageID VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.StudentID'


IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK, T1.DivisionID, T1.APKMaster, T1.StudentID,T2.StudentName,T1.GradeID,T5.GradeName,T1.ClassID,T6.ClassName,
T1.Notes,T1.PickupPlace,T1.ArrivedPlace,T1.RoundTrip,T1.FromDate,T1.ToDate, T1.DeleteFlg,
 T1.AnaID, T1.ShuttleID, 
 T1.Cost, T1.AmountPromotion, T1.AmountTotalPromotion,
 T1.TypeKeepID, T7.ReceiptTypeName as TypeKeepName,
T1.CreateUserID,T3.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T4.FullName AS CreateUserName,T1.LastModifyDate,
		   Stuff(isnull((	Select  '','' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),'''+@APK+''') 
								AND X.APKDetail = T1.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID

FROM EDMT2131 T1 WITH (NOLOCK)
LEFT JOIN EDMT2010 T2 WITH (NOLOCK)ON T2.DivisionID = T1.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0
LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT1000 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID,''@@@'') AND T5.GradeID = T1.GradeID
LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ClassID = T1.ClassID
LEFT JOIN EDMT1050 T7 WITH (NOLOCK) ON T7.ReceiptTypeID = T1.TypeKeepID 

WHERE  T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0
ORDER BY '+@OrderBy+'
' 
END 


ELSE IF @Mode = 1 
BEGIN 

DECLARE @TotalRow NVARCHAR(50) = N''

SET @TotalRow = 'COUNT(*) OVER ()' 

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK, T1.DivisionID, T1.APKMaster, T1.StudentID,T2.StudentName,T1.GradeID,T5.GradeName,T1.ClassID,T6.ClassName,
T1.Notes,T1.PickupPlace,T1.ArrivedPlace,T1.RoundTrip,T1.FromDate,T1.ToDate, T1.DeleteFlg,
 T1.AnaID, T1.ShuttleID, 
 T1.Cost, T1.AmountPromotion, T1.AmountTotalPromotion,
 T1.TypeKeepID, T7.ReceiptTypeName as TypeKeepName,
T1.CreateUserID,T3.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T4.FullName AS CreateUserName,T1.LastModifyDate,
		   Stuff(isnull((	Select  '' 
		   - '' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),'''+@APK+''') 
								AND X.APKDetail = T1.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID

FROM EDMT2131 T1 WITH (NOLOCK)
LEFT JOIN EDMT2010 T2 WITH (NOLOCK)ON T2.DivisionID = T1.DivisionID AND T1.StudentID = T2.StudentID
LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT1000 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID,''@@@'') AND T5.GradeID = T1.GradeID
LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ClassID = T1.ClassID
LEFT JOIN EDMT1050 T7 WITH (NOLOCK) ON T7.ReceiptTypeID = T1.TypeKeepID 


WHERE  T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0
ORDER BY '+@OrderBy+' 

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 



 --PRINT @sSQL
 EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
