IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0437]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0437]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin báo cáo theo dõi phân bổ doanh thu chưa thực hiện dài hạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 16/06/2022 by Kiều Nga
----Modify  on 04/08/2022 by Kiều Nga : [2022/08/IS/0025] Fix lỗi in báo cáo
----Modify  on 12/08/2022 by Kiều Nga : Điều chỉnh đối tượng sang combo chọn nhiều
----Modify  on 07/02/2023 by Kiều Nga : [2023/02/IS/0018] In báo cáo cho chỉnh sửa lại cho phép chọn in 1 hoặc nhiều hợp đồng
-- <Example>
/*  
EXEC AP0437 @DivisionID, @FromYear , @ToYear
EXEC AP0437 'MHS', 2021 , 2022,'A-KH-001','XD-XLNT-01'

*/
----
CREATE PROCEDURE AP0437 ( 
        @DivisionID VARCHAR(50),
		@FromYear INT,
		@ToYear INT,
		@LstObject XML = NULL)
AS

DECLARE @cols  AS NVARCHAR(MAX)='',
		@Sql AS NVARCHAR(MAX)='',
        @Sql1 AS NVARCHAR(MAX)='',
		@Sql11 AS NVARCHAR(MAX)='',
		@Sql2 AS NVARCHAR(MAX)='',
		@Sql22 AS NVARCHAR(MAX)='',
		@Sql3 AS NVARCHAR(MAX)='',
		@Sql33 AS NVARCHAR(MAX)='',
		@Sql4 AS NVARCHAR(MAX)='',
		@DropTBL_ObjectID AS NVARCHAR(MAX)=''

CREATE TABLE #AP0437Result
(
  DivisionID VARCHAR(50),
  ObjectID VARCHAR(50),
  ObjectName NVARCHAR(250),
  ContractNo VARCHAR(50),
  SignDate DATETIME,
  HandOverDate DATETIME,
  PlotID NVARCHAR(MAX),
  PlotName NVARCHAR(MAX),
  Area NVARCHAR(MAX),
  VoucherNo NVARCHAR(MAX),
  Ana01ID NVARCHAR(50),
  Ana02ID NVARCHAR(50),
  Ana03ID NVARCHAR(50),
  Ana04ID NVARCHAR(50),
  Ana05ID NVARCHAR(50),
  Ana06ID NVARCHAR(50),
  Ana07ID NVARCHAR(50),
  Ana08ID NVARCHAR(50),
  Ana09ID NVARCHAR(50),
  Ana10ID NVARCHAR(50),
  JobID NVARCHAR(50),
  TranMonth INT,
  TranYear INT,
  ConvertedAmount DECIMAL(28,8),
  BeginDate DATETIME,
  EndDate DATETIME,
  [Periods] INT,
  DepMonths INT,
  ResidualMonths INT,
  DepValue DECIMAL(28,8),
  ResidualValue DECIMAL(28,8),
  BeginDepMonths INT,
  DepMonthsYear INT,
  BeginDepAmount DECIMAL(28,8),
  DepAmountYear DECIMAL(28,8),
  IncreaseDepAmount DECIMAL(28,8),
  DecreaseDepAmount DECIMAL(28,8),
  EndDepAmount DECIMAL(28,8))

CREATE TABLE #AP0437Ignore
(
	ObjectID VARCHAR(50),
	ContractNo VARCHAr(50)
)

SELECT X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID
INTO #TBL_ObjectID
FROM @LstObject.nodes('//Data') AS X (Data)

-- Tồn đầu kỳ phân bổ
SET @Sql1='
DECLARE @ObjectID VARCHAR(50),
		@ContractNo VARCHAR(50)

SELECT T1.DivisionID
	, T2.ObjectID
	, T2.ContractNo
	, COUNT(T4.TranMonth + T4.TranYear * 100) AS CountPeriod -- Số kỳ đã phân bổ lũy kế đầu kỳ
	, SUM(ISNULL(T4.DepAmount,0)) as DepAmount -- Giá trị phân bổ lũy kế đầu kỳ
INTO #AP043701
FROM AT0421  T1 WITH (NOLOCK)
INNER JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID,''@@@'') AND T2.ObjectID = T3.ObjectID
LEFT JOIN AT0422 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.JobID = T1.JobID
'

SET @Sql11='
WHERE T4.TranMonth + T4.TranYear * 100 < 1 + '+LTRIM(STR(@FromYear))+' * 100
AND T2.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)
GROUP BY T1.DivisionID,T2.ObjectID, T3.ObjectName,T2.ContractNo,T2.SignDate,T2.HandOverDate,T2.ContractType,T2.ConvertedAmount,T2.ConvertedAmountBrokerage'

--PRINT @Sql
--Exec (@Sql)

-- Trong kỳ phân bổ
SET @Sql2='
SELECT T1.DivisionID
	, T2.ObjectID
	, T2.ContractNo
	, Count(T4.TranMonth + T4.TranYear * 100) as CountPeriod -- Số kỳ phân bổ trong năm
	, SUM(ISNULL(T4.DepAmount,0)) as DepAmount -- Giá trị phân bổ trong kỳ
	, SUM(ISNULL(T4.DepAmount,0) + ISNULL(A.ResidualValue,0)) as IncreaseDepAmount -- Phát Sinh Tăng trong kỳ
	, SUM(ISNULL(B.ResidualValue,0)) as DecreaseDepAmount -- Phát Sinh Giảm trong kỳ
INTO #AP043702
FROM AT0421  T1 WITH (NOLOCK)
INNER JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID,''@@@'') AND T2.ObjectID = T3.ObjectID
LEFT JOIN AT0422 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.JobID = T1.JobID
LEFT JOIN (SELECT T1.DivisionID
				,T5.NewObjectID
				,T1.ConvertedAmount - (ISNULL(T1.DepValue,0) + (SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID)) AS ResidualValue 
			FROM AT0421  T1 WITH (NOLOCK)
			INNER JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
			INNER JOIN AT0418 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.ContractNo = T2.ContractNo
			WHERE T5.NewObjectID IS NOT NULL) 
	A ON A.DivisionID = T1.DivisionID AND A.NewObjectID = T2.ObjectID
LEFT JOIN (SELECT T1.DivisionID
				,T2.ObjectID
				,T1.ConvertedAmount - (ISNULL(T1.DepValue,0) + (SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID)) AS ResidualValue 
			FROM AT0421  T1 WITH (NOLOCK)
			INNER JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
			INNER JOIN AT0418 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.ContractNo = T2.ContractNo
			WHERE T5.ContractNo IS NOT NULL) 
	B ON B.DivisionID = T1.DivisionID AND B.ObjectID = T2.ObjectID
'

SET @Sql22='
WHERE T4.TranMonth + T4.TranYear * 100 BETWEEN (1 + '+LTRIM(STR(@FromYear))+' * 100) AND (12 + '+LTRIM(STR(@ToYear))+'* 100)
AND T2.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)
GROUP BY T1.DivisionID,T2.ObjectID, T3.ObjectName,T2.ContractNo,T2.SignDate,T2.HandOverDate,T2.ContractType,T2.ConvertedAmount,T2.ConvertedAmountBrokerage
'

-- Dữ liệu báo cáo
SET @Sql3 ='
INSERT INTO #AP0437Result (DivisionID
							,ObjectID
							,ObjectName
							,ContractNo
							,SignDate
							,HandOverDate
							,PlotID
							,PlotName
							,Area
							,VoucherNo
							,Ana01ID
							,Ana02ID
							,Ana03ID
							,Ana04ID
							,Ana05ID
							,Ana06ID
							,Ana07ID
							,Ana08ID
							,Ana09ID
							,Ana10ID
							,JobID
							,ConvertedAmount
							,BeginDate
							,EndDate
							,[Periods]
							,DepMonths
							,ResidualMonths
							,DepValue
							,ResidualValue)

SELECT T1.DivisionID
	,T2.ObjectID
	,T3.ObjectName -- Khách hàng
	,T2.ContractNo -- Số hợp đồng
	,T2.SignDate -- Ngày hợp đồng
	,T2.HandOverDate -- Thời điểm bàn giao đất
	,(SELECT STUFF((
        SELECT '',''+convert(varchar(50),PlotID)
        FROM CT0156
		WHERE CT0156.APKMaster = T2.APK
        FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
      ,1,1,'''')
	  )as PlotID
	 ,(SELECT STUFF((
        SELECT '',''+convert(NVARCHAR(250),AT0416.StoreName)
        FROM CT0156
		LEFT JOIN AT0416 ON AT0416.DivisionID IN (CT0156.DivisionID,''@@@'') AND AT0416.StoreID = CT0156.PlotID
		WHERE CT0156.APKMaster = T2.APK
        FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
      ,1,1,'''')
	  )as PlotName
	,(SELECT STUFF((
        SELECT '',''+LTRIM(STR(convert(DECIMAL(28,8),AT0416.Area)))
        FROM CT0156
		LEFT JOIN AT0416 ON AT0416.DivisionID IN (CT0156.DivisionID,''@@@'') AND AT0416.StoreID = CT0156.PlotID
		WHERE CT0156.APKMaster = T2.APK
        FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
      ,1,1,'''')
	  )as Area
	,(SELECT STUFF((
        SELECT '',''+ convert(nvarchar(50),VoucherNo)
        FROM AT0423
		WHERE AT0423.DivisionID = T1.DivisionID AND AT0423.JobID = T1.JobID
        FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
      ,1,1,'''')
	  )as VoucherNo
	,T1.Ana01ID
	,T1.Ana02ID
	,T1.Ana03ID
	,T1.Ana04ID
	,T1.Ana05ID
	,T1.Ana06ID
	,T1.Ana07ID
	,T1.Ana08ID
	,T1.Ana09ID
	,T1.Ana10ID
	,T1.JobID
	--,T4.TranMonth
	--,T4.TranYear
	,CASE WHEN T2.ContractType = 4 
		  THEN T2.ConvertedAmountBrokerage 
		  ELSE T2.ConvertedAmount 
		  END AS ConvertedAmount -- Giá trị hợp đồng
	,T1.BeginDate -- Kỳ bắt đầu phân bổ
	,T2.EndDate
	,T1.[Periods] 
	,(select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID) A) AS DepMonths -- số kỳ đã phân bổ
	,(T1.Periods - (Isnull(T1.DepMonths,0) + (select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID) A))) As ResidualMonths -- Số kỳ còn lại chưa phân bổ
	,(SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID) AS DepValue -- Giá trị phân bổ luỹ kế cuối kỳ
	,T1.ConvertedAmount - (ISNULL(T1.DepValue,0) + (SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = T1.DivisionID AND T04.JobID = T1.JobID)) AS ResidualValue --Giá trị còn lại cuối kỳ
FROM AT0421  T1 WITH (NOLOCK)
INNER JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID,''@@@'') AND T2.ObjectID = T3.ObjectID
LEFT JOIN AT0422 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.JobID = T1.JobID
'

SET @Sql33='
WHERE T4.TranMonth + T4.TranYear * 100 BETWEEN (1 + '+LTRIM(STR(@FromYear))+' * 100) AND (12 + '+LTRIM(STR(@ToYear))+'* 100)
AND T2.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)
GROUP BY T1.DivisionID,T2.ObjectID, T3.ObjectName,T2.ContractNo,T2.SignDate,T2.HandOverDate,T2.ContractType
,T2.ConvertedAmount,T2.ConvertedAmountBrokerage,T1.BeginDate,T2.EndDate,T1.JobID,T1.[Periods],T1.DepMonths,T1.ConvertedAmount,T1.DepValue,T2.APK,T1.JobID,T1.Ana01ID
,T1.Ana02ID,T1.Ana03ID,T1.Ana04ID,T1.Ana05ID,T1.Ana06ID,T1.Ana07ID,T1.Ana08ID,T1.Ana09ID,T1.Ana10ID
'

SET @Sql4='
WHILE EXISTS (SELECT TOP 1 1 FROM #AP0437Result T1 LEFT JOIN #AP0437Ignore T2 ON T1.ObjectID = T2.ObjectID AND T1.ContractNo = T2.ContractNo WHERE T2.ObjectID IS NULL AND T2.ContractNo IS NULL)
BEGIN

	SET @ObjectID  = null
	SET @ContractNo = null

	SELECT TOP 1 @ObjectID = T1.ObjectID,
		@ContractNo = T1.ContractNo
	FROM #AP0437Result T1
	LEFT JOIN #AP0437Ignore T2 ON T1.ObjectID = T2.ObjectID AND T1.ContractNo = T2.ContractNo
	WHERE T2.ObjectID IS NULL AND T2.ContractNo IS NULL

	-- Tồn đầu kỳ phân bổ
	UPDATE #AP0437Result SET 
	BeginDepMonths = T2.CountPeriod,
	BeginDepAmount = T2.DepAmount
	FROM #AP0437Result T1
	INNER JOIN #AP043701 T2 ON T1.ObjectID = T2.ObjectID AND T1.ObjectID = T2.ObjectID
	WHERE T1.ObjectID = @ObjectID AND T1.ContractNo = @ContractNo

	-- Trong kỳ phân bổ
    UPDATE #AP0437Result SET 
	DepMonthsYear = T2.CountPeriod,
	DepAmountYear = T2.DepAmount,
	IncreaseDepAmount = T2.IncreaseDepAmount,
	DecreaseDepAmount = T2.DecreaseDepAmount,
	EndDepAmount = ConvertedAmount - T2.IncreaseDepAmount + T2.DecreaseDepAmount -- Giá trị phân bổ cuối cùng
	FROM #AP0437Result T1
	INNER JOIN #AP043702 T2 ON T1.ObjectID = T2.ObjectID AND T1.ObjectID = T2.ObjectID
	WHERE T1.ObjectID = @ObjectID AND T1.ContractNo = @ContractNo

	INSERT INTO #AP0437Ignore(
				 ObjectID
				,ContractNo)
	SELECT @ObjectID,@ContractNo

END
'
SET @DropTBL_ObjectID ='
Drop Table #TBL_ObjectID'

PRINT @Sql1
PRINT @Sql11
PRINT @Sql2
PRINT @Sql22
PRINT @Sql3
PRINT @Sql33
PRINT @Sql4

EXEC (@Sql1+@Sql11+@Sql2+@Sql22+@Sql3+@Sql33+@Sql4+@DropTBL_ObjectID)

-- Lấy dữ liệu phân bổ theo tháng
SELECT @cols = @cols + QUOTENAME([Month]) + ',' FROM (SELECT LTRIM(STR(T1.TranMonth)) +'_'+ LTRIM(STR(T1.TranYear)) as [Month]
														FROM AT0422 T1
														WHERE T1.TranMonth + T1.TranYear * 100 BETWEEN STR(1 + @FromYear * 100) AND STR(12 + @ToYear * 100)
														GROUP BY T1.TranYear,T1.TranMonth
														) as tmp

SELECT @cols = substring(@cols, 0, len(@cols))

IF(ISNULL(@cols,'') <> '')
BEGIN
	SET @Sql = N'
	SELECT M.* ,'+@cols+' FROM #AP0437Result M
	LEFT JOIN (
			SELECT * 
			from 
			(
				SELECT T1.DivisionID,T1.JobID,LTRIM(STR(T1.TranMonth)) +''_''+ LTRIM(STR(T1.TranYear)) as [Month], T1.DepAmount
				FROM AT0422 T1
				WHERE T1.TranMonth + T1.TranYear * 100 BETWEEN '+STR(1 + @FromYear * 100)+' AND '+STR(12 + @ToYear * 100)+'
			) src
			pivot 
			(
				max(DepAmount) for [Month] in ('+@cols+')
			) piv) C ON C.DivisionID = M.DivisionID AND C.JobID = M.JobID'

PRINT @Sql
EXEC (@Sql)
END
ELSE
BEGIN
	SELECT * FROM #AP0437Result
END

-- caption phân bổ theo tháng
SELECT T1.TranYear,'T'+ LTRIM(STR(T1.TranMonth)) as TranMonth,LTRIM(STR(T1.TranMonth)) +'_'+ LTRIM(STR(T1.TranYear)) as [Month]
FROM AT0422 T1
WHERE T1.TranMonth + T1.TranYear * 100 BETWEEN STR(1 + @FromYear * 100) AND STR(12 + @ToYear * 100)
GROUP BY T1.TranYear,T1.TranMonth
ORDER BY T1.TranYear,T1.TranMonth

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
