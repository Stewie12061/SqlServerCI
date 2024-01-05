IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load danh mục thực phẩm (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
	NMP1033 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,@APK= '995FCF24-241A-4E55-B197-6F3BCC15D092'

----*/

CREATE PROCEDURE NMP1033
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50)
	

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N01.SystemName'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'



SET @sSQL = @sSQL + N'
			SELECT DISTINCT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
			 N.APK, N.DivisionID, N.SystemID,N01.SystemName,N.QuotaStandard,N.MinRatio,N.MaxRatio,N.CreateUserID,N.CreateDate,N.LastModifyUserID,N.LastModifyDate
			 from NMT1031 N WITH(NOLOCK) left join NMT0001 N01 WITH (NOLOCK)on N.DivisionID IN ('''+@DivisionID+''',''@@@'') and N.SystemID=N01.SystemID
			 
			
			WHERE N.APKMaster='''+@APK+''' and N.DivisionID='''+@DivisionID+'''
			ORDER BY '+@OrderBy+' 
	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


EXEC (@sSQL)
--PRINT(@sSQL)

   





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


