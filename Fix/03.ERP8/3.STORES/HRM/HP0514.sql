IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0514]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0514]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thời gian dừng máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 26/09/2017
----Modified by Bảo Thy on 20/11/2017: bổ sung StandardFromTime, StandardToTime
-- <Example>
---- 
/*-- <Example>
	EXEC [HP0514] @DivisionID = 'CH', @MachineID = 'CONE_1', @TranMonth = 1, @TranYear = 2017,
					@FromDate = '', @ToDate = '2017-01-31', @IsMode = 0
	
----*/
CREATE PROCEDURE HP0514
( 
	 @DivisionID VARCHAR(50),
	 @MachineID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsMode INT -- 0 load grid khi edit
			-- 1 load grid tại màn hình truy vấn
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@Period INT = 0

SET @OrderBy = 'HT1115.MachineID, HT1115.Date'
SET @Period = (@TranMonth + @TranYear * 100)



SET @sWhere = @sWhere + 'HT1115.DivisionID = '''+@DivisionID+''' AND (HT1115.TranMonth + HT1115.TranYear * 100) = '+STR(@Period)+' ' 

IF @IsMode = 1
BEGIN
	IF ISNULL(@MachineID,'') <> '' SET @sWhere = @sWhere + '
	AND HT1115.MachineID LIKE ''%'+@MachineID+'%'' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1115.Date, 120), 126) >= '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1115.Date, 120), 126) <= '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1115.Date, 120), 126)  BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' '

	SET @sSQL= N'
	SELECT HT1115.APK, HT1115.DivisionID, HT1115.MachineID, HT1109.MachineName, HT1115.TranMonth,  HT1115.TranYear, HT1115.Date, HT1115.Notes, 
	HT1115.FromTime, HT1115.ToTime, HT1115.TotalTime, HT1115.StandardFromTime, HT1115.StandardToTime
	FROM HT1115 WITH (NOLOCK)
	LEFT JOIN HT1109 WITH (NOLOCK) ON HT1115.DivisionID = HT1109.DivisionID AND HT1115.MachineID = HT1109.MachineID AND HT1109.Disabled = 0
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+''

END

IF @IsMode = 0
BEGIN
	SET @sWhere = @sWhere + ' AND HT1115.MachineID = '''+@MachineID+''''

	SET @sSQL= N'
	SELECT HT1115.APK, HT1115.DivisionID, HT1115.MachineID, HT1109.MachineName, HT1115.TranMonth,  HT1115.TranYear, HT1115.Date, HT1115.Notes, 
	CONVERT(DATETIME, HT1115.FromTime, 126) AS FromTime, CONVERT(DATETIME, HT1115.ToTime, 126) AS ToTime, HT1115.TotalTime, 
	CONVERT(DATETIME, HT1115.StandardFromTime, 126) AS StandardFromTime, CONVERT(DATETIME, HT1115.StandardToTime, 126) AS StandardToTime
	FROM HT1115 WITH (NOLOCK)
	LEFT JOIN HT1109 WITH (NOLOCK) ON HT1115.DivisionID = HT1109.DivisionID AND HT1115.MachineID = HT1109.MachineID AND HT1109.Disabled = 0
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+''
END



EXEC (@sSQL)
--PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
