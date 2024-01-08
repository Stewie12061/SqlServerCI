IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load Grid chi tiết màn hình điều chỉnh tăng giảm khi nhấn thực hiện tại màn hình WF0020
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 30/10/2015
---- Moified by ... on ...
---- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Hoài Bảo on 23/11/2022 : Bổ sung load tên đơn vị tính, tài khoản nợ/tài khoản có
-- <Example>
/*
	exec WP0022 'SC','ASOFTADMIN','','',1
*/
CREATE PROCEDURE WP0022
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@ListInventoryID NVARCHAR (MAX),
	@IsType TINYINT=0 --1: Điều chỉnh tăng , 2: điều chỉnh giảm
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WP0022_QC @DivisionID, @UserID, @VoucherID, @ListInventoryID, @IsType
ELSE 
BEGIN


	DECLARE @sSQL NVARCHAR(MAX),
			@SWhere NVARCHAR(MAX)
		
	IF @IsType=1
		SET @SWhere='AND Isnull(Quantity,0)-Isnull(AdjustQuantity,0)<0 '
	ELSE 
		SET @SWhere='AND Isnull(Quantity,0)-Isnull(AdjustQuantity,0)>0 '

	SET @sSQL = '
	SELECT A37.*, A02.InventoryName, A04.UnitName, A05.AccountID, A05.AccountName,(A37.AdjutsOriginalAmount-A37.OriginalAmount)/(A37.AdjustQuantity-A37.Quantity) as Price
	FROM AT2037 A37 WITH (NOLOCK)
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A37.DivisionID) AND A02.InventoryID = A37.InventoryID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID IN (''@@@'', A37.DivisionID) AND A04.UnitID = A37.UnitID
		LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN (''@@@'', A37.DivisionID) AND A05.AccountID = A37.DebitAccountID
	WHERE A37.DivisionID = '''+@DivisionID+'''
	AND A37.VoucherID = '''+@VoucherID+'''
	AND ISNULL(ReTransactionID, '''') = ''''
	'+@SWhere+'
	AND IsAdjust = 0
	AND A37.InventoryID IN ('''+@ListInventoryID+''')
	'
	EXEC (@sSQL)
	--PRINT (@sSQL)

	
END	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
