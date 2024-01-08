
 IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0174]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0174]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load phiếu  lệnh xuất kho kế  thừa xuất kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Source
-- <History>
----Created by khánh Đoan  on 22/10/2019
---- Update Huỳnh Thử on 24/12/2019 Format lọc dữ liệu
---- Update Huỳnh Thử on 23/09/2020 Sum số lượng đã xuất ở nhiều phiếu kế thừa
---- Update Huỳnh Thử on 17/12/2020 Group thêm WT2002.trasactionID
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
 

CREATE PROCEDURE [dbo].[WP0174]   
				    @DivisionID nvarchar(50),
				    @FromMonth INT,
	  			    @FromYear INT,
				    @ToMonth INT,
				    @ToYear INT,  
				    @FromDate as DATETIME,
				    @ToDate as DATETIME,
				    @IsDate as TINYINT, ----0 theo ky, 1 theo ngày
				    @ObjectID NVARCHAR(50),
				    @WareHouseID NVARCHAR(50)

 AS
DECLARE
			@sSQL as NVARCHAR(max),
			@sSQL1 as NVARCHAR(max),
			@sWhere  as NVARCHAR(4000)


IF @IsDate = 0
	SET  @sWhere = '
		And (WT2001.TranMonth + WT2001.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
ELSE
	SET  @sWhere = '
		And (FORMAT(WT2001.VoucherDate,''yyyy/MM/dd'')  Between '''+ CONVERT(VARCHAR, @FromDate,111)+''' AND '''+ CONVERT(VARCHAR, @ToDate,111)+''')'


IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
		DROP TABLE #TAM

	CREATE TABLE #TAM
	(
		VoucherID NVARCHAR(50) ,
		EndQuantity DECIMAL(28,8)
	)

	SET  @sSQL = '
	INSERT INTO #TAM (VoucherID, EndQuantity)
		SELECT TOP 100 percent VoucherID, SUM(ISNULL(EndQuantity,0)) AS EndQuantity
	FROM(
	SELECT      WT2001.DivisionID, WT2001.VoucherID,                       
	 (ISNULl(WT2002.ActualQuantity,0) - SUM(ISNULL(K.WActualQuantity,0))) as EndQuantity 
	FROM WT2002 WITH (NOLOCK)
	LEFT JOIN WT2001 WITH (NOLOCK) ON WT2001.VoucherID = WT2002.VoucherID 
	LEFT JOIN (
	SELECT AT2006.DivisionID, AT2006.VoucherID, AT2007.TransactionID, AT2007.InventoryID, SUM(AT2007.ActualQuantity) As WActualQuantity 
	,InheritTransactionID, InheritVoucherID
	 FROM AT2007 WITH (NOLOCK)
	LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID
	WHERE AT2006.KindVoucherID =2
	GROUP BY AT2006.DivisionID,AT2006.VoucherID, AT2007.TransactionID, AT2007.InventoryID,InheritTransactionID, InheritVoucherID
	)K  ON WT2001.DivisionID = K.DivisionID and WT2002.DivisionID = K.DivisionID and
			 WT2002.InventoryID = K.InventoryID and
			 WT2002.VoucherID = K.InheritVoucherID and
			 WT2002.TransactionID = K.InheritTransactionID
	WHERE WT2001.KindVoucherID =2 
	AND WT2001.DivisionID = '''+@DivisionID+'''
	GROUP BY WT2001.DivisionID, WT2001.VoucherID, WT2002.TransactionID,                       
	 WT2002.ActualQuantity
	)A
	WHERE EndQuantity > 0
	GROUP BY VoucherID
	'

--- KHI LOAD MASTER 

SET @sSQL1 ='SELECT * FROM ( 
	SELECT  DISTINCT WT2001.APK, WT2001.VoucherTypeID, WT2001.VoucherDate, WT2001.VoucherNo,WT2001.WareHouseID ,
	WT2001.Description, WT2001.ObjectID ,WT0095.VoucherNo as ReVoucherNo, WT2001.VoucherID, AT1202.ObjectName ,  AT1303.WareHouseName AS ExWareHouseName
	FROM WT2001 WITH (NOLOCK)
	LEFT JOIN WT2002 WITH (NOLOCK) ON WT2002.VoucherID = WT2001.VoucherID
	LEFT JOIN WT0095 WITH (NOLOCK) ON WT0095. VoucherID = WT2002.InheritVoucherID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = WT2001.ObjectID
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = WT2001.WareHouseID 
	WHERE WT2001.DivisionID = ''' + @DivisionID + '''
	 AND WT2001.VoucherID In (SELECT T01.VoucherID FROM #TAM T01 Where T01.EndQuantity>0) 
	 AND ISNULL(WT2001.WarehouseID,''%'') LIKE (''' + @WareHouseID + ''') AND 
	ISNULL(WT2001.ObjectID,'''') like ''' + @ObjectID + '''
	 ' + @sWhere + '
	) A'



print @sSQL
print @sSQL1
EXEC (@sSQL+ @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
