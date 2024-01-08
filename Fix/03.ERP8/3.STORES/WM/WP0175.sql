IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0175]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0175]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----Kế thừa Lệnh xuất kho Detail

--- Created by: Khánh Đoan
--- Modifle by Huỳnh Thử on 27/08/2020
--- Modifle by Huỳnh Thử on 27/08/2020 -- kế thừa nhiều lệch xuất kho
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 12/10/2020 : Bổ sung cột VoucherNo lệnh xuất kho
---- Modified by Huỳnh Thử on 17/12/2020 :: Bổ sung Ana04ID
---- Modified by Huỳnh Thử on 15/01/2021 :: Sum Lệch xuất kho (InheritVoucherID, InheritTransactionID) vì Xk kế thừa nhiều lệch xuất kho

CREATE PROCEDURE [dbo].[WP0175]
    @DivisionID NVARCHAR(50),
    @VoucherID NVARCHAR(MAX) -- ID của Lệnh xuất kho
AS
DECLARE @sSQL VARCHAR(MAX),
		@sSQL1 VARCHAR(MAX)


--- Load Lệnh xuất kho kế thừa
SET @sSQL1 = N'
SELECT SUM(ActualQuantity) AS ActualQuantity, InheritTransactionID, InheritVoucherID INTO #TAM FROM AT2007 T07 
WHERE T07.InheritVoucherID IN ('''+@VoucherID+''')
GROUP BY InheritVoucherID, InheritTransactionID
'

PRINT @VoucherID
--------------Load detail lệnh xuất kho
SET @sSQL
    = ' 
		SELECT
		T00.VoucherID,
		T00.InventoryID,
		T01.InventoryName,
		T00.UnitID as ConvertedUnitID,
		ISNULL(T00.ActualQuantity,0) - ISNULL(TAM.ActualQuantity,0) AS ActualQuantity ,	
		T00.UnitPrice,
		T00.OriginalAmount , 	
		T00.SourceNo, 
		T04.LimitDate,
		T00.LocationID AS PLocationID, -- Vị trí ô
		T00.Notes, 
		T00.RePVoucherID ,-- Số Pallet
		T00.RePTransactionID ,
		T03.VoucherNo   AS ReVoucherNo, -- Chứng từ nhập
		''WT2001'' AS InheritTableID,
		T00.VoucherID AS InheritVoucherID,
		T00.TransactionID AS InheritTransactionID,
		T04.VoucherID as ReVoucherID,
		T04.TransactionID  as ReTransactionID,
		T02.Description,
		T02.VoucherNo AS InheritVoucherNo,
		T04.Ana04ID
		FROM WT2002 T00 WITH (NOLOCK) 
		INNER JOIN WT2001 T02 WITH (NOLOCK) ON T02.VoucherID  = T00.VoucherID  
		INNER JOIN AT1302 T01 WITH (NOLOCK) ON T01.DivisionID IN (''@@@'', T00.DivisionID) AND T00.InventoryID = T01.InventoryID
		INNER JOIN AT2006 T03 WITH (NOLOCK) ON T03.VoucherID  = T00.ReVoucherID
		INNER JOIN AT2007 T04 WITH (NOLOCK) ON T04.VoucherID  = T00.ReVoucherID  AND T04.TransactionID = T00.ReTransactionID 
		LEFT JOIN #TAM TAM WITH (NOLOCK) ON TAM.InheritVoucherID = T00.VoucherID AND TAM.InheritTransactionID =  T00.TransactionID  
		WHERE	T02.DivisionID = ''' + @DivisionID
      + '''
				AND T03.KindVoucherID = 1
				AND T02.KindVoucherID = 2 AND
				T00.VoucherID IN (''' + @VoucherID + ''') 
		AND ISNULL(T00.ActualQuantity,0) - ISNULL(TAM.ActualQuantity,0)  > 0
				GROUP BY T00.VoucherID,
		T00.InventoryID,
		T01.InventoryName,
		T00.UnitID,
		T00.ActualQuantity,	
		TAM.ActualQuantity,
		T00.UnitPrice,
		T00.OriginalAmount , 	
		T00.SourceNo, 
		T04.LimitDate,
		T00.LocationID , 
		T00.Notes, 
		T00.RePVoucherID ,
		T00.RePTransactionID ,
		T03.VoucherNo,
		T00.VoucherID,
		T00.TransactionID,
		T04.VoucherID,
		T04.TransactionID,
		T02.Description,
		T02.VoucherNo,
		T04.Ana04ID
		';

PRINT @sSQL;
EXEC (@sSQL1 + @sSQL);

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


