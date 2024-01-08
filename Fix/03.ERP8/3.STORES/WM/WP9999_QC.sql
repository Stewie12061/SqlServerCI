IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP9999_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP9999_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Khoa so ky ke toan moudule WM
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Nguyen Quoc Huy on: 23/06/2007
---- Modified by Việt Khánh on 04/08/2010
---- Modified by Bao Anh on 05/08/2012: Cap nhat du lieu cho AT2888 (so du ton kho co quy cach va so luong mark - yeu cau cua 2T)
---- Modified by Bao Anh on 17/09/2012: XL ton kho khi khoa so (cap nhat vao ton kho theo quy cach AT2888 - 2T)
---- Modified by Mai Duyen on 11/09/2014: Fix loi khoa so bi treo(KH Minh Tien), xu ly ton kho khi khoa so chi cap nhat cho ky tiep theo
---- Modify on 08/06/2015 by Bảo Anh: Lấy PeriodNum từ thông tin đơn vị AT1101
---- Modify on 10/09/2015 by Bảo Anh: Xử lý tồn kho khi khóa sổ cập nhật cho các kỳ từ kỳ tiếp theo về sau (trả lại như trước khi fix cho Minh Tiến)
---- Modified on 04/11/2015 by Tiểu Mai: Copy qua store mới khi quản lý quy cách

-- <Example>

CREATE PROCEDURE WP9999_QC
(
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @BeginDate DATETIME, 
    @EndDate DATETIME
)   
AS
DECLARE @Closing TINYINT, 
		@NextMonth TINYINT, 
		@NextYear INT, 
		@PeriodNum TINYINT, 
		@MaxPeriod INT,
		@CustomerName INT


CREATE TABLE #CustomerName (CustomerName INT, ImportExcel INT)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)		
 
SELECT @PeriodNum = PeriodNum FROM AT1101 ---AT0001

IF @PeriodNum IS NULL SET @PeriodNum = 12

SET @NextMonth = @TranMonth % @PeriodNum + 1
SET @NextYear = @TranYear + @TranMonth/@PeriodNum

SELECT @Closing = Closing FROM WT9999
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear
        
SELECT @MaxPeriod = MAX(TranMonth + TranYear * 100) FROM WT9999
WHERE DivisionID = @DivisionID

IF @Closing <> 1 
BEGIN       
    UPDATE WT9999 SET Closing = 1 WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear
	IF @MaxPeriod < (@NextMonth + @NextYear * 100)
        BEGIN
            INSERT WT9999 (TranMonth, TranYear, DivisionID, Closing, BeginDate, EndDate, [Disabled]) 
            VALUES (@NextMonth, @NextYear, @DivisionID, 0, @BeginDate, @EndDate, 0)
            
            IF EXISTS (SELECT 1 FROM WT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID)
			    UPDATE WT0000 SET DefTranMonth = @NextMonth, DefTranYear = @NextYear
		  
---- Insert tồn đầu tháng mới khi quản lý hàng theo quy cách.			
			INSERT AT2008_QC (APK, InventoryID, WarehouseID, TranMonth, TranYear, DivisionID, InventoryAccountID, 
                    BeginQuantity, BeginAmount, DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
                    EndQuantity, EndAmount, UnitPrice, S01ID, S02ID, S03ID, S04ID,
                    S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID,
                    S16ID, S17ID, S18ID, S19ID, S20ID)
			SELECT NEWID(), InventoryID, WareHouseID, @NextMonth, @NextYear, DivisionID, InventoryAccountID, 
                    EndQuantity, EndAmount, 0, 0, 0, 0, 
                    EndQuantity, EndAmount, UnitPrice, S01ID, S02ID, S03ID, S04ID,
                    S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID,
                    S16ID, S17ID, S18ID, S19ID, S20ID
			FROM AT2008_QC 
			WHERE DivisionID = @DivisionID
				AND TranMonth = @TranMonth AND TranYear = @TranYear
				AND (SELECT COUNT(*) FROM AT2008_QC T8
						WHERE T8.TranMonth = @NextMonth AND T8.TranYear = @NextYear AND T8.DivisionID = AT2008_QC.DivisionID
						AND T8.InventoryID = AT2008_QC.InventoryID AND T8.WareHouseID = AT2008_QC.WareHouseID AND
						ISNULL(T8.S01ID,'') = Isnull(AT2008_QC.S01ID,'') AND 
						ISNULL(T8.S02ID,'') = isnull(AT2008_QC.S02ID,'') AND
						ISNULL(T8.S03ID,'') = isnull(AT2008_QC.S03ID,'') AND
						ISNULL(T8.S04ID,'') = isnull(AT2008_QC.S04ID,'') AND
						ISNULL(T8.S05ID,'') = isnull(AT2008_QC.S05ID,'') AND 
						ISNULL(T8.S06ID,'') = isnull(AT2008_QC.S06ID,'') AND
						ISNULL(T8.S07ID,'') = isnull(AT2008_QC.S07ID,'') AND
						ISNULL(T8.S08ID,'') = isnull(AT2008_QC.S08ID,'') AND
						ISNULL(T8.S09ID,'') = isnull(AT2008_QC.S09ID,'') AND
						ISNULL(T8.S10ID,'') = isnull(AT2008_QC.S10ID,'') AND
						ISNULL(T8.S11ID,'') = isnull(AT2008_QC.S11ID,'') AND 
						ISNULL(T8.S12ID,'') = isnull(AT2008_QC.S12ID,'') AND
						ISNULL(T8.S13ID,'') = isnull(AT2008_QC.S13ID,'') AND
						ISNULL(T8.S14ID,'') = isnull(AT2008_QC.S14ID,'') AND
						ISNULL(T8.S15ID,'') = isnull(AT2008_QC.S15ID,'') AND
						ISNULL(T8.S16ID,'') = isnull(AT2008_QC.S16ID,'') AND
						ISNULL(T8.S17ID,'') = isnull(AT2008_QC.S17ID,'') AND
						ISNULL(T8.S18ID,'') = isnull(AT2008_QC.S18ID,'') AND
						ISNULL(T8.S19ID,'') = isnull(AT2008_QC.S19ID,'') AND
						ISNULL(T8.S20ID,'') = isnull(AT2008_QC.S20ID,'')) = 0
			
        END
       
        IF @MaxPeriod >= (@NextMonth + @NextYear * 100)
           UPDATE WT9999 SET BeginDate = @BeginDate, EndDate = @EndDate
           WHERE DivisionID = @DivisionID AND TranMonth = @NextMonth AND TranYear = @NextYear

		        While    @MaxPeriod >= (@NextMonth + @NextYear * 100)
		        BEGIN
		            --- Xử lý tồn kho sau khi khóa sổ (quản lý quy cách hàng hóa).
					EXEC  AP9998_QC @DivisionID, @TranMonth, @TranYear, @NextMonth, @NextYear
			
					SELECT @TranMonth = @NextMonth, @TranYear = @NextYear
					SET @NextMonth = @TranMonth % @PeriodNum + 1
					SET @NextYear = @TranYear + @TranMonth/@PeriodNum
		        END
    END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
