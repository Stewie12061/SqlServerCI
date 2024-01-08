IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2170]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2170]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form SOF2170 Nghiệp vụ điều phối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created  by: Kiều Nga, Date 06/09/2022
----Modified by: Văn Tài,  Date 30/05/2023 - Điều phối load theo chứng từ, STT.
-- <Example>
/* 
exec SOP2170 @DivisionID=N'NN'',''TD',@DivisionIDList=N'',@ObjectName=N'',@YearPlan=N'',@Type=N'',@IsDate=1,@FromDate='2018-11-16 00:00:00',@ToDate='2019-11-16 00:00:00',@Period=N'',@UserID=N'SUPPORT2',@SearchWhere=N'',@PageNumber=1,@PageSize=25
*/
----
CREATE PROCEDURE SOP2170 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID	      
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@VoucherNo  VARCHAR(50),
		@Car  VARCHAR(50),
		@EmployeeName  NVARCHAR(MAX),
		@Route  VARCHAR(50),
		@ObjectName  NVARCHAR(MAX),
		@OrderNo  NVARCHAR(50),
		@Address  NVARCHAR(MAX),
		@Status  VARCHAR(10),
		@SearchWhere NVARCHAR(MAX) = NULL,
		@PageNumber INT,
		@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere='WHERE T1.VoucherNo IS NOT NULL AND ISNULL(T1.DeleteFlag,0) = 0 AND '
SET @OrderBy = 'T1.VoucherNo DESC, T1.[Order]'
		IF @IsDate = 1 
		begin
		SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),T1.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		end
	Else 
	BEGIN
		SET @sWhere = @sWhere + ' (Case When  MONTH(T1.VoucherDate) <10 then ''0''+rtrim(ltrim(str(MONTH(T1.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(T1.VoucherDate)))) 
									Else rtrim(ltrim(str(MONTH(T1.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(T1.VoucherDate)))) End) IN ('''+@Period+''')'
	end

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' 
		AND T1.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' 
		AND T1.DivisionID IN ('''+@DivisionID+''')'

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '

	IF ISNULL(@Car, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.Car, '''') LIKE N''%'+@Car+'%'' '
		
	IF ISNULL(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' 
		AND (ISNULL(T1.EmployeeID, '''') LIKE N''%'+@EmployeeName+'%'' OR ISNULL(T3.FullName, '''') LIKE N''%'+@EmployeeName+'%'') '

	IF ISNULL(@Route, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.Route, '''') LIKE N''%'+@Route+'%'' '

	IF ISNULL(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' 
		AND (ISNULL(T1.ObjectID, '''') LIKE N''%'+@ObjectName+'%'' OR ISNULL(T2.ObjectName, '''') LIKE N''%'+@ObjectName+'%'') '

	IF ISNULL(@OrderNo, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.OrderNo, '''') LIKE N''%'+@OrderNo+'%'' '

	IF ISNULL(@Address, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.Address, '''') LIKE N''%'+@Address+'%'' '

	IF ISNULL(@Status, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.Status, ''0'') = ' + @Status + ' '
	
IF ISNULL(@SearchWhere,'')!=''
BEGIN
	IF @SearchWhere LIKE '%IsNull%'
	SET @SearchWhere = REPLACE(@SearchWhere,''',''',',''''')
	IF @SearchWhere LIKE '%DivisionID%'
	SET @SearchWhere = REPLACE(@SearchWhere,'DivisionID','T1.DivisionID')
	SET @sWhere=@SearchWhere;
END

SET @sSQL = ' SELECT
			  T1.APK, 
			  T1.DivisionID, 
			  T1.TranMonth, 
			  T1.TranYear, 
			  T1.VoucherNo, 
			  T1.VoucherDate, 
			  T1.Car, 
			  T1.EmployeeID, 
			  T3.FullName as EmployeeName, 
			  T1.[Order],
			  T1.Route, 
			  T1.ObjectID, 
			  T2.ObjectName, 
			  T1.OrderNo, 
			  T1.Address, 
			  OT02.DeliveryDate, 
			  A.Description as Status, 
			  T1.Notes, 
			  T1.DeleteFlag, 
			  T1.CreateDate, 
			  T1.CreateUserID, 
			  T1.LastModifyUserID, 
			  T1.LastModifyDate 
			INTO #TemSOT2170
			FROM SOT2170 T1 WITH (NOLOCK)
			LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = T1.DivisionID AND OT02.TransactionID = T1.TransactionID
			LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ObjectID = T2.ObjectID
			LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T1.EmployeeID = T3.EmployeeID
			LEFT JOIN SOT0099 A With (NOLOCK) ON ISNULL(T1.Status, 0) = A.ID and A.CodeMaster = ''SOF2170.Status'' and A.Disabled = 0
 '+@sWhere+''

 SET @sSQL1 ='Select ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow, T1.*
	FROM #TemSOT2170 T1
	'+Isnull(@SearchWhere,'')+'
	Order BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)

print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
