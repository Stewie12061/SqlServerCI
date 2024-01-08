IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0047_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0047_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai
---- Date 01/09/2017
---- Purpose : Tính đơn giá dở dang cuối kỳ cho NVL (CustomizeIndex = 57 - ANGEL)
---- Modified by Tiểu Mai on 07/11/2017: Bổ sung công thức trừ NVL nhập trả lại
---- Modified on 06/03/2018 by Bảo Anh: Sửa lỗi chia cho 0
/*
  exec MP0047_AG 'ANG', 'THEP082017', '''NLCPP1100N'',''BBCN02''', 8, 2017, 8, 2017
 */

CREATE PROCEDURE [dbo].[MP0047_AG] 
(
	@DivisionID NVARCHAR(50),
	@PeriodID  NVARCHAR(50),
	@ListMaterialID NVARCHAR(4000), 
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT
)
AS
DECLARE @FromPeriod INT,
	@ToPeriod INT,
	@sSQL NVARCHAR(MAX),
	@UnitCostDecimals TINYINT

SELECT @UnitCostDecimals = UnitPriceDecimal FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
	
SET @FromPeriod=@FromMonth+@FromYear*100
SET @ToPeriod=@ToMonth+@ToYear*100

---- Tính đơn giá NVL dở dang cuối kỳ
SET @sSQL = '
SELECT MaterialID, CASE WHEN SUM(Quantity) = 0 THEN 0 ELSE ROUND(SUM(ConvertedAmount)/SUM(Quantity),' + LTRIM(@UnitCostDecimals) + ') END AS UnitPrice_CK 
	FROM (	
		---- Lấy dở dang đầu kỳ
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'''') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = '''+@DivisionID+''' AND MT1612.ExpenseID = ''COST001'' AND MaterialTypeID = ''M02'' 
			AND TranMonth + TranYear * 100 BETWEEN '+CONVERT(nvarchar(10),@FromPeriod)+ ' AND  ' + CONVERT(NVARCHAR(10), @ToPeriod) + '
			AND MaterialID IN ('+@ListMaterialID+')
			AND ISNULL(PeriodID,'''') = '''+@PeriodID+'''
			AND [Type] = ''B''
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''''), ProductID

		UNION 
		---- Lấy chi phí NVL phát sinh trong kỳ
		SELECT MV9000.DivisionID, MV9000.InventoryID AS MaterialID, ISNULL(MV9000.PeriodID,'''') AS PeriodID, MV9000.ProductID,  
			SUM(CASE WHEN D_C = ''D'' THEN MV9000.ConvertedAmount ELSE -MV9000.ConvertedAmount END) AS ConvertedAmount,
			SUM(CASE WHEN D_C = ''D'' THEN MV9000.Quantity ELSE -MV9000.Quantity END) AS Quantity
		FROM  MV9000 	
		Where MV9000.TranMonth + MV9000.TranYear*100 BETWEEN '+CONVERT(nvarchar(10),@FromPeriod)+ ' AND  ' + CONVERT(NVARCHAR(10), @ToPeriod) + '			
			AND MV9000.DivisionID = '''+@DivisionID+''' AND InventoryID IN ('+@ListMaterialID+') AND ISNULL(MV9000.PeriodID,'''') LIKE '''+@PeriodID+'''
			AND (MV9000.ExpenseID=''COST001'' or (Isnull(MV9000.ExpenseID,'''') = '''' and
									(DebitAccountID in (Select AccountID 
												  From MT0700 WITH (NOLOCK)
												  Where MT0700.ExpenseID=''COST001''	) or CreditAccountID in (Select AccountID 
												  From MT0700 WITH (NOLOCK)
												  Where MT0700.ExpenseID=''COST001''	))))
		GROUP BY MV9000.DivisionID, MV9000.InventoryID, MV9000.UnitID, MV9000.ProductID, ISNULL(MV9000.PeriodID,'''')
	) P
GROUP BY MaterialID
ORDER BY MaterialID
'
PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
