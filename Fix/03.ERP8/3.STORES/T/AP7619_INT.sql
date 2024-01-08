IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7619_INT]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7619_INT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created Date 27/10/2006 by Đức Tuyên.

CREATE PROCEDURE [dbo].[AP7619_INT] 
				@DivisionID nvarchar(50), 
				@FromMonth as int, 
				@FromYear  as int,  
				@ToMonth  as int,  
				@ToYear  as int,  
				@CaculatorID nvarchar(50), 
				@FromAccountID  nvarchar(50),  
				@ToAccountID  nvarchar(50),  
				@FromCorAccountID  nvarchar(50),  
				@ToCorAccountID  nvarchar(50), 
				@AnaTypeID  nvarchar(50),  
				@FromAnaID  nvarchar(50), 
				@ToAnaID  nvarchar(50),  
				@FieldID nvarchar(50),  
				@AnaID nvarchar(50), 
				@BudgetID as nvarchar(50),
				@Amount decimal(28,8) OUTPUT,
				@Amount2 decimal(28,8) OUTPUT,				
				@StrDivisionID AS NVARCHAR(4000) = ''

AS

--Print '@AnaID:' + @AnaID
--Print '@BudgetID:' + @BudgetID
--Print '@FromAnaID:' + @FromAnaID
--Print '@ToAnaID:' + @ToAnaID
--Print '@AnaTypeID:' + @AnaTypeID
--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000),
		@CustomerName INT	
		
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Set @Amount = isnull(@Amount,0)
Set @Amount2 = isnull(@Amount2,0)

PRINT (@FromMonth)
PRINT (@FromYear)
PRINT (@ToMonth)
PRINT (@ToYear)


--PRINT (@FromMonth + 100*@FromYear)
--PRINT (@ToMonth + 100*@ToYear)

-- Bổ sung thời gian sx (hrs) (WE+PE)
IF @CaculatorID = 'YF'
BEGIN
	PRINT(N'Thời gian sx (hrs) (WE+PE)')
	SELECT @Amount = SUM(ISNULL(MT11.TotalActualTime, 0)), @Amount2 = SUM(ISNULL(MT11.TotalActualTime, 0)) 
	From MT2210 MT10 WITH(NOLOCK)
		LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT11.APKMaster = MT10.APK
	WHERE MT10.DivisionID IN (N'@@@', @DivisionID)
		AND CONCAT(FORMAT(MT10.TranMonth, '00'),'/', MT10.TranYear) = @AnaID
END
-- Bổ sung hàng hỏng (pcs)
IF @CaculatorID = 'YG'
BEGIN
	PRINT(N'Bổ sung hàng hỏng (pcs)')
	SELECT @Amount = SUM(ISNULL(AT07.ActualQuantity, 0)), @Amount2 = SUM(ISNULL(AT07.ActualQuantity, 0))
	FROM AT2006 AT06 WITH (NOLOCK)
		INNER JOIN AT2007 AT07 WITH (NOLOCK) ON AT07.DivisionID = AT06.DivisionID
												AND AT07.VoucherID = AT06.VoucherID
	WHERE AT06.KindVoucherID IN (1)
			AND ISNULL(AT06.WareHouseID, '') IN (N'KNG-EG', N'KNG-PE', N'KNG-WE')
		AND CONCAT(FORMAT(AT06.TranMonth, '00'),'/', AT06.TranYear) = @AnaID
END
-- Bổ sung hàng hỏng (vnd)
IF @CaculatorID = 'YH'
BEGIN
	PRINT(N'Bổ sung hàng hỏng (vnd)')
	SELECT @Amount = SUM(ISNULL(AT07.OriginalAmount, 0)), @Amount2 = SUM(ISNULL(AT07.OriginalAmount, 0))
	FROM AT2006 AT06 WITH (NOLOCK)
		INNER JOIN AT2007 AT07 WITH (NOLOCK) ON AT07.DivisionID = AT06.DivisionID
												AND AT07.VoucherID = AT06.VoucherID
	WHERE AT06.KindVoucherID IN (1)
			AND ISNULL(AT06.WareHouseID, '') IN (N'KNG-EG', N'KNG-PE', N'KNG-WE')
		AND CONCAT(FORMAT(AT06.TranMonth, '00'),'/', AT06.TranYear) = @AnaID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

