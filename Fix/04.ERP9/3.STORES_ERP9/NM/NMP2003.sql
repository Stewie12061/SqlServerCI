IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load màn hình chọn thuc don tong
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
    EXEC NMP2003 'BS', '12',null,1,25
*/

 CREATE PROCEDURE NMP2003 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 
 
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'VoucherNo'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (VoucherNo LIKE N''%'+@TxtSearch+'%''
									Or Description LIKE N''%'+@TxtSearch+'%''
									Or VoucherDate LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
				APK,DivisionID,VoucherNo,VoucherDate,TranMonth,TranYear,
				MenuTypeID,BeginDate,FinishDate,Description,DeleteFlg,
				CreateUserID,CreateDate,LastModifyUserID,LastModifyDate
				FROM NMT2000 N
				WHERE DivisionID  IN ('''+@DivisionID+''' ,''@@@'')
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
