IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1094]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1094]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục biểu phí\ Xem thông tin biểu phí/ Tab thông tin chi tiết biểu phí
-- <History>
----Created by: Hồng Thảo, Date: 06/09/2018
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EDMP1094 @DivisionID = 'BE',@APK = '804E3816-8CEA-4EEB-9019-021AD183F0D1', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,@LanguageID = ''
	
	EDMP1094 @DivisionID,@APK, @UserID, @PageNumber, @PageSize,@LanguageID 
----*/

CREATE PROCEDURE EDMP1094 
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LanguageID VARCHAR(50),
	 @FeeType VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''

        
SET @OrderBy = 'T1.ReceiptTypeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.*, T2.ReceiptTypeName, T4.Description as FeeTypeName,T3.Description as UnitName

FROM EDMT1091 T1 WITH (NOLOCK)
INNER JOIN EDMT1050 T2 WITH(NOLOCK) ON T1.ReceiptTypeID = T2.ReceiptTypeID
LEFT JOIN EDMT0099 T3 WITH(NOLOCK) ON T1.UnitID = T3.ID AND T3.CodeMaster=''Time''
LEFT JOIN EDMT0099 T4 WITH(NOLOCK) ON T2.TypeOfFee = T4.ID AND T4.CodeMaster=''TypeOfFee''
WHERE T1.APKMaster = '''+@APK+''' AND T1.FeeType = ''' + @FeeType + '''
ORDER BY '+@OrderBy+'
 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)


   





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
