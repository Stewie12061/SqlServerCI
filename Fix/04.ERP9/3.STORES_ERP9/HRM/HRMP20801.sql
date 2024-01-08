IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP20801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP20801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xuất phiếu in -Store HRMP20801
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Tiến Sỹ on 07/11/2023
----Updated by: Võ Dương on 02/10/2023
---exec HRMP20801 @APK=N'9a0fed09-5b90-4188-8764-94270bec79ac'',''58aa5581-51eb-416e-84d4-8dfddd999c2e'
--SELECT * FROM AT1102
CREATE PROCEDURE HRMP20801
( 
    @APK NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
      
SET @sWhere = 'HRMT2080.APK IN ('''+@APK+''')'

SET @OrderBy = 'TrainingRequestID DESC'
	
SET @sSQL = N'SELECT AT1101.DivisionName, HRMT2080.TrainingRequestID,AT1103.fullname AS AssignedToUserName,
			STUFF(( SELECT '','' + AT1102.DepartmentName
								FROM   AT1102 WITH (NOLOCK) 
								WHERE   AT1102.DepartmentID IN (SELECT Value FROM dbo.StringSplit(HRMT2080.DepartmentID,'',''))
								ORDER BY AT1102.DepartmentID
								FOR XML PATH('''')), 1, 1, '''') AS DepartmentName,
			HRMT1040.TrainingFieldName,HRMT2080.NumberEmployee,HRMT2080.TrainingFromDate,HRMT2080.TrainingToDate,HRMT2080.Description1,HRMT2080.Description2,
			CASE WHEN EXISTS (SELECT TOP 1 1 FROM HRMT2091 WITH (NOLOCK) WHERE HRMT2091.DivisionID = HRMT2080.DivisionID AND HRMT2091.ID = HRMT2080.TrainingRequestID 
			AND HRMT2091.InheritTableID = ''HRMT2080'') THEN N''Đã được lập đề xuất'' ELSE NULL END StatusName
			FROM HRMT2080 
			LEFT JOIN AT1101 ON AT1101.DivisionID = HRMT2080.DivisionID
			LEFT JOIN AT1103 ON AT1103.EmployeeID = HRMT2080.AssignedToUserID
			LEFT JOIN HRMT1040 ON HRMT1040.TrainingFieldID = HRMT2080.TrainingFieldID
			WHERE  '+ @sWhere +'
			ORDER BY '+ @OrderBy

--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
