IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2007]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kiểm tra số tiền vay/ bảo lãnh so với hạn mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 23/01/2018 by Phương Thảo
----Modify on
-- <Example>
/*  
 EXEC LMP2006 @DivisionID = 'AS',@UserID = 'ASOFTADMIN', @XML=''
*/
----
CREATE PROCEDURE [LMP2007]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@OriginalAmount Decimal(28,8),	
	@VoucherID NVARCHAR(50),
	@LimitVoucherID NVARCHAR(50),
	@FormID Varchar(50)	= 'LMF2001'
) 
AS


IF EXISTS (
SELECT TOP 1 1
FROM LMT1010 T1 WITH (NOLOCK)
LEFT JOIN 
(SELECT DivisionID, LimitVoucherID, SUM(OriginalAmount) AS OriginalAmount
FROM LMT2001 WITH (NOLOCK)  
WHERE VoucherID <> @VoucherID
GROUP BY DivisionID, LimitVoucherID
)T2 ON T1.VoucherID = T2.LimitVoucherID AND T1.DivisionID = T2.DivisionID
LEFT JOIN 
(SELECT DivisionID, LimitVoucherID, SUM(OriginalAmount) AS OriginalAmount
FROM LMT2051 WITH (NOLOCK)
WHERE VoucherID <> @VoucherID
GROUP BY DivisionID, LimitVoucherID
)T3 ON T1.VoucherID = T3.LimitVoucherID AND T1.DivisionID = T3.DivisionID 
WHERE T1.DivisionID = @DivisionID AND T1.VoucherID = @LimitVoucherID 
AND T1.OriginalLimitTotal - T2.OriginalAmount - T3.OriginalAmount  - @OriginalAmount < 0 )
BEGIN 
	SELECT 1 As Status
END
ELSE 
	SELECT 0 AS Status	

--IF (@FormID = 'LMF2001')
--BEGIN
--	SELECT @SumOAmount = SUM(OriginalAmount)
--	FROM LMT2001
--	WHERE DivisionID = @DivisionID AND LimitVoucherID = @LimitVoucherID AND VoucherID <> @VoucherID
--	select @OriginalAmount, @SumOAmount
--	IF @OriginalAmount < @SumOAmount
--		SELECT 1 As Status
--END
--ELSE
--IF (@FormID = 'LMF2051')
--BEGIN
--	SELECT @SumOAmount = SUM(OriginalAmount)
--	FROM LMT2051
--	WHERE DivisionID = @DivisionID AND LimitVoucherID = @LimitVoucherID AND VoucherID <> @VoucherID

--	IF @OriginalAmount < @SumOAmount 
--		SELECT 1 As Status
--END
--ELSE
--BEGIN
--	SELECT 0 AS Status	
--END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

