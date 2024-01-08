IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0130]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0130]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dữ liệu Grid Công việc đang theo dõi trên màn hình Dashboard_OO
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo - [26/05/2021]
----Editted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
-- <Example>
/*
    EXEC OOP0130 'DTI', '2021-05-26 00:00:00', 'ASOFTADMIN'
*/
CREATE proc [dbo].[OOP0130]
(
	@DivisionID VARCHAR(50),
	@ToDay DATETIME,
	@UserID VARCHAR(50),
	@StatusID VARCHAR(50)
)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
		@TodayConvert NVARCHAR(10)
	
	SET @sWhere = ''
	SET @TodayConvert = CONVERT(NVARCHAR(10), @Today, 111)

	SET @sWhere = @sWhere + 'AND O1.StatusID IN ('''+ @StatusID +''')'
	SET @sWhere = @sWhere + ' AND ('

	DECLARE @Number INT = 1 ;
	DECLARE @Column varchar(20);
	WHILE @Number <= 49
	BEGIN
		IF (@Number < 10)
		BEGIN
			SET @Column = 'FollowerID0' + Convert(varchar(5), @Number);
		END
		ELSE
		BEGIN
			SET @Column = 'FollowerID' + Convert(varchar(5), @Number);
		END
		SET @sWhere = @sWhere + 'C1.'+ @Column + ' = ''' + @UserID + ''' OR '
		SET @Number = @Number + 1;
	END

	SET @sWhere = @sWhere + 'FollowerID50 = ''' + @UserID + ''')'
	SET @OrderBy = 'M.PriorityID DESC, M.PlanEndDate'

	SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY M.PriorityID DESC, M.PlanEndDate) AS RowNum
		, M.TaskID, M.TaskName, A1.FullName AS AssignedToUserID, M.PlanStartDate, M.PlanEndDate, O2.Description AS TaskTypeID, M.APK
		, M.PercentProgress, M.StatusID, O1.StatusName, O3.Color
		, IIF((ISNULL(M.PercentProgress, 0) < 100 AND CONVERT(NVARCHAR(10), M.PlanEndDate, 111) < ''' + @TodayConvert + '''), 1, 0) AS OutOfDeadline
	FROM OOT2110 M WITH (NOLOCK)
		INNER JOIN OOT9020 C1 WITH (NOLOCK) ON M.APK = C1.APKMaster AND C1.DivisionID =''' + @DivisionID + '''
		INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
		INNER JOIN OOT1040 O1 WITH (NOLOCK) ON M.StatusID = O1.StatusID
		LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON M.TaskTypeID = O2.ID
			AND ISNULL(O2.Disabled, 0) = 0 AND O2.CodeMaster = ''OOF1060.TaskType''
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = M.StatusID'

	SET @sSQL01 = ' WHERE ISNULL(M.DeleteFlg, 0) = 0 ' + @sWhere + '
	ORDER BY ' + @OrderBy

	PRINT(@sSQL)
	PRINT(@sSQL01)
	EXEC (@sSQL + @sSQL01)
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
