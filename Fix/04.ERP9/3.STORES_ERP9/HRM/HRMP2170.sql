IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[HRMP2170]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[HRMP2170];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO









-- <Summary>
---- Load dữ liệu bảng HRMP2170 theo điều kiện.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Phong, Date 28/12/2020
----Modified by: 

CREATE PROCEDURE HRMP2170
(
    @DivisionIDList NVARCHAR(MAX),
    @DivisionID VARCHAR(50),
    @VoucherNo VARCHAR(50),
    @TranMonth NVARCHAR(10),
    @TranYear NVARCHAR(10),
    @DepartmentID VARCHAR(50),
    @SectionID VARCHAR(50),
    @SubsectionID VARCHAR(50),
	@EmployeeID VARCHAR(50),
    @CreateFromDate DATETIME,
    @CreateToDate DATETIME,
    @WorkFromDate DATETIME,
    @WorkToDate DATETIME,
    @Status NVARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
    @UserID NVARCHAR(50),
    @ConditionRecDecisionNo VARCHAR(MAX)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
        @FromDateText NVARCHAR(20),
        @ToDateText NVARCHAR(20),
        @sSQLPermission VARCHAR(MAX);

SET @sWhere = '';
SET @TotalRow = '';
SET @OrderBy = 'A1.VoucherNo';

IF ISNULL(@DivisionIDList, '') != ''
    SET @sWhere = @sWhere + ' A1.DivisionID IN (''' + @DivisionIDList + ''') ';
ELSE
    SET @sWhere = @sWhere + ' (A1.DivisionID = ''' + @DivisionID + ''') ';

IF ISNULL(@VoucherNo, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(A1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'') ';


IF ISNULL(@TranMonth, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(A1.TranMonth, '''') = ''' + @TranMonth + ''') ';


IF ISNULL(@TranYear, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(A1.TranYear, '''') = ''' + @TranYear + ''') ';

IF ISNULL(@ConditionRecDecisionNo, '') != ''
    SET @sWhere
        = @sWhere + ' AND ISNULL(A1.CreateUserID,'''') in (N''' + @ConditionRecDecisionNo + ''',''' + @UserID + ''' )';

IF ISNULL(@DepartmentID, '') != ''
    SET @sWhere = @sWhere + '
	AND ISNULL(A1.DepartmentID,'''') LIKE ''%' + @DepartmentID + '%'' ';


IF ISNULL(@SectionID, '') != ''
    SET @sWhere = @sWhere + '
	AND ISNULL(A1.SectionID,'''') LIKE ''%' + @SectionID + '%'' ';

--IF ISNULL(@EmployeeID, '') != ''
--    SET @sWhere = @sWhere + '
--	AND ISNULL(A2.EmployeeID,'''') LIKE ''%' + @EmployeeID + '%'' ';
IF ISNULL(@SubsectionID, '') != ''
    SET @sWhere = @sWhere + '
	AND ISNULL(A1.SubsectionID,'''') LIKE ''%' + @SubsectionID + '%'' 
	';

IF ISNULL(@Status, '') != ''  
   AND @Status <> '%'
    SET @sWhere = @sWhere + '
	AND ISNULL(A1.Status,0) = ' + @Status + ' ';

IF (@WorkFromDate IS NOT NULL AND @WorkToDate IS NOT NULL)
    SET @sWhere
        = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.WorkFromDate,120), 126) BETWEEN '''
          + CONVERT(VARCHAR(10), @WorkFromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @WorkToDate, 126)
          + '''
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.WorkToDate,120), 126) BETWEEN '''
          + CONVERT(VARCHAR(10), @WorkFromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @WorkToDate, 126) + ''' ';
IF (@WorkFromDate IS NOT NULL AND @WorkToDate IS NULL)
    SET @sWhere
        = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.WorkFromDate,120), 126) >= ''' + CONVERT(VARCHAR(10), @WorkFromDate, 126)
          + ''' ';
IF (@WorkFromDate IS NULL AND @WorkToDate IS NOT NULL)
    SET @sWhere
        = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.WorkFromDate,120), 126) =< ''' + CONVERT(VARCHAR(10), @WorkToDate, 126)
          + ''' ';
IF @CreateFromDate IS NOT NULL
    SET @sWhere
        = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.CreateDate,120), 126) >= ''' + CONVERT(VARCHAR(10), @CreateFromDate, 126)
          + ''' ';
IF @CreateToDate IS NOT NULL
    SET @sWhere
        = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.CreateDate,120), 126) <= ''' + CONVERT(VARCHAR(10), @CreateToDate, 126)
          + ''' ';

SET @sSQL
    = 'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy
      + ') AS RowNum
				, COUNT(*) OVER () AS TotalRow
				, A1.APK
				, A1.DivisionID
				, A1.VoucherNo
				, A1.OrderDate
				, A1.WorkToDate
				, A1.WorkFromDate
				, A1.Note
				,A11.DepartmentName AS DepartmentID
				, A12.TeamName AS SectionID
				, A13.AnaName AS SubsectionID
				, OOT99.Description AS Status			
				, A1.Description
				, A1.TranYear
				, A1.TranMonth
			FROM HRMT2170 A1 WITH (NOLOCK)			
			LEFT JOIN OOT0099 OOT99 WITH (NOLOCK) 
				ON OOT99.ID1 = A1.[Status] 
				   AND OOT99.CodeMaster=''Status''
			 LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID = A1.DepartmentID 
			 LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.TeamID = A1.SectionID 
			 LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID = A1.SubsectionID 
			WHERE ISNULL(A1.DeleteFlg,0) = 0 AND ' + @sWhere + '
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY ';

EXEC (@sSQL);
PRINT (@sSQL);





GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

