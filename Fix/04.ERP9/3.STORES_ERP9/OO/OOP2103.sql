IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Load màn hình chọn hợp đồng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by:Thị Phượng Date 19/10/2017
-- Update  by:Hoàng Long Date 15/08/2023 - [2023/08/TA/0034] - Gree-Bổ sung trường phòng ban màn hình YCMH 
-- <Example>
/*
	exec OOP2103 @DivisionID = N'KY', @UserID = N'CALL002', @PageNumber = N'1', @PageSize = N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2103] (
	@DivisionID NVARCHAR(2000),
	@UserID VARCHAR(50), 
	@PageNumber INT, 
	@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX), 
	@sWhere NVARCHAR(MAX), 
	@OrderBy NVARCHAR(500), 
	@TotalRow NVARCHAR(50)

SET @sWhere = ''
SET @OrderBy = ' M.DivisionID, M.DepartmentID'

SET @sSQL = '
		SELECT M.APK, M.DivisionID, CASE WHEN M.IsCommon = 1 THEN N''Dùng chung'' ELSE D.DivisionName END AS DivisionName
				, M.DepartmentID, M.DepartmentName, M.ContactPerson, A3.FullName, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
		INTO #TemAT1021
		FROM AT1102 M WITH (NOLOCK)
			LEFT JOIN AT1101 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.ContactPerson
		WHERE M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(M.Disabled, 0) = 0

		DECLARE @count INT
		SELECT @count = COUNT(DepartmentID) FROM #TemAT1021 

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
				, M.APK, M.DivisionID, M.DivisionName, M.DepartmentID, M.DepartmentName,M.ContactPerson,M.FullName
				, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
		FROM #TemAT1021 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
