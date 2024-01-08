IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load màn hình chọn mã phân tích theo AnaTypeID
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Học Huy
-- <Example>
/*
    EXEC sp_executesql N'CMNP90081 @DivisionID=N''MTH'',@UserID=N''HOCHUY'',@PageNumber=N''1'',@PageSize=N''25'',@AnaTypeID=N''I02'',@TxtSearch=N''''',N'@CreateUserID nvarchar(6),@LastModifyUserID nvarchar(6),@DivisionID nvarchar(3)',@CreateUserID=N'HOCHUY',@LastModifyUserID=N'HOCHUY',@DivisionID=N'MTH'
*/

 CREATE PROCEDURE CMNP90081 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(MAX),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @AnaTypeID VARCHAR(50),
	 @AnaTypeID2 VARCHAR(50)=''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'DivisionID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL 
		SET @sWhere = @sWhere +'
			(AnaID LIKE N''%' + dbo._TRIM(@TxtSearch) + '%'' 
			OR AnaName LIKE N''%' + dbo._TRIM(@TxtSearch) + '%'')'
	
	SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow,
			DivisionID, AnaID, AnaName, AnaTypeID  
		FROM (
			SELECT DivisionID, AnaID, AnaName, AnaTypeID  
			FROM AT1015 WITH (NOLOCK)
			WHERE Disabled = 0 
				AND (AnaTypeID= ''' + @AnaTypeID + ''' OR AnaTypeID= ''' + @AnaTypeID2 + ''')
				AND IsCommon = 1
			UNION ALL
			SELECT DivisionID, AnaID, AnaName, AnaTypeID  
			FROM AT1015 WITH (NOLOCK)
			WHERE Disabled = 0 
				AND (AnaTypeID= ''' + @AnaTypeID + ''' OR AnaTypeID= ''' + @AnaTypeID2 + ''')
				AND DivisionID = ''' + @DivisionID + '''
			) AS T
		WHERE ' + @sWhere + '
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

--PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
