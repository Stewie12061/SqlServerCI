IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2134]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2134]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu màn hình chọn Nguồn lực.
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 13/11/2020
-- <Example>

 CREATE PROCEDURE [dbo].[MP2134] 
 (
	 @DivisionID NVARCHAR(250),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
	 ,@ResourceTypeID INT = 3 --Type customize THABICO: 0-Máy; 1-Nhân công; 2-Khac; 3-All
)
AS

DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(MAX), @OrderBy NVARCHAR(500), @TotalRow NVARCHAR(50)
,@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)
,@ColumnName NVARCHAR(MAX) = ''

SET @sWhere = 'M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
SET @OrderBy = 'M.CreateDate'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (M.MachineID LIKE N''%' + @TxtSearch + '%'' 
							 OR M.MachineName LIKE N''%' + @TxtSearch + '%'')'
IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

IF (@CustomerIndex IN (146)) -- Khách hàng THABICO
BEGIN
	IF @ResourceTypeID <> 3
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(M.ResourceTypeID,''3'') = ''' + LTRIM(@ResourceTypeID) +''' '
		SET @ColumnName = @ColumnName + N', M.TimeLimit '
	END
END

SET @sSQL = '
		SELECT M.APK
			 , M.DivisionID
             , M.MachineID AS ResourceID
             , M.MachineName AS ResourceName
             , M.Notes
             , M.Efficiency
             , M.LinedUpTime
             , M.SettingTime
             , M.WaittingTime
             , M.TransferTime
             , M.MaxTime
             , M.MinTime
             , M.Disabled
             , M.IsCommon
             , M.CreateUserID
             , M.CreateDate
             , M.LastModifyUserID
             , M.LastModifyDate
			 , M2.ID AS UnitID
             , M2.Description AS UnitName 
			 ' + @ColumnName + '
			 INTO #TempMT1820
        FROM CIT1150 M WITH(NOLOCK)
	        LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = M.UnitID AND ISNULL(M2.Disabled, 0)= 0 AND M2.CodeMaster = ''RoutingUnit''
		WHERE ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(ResourceID) FROM #TempMT1820
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow, M.*
		FROM #TempMT1820 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
