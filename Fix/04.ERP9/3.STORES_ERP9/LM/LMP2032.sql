IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2032]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Kiểm tra số tiền thanh toán vượt quá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 30/09/2016
/*-- <Example>
	LMP2032 @DivisionID='MK',@UserID='000054', @TranMonth=8, @TranYear=2016, @XML = @XML
----*/

CREATE PROCEDURE LMP2032
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS 

CREATE TABLE #TBL_LMP2032 (VoucherID VARCHAR(50), TransactionID VARCHAR(50), PaymentAmount Decimal(28,8))

INSERT INTO #TBL_LMP2032
SELECT X.Data.query('DisburseVoucherID').value('.', 'NVARCHAR(50)') AS VoucherID,
	   X.Data.query('TransactionID').value('.', 'NVARCHAR(50)') AS TransactionID,
	  (CASE WHEN X.Data.query('PaymentAmount').value('.', 'Decimal(28,8)') = 0 THEN NULL ELSE X.Data.query('PaymentAmount').value('.', 'Decimal(28,8)') END) AS PaymentAmount
FROM @XML.nodes('//Data') AS X (Data)


SELECT DISTINCT T2.PaymentName
FROM #TBL_LMP2032 T1 WITH (NOLOCK)
INNER JOIN LMT2022 T2 WITH (NOLOCK) ON T1.VoucherID = T2.DisburseVoucherID AND T1.TransactionID = T2.TransactionID --AND T1.DivisionID = T2.DivisionID
WHERE T2.DivisionID = @DivisionID AND
T1.PaymentAmount > T2.PaymentOriginalAmount






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

