IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03194]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP03194]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load du lieu cho man hinh but toan tong hop AF0067
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> T/but toan tong hop/Tap hop but toan hinh thanh TSCD/ Chon
---- 
-- <History>
----- Created by Phuong Thao, Date 13/11/2015
---- Modify on 
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
-- <Example>
---- 
/* DROP TABLE AF0319TMP
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AF0319TMP]') AND type in (N'U')) 
BEGIN
     CREATE TABLE AF0319TMP 
     (DivisionID Nvarchar(50),
     ObjectID  Nvarchar(50),
     ObjectName Nvarchar(250),
     AccountID Nvarchar(50),
     CurrencyID NVarchar(50),
     ExchangeRate Money,
    TaskID Nvarchar(50),
    TaskName Nvarchar(250),
    OriginalAmount Decimal(28,8),
     ConvertedAmount Decimal(28,8),
     StrTransactionID Nvarchar(2000),
    UserID NVarchar(100),
    HostID Nvarchar(100)
       )
END
 EXEC AP03194 'GS', 'ADMIN', 'AS031', ''
 */
CREATE PROCEDURE [dbo].[AP03194] 
				@DivisionID AS nvarchar(50), 
				@VoucherID AS Nvarchar(50),
				@UserID AS Nvarchar(50),
				@HostID AS NVarchar(100)

AS

DECLARE @sSQL NVarchar(4000)

Set @sSQL='
BEGIN WITH TEMP AS
(
	SELECT InheritTransactionID, InheritTableID
	FROM AT9000 WITH (NOLOCK)
	WHERE VoucherID ='''+@VoucherID+''' 
	AND DivisionID ='''+@DivisionID+'''
	AND InheritTableID =''AF0319TMP''
)

UPDATE AT9000
SET		InheritedFAVoucherID = '''+@VoucherID+'''
FROM AT9000, TEMP
WHERE CHARINDEX(AT9000.TransactionID,TEMP.InheritTransactionID) > 0
END

'


--Print @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

