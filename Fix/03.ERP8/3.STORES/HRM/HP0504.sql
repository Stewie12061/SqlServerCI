IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách kế hoạch sản xuất theo máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Kế hoạch sản xuất theo máy
-- <History>
----Created by Bảo Thy on 15/09/2017
---- Modified by on 

/*-- <Example>
	HP0504 @DivisionID='CH', @TranMonth=5, @TranYear=2017, @MachineID='CONE_3'
----*/

CREATE PROCEDURE [dbo].[HP0504]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@MachineID AS VARCHAR(50)
)
AS
SELECT T1.APK, T1.TranMonth, T1.TranYear, T1.DivisionID, T1.MachineID, CONVERT(DATETIME,T2.FromTime,120) AS FromTime, CONVERT(DATETIME,T2.ToTime,120) AS ToTime,
'FromTime'+CASE WHEN CONVERT(VARCHAR(2),DAY([Date])) <= 9 THEN '0'+CONVERT(VARCHAR(2),DAY([Date])) ELSE CONVERT(VARCHAR(2),DAY([Date])) END AS FromTimeCol,
'ToTime'+CASE WHEN CONVERT(VARCHAR(2),DAY([Date])) <= 9 THEN '0'+CONVERT(VARCHAR(2),DAY([Date])) ELSE CONVERT(VARCHAR(2),DAY([Date])) END AS ToTimeCol
INTO #Temp1
FROM HT1110 T1 WITH (NOLOCK)
LEFT JOIN HT1111 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND CONVERT(VARCHAR(50),T1.APK) = T2.APKMaster
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T1.MachineID LIKE ISNULL(@MachineID,'%')
ORDER BY T1.MachineID

SELECT DISTINCT FromTimeCol, ToTimeCol
INTO #Temp2
FROM #Temp1

DECLARE @sSQL3 NVARCHAR(max) = '',
		@sSQL4 NVARCHAR(max) = '',
		@sSQL5 NVARCHAR(max) = '',
		@sSQL6 NVARCHAR(max) = '',
		@sSQL7 NVARCHAR(max) = '',
		@FromTime NVARCHAR(max) = '',
		@ToTime NVARCHAR(max) = ''

SELECT @sSQL3 = @sSQL3 +
	'
	SELECT	*
	INTO #Temp_FromTime
	FROM	
	(
	SELECT APK, DivisionID, TranMonth, TranYear, MachineID, FromTime, FromTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(FromTime) FOR FromTimeCol IN ('
	SELECT	@sSQL4 = @sSQL4 + CASE WHEN @sSQL4 <> '' THEN ',' ELSE '' END + '['+''+FromTimeCol+''+']'
	FROM	#Temp2
	SET @FromTime = @sSQL4
	SELECT	@sSQL4 = @sSQL4 +') ) AS BT'

SELECT @sSQL5 = @sSQL5 +
	'
	SELECT	*
	INTO #Temp_ToTime
	FROM	
	(
	SELECT DivisionID, TranMonth, TranYear, MachineID, ToTime, ToTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(ToTime) FOR ToTimeCol IN ('
	SELECT	@sSQL6 = @sSQL6 + CASE WHEN @sSQL6 <> '' THEN ',' ELSE '' END + '['+''+ToTimeCol+''+']'
	FROM	#Temp2
	SET @ToTime = @sSQL6
	SELECT	@sSQL6 = @sSQL6 +') ) AS BT'

SET @sSQL7 = '
SELECT ROW_NUMBER() OVER (ORDER BY MachineID) AS RowNum, * 
FROM 
(
	SELECT T1.APK,T1.TranMonth, T1.TranYear, T1.DivisionID, T1.MachineID, HT1109.MachineName
	'+CASE WHEN ISNULL(@FromTime,'')<>'' THEN ','+@FromTime ELSE '' END +''+CASE WHEN ISNULL(@ToTime,'')<>'' THEN ','+@ToTime ELSE '' END +'
	 FROM #Temp_FromTime T1
	 LEFT JOIN #Temp_ToTime T2 ON T1.MachineID = T2.MachineID
	 LEFT JOIN HT1109 WITH (NOLOCK) ON T1.MachineID = HT1109.MachineID AND T1.DivisionID = HT1109.DivisionID
)Temp
ORDER BY RowNum
'

--print @sSQL3
--print @sSQL4
--print @sSQL5
--print @sSQL6
--print @sSQL7

IF ISNULL(@FromTime,'')<>'' OR ISNULL(@ToTime,'')<>''
EXEC (@sSQL3+@sSQL4+@sSQL5+@sSQL6+@sSQL7)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
