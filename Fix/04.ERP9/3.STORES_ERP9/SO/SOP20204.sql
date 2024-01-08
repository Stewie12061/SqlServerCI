IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20204]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP20204]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn báo giá
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
----Modify by Thị Phượng Date 12/05/2017 Bổ sung phân quyền xem dữ liệu
----Modify by Trọng Kiên Date 23/11/2020: Bổ sung điều kiện load dữ liệu báo giá khi gọi từ cơ hội
-- <Example>
/*

	exec sp_executesql N'SOP20204 @DivisionID=N''AS'',@TxtSearch=N'''',@UserID=N''CALL002'',@PageNumber=N''1'',@PageSize=N''10''',N'@CreateUserID nvarchar(7),@LastModifyUserID nvarchar(7),@DivisionID nvarchar(2)',@CreateUserID=N'CALL002',@LastModifyUserID=N'CALL002',@DivisionID=N'AS'

*/

 CREATE PROCEDURE SOP20204 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ConditionQuotationID NVARCHAR(Max),
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
	SET @OrderBy = ' M.QuotationNo, M.QuotationDate'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.QuotationNo LIKE N''%'+@TxtSearch+'%'' 
							OR M.QuotationDate LIKE N''%'+@TxtSearch+'%'' 
							OR M.ObjectID LIKE N''%'+@TxtSearch+'%'' 
							OR M.ObjectName LIKE N''%'+@TxtSearch+'%'' 
							OR D2.Description LIKE N''%'+@TxtSearch + '%'' 
							OR M.EmployeeID LIKE N''%'+@TxtSearch+'%'')'
	IF Isnull(@ConditionQuotationID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EmployeeID, M.CreateUserID) IN ('''+@ConditionQuotationID+''') '
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, M.APK, M.DivisionID
					, M.QuotationNo, convert(Varchar(50),M.QuotationDate,103) as QuotationDate
					, M.ObjectID
					, M.ObjectName
					, isnull(Sum(D.OriginalAmount) ,0) AS SumAmount
					, M.QuotationID
					, D2.Description AS QuotationStatus
					, M.Description
					, M.EmployeeID, D1.FullName AS EmployeeName
					, D3.Description AS IsConfirm
					, M.VoucherTypeID, M.CurrencyID, M.OrderStatus
					, M.EndDate, M.ConfirmDate
					, M.ConfirmUserID, M.OpportunityID
					, M.InventoryTypeID
					, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate
			FROM OT2101 M WITH (NOLOCK)   INNER JOIN OT2102 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.QuotationID = D.QuotationID
											 LEFT JOIN AT1103 D1 WITH (NOLOCK) ON M.EmployeeID = D1.EmployeeID
											 LEFT JOIN CRMT0099 D2 WITH (NOLOCK) ON M.QuotationStatus = D2.ID AND D2.CodeMaster = ''CRMT00000015''
											 LEFT JOIN AT0099 D3 WITH (NOLOCK) ON M.IsConfirm = D3.ID AND D3.CodeMaster = ''AT00000039''
				WHERE M.DivisionID = '''+@DivisionID+''' AND (ISNULL(IsConfirm,0) = 1 OR ISNULL(M.OrderStatus, 0) = 1)  '+@sWhere+'
				GROUP BY M.APK, M.DivisionID, M.QuotationNo, M.QuotationDate, M.ObjectID, M.ObjectName, M.QuotationID
					, D2.Description, M.Description, M.EmployeeID, D1.FullName, D3.Description, M.VoucherTypeID, M.CurrencyID, M.OrderStatus
					, M.EndDate, M.ConfirmDate, M.ConfirmUserID, M.OpportunityID, M.InventoryTypeID, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)
		---Print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
