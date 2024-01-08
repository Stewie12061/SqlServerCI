IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2183]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2183]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn nhân viên từ hợp đồng lao động 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phương Thảo
-- <Example>
/*
    EXEC HRMP2183 @DivisionID=N'BBA-SI',@TxtSearch=N'',@UserID=N'ADMIN',@PageNumber=N'1',@PageSize=N'25'
*/

 CREATE PROCEDURE HRMP2183 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @UserID2 VARCHAR(50) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'EmployeeID, EmployeeName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
				SELECT HT60.DivisionID, HT60.EmployeeID AS EmployeeID,  AT03.FullName AS EmployeeName, AT02.DepartmentName AS DepartmentName, HT60.ContractNo AS ContractNo, HT60.WorkDate AS WorkDate, HT60.WorkEndDate AS WorkEndDate , HT05.ContractTypeName AS ContractTypeName
				FROM HT1360  HT60 WITH (NOLOCK)
				LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID = HT60.DivisionID AND AT03.EmployeeID     = HT60.EmployeeID
				LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DivisionID = HT60.DivisionID AND AT02.DepartmentID   = HT60.DepartmentID
				LEFT JOIN HT1105 HT05 WITH (NOLOCK) ON HT05.DivisionID = HT60.DivisionID AND HT05.ContractTypeID = HT60.ContractTypeID 
				WHERE HT60.DivisionID = '''+@DivisionID+''' 
				'+@sWhere+' ) HT1360
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
				'
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO