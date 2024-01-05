IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].QCP3007
GO
/****** Object:  StoredProcedure [dbo].[QCP3007]    Script Date: 11/13/2020 3:01:26 PM ******/
-- <Summary>
---- Lấy dữ liệu báo cáo biểu đồ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 13/11/2020 by TAN TAI
----Modified by Le Hoang on 24/02/2021 : Lỗi in không có dữ liệu trong cùng ngày
----Modified by Trong Phuc on 27/07/2023 : Lỗi truy vấn tiêu chuẩn, bổ sung điều kiện theo mã tiêu chuẩn
----Modified by Anh Đô on 17/08/2023: Fix lỗi in khi chọn nhiều tiêu chuẩn
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3007]
		@DivisionID = N'VNP',
		@UserID = N'ASOFTADMIN',
		@FromDate = N'2019-11-12 00:00:00.000',
		@ToDate = N'2020-12-12 00:00:00.000',
		@InventoryID = N'25G1NKK160002',
		@StandardID = N''
----*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3007]
( 
	 @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),	 
	 @FromDate NVARCHAR(50), 	 
	 @ToDate NVARCHAR(50),
	 @InventoryID VARCHAR(MAX),
	 @StandardID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.DivisionID IN ('''+@DivisionID+''') '
		IF ISNULL(@FromDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.VoucherDate >= '''+@FromDate+''''
		IF ISNULL(@ToDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.VoucherDate <= '''+REPLACE(@ToDate, '00:00:00', '23:59:59')+''''	
		IF ISNULL(@InventoryID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2001.InventoryID IN ('''+@InventoryID+''')'
		IF ISNULL(@StandardID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2002.StandardID IN ('''+@StandardID+''')'

		--DROP TABLE #Total_Standard
		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		--select * from  #Total_Standard

		SET @SQLQuery = N'select QCT1020.InventoryID, QCT1021.StandardID, QCT1000.StandardName, QCT1000.UnitID, SRange01, SRange02, SRange03, SRange04, SRange05 
		from QCT1020 QCT1020
		join QCT1021 QCT1021 on QCT1021.APKMaster = QCT1020.APK
		join QCT1000 QCT1000 on QCT1000.StandardID = QCT1021.StandardID
		where QCT1020.InventoryID LIKE CONCAT(''%'', '''+ @InventoryID +''',''%'')'
		+ CASE WHEN ISNULL(@StandardID, '') != '' THEN 'AND QCT1000.StandardID IN ('''+ @StandardID +''')' ELSE '' END

SET @SQLQuery = @SQLQuery + N'
		
		--*******************************
		-- Phiếu QL Chất lượng :2000 2001 Detail 2002 (APK Master 2001)
		--*******************************

		select QCT2000.APK as QCT2000APK, QCT2000.ShiftID,QCT2000.Status,QCT2000.VoucherNo as QCT2000VoucherNo, QCT2000.VoucherDate as QCT2000VoucherDate ,
		QCT2001.InventoryID,QCT2001.BatchNo, QCT2001.GrossWeight, QCT2001.NetWeight,QCT2001.OtherQuantity , QCT2001.OtherUnitID,
		QCT2001.DParameter01, QCT2001.DParameter02,QCT2001.DParameter03,QCT2001.DParameter04,QCT2001.DParameter05,
		QCT2002.StandardID,QCT1000.StandardName , QCT2002.StandardValue

		-- Phiếu nhập đầu ca
		from QCT2000 QCT2000
		join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
		join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2001.APK
		join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
		where  QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0  
		'+ @sWhere+ '
		 UNION

		--*******************************
		-- Phiếu thông số vận hành :2010 2011 Detail 2002 (APK Master 2011)
		--*******************************
		select QCT2000.APK as QCT2000APK, QCT2000.ShiftID,QCT2000.Status,QCT2000.VoucherNo as QCT2000VoucherNo, QCT2000.VoucherDate as QCT2000VoucherDate ,
		QCT2001.InventoryID,QCT2001.BatchNo, QCT2001.GrossWeight, QCT2001.NetWeight,QCT2001.OtherQuantity , QCT2001.OtherUnitID,
		QCT2001.DParameter01, QCT2001.DParameter02,QCT2001.DParameter03,QCT2001.DParameter04,QCT2001.DParameter05,
		--QCT2010.APK as QCT2010APK,QCT2010.VoucherType as QCT2010VoucherType,QCT2010.VoucherTypeID as QCT2010VoucherTypeID,QCT2010.VoucherNo as  QCT2010VoucherNo, QCT2010.VoucherDate as  QCT2010VoucherDate,
		--QCT2011.APK as  QCT2011APK, QCT2011.MaterialID as  MaterialID,
		QCT2002.StandardID,QCT1000.StandardName , QCT2002.StandardValue
		-- Phiếu nhập đầu ca
		from QCT2000 QCT2000
		join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
		-- Phiếu nhập (VNL,Thông số vận hành )
		join QCT2011  QCT2011 on QCT2011.RefAPKDetail  = QCT2001.APK
		join QCT2010  QCT2010 on QCT2010.APK  = QCT2011.APKMaster
		join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2011.APK
		join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
		where QCT2010.VoucherType=''1''   and QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0 
		and QCT2010.DeleteFlg = 0 and  QCT2011.DeleteFlg = 0 '+ @sWhere+ '

		 UNION
		--*******************************
		-- Phiếu thông số NVL :2010 2011 Detail 2002 (APK Master 2011)
		--*******************************
		select QCT2000.APK as QCT2000APK, QCT2000.ShiftID,QCT2000.Status,QCT2000.VoucherNo as QCT2000VoucherNo, QCT2000.VoucherDate as QCT2000VoucherDate ,
		QCT2001.InventoryID,QCT2001.BatchNo, QCT2001.GrossWeight, QCT2001.NetWeight,QCT2001.OtherQuantity , QCT2001.OtherUnitID,
		QCT2001.DParameter01, QCT2001.DParameter02,QCT2001.DParameter03,QCT2001.DParameter04,QCT2001.DParameter05,
		--QCT2010.APK as QCT2010APK,QCT2010.VoucherType as QCT2010VoucherType,QCT2010.VoucherTypeID as QCT2010VoucherTypeID,QCT2010.VoucherNo as  QCT2010VoucherNo, QCT2010.VoucherDate as  QCT2010VoucherDate,
		--QCT2011.APK as  QCT2011APK, QCT2011.MaterialID as  MaterialID,
		QCT2002.StandardID,QCT1000.StandardName , QCT2002.StandardValue
		-- Phiếu nhập đầu ca
		from QCT2000 QCT2000
		join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
		-- Phiếu nhập (VNL,Thông số vận hành )
		join QCT2011  QCT2011 on QCT2011.RefAPKDetail  = QCT2001.APK
		join QCT2010  QCT2010 on QCT2010.APK  = QCT2011.APKMaster
		join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2011.APK
		join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
		where QCT2010.VoucherType=''2'' and QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0 
		and QCT2010.DeleteFlg = 0 and  QCT2011.DeleteFlg = 0 
'+ @sWhere
		print (@SQLQuery)
		EXEC sp_executesql @SQLQuery





