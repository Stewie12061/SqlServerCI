IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa dự trù chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đình Hòa on 26/04/2021
----Update by Kiều Nga on 02/06/2021 : Load dữ liệu tab đối chiếu
----Update by Nhật Quang on 05/04/2023 : Lấy số lượng là cột Gợi ý mua hàng.
----Update by Mạnh Cường on 10/08/2023 : Lấy số lượng là cột Gợi ý mua hàng.
----Update by Trọng Phúc on 11/08/2023 : Có thể chọn nhiều mặt hàng dự trù chi phí, cộng số lượng khi gộp chung lại.
----Update by Hoàng Long on 15/09/2023 : Bổ sung trường số PO
----modify by Thanh Lượng on 06/10/2023 : Bổ sung trường Specification
-- <Example>
---- 
/*-- <Example>
	POP2009 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @EstimateID = 'sfasdf'

----*/

CREATE PROCEDURE POP2009
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,	 
	@EstimateID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N''

IF (@PageNumber = 1) SET @TotalRow = '(COUNT(*) OVER ())' ELSE SET @TotalRow = 'NULL'

IF (ISNULL(@EstimateID, '') <> '')
BEGIN
	SET @sWhere = @sWhere + '   AND CONVERT(VARCHAR(50), D1.APKMaster) IN (''' + @EstimateID + ''') AND D1.SuggestQuantity > 0'
END

SET @sSQL = @sSQL + N'
SELECT D1.MaterialID as ProductID, D1.MaterialName as ProductName, D1.UnitID, D1.UnitName, D3.Specification, SUM(D1.SuggestQuantity) as ProductQuantity,D2.nvarchar01 as PONumber
INTO #OT2205
FROM OT2205 D1 WITH(NOLOCK)
LEFT JOIN OT2202 D2 ON D1.APKMaster=D2.APKMaster
LEFT JOIN AT1302 D3 ON  D3.DivisionID = D1.DivisionID and D3.InventoryID = D1.MaterialID 
WHERE D1.DivisionID = '''+@DivisionID+''' AND ( D1.SemiProduct = '''' OR D1.SemiProduct IS NULL )' 
 +@sWhere +'
 GROUP BY D1.MaterialID, D1.MaterialName, D1.UnitID, D1.UnitName,D2.nvarchar01, D3.Specification'

SET @sSQL1 = @sSQL1 + ' SELECT '+@TotalRow+' AS TotalRow, *
FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as RowNum,*
    FROM #OT2205
) AS T
WHERE RowNum BETWEEN '+STR((@PageNumber-1) * @PageSize+1)+' AND '+STR(@PageNumber * @PageSize)

PRINT @sSQL 
PRINT @sSQL1

EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
