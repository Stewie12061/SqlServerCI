IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Nguyên tắc xuất hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 21/09/2019
---- Modified by 
---- 
---- Modified on 23/09/2020 by Huỳnh Thử: Lấy những pallet còn số lượng và chưa kế thừa hết
---- Modified on 23/09/2020 by Huỳnh Thử: Manual lấy theo số lượng tồn nhỏ nhất
-- <Example>
/*
    EXEC WP2010 @DivisionID='',@InventoryID='',@VoucherID='', @Mode=''
*/


CREATE PROCEDURE [dbo].[WP2006]
	@DivisionID NVARCHAR(50),
	@InventoryID NVARCHAR(50),
	@VoucherID NVARCHAR(50),
	@LimitDate DATE,
	@Mode INT -- 1 FIF0 --2 Auto

AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL_Where NVARCHAR(MAX),
		@sSQL_OrderBy NVARCHAR(MAX)

IF ISNULL(@LimitDate,'') <> ''
	SET @sSQL_Where = '
		AND T02.LimitDate =   '''+CONVERT(NVARCHAR(50),@LimitDate,111)+'''
	'
SET @sSQL = '
					SELECT * INTO #TAM FROM (	SELECT T02.InventoryID,AT1302.InventoryName,AT1302.UnitID,T02.ReVoucherID,t02.ReTransactionID,T02.VoucherID AS RePVoucherID, T02.TransactionID AS RePTransactionID,t02.UnitPrice, T02.SourceNo, T02.LimitDate,
					T01.VoucherNo , T01.LocationID ,(ISNULL(T02.ActualQuantity,0)) AS ActualQuantity, T06.VoucherNo AS ReVoucherNo, T02.ReVoucherDate
                                            FROM  WT2002 T02 WITH (NOLOCK)
                                            LEFT JOIN WT2001 T01 WITH (NOLOCK) ON T01.VoucherID = T02.VoucherID 
                                            LEFT JOIN AT2006 T06 ON	T06.VoucherID = T02.ReVoucherID
											LEFT JOIN  AT1302 WITH (NOLOCK) ON AT1302.InventoryID = T02.InventoryID
                                            WHERE T01.KindVoucherID = 1
                                            AND T02.ReVoucherID = '''+@VoucherID+'''
                                            AND T02.InventoryID = '''+@InventoryID+'''
											--ORDER BY T02.ReVoucherDate, T02.ActualQuantity
                                            UNION  ALL
											SELECT T02.InventoryID,AT1302.InventoryName,AT1302.UnitID,T02.ReVoucherID,t02.ReTransactionID,T02.RePVoucherID, T02.RePTransactionID,t02.UnitPrice, T02.SourceNo, T02.LimitDate,
											(SELECT VoucherNo FROM WT2001 WHERE  T02.RePVoucherID = dbo.WT2001.VoucherID) AS VoucherNo , (SELECT LocationID FROM WT2001 WHERE  T02.RePVoucherID = dbo.WT2001.VoucherID) AS LocationID ,- (ISNULL(T02.ActualQuantity,0)) AS ActualQuantity, T06.VoucherNo AS ReVoucherNo, T06.VoucherDate AS ReVoucherDate
                                            FROM  WT2002 T02 WITH (NOLOCK)
                                            LEFT JOIN WT2001 T01 WITH (NOLOCK) ON T01.VoucherID = T02.VoucherID 
                                            LEFT JOIN AT2006 T06 ON	T06.VoucherID = T02.ReVoucherID
											LEFT JOIN  AT1302 WITH (NOLOCK) ON AT1302.InventoryID = T02.InventoryID
                                            WHERE T01.KindVoucherID = 2
                                            AND T02.ReVoucherID = '''+@VoucherID+'''
                                            AND T02.InventoryID = '''+@InventoryID+'''
											--ORDER BY T02.LimitDate, T02.ReVoucherDate, T02.ActualQuantity
											) A
											SELECT * FROM (
												  SELECT #TAM.InventoryID, #TAM.InventoryName, #TAM.UnitID, #TAM.UnitPrice, #TAM.ReVoucherID, #TAM.ReTransactionID, #TAM.RePVoucherID, #TAM.RePTransactionID, 
												   #TAM.SourceNo, #TAM.LimitDate, #TAM.VoucherNo,  #TAM.LocationID, SUM(ActualQuantity) AS ActualQuantity, #TAM.ReVoucherNo, #TAM.ReVoucherDate
												
												   FROM #TAM 
												   GROUP BY #TAM.InventoryID, #TAM.InventoryName, #TAM.UnitID, #TAM.UnitPrice, #TAM.ReVoucherID, #TAM.ReTransactionID, #TAM.RePVoucherID, #TAM.RePTransactionID, 
												   #TAM.SourceNo, #TAM.LimitDate, #TAM.VoucherNo,  #TAM.LocationID, #TAM.ReVoucherNo, #TAM.ReVoucherDate
												   HAVING SUM(ActualQuantity) > 0
													    ) AA 
												 
			'
IF @Mode = 1
BEGIN
SET @sSQL_OrderBy ='
	ORDER BY AA.ReVoucherDate, AA.ActualQuantity
	'
END
ELSE IF @Mode = 2
BEGIN 
SET @sSQL_OrderBy ='
	ORDER BY AA.LimitDate, AA.ReVoucherDate, AA.ActualQuantity
	'
END
ELSE
BEGIN
	SET @sSQL_OrderBy ='
		ORDER BY AA.ActualQuantity
		'
END


PRINT @sSQL + @sSQL_OrderBy
EXEC (@sSQL + @sSQL_OrderBy)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
