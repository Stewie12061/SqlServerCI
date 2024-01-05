IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22703]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22703]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Kết chuyển số dư cuối kỳ moudule WM - kế thừa từ store WP9999
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Hoài Bảo on 20/07/2022
---- Modified by: Hoài Bảo on 02/12/2022 - Cập nhật lấy kỳ kế toán lớn nhất từ bảng WT9999
---- Modified by: Hoài Bảo on 20/02/2023 - WareHouseID truyền vào theo danh sách
---- Modified by ... on ...

-- <Example>
----EXEC WMP22703 @DivisionID=N'DTI',@UserID=N'ASOFTADMIN',@WareHouseID=N'KHO_A',@TranMonth=1,@TranYear=2019

CREATE PROCEDURE WMP22703
(
    @DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@WareHouseID NVARCHAR(MAX),
    @TranMonth INT,
    @TranYear INT
)   
AS

DECLARE		@Closing TINYINT, 
			@LastMonth TINYINT,
			@LastYear INT,
			@NextMonth TINYINT,
			@NextYear INT,
			@PeriodNum TINYINT, 
			@MaxPeriod INT,
			@PeriodPresent INT
 
	SELECT @PeriodNum = PeriodNum FROM AT1101 WHERE DivisionID = @DivisionID

	IF @PeriodNum IS NULL SET @PeriodNum = 12

	--SET @LastMonth = @TranMonth % @PeriodNum - 1
	SET @LastMonth = IIF(@TranMonth = 12, 11, @TranMonth % @PeriodNum - 1)

	IF @TranMonth = 1 
		SET  @LastYear = @TranYear - 1
	ELSE
		SET @LastYear = @TranYear + @TranMonth/@PeriodNum

	SET @NextMonth = @TranMonth % @PeriodNum + 1
	SET @NextYear = @TranYear + @TranMonth/@PeriodNum

	SELECT @MaxPeriod = MAX(TranMonth + TranYear * 100) FROM WT9999
	WHERE DivisionID = @DivisionID

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	IF (@MaxPeriod < (@TranMonth + @TranYear * 100))
	BEGIN
		INSERT AT2008_QC (InventoryID, WarehouseID, TranMonth, TranYear, DivisionID, InventoryAccountID, 
				BeginQuantity, BeginAmount, DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
				EndQuantity, EndAmount, UnitPrice, CreateUserID, CreateDate)
		SELECT InventoryID, WareHouseID, @TranMonth, @TranYear, DivisionID, InventoryAccountID, 
				EndQuantity, EndAmount, 0, 0, 0, 0, EndQuantity, EndAmount, UnitPrice, @UserID, GETDATE()
		FROM AT2008_QC
		WHERE DivisionID = @DivisionID
		AND TranMonth = @TranMonth AND TranYear = @TranYear AND WareHouseID IN (SELECT Value FROM dbo.StringSplit(@WareHouseID, ','))
		AND (SELECT COUNT(*) FROM AT2008_QC T8
				WHERE T8.TranMonth = @LastMonth AND T8.TranYear = @LastYear AND T8.DivisionID = AT2008_QC.DivisionID
				AND T8.InventoryID = AT2008_QC.InventoryID AND T8.WareHouseID = AT2008_QC.WareHouseID) = 0
	END


	-- Cập nhật dữ liệu tồn kho cho các kỳ
	IF @MaxPeriod >= (@NextMonth + @NextYear * 100)
	BEGIN
		-- Xu ly ton kho sau khi khoa so
		EXEC WMP22704_QC @DivisionID, @UserID, @WareHouseID, @TranMonth, @TranYear, @NextMonth, @NextYear

		--SELECT @TranMonth = @NextMonth, @TranYear = @NextYear
		--SET @NextMonth = @TranMonth % @PeriodNum + 1
		--SET @NextYear = @TranYear + @TranMonth/@PeriodNum
	END
END
ELSE
BEGIN
	IF (@MaxPeriod < (@TranMonth + @TranYear * 100))
	BEGIN
		INSERT AT2008 (InventoryID, WarehouseID, TranMonth, TranYear, DivisionID, InventoryAccountID, 
				BeginQuantity, BeginAmount, DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
				EndQuantity, EndAmount, UnitPrice, CreateUserID, CreateDate)
		SELECT InventoryID, WareHouseID, @TranMonth, @TranYear, DivisionID, InventoryAccountID, 
				EndQuantity, EndAmount, 0, 0, 0, 0, EndQuantity, EndAmount, UnitPrice, @UserID, GETDATE()
		FROM AT2008
		WHERE DivisionID = @DivisionID
		AND TranMonth = @TranMonth AND TranYear = @TranYear AND WareHouseID = @WareHouseID
		AND (SELECT COUNT(*) FROM AT2008 T8
				WHERE T8.TranMonth = @LastMonth AND T8.TranYear = @LastYear AND T8.DivisionID = AT2008.DivisionID
				AND T8.InventoryID = AT2008.InventoryID AND T8.WareHouseID = AT2008.WareHouseID) = 0
	END

	-- Cập nhật dữ liệu tồn kho cho các kỳ
	IF @MaxPeriod >= (@NextMonth + @NextYear * 100)
	BEGIN
		-- Xu ly ton kho sau khi khoa so
		EXEC WMP22704 @DivisionID, @UserID, @WareHouseID, @TranMonth, @TranYear, @NextMonth, @NextYear

		--SELECT @TranMonth = @NextMonth, @TranYear = @NextYear
		--SET @NextMonth = @TranMonth % @PeriodNum + 1
		--SET @NextYear = @TranYear + @TranMonth/@PeriodNum
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON