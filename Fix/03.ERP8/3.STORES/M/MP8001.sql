IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan
--Date 18/11/2003
--Purpose:Tinh chi phi do dang dau ky cho DT THCP
-- Modified by Tiểu Mai on 12/01/2016: Bổ sung trường hợp thiết lập quản lý mặt hàng theo quy cách.
-- Modified by Kim Thư on 21/12/2018: Bổ sung @UserID để đưa vào MT1613 -> không load màn hình MF0009 -> cải tiến tốc độ

CREATE PROCEDURE  [dbo].[MP8001] @DivisionID AS NVARCHAR(50), 
					@UserID AS VARCHAR(50), 
                 @PeriodID AS NVARCHAR(50), 
                 @TranMonth AS INT, 
                 @TranYear AS INT, 
                 @InProcessID AS NVARCHAR(50),
				 @VoucherNo NVARCHAR(50)
AS
DECLARE @sSQL AS VARCHAR(8000), @BeginMethodID AS tinyint

SET @BeginMethodID = (SELECT BeginMethodID FROM MT1608 WHERE InProcessID = @InProcessID And DivisionID = @DivisionID)
--print 'Chi phi DD dau ky 1'

IF @BeginMethodID = 1 ---Cap nhat bang tay
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		EXEC MP8006_QC @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @VoucherNo
	ELSE
		EXEC MP8006 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @VoucherNo	
END
IF @BeginMethodID = 2 --- Chuyen tu ky truoc
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		EXEC MP8007_QC @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @VoucherNo	
	ELSE
		EXEC MP8007 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @VoucherNo
	
END
GO


