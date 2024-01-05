IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load dữ liệu ContentMaster - SF2010 - ST2010 theo theo kiều kiện.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 06/10/2020

CREATE PROCEDURE SP2010 
( 
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@StatusID VARCHAR(50),
	@ConditionTypeID VARCHAR(50),
	@PipeLine NVARCHAR(50),
	@RefObject NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@CurrUserID VARCHAR(50), -- User đang đăng nhập hiện tại
	@GroupID VARCHAR(50) -- Nhóm của User đăng nhập.

	--@ConditionST2010 VARCHAR(MAX)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'S1.CreateDate DESC'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' S1.DivisionID IN (''' + @DivisionIDList + ''') '
ELSE
	SET @sWhere = @sWhere + ' (S1.DivisionID = ''' + @DivisionID + ''') '
	
IF ISNULL(@StatusID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(S1.StatusID, '''') IN (''' + @StatusID + ''') '

IF ISNULL(@ConditionTypeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(S1.ConditionTypeID, '''') IN (''' + @ConditionTypeID + ''') '

IF ISNULL(@PipeLine, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(S1.PipeLineName, '''') LIKE N''%' + @PipeLine + '%'' OR ISNULL(S1.PipeLineID, '''') LIKE N''%' + @PipeLine + '%'') '	

IF ISNULL(@RefObject, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(S3.ObjectTableName, '''') IN (''' + @RefObject + ''')'

--IF @CurrUserID != 'ASOFTADMIN'
--	SET @sWhere = @sWhere + ' AND ISNULL(S1.IsSystem, 0) = 0'

SELECT VALUE INTO #Temp FROM StringSplit(@GroupID,',') 

IF (NOT EXISTS (SELECT TOP 1 1  FROM #TEMP WHERE Value = 'ADMIN'))	
	SET @sWhere = @sWhere + ' AND ISNULL(S1.IsSystem, 0) = 0'

SET @sSQL ='SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, 
			COUNT(*) OVER () AS TotalRow, 
			S1.APK, S1.DivisionID, S1.PipeLineID, 
			S1.PipeLineName, S3.RefObjectName AS RefObject, 
			S2.Description AS ConditionTypeID, 
			S6.Description AS StatusID, S1.CreateUserID, S1.CreateDate
			FROM ST2010 S1 WITH (NOLOCK)
				LEFT JOIN ST0099 S2 WITH (NOLOCK) ON S2.ID = S1.ConditionTypeID AND S2.CodeMaster = ''ConditionActiveType'' AND ISNULL(S2.Disabled,0) = 0
				LEFT JOIN ST2015 S3 WITH (NOLOCK) ON S3.ObjectTableName = S1.RefObject AND S3.DivisionID IN (S1.DivisionID,''@@@'') AND ISNULL(S3.Disabled,0) = 0
				LEFT JOIN ST0099 S6 WITH (NOLOCK) ON S6.ID = S1.StatusID AND S6.CodeMaster = ''PipelineStatus'' AND ISNULL(S6.Disabled,0) = 0
			WHERE' + @sWhere +
			'ORDER BY '+@OrderBy+'
			OFFSET'+STR((@PageNumber-1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

--EXEC (@sSQLPermission + @sSQL)
--PRINT (@sSQLPermission + @sSQL)
EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
