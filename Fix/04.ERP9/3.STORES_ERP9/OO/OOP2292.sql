IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2292]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2292]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---<summary>
--- Load dữ liệu màn hình Xem chi tiết chỉ tiêu/công việc
---<history>
--- Created by Anh Đô on 27/06/2023
--- Modified by Anh Đô on 06/07/2023: Select thêm cột StatusID, StatusName, Color

CREATE PROC OOP2292
(
	@APK	VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSql	NVARCHAR(MAX) = ''
		  , @sSql1	NVARCHAR(MAX) = ''
		  , @sSql2	NVARCHAR(MAX) = ''

	SET @sSql = N'
		SELECT
			M.APK
			, M.DivisionID
			, A1.DivisionName
			, M.TargetTaskID
			, M.TargetTaskName
			, M.TypeID
			, O1.Description AS TypeName
			, M.BeginDate
			, M.EndDate
			, M.PriorityID
			, C1.Description AS PriorityName
			, M.RequestUserID
			, A2.UserName AS RequestUserName
			, M.AssignedUserID
			, A3.UserName AS AssignedUserName
			, M.Description
			, A4.UserName AS CreateUserName
			, M.CreateDate
			, A5.UserName AS LastModifyUserName
			, M.LastModifyDate
			, M.StatusID
			, O2.StatusName
			, O2.Color
		INTO #OOF2292_Master
		FROM OOT2290 M WITH (NOLOCK)
		LEFT JOIN AT1101 A1 WITH (NOLOCK) ON A1.DivisionID = M.DivisionID
		LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.CodeMaster = ''OOF2290.Type'' AND O1.ID = M.TypeID
		LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND C1.ID = M.PriorityID
		LEFT JOIN AT1405 A2 WITH (NOLOCK) ON A2.UserID = M.RequestUserID AND A2.DivisionID IN (M.DivisionID, ''@@@'')
		LEFT JOIN AT1405 A3 WITH (NOLOCK) ON A3.UserID = M.AssignedUserID AND A3.DivisionID IN (M.DivisionID,  ''@@@'')
		LEFT JOIN AT1405 A4 WITH (NOLOCK) ON A4.UserId = M.CreateUserID	AND A4.DivisionID IN (M.DivisionID,  ''@@@'')
		LEFT JOIN AT1405 A5 WITH (NOLOCK) ON A5.UserId = M.LastModifyUserID AND A5.DivisionID IN (M.DivisionID,  ''@@@'')
		LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON O2.StatusID = M.StatusID
		WHERE M.APK = '''+ @APK +'''
	'

	-- Lấy số lượng task đã hoàn thành của mỗi chỉ tiêu/công việc
	SET @sSql1 = N'
		SELECT
			  M.APKParent
			, COUNT(CASE WHEN O1.StatusID = ''TTCV0003'' THEN 1 ELSE NULL END) AS DoneTask
			, CONVERT(DECIMAL, COUNT(*)) AS TotalTask
		INTO #OOF2292_DoneTasks
		FROM CRMT0088 M WITH (NOLOCK)
		INNER JOIN OOT2110 O1 WITH (NOLOCK) ON O1.APK = M.APKChild
		WHERE M.TableBusinessParent =''OOT2290'' AND M.TableBusinessChild = ''OOT2110'' AND M.APKParent IN (SELECT APK FROM #OOF2292_Master)
		GROUP BY M.APKParent
	'

	SET @sSql2 = N'
		SELECT
			  M.*
			, CASE WHEN DT.TotalTask != 0 THEN DT.DoneTask / DT.TotalTask * 100 ELSE 0 END AS Progress
		FROM #OOF2292_Master M WITH (NOLOCK)
		LEFT JOIN #OOF2292_DoneTasks DT WITH (NOLOCK) ON DT.APKParent = M.APK
	'

	EXEC(@sSql + @sSql1 + @sSql2)
	PRINT(@sSql + @sSql1 + @sSql2)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
