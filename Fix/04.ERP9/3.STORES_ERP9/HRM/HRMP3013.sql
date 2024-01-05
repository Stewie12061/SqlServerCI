IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In báo cáo theo dõi tình hình CNV (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on	25/12/2018	by Bảo Anh
--- Modified on 25/12/2018	by Văn Tài: Sửa trường hợp không có dữ liệu để phát sinh.
-- <Example>
---- EXEC HRMP3013 'NTY',2017,'01,02,03,04,05,06,07,08,09,10,11,12,13,CON','',''
/*-- <Example>

----*/

CREATE PROCEDURE HRMP3013
( 
	@DivisionList VARCHAR(MAX),
	@TranYear INT,
	@DepartmentList VARCHAR(MAX),
	@TeamList VARCHAR(MAX),
	@DutyGroupList VARCHAR(MAX)
)
AS 
DECLARE @sSQL VARCHAR (MAX)='',
		@sWhere VARCHAR(MAX)='',
		@i INT = 1,
		@s VARCHAR(3)='',
		@ColumnName_PIVOT AS VARCHAR(MAX),
		@ColumnName AS VARCHAR(MAX),
		@ColumnName_SELECT AS VARCHAR(MAX),
		@ColumnName_IsMale AS VARCHAR(MAX),
		@ColumnName_Chart AS VARCHAR(MAX),
		@Cur AS CURSOR,
		@DutyGroupID VARCHAR(50),
		@DutyGroupOrders INT

SET @sWhere = 'HT1360.DivisionID IN (''' + @DivisionList + ''')'

IF ISNULL(@DepartmentList,'') <> ''
	SET @sWhere = @sWhere + ' AND HT1360.DepartmentID IN (''' + @DepartmentList + ''')'

IF ISNULL(@DutyGroupList,'') <> ''
	SET @sWhere = @sWhere + ' AND HT1102.DutyGroupID IN (''' + @DutyGroupList + ''')'

IF ISNULL(@TeamList, '') <> ''
	SET @sWhere = @sWhere + ' AND ISNULL(HT1360.TeamID,'''') IN ('''+@TeamList+''')'

CREATE TABLE #HT13601 (TranMonth INT, EmployeeID VARCHAR(50), DutyGroupID VARCHAR(50), DutyGroupName NVARCHAR(50), DutyGroupOrders INT, IsMale TINYINT)

WHILE @i <= 12
BEGIN
	

	SET @s = CASE WHEN @i < 10 THEN '0' + LTRIM(@i) ELSE LTRIM(@i) END

	
	SET @sSQL = '
	INSERT INTO #HT13601
	SELECT ' + LTRIM(@i) + ' AS TranMonth, HT1360.EmployeeID, HT1102.DutyGroupID, HT1127.DutyGroupName, HT1127.Orders AS DutyGroupOrders,HT1400.IsMale
	FROM HT1360 WITH (NOLOCK)
	LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1360.DivisionID = HT1400.DivisionID AND HT1360.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1360.DivisionID = HT1403.DivisionID AND HT1360.EmployeeID = HT1403.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1403.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID
	LEFT JOIN HT1127 WITH (NOLOCK) ON HT1127.DivisionID = HT1102.DivisionID AND HT1127.DutyGroupID = HT1102.DutyGroupID
	WHERE ' + @sWhere + ' AND Year(HT1360.SignDate) = ' + LTRIM(@TranYear) + ' AND Month(HT1360.SignDate) = ' + LTRIM(@i) + '
	
	UNION --ALL
	SELECT ' + LTRIM(@i) + ' AS TranMonth, HT1360.EmployeeID, HT1102.DutyGroupID, HT1127.DutyGroupName, HT1127.Orders AS DutyGroupOrders, HT1400.IsMale
	FROM HT1360 WITH (NOLOCK)
	LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1360.DivisionID = HT1400.DivisionID AND HT1360.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1360.DivisionID = HT1403.DivisionID AND HT1360.EmployeeID = HT1403.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1403.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID
	LEFT JOIN HT1127 WITH (NOLOCK) ON HT1127.DivisionID = HT1102.DivisionID AND HT1127.DutyGroupID = HT1102.DutyGroupID
	WHERE ' + @sWhere + ' AND HT1360.SignDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101)
	AND (HT1105.Months = 0 OR DATEADD(m,HT1105.Months,HT1360.SignDate) > CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101))
	AND NOT EXISTS (SELECT 1 FROM HT1380 WITH (NOLOCK) WHERE DivisionID = HT1360.DivisionID AND EmployeeID = HT1360.EmployeeID
					AND LeaveDate < CONVERT(DATETIME,''' + @s+'/01/'+LTRIM(@TranYear) + ''',101))
	'
	PRINT @sSQL
	EXEC(@sSQL)
	SET @i = @i + 1
END

SELECT	TranMonth, DutyGroupID, DutyGroupName, DutyGroupOrders, IsMale, COUNT(EmployeeID) AS Quantity
INTO #HT13602
FROM #HT13601
GROUP BY TranMonth, DutyGroupID, DutyGroupName, DutyGroupOrders, IsMale

SELECT TranMonth, SUM(Quantity) AS QuantityTotal
INTO #HT13600
FROM #HT13602
GROUP BY TranMonth

--- Dataset 1: trả ra các nhóm chức vụ để dựng thành các cột, mỗi nhóm chức vụ chia thành 2 cột Nam/Nữ
SELECT DISTINCT DutyGroupName, DutyGroupOrders, @TranYear TranYear FROM #HT13602 Order by DutyGroupOrders

--- Dataset 2: Thống kê số lượng theo từng nhóm chức vụ và theo giới tính
SELECT @ColumnName = STUFF((
select DISTINCT DutyGroupID + ','
from #HT13602
For XML PATH('')),1,0,'')

IF EXISTS (SELECT TOP 1 1 FROM #HT13602)
BEGIN

	SET @ColumnName = LEFT(@ColumnName, LEN(@ColumnName) - 1)
	SET @ColumnName_PIVOT = '[' + REPLACE(@ColumnName,',','],[') + ']'
	SET @ColumnName_SELECT = ''
	SET @ColumnName_IsMale = ''
	SET @ColumnName_Chart = ''
	SET @i = 1

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT DutyGroupID, DutyGroupOrders FROM #HT13602 Order by DutyGroupOrders
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DutyGroupID, @DutyGroupOrders
	WHILE @@Fetch_Status = 0 
		BEGIN
		
			PRINT('C')

			SET @ColumnName_SELECT = @ColumnName_SELECT + 'MAX(ISNULL(' + @DutyGroupID + ',0)) AS ' + @DutyGroupID + ', '
			SET @ColumnName_IsMale = @ColumnName_IsMale + 'SUM(CASE WHEN IsMale = 1 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col' + LTRIM(@i) + '_1,'
			SET @ColumnName_IsMale = @ColumnName_IsMale + 'SUM(CASE WHEN IsMale = 0 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col' + LTRIM(@i) + '_2,'
		
			SET @ColumnName_Chart = @ColumnName_Chart + ',
			SUM(CASE WHEN TranMonth = 1 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col1_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 2 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col2_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 3 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col3_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 4 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col4_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 5 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col5_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 6 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col6_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 7 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col7_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 8 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col8_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 9 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col9_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 10 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col10_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 11 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col11_' + LTRIM(@i) + ',
			SUM(CASE WHEN TranMonth = 12 THEN ' + @DutyGroupID + ' ELSE 0 END) AS Col12_' + LTRIM(@i) + ''

			PRINT('D')
		
			SET @i = @i + 1
			FETCH NEXT FROM @Cur INTO @DutyGroupID, @DutyGroupOrders
		END

	SET @ColumnName_SELECT = LEFT(@ColumnName_SELECT, LEN(@ColumnName_SELECT) - 1)
	SET @ColumnName_IsMale = LEFT(@ColumnName_IsMale, LEN(@ColumnName_IsMale) - 1)

	SET @sSQL = '
	SELECT TranMonth, IsMale, ' + @ColumnName_SELECT + '
	INTO #HT13603
	FROM
	(
		SELECT *
		FROM #HT13602
	) AS A
	PIVOT (SUM(Quantity) FOR DutyGroupID IN (' + @ColumnName_PIVOT + ')
	) As P
	GROUP BY TranMonth, IsMale

	SELECT #HT13603.TranMonth, #HT13600.QuantityTotal, ' + @ColumnName_IsMale + '
	FROM #HT13603
	LEFT JOIN #HT13600 ON #HT13603.TranMonth = #HT13600.TranMonth
	GROUP BY #HT13603.TranMonth, #HT13600.QuantityTotal
	ORDER BY #HT13603.TranMonth

	SELECT IsMale ' + @ColumnName_Chart + '
	FROM #HT13603
	GROUP BY IsMale
	ORDER BY IsMale DESC
	'

	PRINT @sSQL
	EXEC(@sSQL)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
