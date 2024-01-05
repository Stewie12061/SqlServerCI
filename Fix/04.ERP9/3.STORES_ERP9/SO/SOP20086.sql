IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load grid danh sách MPT màu in. (MAITHU)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tài ON 17/07/2023
-- <Example>
/*
exec SOP20086 @DivisionID='AT',@UserID='ASOFTADMIN',@SaleEmployeeID='%',@ObjectID='%',@FromDate='2019-01-07 10:51:26.573',@ToDate='2019-01-07 10:51:26.573',@PageNumber=1,@PageSize=25

*/
CREATE PROCEDURE SOP20086
(
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
SET @OrderBy = 'O.AnaID'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND 
							(
								(A2.InventoryID LIKE N''%' + @TxtSearch + '%'')
								OR
								(A2.InventoryName LIKE N''%' + @TxtSearch + '%'')
							)
								
	'

SET @sSQL = '
		SELECT InventoryID AS AnaID
				, InventoryName AS AnaName
		INTO #TemSOP20086
		FROM AT1302 A2 WITH (NOLOCK)
			LEFT JOIN AT1015 T25 WITH (NOLOCK) ON T25.DivisionID IN (''@@@'', A2.DivisionID, ''' + @DivisionID + ''')
													AND T25.AnaID = A2.I02ID
													AND T25.AnaTypeID = ''I02''
		WHERE ' + @sWhere + '
		AND A2.DivisionID IN (''' + @DivisionID + ''', ''@@'')
		AND T25.AnaID = (SELECT TOP 1 ClassifyID FROM CRMT00000 WITH (NOLOCK))
			
		DECLARE @count INT
		SELECT @count = COUNT(AnaID) FROM #TemSOP20086 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
			 , @count AS TotalRow
			 , O.AnaID
			 , O.AnaName
		FROM #TemSOP20086 O
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
