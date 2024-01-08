IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GetPartVoucherNo]') AND XTYPE IN (N'FN', N'IF', N'TF')) DROP FUNCTION [GetPartVoucherNo]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy giá trị theo phân loại của Loại chứng từ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by Vĩnh Tâm on 08/06/2020
---- Modified by Trọng Kiên on 07/09/2020: Bổ sung đọc dữ liệu cho module CRM
---- Modified by Hoài Bảo on 07/12/2021: Bổ sung đọc dữ liệu cho module OO, CRM, SO, PO, HRM
---- Modified by Hoài Bảo on 24/11/2022: Bổ sung đọc dữ liệu cho module WM
---- Modified by Anh Đô on 21/03/2023: Fix lỗi không lấy được kỳ mới nhất module PO
/* <Example>
 
 SELECT dbo.GetPartVoucherNo('DTI', 'BEM', 'DN', 'DN', 1)
 */
CREATE FUNCTION dbo.GetPartVoucherNo
(
    @DivisionID VARCHAR(50),
    @ModuleID VARCHAR(50),
    @VoucherType VARCHAR(50),        -- Loại chứng từ
    @DefaultString VARCHAR(50),      -- Chuỗi mặc định
    @Type INT                        -- Loại thiết lập sinh mã chứng từ
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result VARCHAR(50),
            @TranMonth VARCHAR(50) = '0',
            @TranYear VARCHAR(50) = '0'

    IF @ModuleID = 'BEM'
    BEGIN
        SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM BEMT9999 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID AND ISNULL(Closing, 0) = 0
    END

    IF @ModuleID = 'CRM'
    BEGIN
        SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM CRMT00000 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID
    END

	IF @ModuleID = 'OO'
    BEGIN
        SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM OOT9999 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID
		ORDER BY TranYear DESC, TranMonth
    END

	IF (@ModuleID = 'SO' OR @ModuleID = 'PO')
    BEGIN
        SELECT TOP 1 @TranMonth = TranMonth, @TranYear = TranYear FROM OT9999 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID AND ISNULL(Closing, 0) = 0
		ORDER BY TranYear DESC, TranMonth DESC
    END

	IF @ModuleID = 'HRM'
	BEGIN
        SELECT TOP 1 @TranMonth = TranMonth, @TranYear = TranYear FROM HT9999 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID AND ISNULL(Closing, 0) = 0
		ORDER BY TranYear DESC, TranMonth
    END

	IF @ModuleID = 'WM'
	BEGIN
        SELECT TOP 1 @TranMonth = TranMonth, @TranYear = TranYear FROM WT9999 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID AND ISNULL(Closing, 0) = 0
		ORDER BY TranYear DESC, TranMonth
    END

    -- Trả về kết quả theo thiết lập
    SELECT @Result = 
        CASE @Type
            -- Month (MM)
            WHEN 1    THEN RIGHT('00' + @TranMonth, 2)

            -- Year (YYYY)
            WHEN 2    THEN @TranYear

            -- VoucherType
            WHEN 3    THEN @VoucherType

            -- DivisionID
            WHEN 4    THEN @DivisionID

            -- Default String
            WHEN 5    THEN @DefaultString

            -- Short year (YY)
            WHEN 6    THEN RIGHT('00' + @TranYear, 2)

            ELSE ''
        END

    RETURN @Result
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
