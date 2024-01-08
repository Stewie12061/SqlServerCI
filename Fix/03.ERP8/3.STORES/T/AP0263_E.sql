IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0263_E]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0263_E]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load  detail màn hình kế thừa phiếu nhập kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Khánh Đoan on 22/10/2019
---- Modified by Huỳnh Thử on 26/08/2020: Bổ sung cột lô nhập và hạn sử dụng
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Huỳnh Thử on 28/12/2020: Where lệch xuất kho KinvoucherID = 2
---- Modified by Huỳnh Thử on 29/12/2020: Where lệch xuất kho KinvoucherID = 1 (Kế thừa trừ số lượng)
-- <Example>
/*
    EXEC AP0263_E @DivisionID ='EM', @VoucherID ='',@PalletID=''

*/



CREATE PROCEDURE [dbo].[AP0263_E] @DivisionID nvarchar(50),				
				@VoucherID nvarchar(50),
				@PalletID nvarchar(50)
				
AS
BEGIN

	
	Declare @sSQL  nvarchar(4000),
		@sSQL1  nvarchar(4000),
		@sSQL2  NVARCHAR(MAX)

	SET @sSQL1 = ''
	SET @sSQL2 = ''



	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
		DROP TABLE #TAM

	CREATE TABLE #TAM
	(
		DivisionID nvarchar(50),
		VoucherID nvarchar(50),
		TransactionID nvarchar(50),
		ActualQuantity decimal(28,8),
		EndQuantity decimal(28,8),
		EndConvertedQuantity decimal(28,8)
	)

	Set  @sSQL = '
	INSERT INTO #TAM (DivisionID, VoucherID, TransactionID, ActualQuantity, EndQuantity)
		SELECT 
		AT2006.DivisionID, AT2007.VoucherID, AT2007.TransactionID, AT2007.ActualQuantity,
		(ISNULL(ActualQuantity, 0) - isnull(K.ActualQuantityP,0)) as EndQuantity
	FROM AT2006
	inner join AT2007 on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID
	LEFT JOIN (
		SELECT  WT2001.DivisionID, WT2002.ReVoucherID, WT2002.ReTransactionID, WT2002.InventoryID, 
		SUM(WT2002.ActualQuantity) As ActualQuantityP
		FROM  WT2002
		LEFT JOIN WT2001 WITH (NOLOCK) ON WT2001.VoucherID =WT2002.VoucherID 
		WHERE KindVoucherID = 1
		GROUP BY WT2001.DivisionID,WT2002.ReVoucherID, WT2002.ReTransactionID, WT2002.InventoryID
		) AS K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
				AT2007.VoucherID = K.ReVoucherID and AT2007.InventoryID = K.InventoryID and
				AT2007.TransactionID = K.ReTransactionID
	WHERE AT2006.DivisionID = ''' + @DivisionID + ''' 
	AND AT2006.VoucherID = ''' + @VoucherID + '''
	'

	Set @sSQL1 ='
			SELECT T06.ObjectID,
			T06.WareHouseID,
			T00.ReVoucherID ,
			T06.VoucherNo, 
			T00.ReTransactionID,
			T00.InventoryID,
			T01.InventoryName,
			Isnull(T00.UnitID,T01.UnitID) as UnitID,
			T00.ActualQuantity as Quantity, 
			T00.UnitPrice,
			T00.OriginalAmount, 
			T00.SourceNo, 
			T00.LimitDate,
			T00.ReVoucherDate as VoucherDate,
			T01.IsSource, 
			T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
			T01.AccountID,
			 T01.MethodID, 
			T01.IsStocked,
			T00.Notes as BDescription,
			T00.SourceNo,
			T00.LimitDate
			From WT2002 T00 WITH (NOLOCK)
			LEFT JOIN WT2001 WT01 WITH (NOLOCK) ON WT01.VoucherID = T00.VoucherID
			Inner join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
			INNER JOIN AT2006 T06 WITH (NOLOCK) on  T06.VoucherID = T00.ReVoucherID
			Where  T00.DivisionID = ''' + @DivisionID + ''' AND 
			T00.VoucherID =  ''' + @PalletID + '''   AND
			ISNULL(ReTransactionID,'''')  <> ''''
			UNION '
		
			
		SET @sSQL2 = 'SELECT
		T02.ObjectID,
		T02.WareHouseID,
		T00.VoucherID AS ReVoucherID,
		T02.VoucherNo,
		T00.TransactionID as ReTransactionID,
		T00.InventoryID,		
		T01.InventoryName, 
		Isnull(T00.UnitID,T01.UnitID) as UnitID,
		V00.EndQuantity as Quantity,	
		T00.UnitPrice ,
		CASE WHEN IsNull(V00.EndQuantity,0) = IsNull(V00.ActualQuantity,0) then IsNull(T00.OriginalAmount,0) else
		IsNull(V00.EndQuantity,0) * IsNull(T00.UnitPrice,0) End As OriginalAmount , 	 
		T00.SourceNo,
		 T00.LimitDate,
		 T02.VoucherDate,
		T01.IsSource, 
		T01.IsLocation, 
		T01.PurchaseAccountID,
		 T01.IsLimitDate, 
		T01.AccountID,
		 T01.MethodID, 
		 T01.IsStocked,
		T02.Description as BDescription,
		T00.SourceNo,
		T00.LimitDate
		From AT2007 T00 WITH (NOLOCK) 
		INNER JOIN AT2006 T02 WITH (NOLOCK) on T00.VoucherID = T02.VoucherID
		 INNER JOIN #TAM V00 on  V00.VoucherID = T00.VoucherID and V00.TransactionID = T00.TransactionID 
		 INNER JOIN AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		 
		Where  T02.DivisionID = ''' + @DivisionID + ''' AND V00.EndQuantity > 0
		 AND T00.VoucherID = ''' + @VoucherID + ''''

	--print @sSQL
	--print @sSQL1
	--print @sSQL2
	exec (@sSQL +@sSQL1+@sSQL2)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


