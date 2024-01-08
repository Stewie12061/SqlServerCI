IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO














-- <Summary>
--- Load phần Master của popupMasterdetail màn hình Yêu cầu nhập/xuất kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Lộc on: 31/10/2022
-- <Example>

CREATE PROCEDURE WMP2005
(
	@DivisionID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode TINYINT-- 1: YC Nhập, 2: YC Xuất, 3: YC VCNB
)
AS

DECLARE @Ssql Nvarchar(max), 
		@Ssql2 Nvarchar(max),
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = '',
		@sSelect AS NVARCHAR(MAX),
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF ISNULL(@Type, '') = 'YCNK' OR ISNULL(@Type, '') = 'YCXK' OR ISNULL(@Type, '') = 'YCVCNB'
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),WT95.APKMaster_9000)= '''+@APKMaster+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE
BEGIN
	SET @Swhere = @Swhere + 'AND WT95.VoucherID = '''+@VoucherID+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN WT0095 WT95 ON OOT9001.APKMaster = WT95.APKMaster_9000  WHERE WT95.VoucherID = @VoucherID
END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

-- YCNK
IF @Mode = 1
BEGIN
	SET @sSelect = 'WT95.WarehouseID AS ImWareHouseID, T2.WarehouseName AS ImWareHouseName'
END

-- YCXK
IF @Mode = 2
BEGIN
	SET @sSelect = 'WT95.WarehouseID AS ExWareHouseID, T2.WarehouseName AS ExWareHouseName,WT95.PONumber'
END

-- YC VCNB
IF @Mode = 3
BEGIN
	SET @sSelect = 'WT95.WarehouseID AS ImWareHouseID, T2.WarehouseName AS ImWareHouseName,
					WT95.WarehouseID2 AS ExWareHouseID, T6.WarehouseName AS ExWareHouseName'
END

IF @CustomerIndex = 166
BEGIN
	SET @sSelect = @sSelect + ', WT95.RDAddressID'
END

SET @Ssql = '
SELECT WT95.APK, WT95.APKMaster_9000, WT95.ApproveLevel, WT95.ApprovingLevel, ISNULL(WT95.IsCheck, ''0'') AS StatusApproveName, WT95.DivisionID, WT95.TranMonth, WT95.TranYear, WT95.VoucherTypeID, WT95.VoucherID, WT95.VoucherNo, WT95.VoucherDate, WT95.RefNo01, WT95.RefNo02, 
    WT95.ObjectID, WT95.WareHouseID, WT95.InventoryTypeID, WT95.EmployeeID, WT95.ContactPerson, WT95.RDAddress, WT95.Description, WT95.TableID, WT95.ProjectID, WT95.OrderID, 
    WT95.BatchID, WT95.ReDeTypeID, WT95.KindVoucherID, WT95.WareHouseID2, WT95.Status, WT95.VATObjectName, WT95.IsGoodsFirstVoucher, WT95.MOrderID, WT95.ApportionID, 
    WT95.IsInheritWarranty, WT95.EVoucherID, WT95.IsGoodsRecycled, WT95.RefVoucherID, WT95.IsCheck, WT95.IsVoucher, WT95.CreateUserID, WT95.CreateDate, WT95.LastModifyUserID, 
    WT95.LastModifyDate, WT95.StandardPrice, WT95.StatusID, WT95.IsConfirm01, WT95.ConfDescription01, WT95.IsConfirm02, WT95.ConfDescription02, WT95.ContractNo, WT95.ContractID,
    WT95.SParameter01, WT95.SParameter02, WT95.SParameter03, WT95.SParameter04, WT95.SParameter05, WT95.SParameter06, WT95.SParameter07, WT95.SParameter08, WT95.SParameter09, 
    WT95.SParameter10, WT95.SParameter11, WT95.SParameter12, WT95.SParameter13, WT95.SParameter14, WT95.SParameter15, WT95.SParameter16, WT95.SParameter17, WT95.SParameter18, T9.VoucherTypeName,
    WT95.SParameter19, WT95.SParameter20, WT95.DeliveryDate, WT95.TypeRule, T5.FullName AS EmployeeName, T4.ObjectName, T3.InventoryTypeName,
	'+@sSelect+'
	'+@sSQLSL+''

set @Ssql2 = ' FROM WT0095 WT95 WITH (NOLOCK)
LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON WT95.APKMaster_9000 = OOT90.APK
LEFT JOIN AT1303 T2 WITH (NOLOCK) ON WT95.WarehouseID = T2.WareHouseID AND T2.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1301 T3 WITH (NOLOCK) ON WT95.InventoryTypeID = T3.InventoryTypeID AND T3.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1202 T4 WITH (NOLOCK) ON WT95.ObjectID = T4.ObjectID AND T4.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON WT95.EmployeeID = T5.EmployeeID AND T5.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1303 T6 WITH (NOLOCK) ON WT95.WarehouseID2 = T6.WareHouseID AND T6.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1103 T7 WITH (NOLOCK) ON WT95.EmployeeID = T7.EmployeeID AND T7.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1103 T8 WITH (NOLOCK) ON WT95.EmployeeID = T8.EmployeeID AND T8.DivisionID IN (WT95.DivisionID,''@@@'')
LEFT JOIN AT1007 T9 WITH (NOLOCK) ON T9.DivisionID = WT95.DivisionID AND T9.VoucherTypeID = WT95.VoucherTypeID
	'+@sSQLJon+'
WHERE WT95.DivisionID = '''+@DivisionID+''' '+@Swhere+''

EXEC (@Ssql + @Ssql2)
PRINT (@Ssql + @Ssql2) 
--print (@Ssql)














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
