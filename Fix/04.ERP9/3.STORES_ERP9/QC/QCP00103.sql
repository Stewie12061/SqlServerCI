IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP00103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[QCP00103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- <summary>
---- Load dữ liệu Biểu đồ tỷ lệ hàng NG theo NCC (QCD0004)
--- <history>
---- Created by Anh Đô on 07/08/2023
---- Modified by Anh Đô on 18/08/2023: Fix lỗi load dữ liệu
---- Modified by Anh Đô on 26/08/2023: Cập nhật xử lý lấy dữ liệu

CREATE PROC QCP00103
(
	@DivisionID		VARCHAR(MAX)
  ,	@ListPeriod		VARCHAR(MAX)
  , @ListSuplier	VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX)
		  , @sWhere NVARCHAR(MAX) = ''

	CREATE TABLE #ChartLine
	(
		[CategoryID] VARCHAR(50)
      , [CategoryName] NVARCHAR(100)
	  , [TargetPercent] DECIMAL
	  , [OKQuantity] DECIMAL
	  , [NGQuantity] DECIMAL
	)

	CREATE TABLE #Supliers
	(
		SuplierID VARCHAR(50)
	)

	INSERT INTO #Supliers
	SELECT [Value]  FROM [dbo].StringSplit(@ListSuplier, ',')

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = 'Q1.DivisionID IN (SELECT Value FROM [dbo].StringSplit('''+ @DivisionID +''', '','')) '

	SET @sSql = N'
		SELECT [Name] INTO #PeriodTmp FROM SplitString('''+ @ListPeriod +''', '','')
		
		DECLARE @Period VARCHAR(50),
				@Month INT,
				@Year INT
				 
		WHILE EXISTS(SELECT TOP 1 1 FROM #PeriodTmp)
		BEGIN
			SET @Period = (SELECT TOP 1 [Name] FROM #PeriodTmp)
			SET @Month = (SELECT TOP 1 Value FROM [dbo].StringSplit(@Period, ''/''))
			SET @Year = CONVERT(INT, RIGHT(@Period, 4))

			INSERT INTO #ChartLine
			SELECT 
				M.SuplierID AS CategoryID
              , A1.ObjectName AS CategoryName
			  , CASE WHEN @Month = 1 THEN ISNULL(Q1.Value1, 0)
					 WHEN @Month = 2 THEN ISNULL(Q1.Value2, 0)
					 WHEN @Month = 3 THEN ISNULL(Q1.Value3, 0)
					 WHEN @Month = 4 THEN ISNULL(Q1.Value4, 0)
					 WHEN @Month = 5 THEN ISNULL(Q1.Value5, 0)
					 WHEN @Month = 6 THEN ISNULL(Q1.Value6, 0)
					 WHEN @Month = 7 THEN ISNULL(Q1.Value7, 0)
					 WHEN @Month = 8 THEN ISNULL(Q1.Value8, 0)
					 WHEN @Month = 9 THEN ISNULL(Q1.Value9, 0)
					 WHEN @Month = 10 THEN ISNULL(Q1.Value10, 0)
					 WHEN @Month = 11 THEN ISNULL(Q1.Value11, 0)
					 WHEN @Month = 12 THEN ISNULL(Q1.Value12, 0) ELSE 0 
			   END AS TargetPercent
			 , ISNULL(P.OKQuantity, 0) AS OKQuantity
			 , ISNULL(P.NGQuantity, 0) AS NGQuantity

			FROM #Supliers M WITH (NOLOCK)
			LEFT JOIN QCT2081 Q1 WITH (NOLOCK) ON Q1.ObjectID = M.SuplierID
			LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = M.SuplierID AND A1.IsSupplier = 1 AND A1.DivisionID IN ('''+ @DivisionID +''')
			LEFT JOIN (
				SELECT 
					  Q1.ObjectID
					, SUM(ISNULL(Q2.QuantityQC, 0)) AS OKQuantity
					, SUM(ISNULL(Q2.QuantityUnQC, 0)) AS NGQuantity
				FROM QCT2000 Q1 WITH (NOLOCK)
				LEFT JOIN QCT2001 Q2 WITH (NOLOCK) ON Q2.APKMaster = Q1.APK
				LEFT JOIN OT3002 O1 WITH (NOLOCK) ON O1.TransactionID = Q2.InheritTransaction AND Q2.InheritTable = ''OT3001'' AND O1.DivisionID = Q2.DivisionID
				WHERE Q1.TranMonth = @Month AND Q1.TranYear = @Year
				GROUP BY Q1.ObjectID
			) AS P ON P.ObjectID = M.SuplierID

			DELETE FROM #PeriodTmp WHERE [Name] = @Period
		END
	'

	SET @sSql = @sSql + N'
		SELECT * FROM (
			SELECT
				M.CategoryID
			  , M.CategoryName
			  , CASE WHEN (SUM(M.NGQuantity) + SUM(M.OKQuantity)) != 0 THEN SUM(M.NGQuantity) / (SUM(M.NGQuantity) + SUM(M.OKQuantity)) * 100 ELSE 0 END AS ActualPercent
			  , SUM(M.TargetPercent) / COUNT(M.CategoryID) AS TargetPercent
			FROM #ChartLine M WITH (NOLOCK)
			GROUP BY M.CategoryID, M.CategoryName
		) AS P
		WHERE NOT (ActualPercent = 0 AND TargetPercent = 0)
	'

	EXEC(@sSql)
	PRINT(@sSql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
