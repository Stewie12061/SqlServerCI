IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục biểu phí \ Cập nhật đưa đón \ Lưới
-- <History>
----Created by: Lương Mỹ, Date: 02/01/2019
---- Modified by on 
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE EDMP1112
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''

        
SET @OrderBy = 'T1.StudentID'


SET @sSQL = @sSQL + N'
SELECT 
T1.APK, T1.DivisionID, T1.StudentID,  T2.StudentName 
FROM EDMT1111 T1 WITH (NOLOCK)
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID
WHERE T1.APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy


--PRINT(@sSQL)
EXEC (@sSQL)


   





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
