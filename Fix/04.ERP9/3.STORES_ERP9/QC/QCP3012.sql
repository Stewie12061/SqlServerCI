IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[QCP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Báo cáo kiểm tra dữ liệu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Phương Thảo on: 29/06/2023
---- Modified by: Mạnh Cường  on: 03/08/2023 : Fix lỗi in báo cáo kiểm tra dữ liệu (QCR3012)
---- Modified by: Anh Đô on 22/08/2023: Cập nhật xử lý tính trung bình giá trị kiểm tra (tính trung bình trên số lần kiểm tra có nhập liệu)

--example:EXEC QCP3012 @DivisionID='EXV',@UserID=N'ASOFTADMIN',@FromDate=N'2023-06-02 00:00:00',@ToDate=N'2023-07-02 00:00:00',@StandardID=N'NL02'	



								
CREATE PROCEDURE QCP3012
(   

     @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50), 
	 @FromDate NVARCHAR(50), 
	 @ToDate NVARCHAR(50) = NULL, 
	 @StandardID NVARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sSQL1 NVARCHAR (MAX)='',
		@sSQL2 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
		@sWhere1 NVARCHAR(MAX)=''

	IF ISNULL(@DivisionID, '') != '' 
		BEGIN
			SET @sWhere = N'  Q02.DivisionID IN ('''+@DivisionID+''') '
		END
	ELSE 
		BEGIN
			SET @sWhere = N'  Q02.DivisionID IN ('''+@DivisionID+''') '
		END


	IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = ''
		SET @sWhere = @sWhere + N' AND Q00.VoucherDate >= '''+@FromDate+''' AND Q00.VoucherDate <= '''+SUBSTRING(@FromDate,0,11)+' 23:59:59'+''''	
	IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != ''
		SET @sWhere = @sWhere + N' AND Q00.VoucherDate >= '''+@FromDate+''' AND Q00.VoucherDate <= '''+SUBSTRING(@ToDate,0,11)+' 23:59:59'+''''	
	IF ISNULL(@StandardID, '') != '' 
					SET @sWhere = @sWhere + N' AND Q02.StandardID IN ('''+@StandardID+''')'

SET @sSQL =N'
SELECT
    InventoryID,
    StandardID,
    StandardName,
    CASE WHEN DayColumn = ''Day1'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day1,
    CASE WHEN DayColumn = ''Day2'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day2,
    CASE WHEN DayColumn = ''Day3'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day3,
	CASE WHEN DayColumn = ''Day4'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day4,
	CASE WHEN DayColumn = ''Day5'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day5,
	CASE WHEN DayColumn = ''Day6'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day6,
	CASE WHEN DayColumn = ''Day7'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day7,
	CASE WHEN DayColumn = ''Day8'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day8,
	CASE WHEN DayColumn = ''Day9'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS  Day9,
	CASE WHEN DayColumn = ''Day10'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day10,
	CASE WHEN DayColumn = ''Day11'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day11,
	CASE WHEN DayColumn = ''Day12'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day12,
	CASE WHEN DayColumn = ''Day13'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day13,
	CASE WHEN DayColumn = ''Day14'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day14,
	CASE WHEN DayColumn = ''Day15'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day15,
	CASE WHEN DayColumn = ''Day16'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day16,
	CASE WHEN DayColumn = ''Day17'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day17,
	CASE WHEN DayColumn = ''Day18'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day18,
	CASE WHEN DayColumn = ''Day19'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day19,
	CASE WHEN DayColumn = ''Day20'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day20,
	CASE WHEN DayColumn = ''Day21'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day21,
	CASE WHEN DayColumn = ''Day22'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day22,
	CASE WHEN DayColumn = ''Day23'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day23,
	CASE WHEN DayColumn = ''Day24'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day24,
	CASE WHEN DayColumn = ''Day25'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day25,
	CASE WHEN DayColumn = ''Day26'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day26,
	CASE WHEN DayColumn = ''Day27'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day27,
	CASE WHEN DayColumn = ''Day28'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day28,
	CASE WHEN DayColumn = ''Day29'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day29,
	CASE WHEN DayColumn = ''Day30'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day30,
    CASE WHEN DayColumn = ''Day31'' AND SUM(NotNullColumns) != 0 THEN SUM(SumCheckDay) / SUM(NotNullColumns) ELSE 0 END AS Day31'

SET @sSQL1 = N'
INTO #QCP3012_Tmp
FROM
(
    SELECT
          Q01.InventoryID AS InventoryID
        , Q02.StandardID AS StandardID
        , Q10.StandardName AS StandardName
		, CASE WHEN ISNUMERIC(Q02.checkvalue) = 1 AND Q02.checkvalue != ''-'' OR Q02.checkvalue IS NULL THEN 
			(CAST(COALESCE(Q02.CheckValue, ''0'') AS FLOAT) + CAST(COALESCE(Q02.CheckValue02, ''0'') AS FLOAT) 
			+ CAST(COALESCE(Q02.CheckValue03, ''0'') AS FLOAT) + CAST(COALESCE(Q02.CheckValue04, ''0'') AS FLOAT) 
			+ CAST(COALESCE(Q02.CheckValue05, ''0'') AS FLOAT))
		  END AS SumCheckDay
        , ''Day'' + CAST(DATEDIFF(DAY, '''+@FromDate+''', Q00.VoucherDate) + 1 AS VARCHAR) AS DayColumn
		, IIF(ISNULL(Q02.CheckValue, '''') != '''', 1, 0) 
			+ IIF(ISNULL(Q02.CheckValue02, '''') != '''', 1, 0)
			+ IIF(ISNULL(Q02.CheckValue03, '''') != '''', 1, 0) 
			+ IIF(ISNULL(Q02.CheckValue04, '''') != '''', 1, 0)
			+ IIF(ISNULL(Q02.CheckValue05, '''') != '''', 1, 0)
		  AS NotNullColumns
    FROM QCT2002 Q02 WITH (NOLOCK)
    LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q02.APKMaster = CAST(Q01.APK AS uniqueidentifier) AND Q01.DivisionID = Q02.DivisionID
    LEFT JOIN QCT1000 Q10 WITH (NOLOCK) ON Q10.StandardID = Q02.StandardID AND Q10.DivisionID = Q02.DivisionID
    LEFT JOIN QCT2000 Q00 WITH (NOLOCK) ON Q00.APK = Q01.APKMaster AND Q00.DivisionID = Q02.DivisionID
'
SET @sSQL1 = @sSQL1 + N'
    WHERE Q00.DeleteFlg = 0 AND '+@sWhere+'
	) AS SourceData
	GROUP BY InventoryID, StandardID, StandardName, DayColumn;

'
SET @sSQL2 = N'
	SELECT M.InventoryID
		, M.StandardID
		, M.StandardName
		, SUM(M.Day1) AS Day1, SUM(M.Day2) AS Day2, SUM(M.Day3) AS Day3
		, SUM(M.Day4) AS Day4, SUM(M.Day5) AS Day5, SUM(M.Day6) AS Day6
		, SUM(M.Day7) AS Day7, SUM(M.Day8) AS Day8, SUM(M.Day9) AS Day9
		, SUM(M.Day10) AS Day10, SUM(M.Day11) AS Day11, SUM(M.Day12) AS Day12
		, SUM(M.Day13) AS Day13, SUM(M.Day14) AS Day14, SUM(M.Day15) AS Day15
		, SUM(M.Day16) AS Day16, SUM(M.Day17) AS Day17, SUM(M.Day18) AS Day18
		, SUM(M.Day19) AS Day19, SUM(M.Day20) AS Day20, SUM(M.Day21) AS Day21
		, SUM(M.Day22) AS Day22, SUM(M.Day23) AS Day23, SUM(M.Day24) AS Day24
		, SUM(M.Day25) AS Day25, SUM(M.Day26) AS Day26, SUM(M.Day27) AS Day27
		, SUM(M.Day28) AS Day28, SUM(M.Day29) AS Day29, SUM(M.Day30) AS Day30
		, SUM(M.Day31) AS Day31
	FROM #QCP3012_Tmp M WITH (NOLOCK)
	GROUP BY M.InventoryID, M.StandardID, M.StandardName
'

PRINT (@sSQL)
PRINT (@sSQL1)
PRINT (@sSQL2)
EXEC (@sSQL + @sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO