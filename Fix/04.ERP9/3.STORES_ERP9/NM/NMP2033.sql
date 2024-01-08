IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn phieu kê chợ
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>/
----Created by: Trà Giang on 18/09/2018
-- <Example>
/*
    EXEC NMP2033 'BS', '',null,1,25,'2018-06-01 00:00:00.000',''
*/

 CREATE PROCEDURE NMP2033 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @MenuVoucherDate DATETIME,
	 @FormID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 
 
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'MarketVoucherNo, MarketVoucherDate'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (MarketVoucherNo LIKE N''%'+@TxtSearch+'%'' 
									OR Description LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, APK
							, DivisionID,  MarketVoucherNo, MarketVoucherDate, Description
						
				FROM NMT2020 N
				WHERE DivisionID  IN ('''+@DivisionID+''' ,''@@@'') and DeleteFlg=0 
				  '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
