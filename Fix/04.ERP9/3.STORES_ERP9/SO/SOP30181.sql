IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30181]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30181]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- In báo cáo tổng hợp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 24/12/2017 by Minh Hiếu
---- Update ON 10/02/2023 by Anh Đô: Bổ sung thêm cột tổng doanh số của mỗi nhân viên (SumEachSalesManID); chỉnh sửa điều kiện lọc; select thêm cột DepartmentName
-- <Example> 
--exec sp_executesql N'EXEC SOP30181 @DivisionID=N''VNA'',@DivisionIDList=''HN'''',''''VNA'',@FromDate=N''2021-12-01 00:00:00'',@ToDate=N''2021-12-29 00:00:00'',@IsDate=1,@PeriodIDList=null,@FromSalesManID=N''ADMIN,HCM-AM01,HCM-KD01,HCM-KT01,HCM-KT02,HCM-KT03,HCM-KT08,HCM-XNK01,HIU,HIU1,HIU2,HN-KD01,HN-KD03,HN-KT01,HN-KT02,NV06,TEST001,TEST002,UNASSIGNED'',@DepartmentIDList=''BOD'''',''''PAM-HCM'''',''''PAM-HN'''',''''PB01'''',''''PBV-HCM'''',''''PBV-HN'''',''''PGD'''',''''PGN-HCM'''',''''PGN-HN'''',''''PKD-HCM'''',''''PKD-HN'''',''''PK-HCM'''',''''PK-HN'''',''''PKT-HCM'''',''''PKT-HN'''',''''PTV-HCM'''',''''PTV-HN'''',''''PTX-HCM'''',''''PTX-HN'''',''''PXNK-HCM'''',''''PXNK-HN''',N'@CreateUserID nvarchar(4),@LastModifyUserID nvarchar(4),@DivisionID nvarchar(3)',@CreateUserID=N'HIU2',@LastModifyUserID=N'HIU2',@DivisionID=N'VNA'
--exec sp_executesql N'EXEC SOP30181 @DivisionID=N''VNA'',@DivisionIDList=''HN'''',''''VNA'',@FromDate='''',@ToDate='''',@IsDate=0,@PeriodIDList=''11/2021'',@FromSalesManID=N''ADMIN,HCM-AM01,HCM-KD01,HCM-KT01,HCM-KT02,HCM-KT03,HCM-KT08,HCM-XNK01,HIU,HIU1,HIU2,HN-KD01,HN-KD03,HN-KT01,HN-KT02,NV06,TEST001,TEST002,UNASSIGNED'',@DepartmentIDList=''BOD'''',''''PAM-HCM'''',''''PAM-HN'''',''''PB01'''',''''PBV-HCM'''',''''PBV-HN'''',''''PGD'''',''''PGN-HCM'''',''''PGN-HN'''',''''PKD-HCM'''',''''PKD-HN'''',''''PK-HCM'''',''''PK-HN'''',''''PKT-HCM'''',''''PKT-HN'''',''''PTV-HCM'''',''''PTV-HN'''',''''PTX-HCM'''',''''PTX-HN'''',''''PXNK-HCM'''',''''PXNK-HN''',N'@CreateUserID nvarchar(4),@LastModifyUserID nvarchar(4),@DivisionID nvarchar(3)',@CreateUserID=N'HIU2',@LastModifyUserID=N'HIU2',@DivisionID=N'VNA'

CREATE PROCEDURE [dbo].[SOP30181] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				--@FromObjectID		NVARCHAR(MAX),
				@FromSalesManID		NVARCHAR(MAX),
				--@FromInventoryID	NVARCHAR(MAX),
				@DepartmentIDList		NVARCHAR(MAX)
				--@UserID				NVARCHAR(50),	--Biến môi trường
				--@ConditionSOrderID  NVARCHAR(Max),
				--@ConditionOpportunityID nvarchar(max)	--Biến môi trường
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sSQL1 NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sWhere1 NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max)
	Set @sWhere = ''
	Set @sWhere1 = ''
 CREATE TABLE #Temp(
	APK uniqueidentifier default newid() PRIMARY KEY,
	DivisionID VARCHAR(50),
	DivisionName VARCHAR(50),
	SalesManID VARCHAR(50),
	FullName NVARCHAR(50),
	DepartmentID VARCHAR(50),
	Amount01 DECIMAL(28,1) default 0,
	Amount02 DECIMAL(28,1) default 0,
	Amount03 DECIMAL(28,1) default 0,
	Amount04 DECIMAL(28,1) default 0,
	Amount05 DECIMAL(28,1) default 0,
	Amount06 DECIMAL(28,1) default 0,
	Amount07 DECIMAL(28,1) default 0,
	Amount08 DECIMAL(28,1) default 0,
	Amount09 DECIMAL(28,1) default 0,
	Amount10 DECIMAL(28,1) default 0,
	Amount11 DECIMAL(28,1) default 0,
	Amount12 DECIMAL(28,1) default 0,
	Amount13 DECIMAL(28,1) default 0,
	Amount14 DECIMAL(28,1) default 0,
	Amount15 DECIMAL(28,1) default 0,
	Amount16 DECIMAL(28,1) default 0,
	Amount17 DECIMAL(28,1) default 0,
	Amount18 DECIMAL(28,1) default 0,
	Amount19 DECIMAL(28,1) default 0,
	Amount20 DECIMAL(28,1) default 0,
	Amount21 DECIMAL(28,1) default 0,
	Amount22 DECIMAL(28,1) default 0,
	Amount23 DECIMAL(28,1) default 0,
	Amount24 DECIMAL(28,1) default 0,
	Amount25 DECIMAL(28,1) default 0,
	Amount26 DECIMAL(28,1) default 0,
	Amount27 DECIMAL(28,1) default 0,
	Amount28 DECIMAL(28,1) default 0,
	Amount29 DECIMAL(28,1) default 0,
	Amount30 DECIMAL(28,1) default 0,
	Amount31 DECIMAL(28,1) default 0,
	Amount3 DECIMAL(28,1) default 0,
	Total DECIMAL(28,1) default 0,
	TotalM DECIMAL(28,1) default 0
)

CREATE TABLE #TempDate(
	APK INT IDENTITY(1,1) PRIMARY KEY,
	Date date
)

		--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = ' O01.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			--SET @sWhere = ' O01.DivisionID = N'''+@DivisionID+''''
			SET @sWhere = ' O01.DivisionID IN ('''+@DivisionIDList+''')'

		--Search theo điều điện thời gian
		IF @IsDate = 1	
		BEGIN

			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,O01.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

		END
		ELSE
		BEGIN
			SET @sWhere = @sWhere + ' AND (Case When  O01.TranMonth <10 then ''0''+rtrim(ltrim(str(O01.TranMonth)))+''/''
											+ltrim(Rtrim(str(O01.TranYear))) Else rtrim(ltrim(str(O01.TranMonth)))+''/''
											+ltrim(Rtrim(str(O01.TranYear))) End) IN ('''+@PeriodIDList+''')'
		END

		--phòng ban
		IF Isnull(@DepartmentIDList, '') != ''
		SET @sWhere = @sWhere + ' AND DT.DepartmentID IN ('''+@DepartmentIDList+''')'

		--nhân viên
		IF ISNULL(@FromSalesManID,'') <> ''
		SET @sWhere = @sWhere + ' AND DT.SalesManID IN (SELECT Value FROM [dbo].StringSplit('''+@FromSalesManID+''', '',''))'


		SET @sWhere1 = @sWhere1 + ' AND CONVERT(VARCHAR,DT.Date,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

			-- Đổ danh sách nhân viên vào bảng nhân viên
			SELECT Value AS SalesManID
			INTO #Employee
			FROM dbo.StringSplit(@FromSalesManID, ',')

			INSERT INTO #Temp ( APK,DivisionID,DivisionName, SalesManID, FullName, DepartmentID, Amount01,Amount02,Amount03,Amount04,Amount05,Amount06,Amount07,
								Amount08,Amount09,Amount10,Amount11,Amount12,Amount13,Amount14,Amount15,Amount16,Amount17,Amount18,Amount19,
								Amount20,Amount21,Amount22,Amount23,Amount24,Amount25,Amount26,Amount27,Amount28,Amount29,Amount30,Amount31, Total, TotalM )
			SELECT 	NEWID(),AT03.DivisionID,AT04.DivisionName,  AT01.SalesManID, AT03.FullName, AT03.DepartmentID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					
			FROM #Employee AS AT01
			--LEFT JOIN AT1103 AS AT03 WITH (NOLOCK) ON AT03.DivisionID = @DivisionID
			--											AND AT03.EmployeeID = AT01.SalesManID
			LEFT JOIN AT1103 AS AT03 WITH (NOLOCK) ON AT03.EmployeeID = AT01.SalesManID
			LEFT JOIN AT1101 AS AT04 WITH (NOLOCK) ON AT04.DivisionID = AT03.DivisionID
			
			DECLARE @Number1 INT = 1, @SalesManID NVARCHAR(200) ;
			DECLARE @Number INT = 1, @NumberD INT = 0, @TotalS DECIMAL(28,1);
			IF @IsDate = 0
			BEGIN
				SET @FromDate = (SELECT (SELECT SUBSTRING(@PeriodIDList, 4, 5))+'-'+(SELECT SUBSTRING(@PeriodIDList, 1, 2))+'-'+'01')
				SET @ToDate = (SELECT SUBSTRING((select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,@FromDate))),dateadd(m,1,@FromDate)),121)),1,10))
			END
			DECLARE @CountDate INT = (SELECT DATEDIFF(day, @FromDate, @ToDate));
			IF @CountDate > 31
				SET @CountDate = 31
			WHILE @Number1 < = (SELECT count(*) FROM dbo.StringSplit(@FromSalesManID, ','))
			BEGIN
				SET @SalesManID = (SELECT Value FROM(
									SELECT ROW_NUMBER() OVER (ORDER BY Value ASC) AS rownumber,Value
									FROM dbo.StringSplit(@FromSalesManID, ',')
									)AS foo
									WHERE rownumber = @Number1)
					
				WHILE @Number <= @CountDate + 1
				BEGIN	
						INSERT INTO #TempDate (Date) VALUES(DATEADD(DAY,@NumberD,@FromDate)) 

						print(@CountDate)
						print(DATEADD(DAY,@NumberD,@FromDate))


						SET @TotalS = (select distinct SUM(O02.ConvertedAmount) AS Total 
										FROM OT2001 O01 WITH (NOLOCK)
										LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
										LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON O01.SalesManID = AT03.EmployeeID
										where O01.SalesManID = @SalesManID and O01.OrderDate = DATEADD(DAY,@NumberD,@FromDate))
						UPDATE #Temp
						SET Amount01 = CASE WHEN @Number = 1 THEN @TotalS ELSE Amount01 END,
							Amount02 = CASE WHEN @Number = 2 THEN @TotalS ELSE Amount02 END,
							Amount03 = CASE WHEN @Number = 3 THEN @TotalS ELSE Amount03 END,
							Amount04 = CASE WHEN @Number = 4 THEN @TotalS ELSE Amount04 END,
							Amount05 = CASE WHEN @Number = 5 THEN @TotalS ELSE Amount05 END,
							Amount06 = CASE WHEN @Number = 6 THEN @TotalS ELSE Amount06 END,
							Amount07 = CASE WHEN @Number = 7 THEN @TotalS ELSE Amount07 END,
							Amount08 = CASE WHEN @Number = 8 THEN @TotalS ELSE Amount08 END,
							Amount09 = CASE WHEN @Number = 9 THEN @TotalS ELSE Amount09 END,
							Amount10 = CASE WHEN @Number = 10 THEN @TotalS ELSE Amount10 END,
							Amount11 = CASE WHEN @Number = 11 THEN @TotalS ELSE Amount11 END,
							Amount12 = CASE WHEN @Number = 12 THEN @TotalS ELSE Amount12 END,
							Amount13 = CASE WHEN @Number = 13 THEN @TotalS ELSE Amount13 END,
							Amount14 = CASE WHEN @Number = 14 THEN @TotalS ELSE Amount14 END,
							Amount15 = CASE WHEN @Number = 15 THEN @TotalS ELSE Amount15 END,
							Amount16 = CASE WHEN @Number = 16 THEN @TotalS ELSE Amount16 END,
							Amount17 = CASE WHEN @Number = 17 THEN @TotalS ELSE Amount17 END,
							Amount18 = CASE WHEN @Number = 18 THEN @TotalS ELSE Amount18 END,
							Amount19 = CASE WHEN @Number = 19 THEN @TotalS ELSE Amount19 END,
							Amount20 = CASE WHEN @Number = 20 THEN @TotalS ELSE Amount20 END,
							Amount21 = CASE WHEN @Number = 21 THEN @TotalS ELSE Amount21 END,
							Amount22 = CASE WHEN @Number = 22 THEN @TotalS ELSE Amount22 END,
							Amount23 = CASE WHEN @Number = 23 THEN @TotalS ELSE Amount23 END,
							Amount24 = CASE WHEN @Number = 24 THEN @TotalS ELSE Amount24 END,
							Amount25 = CASE WHEN @Number = 25 THEN @TotalS ELSE Amount25 END,
							Amount26 = CASE WHEN @Number = 26 THEN @TotalS ELSE Amount26 END,
							Amount27 = CASE WHEN @Number = 27 THEN @TotalS ELSE Amount27 END,
							Amount28 = CASE WHEN @Number = 28 THEN @TotalS ELSE Amount28 END,
							Amount29 = CASE WHEN @Number = 29 THEN @TotalS ELSE Amount29 END,
							Amount30 = CASE WHEN @Number = 30 THEN @TotalS ELSE Amount30 END,
							Amount31 = CASE WHEN @Number = 31 THEN @TotalS ELSE Amount31 END
						FROM #Temp AS DT
						LEFT JOIN OT2001 O01 WITH (NOLOCK) ON DT.DivisionID = O01.DivisionID
						LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
						LEFT JOIN #Employee HT14 WITH (NOLOCK) ON HT14.SalesManID = O01.SalesManID
						WHERE O01.OrderDate = DATEADD(DAY,@NumberD,@FromDate) and DT.SalesManID = @SalesManID and O01.SalesManID = @SalesManID
					
					SET @Number = @Number + 1;
					SET @NumberD = @NumberD + 1;
				END

				SET @Number = 1;
				SET @NumberD = 0;
				SET @Number1 = @Number1 + 1 ;
			END


			SET @sSQL = 'select distinct DT.DivisionID,DT.DivisionName,DT.SalesManID,DT.FullName,DT.DepartmentID,Amount01,Amount02,Amount03,Amount04,Amount05,Amount06,Amount07,
										Amount08,Amount09,Amount10,Amount11,Amount12,Amount13,Amount14,Amount15,Amount16,Amount17,Amount18,
										Amount19,Amount20,Amount21,Amount22,Amount23,Amount24,Amount25,Amount26,Amount27,Amount28,Amount29,
										Amount30,Amount31
										,AT02.DepartmentName
										,(
											Amount01 + Amount02 + Amount03 + Amount04 + Amount05 + Amount06 + Amount07 + Amount08 + Amount09 + Amount10
											+ Amount11 + Amount12 + Amount13 + Amount14 + Amount15 + Amount16 + Amount17 + Amount18 + Amount19 + Amount20
											+ Amount21 + Amount22 + Amount23 + Amount24 + Amount25 + Amount26 + Amount27 + Amount28 + Amount29 + Amount30
											+ Amount31
										) AS SumEachSalesManID
				from #Temp DT 
				LEFT JOIN OT2001 O01 WITH (NOLOCK) ON DT.DivisionID = O01.DivisionID
				LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
				LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON O01.SalesManID = AT03.EmployeeID
				LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DepartmentID = DT.DepartmentID AND AT02.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
				Where '+@sWhere+'
				ORDER BY DT.DivisionID,DT.DepartmentID, DT.SalesManID'

			EXEC (@sSQL)



			IF @IsDate = 1
			BEGIN

				SET @sSQL1 = 'select distinct Date 
								From #TempDate DT
								Where APK < 32
								'+@sWhere1+''
				EXEC (@sSQL1)

			END
			ELSE
			BEGIN
				SET @sSQL1 = 'select distinct Date 
								From #TempDate DT
								Where APK < 32'
			END
			EXEC (@sSQL1)
			--PRINT (@sSQL + @sSQL1)

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
