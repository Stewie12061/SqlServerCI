IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2113]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2113]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load dữ liệu GridOOF2130 tại màn hình OOF2112
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Vĩnh Tâm ON 10/09/2019
-- <Example>
/*
	EXEC OOP2113 'DTI', 'f5d0be79-c485-45c1-996b-33dfde7f2848', N'VINHTAM', 1, 25
*/

CREATE PROCEDURE [dbo].[OOP2113]
(
	@DivisionID NVARCHAR(250),
	@APK NVARCHAR(250),
	@UserID NVARCHAR(250),
	@PageNumber INT,
	@PageSize INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = ' M.AssessOrder'

	SET @sWhere = 'O1.DivisionID = ''' + @DivisionID + ''' '

	IF ISNULL(@APK, '') != ''
		SET @sWhere =  @sWhere + ' AND O1.APK = ''' + ISNULL(@APK, '00000000-0000-0000-0000-000000000000') + ''''

	SET @sSQL = N'
				SELECT
					  O2.TargetsGroupID
					, K1.TargetsGroupName
					, O2.AssessOrder
					, O2.AssessUserID
					, A1.FullName AS AssignedToUserName
					, O2.StatusID
					, O3.Description AS StatusName
					, K2.Percentage
					, IIF(O2.AssessRequired = 1 AND O2.StatusID = 0, 0, O2.Mark) AS Mark
					, O2.Note
				INTO #OOT2130Temp
				FROM OOT2110 O1
					INNER JOIN OOT2130 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
					LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O2.StatusID = O3.ID AND O3.CodeMaster = ''OOF2130.StatusID'' AND ISNULL(O3.Disabled, 0) = 0
					LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O2.AssessUserID = A1.EmployeeID AND O1.DivisionID = A1.DivisionID
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O1.AssignedToUserID = A2.EmployeeID AND O1.DivisionID = A2.DivisionID
					LEFT JOIN KPIT10101 K1 WITH (NOLOCK) ON O2.TargetsGroupID = K1.TargetsGroupID
					LEFT JOIN KPIT10102 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster AND O1.DivisionID = K2.DivisionID AND K2.DepartmentID = A2.DepartmentID
				WHERE ' + @sWhere + '
						
				DECLARE @count INT
				SELECT @count = COUNT(TargetsGroupID) FROM #OOT2130Temp
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.TargetsGroupID
					, M.TargetsGroupName
					, M.AssessOrder
					, M.AssessUserID
					, M.AssignedToUserName
					, M.StatusID
					, M.StatusName
					, M.Percentage
					, M.Mark
					, M.Note
				FROM #OOT2130Temp M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	--PRINT (@sSQL)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
