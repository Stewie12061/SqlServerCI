IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9096]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9096]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
---- Đổ nguồn lưới danh sách ngân sách
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 30/10/2018
---- Modified by Lê Hoàng on 24/08/2021: Bổ sung trả thêm trường Loại ngân sách chi phí / doanh thu (BudgetKindID,BudgetKindName)
---- Modified by ... on ...:
----<Example>
/*
	EXEC TP9096 'VF', 0, 'Q', 11, 2018,'2018-10-29 00:00:00.000', '2018-10-30 00:00:00.000', 'DN',1,25
	EXEC TP9096 @DivisionID, @Status, @BudgetType, @TranMonth, @TranYear, @FromDate, @ToDate, @DepartmentID, @PageNumber, @PageSize
*/
CREATE PROCEDURE [dbo].[TP9096] 	
(
	@DivisionID NVARCHAR(50),
	@DivisionList NVARCHAR(Max),
	@Status INT,
	@BudgetType NVARCHAR(Max),
	@Month INT,
	@Year INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@DepartmentID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@BudgetKindID NVARCHAR(50) = ''
)
AS


DECLARE @SQL NVARCHAR(MAX),
		@WHERE NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'VoucherNo'

IF ISNULL(@DivisionList, '') <> '' 
SET @WHERE = @WHERE + ' AND T21.DivisionID IN ('''+@DivisionList+''')'
ELSE 
SET @WHERE = @WHERE + ' AND T21.DivisionID = '''+@DivisionID+''''

IF ISNULL(STR(@Status),'')<>''
SET @WHERE = @WHERE + N' 
				AND T21.Status = '+STR(@Status)+''
IF ISNULL(@BudgetType,'')<> ''
SET @WHERE = @WHERE + N' 
				AND T21.BudgetType = '''+@BudgetType+''''
IF ISNULL(@Month,'')<>''
SET @WHERE = @WHERE + N' 
				AND T21.MonthBP = '+Ltrim(@Month)+''
IF ISNULL(@Year,'')<>''
SET @WHERE = @WHERE + N' 
				AND T21.YearBP = '+Ltrim(@Year)+''
IF ISNULL(@FromDate,'') <> ''
SET @WHERE = @WHERE + N'
				AND CONVERT(Varchar(20),T21.VoucherDate,120) >= '''+CONVERT(Varchar(20),@FromDate,120)+''' '

IF ISNULL(@ToDate,'') <> ''
SET @WHERE = @WHERE + N'
				AND CONVERT(Varchar(20),T21.VoucherDate,120) <= '''+CONVERT(Varchar(20),@ToDate,120)+''' '

IF ISNULL(@BudgetKindID,'') <> ''
	SET @WHERE = @WHERE + N' 
				AND T21.BudgetKindID = '''+@BudgetKindID+''''

IF ISNULL(@DepartmentID,'')<> ''
SET @WHERE = @WHERE + N'
				AND T11.AnaName Like N''%'+@DepartmentID+'%'''


SET @SQL= N'		
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,	
				T21.APK, T21.APKMaster_9000, T21.DivisionID, T21.TranMonth, T21.TranYear, T21.VoucherTypeID, T21.VoucherNo, T21.VoucherDate,
				T21.BudgetType, T99.Description As BudgetTypeName, 
				T21.Description,T21.CurrencyID,T04.CurrencyName,
				T21.ExchangeRate,T21.DepartmentID,T11.AnaName As DepartmentName,
				T21.Status, T09.Description As StatusName,
				T21.BudgetKindID, T10.Description As BudgetKindName,
				T21.ApprovalDate,T21.CreateDate,T21.CreateUserID,T21.LastModifyDate,T21.LastModifyUserID,T21.DeleteFlag
		FROM	TT2100 T21 WITH (NOLOCK)
		LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T21.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
		LEFT JOIN AT0099 T09 WITH (NOLOCK) ON T21.Status = T09.ID AND T09.CodeMaster = ''Status''
		LEFT JOIN AT1011 T11 WITH (NOLOCK) ON T21.DepartmentID = T11.AnaID AND T11.AnaTypeID = ''A03''
		LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T21.CurrencyID = T04.CurrencyID
		LEFT JOIN AT0099 T10 WITH (NOLOCK) ON T21.BudgetKindID = T10.ID AND T10.CodeMaster = ''BudgetKind'' AND T10.Disabled = 0
		WHERE	T21.DeleteFlag = 0 '+@WHERE+'
		ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@SQL)
--PRINT @SQL





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
