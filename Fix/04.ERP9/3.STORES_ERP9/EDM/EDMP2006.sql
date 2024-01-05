IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load kế thừa thông tin chuyển trường 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 27/9/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2006 @DivisionID = 'CG', @UserID = '', @Search = '',@PageNumber = 1,@PageSize = 25
	
	EDMP2006 @DivisionID, @UserID, @Search,@PageNumber,@PageSize
----*/
CREATE PROCEDURE EDMP2006
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @Search NVARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT
)

AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N''

 SET @OrderBy = 'T1.DateTranfer DESC,T1.StudentID'
 SET @TotalRow = 'COUNT(*) OVER ()' 

IF ISNULL(@Search, '') <> '' 
		SET @sWhere = @sWhere + N' AND (T1.StudentID LIKE N''%'+@Search+'%''
										OR T2.StudentName LIKE N''%'+@Search+'%''
										)
								'



SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
 T1.APK , T1.DivisionID, T3.DivisionName, T1.StudentID, T2.StudentName, T1.DateTranfer,  T1.SchoolIDTo AS DivisionIDTo,T4.DivisionName AS DivisionNameTo, T2.InheritTranfer,
 T2.APKTransfer
FROM EDMT2140 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2000 T2 WITH (NOLOCK) ON T1.StudentID = T2.StudentID AND T2.DeleteFlg = T1.DeleteFlg
LEFT JOIN AT1101 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID
LEFT JOIN AT1101 T4 WITH (NOLOCK) ON T4.DivisionID = T1.SchoolIDTo
WHERE T1.SchoolIDTo != T1.DivisionID AND T1.DeleteFlg = 0 AND T1.SchoolIDTo = '''+@DivisionID+''' AND T1.DateTranfer <= '''+CONVERT(VARCHAR(10),GETDATE(),126)+'''
AND NOT EXISTS (SELECT TOP 1 APKTransfer FROM EDMT2000 WITH (NOLOCK) WHERE  ISNULL(EDMT2000.APKTransfer,'''') = CONVERT(VARCHAR(50),T1.APK ) )
'+@sWhere+'

 ORDER BY '+@OrderBy+'
 OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
 FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

'


PRINT @sSQL
 EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
