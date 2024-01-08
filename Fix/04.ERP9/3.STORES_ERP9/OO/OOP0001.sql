IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load form OOF2110 - Load Danh sách dự án để vẽ Biểu đồ tiến độ dự án
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Khâu Vĩnh Tâm ON 06/08/2019
----Updated by: Thái Đình Ly ON 25/11/2019
----Updated by: Hoài Bảo ON 11/11/2022 - Bổ sung lọc theo nhiều đơn vị
-- <Example>
/*
	EXEC OOP0001 'DTI', 'TTDA0001', '2019-06-01', '2019-07-31', 'HUULOI5'
*/

CREATE PROCEDURE [dbo].[OOP0001]
(
	@DivisionID NVARCHAR(250),
	@DivisionIDList NVARCHAR(MAX),
	@StatusID NVARCHAR(250),
	@StartDate DATETIME,
	@EndDate DATETIME,
	@UserID NVARCHAR(250),
	@ConditionProjectID VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)
	
	SET @FromDateText = CONVERT(NVARCHAR(20), @StartDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @EndDate, 111) + ' 23:59:59'

	--Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' O1.DivisionID IN (''' + @DivisionIDList + ''') AND ISNULL(O1.DeleteFlg, 0) = 0'
	ELSE
		SET @sWhere = ' O1.DivisionID = N''' + @DivisionID + ''' AND ISNULL(O1.DeleteFlg, 0) = 0'

	--SET @sWhere = ' O1.DivisionID = N''' + @DivisionID + ''' AND ISNULL(O1.DeleteFlg, 0) = 0'

	SET @sWhere = @sWhere + ' AND (O1.StartDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
									OR O1.EndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '

	IF ISNULL(@StatusID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O1.StatusID, '''') IN (''' + @StatusID + ''') '
	
	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2100'') IS NOT NULL DROP TABLE #PermissionOOT2100

							SELECT Value
							INTO #PermissionOOT2100
							FROM STRINGSPLIT(''' + ISNULL(@ConditionProjectID, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterProjectAPK'') IS NOT NULL DROP TABLE #FilterProjectAPK

							SELECT DISTINCT O1.APK
							INTO #FilterProjectAPK
							FROM OOT2100 O1 WITH (NOLOCK)
								LEFT JOIN OOT2101 O2 WITH (NOLOCK) ON O2.RelatedToID = O1.ProjectID
								LEFT JOIN OOT2103 O3 WITH (NOLOCK) ON O3.RelatedToID = O1.ProjectID
								LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O2.DepartmentID
								INNER JOIN #PermissionOOT2100 T1 ON T1.Value IN (O1.LeaderID, O1.CreateUserID, O3.UserID, A1.ContactPerson)
							WHERE ' + @sWhere + '
							'
							
	SET @sSQL = '
		SELECT
			O1.ProjectID , O1.ProjectName , O1.StartDate , O1.EndDate
		  , ISNULL(O1.PercentProgress, 0) AS PercentProgress , O1.StatusID
		INTO #temTable
		FROM OOT2100 O1 WITH (NOLOCK)
			INNER JOIN #FilterProjectAPK T1 ON O1.APK = T1.APK
		ORDER BY O1.LastModifyDate DESC

		SELECT T1.ProjectID
			 , T1.ProjectName
			 , SUM(T1.ActualTime) AS PercentProgress
			 , (SELECT SUM(O1.PlanTime) 
			  FROM OOT2110 O1 WITH (NOLOCK)
			  WHERE O1.ProjectID = T1.ProjectID) AS PlanPercentProgress
			 , T1.StartDate
			 , T1.EndDate
		FROM(
			SELECT O.ProjectID, O1.ProjectName, O1.StartDate, O1.EndDate,
				   CASE
					 WHEN O.StatusID = ''TTCV0002''
						THEN O.PlanTime * (O.PercentProgress / 100)
						ELSE O.PlanTime
				   END AS ActualTime
			FROM OOT2110 O WITH (NOLOCK)
				LEFT JOIN #temTable O1 ON O1.ProjectID = O.ProjectID
			WHERE O.ProjectID = O1.ProjectID AND O.StatusID IN (''TTCV0003'', ''TTCV0002'')
		) AS T1
		GROUP BY T1.ProjectID, T1.ProjectName, T1.StartDate, T1.EndDate'

	EXEC (@sSQLPermission + @sSQL)
	--PRINT(@sSQLPermission + @sSQL)
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
