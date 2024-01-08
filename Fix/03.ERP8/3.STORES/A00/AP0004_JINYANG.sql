IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0004_JINYANG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0004_JINYANG]
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
---- Create on 22/02/2022 by Kiều Nga

-- <Example>
---- EXEC AP0004_JINYANG 'MK', 'ASOFT-T', 'AF0063' , '2','11111', 'EDIT', 'wewewewew'

CREATE PROCEDURE AP0004_JINYANG
( 
	@DivisionID AS NVARCHAR(50),
	@ModuleID AS NVARCHAR(50),
	@FormID AS NVARCHAR(50),
	@Serial AS NVARCHAR(50),
	@InvoiceNo AS NVARCHAR(50),
	@Mode AS NVARCHAR(50) = 'NEW',	--- 'EDIT' : Sửa
							--- 'NEW' : Thêm mới
	@VoucherID AS NVARCHAR(50) = '',
	@ObjectID AS NVARCHAR(50),
	@VATNO AS NVARCHAR(50) = '',
	@InvoiceSign AS NVARCHAR(50)='',
	@VATObjectID AS NVARCHAR(50)=''		
) 
AS 
DECLARE @Sql NVARCHAR(MAX),
		@Table NVARCHAR(50),
		@WHERE NVARCHAR(4000)='',
		@StatusSql TINYINT,
		@Status TINYINT = 0

IF @FormID = 'AF0063' OR @FormID = 'AF0066' OR @FormID = 'AF0062' OR @FormID = 'AF0067' OR @FormID = 'AF0103'
BEGIN
	SET @Table = 'AT9000'
	IF @FormID = 'AF0063' SET @WHERE = ' AND TransactionTypeID = ''T03'' AND VATObjectID = '''+@VATObjectID+''' AND ISNULL(VATNO,'''') = '''+ISNULL(@VATNO,'')+''' '
	IF @FormID = 'AF0066' SET @WHERE = ' AND TransactionTypeID = ''T04'' AND ISNULL(InvoiceSign,'''') = '''+ISNULL(@InvoiceSign,'')+''' '
	IF @FormID = 'AF0067' SET @WHERE = ' AND ISNULL(CreditObjectID,'''') = '''+@ObjectID+''' '
	ELSE SET @WHERE = ' AND ISNULL(ObjectID,'''') = '''+@ObjectID+''' '
	IF @Mode = 'EDIT' SET @WHERE = @WHERE + ' AND VoucherID NOT IN  ('''+@VoucherID+''')'
END

SET @Sql = N'
	SELECT @StatusSql = 1 FROM	'+@Table+'  WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
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

