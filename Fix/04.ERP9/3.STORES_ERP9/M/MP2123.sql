IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu màn hình chọn cấu trúc sản phẩm (MT2110).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 10/11/2020
-- Updated by: Thanh Lượng Date 14/09/2023 - [2023/09/TA/0070]: Bổ sung load trường Specification
-- <Example>

 CREATE PROCEDURE [dbo].[MP2123] 
 (
	 @NodeTypeID VARCHAR(250),
	 @DivisionID NVARCHAR(250),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(MAX), @OrderBy NVARCHAR(500), @TotalRow NVARCHAR(50)

SET @sWhere = 'MT10.NodeTypeID = ' + @NodeTypeID + ''
SET @OrderBy = 'MT10.NodeTypeID, MT10.CreateDate'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (MT10.NodeID LIKE N''%' + @TxtSearch + '%''
							 OR MT10.NodeName LIKE N''%' + @TxtSearch + '%''
							 OR MT10.NodeTypeID LIKE N''%' + @TxtSearch + '%''
							 OR MT99.Description LIKE N''%' + @TxtSearch + '%''
							 OR AT14.UnitName LIKE N''%' + @TxtSearch + '%''
							 OR MT10.UnitID LIKE N''%' + @TxtSearch + '%'')'
IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(MT10.OpportunityID, '''') != '''''

SET @sSQL = 'SELECT MT10.APK
			 , MT10.NodeID
			 , MT10.NodeName
			 , MT10.UnitID
			 , AT14.UnitName
			 , MT10.CreateDate
			 , MT99.ID AS NodeTypeID
             , MT99.Description AS NodeTypeName
			 , MT10.Specification
			 , MT10.LastModifyDate INTO #TempMT2110
		FROM MT2110 MT10 WITH (NOLOCK)
			LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = MT10.NodeTypeID
			LEFT JOIN AT1304 AT14 WITH (NOLOCK) ON AT14.UnitID = MT10.UnitID
		WHERE ' + @sWhere + ' AND MT10.DivisionID = ''' + @DivisionID + ''' AND MT99.CodeMaster = ''StuctureType''
			
		DECLARE @count INT
		SELECT @count = COUNT(NodeID) FROM #TempMT2110 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow, MT10.*
		FROM #TempMT2110 MT10
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
