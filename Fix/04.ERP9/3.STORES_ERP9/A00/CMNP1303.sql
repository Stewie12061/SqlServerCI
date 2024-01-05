IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP1303]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP1303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load màn hình chọn kho hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tấn Lộc 17/06/2021
-- <Example>
/*
    EXEC CMNP1303 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE CMNP1303 (
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

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'A1.WareHouseID, A1.WareHouseName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '
									AND (A1.WareHouseID LIKE N''%' + @TxtSearch + '%'' 
									OR A1.WareHouseName LIKE N''%' + @TxtSearch + '%'' 
									OR A1.Address LIKE N''%' + @TxtSearch + '%'')'
									
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow
							, A1.DivisionID, A1.WareHouseID, A1.WareHouseName
							, A1.Address
				FROM AT1303 A1 WITH (NOLOCK)
				WHERE ISNULL(A1.Disabled, 0) = 0 AND ISNULL(A1.IsTemp, 0) = 0 AND (A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') OR A1.IsCommon = 1) ' + @sWhere + '
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
