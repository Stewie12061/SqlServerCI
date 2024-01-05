IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load dữ liệu bảng HRMT2150 theo điều kiện.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date 03/11/2020
----Modified by: 

CREATE PROCEDURE HRMP2150 
( 
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@VoucherNo VARCHAR(50),
	@TranMonth NVARCHAR(10),
	@TranYear NVARCHAR(10),
	@Description NVARCHAR(500),
	@PageNumber INT,
	@PageSize INT,
	@UserID NVARCHAR(50),
	@ConditionRecDecisionNo VARCHAR(MAX)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@sSQLPermission VARCHAR(MAX)
        
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'B1.VoucherNo'
-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionIDList + ''') '
ELSE
	SET @sWhere = @sWhere + ' (B1.DivisionID = ''' + @DivisionID + ''') '

IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'') '

IF ISNULL(@TranMonth, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.TranMonth, '''') = ''' + @TranMonth + ''') '

IF ISNULL(@TranYear, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.TranYear, '''') = ''' + @TranYear + ''') '

IF ISNULL(@Description, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.Description, '''') = ''' + @Description + ''') '

IF Isnull(@ConditionRecDecisionNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(B1.CreateUserID,'''') in (N'''+@ConditionRecDecisionNo+''','''+@UserID+''' )'

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
				, COUNT(*) OVER () AS TotalRow
				, B1.APK
				, B1.DivisionID
				, B1.VoucherDate
				, B1.VoucherNo
				, B1.TranMonth
				, B1.TranYear
				, B1.CreateUserID
				, B1.CreateDate
				, B1.LastModifyUserID
				, B1.LastModifyDate
				, B1.Description
			FROM HRMT2150 B1 WITH (NOLOCK)
			WHERE ISNULL(B1.DeleteFlg,0) = 0 AND '+@sWhere+'
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

