IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu màn hình chọn BOMVersion (MT2120).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 10/11/2020
-- Edit by: Nhật Quang on 03/02/2023 : Bổ sung lấy thêm cột QuantityProduct
-- Edit by: Đức Tuyên on 06/04/2023 : Bổ sung thêm trường ghi chú HIPC
-- Edit by: Minh Dũng on 06/10/2023 : Bổ sung load quy cách từ định mức
-- <Example>

 CREATE PROCEDURE [dbo].[MP2124] 
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

DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(MAX), @OrderBy NVARCHAR(500), @TotalRow NVARCHAR(50),
	@CustomerIndex NVARCHAR(50) = (SELECT CustomerName FROM CustomerIndex),
	@SelectTop NVARCHAR(MAX),
	@OrderBy_TempMT22 NVARCHAR(MAX)

IF (@CustomerIndex = 166) -- NKC
BEGIN
  SET @SelectTop = 'SELECT'
  SET @OrderBy_TempMT22 = ''
  
  SET @sWhere = 'MT22.NodeTypeID = ' + @NodeTypeID + ''
  SET @OrderBy = 'MT22.NodeTypeID, MT22.CreateDate'
  
  IF ISNULL(@TxtSearch,'') != ''
  	SET @sWhere = @sWhere + 'AND (MT22.NodeID LIKE N''%' + @TxtSearch + '%''
  							 OR MT22.NodeName LIKE N''%' + @TxtSearch + '%''
  							 OR MT22.NodeTypeID LIKE N''%' + @TxtSearch + '%''
  							 OR MT99.Description LIKE N''%' + @TxtSearch + '%'')'
  IF @IsOpportunity = 1
  	SET @sWhere = @sWhere + ' AND ISNULL(MT22.OpportunityID, '''') != '''''
  
  SET @sSQL = 'SELECT TempMT22.APK
  			 , MT22.NodeID
  			 , MT22.UnitID
  			 , MT22.NodeName
  			 , MT22.CreateDate
  			 , MT22.EndDate
  			 , MT22.StartDate
  			 , MT22.ObjectID
  			 , AT02.ObjectName
  			 , TempMT22.Version
               , MT99.Description AS NodeTypeID
  			 , MT22.LastModifyDate 
  			 , MT22.QuantityProduct
  			 , TempMT22.Description
  			 , MT89.S01ID AS Length, MT89.S02ID AS Width, MT89.S03ID AS Height INTO #TempMT2120
  		FROM MT2120 MT22 WITH (NOLOCK)
  			CROSS APPLY
              (
              '+@SelectTop+' MT22_2.APK, MT22_2.Version, MT22_2.Description FROM MT2122 MT22_2 WITH (NOLOCK) WHERE MT22_2.DivisionID = MT22.DivisionID
                                                                                      AND MT22_2.NodeID = MT22.NodeID
                                                                                  '+ @OrderBy_TempMT22 +'
              ) TempMT22
  			LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.ObjectID = MT22.ObjectID
  			LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = MT22.NodeTypeID
  			LEFT JOIN MT2121 MT23 WITH (NOLOCK) ON MT23.NodeTypeID = 0 AND MT23.APK_2120 = MT22.APK
  			LEFT JOIN MT8899 MT89 WITH (NOLOCK) ON MT89.TransactionID = CAST(MT23.APK AS VARCHAR(250))
  		WHERE ' + @sWhere + ' AND MT22.DivisionID = ''' + @DivisionID + ''' AND MT99.CodeMaster = ''StuctureType''
  			
  		DECLARE @count INT
  		SELECT @count = COUNT(NodeID) FROM #TempMT2120 
  		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow, MT22.*
  		FROM #TempMT2120 MT22
  		ORDER BY ' + @OrderBy + '
  		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
  		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
  PRINT(@sSQL)
  EXEC (@sSQL)
END
ELSE
BEGIN
SET @sWhere = 'MT22.NodeTypeID = ' + @NodeTypeID + ''
SET @OrderBy = 'MT22.NodeTypeID, MT22.CreateDate'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (MT22.NodeID LIKE N''%' + @TxtSearch + '%''
							 OR MT22.NodeName LIKE N''%' + @TxtSearch + '%''
							 OR MT22.NodeTypeID LIKE N''%' + @TxtSearch + '%''
							 OR MT99.Description LIKE N''%' + @TxtSearch + '%'')'
IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(MT22.OpportunityID, '''') != '''''

SET @sSQL = 'SELECT TempMT22.APK
			 , MT22.NodeID
			 , MT22.UnitID
			 , MT22.NodeName
			 , MT22.CreateDate
			 , MT22.EndDate
			 , MT22.StartDate
			 , MT22.ObjectID
			 , AT02.ObjectName
			 , TempMT22.Version
             , MT99.Description AS NodeTypeID
			 , MT22.LastModifyDate 
			 , MT22.QuantityProduct
			 , TempMT22.Description
			 , MT89.S01ID AS Length, MT89.S02ID AS Width, MT89.S03ID AS Height INTO #TempMT2120
		FROM MT2120 MT22 WITH (NOLOCK)
			CROSS APPLY
            (
            SELECT TOP 1 MT22_2.APK, MT22_2.Version, MT22_2.Description FROM MT2122 MT22_2 WITH (NOLOCK) WHERE MT22_2.DivisionID = MT22.DivisionID
                                                                                    AND MT22_2.NodeID = MT22.NodeID
                                                                               ORDER BY MT22_2.Version DESC
            ) TempMT22
			LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.ObjectID = MT22.ObjectID
			LEFT JOIN MT0099 MT99 WITH (NOLOCK) ON MT99.ID = MT22.NodeTypeID
			LEFT JOIN MT2121 MT23 WITH (NOLOCK) ON MT23.NodeTypeID = 0 AND MT23.APK_2120 = MT22.APK
			LEFT JOIN MT8899 MT89 WITH (NOLOCK) ON MT89.TransactionID = CAST(MT23.APK AS VARCHAR(250))
		WHERE ' + @sWhere + ' AND MT22.DivisionID = ''' + @DivisionID + ''' AND MT99.CodeMaster = ''StuctureType''
			
		DECLARE @count INT
		SELECT @count = COUNT(NodeID) FROM #TempMT2120 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow, MT22.*
		FROM #TempMT2120 MT22
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
PRINT(@sSQL)
EXEC (@sSQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
