IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load cac phieu yêu cầu Nhap, xuat len man hinh truy van WF0122 (ERP9 - EIMSKIP)
---- Created by Bảo Thy on 30/12/2016
---- Modified by on
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
-- <Example> 
/*
	EXEC WMP2004 @DivisionID=N'EM', @UserID=N'CVN0007',@TranMonth=6, @TranYear=2016,@Mode=1,@VoucherNo=NULL,
	@ContractNo=NULL, @Status = '%', @FromDate='2017-06-01 00:00:00',@ToDate='2017-08-30 00:00:00', @WareHouseID = 'VNSGN-CH-RK-TMS',@IsCheckAll=0
	@VoucherIDList = '6a406f2e-a145-4a0d-9b7e-939ed48923b0'',''ce5ee564-1a6a-47fb-8d1b-e5dc86b01cab'',''bf7e1cd7-be1d-4f00-b3ae-7b8b8f68eff3'
*/

CREATE PROCEDURE [dbo].[WMP2004] 
(
    @DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@Mode TINYINT,-- 1: YC Nhập, 2: YC Xuất
	@VoucherNo VARCHAR(50),
	@ContractNo VARCHAR(50),
	@WareHouseID VARCHAR(50),
	@Status VARCHAR(10),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsCheckAll TINYINT,
	@VoucherIDList XML
)
AS
DECLARE @sSelect NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = '',
		@sSQL NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = '',
		@TotalRow NVARCHAR(50) = '',
		@OrderBy NVARCHAR(2000) = '',
		@CustomerName INT,
		@sJoin VARCHAR(2000) = '',
		@sGroup VARCHAR(2000) = ''

SELECT @CustomerName = ISNULL(CustomerName,-1) FROM CustomerIndex

CREATE TABLE #VoucherIDList (DivisionID VARCHAR(50), VoucherID VARCHAR(50))
INSERT INTO #VoucherIDList (DivisionID, VoucherID)
SELECT  X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherID').value('.', 'NVARCHAR(50)') AS VoucherID
FROM @VoucherIDList.nodes('//Data') AS X (Data)

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM WT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = N' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = W95.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = W95.CreateUserID '
				SET @sWHEREPer = N' 
				AND (W95.CreateUserID = AT0010.UserID
					OR  W95.CreateUserID = '''+@UserID+''' '		
			
				IF @CustomerName = 70 ---EIMSKIP
				BEGIN
					SET @sWHEREPer = @sWHEREPer + '
					OR W95.ObjectID = '''+@UserID+''')'
				END
				ELSE SET @sWHEREPer = @sWHEREPer + ')'
			
			END
		
-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		

IF @Mode = 1 SET @sWhere = 'AND W95.KindVoucherID IN (1,5,7,9)'
IF @Mode = 2 SET @sWhere = 'AND W95.KindVoucherID IN (2,4,6,8,10)'
IF @Mode = 3 SET @sWhere = 'AND W95.KindVoucherID IN (3)'

IF @IsCheckALL=0 
BEGIN
	SET @sJoin = 'INNER JOIN #VoucherIDList ON #VoucherIDList.DivisionID = W95.DivisionID AND #VoucherIDList.VoucherID = W95.VoucherID'
END

SET @OrderBy = 'W95.VoucherTypeID, W95.VoucherDate, W95.VoucherNo'

IF @VoucherNo IS NOT NULL SET @sWhere = @sWhere + '
AND ISNULL(W95.VoucherNo,'''') LIKE ''%'+@VoucherNo+'%'' '
IF @ContractNo IS NOT NULL SET @sWhere = @sWhere + '
AND ISNULL(W95.ContractNo,'''') LIKE ''%'+@ContractNo+'%'' '
IF @WareHouseID IS NOT NULL SET @sWhere = @sWhere + '
AND ISNULL(W95.WareHouseID,'''') LIKE ''%'+@WareHouseID+'%''  '
IF @Status IS NOT NULL AND @Status <>'%' SET @sWhere = @sWhere + '
AND ISNULL(CONVERT(VARCHAR(10),W95.[Status]),'''') LIKE ''%'+@Status+'%'' '
IF @FromDate IS NOT NULL SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,W95.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF @ToDate IS NOT NULL SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,W95.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '


IF @Mode = 1
SET @sSelect = ' W95.WareHouseID ImWareHouseID, A33.WareHouseName ImWareHouseName, A33.Address ImWareHouseAddress,'

IF @Mode= 2
BEGIN
	SET @sSelect = ' W95.WareHouseID ExVoucherID, A33.WareHouseName ExVoucherName, A33.Address ExVoucherAddress, ISNULL(AT2006.VoucherDate,'''') AS ReVoucherDate,'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT2006 ON W96.DivisionID = AT2006.DivisionID AND W96.ReVoucherID = AT2006.VoucherID'
	SET @sGroup = ', ISNULL(AT2006.VoucherDate,'''')'
END

IF @Mode = 3
BEGIN
	SET @sSelect = ' W95.WareHouseID AS ImWareHouseID, A33.WareHouseName AS ImWareHouseName, W95.WareHouseID2 AS ExWareHouseID, A34.WareHouseName AS ExWareHouseName, A33.Address ImWareHouseAddress,'

END

SET @sSQL = '
	SELECT W95.VoucherNo, W95.VoucherDate, '+@sSelect+' 
	W95.[Description], W95.EmployeeID, AT1103.FullName EmployeeName, W96.Notes,
	W96.InventoryID, A02.InventoryName, W96.UnitID, A04.UnitName, SUM(W96.ConvertedQuantity) ConvertedQuantity,
	W96.UnitPrice, SUM(W96.ConvertedAmount) ConvertedAmount, SUM(W96.OriginalAmount) OriginalAmount,
	A02.Notes01, W95.ObjectID, A202.ObjectName, A02.BarCode,
	ISNULL(W95.SParameter01,'''') SParameter01, ISNULL(W95.SParameter02,'''') SParameter02, ISNULL(W95.SParameter03,'''') SParameter03, 
	ISNULL(W95.SParameter04,'''') SParameter04, ISNULL(W95.SParameter05,'''') SParameter05, ISNULL(W95.SParameter06,'''') SParameter06, 
	ISNULL(W95.SParameter07,'''') SParameter07, ISNULL(W95.SParameter08,'''') SParameter08, ISNULL(W95.SParameter09,'''') SParameter09, 
	ISNULL(W95.SParameter10,'''') SParameter10, ISNULL(W95.SParameter11,'''') SParameter11, ISNULL(W95.SParameter12,'''') SParameter12, 
	ISNULL(W95.SParameter13,'''') SParameter13, ISNULL(W95.SParameter14,'''') SParameter14, ISNULL(W95.SParameter15,'''') SParameter15, 
	ISNULL(W95.SParameter16,'''') SParameter16, ISNULL(W95.SParameter17,'''') SParameter17, ISNULL(W95.SParameter18,'''') SParameter18, 
	ISNULL(W95.SParameter19,'''') SParameter19, ISNULL(W95.SParameter20,'''') SParameter20,
	ISNULL(W96.Notes01,'''') WNotes01, ISNULL(W96.Notes02,'''') WNotes02, ISNULL(W96.Notes03,'''') WNotes03, 
	ISNULL(W96.Notes04,'''') WNotes04, ISNULL(W96.Notes05,'''') WNotes05, ISNULL(W96.Notes06,'''') WNotes06, 
	ISNULL(W96.Notes07,'''') WNotes07, ISNULL(W96.Notes08,'''') WNotes08, ISNULL(W96.Notes09,'''') WNotes09, 
	ISNULL(W96.Notes10,'''') WNotes10, ISNULL(W96.Notes11,'''') WNotes11, ISNULL(W96.Notes12,'''') WNotes12, 
	ISNULL(W96.Notes13,'''') WNotes13, ISNULL(W96.Notes14,'''') WNotes14, ISNULL(W96.Notes15,'''') WNotes15,
	A02.I01ID, I_01.AnaName AnaNameI01, A02.I02ID, I_02.AnaName AnaNameI02, A02.I03ID, I_03.AnaName AnaNameI03, A02.I04ID, I_04.AnaName AnaNameI04,
	A02.I05ID, I_05.AnaName AnaNameI05, A02.I06ID, I_06.AnaName AnaNameI06, A02.I07ID, I_07.AnaName AnaNameI07,
	A02.I08ID, I_08.AnaName AnaNameI08, A02.I09ID, I_09.AnaName AnaNameI09, A02.I10ID, I_10.AnaName AnaNameI10,
	W96.SourceNo, W96.LimitDate, W95.ContactPerson, W96.APK AS APKDetail
	FROM WT0095 W95 WITH (NOLOCK)'
SET @sSQL1 = '
	LEFT JOIN AT1202 A202 WITH (NOLOCK) ON A202.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = W96.InventoryID
	LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.WareHouseID = W95.WareHouseID
	LEFT JOIN AT1303 A34 WITH (NOLOCK) ON A34.WareHouseID = W95.WareHouseID2
	LEFT JOIN AT1015 I_01 WITH (NOLOCK) ON I_01.AnaID = A02.I01ID AND I_01.AnaTypeID = ''I01''
	LEFT JOIN AT1015 I_02 WITH (NOLOCK) ON I_02.AnaID = A02.I02ID AND I_02.AnaTypeID = ''I02''
	LEFT JOIN AT1015 I_03 WITH (NOLOCK) ON I_03.AnaID = A02.I03ID AND I_03.AnaTypeID = ''I03''
	LEFT JOIN AT1015 I_04 WITH (NOLOCK) ON I_04.AnaID = A02.I04ID AND I_04.AnaTypeID = ''I04''
	LEFT JOIN AT1015 I_05 WITH (NOLOCK) ON I_05.AnaID = A02.I05ID AND I_05.AnaTypeID = ''I05''
	LEFT JOIN AT1015 I_06 WITH (NOLOCK) ON I_06.AnaID = A02.I06ID AND I_06.AnaTypeID = ''I06''
	LEFT JOIN AT1015 I_07 WITH (NOLOCK) ON I_07.AnaID = A02.I07ID AND I_07.AnaTypeID = ''I07''
	LEFT JOIN AT1015 I_08 WITH (NOLOCK) ON I_08.AnaID = A02.I08ID AND I_08.AnaTypeID = ''I08''
	LEFT JOIN AT1015 I_09 WITH (NOLOCK) ON I_09.AnaID = A02.I09ID AND I_09.AnaTypeID = ''I09''
	LEFT JOIN AT1015 I_10 WITH (NOLOCK) ON I_10.AnaID = A02.I10ID AND I_10.AnaTypeID = ''I10''
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = W95.EmployeeID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = W96.UnitID
	'+@sJoin+@sSQLPer+'
	WHERE W95.DivisionID = '''+@DivisionID+'''
	'+@sWhere+@sWHEREPer+'
	GROUP BY W95.VoucherNo, W95.VoucherDate, W95.WareHouseID2, A34.WareHouseName, W95.WareHouseID,
	A33.WareHouseName, W95.[Description], W95.EmployeeID, AT1103.FullName, W96.Notes, W96.InventoryID, A02.InventoryName, W96.UnitID, A04.UnitName,
	W96.UnitPrice, A02.Notes01, W95.ObjectID, A202.ObjectName, A02.Barcode, A33.Address, A34.Address,
	ISNULL(W95.SParameter01,''''), ISNULL(W95.SParameter02,''''), ISNULL(W95.SParameter03,''''), ISNULL(W95.SParameter04,''''), ISNULL(W95.SParameter05,''''), 
	ISNULL(W95.SParameter06,''''), ISNULL(W95.SParameter07,''''), ISNULL(W95.SParameter08,''''), ISNULL(W95.SParameter09,''''), ISNULL(W95.SParameter10,''''), 
	ISNULL(W95.SParameter11,''''), ISNULL(W95.SParameter12,''''), ISNULL(W95.SParameter13,''''), ISNULL(W95.SParameter14,''''), ISNULL(W95.SParameter15,''''), 
	ISNULL(W95.SParameter16,''''), ISNULL(W95.SParameter17,''''), ISNULL(W95.SParameter18,''''), ISNULL(W95.SParameter19,''''), ISNULL(W95.SParameter20,''''),
	ISNULL(W96.Notes01,''''), ISNULL(W96.Notes02,''''), ISNULL(W96.Notes03,''''), ISNULL(W96.Notes04,''''), ISNULL(W96.Notes05,''''), 
	ISNULL(W96.Notes06,''''), ISNULL(W96.Notes07,''''), ISNULL(W96.Notes08,''''), ISNULL(W96.Notes09,''''), ISNULL(W96.Notes10,''''), 
	ISNULL(W96.Notes11,''''), ISNULL(W96.Notes12,''''), ISNULL(W96.Notes13,''''), ISNULL(W96.Notes14,''''), ISNULL(W96.Notes15,''''),
	A02.I01ID, I_01.AnaName, A02.I02ID, I_02.AnaName, A02.I03ID, I_03.AnaName, A02.I04ID, I_04.AnaName, A02.I05ID, I_05.AnaName, A02.I06ID, I_06.AnaName, W96.APK,
	A02.I07ID, I_07.AnaName, A02.I08ID, I_08.AnaName, A02.I09ID, I_09.AnaName, A02.I10ID, I_10.AnaName, W96.SourceNo, W96.LimitDate, W95.ContactPerson'+@sGroup+''

PRINT @sSQL
PRINT @sSQL1

EXEC (@sSQL + @sSQL1)

DROP TABLE #VoucherIDList





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
