IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In bao cao Doanh số trung bình của công ty - SOR3007
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create On 30/06/2017 by Cao Thị Phượng
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modified By Hoài Bảo Date 12/10/2022 Bổ sung load thêm tổng số đơn hàng, thay đổi param truyền vào theo danh sách
-- <Example> EXEC SOP30071 'AS', '', '04/2017'',''05/2017'',''06/2017', '', '', '', '', '' , 'VU'',''Phuong'

CREATE PROCEDURE [dbo].[SOP30071]
(
		@DivisionID			NVARCHAR(50),	--Biến môi trường
		@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
		@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate			DATETIME, 
		@ToDate				DATETIME,
		@PeriodIDList		NVARCHAR(2000),
		--@FromObjectID		NVARCHAR(MAX),
		--@ToObjectID			NVARCHAR(MAX),
		--@FromSalesManID		NVARCHAR(MAX),
		--@ToSalesManID		NVARCHAR(MAX),
		@ObjectID			NVARCHAR(MAX),
		@EmployeeID		    NVARCHAR(MAX),			
		@UserID				NVARCHAR(50),	--Biến môi trường
		@ConditionSOrderID  NVARCHAR(MAX)	--Biến môi trường
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@sSELECT NVARCHAR(MAX),
			@sGROUPBY NVARCHAR(MAX)
	SET @sWhere = ''
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,ISNULL(M.OrderDate, M.CreateDate),112) BETWEEN ''' + CONVERT(VARCHAR,@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR,@ToDate,112) + ''''
	ELSE
	BEGIN
		IF ISNULL(@PeriodIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
									+ RTRIM(LTRIM(STR(M.TranYear))) ELSE RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
									+ RTRIM(LTRIM(STR(M.TranYear))) END) IN ('''+@PeriodIDList+''')'
		END
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	--IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') > = N'''+@FromObjectID +''''
	--ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') < = N'''+@ToObjectID +''''
	--ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	--IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	--ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	--ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND M.ObjectID IN ('''+@ObjectID +''')'

	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND M.SalesManID IN ('''+@EmployeeID +''')'

	---Phân quyền dữ liệu
	IF ISNULL(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, M.CreateUserID) IN ('''+@ConditionSOrderID+''')'
	
	SET @sSQL = '  
					SELECT M.DivisionID, AT1101.DivisionName, (CASE WHEN M.TranMonth < 10 THEN ''0'' 
								+ RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
								+ RTRIM(LTRIM(STR(M.TranYear))) ELSE RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
								+ RTRIM(LTRIM(STR(M.TranYear))) END) AS Period
							, M.SalesManID, M.SalesManID + '' - '' + AT1103.FullName AS SalesManName
							, CAST(COUNT(Distinct M.SOrderID) AS DECIMAL(28,1)) AS Quantity
							, SUM(D.ConvertedAmount) / CAST(COUNT(DISTINCT M.SOrderID) AS DECIMAL(28,1)) AS AVGAmount
					INTO #TEMOT2001
					FROM OT2001 M WITH (NOLOCK)
						INNER JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.SorderID = D.SorderID AND M.OrderType = 0 AND M.IsConfirm = 1
						LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = M.SalesManID
						LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = M.DivisionID
					WHERE ' + @sWhere +' 
					GROUP BY M.DivisionID, AT1101.DivisionName, (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
								+ RTRIM(LTRIM(STR(M.TranYear))) ELSE RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
								+ RTRIM(LTRIM(STR(M.TranYear))) END), M.SalesManID, AT1103.FullName
				
					DECLARE @columnPeriod NVARCHAR(MAX),
							@columnTotal NVARCHAR(MAX),
							@sql NVARCHAR(MAX),
							@sql1 NVARCHAR(MAX);
					SET @columnPeriod = N'''';
					SET @columnTotal = N'''';
					
					SELECT @columnPeriod += N'', '' + quotename(Period),
						   @columnTotal += N'', '' + quotename(Period + N''Quantity'')
					FROM (SELECT Period FROM #TEMOT2001 GROUP BY Period ) AS x ORDER BY Period;
					
					SET @sql = N''
					SELECT DivisionID, DivisionName, SalesManID, SalesManName, '' + STUFF(@columnPeriod, 1, 2, '''') + ''
					INTO #TempAVG
					FROM
					(
						SELECT DivisionID, DivisionName, SalesManID, SalesManName, AVGAmount, Period
						FROM  #TEMOT2001
					) AS j
					PIVOT
					(
						SUM(AVGAmount) FOR Period IN ('' + STUFF(REPLACE(@columnPeriod, '', ['', '',[''), 1, 1, '''') + '')
					) AS p;

					SELECT DivisionID, DivisionName, SalesManID, SalesManName, '' + STUFF(@columnTotal, 1, 2, '''') + ''
					INTO #TempQuantity
					FROM
					(
						SELECT DivisionID, DivisionName, SalesManID, SalesManName, Quantity, Period + N''''Quantity'''' AS PeriodQuantity
						FROM  #TEMOT2001
					) AS k
					PIVOT
					(
						SUM(Quantity) FOR PeriodQuantity IN ('' + STUFF(REPLACE(@columnTotal, '', ['', '',[''), 1, 1, '''') + '')
					) AS x;

					SELECT * FROM #TempAVG;

					SELECT A1.*, '' + STUFF(@columnTotal, 1, 2, '''') + ''
					FROM #TempAVG A1
					CROSS APPLY (SELECT '' + STUFF(@columnTotal, 1, 2, '''') + '' FROM #TempQuantity A2 WHERE A1.SalesManID = A2.SalesManID) AS K
					'';
					EXEC sp_executesql @sql;
					'
	PRINT (@sSQL)		
	EXEC (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO