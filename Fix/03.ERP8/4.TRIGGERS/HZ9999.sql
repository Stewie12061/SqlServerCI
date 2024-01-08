IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HZ9999]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HZ9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Triger update bang khoa so HRM
-- <History>
---- Create on 03/07/2023 by Nhựt Trường:  CUSTOMIZE MEIKO - Không cho update sai ngày đầu tiên và ngày cuối cùng của tháng.


CREATE TRIGGER [dbo].[HZ9999] ON [dbo].[HT9999]
FOR UPDATE 
AS

DECLARE @CustomerName NVARCHAR(50),
		@BeginDate INT,
		@EndDate INT,
		@TranMonth INT,
		@TranYear INT
--Tao bang tam de kiem tra day co phai la khach hang MEIKO khong (CustomerName = 50)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName IN (50) --- Customize Meiko
BEGIN

	SET ROWCOUNT 0;
    SET NOCOUNT ON;

	SELECT TOP 1 
		   @BeginDate = DAY(BeginDate),
		   @EndDate = DAY(EndDate)
	FROM Inserted
	WHERE TranMonth = Month(BeginDate) AND TranYear = Year(BeginDate)

	SELECT TOP 1
		   @TranMonth = TranMonth,
		   @TranYear = TranYear
	FROM Inserted

	-- Kiểm tra: không cho update sai ngày đầu tiên và ngày cuối cùng của tháng.
	IF EXISTS( SELECT TOP 1 1 FROM Deleted WITH(NOLOCK) WHERE TranMonth = @TranMonth 
															  AND TranYear = @TranYear 
															  AND (DAY(BeginDate) <> @BeginDate OR DAY(EndDate) <> @EndDate))
	   OR ISNULL(@BeginDate,'') = ''
	   OR ISNULL(@EndDate,'') = ''
	BEGIN
		-- Update trả về nếu sai ngày đầu tiên và ngày cuối cùng của tháng.
		UPDATE HT9999 SET BeginDate = (SELECT TOP 1 BeginDate FROM Deleted WHERE TranMonth = @TranMonth AND TranYear = @TranYear),
						  EndDate   = (SELECT TOP 1 EndDate FROM Deleted WHERE TranMonth = @TranMonth AND TranYear = @TranYear)
					  WHERE TranMonth = @TranMonth AND TranYear = @TranYear
	END

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO