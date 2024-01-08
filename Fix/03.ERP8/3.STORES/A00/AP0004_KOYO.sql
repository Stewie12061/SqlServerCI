IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0004_KOYO]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0004_KOYO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra trùng số seri số hóa đơn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 04/07/2012 by Lê Thị Thu Hiền
---- 
---- Modified on 26/02/2013 by Lê Thị Thu Hiền : Bổ sung Màn hình bán hàng
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Huỳnh Thử on 13/04/2020: Khi check trùng số seri và số HD thì check thêm xem có trùng mã đối tượng không
---- Modified by Huỳnh Thử on 13/07/2020: Bổ sung màn hình -- Chi tiền mặt. AF0062
														   -- Chi ngân hàng.  AF0103
														   -- Phiếu tổng hợp. AF0067
---- Modified by Huỳnh Thử on 25/08/2020: check thêm trường VATNO 
---- Modified by Xuân Nguyên on 19/10/2022: Loại T99 kiểm tra theo CreditObjectID
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Thanh Sang on 29/11/2023: [2023/11/IS/0184] - Bổ sung thêm điều kiện @FormID=AF0102 và khai báo @WHERE = ''
-- <Example>
---- EXEC AP0004 'MK', 'ASOFT-T', 'AF0063' , '2','11111', 'EDIT', 'wewewewew'

CREATE PROCEDURE AP0004_KOYO
( 
	@DivisionID AS NVARCHAR(50),
	@ModuleID AS NVARCHAR(50),
	@FormID AS NVARCHAR(50),
	@Serial AS NVARCHAR(50)='',
	@InvoiceNo AS NVARCHAR(50),
	@Mode AS NVARCHAR(50) = 'NEW',	--- 'EDIT' : Sửa
							--- 'NEW' : Thêm mới
	@VoucherID AS NVARCHAR(50) = '',
	@ObjectID AS NVARCHAR(50)='',
	@VATNO AS NVARCHAR(50) = ''
	
) 
AS 
DECLARE @Sql NVARCHAR(MAX),
		@Table NVARCHAR(50),
		@WHERE NVARCHAR(4000)='',
		@StatusSql TINYINT,
		@Status TINYINT = 0
IF @FormID = 'AF0063' OR @FormID = 'AF0066' OR @FormID = 'AF0062' OR @FormID = 'AF0067' OR @FormID = 'AF0103' OR @FormID = 'AF0102'
BEGIN
	SET @Table = 'AT9000'
	IF @FormID = 'AF0063' SET @WHERE = 'AND TransactionTypeID = ''T03'' AND AT9000.ObjectID = '''+@ObjectID+''' AND ISNULL(AT9000.VATNO,ISNULL(AT1202.VATNO,'''')) = '''+ISNULL(@VATNO,'')+''' '
	IF @FormID = 'AF0066' SET @WHERE = 'AND TransactionTypeID = ''T04'''
	IF @FormID = 'AF0062' SET @WHERE = 'AND TransactionTypeID = ''T02'' AND AT9000.ObjectID = '''+@ObjectID+''' AND ISNULL(AT9000.VATNO,ISNULL(AT1202.VATNO,'''')) = '''+ISNULL(@VATNO,'')+''' '
	IF @FormID = 'AF0103' SET @WHERE = 'AND TransactionTypeID = ''T22'' AND AT9000.ObjectID = '''+@ObjectID+''' AND ISNULL(AT9000.VATNO,ISNULL(AT1202.VATNO,'''')) = '''+ISNULL(@VATNO,'')+''' '
	IF @FormID = 'AF0067' SET @WHERE = 'AND TransactionTypeID = ''T99'' AND AT9000.CreditObjectID = '''+@ObjectID+''' AND ISNULL(AT9000.VATNO,ISNULL(AT1202.VATNO,'''')) = '''+ISNULL(@VATNO,'')+''' '
	IF @Mode = 'EDIT' SET @WHERE = @WHERE + 'AND VoucherID NOT IN  ('''+@VoucherID+''')'
END

SET @Sql = N'
	SELECT @StatusSql = 1 FROM	'+@Table+'  WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
	WHERE AT9000.DivisionID = '''+@DivisionID+'''
		AND ISNULL(Serial,'''') = '''+@Serial+''' 
		AND ISNULL(InvoiceNo,'''') = '''+@InvoiceNo+''''

SET @Sql = @Sql+@WHERE
PRINT @Sql
EXEC sp_executesql @Sql, N'@StatusSql int output', @Status OUTPUT;
--PRINT @Sql

SELECT @Status AS Status

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

