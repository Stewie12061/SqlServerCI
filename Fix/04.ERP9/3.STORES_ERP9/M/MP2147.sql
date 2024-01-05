IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2147]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2147]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid: Lấy dữ liệu thời gian của các kế hoạch sản xuất có trong database.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Trọng Kiên on 08/04/2021
----Modified by Lê Hoàng on 04/06/2021 : Bổ sung kiều kiện DeleteFlg = 0
-- <Example>
----

CREATE PROCEDURE [dbo].[MP2147]
( 
	 @APK VARCHAR(250),
	 @ListMachine VARCHAR(MAX),
	 @StartDate VARCHAR(50),
	 @EndDate VARCHAR(50),
	 @DivisionID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', @sWhere NVARCHAR(MAX) = N''

IF ISNULL(@APK, '') != '' BEGIN
	SET @sWhere = @sWhere + 'M1.APKMaster <> ''' + @APK + ''' AND '
END

SET @sSQL = @sSQL + N'

	SELECT M2.Date
		 , M1.MachineID
		 , CASE WHEN M1.UnitID = ''0'' THEN M1.TimeNumber WHEN M1.UnitID =''1'' THEN M1.TimeNumber * 60 END AS TimeNumber INTO #Temp2321
	FROM MT2142 M1 WITH (NOLOCK)
		LEFT JOIN MT2143 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
	WHERE '+@sWhere+' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND M1.MachineID IN (''' + @ListMachine + ''') 
		AND M1.DeleteFlg = 0 
		AND M2.DeleteFlg = 0 
		AND M2.Date IS NOT NULL 
		AND CONVERT(VARCHAR(50), M2.Date, 103) BETWEEN ''' + @StartDate + ''' AND ''' + @EndDate + '''
	ORDER BY MachineID

	SELECT MachineID, SUM(TimeNumber) AS TimeNumber, CONVERT(VARCHAR(50), Date, 103) AS Date
	FROM #Temp2321
	GROUP BY MachineID, Date
	ORDER BY MachineID'

EXEC (@sSQL)
PRINT(@sSQL)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
