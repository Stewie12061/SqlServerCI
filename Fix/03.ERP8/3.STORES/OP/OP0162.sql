IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0162]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dữ liệu màn hình danh sách kế hoạch bán hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tieu Mai on 31/03/2016
---- Modified by Bảo Thy on 23/05/2017: Sửa danh mục dùng chung
---- Modified by ... on ...
-- <Example>
/*
	OP0162 'HT', 3, 2016, 3, 2016, '03/01/2016', '03/30/2016', 0, '%'
*/
CREATE PROCEDURE OP0162
(
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT,
	@PlanPrice NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX)

IF @IsDate = 0
BEGIN
	SET @sSQL = '
	SELECT OT0149.*, FullName  
	FROM OT0149 left join AT1103 on OT0149.DivisionID = AT1103.DivisionID
      and OT0149.EmployeeID = AT1103.EmployeeID
	WHERE OT0149.DivisionID = '''+@DivisionID+'''
		AND TranMonth + TranYear*100 BETWEEN ' +Convert(nvarchar(10),@FromMonth)+ ' + ' + Convert(nvarchar(10),@FromYear)+'*100 AND ' +Convert(nvarchar(10),@ToMonth)+ ' + ' +Convert(nvarchar(10),@ToYear)+'*100
		AND ISNULL(OT0149.PlanPrice,'''') LIKE '''+@PlanPrice+'''
    ' 
END	
ELSE 
	BEGIN
		SET @sSQL = '
			SELECT OT0149.*, FullName  
			FROM OT0149 left join AT1103 on OT0149.EmployeeID = AT1103.EmployeeID
			WHERE OT0149.DivisionID = '''+@DivisionID+'''
				AND Convert(nvarchar(10),VoucherDate,112) BETWEEN ' +Convert(nvarchar(10),@FromDate,112)+ ' AND ' +Convert(nvarchar(10),@ToDate,112)+'
				AND ISNULL(OT0149.PlanPrice,'''') LIKE '''+@PlanPrice+'''
    ' 
	END	


EXEC (@sSQL)
--PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
