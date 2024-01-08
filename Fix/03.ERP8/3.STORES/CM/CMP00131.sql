IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMP00131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMP00131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load Grid màn hình Thống kê hoa hồng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Khanh Van on 17/01/2014
---- Modified by Thanh Sơn on 24/06/2014: Bổ sung lọc thêm 2 điều kiện : Nhân viên sale và người nhận hoa hồng, phân quyền xem dữ liệu
-----Modified on 25/08/2022 by Kiều Nga: Bổ sung lọc theo mặt hàng
-----Modified on 02/11/2022 by Nhật Quang: Bổ sung thêm cột line, model, tk cho exedy.
-----Modified by Đức Duy	on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-----Modified by Văn Tài	on 28/03/2023: [2023/03/IS/0254] - Điều chỉnh lại biến @Royalty phải là số, vì trong các bảng dữ liệu đang là số.
-- <Example>
/*
    CMP00131 'LTV','', 1, 2014,6, 2014,'%', '%', '%','%',3,'%','%'
*/

					
CREATE PROCEDURE CMP00131
(
	@DivisionID NVARCHAR(50), 
	@UserID NVARCHAR(50), 		
	@FromMonth INT, 	
	@FromYear INT, 		
	@ToMonth INT, 							
	@ToYear INT,			
	@ObjectTypeID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@InventoryTypeID NVARCHAR(50),
	@InventoryID NVARCHAR(50),
	@Mode TINYINT,
	@ReceiverID VARCHAR(50) = NULL,
	@SaleID VARCHAR(50) = NULL,
	@Royalty INT = 0
)
AS
DECLARE @sSQL NVARCHAR(MAX)
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX),
		@sWHEREInventory AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		
SET @sWHEREInventory = ''		

-- Tính hoa hồng theo hóa đơn, mặt hàng và đối tượng
IF (@Mode IN (0,1,2))
BEGIN
	----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
IF EXISTS (SELECT TOP 1 1 FROM CMT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = C10.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = C10.CreateUserID '
		SET @sWHEREPer = ' AND (C10.CreateUserID = AT0010.UserID
								OR  C10.CreateUserID = '''+@UserID+''') '		
	END
-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác
	SET @sSQL = '
SELECT C10.DivisionID, C10.VoucherID, A00.InVoiceNo VoucherNo, A00.InvoiceDate VoucherDate, C10.TranMonth, C10.TranYear, C10.InventoryID,
A02.InventoryName, A00.ObjectID CustomerID, A202.ObjectName CustomerName, C10.ObjectID ReceiverID, A201.ObjectName ReceiverName,
C10.ComPercent ComRate, C10.ComUnit, SUM(C10.ComAmount) ComAmount, SUM(ISNULL(C15.ConvertedAmount,0)) PaidAmount,
SUM(C10.ComAmount) - SUM(ISNULL(C15.ConvertedAmount,0)) RemainAmount,
ISNULL(C15.IsPayment, CASE WHEN ISNULL(A201.BankAccountNo,'''') <> '''' THEN 0 ELSE 1 END) IsPayment, A201.BankAccountNo BankAccount,
NULL BankAccountName, A201.BankName, A11.AnaName Saleman
FROM CMT0010 C10
LEFT JOIN (SELECT DivisionID, TVoucherID, ObjectID, InventoryID, MAX(IsPayment) IsPayment, SUM(ISNULL(CMT0015.ConvertedAmount,0)) ConvertedAmount 
           FROM CMT0015 GROUP BY DivisionID, TVoucherID, ObjectID, InventoryID)C15
	ON C15.DivisionID = C10.DivisionID AND C15.ObjectID = C10.ObjectID AND C15.TVoucherID = C10.VoucherID AND C15.InventoryID = C10.InventoryID
LEFT JOIN AT1202 A201 ON A201.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A201.ObjectID = C10.ObjectID
LEFT JOIN AT1302 A02 ON A02.DivisionID = C10.DivisionID AND A02.InventoryID = C10.InventoryID
LEFT JOIN (SELECT DISTINCT DivisionID, VoucherID, ObjectID, InvoiceDate, InVoiceNo, MAX(Ana01ID) Ana01ID FROM AT9000 WHERE TransactionTypeID = ''T04''
           GROUP BY DivisionID, VoucherID, ObjectID, InvoiceDate, InVoiceNo)A00 ON A00.DivisionID = C10.DivisionID AND A00.VoucherID = C10.VoucherID
LEFT JOIN AT1011 A11 ON A11.DivisionID = A00.DivisionID AND A11.AnaID = A00.Ana01ID
LEFT JOIN AT1202 A202 ON A202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A202.ObjectID = A00.ObjectID
'+@sSQLPer+'
WHERE C10.DivisionID = '''+@DivisionID+'''
AND C10.TranYear * 100 + C10.TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR(@ToYear * 100 + @ToMonth)+'
AND (A201.ObjectTypeID LIKE ''HH'' AND C10.ObjectID LIKE ISNULL('''+@ReceiverID+''',''%'') OR A201.ObjectTypeID LIKE ''NV'' AND C10.ObjectID LIKE ISNULL('''+@SaleID+''',''%''))
AND A202.ObjectTypeID LIKE ISNULL('''+@ObjectTypeID+''',''%'') AND A00.ObjectID LIKE ISNULL('''+@ObjectID+''',''%'')
AND A02.InventoryTypeID LIKE ISNULL('''+@InventoryTypeID+''',''%'') AND C10.InventoryID LIKE ISNULL('''+@InventoryID+''',''%'')
'+@sWHEREPer+'
GROUP BY C10.DivisionID, C10.VoucherID, A00.InVoiceNo, A00.InvoiceDate, C10.TranMonth, C10.TranYear, C10.InventoryID,
A02.InventoryName, A00.ObjectID, A202.ObjectName, C10.ObjectID, A201.ObjectName,
C10.ComPercent, C10.ComUnit, C15.IsPayment, A201.BankAccountNo, A201.BankName, A11.AnaName '
END

-- Tính hoa hồng cho bộ phận hỗ trợ
IF @Mode = 3
BEGIN
	----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		

IF EXISTS (SELECT TOP 1 1 FROM CMT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = C13.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = C13.CreateUserID '
		SET @sWHEREPer = ' AND (C13.CreateUserID = AT0010.UserID
								OR  C13.CreateUserID = '''+@UserID+''') '		
	END
-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác
	SET @sSQL = '
SELECT C13.DivisionID, NULL VoucherID, NULL VoucherNo, C13.CreateDate VoucherDate, C13.TranMonth, C13.TranYear, C13.InventoryID,
A02.InventoryName, NULL CustomerID, NULL CustomerName, C13.ObjectID ReceiverID, A202.ObjectName ReceiverName, NULL ComRate,
NULL ComUnit, SUM(C13.ComAmount) ComAmount, SUM(ISNULL(C15.ConvertedAmount,0)) PaidAmount,
SUM(C13.ComAmount) - SUM(ISNULL(C15.ConvertedAmount,0)) RemainAmount,
ISNULL(C15.IsPayment, CASE WHEN ISNULL(A202.BankAccountNo,'''') <> '''' THEN 0 ELSE 1 END) IsPayment, A202.BankAccountNo BankAccount,
NULL BankAccountName, A202.BankName, NULL Saleman
FROM CMT0013 C13
LEFT JOIN (SELECT DivisionID, TVoucherID, ObjectID, InventoryID, MAX(IsPayment) IsPayment, SUM(ISNULL(CMT0015.ConvertedAmount,0)) ConvertedAmount 
           FROM CMT0015 WHERE [Status] = 1 GROUP BY DivisionID, TVoucherID, ObjectID, InventoryID)C15
     ON C15.DivisionID = C13.DivisionID AND C15.ObjectID = C13.ObjectID AND C15.InventoryID = C13.InventoryID
LEFT JOIN AT1202 A202 ON A202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A202.ObjectID = C13.ObjectID
LEFT JOIN AT1302 A02 ON A02.DivisionID = C13.DivisionID AND A02.InventoryID = C13.InventoryID
'+@sSQLPer+'
WHERE C13.DivisionID = '''+@DivisionID+'''
AND C13.TranYear * 100 + C13.TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR(@ToYear * 100 + @ToMonth)+'
AND (A202.ObjectTypeID LIKE ''HH'' AND C13.ObjectID LIKE ISNULL('''+@ReceiverID+''',''%'') OR A202.ObjectTypeID LIKE ''NV'' AND C13.ObjectID LIKE ISNULL('''+@SaleID+''',''%''))
AND A02.InventoryTypeID LIKE ISNULL('''+@InventoryTypeID+''',''%'') AND C13.InventoryID LIKE ISNULL('''+@InventoryID+''',''%'')
'+@sWHEREPer+'
GROUP BY C13.DivisionID, C13.CreateDate, C13.TranMonth, C13.TranYear, C13.InventoryID,
A02.InventoryName, C13.ObjectID, A202.ObjectName, C15.IsPayment, A202.BankAccountNo, A202.BankName '

END

-- Tính hoa hồng cho bộ phận sale
IF @Mode = 4
BEGIN
	----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		

IF EXISTS (SELECT TOP 1 1 FROM CMT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = C13.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = C13.CreateUserID '
		SET @sWHEREPer = ' AND (C13.CreateUserID = AT0010.UserID
								OR  C13.CreateUserID = '''+@UserID+''') '		
	END
-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác

IF(ISNULL(@InventoryTypeID,'%') <> '%' )
	SET @sWHEREInventory = ' AND C13.InventoryID LIKE ISNULL('''+@InventoryTypeID+''',''%'')'
ELSE IF(ISNULL(@InventoryID,'%') <> '%' )
	SET @sWHEREInventory = ' AND C13.InventoryID LIKE ISNULL('''+@InventoryID+''',''%'')'
ELSE IF(ISNULL(@InventoryTypeID,'%') <> '%' ) AND (ISNULL(@InventoryID,'%') <> '%' )
	SET @sWHEREInventory = ' AND (C13.InventoryID LIKE ISNULL('''+@InventoryTypeID+''',''%'') OR C13.InventoryID LIKE ISNULL('''+@InventoryID+''',''%''))'

	SET @sSQL = '
SELECT C13.DivisionID
	, NULL VoucherID
	, C13.VoucherNo
	, C13.CreateDate VoucherDate
	, C13.TranMonth
	, C13.TranYear
	, C13.InventoryID
	, A02.InventoryName
	, C13.ObjectID CustomerID
	, A202.ObjectName CustomerName
	, C13.SaleManID ReceiverID
	, AT05.UserName ReceiverName
	, NULL ComRate
	, NULL ComUnit
	, C13.ConvertedAmount AS ConvertedAmount
	, C13.ComAmount AS ComAmount
	, 0 PaidAmount
	, 0 RemainAmount
	, 0 IsPayment
	, A202.BankAccountNo BankAccount
	, NULL BankAccountName
	, A202.BankName
	, ISNULL(AT05.UserName, C13.SaleManID) AS Saleman
	, C13.SaleManID UserID
	, AT05.UserName UserName	
	, A.SalesMonth
	, A.TargetsID
	, A02.I01ID AS Model
	, A02.I02ID AS Line
	, A02.I03ID AS TK
	, C13.Quantity AS Quantity
	, C13.UnitID AS UnitID
FROM CMT0013 C13
LEFT JOIN AT1202 A202 ON A202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A202.ObjectID = C13.ObjectID
LEFT JOIN AT1405 AT05 ON AT05.DivisionID IN (''@@@'', C13.DivisionID) AND AT05.UserID = C13.SaleManID
LEFT JOIN AT1302 A02 ON A02.DivisionID IN (''@@@'', C13.DivisionID) AND A02.InventoryID = C13.InventoryID
OUTER APPLY
(
	SELECT TOP 1 *
	FROM AT0161 AT61 WITH (NOLOCK)
	WHERE 
		AT61.DivisionID = C13.DivisionID
		AND AT61.EmployeeID = C13.SaleManID
		AND 
		(
			(YEAR(AT61.FromDate) * 100 + MONTH(AT61.FromDate)) <= ' + STR(@FromYear * 100 + @FromMonth)+ '
			AND 
			(
				AT61.ToDate IS NULL
				OR
				(YEAR(AT61.ToDate) * 100 + MONTH(AT61.ToDate)) >= ' + STR(@FromYear * 100 + @FromMonth)+ '
			)
		)
) A
'+@sSQLPer+'
WHERE C13.DivisionID = '''+@DivisionID+'''
AND ISNULL(C13.IsRoyalty, 0) =  ''' + STR(@Royalty) + '''
AND C13.TranYear * 100 + C13.TranMonth BETWEEN ' + STR(@FromYear * 100 + @FromMonth)+' AND ' + STR(@ToYear * 100 + @ToMonth) + '
AND C13.SaleManID LIKE ISNULL('''+@SaleID+''',''%'')
'+@sWHEREInventory+'
'+@sWHEREPer+'
ORDER BY C13.VoucherNo
'

END


PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

