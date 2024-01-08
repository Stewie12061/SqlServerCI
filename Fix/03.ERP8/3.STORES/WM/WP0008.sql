IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[WP0008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Loc ra cac phieu Nhap, xuat, VCNB de len man hinh truy van 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: 
---- Edit By: Mai Duyen,Date 21/03/2014: Bổ sung tham so @IsServer,@StrWhere để tìm kiếm Detail( customized cho KH PrintTech ) 
---- Modified by Thanh Sơn on 08/07/2014: Bổ sung biến @Mode để load dữ liệu theo từng loại phiếu (chia tabcontrol)
---- Modified by Hoàng Vũ on 10/08/2015: Bổ sung phần quyền xem du74lieu65 của người khác
---- Modified by Thanh Thịnh on 05/10/2015: Bổ Sung thêm trường Load dữ liệu đối với nhập kho và từ sản xuất
---- Modified by Phương Thảo on 15/10/2015: Bổ sung thêm IsVAT
---- Modified by Kim Vũ on 21/04/2016: Bổ sung tìm kiếm theo InventoryID, InventoryName
---- Modified by Phương Thảo on 18/05/2016 : Bổ sung with(nolock)
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 21/03/2017 by Bảo Thy: Bổ sung ISCalCost, CostVoucherNo (EIMSKIP)
---- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Hải Long on 06/09/2017: Bổ sung cột loại VCNB (Bê Tông Long An)
---- Modified by Kim Thư on 04/01/2019: Lấy thêm InvoiceNo đối với phiếu VCNB (16-Siêu Thanh)
---- Modified by Huỳnh Thử on 27/08/2020: Lấy thêm Yêu cầu nhập kho, yêu cầu xuất kho, lệnh xuất kho (EIMSKIP)
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 16/10/2020 : EMIKSIP -- Xuất kho kế thừa nhiều lệch gộp thành 1 dòng, yêu cầu xuất kho và lệnh xuất kho cách nhau dấu , 
---- Modified by Đức Thông on 03/11/2020 : Kéo thêm trường mã phân tích 1 (Ana01ID)
---- Modified by Hoài Phong on 17/11/2020 : Tăng ký tự Query lên mã hiện tại 4000 bị lỗi
---- Modified by Đức Thông on 27/01/2021 : [SAVIFARM] 2021/01/IS/0357: Sửa lỗi phiếu bị lặp dòng ở màn hình truy vấn phiếu xuất kho
---- Modified by Nhựt Trường on 08/03/2022: Bổ sung convert trường VoucherDate khi where.
---- Modified by Nhật Thanh on 25/03/2022: Bổ sung cột cho angel. Bổ sung điều kiện divisionID @@@ khi join bảng AT1202
---- Modified by Nhật Thanh on 28/04/2022: Bổ sung cột cho angel
---- Modified by Xuân Nguyên on 28/04/2022: Bổ sung điều kiện lọc theo kỳ kế toán
-- <Example>
/*
	 exec WP0008 @DivisionID=N'AS',@FromDate='2014-05-10 00:00:00',@ToDate='2016-05-31 00:00:00',@ConditionVT=N'('''')',
	@IsUsedConditionVT=N' (0=0) ',@ConditionOB=N'('''')',@IsUsedConditionOB=N' (0=0) ',
	@ConditionWA=N'('''')',@IsUsedConditionWA=N' (0=0) ',@IsServer=0,@StrWhere=N'', @Mode = 2, @UserID = 'NV005'
*/

	
CREATE PROCEDURE [dbo].[WP0008] 
(
    @DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ConditionVT NVARCHAR(MAX),
	@IsUsedConditionVT NVARCHAR(20),
	@ConditionOB NVARCHAR(MAX),
	@IsUsedConditionOB NVARCHAR(20),
	@ConditionWA NVARCHAR(MAX),
	@IsUsedConditionWA NVARCHAR(20),
	@IsServer INT = 0,	--0 : Tim kiem Master -- 1 : Tim kiem Detail
	@StrWhere NVARCHAR(4000) = '',  --Dieu kien tim kiem tren luoi
	@Mode TINYINT = 1,-- 1: Nhập, 2: Xuất, 3: VCNB
	@UserID nvarchar(50),
	@Isperiod  INT = 0, --0: Ngày, 1:Kỳ
	@Period AS NVARCHAR(4000) = ''
)

AS
DECLARE @sSQL AS NVARCHAR(MAX),
		@CustomerName INT,
		@sWhere NVARCHAR(2000),
		@sJoin NVARCHAR(2000) = '',
		@sSelect NVARCHAR(2000) = '',
		@sGroup NVARCHAR(2000) = '',
		@sPeriod AS NVARCHAR(MAX)

		----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM WT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = A06.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = A06.CreateUserID '
				SET @sWHEREPer = ' AND (A06.CreateUserID = AT0010.UserID
										OR  A06.CreateUserID = '''+@UserID+''') '		
			END

		-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		
SET @sWhere = ''
IF @Mode = 1 SET @sWhere = 'AND A06.KindVoucherID IN (1,5,7,9)'
IF @Mode = 2 
BEGIN
	SET @sWhere = 'AND A06.KindVoucherID IN (2,4,6,8,10)'
	SET @StrWhere = REPLACE(@StrWhere,'ExWareHouseID','WareHouseID')
	SET @StrWhere = REPLACE(@StrWhere,'ImWareHouseID','WareHouseID')	
END

IF @Mode = 3
BEGIN
	SET @sWhere = 'AND A06.KindVoucherID = 3'
	SET @StrWhere = REPLACE(@StrWhere,'ImWareHouseID','WareHouseID')
	SET @StrWhere = REPLACE(@StrWhere,'ExWareHouseID','WareHouseID2')		
END 

IF @IsServer = 1 SET 	@sWhere = @sWhere + 'AND ' + @StrWhere

IF @Isperiod = 0
begin
	SET @sPeriod ='	AND (CONVERT(VARCHAR, A06.VoucherDate,111) BETWEEN ''' + CONVERT(VARCHAR, @FromDate,111) + ''' AND ''' + CONVERT(VARCHAR, @ToDate,111) + ''')'
end
else
begin
	SET @sPeriod ='AND(''0''+CONCAT(A06.TranMonth,''/'',A06.TranYear) IN ('+@Period+'))'
end 

--Tao bang tam de kiem tra day co phai la khach hang PrintTech khong (CustomerName = 26)
CREATE TABLE #CustomerName (CustomerName INT, ImportExcel INT)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 70 ---EIMSKIP
BEGIN
	
	SELECT DISTINCT A06.VoucherID,W95_LXK.VoucherNo AS ReExVoucherNo, W01.VoucherNo AS ReCmVoucherNo INTO #TEMP  FROM AT2007  A07
	LEFT JOIN AT2006 A06 ON A06.VoucherID = A07.VoucherID
	LEFT JOIN WT2001 W01 WITH (NOLOCK) ON W01.DivisionID = A06.DivisionID AND W01.VoucherID = A07.InheritVoucherID 
	LEFT JOIN WT2002 W02 WITH (NOLOCK) ON W02.DivisionID = A06.DivisionID AND W02.VoucherID = W01.VoucherID 
	LEFT JOIN WT0095 W95_LXK WITH (NOLOCK) ON W95_LXK.DivisionID = A06.DivisionID AND W95_LXK.VoucherID = W02.InheritVoucherID 
	WHERE ( @Isperiod = 0 AND (CONVERT(VARCHAR, A06.VoucherDate,111) BETWEEN  CONVERT(VARCHAR, @FromDate,111) AND CONVERT(VARCHAR, @ToDate,111) ) )
	OR (@Isperiod = 1 and '0'+CONCAT(A06.TranMonth,'/',A06.TranYear) IN (@Period) ) 


	SET @sSelect = ', W97.VoucherNo AS CostVoucherNo, (CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN W95.VoucherNo ELSE '''' END) AS ReVoucherNo, 
					--(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN ISNULL(W95_LXK.VoucherNo,W95.VoucherNo) ELSE '''' END)  AS ReExVoucherNo, W01.VoucherNo AS ReCmVoucherNo
					ReExVoucherNo, ReCmVoucherNo
					'
	SET @sGroup = ', W97.VoucherNo, W95.VoucherNo, ReExVoucherNo, ReCmVoucherNo
					--, W01.VoucherNo, W95_LXK.VoucherNo'
	SET @sJoin = '
	LEFT JOIN WT0098 W98 WITH (NOLOCK) ON A06.DivisionID = W98.DivisionID AND A06.VoucherID = W98.InheritVoucherID
	LEFT JOIN WT0097 W97 WITH (NOLOCK) ON W97.DivisionID = W98.DivisionID AND W97.VoucherID = W98.VoucherID
	LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.DivisionID = A06.DivisionID AND W95.VoucherID = A07.InheritVoucherID 
	INNER JOIN (
		SELECT 
		t1.VoucherID,
	  STUFF((
		SELECT '', '' + t2.ReExVoucherNo  
		FROM #TEMP t2
		WHERE t2.VoucherID = t1.VoucherID
		FOR XML PATH (''''))
	  ,1,2,'''') AS ReExVoucherNo,
	   STUFF((
		SELECT '', '' + t2.ReCmVoucherNo  
		FROM #TEMP t2
		WHERE t2.VoucherID = t1.VoucherID
		FOR XML PATH (''''))
	  ,1,2,'''') AS ReCmVoucherNo
	FROM #TEMP t1
	GROUP BY t1.VoucherID
	) TAM ON TAM.VoucherID = A06.VoucherID

	--LEFT JOIN WT2001 W01 WITH (NOLOCK) ON W01.DivisionID = A06.DivisionID AND W01.VoucherID = A07.InheritVoucherID 
	--LEFT JOIN WT2002 W02 WITH (NOLOCK) ON W02.DivisionID = A06.DivisionID AND W02.VoucherID = W01.VoucherID 
	--LEFT JOIN WT0095 W95_LXK WITH (NOLOCK) ON W95_LXK.DivisionID = A06.DivisionID AND W95_LXK.VoucherID = W02.InheritVoucherID 
	'
END

IF @CustomerName = 80 ---BÊ TÔNG LONG AN
BEGIN
	SET @sSelect = N', (CASE WHEN A06.IsReturn IN (1,2) THEN N''VCNB trả về'' 
							WHEN A06.IsDelivery = 1 THEN N''VCNB giao hàng'' ELSE NULL END) AS TypeName'
	SET @sGroup = ', A06.IsReturn, A06.IsDelivery'						   
END

IF @CustomerName = 16 ---SIÊU THANH
BEGIN
	SET @sSelect = N', A35.InvoiceSign, A35.Serial, A35.InvoiceNo '
	SET @sGroup = ', A35.InvoiceSign, A35.Serial, A35.InvoiceNo '		
	
	SET @sJoin = 'LEFT JOIN AT1035 A35 WITH (NOLOCK) ON A35.VoucherID = A06.VoucherID AND A35.IsLastEInvoice = 1'				   
END

IF @CustomerName = 26  --- Customize PrintTech
	EXEC WP0008_PT @DivisionID, @FromDate, @ToDate, @ConditionVT, @IsUsedConditionVT, @ConditionOB, @IsUsedConditionOB, @ConditionWA, @IsUsedConditionWA,@IsServer,@StrWhere
ELSE
	BEGIN		
		SET @sSQL = '
SELECT * , CAST(0 AS BIT) AS IsVAT
INTO #WP0008
FROM 
(
	SELECT DISTINCT CONVERT(bit,0) AS Choose,A06.VoucherTypeID, A06.VoucherNo, A06.VoucherDate, A06.RefNo01, A06.RefNo02, SUM(A07.ConvertedAmount) ConvertedAmount,
	A06.ObjectID + '' - '' +ISNULL(A06.VATObjectName, A02.ObjectName) ObjectID, ISNULL(A06.VATObjectName, A02.ObjectName) ObjectName,
	A06.ObjectID ObjectIDPermission, A06.EmployeeID,  ISNULL(A06.IsReturn,0) AS  IsReturn, 
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A06.WareHouseID ELSE '''' END) ImWareHouseID,
	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A06.WareHouseID ELSE CASE WHEN A06.KindVoucherID = 3 THEN A06.WareHouseID2 ELSE '''' END END) ExWareHouseID,
	A06.[Description], A06.VoucherID, A06.[Status], A06.DivisionID, A06.TranMonth, A06.TranYear, A06.CreateUserID, A06.KindVoucherID,
	A06.EVoucherID, A06.ImVoucherID '+CASE WHEN @CustomerName = 49 THEN ', ISNULL((SELECT TOP 1 1 FROM MT0810 WITH (NOLOCK) WHERE voucherid = A06.voucherid),0) [IsM]' ELSE '' END + ',
	(SELECT TOP 1 Ana01ID FROM AT2007 A07B WHERE A06.DivisionID = A07B.DivisionID AND A06.VoucherID = A07B.VoucherID) AS Ana01ID,
	ISNULL(A06.IsNotUpdatePrice,0) AS IsNotUpdatePrice, ISNULL(A06.IsProduct,0) AS IsProduct, ISNULL(A06.IsLedger,0) AS IsLedger, ISNULL(A06.IsNotJoinPrice,0) AS IsNotJoinPrice,
	ISNULL(A06.IsCalCost,0) AS IsCalCost '+@sSelect+'
	FROM AT2006 A06 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID in (''@@@'',A06.DivisionID) AND A02.ObjectID = A06.ObjectID
	LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = A06.DivisionID AND A07.VoucherID = A06.VoucherID
	Left JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', A07.DivisionID) AND AT1302.InventoryID = A07.InventoryID
	'+@sJoin+'
	' + @sSQLPer+ '
	WHERE A06.DivisionID = '''+@DivisionID+'''
	'+@sPeriod+'
	'+@sWhere+''+ @sWHEREPer+'
	GROUP BY A06.VoucherTypeID, A06.VoucherNo, A06.VoucherDate, A06.RefNo01, A06.RefNo02, A06.ObjectID, A06.VATObjectName,
	A02.ObjectName, A06.ObjectID, A06.EmployeeID, A06.KindVoucherID, A06.WareHouseID, A06.WareHouseID2,
	A06.[Description], A06.VoucherID, A06.[Status], A06.DivisionID, A06.TranMonth, A06.TranYear, A06.CreateUserID, A06.KindVoucherID,
	A06.EVoucherID, A06.ImVoucherID, A06.IsCalCost, A06.IsReturn, A06.IsNotUpdatePrice, A06.IsProduct, A06.IsLedger, A06.IsNotJoinPrice '+@sGroup+'
)A
WHERE (ISNULL(VoucherTypeID, ''#'') IN (' + @ConditionVT + ') OR ' + @IsUsedConditionVT + ')
AND (ISNULL(ObjectIDPermission, ''#'') IN (' + @ConditionOB + ') OR ' + @IsUsedConditionOB + ')
AND (ISNULL(ImWareHouseID, ''#'') IN (' + @ConditionWA + ') OR ' + @IsUsedConditionWA + ')
AND (ISNULL(ExWareHouseID, ''#'') IN (' + @ConditionWA + ') OR ' + @IsUsedConditionWA + ')
ORDER BY VoucherTypeID, VoucherDate, VoucherNo

UPDATE #WP0008
SET		ISVAT = 1
WHERE  EXISTS (SELECT top 1 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+'''
														AND #WP0008.VoucherID = AT9000.VoucherID
														AND TransactionTypeID = ''T14'')

SELECT * FROM #WP0008 ORDER BY VoucherTypeID, VoucherDate, VoucherNo
DROP TABLE #WP0008
'
	PRINT(@sSQL)
	EXEC(@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
