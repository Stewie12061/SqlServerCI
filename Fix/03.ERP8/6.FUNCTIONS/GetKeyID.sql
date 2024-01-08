IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GetKeyID]') AND XTYPE IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].GetKeyID
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
----	Trả ra Key (Key1, Key2, Key3 tương ứng trong A003) của mã tăng tự động
-- <Return>
-- <History>
---- Create on 13/07/2020 by Lê Hoàng
CREATE FUNCTION GetKeyID(@SType INT, @TranMonth INT, @TranYear INT, @VoucherTypeID NVARCHAR(50), @DivisionID NVARCHAR(50), @S NVARCHAR(50)) 
RETURNS NVARCHAR(50)
AS 
  BEGIN 
	IF (@SType = 1)
		RETURN FORMAT(@TranMonth, '00')
	IF (@SType = 2)
        RETURN FORMAT(@TranYear, '0000')
    IF (@SType = 3)
        RETURN @VoucherTypeID
    IF (@SType = 4)
        RETURN @DivisionID
    IF (@SType = 5)
        RETURN @S
	IF (@SType <> 6)
        RETURN ''
    RETURN SUBSTRING(CONVERT(VARCHAR(10), @TranYear), 3, 2);
  END 
GO 