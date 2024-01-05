IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- In bao cao Doanh số bán hàng theo khu vực - SOR3005
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 26/06/2017 by Phan thanh hoàng Vũ
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
---- Modify by Đình Hòa, Date 20/07/2020: Load giá trị theo khu vực là mã đối tượng (mã phân tích số 1)
---- Modify by Anh Đô,   Date 26/10/2022: Chỉnh sửa điều kiện lọc
---- Modify by Anh Đô,   Date 30/11/2022: Fix lỗi không hiển thị được khu vực khi search khu vực theo chuẩn
---- Modify by Anh Đô,   Date 09/02/2023: Bổ sung cột tổng doanh số của mỗi khách hàng của nhân viên (SumEachObjectID)
-- <Example> EXEC SOP30051 'AS',  'AS'',''GS'',''GC', '01/2017'',''02/2017'',''03/2017'',''04/2017'',''05/2017', '', '', '', '', '', '', '', 'VU'

CREATE PROCEDURE [dbo].[SOP30051] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@PeriodIDList		NVARCHAR(2000),
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@ObjectID			NVARCHAR(MAX),
				@SalesManID			NVARCHAR(MAX),
				@AreaID				NVARCHAR(MAX),
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR(Max),
				@FromObjectID		NVARCHAR(MAX) = '',
				@ToObjectID			NVARCHAR(MAX) = '',
				@FromSalesManID		NVARCHAR(MAX) = '',
				@ToSalesManID		NVARCHAR(MAX) = '',
				@FromAreaID			NVARCHAR(MAX) = '',
				@ToAreaID			NVARCHAR(MAX) = ''
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max),
			@CustomerIndex int,
			@SQLLEFTJOINAREA nvarchar(max),
			@SQLDisplayArea nvarchar(max)
	Set @SQLLEFTJOINAREA = ''
	SET @SQLDisplayArea = ''
	Set @sWhere = ''

	SELECT @CustomerIndex = CONVERT(INT, c.CustomerName) FROM CustomerIndex c
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+@DivisionID+''''	

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),M.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'

		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''
								+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''
								+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') >= N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') <= N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''
	ELSE IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '',''))'

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''
	ELSE IF ISNULL(@SalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @SalesManID +''', '',''))'

	IF @CustomerIndex IN (92, -1)
	Begin
		--Search theo khu vực (khu vực theo chuẩn)
		IF Isnull(@FromAreaID, '')!= '' and Isnull(@ToAreaID, '') = ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1003.AreaID, '''') >= N'''+@FromAreaID +''''
		ELSE IF Isnull(@FromAreaID, '') = '' and Isnull(@ToAreaID, '') != ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1003.AreaID, '''') <= N'''+@ToAreaID +''''
		ELSE IF Isnull(@FromAreaID, '') != '' and Isnull(@ToAreaID, '') != ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1003.AreaID, '''') Between N'''+@FromAreaID+''' AND N'''+@ToAreaID+''''
		ELSE IF ISNULL(@AreaID, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(AT1003.AreaID, '''') IN ('''+ @AreaID +''')'

		SET @SQLLEFTJOINAREA = @SQLLEFTJOINAREA + 'LEFT JOIN AT1003 WITH (NOLOCK) ON AT1003.AreaID = AT1202.AreaID'
		Set @SQLDisplayArea = @SQLDisplayArea + ', Isnull(AT1003.AreaID, ''-'') as AreaID, Isnull(AT1003.AreaName, ''-'') as AreaName'
		
	End
	Else
	Begin
		--Search theo khu vực (khu vực theo mã đối tượng - mã phân tích số 1)
		IF Isnull(@FromAreaID, '')!= '' and Isnull(@ToAreaID, '') = ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1015.AnaID, '''') >= N'''+@FromAreaID +''''
		ELSE IF Isnull(@FromAreaID, '') = '' and Isnull(@ToAreaID, '') != ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1015.AnaID, '''') <= N'''+@ToAreaID +''''
		ELSE IF Isnull(@FromAreaID, '') != '' and Isnull(@ToAreaID, '') != ''
			SET @sWhere = @sWhere + ' AND Isnull(AT1015.AnaID, '''') Between N'''+@FromAreaID+''' AND N'''+@ToAreaID+''''
		ELSE IF ISNULL(@AreaID, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(AT1015.AnaID, '''') IN ('''+ @AreaID +''')'
		SET @SQLLEFTJOINAREA = @SQLLEFTJOINAREA + 'LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = AT1202.O01ID and AT1015.AnaTypeID = ''O01'''
		Set @SQLDisplayArea = @SQLDisplayArea + ', Isnull(AT1202.O01ID, ''-'') as AreaID, Isnull(AT1015.AnaName, ''-'') as AreaName'
	end
	---Phân quyền dữ liệu
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, M.CreateUserID) in ('''+@ConditionSOrderID+''')'
	
	SET @sSQL = '  
					Select   M.DivisionID, AT1101.DivisionName, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''
							+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''
							+ltrim(Rtrim(str(M.TranYear))) End) as Period
							, M.SalesManID, AT1103.FullName as SalesManName
							' + @SQLDisplayArea	+ '
							, M.ObjectID, POST0011.MemberName as ObjectName
							, D.ConvertedAmount
							into #OT2001
					From  OT2001 M WITH (NOLOCK)
							INNER JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.SorderID = D.SorderID and M.OrderType = 0 and M.IsConfirm = 1
							Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = M.ObjectID
							LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = M.SalesManID
							LEFT JOIN POST0011 WITH (NOLOCK) ON POST0011.MemberID = M.ObjectID
							' + @SQLLEFTJOINAREA +' 
							LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = M.DivisionID
					Where ' + @sWhere +' 
					
				
					DECLARE @columns NVARCHAR(MAX), 
							@sql NVARCHAR(MAX);
					SET @columns = N'''';
					
					SELECT @columns += N'', '' + quotename(Period)
					FROM (SELECT Period FROM #OT2001 group by Period ) AS x;

					DECLARE @SumEachObjectID NVARCHAR(MAX) = N''''
					SELECT @SumEachObjectID += N''+ '' + ''COALESCE('' + QUOTENAME(Period) + '', 0)''
					FROM (SELECT Period FROM #OT2001 group by Period) AS x;
					
					SET @SumEachObjectID = SUBSTRING(@SumEachObjectID, 2, LEN(@SumEachObjectID))

					SET @sql = N''
					SELECT X.*, ''+@SumEachObjectID+'' AS SumEachObjectID FROM (
					SELECT DivisionID, DivisionName, AreaID, SalesManName, ObjectName, AreaName,  '' + STUFF(@columns, 1, 2, '''') + ''
					FROM (SELECT DivisionID, DivisionName, AreaID, SalesManName, ObjectName, ConvertedAmount, Period, AreaName
						  FROM  #OT2001 )
						  AS j PIVOT (SUM(ConvertedAmount) FOR Period IN (''
									  + STUFF(REPLACE(@columns, '', ['', '',[''), 1, 1, '''')
									  + '')) AS p) X'';

					EXEC sp_executesql @sql;

					SELECT DivisionID, Period FROM #OT2001 GROUP BY DivisionID, Period

					'
	--PRINT(@sSQL)
	EXEC (@sSQL)

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
