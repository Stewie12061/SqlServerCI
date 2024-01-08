IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OP0156]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0156]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Tiểu Mai on 20/01/2016
--- Purpose: Load Số lượng hàng bán ra bình quân theo số tháng (CustomizeIndex = 57 - Angel).
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)

--- EXEC OP0156 'AS', '02/25/2016', 2, 'MT.TEST', 'HO'



CREATE PROCEDURE [dbo].[OP0156]
	@DivisionID NVARCHAR(50),
	@VoucherDate DATETIME,
	@NumberMonth AS INT, -- 2, 6
	@InventoryID AS NVARCHAR(50),
	@UnitID AS NVARCHAR(50)
AS 	
DECLARE @Month AS INT,
		@Year AS INT,
		@sSQL AS NVARCHAR(MAX)
		
SET @Month = MONTH(@VoucherDate)
SET @Year = YEAR(@VoucherDate)

IF @Month > @NumberMonth
BEGIN
	SET @sSQL = '
	SELECT Isnull(SUM(Quantity),0)/'+Cast(@NumberMonth AS NVARCHAR(5))+' FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
		AND InventoryID = '''+@InventoryID+'''
		AND UnitID = '''+@UnitID+'''
		AND TransactionTypeID IN (''T04'')
		AND (TranMonth+TranYear*100) BETWEEN ('+Cast(@Year AS NVARCHAR(5))+'*100 + ('+Cast(@Month AS NVARCHAR(2))+' - '+Cast(@NumberMonth AS NVARCHAR(5))+')) AND ('+Cast(@Year AS NVARCHAR(5))+'*100 + '+Cast(@Month AS NVARCHAR(2))+' - 1)'
END
IF @Month <= @NumberMonth
BEGIN
	SET @sSQL = '
	SELECT Isnull(SUM(Quantity),0)/'+Cast(@NumberMonth AS NVARCHAR(5))+' FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
		AND InventoryID = '''+@InventoryID+'''
		AND UnitID = '''+@UnitID+'''		
		AND TransactionTypeID IN (''T04'')
		AND (TranMonth+TranYear*100) BETWEEN (('+Cast(@Year AS NVARCHAR(5))+' - 1)*100 + 12 - ('+Cast(@NumberMonth AS NVARCHAR(5))+' - '+Cast(@Month AS NVARCHAR(2))+')) AND ('+Cast(@Year AS NVARCHAR(5))+'*100 + '+Cast(@Month AS NVARCHAR(2))+' - 1)'
END

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO 