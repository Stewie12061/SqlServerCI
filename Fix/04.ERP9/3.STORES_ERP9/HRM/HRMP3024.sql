IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO














-- <Summary>
---- In báo cáo lương theo ngày (ERP 9.9)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 12/02/2019 by Huỳnh Thử
--- Updated on 25/10/2022 by Nhật Thanh: Lấy thêm DepartmentID
--- Updated on 26/10/2022 by Nhật Thanh: Join thêm HT3499 để lấy các cột Income
-- <Example>
---- EXEC HRMP3024 'NTVN0021','BDGHCNS2019','10/2017',''
/*-- <Example>

----*/
CREATE PROCEDURE HRMP3024
( 
	@DivisionID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@TeamID VARCHAR(50),
	@SectionID  VARCHAR(50),
	@ProcessID  VARCHAR(50),
	@FromDate  DateTime,
	@ToDate  DATETIME,
	@Template NVARCHAR(500)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)='',
		@sSQL01 NVARCHAR (MAX)='',
		@sSQLGroup01 NVARCHAR (MAX)='',
		@sSQLGroup02 NVARCHAR (MAX)='',
		@sSQLGroup03 NVARCHAR (MAX)='',
		@sSQLGroup04 NVARCHAR (MAX)='',
		@sSQLGroup05 NVARCHAR (MAX)='',
		@sSQLGroup06 NVARCHAR (MAX)='',
		@sSQLGroup07 NVARCHAR (MAX)='',
		@sSQLGroup08 NVARCHAR (MAX)='',
		@sSQLGroup09 NVARCHAR (MAX)='',
		@sSQLGroup10 NVARCHAR (MAX)='',
		@sWhere NVARCHAR(MAX)=''

SET @sWhere = ''

	IF ISNULL(@DepartmentID,'') <> ''
	BEGIN
		--SET @TargetsIDList = '''' + @TargetsIDList + ''''
		SET @sWhere = ' WHERE V14.Ana02ID IN (''' + @DepartmentID + ''')'
	END

	IF ISNULL(@TeamID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND V14.Ana03ID IN (''' + @TeamID + ''')'
	END

	IF ISNULL(@SectionID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND V14.Ana04ID IN (''' + @SectionID + ''')'
	END
	IF ISNULL(@ProcessID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND V14.Ana05ID IN (''' + @ProcessID + ''')'
	END
IF @Template <> N'Bảng lương lũy kế theo năm'
BEGIN
    
	IF ISNULL(@DepartmentID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND '
	END
	ELSE
	BEGIN
		SET @sWhere = ' WHERE '
	END 
	IF (ISNULL(@FromDate,'') <> '' and ISNULL(@ToDate,'') <> '')
	BEGIN
		SET @sWhere = @sWhere + ' CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) BETWEEN '''+CONVERT(NVARCHAR(10), @FromDate ,101)+''' AND '''+CONVERT(NVARCHAR(10), @ToDate ,101)+''' '
	END
	ELSE IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') = ''
	BEGIN
		SET @sWhere = @sWhere + ' CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) > '''+CONVERT(NVARCHAR(10), @FromDate ,101)+''' '
	END
	ELSE IF ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) < '''+CONVERT(NVARCHAR(10), @ToDate ,101)+''' '
	END
	--SET @sWhere = @sWhere + ' AND ISNULL(V14.Ana02ID,'''') <> '''' AND ISNULL(V14.Ana03ID,'''') <> '''''
	DECLARE @Index INT = 1;
	DECLARE @SqlIncome NVARCHAR(MAX)
	DECLARE @SqlIncomeSum NVARCHAR(MAX)
	SET @SqlIncome = ''
	SET @SqlIncomeSum = ''
	WHILE @Index <= 150
	BEGIN
		IF @Index < 10
		BEGIN
			SET @SqlIncome = @SqlIncome + ', Income0'+ LTRIM(STR(@Index))
			SET @SqlIncomeSum = @SqlIncomeSum + ', SUM(Income0'+ LTRIM(STR(@Index))+') AS Income0'+ LTRIM(STR(@Index))
		END
		ELSE
		BEGIN
			SET @SqlIncome = @SqlIncome + ', Income'+ LTRIM(STR(@Index))
			SET @SqlIncomeSum =  @SqlIncomeSum + ', SUM(Income'+ LTRIM(STR(@Index))+') AS Income'+ LTRIM(STR(@Index))
		END
	
	 SET @Index = @Index + 1;
	END;

	IF(1=1)
	BEGIN
		SET @sSQL = N' 
						drop table thu
					  select UPPER(V14.Ana02ID) AS DepartmentID,AT1102.DepartmentName,
					  UPPER(V14.Ana03ID) AS TeamID, HT1101.TeamName,
					  UPPER(V14.Ana04ID) AS SectionID, A04.AnaName AS SectionName,
					  UPPER(V14.Ana05ID) AS ProcessID, A05.AnaName AS ProcessName,
					  V14.FullName, HT5891.BaseSalary,HT5891.EmployeeID,TranMonth,TranYear,HT5891.VoucherDate
					  '+@SqlIncome+'
					  From HT5891 WITH (Nolock)
					  inner join HV1400 V14 on V14.EmployeeID=HT5891.EmployeeID and V14.DivisionID=HT5891.DivisionID
					  LEFT JOIN AT1102 WITH (Nolock) On HT5891.DivisionID=V14.DivisionID AND AT1102.DepartmentID = V14.Ana02ID
					  LEFT JOIN HT1101 WITH (Nolock) On HT1101.DivisionID=HT1101.DivisionID AND HT1101.TeamID = V14.Ana03ID
					  LEFT JOIN AT1011 A04 WITH (Nolock) On A04.DivisionID=HT1101.DivisionID AND A04.AnaID = V14.Ana04ID AND A04.AnaTypeID = ''A04''
					  LEFT JOIN AT1011 A05 WITH (Nolock) On A05.DivisionID=HT1101.DivisionID AND A05.AnaID = V14.Ana05ID AND A05.AnaTypeID = ''A05''
					   ' +@sWhere  + ' 
					   ORDER BY HT5891.VoucherDate, RIGHT(V14.Ana03ID,1) , LEFT(V14.Ana03ID,1) DESC, V14.EmployeeID
					   , A04.AnaName 
					   , A05.AnaName'

		SET @sSQL01 = N'
					  select UPPER(V14.Ana02ID) AS DepartmentID,AT1102.DepartmentName,
					  UPPER(V14.Ana03ID) AS TeamID, HT1101.TeamName,
					  UPPER(V14.Ana04ID) AS SectionID, A04.AnaName AS SectionName,
					  UPPER(V14.Ana05ID) AS ProcessID, A05.AnaName AS ProcessName,
					  V14.FullName, HT5891.BaseSalary,HT5891.EmployeeID,TranMonth,TranYear,HT5891.VoucherDate
					  '+@SqlIncome+'
					  into thu From HT5891 WITH (Nolock)
					  inner join HV1400 V14 on V14.EmployeeID=HT5891.EmployeeID and V14.DivisionID=HT5891.DivisionID
					  LEFT JOIN AT1102 WITH (Nolock) On HT5891.DivisionID=V14.DivisionID AND AT1102.DepartmentID = V14.Ana02ID
					  LEFT JOIN HT1101 WITH (Nolock) On HT1101.DivisionID=HT1101.DivisionID AND HT1101.TeamID = V14.Ana03ID
					  LEFT JOIN AT1011 A04 WITH (Nolock) On A04.DivisionID=HT1101.DivisionID AND A04.AnaID = V14.Ana04ID AND A04.AnaTypeID = ''A04''
					  LEFT JOIN AT1011 A05 WITH (Nolock) On A05.DivisionID=HT1101.DivisionID AND A05.AnaID = V14.Ana05ID AND A05.AnaTypeID = ''A05''
					  ' +@sWhere + ' 
					  ORDER BY HT5891.VoucherDate, RIGHT(V14.Ana02ID,1) , LEFT(V14.Ana03ID,1) DESC, V14.EmployeeID
					   , A04.AnaName 
					   , A05.AnaName'
			
	end
	ELSE
	BEGIN
		SET @sSQL = N' 
						drop table thu
				  SELECT V14.Ana02ID AS DepartmentID,AT1102.DepartmentName,
				  V14.Ana03ID AS TeamID, HT1101.TeamName,
				  V14.Ana04ID AS SectionID, A04.AnaName AS SectionName,
				  V14.Ana05ID AS ProcessID, A05.AnaName AS ProcessName,HT5891.VoucherDate
				  '+@SqlIncomeSum+'
				  into thu From HT5891 WITH (Nolock)
				  inner join HV1400 V14 on V14.EmployeeID=HT5891.EmployeeID and V14.DivisionID=HT5891.DivisionID
				  LEFT JOIN AT1102 WITH (Nolock) On HT5891.DivisionID=V14.DivisionID AND AT1102.DepartmentID = V14.Ana02ID
				  LEFT JOIN HT1101 WITH (Nolock) On HT1101.DivisionID=HT1101.DivisionID AND HT1101.TeamID = V14.Ana03ID
				  LEFT JOIN AT1011 A04 WITH (Nolock) On A04.DivisionID=HT1101.DivisionID AND A04.AnaID = V14.Ana04ID AND A04.AnaTypeID = ''A04''
				  LEFT JOIN AT1011 A05 WITH (Nolock) On A05.DivisionID=HT1101.DivisionID AND A05.AnaID = V14.Ana05ID AND A05.AnaTypeID = ''A05''

				  GROUP BY AT1102.DepartmentName,
				  V14.Ana02ID ,AT1102.DepartmentName,
				  V14.Ana03ID , HT1101.TeamName,
				  V14.Ana04ID , A04.AnaName ,
				  V14.Ana05ID , A05.AnaName ,HT5891.VoucherDate
				  ORDER BY HT5891.VoucherDate, RIGHT(V14.Ana02ID,1), Left(V14.Ana02ID,1)
				  ' +@sWhere 	

		SET @sSQL01 = N'
					   SELECT --V14.Ana02ID AS DepartmentID,AT1102.DepartmentName,
				  V14.Ana03ID AS TeamID, HT1101.TeamName,
				  V14.Ana04ID AS SectionID, A04.AnaName AS SectionName,
				  V14.Ana05ID AS ProcessID, A05.AnaName AS ProcessName,HT5891.VoucherDate
				  '+@SqlIncomeSum+'
				  From HT5891 WITH (Nolock)
				  inner join HV1400 V14 on V14.EmployeeID=HT5891.EmployeeID and V14.DivisionID=HT5891.DivisionID
				  LEFT JOIN AT1102 WITH (Nolock) On HT5891.DivisionID=V14.DivisionID AND AT1102.DepartmentID = V14.Ana02ID
				  LEFT JOIN HT1101 WITH (Nolock) On HT1101.DivisionID=HT1101.DivisionID AND HT1101.TeamID = V14.Ana03ID
				  LEFT JOIN AT1011 A04 WITH (Nolock) On A04.DivisionID=HT1101.DivisionID AND A04.AnaID = V14.Ana04ID AND A04.AnaTypeID = ''A04''
				  LEFT JOIN AT1011 A05 WITH (Nolock) On A05.DivisionID=HT1101.DivisionID AND A05.AnaID = V14.Ana05ID AND A05.AnaTypeID = ''A05''

				  GROUP BY 
				  --V14.Ana02ID ,AT1102.DepartmentName,
				  V14.Ana03ID , HT1101.TeamName,
				  V14.Ana04ID , A04.AnaName ,
				  V14.Ana05ID , A05.AnaName ,HT5891.VoucherDate
				  ' +@sWhere 	
	END
	
	SET @sSQLGroup01 =	N'
		   SELECT DepartmentID,
		    VoucherDate
		   '+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID,
		    VoucherDate'
	SET @sSQLGroup02 =	N'  
		   SELECT DepartmentID,
		   TeamID, VoucherDate
		   '+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID, VoucherDate'
	SET @sSQLGroup03 =	N'	  
		   SELECT DepartmentID,
		   TeamID,SectionID, VoucherDate
		   '+@SqlIncomeSum+' 
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID,SectionID, VoucherDate'
	SET @sSQLGroup04 =	N'
		   SELECT DepartmentID,
		   TeamID,SectionID,ProcessID, VoucherDate
			'+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID,SectionID,ProcessID, VoucherDate
	 '
	 SET @sSQLGroup09 =	N'
		   SELECT VoucherDate
			'+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY VoucherDate
	 '

	 -- Sheet All
	 SET @sSQLGroup05 =	N'
		   SELECT DepartmentID
		   '+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID'
	SET @sSQLGroup06 =	N'  
		   SELECT DepartmentID,
		   TeamID
		   '+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID'
	SET @sSQLGroup07 =	N'	  
		   SELECT DepartmentID,
		   TeamID,SectionID
		   '+@SqlIncomeSum+' 
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID,SectionID'
	SET @sSQLGroup08 =	N'
		   SELECT DepartmentID,
		   TeamID,SectionID,ProcessID
			'+@SqlIncomeSum+'
		   FROM thu
		   GROUP BY DepartmentID,
		   TeamID,SectionID,ProcessID'
	SET @sSQLGroup10 =	N'
			SELECT  
			'+SUBSTRING(@SqlIncomeSum,2,LEN(@SqlIncomeSum))+'
			FROM thu'
	PRINT @sSQL
	print  @sSQL01
	print  @sSQLGroup01 
	print  @sSQLGroup02 
	print @sSQLGroup03
	print  @sSQLGroup04
	print  @sSQLGroup05
	print  @sSQLGroup06
	print  @sSQLGroup07
	print  @sSQLGroup08
	print  @sSQLGroup09
	print  @sSQLGroup10
	EXEC(@sSQL +@sSQL01+ @sSQLGroup01 + @sSQLGroup02 +@sSQLGroup03+ @sSQLGroup04+ @sSQLGroup05 + @sSQLGroup06 +@sSQLGroup07+ @sSQLGroup08+@sSQLGroup09+@sSQLGroup10)

END
ELSE
BEGIN
	DECLARE @sqlAll VARCHAR(MAX) = ''

	DECLARE @SQL VARCHAR(MAX) = ''
	update HT0002
	set @SQL = @SQL + CASE WHEN @SQL <> '' THEN ' + SUM(ISNULL(' + REPLACE(IncomeID,'I','Income')+',0))'  ELSE 'SUM(ISNULL(' + REPLACE(IncomeID,'I','Income') + ',0))' END
	FROM HT0002 WHERE IsCalculateNetIncome = 1 AND IsUsed = 1

	DECLARE @SQL1 VARCHAR(MAX) = ''
	update HT0005
	set @SQL1 = @SQL1 + CASE WHEN @SQL1 <> '' THEN ' - SUM(ISNULL(' + REPLACE(SubID,'S','SubAmount')+',0))'  ELSE 'SUM(ISNULL(' + REPLACE(SubID,'S','SubAmount') + ',0))' END
	from HT0005 where IsCalculateNetIncome = 1 AND IsUsed = 1

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LuyKe]') AND type in (N'U'))
		CREATE TABLE LuyKe (Name NVARCHAR(250), [2020] DECIMAL(28,8), [2021] DECIMAL(28,8), [2022] DECIMAL(28,8), [2023] DECIMAL(28,8), [2024] DECIMAL(28,8), [2025] DECIMAL(28,8), [2026] DECIMAL(28,8), [2027] DECIMAL(28,8), [2028] DECIMAL(28,8), [2029] DECIMAL(28,8), [2030] DECIMAL(28,8))

	SET @sqlAll = N'
	SELECT LuyKe.Name, A.[2020], A.[2021], A.[2022], A.[2023], A.[2024], A.[2025], A.[2026], A.[2027], A.[2028], A.[2029], A.[2030]  FROM LuyKe 
	LEFT JOIN 
	(
	SELECT *
		FROM 
		(SELECT CASE WHEN HT3400.TranMonth < 10 THEN N''Tháng 0''+ LTRIM(STR(HT3400.TranMonth)) ELSE N''Tháng ''+ LTRIM(STR(HT3400.TranMonth)) END AS [Name], HT3400.TranYear,
		'+CASE WHEN ISNULL(@SQL,'') = '' THEN '' ELSE @SQL END + CASE WHEN ISNULL(@SQL1,'') = '' THEN '' ELSE ' - ' + @SQL1 END+ '-  Sum(Isnull(TaxAmount, 0)) AS SalaryAmount
		FROM HT3400
		inner join HV1400 V14 ON  V14.DivisionID=HT3400.DivisionID AND V14.EmployeeID=HT3400.EmployeeID 
		LEFT JOIN HT3499 ON HT3400.DivisionID = HT3499.DivisionID AND HT3400.TransactionID = HT3499.TransactionID 
		'+@sWhere+'
		GROUP BY HT3400.TranYear, HT3400.TranMonth
		) AS BangNguon
		PIVOT 
		(
		 SUM(SalaryAmount)
		 FOR TranYear IN ([2020], [2021], [2022], [2023], [2024], [2025], [2026], [2027], [2028], [2029], [2030])
		) AS BangChuyen
	) A	 ON A.Name = LuyKe.Name
	ORDER BY LuyKe.Name
	'
	EXEC(@sqlAll)
	PRINT @sqlAll
END













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
