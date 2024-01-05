IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Báo cáo hoàn trả tiền ăn (tổng hợp) mấu 2
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:	Lương Mỹ, Date: 15/01/2020
-- <Example>
---- 
/*-- <Example>
  
  EXEC EDMP30011 'VS', 'BGD',12,2018
  EDMP30011 @DivisionID= 'BE',@Month = '7',@Year = '2019'

  exec EDMP30011 @DivisionID=N'BE'',''CDX'',''CG'',''HA'',''HP'',''HTX'',''KT'',''LE'',''LU'',''MR'',''NC'',''OG'',''OP'',''OR'',''PH'',''PM'',''SU'',''TS'',''VP',
@GradeID=N'MG-3-4'',''MG-3-6'',''MG-4-5'',''MG-5-6'',''MYEST'',''NT-06-12'',''NT-13-18'',''NT-18-24'',''NT-25-36',
@FromDate='2019-11-01 00:00:00',@ToDate='2019-11-01 00:00:00'




----*/

CREATE PROCEDURE EDMP30011
(
	@DivisionID			VARCHAR(MAX),
	@GradeID			VARCHAR(MAX),
	@FromDate 			DATETIME,
	@ToDate				DATETIME
		
)
AS

SET NOCOUNT ON

    DECLARE @sSQL NVARCHAR(MAX) = N'',
            @TempDate DATETIME,
			@Today DATETIME

	SET @ToDay =  CONVERT(DATE,GETDATE())

	IF @ToDate > @ToDay
	BEGIN
		SET @ToDate = @ToDay
	END	

	SELECT Value AS DivisionID
	INTO #DivisionFilter
	FROM dbo.StringSplit(@DivisionID,''',''')
	WHERE Value <> ','

	SELECT TOP 0 
	GETDATE() AS Date,
	CONVERT(VARCHAR(50),'') AS DivisionID,			CONVERT(NVARCHAR(500),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentTotal,	CONVERT(DECIMAL(28,8), 100) AS Available,
	CONVERT(DECIMAL(28,8), 100) AS EatLunch,		CONVERT(DECIMAL(28,8), 100) AS EatDay,
	CONVERT(DECIMAL(28,8), 100) AS MoneyLunch,		CONVERT(DECIMAL(28,8), 100) AS MoneyDay,
	CONVERT(NVARCHAR(MAX), '') AS SpecialDay,		CONVERT(VARCHAR(10), '') AS IsOffDay

	INTO  #Table_EDMF30011

	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(500),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentTotal, CONVERT(DECIMAL(28,8), 100) AS Available
	INTO  #TableTemp1



	SET @TempDate = @FromDate
	WHILE @TempDate <= @ToDate
	BEGIN
		-- reset dữ liệu tạm
		TRUNCATE TABLE #TableTemp1


		INSERT INTO #Table_EDMF30011
		SELECT @TempDate, 
			T1.DivisionID AS DivisionID, T2.DivisionName AS DivisionName,
			NULL as StudentTotal,	NULL AS Available,
			NULL AS EatLunch,		NULL AS EatDay,
			NULL AS MoneyLunch,		NULL AS MoneyDay,
			NULL 	SpecialDay,		NULL AS IsOffDay
		FROM #DivisionFilter T1
		INNER JOIN AT1101 T2 WITH(NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.Disabled =0

		
		--BÁO CÁO TỔNG SỐ LƯỢNG HỌC SINH HIỆN TẠI SO VỚI THÁNG TRƯỚC #Table1
		INSERT INTO #TableTemp1
		EXEC EDMP30013 @DivisionID,@GradeID,@TempDate

		UPDATE #Table_EDMF30011
		SET StudentTotal = T3.StudentTotal, Available = T3.Available,
			EatLunch = T2.EatLunch,				EatDay = T2.EatDay,
			MoneyLunch = T2.MoneyLunch,			MoneyDay = T2.MoneyDay,
			SpecialDay = O1.Description,		IsOffDay = CASE WHEN O2.APK IS NULL THEN NULL ELSE 'X' END 
		FROM #DivisionFilter T1
		LEFT JOIN EDMF1005(@TempDate) T2 ON T2.DivisionID = T1.DivisionID
		LEFT JOIN #TableTemp1 T3 ON T3.DivisionID = T1.DivisionID

		LEFT JOIN OOT0030 O0 WITH(NOLOCK) ON O0.DivisionID = T1.DivisionID AND @TempDate BETWEEN O0.FromDate AND O0.ToDate
		LEFT JOIN OOT0031 O1 WITH(NOLOCK) ON O1.APKMaster = O0.APK AND @TempDate BETWEEN O1.StartDayOff AND O1.EndDayOff
		LEFT JOIN OOT0032 O2 WITH(NOLOCK) ON O2.APKMaster = O0.APK AND (CASE 
																			WHEN DATEPART(WEEKDAY,@TempDate) = 2 THEN O2.IsWorkMon
																			WHEN DATEPART(WEEKDAY,@TempDate) = 3 THEN O2.IsWorkTues
																			WHEN DATEPART(WEEKDAY,@TempDate) = 4 THEN O2.IsWorkWed
																			WHEN DATEPART(WEEKDAY,@TempDate) = 5 THEN O2.IsWorkThurs
																			WHEN DATEPART(WEEKDAY,@TempDate) = 6 THEN O2.IsWorkFri
																			WHEN DATEPART(WEEKDAY,@TempDate) = 7 THEN O2.IsWorkSat
																			WHEN DATEPART(WEEKDAY,@TempDate) = 1 THEN O2.IsWorkSun END = 0) 
		WHERE #Table_EDMF30011.DivisionID = T1.DivisionID 
				AND #Table_EDMF30011.Date = @TempDate

		--INSERT INTO #Table_EDMF30011
		--SELECT @TempDate, T1.DivisionID,T1.DivisionName,
		--	(T1.StudentTotal) as StudentTotal,	(T1.Available) as Available,
		--	(T2.EatLunch) AS EatLunch,			(T2.EatDay) AS EatDay,
		--	(T2.MoneyLunch) AS MoneyLunch,		(T2.MoneyDay) AS MoneyDay,
		--	O1.Description AS 	SpecialDay,		CASE WHEN O2.APK IS NULL THEN NULL ELSE 'X' END AS IsOffDay
		--FROM #TableTemp1 T1 WITH(NOLOCK)
		--LEFT JOIN EDMF1005(@TempDate) T2 ON T2.DivisionID = T1.DivisionID
		--LEFT JOIN OOT0030 O0 WITH(NOLOCK) ON O0.DivisionID = T1.DivisionID AND @TempDate BETWEEN O0.FromDate AND O0.ToDate
		--LEFT JOIN OOT0031 O1 WITH(NOLOCK) ON O1.APKMaster = O0.APK AND @TempDate BETWEEN O1.StartDayOff AND O1.EndDayOff
		--LEFT JOIN OOT0032 O2 WITH(NOLOCK) ON O2.APKMaster = O0.APK AND (CASE 
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 2 THEN O2.IsWorkMon
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 3 THEN O2.IsWorkTues
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 4 THEN O2.IsWorkWed
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 5 THEN O2.IsWorkThurs
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 6 THEN O2.IsWorkFri
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 7 THEN O2.IsWorkSat
		--																	WHEN DATEPART(WEEKDAY,@TempDate) = 1 THEN O2.IsWorkSun END = 0)

		--GROUP BY T1.DivisionID,T1.DivisionName


		SET @TempDate = DATEADD(DAY,1,@TempDate)
	END
	UPDATE #Table_EDMF30011
	SET StudentTotal = NULL, Available = NULL
	WHERE ISNULL(SpecialDay,'') ='' OR ISNULL(IsOffDay,'') =''

	SELECT * 
	FROM #Table_EDMF30011
	ORDER BY DivisionID, Date





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
