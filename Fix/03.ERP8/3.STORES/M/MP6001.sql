IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[MP6001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP6001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created BY Hoang Thi Lan
--Date 6/12/2003
--Purpose:Phan bo chi phi cho  doi tuong (Theo chi phi cau thanh)
--Edit BY: Vo THanh Huong, date: 18/4/2006
--Edit BY: Dang Le Bao Quynh, Date: 29/05/2008
--Purpose: Sua lai cach thuc xu ly lam tron
/********************************************
'* Edited BY: [GS] [Việt Khánh] [03/08/2010]
'********************************************/
--- Modified by Tiểu Mai on 31/12/2015: Bổ sung lưu thông tin quy cách NVL vào MT8899
--- Modify on 26/05/2016 by Bảo Anh: Lấy loại tiền từ AT1101 do đã chuyển thiết lập sang Đơn vị
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK), tách thông tin quy cách
--- Modified by Tiểu Mai on 26/10/2016: Fix bug phân bổ chưa đúng
--- Modified by Phương Thảo on 26/10/2016: Chỉnh sửa đoạn làm tròn (lấy ra dòng dữ liệu có số tiền/sl lớn nhất)
--- Modified on 17/08/2018 by Bảo Anh: Cập nhật giá trị bộ hệ số cho các đối tượng THCP con dựa trên KQSX (Ngọc Tề)

CREATE PROCEDURE [dbo].[MP6001]     
    @DivisionID NVARCHAR(50), 
    @PeriodID NVARCHAR(50), 
    @CoefficientID NVARCHAR(50), 
    @CMonth INT, 
    @CYear INT, 
    @VoucherID NVARCHAR(50), 
    @BatchID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT
AS 

DECLARE 
    @sSQL NVARCHAR(4000), 
    @SumCovalue DECIMAL(28, 8), 
    @ChildPeriodID_Cur CURSOR, 
    @ChildPeriodID NVARCHAR(50), 
    @ConvertedAmount DECIMAL(28, 8), 
    @PeriodConv DECIMAL(28, 8), 
    @ChildConv DECIMAL(28, 8), 
    @ExpenseID NVARCHAR(50), 
    @MaterialTypeID NVARCHAR(50), 
    @TransactionID NVARCHAR(50), 
    @Covalue DECIMAL(28, 8), 
    @PeriodID_Cur CURSOR, 
    @ConvertedDecimal DECIMAL(28, 8), 
    @DebitAccountID NVARCHAR(50), 
    @CreditAccountID NVARCHAR(50), 
    @Quantity DECIMAL(28, 8), 
    @ChildQConv DECIMAL(28, 8), 
    @InventoryID NVARCHAR(50), 
    @CurrencyID NVARCHAR(50), 
    @ExchangeRate DECIMAL(28, 8),
    @S01ID NVARCHAR(50),
    @S02ID NVARCHAR(50),
    @S03ID NVARCHAR(50),
    @S04ID NVARCHAR(50),
    @S05ID NVARCHAR(50),
    @S06ID NVARCHAR(50),
    @S07ID NVARCHAR(50),
    @S08ID NVARCHAR(50),
    @S09ID NVARCHAR(50),
    @S10ID NVARCHAR(50),
    @S11ID NVARCHAR(50),
    @S12ID NVARCHAR(50),
    @S13ID NVARCHAR(50),
    @S14ID NVARCHAR(50),
    @S15ID NVARCHAR(50),
    @S16ID NVARCHAR(50),
    @S17ID NVARCHAR(50),
    @S18ID NVARCHAR(50),
    @S19ID NVARCHAR(50),
    @S20ID NVARCHAR(50)

SELECT @ConvertedDecimal = ConvertDecimal FROM MT0000 WITH (NOLOCK) WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
SET @ConvertedDecimal = ISNULL(@ConvertedDecimal, 2)

SET @CurrencyID = ISNULL((SELECT TOP 1 BaseCurrencyID FROM AT1101 WITH (NOLOCK) WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))), 'VND')
SET @ExchangeRate = 1

--- Customize Ngọc Tề: Cập nhật giá trị bộ hệ số cho các đối tượng THCP con dựa trên KQSX
IF (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK)) = 2
BEGIN
	EXEC MP10011 @DivisionID, @TranMonth, @TranYear, @PeriodID
END

--Lay tung he so
SET @SumCovalue = (SELECT SUM(Covalue) FROM MT1607 WITH (NOLOCK) WHERE CoefficientID = @CoefficientID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

--Lay he so theo doi tuong
SET @ChildPeriodID_Cur = CURSOR SCROLL KEYSET FOR 
SELECT PeriodID, Covalue 
FROM MT1607 WITH (NOLOCK)
WHERE CoefficientID = @CoefficientID 
AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))

OPEN @ChildPeriodID_Cur
FETCH NEXT FROM @ChildPeriodID_Cur INTO @ChildPeriodID, @CoValue
            
WHILE @@Fetch_Status = 0
BEGIN
    --Lay tong tien cua doi tuong cha
    SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT 
	SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount,0) ELSE -ISNULL(ConvertedAmount,0) END)  AS ConvertedAmount, 
    --SUM( Case D_C  when  'D' then ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END) AS MaterialQuantity
	--SUM(ConvertedAmount) AS ConvertedAmount, 
    MaterialTypeID, AccountID AS DebitAccountID, CorAccountID AS CreditAccountID
    FROM MV9000
    WHERE PeriodID = @PeriodID AND ExpenseID = 'COST003' AND ISNULL(MaterialTypeID, '') <> ''
        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
    GROUP BY MaterialTypeID, AccountID, CorAccountID

    OPEN @PeriodID_Cur
    FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @MaterialTypeID, @DebitAccountID, @CreditAccountID
    WHILE @@Fetch_Status = 0
        BEGIN
            IF (@SumCovalue<>0)
                BEGIN
                    SET @ChildConv = (ISNULL(@ConvertedAmount, 0) * ISNULL(@Covalue, 0))/@SumCovalue
                    SET @ChildQConv = (ISNULL(@Quantity, 0) * ISNULL(@Covalue, 0))/@SumCovalue
                END
            ELSE  
                BEGIN
                    SET @ChildConv = 0 
                    SET @ChildQConv = 0 
                END

            SET @ChildConv = ROUND(@ChildConv, @ConvertedDecimal) 
            SET @ChildQConv = ROUND(@ChildQConv, @ConvertedDecimal) 

            EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT9000', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

            INSERT MT9000 (ParentPeriodID, VoucherID, BatchID, DivisionID, TransactionID, ExpenseID, MaterialTypeID, OriginalAmount, ConvertedAmount, PeriodID, Status, CreateDate, IsFromPeriodID, DebitAccountID, CreditAccountID, TransactiontypeID, TranMonth, TranYear, Quantity, InventoryID, CurrencyID, ExchangeRate)
            VALUES (@PeriodID, @VoucherID, @BatchID, @DivisionID, @TransactionID, 'COST003', @MaterialTypeID, @ChildConv, @ChildConv, @ChildPeriodID, 0, GETDATE(), 1, @DebitAccountID, @CreditAccountID, ' ', @TranMonth, @TranYear, @ChildQConv, @InventoryID, @CurrencyID, @ExchangeRate)
                
            FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @MaterialTypeID, @DebitAccountID, @CreditAccountID

        END
    CLOSE @PeriodID_Cur
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Phan bo chi phi nhan cong
--Lay tong tien cua doi tuong cha

    SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT 
	 SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END)  AS ConvertedAmount, 
     SUM( Case D_C  when  'D' then ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END) AS Quantity, 
	--SUM(ConvertedAmount) AS ConvertedAmount, SUM(ISNULL(Quantity, 0)) AS Quantity,
    MaterialTypeID, AccountID AS DebitAccountID, CorAccountID AS CreditAccountID
    FROM MV9000
    WHERE PeriodID = @PeriodID AND ExpenseID = 'COST002' AND ISNULL(MaterialTypeID, '') <> ''
        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
    GROUP BY MaterialTypeID, AccountID, CorAccountID

    OPEN @PeriodID_Cur
    FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @Quantity, @MaterialTypeID, @DebitAccountID, @CreditAccountID
    WHILE @@Fetch_Status = 0
        BEGIN
            IF (@SumCovalue<>0)
                BEGIN
                    SET @ChildConv = (ISNULL(@ConvertedAmount, 0) * ISNULL(@Covalue, 0))/@SumCovalue
                    SET @ChildQConv = (ISNULL(@Quantity, 0) * ISNULL(@Covalue, 0))/@SumCovalue
                END
            ELSE 
                BEGIN
                    SET @ChildConv = 0 
                    SET @ChildQConv = 0 
                END

            SET @ChildConv = ROUND(@ChildConv, @ConvertedDecimal) 
            SET @ChildQConv = ROUND(@ChildQConv, @ConvertedDecimal) 



            EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT9000', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

            INSERT MT9000 (ParentPeriodID, VoucherID, BatchID, DivisionID, TransactionID, ExpenseID, MaterialTypeID, OriginalAmount, ConvertedAmount, PeriodID, Status, CreateDate, IsFromPeriodID, DebitAccountID, CreditAccountID, transactiontypeID, TranMonth, TranYear, Quantity, CurrencyID, ExchangeRate)
            VALUES (@PeriodID, @VoucherID, @BatchID, @DivisionID, @TransactionID, 'COST002', @MaterialTypeID, @ChildConv, @ChildConv, @ChildPeriodID, 0, GETDATE(), 1, @DebitAccountID, @CreditAccountID, ' ', @TranMonth, @TranYear, @ChildQConv, @CurrencyID, @ExchangeRate)
            
            FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @Quantity, @MaterialTypeID, @DebitAccountID, @CreditAccountID
        END
    CLOSE @PeriodID_Cur

---- Phan bo chi phi NVL
---- Lay tong tien cua doi tuong cha
    SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR 
    SELECT 
	SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END)  AS ConvertedAmount, 
	SUM( Case D_C  when  'D' then ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END) AS Quantity, 
	--SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, SUM(ISNULL(Quantity, 0)) AS Quantity,
    MaterialTypeID, InventoryID, AccountID AS DebitAccountID, CorAccountID AS CreditAccountID,
    S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
    S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
    FROM MV9000
    WHERE PeriodID = @PeriodID AND ExpenseID = 'COST001' AND ISNULL(MaterialTypeID, '')<>''
        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
    GROUP BY MaterialTypeID, InventoryID, AccountID, CorAccountID,
    S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
    S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID

    OPEN @PeriodID_Cur
    FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @Quantity, @MaterialTypeID, @InventoryID, @DebitAccountID, @CreditAccountID,
    @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
    @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID 

    WHILE @@Fetch_Status = 0
    BEGIN
        SET @TranMonth = (SELECT distinct TranMonth FROM MV9000 WHERE PeriodID = @PeriodID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND ExpenseID = 'COST001')
        SET @TranYear = (SELECT distinct TranYear FROM MV9000 WHERE PeriodID = @PeriodID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) AND ExpenseID = 'COST001')

        IF (@SumCovalue<>0)
            BEGIN
                SET @ChildConv = (ISNULL(@ConvertedAmount, 0) * ISNULL(@Covalue, 0))/@SumCovalue
                SET @ChildQConv = (ISNULL(@Quantity, 0) * ISNULL(@Covalue, 0))/@SumCovalue
            END
        ELSE 
            BEGIN
                SET @ChildConv = 0 
                SET @ChildQConv = 0 
            END

        SET @ChildConv = ROUND(@ChildConv, @ConvertedDecimal) 
        SET @ChildQConv = ROUND(@ChildQConv, @ConvertedDecimal) 

        EXEC AP0000 @DivisionID, @TransactionID  OUTPUT, 'MT9000', 'IT', @CMonth, @CYear, 18, 3, 0, '-'

        INSERT MT9000 (ParentPeriodID, VoucherID, BatchID, DivisionID, TransactionID, ExpenseID, MaterialTypeID, OriginalAmount, ConvertedAmount, PeriodID, Status, CreateDate, IsFromPeriodID, DebitAccountID, CreditAccountID, TransactiontypeID, TranMonth, TranYear, Quantity, InventoryID, CurrencyID, ExchangeRate)
        VALUES (@PeriodID, @VoucherID, @BatchID, @DivisionID, @TransactionID, 'COST001', @MaterialTypeID, @ChildConv, @ChildConv, @ChildPeriodID, 0, GETDATE(), 1, @DebitAccountID, @CreditAccountID, ' ', @TranMonth, @TranYear, @ChildQConv, @InventoryID, @CurrencyID, @ExchangeRate)
		
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
			INSERT MT8899 (DivisionID, TransactionID, TableID, VoucherID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
				S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
			VALUES (@DivisionID, @TransactionID, 'MT9000', @VoucherID, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
				@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID )
				
        FETCH NEXT FROM @PeriodID_Cur INTO @ConvertedAmount, @Quantity, @MaterialTypeID, @InventoryID, @DebitAccountID, @CreditAccountID,
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID 
    END
    CLOSE @PeriodID_Cur

    FETCH NEXT FROM @ChildPeriodID_Cur INTO @ChildPeriodID, @Covalue
END
CLOSE @ChildPeriodID_Cur

------------------------------------------------------------------------------------------------------------------
--- Add BY: Vo Thanh Huong
--- Xu ly chenh lech 
--- Edit BY: Dang Le Bao Quynh; Date 03/08/2007
--- Không c?n ph?i x? lý -ConvertedAmount khi but toan phat sinh Co TK chi phi

DECLARE 
    @Delta_Converted DECIMAL(28, 8), 
    @Delta_Quantity DECIMAL(28, 8), 
    @ID NVARCHAR(50), 
    @MaterialID NVARCHAR(50)
-----------Nhan cong & SXC
SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR
SELECT 
    MaterialTypeID, 
    SUM(CASE WHEN D_C = 'D' THEN ISNULL(ConvertedAmount, 0) ELSE -ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount, 
    SUM(CASE WHEN D_C = 'D' THEN ISNULL(Quantity, 0) ELSE -ISNULL(Quantity, 0) END) AS Quantity, 
    AccountID AS DebitAccountID, 
    CorAccountID AS CreditAccountID
FROM MV9000
WHERE PeriodID = @PeriodID AND ExpenseID <> 'COST001' AND ISNULL(MaterialTypeID, '') <> ''
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
GROUP BY MaterialTypeID, AccountID, CorAccountID

OPEN @PeriodID_Cur
FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Delta_Converted = @ConvertedAmount - (SELECT SUM(ISNULL(ConvertedAmount, 0)) 
                                                    FROM MT9000 WITH (NOLOCK)
                                                    WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
                                                        AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
                                                        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))) 

        SET @Delta_Quantity = @Quantity - (SELECT SUM(ISNULL(Quantity, 0)) 
                                            FROM MT9000 WITH (NOLOCK)
                                            WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
                                                AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
                                                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))
        IF @Delta_Converted <> 0
            BEGIN
                SET @ID = NULL
                SELECT top 1 @ID = TransactionID FROM MT9000 WITH (NOLOCK)
                WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
                    AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
                    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                ORDER BY ConvertedAmount DESC

                IF @ID IS NOT NULL 
                    UPDATE MT9000 SET OriginalAmount = OriginalAmount + @Delta_Converted, ConvertedAmount = ConvertedAmount + @Delta_Converted
                    WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
            END    
        

        IF @Delta_Quantity <> 0
            BEGIN
                SET @ID = NULL
                SELECT top 1 @ID = TransactionID FROM MT9000 WITH (NOLOCK)
                WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
                    AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
                    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                ORDER BY Quantity DESC

                IF @ID IS NOT NULL 
                    UPDATE MT9000 SET Quantity = Quantity + @Delta_Quantity
                    WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
            END    

        FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID
    END
CLOSE @PeriodID_Cur


------NVL truc tiep
------ Quan ly theo quy cach
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR
	SELECT 
		MaterialTypeID, 
		InventoryID, 
		SUM(CASE WHEN D_C = 'D' THEN ISNULL(ConvertedAmount, 0) ELSE -ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount, 
		SUM(CASE WHEN D_C = 'D' THEN ISNULL(Quantity, 0) ELSE -ISNULL(Quantity, 0) END) AS Quantity, 
		AccountID AS DebitAccountID, CorAccountID AS CreditAccountID,
		S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
	FROM MV9000
	WHERE PeriodID = @PeriodID AND ExpenseID = 'COST001' AND ISNULL(MaterialTypeID, '') <> ''
		AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
	GROUP BY MaterialTypeID, InventoryID, AccountID, CorAccountID,
		S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 

	OPEN @PeriodID_Cur
	FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @MaterialID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID,
			@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Delta_Converted = @ConvertedAmount - (SELECT SUM(ISNULL(ConvertedAmount, 0)) FROM MT9000 WITH (NOLOCK)
														LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT9000.DivisionID AND O99.VoucherID = MT9000.VoucherID AND O99.TransactionID = MT9000.TransactionID
														WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
															AND InventoryID = @MaterialID AND DebitAccountID = @DebitAccountID 
															AND CreditAccountID = @CreditAccountID
															AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
															AND ISNULL(S01ID,'') = ISNULL(@S01ID,'')
															AND ISNULL(S02ID,'') = ISNULL(@S02ID,'')
															AND ISNULL(S03ID,'') = ISNULL(@S03ID,'')
															AND ISNULL(S04ID,'') = ISNULL(@S04ID,'')
															AND ISNULL(S05ID,'') = ISNULL(@S05ID,'')
															AND ISNULL(S06ID,'') = ISNULL(@S06ID,'')
															AND ISNULL(S07ID,'') = ISNULL(@S07ID,'')
															AND ISNULL(S08ID,'') = ISNULL(@S08ID,'')
															AND ISNULL(S09ID,'') = ISNULL(@S09ID,'')
															AND ISNULL(S10ID,'') = ISNULL(@S10ID,'')
															AND ISNULL(S11ID,'') = ISNULL(@S11ID,'')
															AND ISNULL(S12ID,'') = ISNULL(@S12ID,'')
															AND ISNULL(S13ID,'') = ISNULL(@S13ID,'')
															AND ISNULL(S14ID,'') = ISNULL(@S14ID,'')
															AND ISNULL(S15ID,'') = ISNULL(@S15ID,'')
															AND ISNULL(S16ID,'') = ISNULL(@S16ID,'')
															AND ISNULL(S17ID,'') = ISNULL(@S17ID,'')
															AND ISNULL(S18ID,'') = ISNULL(@S18ID,'')
															AND ISNULL(S19ID,'') = ISNULL(@S19ID,'')
															AND ISNULL(S20ID,'') = ISNULL(@S20ID,''))


			SET @Delta_Quantity = @Quantity - (SELECT SUM(ISNULL(Quantity, 0)) FROM MT9000 WITH (NOLOCK)
												LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT9000.DivisionID AND O99.VoucherID = MT9000.VoucherID AND O99.TransactionID = MT9000.TransactionID
												WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
													AND InventoryID = @MaterialID AND DebitAccountID = @DebitAccountID 
													AND CreditAccountID = @CreditAccountID
													AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
													AND ISNULL(S01ID,'') = ISNULL(@S01ID,'')
													AND ISNULL(S02ID,'') = ISNULL(@S02ID,'')
													AND ISNULL(S03ID,'') = ISNULL(@S03ID,'')
													AND ISNULL(S04ID,'') = ISNULL(@S04ID,'')
													AND ISNULL(S05ID,'') = ISNULL(@S05ID,'')
													AND ISNULL(S06ID,'') = ISNULL(@S06ID,'')
													AND ISNULL(S07ID,'') = ISNULL(@S07ID,'')
													AND ISNULL(S08ID,'') = ISNULL(@S08ID,'')
													AND ISNULL(S09ID,'') = ISNULL(@S09ID,'')
													AND ISNULL(S10ID,'') = ISNULL(@S10ID,'')
													AND ISNULL(S11ID,'') = ISNULL(@S11ID,'')
													AND ISNULL(S12ID,'') = ISNULL(@S12ID,'')
													AND ISNULL(S13ID,'') = ISNULL(@S13ID,'')
													AND ISNULL(S14ID,'') = ISNULL(@S14ID,'')
													AND ISNULL(S15ID,'') = ISNULL(@S15ID,'')
													AND ISNULL(S16ID,'') = ISNULL(@S16ID,'')
													AND ISNULL(S17ID,'') = ISNULL(@S17ID,'')
													AND ISNULL(S18ID,'') = ISNULL(@S18ID,'')
													AND ISNULL(S19ID,'') = ISNULL(@S19ID,'')
													AND ISNULL(S20ID,'') = ISNULL(@S20ID,''))
			IF @Delta_Converted <> 0
				BEGIN
					SET @ID = NULL
					SELECT top 1 @ID =  MT9000.TransactionID FROM MT9000 WITH (NOLOCK)
					LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT9000.DivisionID AND O99.VoucherID = MT9000.VoucherID AND O99.TransactionID = MT9000.TransactionID
						WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID AND InventoryID = @MaterialID 
							AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
							AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
						ORDER BY ConvertedAmount DESC

					IF @ID IS NOT NULL  
						UPDATE MT9000 SET OriginalAmount = OriginalAmount + @Delta_Converted, ConvertedAmount = ConvertedAmount + @Delta_Converted 
						WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				END    
			---
			IF @Delta_Quantity <> 0
				BEGIN
					SET @ID = NULL
					SELECT top 1 @ID = TransactionID FROM MT9000 WITH (NOLOCK)
						WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID AND InventoryID = @MaterialID 
							AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
							AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
						ORDER BY Quantity DESC

					IF @ID IS NOT NULL 
						UPDATE MT9000 SET Quantity = Quantity + @Delta_Quantity
						WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				END    

			FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @MaterialID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID,
				@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
				@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID 
		END
	CLOSE @PeriodID_Cur	
END
-------<<<<--------- Quan ly theo quy cach
ELSE
BEGIN
	SET @PeriodID_Cur = CURSOR SCROLL KEYSET FOR
	SELECT 
		MaterialTypeID, 
		InventoryID, 
		SUM(CASE WHEN D_C = 'D' THEN ISNULL(ConvertedAmount, 0) ELSE -ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount, 
		SUM(CASE WHEN D_C = 'D' THEN ISNULL(Quantity, 0) ELSE -ISNULL(Quantity, 0) END) AS Quantity, 
		AccountID AS DebitAccountID, CorAccountID AS CreditAccountID
	FROM MV9000
	WHERE PeriodID = @PeriodID AND ExpenseID = 'COST001' AND ISNULL(MaterialTypeID, '') <> ''
		AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 
	GROUP BY MaterialTypeID, InventoryID, AccountID, CorAccountID

	OPEN @PeriodID_Cur
	FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @MaterialID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Delta_Converted = @ConvertedAmount - (SELECT SUM(ISNULL(ConvertedAmount, 0)) FROM MT9000 WITH (NOLOCK)
														WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
															AND InventoryID = @MaterialID AND DebitAccountID = @DebitAccountID 
															AND CreditAccountID = @CreditAccountID
															AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

			SET @Delta_Quantity = @Quantity - (SELECT SUM(ISNULL(Quantity, 0)) FROM MT9000 WITH (NOLOCK)
			                                   WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID 
													AND InventoryID = @MaterialID AND DebitAccountID = @DebitAccountID 
													AND CreditAccountID = @CreditAccountID
													AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))
			IF @Delta_Converted <> 0
				BEGIN
					SET @ID = NULL
					SELECT top 1 @ID = MT9000.TransactionID FROM MT9000 WITH (NOLOCK)
						WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID AND InventoryID = @MaterialID 
							AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
							AND MT9000.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
						ORDER BY ConvertedAmount DESC

					IF @ID IS NOT NULL  
						UPDATE MT9000 SET OriginalAmount = OriginalAmount + @Delta_Converted, ConvertedAmount = ConvertedAmount + @Delta_Converted 
						WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				END    
			---
			IF @Delta_Quantity <> 0
				BEGIN
					SET @ID = NULL
					SELECT top 1 @ID = TransactionID FROM MT9000 WITH (NOLOCK)
						WHERE ParentPeriodID = @PeriodID AND MaterialTypeID = @MaterialTypeID AND InventoryID = @MaterialID 
							AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
							AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
						ORDER BY Quantity DESC

					IF @ID IS NOT NULL 
						UPDATE MT9000 SET Quantity = Quantity + @Delta_Quantity
						WHERE TransactionID = @ID AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				END    

			FETCH NEXT FROM @PeriodID_Cur INTO @MaterialTypeID, @MaterialID, @ConvertedAmount, @Quantity, @DebitAccountID, @CreditAccountID 
		END
	CLOSE @PeriodID_Cur		
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

