IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Báo cáo  chi phí lưu kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 04/11/2019
---- Modified by Huỳnh Thử 30/03/2020 -- In thêm Chi phí thuê Pallet
---- Modified by Huỳnh Thử 30/03/2020 -- Lấy thêm VATNo, ObjectName và Address
---- Modified by Huỳnh Thử 07/04/2020 -- Order by Theo VoucherDate
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on by 
-- <Example>
/*
    EXEC WP2013 @DivisionID ='',@FromVoucherDate='',@ToVoucherDate='',@ObjectID='', @FromContractID='',@ToWareHouseID='',@FromRoomID='',@ToRoomID
*/

 CREATE PROCEDURE WP2013
(
     @DivisionID VARCHAR(50),
	 @FromVoucherDate DATETIME,
	 @ToVoucherDate DATETIME,
	 @ObjectID VARCHAR(50),
	 @FromContractID VARCHAR(50),
	 @ToContractID VARCHAR(50),
	 @FromWareHouseID VARCHAR(50),
	 @ToWareHouseID VARCHAR(50),
	 @FromRoomID VARCHAR(50),
	 @ToRoomID VARCHAR(50),
	 @Mode int
)
AS
SELECT T99.InventoryTypeID
INTO #TAMNE FROM WT2002 T02 WITH (NOLOCK) 
LEFT JOIN WT2001 T01 WITH (NOLOCK)  ON T01.VoucherID = T02.VoucherID 
LEFT JOIN WT2003 T03 WITH (NOLOCK) ON T03.ReVoucherID = T02.VoucherID
LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T06.ObjectID

WHERE T06.ObjectID = @ObjectID
--AND AT1020.ContractID BETWEEN @FromContractID AND @ToContractID
AND T99.InventoryTypeID  BETWEEN @FromRoomID AND @ToRoomID
--AND T03.WareHouseID  BETWEEN @FromWareHouseID AND @ToWareHouseID
GROUP BY T99.InventoryTypeID


	SELECT WT2004.*,AT1202.Address,AT1202.VATNo,AT1202.ObjectName FROM WT2004 
	LEFT JOIN WT0099 on WT0099.VoucherID = WT2004.VoucherID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = WT2004.ObjectID
	WHERE RoomID IN (SELECT InventoryTypeID FROM #TAMNE) 
	AND WT2004.VoucherDate BETWEEN @FromVoucherDate AND @ToVoucherDate
	AND  WT2004.ObjectID =  @ObjectID
	AND ISNULL(IsRent,0) = Case when @Mode = 1 then 1 else 0 end
	ORDER BY WT2004.VoucherDate

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
