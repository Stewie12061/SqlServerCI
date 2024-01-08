IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[DP0004_PL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[DP0004_PL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Bảo Anh		Date: 21/12/2017
---- Purpose: Update lại tài khoản cho một số chứng từ bán hàng sau khi chuyển dữ liệu
---- Modified on 15/07/2019 by Kim Thư: Sửa lại trạng thái chưa phát hành đối với hóa đơn điện tử để có thể edit ở DB THUE2017
---- Modified on 07/01/2020 by Mỹ Tuyền: Bổ sung điều kiện VoucherType.
---- Modified on 11/06/2020 by Huỳnh Thử: Custommer cho Phú Long.
---- Modified on 17/12/2020 by Cao Phước: Bổ sung thêm loại chứng từ BHPACT khi kết chuyển dữ liệu từ NB qua thuế mặc định tài khoản 131
---- Modified on 11/01/2021 by Cao Phước: Bổ sung thêm loại chứng từ BHDLA khi kết chuyển dữ liệu từ NB qua thuế mặc định tài khoản 131
---- Modified on 14/04/2021 by Cao Phước: Bổ sung thêm loại chứng từ BH382ACTY,BHBDACTY,BHBTACTY,BHCATACTY,BHDLACTY,BHDNACTY,BHHNACTY,BHLOT11ACTY,BHLOTDACTY,
---- BHNHACTY,BHNTRACTY,BHTCVACTY khi kết chuyển dữ liệu từ NB qua thuế mặc định tài khoản 1388

CREATE PROCEDURE [dbo].[DP0004_PL]
	@DivisionID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@TargetDB VARCHAR(50)
AS

DECLARE @SQL VARCHAR(MAX) = ''
DECLARE @SQL1 VARCHAR(MAX) = ''
DECLARE @CustommerIndex INT
SELECT @CustommerIndex = CustomerName FROM dbo.CustomerIndex
IF @CustommerIndex = 32
BEGIN
	SET @SQL = '
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET DebitAccountID = ''131''
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND VoucherTypeID IN (''BHA'',''BH'',''BHPA'',''BH382A'',''BHBDA'',''BHBTA'',''BHCATA'',''BHDNA'',''BHHNA'',''BHLOT11A'',''BHLOTDA'',''BHNHA'',''BHNTRA'',''BHTCVA'',''BHPACT'',''BHDLA'')
	AND TransactionTypeID in (''T04'',''T14'')
	
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET CreditAccountID = (Select SalesAccountID From ' + @TargetDB + '.dbo.AT1302 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + ''' And InventoryID = ' + @TargetDB + '.dbo.AT9000.InventoryID)
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND TransactionTypeID = ''T04''
	AND CreditAccountID = ''5118''
	
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET DebitAccountID = (Select AccountID From ' + @TargetDB + '.dbo.AT1302 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + ''' And InventoryID = ' + @TargetDB + '.dbo.AT9000.InventoryID)
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND TransactionTypeID = ''T03''
	AND DebitAccountID = ''33881''

	-- Sửa lại trạng thái chưa phát hành đối với hóa đơn điện tử để có thể edit ở DB THUE2017
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET EInvoiceStatus = 0
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND TransactionTypeID in (''T04'',''T14'')
	AND IsEInvoice=1
	'

	SET @SQL1 = '
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET DebitAccountID = ''1368''
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND VoucherTypeID IN (''BH382ACTY'',''BHBDACTY'',''BHBTACTY'',''BHCATACTY'',''BHDLACTY'',''BHDNACTY'',''BHHNACTY'',''BHLOT11ACTY'',''BHLOTDACTY'',''BHNHACTY'',''BHNTRACTY'',''BHTCVACTY'')
	AND TransactionTypeID in (''T04'',''T14'')
	
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET CreditAccountID = (Select SalesAccountID From ' + @TargetDB + '.dbo.AT1302 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + ''' And InventoryID = ' + @TargetDB + '.dbo.AT9000.InventoryID)
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND TransactionTypeID = ''T04''
	AND CreditAccountID = ''5118''
	
	UPDATE ' + @TargetDB + '.dbo.AT9000
	SET DebitAccountID = (Select AccountID From ' + @TargetDB + '.dbo.AT1302 WITH (NOLOCK) Where DivisionID = ''' + @DivisionID + ''' And InventoryID = ' + @TargetDB + '.dbo.AT9000.InventoryID)
	WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + LTRIM(@TranMonth) + ' And TranYear = ' + LTRIM(@TranYear) + '
	AND TransactionTypeID = ''T03''
	AND DebitAccountID = ''33311'' '
END
EXEC(@SQL+@SQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
