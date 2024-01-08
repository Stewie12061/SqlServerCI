IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03214]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03214]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu cho AF0064 - Chi phí mua hàng khi thực hiện phân bổ chi phí mua hàng[Customize LAVO]
-- <History>
---- Create on 24/04/2015 by Lê Thị Hạnh 
---- Modified on ... by 
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Anh on 26/05/2016: Lấy BaseCurrencyID từ AT1101 vì đã chuyển thiết lập sang Division
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Thông on 30/10/2020: Chỉnh sửa cách join với các bút toán t99, t22, t02 để lấy thông tin tk và đối tượng tránh bị dup dòng dẫn tới sum tổng tiền trong phân bổ chi phí sai
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
 AP03214 @DivisionID = 'LV', @VoucherID = '6b59bbad-3933-484d-9098-3633f0cc7ef9', @Status = 0
 SELECT * FROM AT0305 WHERE VoucherID = '6b59bbad-3933-484d-9098-3633f0cc7ef9'
 */

CREATE PROCEDURE [dbo].[AP03214] 	
	@DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50), -- Của chứng từ PBCPMH
	@Status INT -- 0: Add, 1: Edit, 3: Delete
AS

DECLARE @sSQL NVARCHAR(MAX)
SET @Status = ISNULL(@Status,0)
-- Xoá dữ liệu chi phí mua hàng T23
DELETE FROM AT9000
WHERE DivisionID = @DivisionID 
   AND VoucherID IN (SELECT AT0321.POVoucherID
                     FROM AT0321 WITH (NOLOCK)
                     WHERE AT0321.DivisionID = @DivisionID AND AT0321.VoucherID = @VoucherID) 
   AND TransactionTypeID = 'T23'
-- lOAD DỮ LIỆU CHO FORM

SET @sSQL = 'SELECT VoucherID,
       POVoucherID,
       DebitAccountID,
       CreditAccountID,
       A.ObjectID,
       ObjectName,
       [Address],
       TDescription,
       VDescription,
       BaseCurrencyID,
       ExchangeRate,
       SUM(OriginalAmount) AS OriginalAmount,
       SUM(ConvertedAmount) AS ConvertedAmount
FROM
  (SELECT AT0321.VoucherID,
          AT0321.POVoucherID,
          AT90.DebitAccountID,

     (SELECT TOP 1 DebitAccountID
      FROM at9000 WITH(NOLOCK)
      WHERE DivisionID = AT0321.DivisionID
        AND BatchID = AT0321.POCTransactionID
        AND VoucherID = AT0321.POCVoucherID
        AND TransactionTypeID IN(''T99'',
                                 ''T02'',
                                 ''T22'')
        AND DebitAccountID NOT LIKE ''133%'') AS CreditAccountID,

     (SELECT TOP 1 ObjectID
      FROM at9000 WITH(NOLOCK)
      WHERE DivisionID = AT0321.DivisionID
        AND BatchID = AT0321.POCTransactionID
        AND VoucherID = AT0321.POCVoucherID
        AND TransactionTypeID IN(''T99'',
                                 ''T02'',
                                 ''T22'')
        AND DebitAccountID NOT LIKE ''133%'') AS ObjectID,
          NULL AS TDescription,
          NULL AS VDescription,
          AT01.BaseCurrencyID,
          ISNULL(AT14.ExchangeRate, 0) AS ExchangeRate,
          SUM(ISNULL(AT0321.ExpenseConvertedAmount, 0)) AS OriginalAmount,
          SUM(ISNULL(AT0321.ExpenseConvertedAmount, 0)) AS ConvertedAmount
   FROM AT0321 WITH(NOLOCK)
   INNER JOIN AT9000 AT90 WITH(NOLOCK) ON AT90.DivisionID = AT0321.DivisionID
   AND AT90.VoucherID = AT0321.POVoucherID
   AND AT90.TransactionID = AT0321.POTransactionID
   AND AT90.TransactionTypeID = ''T03''
   LEFT JOIN AT1101 AT01 WITH(NOLOCK) ON AT01.DivisionID = AT0321.DivisionID
   LEFT JOIN AT1004 AT14 WITH(NOLOCK) ON AT14.CurrencyID = AT01.BaseCurrencyID
   WHERE AT0321.DivisionID = ''' + @DivisionID + '''
     AND AT0321.[Check] = 1
     AND AT0321.VoucherID = ''' + @VoucherID + '''
   GROUP BY AT0321.VoucherID,
            AT0321.POVoucherID,
            AT90.DebitAccountID,
            AT14.ExchangeRate,
            AT01.BaseCurrencyID,
            AT0321.DivisionID,
            AT0321.POCTransactionID,
            AT0321.POCVoucherID) A
LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A.ObjectID = AT1202.objectID
GROUP BY VoucherID,
         POVoucherID,
         DebitAccountID,
         CreditAccountID,
         A.ObjectID,
         ObjectName,
         [Address],
         TDescription,
         VDescription,
         BaseCurrencyID,
         ExchangeRate;'


EXEC (@sSQL)
--PRINT(@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
