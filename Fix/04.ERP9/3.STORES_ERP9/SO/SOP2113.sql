IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2113]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2113]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load danh sách đơn hàng bán
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 05/12/2019
-- Created by: Kiều Nga Date 19/11/2020 : Bổ sung lấy thêm APK
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
-- <Example>
/*
	EXEC OOP1063 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[SOP2113] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.NODEID'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = '(M.NODEID = N''' + @TxtSearch + ''' OR M.NODENAME LIKE N''%' + @TxtSearch + '%'')'


SET @sSQL = '
		SELECT M.APK, M.DivisionID, M.NodeID, M.NodeName, M.UnitID, M.StartDate, M.EndDate, M.ObjectID, A02.ObjectName , M99.Description AS NodeTypeID
		, M.QuantityVersion, M.Description, M.RoutingID,AT13.Specification
		INTO #MT2120
		FROM MT2120 M WITH(NOLOCK)
		LEFT JOIN AT1302 AT13 WITH(NOLOCK) ON M.NodeID = AT13.InventoryID AND M.DivisionID IN (''@@@'',AT13.DivisionID)
		LEFT JOIN AT1202 A02 WITH(NOLOCK) ON M.ObjectID = A02.ObjectID AND M.DivisionID IN (''@@@'',A02.DivisionID)
		LEFT JOIN MT0099 M99 WITH(NOLOCK) ON M.NodeTypeID = M99.ID AND CodeMaster = ''StuctureType''
 		WHERE M.DivisionID = ''' + @DivisionID + '''  AND ' + @sWhere + ' 
			
		DECLARE @count INT
		SELECT @count = COUNT(APK) FROM #MT2120 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
			 , @count AS TotalRow
			 , M.APK, M.DivisionID, M.NodeID, M.NodeName, M.UnitID, M.StartDate, M.EndDate, M.ObjectID, M.ObjectName , M.NodeTypeID, M.Specification
		, M.QuantityVersion, M.Description, M.RoutingID
		FROM #MT2120 M
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
