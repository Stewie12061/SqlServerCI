IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn nhân viên
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ
----Modify by Thị Phượng, Bổ sung IsCommon = 1 load các nhân viên dùng chung
----Modify by Hồng Thảo on 10/09/2019: Fix lỗi không load tên phòng ban khi phòng ban có division dùng chung
----Modify by Vĩnh Tâm on 16/10/2019: Thêm điều kiện để không load các User đã bị khóa
----Modify by Hồng Thảo on 12/4/2019: Fix lỗi double dữ liệu khi 1 user được add nhiều division trong at1405
----Modify by Vĩnh Tâm on 02/03/2020: Bổ sung param @ConditionTaskID để lọc dữ liệu user theo phân quyền Xem công việc
----Modify by Kiều Nga on 17/04/2020: Bổ sung không load user hiện tại
----Modify by Hoài Phong on 01/09/2020: Bổ Sung customer  Cho DTI load luôn người tạo
----Modify by Hoài Bảo on 12/01/2021: Bổ sung điều kiện không load user hệ thống (UNASSIGNED)
----Modify by Hoàng Long on 30/08/2023: Bổ sung điều kiện phòng ban(@DepartmentName)
----Modify by Thanh Lượng on 01/12/2023: [2023/11/TA/0176] - Bổ sung điều kiện phòng ban(@DepartmentID)
-- <Example>
/*
    EXEC CMNP90031 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE CMNP90031 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @UserID2 VARCHAR(50) ='',
	 @DepartmentName NVARCHAR(50)='',
	 @DepartmentID NVARCHAR(50)=''

)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerIndex int 

	select @CustomerIndex = CustomerName from CustomerIndex
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1103.EmployeeID, AT1103.FullName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '
									AND (AT1103.EmployeeID LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.FullName LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Address LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.DepartmentID LIKE N''%' + @TxtSearch + '%'' 
									OR AT1102.DepartmentName LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Tel LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Email LIKE N''%' + @TxtSearch + '%'')'
	
	IF ISNULL(@ConditionTaskID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND AT1103.EmployeeID IN (''' + @ConditionTaskID + ''')'
	END
	IF ISNULL(@UserID2, '') != ''
	BEGIN
		if(@CustomerIndex <> 114) -- DTI
			SET @sWhere = @sWhere + ' AND AT1103.EmployeeID NOT IN (''' + @UserID2 + ''')'
	END

	IF ISNULL(@DepartmentName, '') != ''
	BEGIN
		if(@CustomerIndex = 162) -- GREE
			SET @sWhere = @sWhere + ' AND AT1102.DepartmentName LIKE N''%' + @DepartmentName + '%'' '
	END

	IF ISNULL(@DepartmentID, '') != ''
	BEGIN
			SET @sWhere = @sWhere + ' AND AT1102.DepartmentID = (''' + @DepartmentID + ''')'
	END

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow
							, AT1103.DivisionID, AT1103.EmployeeID, AT1103.FullName AS EmployeeName
							, AT1103.DepartmentID, AT1102.DepartmentName, AT1103.Address
							, AT1103.Tel, AT1103.Email, AT1103.IsCommon, AT1103.Disabled
							, A02.ContactPerson AS ContactPersonID
							, A03.UserName AS ContactPersonName
				FROM AT1103 WITH (NOLOCK)
					LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID, ''@@@'')
							AND AT1103.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
					LEFT JOIN AT1405 WITH (NOLOCK) ON AT1103.EmployeeID = AT1405.UserID AND AT1405.DivisionID IN (AT1103.DivisionID,''@@@'')
					LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = AT1103.DepartmentID
					LEFT JOIN AT1405 A03 WITH (NOLOCK) ON A03.UserID = A02.ContactPerson
				WHERE ISNULL(AT1103.Disabled, 0) = 0 AND ISNULL(AT1405.IsLock, 0) = 0 AND (AT1103.DivisionID IN (''' + @DivisionID + ''') OR AT1103.IsCommon = 1) 
				AND AT1103.EmployeeID NOT IN (''ASOFTADMIN'',''UNASSIGNED'') ' + @sWhere + '
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
