IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2490_NQH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2490_NQH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Create By : Dang Le Bao Quynh; Date 03/11/2008
--Purpose: Bao cao bien dong luong
--- Edited by:[Thanh Thịnh] [02/11/2015] : Thêm Mức lương cố định (Basesalary) trên hồ sơ lương
-- Tỉ lệ % thực hiện/kế hoạch: Hệ số trên hồ sơ lương (liên hệ CON khi gắp trường), Mã chức vụ, Ngày vào làm
---- Modified on 15/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị
---- Modified on 18/02/2021 by Huỳnh Thử: Tách Store NQH
---- Modified on 23/02/2021 by Huỳnh Thử: Lấy lên báo cáo các khoản mục lương khai báo bên danh mục
/********************************************
'* Edited by: [GS] [Việt Khánh] [02/08/2010]
'********************************************/

CREATE PROCEDURE [dbo].[HP2490_NQH] 
    @DivisionID NVARCHAR(50), 
    @FromDepartmentID NVARCHAR(50), 
    @ToDepartmentID NVARCHAR(50), 
    @TeamID NVARCHAR(50), 
    @FromEmployeeID NVARCHAR(50), 
    @ToEmployeeID NVARCHAR(50), 
    @FromTranMonth INT, 
    @FromTranYear INT, 
    @ToTranMonth INT, 
    @ToTranYear INT, 
    @SalaryList NVARCHAR(4000), 
    @BaseSalary NVARCHAR(50),
    @InsuranceSalary NVARCHAR(50),
    @Salary01 NVARCHAR(50),
    @Salary02 NVARCHAR(50),
    @Salary03 NVARCHAR(50),
    @SalaryCoefficient NVARCHAR(50),
    @TimeCoefficient NVARCHAR(50),
    @Coefficient NVARCHAR(50),
    @gnLang INT = 0, --0: tieng Viet, 1: tieng Anh
	@StrDivisionID AS NVARCHAR(4000) = ''
AS

DECLARE 
    @TranMonth INT, 
    @TranYear INT, 
    @sSQL NVARCHAR(max), 
    @SalaryCur CURSOR, 
    @SalID NVARCHAR(50), 
    @SalName NVARCHAR(250), 
    @SalCount INT, 
    @SalIndex INT, 
    @PeriodCur CURSOR, 
    @PeriodID NVARCHAR(50), 
    @PeriodIndex INT,
	@StrDivisionID_New AS NVARCHAR(4000)
		
SET @StrDivisionID_New = ''

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''

SET @sSQL = '
	  SELECT DivisionID, IncomeID as SalID, Caption as SalName from HT0002 WITH (NOLOCK)
	  WHERE DivisionID =  '''+@DivisionID+''' AND IsUsed = 1
	  UNION ALL 
	  SELECT DivisionID,SubID as SalID, Caption as SalName 
	  FROM HT0005 WITH (NOLOCK)
	  WHERE DivisionID =  '''+@DivisionID+''' AND IsUsed = 1
   
'

--print @sSQL
IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Id = Object_ID('HV2490') AND xType = 'V')
    DROP VIEW HV2490

--PRINT '====================' PRINT ('-- Create by HP2490
--    CREATE VIEW HV2490 AS ' + @sSQL)
EXEC ('-- Create by HP2490
    CREATE VIEW HV2490 AS ' + @sSQL)
    
SET @sSQL = '
SELECT SalID, SalName 
FROM HV2490 
WHERE DivisionID '+@StrDivisionID_New+'
AND SalID ' + CASE WHEN @SalaryList = '%' THEN ' = ''' + @SalaryList + '''' ELSE 'IN (' + @SalaryList + ')' END

IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Id = Object_ID('HV2491') AND xType = 'V')
    DROP VIEW HV2491

--PRINT '====================' PRINT ('CREATE VIEW HV2491 -- Create by HP2490
--    AS ' + @sSQL)
EXEC ('CREATE VIEW HV2491 -- Create by HP2490
    AS ' + @sSQL)
    
SET @sSQL = ''
SELECT @SalCount = COUNT(*) FROM HV2491
SET @SalIndex = 1

SET @SalaryCur = CURSOR STATIC FOR
SELECT SalID, SalName FROM HV2491
DECLARE @SubStr NVARCHAR(10)
OPEN @SalaryCur

FETCH NEXT FROM @SalaryCur INTO @SalID, @SalName
WHILE @@Fetch_Status = 0
    BEGIN
		SET  @SubStr = SUBSTRING( @SalID,1,1)
        SET @sSQL = @sSQL + '
            SELECT CASE WHEN HT2400.TranMonth <10 THEN ''0'' + LTRIM(HT2400.TranMonth) + ''/'' + LTRIM(HT2400.TranYear) ELSE LTRIM(HT2400.TranMonth) + ''/'' + LTRIM(HT2400.TranYear) END AS PeriodID, 
					HT2400.TranMonth, HT2400.TranYear, HT2400.DivisionID, HT2400.EmployeeID, ''' + @SalID + ''' AS SalID,
					N''' + @SalName + ''' AS SalName,
					'+CASE WHEN @SubStr = 'I' THEN ' ISNULL(Income' + SUBSTRING( @SalID,2,LEN(@SalID)) + ', 0)' ELSE ' ISNULL(SubAmount' + SUBSTRING( @SalID,2,LEN(@SalID)) + ', 0)' end +'  AS Amount ,
					ISNULL(HT2400.BaseSalary, 0) AS BaseSalary, 
					Isnull(C01,0) as HS01, IsNull(C02,0) as HS02 
            FROM HT2400   WITH (NOLOCK)
			LEFT JOIN HT3400 WITH (NOLOCK) on HT3400.EmployeeID = HT2400.EmployeeID and HT3400.TranMonth = HT2400.TranMonth and HT3400.TranYear = HT2400.TranYear
			LEFT JOIN HT3499 ON HT3400.DivisionID = HT3499.DivisionID AND HT3400.TransactionID = HT3499.TransactionID 
            WHERE HT2400.DivisionID '+@StrDivisionID_New+' And HT2400.TranMonth + 12*HT2400.TranYear BETWEEN ' + LTRIM(@FromTranMonth + 12*@FromTranYear) + ' AND ' + LTRIM(@ToTranMonth + 12*@ToTranYear) + char(13) + char(10) 
        
        IF @SalIndex < @SalCount 
        SET @sSQL = @sSQL + ' UNION ALL ' + char(13) + char(10)
        
        SET @SalIndex = @SalIndex + 1
        FETCH NEXT FROM @SalaryCur INTO @SalID, @SalName
    END
	PRINT @SalaryList
	IF(@SalaryList = '%')
	BEGIN
	PRINT 'aaa'
		-- Cộng thêm dòng thực lãnh
		SET @sSQL  = @sSQL + N'
		 SELECT CASE WHEN HT2400.TranMonth <10 THEN ''0'' + LTRIM(HT2400.TranMonth) + ''/'' + LTRIM(HT2400.TranYear) ELSE LTRIM(HT2400.TranMonth) + ''/'' + LTRIM(HT2400.TranYear) END AS PeriodID, 
						HT2400.TranMonth, HT2400.TranYear, HT2400.DivisionID, HT2400.EmployeeID, ''BaseSalary'' AS SalID,
						N''Thực lãnh'' AS SalName, ISNULL(Income30,0) - ISNULL(SubAmount01,0) - ISNULL(SubAmount02,0) - ISNULL(SubAmount03,0) - ISNULL(SubAmount04,0) - ISNULL(SubAmount05,0) - ISNULL(SubAmount06,0) - ISNULL(SubAmount07,0) - ISNULL(SubAmount08,0)-  Isnull(TaxAmount, 0) AS Amount ,
						ISNULL(Income30,0) - ISNULL(SubAmount01,0) - ISNULL(SubAmount02,0) - ISNULL(SubAmount03,0) - ISNULL(SubAmount04,0) - ISNULL(SubAmount05,0) - ISNULL(SubAmount06,0) - ISNULL(SubAmount07,0) - ISNULL(SubAmount08,0)-  Isnull(TaxAmount, 0) AS BaseSalary, Isnull(C01,0) as HS01, IsNull(C02,0) as HS02 
				FROM HT2400   WITH (NOLOCK)
				LEFT JOIN HT3400 WITH (NOLOCK) on HT3400.EmployeeID = HT2400.EmployeeID and HT3400.TranMonth = HT2400.TranMonth and HT3400.TranYear = HT2400.TranYear
				WHERE HT2400.DivisionID '+@StrDivisionID_New+' And HT2400.TranMonth + 12*HT2400.TranYear BETWEEN ' + LTRIM(@FromTranMonth + 12*@FromTranYear) + ' AND ' + LTRIM(@ToTranMonth + 12*@ToTranYear) + char(13) + char(10) 
	END 
	
PRINT (@sSQL)
IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Id = Object_ID('HV2492') AND xType = 'V')
    DROP VIEW HV2492
--print @sSQL

EXEC ('CREATE VIEW HV2492 -- Create by HP2490
    AS ' + @sSQL)

SET @sSQL = 'SELECT HV2492.DivisionID, EmployeeID, SalID, SalName, '
SET @PeriodIndex = 1

SET @PeriodCur = CURSOR STATIC FOR 
SELECT DISTINCT Top 24 PeriodID, TranMonth, TranYear 
FROM HV2492  WHERE DivisionID = @DivisionID
ORDER BY TranYear, TranMonth

OPEN @PeriodCur

FETCH NEXT FROM @PeriodCur INTO @PeriodID, @TranMonth, @TranYear
WHILE @@Fetch_Status = 0
     BEGIN
        SET @sSQL = @sSQL + 'SUM(CASE WHEN PeriodID = ''' + @PeriodID + ''' THEN Amount ELSE 0 END) AS P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + ', ''' + @PeriodID + ''' AS P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + 'Name, '
		+ 'SUM(CASE WHEN PeriodID = ''' + @PeriodID + ''' THEN HV2492.BaseSalary ELSE 0 END) as BaseSalary' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END +
		 ',SUM(CASE WHEN PeriodID = ''' + @PeriodID + ''' THEN HV2492.HS01 ELSE 0 END)as HS01P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END
		+',SUM(CASE WHEN PeriodID = ''' + @PeriodID + ''' THEN HV2492.HS02 ELSE 0 END)as HS02P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + ','
        SET @PeriodIndex = @PeriodIndex + 1
        FETCH NEXT FROM @PeriodCur INTO @PeriodID, @TranMonth, @TranYear
    END

WHILE @PeriodIndex < 25
    BEGIN
        SET @sSQL = @sSQL + 'Null AS P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + ', Null AS P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + 'Name, '
		+ 'NULL as BaseSalary' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + 
		', NULL as HS01P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END
		+ ',NULL as HS02P' + CASE WHEN @PeriodIndex<10 THEN '0' + LTRIM(@PeriodIndex) ELSE LTRIM(@PeriodIndex) END + ','
        SET @PeriodIndex = @PeriodIndex + 1
    END

SET @sSQL = left(@sSQL, LEN(@sSQL)-1)
SET @sSQL = @sSQL + ' FROM HV2492 WHERE DivisionID '+@StrDivisionID_New+' GROUP BY HV2492.DivisionID, EmployeeID, SalID, SalName'

IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Id = Object_ID('HV2493') AND xType = 'V')
    DROP VIEW HV2493

--PRINT '====================' PRINT ('CREATE VIEW HV2493 -- Create by HP2490
  --  AS ' + @sSQL)
EXEC ('CREATE VIEW HV2493 -- Create by HP2490
    AS ' + @sSQL)

SET @sSQL = '
    SELECT HV14.DepartmentID, HV14.DepartmentName, HV14.TeamID, HV14.TeamName, HV14.FullName, HV14.DutyID,HV14.WorkDate , HV93.*
    FROM HV2493 HV93 
		INNER JOIN HV1400 HV14 
			ON HV93.EmployeeID = HV14.EmployeeID 
				and HV93.DivisionID = HV14.DivisionID 		
    WHERE HV14.EmployeeStatus = 1 
        AND HV93.DivisionID '+@StrDivisionID_New+' 
        AND (HV14.DepartmentID BETWEEN ''' + @FromDepartmentID + ''' AND ''' + @ToDepartmentID + ''') 
        AND ISNULL(HV14.TeamID, '''') LIKE ''' + @TeamID + ''' 
        AND (HV14.EmployeeID BETWEEN ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + ''')'

IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Id = Object_ID('HV2494') AND xType = 'V')
    DROP VIEW HV2494

--PRINT '====================' PRINT ('CREATE VIEW HV2494 -- Create by HP2490
  --  AS ' + @sSQL)
EXEC ('CREATE VIEW HV2494 -- Create by HP2490
    AS ' + @sSQL)

	print @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

