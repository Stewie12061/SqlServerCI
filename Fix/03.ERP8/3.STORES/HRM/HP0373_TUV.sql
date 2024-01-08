IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0373_TUV]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0373_TUV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Param>
---- Customize KH TUV
---- 
-- <Return>
---- 
-- <Reference>
---- HRM\Báo cáo\Công\Quét thẻ dữ liệu chấm công 
-- <History>
---- Create on 13/04/2017 by Trương Ngọc Phương Thảo
---- Modified on 13/04/2017 by Trương Ngọc Phương Thảo
---- Modified on 17/11/2017 by Khả Vi: Thêm phòng ban 
-- <Example>
---- 

CREATE PROCEDURE [dbo].[HP0373_TUV]
				@DivisionID nvarchar(50),
				@FromDepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@FromEmployeeID nvarchar(50),
				@ToEmployeeID nvarchar(50),
				@FromMonth int,
				@FromYear int,
				@ToMonth int,
				@ToYear int,
				@lstEmployeeID as NVARCHAR(4000)

AS

Declare @sSQL NVARCHAR(MAX),
		@sSQL_Where NVARCHAR(4000),
		@BeginDate Datetime,
		@EndDate Datetime
	

DECLARE	@sSQL001 Nvarchar(4000),
		@sSQL002 Nvarchar(4000),
		@TableHT2408 Varchar(50),		
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @FromMonth >9 THEN Convert(Varchar(2),@FromMonth) ELSE '0'+Convert(Varchar(1),@FromMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	IF(@FromMonth = @ToMonth and @FromYear = @ToYear)
	BEGIN
		SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@FromYear)
	END
	ELSE
	IF(@FromMonth <> @ToMonth and @FromYear = @ToYear)
	BEGIN
		SET  @TableHT2408 = 'HT2408Y'+Convert(Varchar(4),@FromYear)
	END
	ELSE
		SET  @TableHT2408 = 'HT2408'
END
ELSE
BEGIN
	SET  @TableHT2408 = 'HT2408'
END

if(ISNULL(@lstEmployeeID,'') = '')
begin
	SET @sSQL_Where =''
end
else
begin
	SET @sSQL_Where = 'AND H06.EmployeeID  in (''' + @lstEmployeeID + ''') '
end

SELECT	@BeginDate = Min(BeginDate),
		@EndDate = Max(EndDate)
FROM HT9999
WHERE DivisionID = @DivisionID AND TranMonth = @FromMonth AND TranYear = @FromYear

SET @sSQL001 = N'
SELECT		H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, 			 
			H07.EmployeeID,   			
			H06.AbsentDate,
			CONVERT(TIME(0),MIN(H06.AbsentDate+Cast(H06.AbsentTime as Datetime))) AS InTime,  
			CONVERT(TIME(0),MAX(H06.AbsentDate+Cast(H06.AbsentTime as Datetime))) AS OutTime
INTO	#HP0373_TUV_HT2408
FROM         '+@TableHT2408+' AS H06     
LEFT OUTER JOIN HT1407 AS H07 WITH (NOLOCK) ON H07.AbsentCardNo = H06.AbsentCardNo and H07.DivisionID = H06.DivisionID    
LEFT OUTER JOIN HT1025 AS H25 WITH (NOLOCK) ON H07.EmployeeID = H25.EmployeeID and H07.DivisionID = H25.DivisionID    
WHERE  H06.DivisionID = '''+@DivisionID+''' AND H25.TranMonth =  H06.TranMonth  AND H25.TranYear = H06.TranYear 
AND   H06.TranMonth + H06.TranYear*100 between '+STR(@FromMonth+ @FromYear * 100)+'  AND '+STR(@ToMonth + @ToYear * 100)+' 
AND H06.EmployeeID Between '''+@FromEmployeeID+''' and '''+@ToEmployeeID+'''
' + @sSQL_Where + '
GROUP BY H06.DivisionID, H06.TranMonth, H06.Tranyear, H06.AbsentCardNo, 
		 H07.EmployeeID, H06.AbsentDate
	'
CREATE TABLE #HP0373_TUV_NGAY (DivisionID Varchar(50), AbsentDate Datetime, TranMonth Int, TranYear Int)
	
WHILE (@BeginDate <= @EndDate)
BEGIN		
	INSERT INTO #HP0373_TUV_NGAY
	SELECT @DivisionID, @BeginDate, TranMonth, TranYear
	FROM HT9999
	WHERE @BeginDate BETWEEN BeginDate and EndDate

	SET @BeginDate = @BeginDate + 1	
END

SET @sSQL002 =N'
SELECT	T1.DivisionID, T1.EmployeeID, T2.TranMonth, T2.TranYear, Convert(NVarchar(250),'''') AS FullName, CONVERT(VARCHAR(50), '''') AS DepartmentID, 
		CONVERT(NVARCHAR(250), '''') AS DepartmentName, 
		DateName(dw,T2.AbsentDate) AS DAY, T2.AbsentDate, T1.AbsentCardNo, Convert(Time,null) as FromTimeValid, Convert(Time,null) as ToTimeValid		
INTO #HP0373_TUV_RS
FROM
(SELECT DISTINCT DivisionID, EmployeeID, AbsentCardNo
FROM #HP0373_TUV_HT2408	) T1,#HP0373_TUV_NGAY T2


--select * from #HP0373_TUV_HT2408
--select * from #HP0373_TUV_RS

UPDATE T1
SET	T1.FromTimeValid = T2.InTime,
	T1.ToTimeValid = T2.OutTime
FROM #HP0373_TUV_RS T1
INNER JOIN #HP0373_TUV_HT2408 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate

UPDATE T1
SET	T1.FullName = T2.FullName, 
	T1.DepartmentID = T2.DepartmentID, 
	T1.DepartmentName = AT1102.DepartmentName
FROM #HP0373_TUV_RS T1
INNER JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN AT1102 WITH (NOLOCK) ON T2.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')


SELECT * FROM #HP0373_TUV_RS ORDER BY EmployeeID, AbsentDate
' 

--print @sSQL001
--print @sSQL002
EXEC (@sSQL001+@sSQL002)


SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

