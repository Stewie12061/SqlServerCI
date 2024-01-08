IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load lưới học sinh từ màn hình cập nhật xếp lớp 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 21/10/2018
-- <Example>
---- 
/*-- <Example>
exec EDMP2022 @DivisionID=N'BE',@UserID=N'HONGTHAO',@APK=N'd5d8b9e7-7f19-4221-bbc7-a70855808b4f',@LanguageID=N'vi-VN',@Mode=N'2',@PageNumber=1,@PageSize=25, @SchoolYearID = '2016-2018'
		
----*/


CREATE PROCEDURE [dbo].[EDMP2022]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode VARCHAR(1) , -- 0: kế thừa thì có phân trang; 1 là edit không phân trang, 2 là load xem chi tiết 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @SchoolYearID VARCHAR(50)

)
AS 
SET NOCOUNT ON

DECLARE @sSQL NVARCHAR (MAX), @TotalRow NVARCHAR(50), @sWhere NVARCHAR(MAX) = N''
 

IF @Mode = '0' -- KẾ THỪA, CHỌN       
	BEGIN     
		SET @TotalRow = ''
		SET @TotalRow = 'COUNT(1) OVER ()' 

	IF ISNULL(@SchoolYearID, '') <> '' 
	SET @sWhere = @sWhere + N' AND NOT EXISTS (SELECT T1.StudentID FROM EDMT2020
														WHERE EDMT2020.APK = T1.APKMaster
														AND EDMT2020.SchoolYearID = '''+@SchoolYearID+''' )'

		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY  T1.StudentID) AS RowNum, ' + @TotalRow + ' AS TotalRow,
		T1.APK, T1.APKMaster, T1.StudentID, T2.StudentName, T2.DateOfBirth, T1.LastModifyDate,
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END + N' as Sex,
		0 as IsTransfer, N''Không điều chuyển'' as TransferName 

		FROM EDMT2021 T1 WITH(NOLOCK)
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0  
		LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T2.SexID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''Sex''
		WHERE T1.APKMaster = ''' + @APK + ''' AND T1.IsTransfer IN (0,2) AND T1.DeleteFlg = 0 ' 
		+ @sWhere+
		'ORDER BY T1.StudentID
	'


		--SET @sSQL = @sSQL + 'OFFSET ' + LTRIM(STR((@PageNumber-1)) * @PageSize) + ' ROWS
		--FETCH NEXT ' + LTRIM(STR(@PageSize)) + ' ROWS ONLY'
	END
ELSE IF @Mode = '1'  --EDIT
	BEGIN     
	

		SET @sSQL = 'SELECT 
		T1.APK, T1.APKMaster, T1.StudentID, T2.StudentName,T5.GradeID,T5.ClassID, T2.DateOfBirth, T1.LastModifyDate,
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END +' as Sex,
		IsTransfer, 
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END +' as TransferName
		FROM EDMT2021 T1 WITH(NOLOCK)
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0  
		LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T2.SexID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''Sex''
		LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T1.IsTransfer = T4.ID AND T4.Disabled = 0 AND T4.CodeMaster=''MoveStatus''
		LEFT JOIN EDMT2020 T5 WITH (NOLOCK) ON T5.APK = T1.APKMaster 
		WHERE T1.APKMaster = ''' + @APK + '''  AND T1.DeleteFlg = 0  '
		+ @sWhere+
		'ORDER BY T1.StudentID

	'

	END

ELSE IF @Mode = '2'
BEGIN 
       
		SET @TotalRow = 'COUNT(1) OVER ()'

		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY  T1.StudentID) AS RowNum, ' + @TotalRow + ' AS TotalRow,
		T1.APK, T1.APKMaster, T1.StudentID, T2.StudentName,T5.GradeID,T5.ClassID, T2.DateOfBirth, T1.LastModifyDate,
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END +' as Sex,
		IsTransfer, 
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END +' as TransferName
		FROM EDMT2021 T1 WITH(NOLOCK)
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0  
		LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T2.SexID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''Sex''
		LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T1.IsTransfer = T4.ID AND T4.Disabled = 0 AND T4.CodeMaster=''MoveStatus''
		LEFT JOIN EDMT2020 T5 WITH (NOLOCK) ON T5.APK = T1.APKMaster 
		WHERE T1.APKMaster = ''' + @APK + ''' AND T1.DeleteFlg = 0 '
		+ @sWhere+
		'ORDER BY T1.StudentID

		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'

END 


PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
