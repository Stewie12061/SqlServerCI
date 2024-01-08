IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3106]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3106]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by: Kim Thư on 16/01/2019
---- Purpose: Load danh mục  / In, Xuất Excel phiếu chiết khấu
---- Modify on 05/07/2019 by Kim Thư: Bổ sung DiscountType 
---- Modify on 06/11/2019 by Huỳnh Thử: Bổ sung Xuất Tổng hợp Execl 
---- Modify on 31/08/2020 by Huỳnh Thử: Check = '' trường hợp Load lưới
-- EXEC AP3106 @DivisionID = 'ANG', @FromMonth = 1, @FromYear = 2019, @ToMonth = 1, @ToYear = 2019, @FromDate = '2019-01-18 00:00:00', @ToDate = '2019-01-18 23:59:59', @IsDate=0, @DiscountType=1, @VoucherID=''

CREATE PROCEDURE [dbo].[AP3106] @DivisionID nvarchar(50),
								@FromMonth int,
  								@FromYear int,
								@ToMonth int,
								@ToYear int,  
								@FromDate as datetime,
								@ToDate as Datetime,
								@IsDate as tinyint, ----0 theo ky, 1 theo ng�y
								@DiscountType TINYINT, -- 1: CK thương mại / 2: CK thanh toán			
								--@VoucherID varchar(50), -- ,
								@LstVoucherID XML --truyền '' nếu load danh mục, truyền VoucherID nếu in / xuất excel

AS

SELECT X.Rec.query('./VoucherID').value('.', 'NVARCHAR(50)') AS VoucherID
INTO #LST_VOUCHERID
FROM @LstVoucherID.nodes('/Data/VoucherIDs') AS X (Rec)

Declare @sqlSelect as nvarchar(4000),
		@sqlWhere  as nvarchar(4000)

IF @IsDate = 0
	Set  @sqlWhere = N'
		And  A31.TranMonth+A31.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
else
	Set  @sqlWhere = N'
		And A31.VoucherDate  Between '''+Convert(nvarchar(10),@FromDate,21)+' 00:00:00'' and '''+convert(nvarchar(10), @ToDate,21)+' 23:59:59'''

IF (SELECT TOP 1 VoucherID FROM #LST_VOUCHERID) = ''
	SET @sqlSelect = '
		SELECT A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, A31.EndOriginalAmount,
			SUM(A31.DiscountAmount) AS TotalDiscountAmount, A03.Fullname AS EmployeeName, A31.DiscountType, A31.ObjectID, A31.ObjectName
		FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
		WHERE A31.DivisionID = '''+@DivisionID+''' 
			AND ' + CASE WHEN @DiscountType = 1 THEN 'A31.DiscountType = 1' ELSE 'A31.DiscountType = 2' END
			+ @sqlWhere+'
		GROUP BY A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, A03.Fullname, A31.DiscountType, A31.ObjectID, A31.ObjectName,A31.EndOriginalAmount
		ORDER BY A31.VoucherDate, A31.VoucherNo
		'

ELSE
	SET @sqlSelect = '
		SELECT A31.VoucherID, A31.TransactionID, A31.TranMonth, A31.TranYear, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note,A31.EndOriginalAmount,
			A31.DiscountType, A31.InvoiceNo, A31.InvoiceDate, A31.ReceivedDate, A31.InventoryID, A31.InventoryName, A31.Amount, A31.AfterVATAmount, A31.DiscountRate,
			A31.DiscountAmount, (SELECT SUM(AT3101.DiscountAmount) FROM AT3101 WITH (NOLOCK) WHERE AT3101.VoucherID = A31.VoucherID) AS TotalDiscountAmount,
			A31.ObjectID, A31.ObjectName, A31.TDescription, A03.Fullname AS EmployeeName
		FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
		WHERE A31.DivisionID = '''+@DivisionID+''' 
			AND VoucherID in (SELECT VoucherID FROM #LST_VOUCHERID) 
			ORDER BY A31.VoucherDate, A31.VoucherNo
	'


PRINT @sqlSelect
EXEC (@sqlSelect)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
