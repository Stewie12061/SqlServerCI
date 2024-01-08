IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5101_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5101_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Phan bo chi phi NVL the PP truc tiep (theo QC)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Gọi từ sp MP5101
-- <History>
----Created by: Trương Ngọc Phương Thảo, Date: 24/04/2018
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ
---- Modified by Viết Toàn on 11/08/2023 [MAITHU] [2023/08/IS/0118] Bỏ kiểm tra quy cách đối với MAITHU
-- <Example>
---- 
/*-- <Example>	
----*/

CREATE Procedure [dbo].[MP5101_QC]     
				@DivisionID AS nvarchar(50),
				@UserID VARCHAR(50), 
                @PeriodID AS nvarchar(50), 
                @TranMonth AS INT, 
                @TranYear AS INT, 
                @MaterialTypeID AS nvarchar(50)                 
AS 
DECLARE @sSQL AS nvarchar(4000), 
    @SumProductCovalues AS DECIMAL(28, 8), 
    @ProductID AS nvarchar(50), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @ProductCovalues AS DECIMAL(28, 8), 
    @ListMaterial_cur AS Cursor, 
    @MaterialID AS nvarchar(50), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ConvertedAmount AS DECIMAL(28, 8), 
    @QuantityUnit AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL(28, 8), 
    @UnitID AS nvarchar(50), 
    @ConvertDecimal INT,
	@PS01ID	AS Varchar(50),
	@PS02ID	AS Varchar(50),
	@PS03ID	AS Varchar(50),
	@PS04ID	AS Varchar(50),
	@PS05ID	AS Varchar(50),
	@PS06ID	AS Varchar(50),
	@PS07ID	AS Varchar(50),
	@PS08ID	AS Varchar(50),
	@PS09ID	AS Varchar(50),
	@PS10ID	AS Varchar(50),
	@PS11ID	AS Varchar(50),
	@PS12ID	AS Varchar(50),
	@PS13ID	AS Varchar(50),
	@PS14ID	AS Varchar(50),
	@PS15ID	AS Varchar(50),
	@PS16ID	AS Varchar(50),
	@PS17ID	AS Varchar(50),
	@PS18ID	AS Varchar(50),
	@PS19ID	AS Varchar(50),
	@PS20ID AS Varchar(50),
	@CustomerName INT
    
SET @ConvertDecimal = (Select ConvertDecimal FROM MT0000 WITH (NOLOCK) where DivisionID = @DivisionID)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

IF(@CustomerName = 80) -- BeTong: Co di theo nghiep vu tao phieu xuat nvl tu dong tu phieu KQTP
BEGIN	
	SET @sSQL='
	Select     
		T1.DivisionID, 
		T1.InventoryID AS MaterialID, 
		SUM( Case T1.D_C when ''D'' then ISNULL(T1.Quantity, 0) ELSE - ISNULL(T1.Quantity, 0) END ) AS MaterialQuantity, 
		SUM( Case T1.D_C when ''D'' then ISNULL(T1.ConvertedAmount, 0) ELSE - ISNULL(T1.ConvertedAmount, 0) END) AS ConvertedAmount, 
		T1.ProductID,
		ISNULL(T4.S01ID,PS01ID) AS PS01ID, ISNULL(T4.S02ID,PS02ID) AS PS02ID,	ISNULL(T4.S03ID,PS03ID) AS PS03ID,	
		ISNULL(T4.S04ID,PS04ID) AS PS04ID, ISNULL(T4.S05ID,PS05ID) AS PS05ID,	ISNULL(T4.S06ID,PS06ID) AS PS06ID,	
		ISNULL(T4.S07ID,PS07ID) AS PS07ID, ISNULL(T4.S08ID,PS08ID) AS PS08ID,	ISNULL(T4.S09ID,PS09ID) AS PS09ID,	ISNULL(T4.S10ID,PS10ID) AS PS10ID,
		ISNULL(T4.S11ID,PS11ID) AS PS11ID, ISNULL(T4.S12ID,PS12ID) AS PS12ID,	ISNULL(T4.S13ID,PS13ID) AS PS13ID,	
		ISNULL(T4.S14ID,PS14ID) AS PS14ID, ISNULL(T4.S15ID,PS15ID) AS PS15ID,	ISNULL(T4.S16ID,PS16ID) AS PS16ID,	
		ISNULL(T4.S17ID,PS17ID) AS PS17ID, ISNULL(T4.S18ID,PS18ID) AS PS18ID,	ISNULL(T4.S19ID,PS19ID) AS PS19ID,	ISNULL(T4.S20ID,PS20ID) AS PS20ID
	FROM MV9000 T1
	-- Ket ve phieu xuat nvl
	LEFT JOIN AT2007 T2 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID AND T1.TransactionID = T2.TransactionID AND T1.TableID = ''AT2006''
	-- Ket ve phieu nhap tp (theo nv tu dong sinh px nvl khi nhap kqtp)
	LEFT JOIN AT2007 T3 WITH(NOLOCK) ON T2.DivisionID = T3.DivisionID AND T3.VoucherID = T2.InheritVoucherID AND T3.TransactionID = T2.InheritTransactionID 
	-- Ket ve thong tin quy cach cua tp
	LEFT JOIN WT8899 T4 WITH(NOLOCK) ON T3.DivisionID = T4.DivisionID AND T3.VoucherID = T4.VoucherID AND T3.TransactionID = T4.TransactionID AND T4.TableID = ''AT2007''
	WHERE T1.PeriodID = N'''+@PeriodID+''' 
		AND T1.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
		AND T1.ExpenseID = ''COST001'' 
		AND ISNULL(T1.ProductID, '''') <> ''''  
		AND T1.MaterialTypeID = N''' + @MaterialTypeID + ''' 
	GROUP BY T1.DivisionID, T1.InventoryID, T1.ProductID ,
		ISNULL(T4.S01ID,PS01ID), ISNULL(T4.S02ID,PS02ID), ISNULL(T4.S03ID,PS03ID),	
		ISNULL(T4.S04ID,PS04ID), ISNULL(T4.S05ID,PS05ID), ISNULL(T4.S06ID,PS06ID),	
		ISNULL(T4.S07ID,PS07ID), ISNULL(T4.S08ID,PS08ID), ISNULL(T4.S09ID,PS09ID), ISNULL(T4.S10ID,PS10ID),
		ISNULL(T4.S11ID,PS11ID), ISNULL(T4.S12ID,PS12ID), ISNULL(T4.S13ID,PS13ID),	
		ISNULL(T4.S14ID,PS14ID), ISNULL(T4.S15ID,PS15ID), ISNULL(T4.S16ID,PS16ID),	
		ISNULL(T4.S17ID,PS17ID), ISNULL(T4.S18ID,PS18ID), ISNULL(T4.S19ID,PS19ID), ISNULL(T4.S20ID,PS20ID)
	'													  
	IF NOT EXISTS (Select TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV5101_QC' AND Xtype ='V')
		EXEC ('CREATE VIEW MV5101_QC AS '+@sSQL)
	ELSE
		EXEC ('ALTER VIEW MV5101_QC AS '+@sSQL)
END
ELSE
BEGIN	
	SET @sSQL='
	Select     
		DivisionID, 
		InventoryID AS MaterialID, 
		SUM( Case D_C when ''D'' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END ) AS MaterialQuantity, 
		SUM( Case D_C when ''D'' then ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount, 
		ProductID,
		PS01ID, PS02ID,	PS03ID,	PS04ID,	PS05ID,	PS06ID,	PS07ID,	PS08ID,	PS09ID,	PS10ID,
		PS11ID,	PS12ID,	PS13ID,	PS14ID,	PS15ID,	PS16ID,	PS17ID,	PS18ID,	PS19ID,	PS20ID
	FROM MV9000
	WHERE PeriodID = N'''+@PeriodID+''' 
		AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
		AND ExpenseID = ''COST001'' 
		AND ISNULL(ProductID, '''') <> ''''  
		AND MaterialTypeID = N''' + @MaterialTypeID + ''' 
	GROUP BY DivisionID, InventoryID, ProductID ,
		PS01ID, PS02ID,	PS03ID,	PS04ID,	PS05ID,	PS06ID,	PS07ID,	PS08ID,	PS09ID,	PS10ID,
		PS11ID,	PS12ID,	PS13ID,	PS14ID,	PS15ID,	PS16ID,	PS17ID,	PS18ID,	PS19ID,	PS20ID 
	'
	IF NOT EXISTS (Select TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV5101_QC' AND Xtype ='V')
		EXEC ('CREATE VIEW MV5101_QC AS '+@sSQL)
	ELSE
		EXEC ('ALTER VIEW MV5101_QC AS '+@sSQL)
END	
--print @sSQL
		
IF @CustomerName = 117
	SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
	Select 
		MV5101.MaterialID, 
		MV5101.MaterialQuantity, 
		round(MV5101.ConvertedAmount, @ConvertDecimal), 
		MV5101.ProductID, 
		MT2222.ProductQuantity, 
		MT2222.UnitID,
		MV5101.PS01ID, MV5101.PS02ID, MV5101.PS03ID, MV5101.PS04ID, MV5101.PS05ID, MV5101.PS06ID, MV5101.PS07ID, MV5101.PS08ID, MV5101.PS09ID, MV5101.PS10ID,
		MV5101.PS11ID, MV5101.PS12ID, MV5101.PS13ID, MV5101.PS14ID, MV5101.PS15ID, MV5101.PS16ID, MV5101.PS17ID, MV5101.PS18ID, MV5101.PS19ID, MV5101.PS20ID
	FROM MV5101_QC AS MV5101 
	INNER JOIN MT2222 WITH (NOLOCK) ON MV5101.DivisionID  = MT2222.DivisionID AND MV5101.ProductID  = MT2222.ProductID 
	--AND ISNULL(MV5101.PS01ID,'')  = ISNULL(MT2222.PS01ID,'') AND ISNULL(MV5101.PS02ID,'')  = ISNULL(MT2222.PS02ID,'') AND ISNULL(MV5101.PS03ID,'')  = ISNULL(MT2222.PS03ID,'') AND ISNULL(MV5101.PS04ID,'')  = ISNULL(MT2222.PS04ID,'') AND ISNULL(MV5101.PS05ID,'')  = ISNULL(MT2222.PS05ID,'') 
	--AND ISNULL(MV5101.PS06ID,'')  = ISNULL(MT2222.PS06ID,'') AND ISNULL(MV5101.PS07ID,'')  = ISNULL(MT2222.PS07ID,'') AND ISNULL(MV5101.PS08ID,'')  = ISNULL(MT2222.PS08ID,'') AND ISNULL(MV5101.PS09ID,'')  = ISNULL(MT2222.PS09ID,'') AND ISNULL(MV5101.PS10ID,'')  = ISNULL(MT2222.PS10ID,'') 
	--AND ISNULL(MV5101.PS11ID,'')  = ISNULL(MT2222.PS11ID,'') AND ISNULL(MV5101.PS12ID,'')  = ISNULL(MT2222.PS12ID,'') AND ISNULL(MV5101.PS13ID,'')  = ISNULL(MT2222.PS13ID,'') AND ISNULL(MV5101.PS14ID,'')  = ISNULL(MT2222.PS14ID,'') AND ISNULL(MV5101.PS15ID,'')  = ISNULL(MT2222.PS15ID,'') 
	--AND ISNULL(MV5101.PS16ID,'')  = ISNULL(MT2222.PS16ID,'') AND ISNULL(MV5101.PS17ID,'')  = ISNULL(MT2222.PS17ID,'') AND ISNULL(MV5101.PS18ID,'')  = ISNULL(MT2222.PS18ID,'') AND ISNULL(MV5101.PS19ID,'')  = ISNULL(MT2222.PS19ID,'') AND ISNULL(MV5101.PS20ID,'')  = ISNULL(MT2222.PS20ID,'')
ELSE
	SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
	Select 
		MV5101.MaterialID, 
		MV5101.MaterialQuantity, 
		round(MV5101.ConvertedAmount, @ConvertDecimal), 
		MV5101.ProductID, 
		MT2222.ProductQuantity, 
		MT2222.UnitID,
		MV5101.PS01ID, MV5101.PS02ID, MV5101.PS03ID, MV5101.PS04ID, MV5101.PS05ID, MV5101.PS06ID, MV5101.PS07ID, MV5101.PS08ID, MV5101.PS09ID, MV5101.PS10ID,
		MV5101.PS11ID, MV5101.PS12ID, MV5101.PS13ID, MV5101.PS14ID, MV5101.PS15ID, MV5101.PS16ID, MV5101.PS17ID, MV5101.PS18ID, MV5101.PS19ID, MV5101.PS20ID
	FROM MV5101_QC AS MV5101 
	INNER JOIN MT2222 WITH (NOLOCK) ON MV5101.DivisionID  = MT2222.DivisionID AND MV5101.ProductID  = MT2222.ProductID 
	AND ISNULL(MV5101.PS01ID,'')  = ISNULL(MT2222.PS01ID,'') AND ISNULL(MV5101.PS02ID,'')  = ISNULL(MT2222.PS02ID,'') AND ISNULL(MV5101.PS03ID,'')  = ISNULL(MT2222.PS03ID,'') AND ISNULL(MV5101.PS04ID,'')  = ISNULL(MT2222.PS04ID,'') AND ISNULL(MV5101.PS05ID,'')  = ISNULL(MT2222.PS05ID,'') 
	AND ISNULL(MV5101.PS06ID,'')  = ISNULL(MT2222.PS06ID,'') AND ISNULL(MV5101.PS07ID,'')  = ISNULL(MT2222.PS07ID,'') AND ISNULL(MV5101.PS08ID,'')  = ISNULL(MT2222.PS08ID,'') AND ISNULL(MV5101.PS09ID,'')  = ISNULL(MT2222.PS09ID,'') AND ISNULL(MV5101.PS10ID,'')  = ISNULL(MT2222.PS10ID,'') 
	AND ISNULL(MV5101.PS11ID,'')  = ISNULL(MT2222.PS11ID,'') AND ISNULL(MV5101.PS12ID,'')  = ISNULL(MT2222.PS12ID,'') AND ISNULL(MV5101.PS13ID,'')  = ISNULL(MT2222.PS13ID,'') AND ISNULL(MV5101.PS14ID,'')  = ISNULL(MT2222.PS14ID,'') AND ISNULL(MV5101.PS15ID,'')  = ISNULL(MT2222.PS15ID,'') 
	AND ISNULL(MV5101.PS16ID,'')  = ISNULL(MT2222.PS16ID,'') AND ISNULL(MV5101.PS17ID,'')  = ISNULL(MT2222.PS17ID,'') AND ISNULL(MV5101.PS18ID,'')  = ISNULL(MT2222.PS18ID,'') AND ISNULL(MV5101.PS19ID,'')  = ISNULL(MT2222.PS19ID,'') AND ISNULL(MV5101.PS20ID,'')  = ISNULL(MT2222.PS20ID,'')

OPEN @ListMaterial_cur 
FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @UnitID,
				@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
WHILE @@Fetch_Status = 0
    Begin                                            
        IF ISNULL(@ProductQuantity, 0)<>0  
            SET @QuantityUnit = ISNULL(@MaterialQuantity, 0)/@ProductQuantity 
        ELSE  SET @QuantityUnit =0
        
        ---- Phan bo thanh tien chi phi mot nguyen vat lieu cho mot san pham
        IF ISNULL(@ProductQuantity, 0)<>0 
              SET @ConvertedUnit =ISNULL(@ConvertedAmount, 0)/@ProductQuantity
        ELSE SET @ConvertedUnit = 0
        
        --INSERT vao bang MT0612
        --IF ISNULL(@SumProductCovalues, 0) <>0 
        INSERT MT0621 (DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit, MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate,
					   PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					   PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)
        VALUES (@DivisionID, @MaterialID, @ProductID, @UnitID, 'COST001', @MaterialQuantity, @QuantityUnit, @MaterialTypeID, @ConvertedAmount, @ConvertedUnit, @ProductQuantity, NULL,
				@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID)
        
        FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount, @ProductID, @ProductQuantity, @UnitID,
												@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
												@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
    END
CLOSE @ListMaterial_cur

---- Xu ly lam tron
DECLARE @Detal_ConvertedAmount AS DECIMAL(28, 8), 
    @ID AS DECIMAL(28, 0)

SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
Select ISNULL(MaterialID, ''), SUM(Quantity) AS Quantity, SUM(ConvertedAmount) AS ConvertedAmount 
FROM MT0621  WITH (NOLOCK)
WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID ='COST001'
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
GROUP BY ISNULL(MaterialID, '')
        
OPEN @ListMaterial_cur 
FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount

WHILE @@Fetch_Status = 0        
    Begin    
        Select @Detal_ConvertedAmount =0
        Select @Detal_ConvertedAmount = round(ISNULL((Select  SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) 
                                                      FROM MV9000 
                                                      WHERE PeriodID =@PeriodID AND MaterialTypeID =@MaterialTypeID 
                                                        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                                                        AND ISNULL(ProductID, '')<>'' AND ISNULL(InventoryID, '')  = @MaterialID ), 0), @ConvertDecimal) - @ConvertedAmount
            
        IF @Detal_ConvertedAmount <>0
            Begin
                SET @ID = NULL
                SET @ID =(Select TOP 1 ID  FROM MT0621  WITH (NOLOCK)
                          WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID = 'COST001' AND ISNULL(MaterialID, '') = @MaterialID 
                              AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
                          Order BY  ConvertedAmount Desc )
                IF @ID is NOT NULL
                    Update MT0621  SET ConvertedAmount = ConvertedAmount + @Detal_ConvertedAmount     
                    WHERE ID =@ID
                        AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
            END
    
        FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID, @MaterialQuantity, @ConvertedAmount
    END    

-- SINH SỐ CHỨNG TỪ PHÂN BỔ TỰ ĐỘNG
DECLARE @Enabled1 TINYINT,
		@Enabled2 TINYINT,
		@Enabled3 TINYINT,
		@S1 NVARCHAR(50),
		@S2 NVARCHAR(50),
		@S3 NVARCHAR(50),
		@S1Type TINYINT,
		@S2Type TINYINT,
		@S3Type TINYINT,
		@VoucherNo NVARCHAR(50),
		@StringKey1 nvarchar(50),
		@StringKey2 nvarchar(50),
		@StringKey3 nvarchar(50), 
		@OutputLen int, 
		@OutputOrder int,
		@Separated int, 
		@Separator char(1),
		@ExpenseVoucherTypeID VARCHAR(50),
		@DistributeDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @ExpenseVoucherTypeID = (SELECT ISNULL(ExpenseVoucherTypeID,'PBO') FROM MT0000 WHERE DivisionID = @DivisionID)
SET @DistributeDescription = (SELECT ISNULL(DistributeDescription + ' ',N'Phân bổ chi phí ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END

--LẤY CHỈ SỐ TĂNG SỐ CHỨNG TỪ
Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type,
		@OutputLen=OutputLength, @OutputOrder=OutputOrder, @Separated=Separated, @Separator=Separator
From AT1007 WITH (NOLOCK) Where DivisionID = @DivisionID AND VoucherTypeID = @ExpenseVoucherTypeID

If @Enabled1 = 1
	SET @StringKey1 = 
	Case @S1Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S1
	Else '' End
Else
	SET @StringKey1 = ''

If @Enabled2 = 1
	SET @StringKey2 = 
	Case @S2Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S2
	Else '' End
Else
	SET @StringKey2 = ''

If @Enabled3 = 1
	SET @StringKey3 = 
	Case @S3Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	SET @StringKey3 = ''


Recal:
--- SINH SỐ CHỨNG TỪ PHÂN BỔ
Exec AP0000  @DivisionID, @VoucherNo OUTPUT, 'MT0400', @StringKey1, @StringKey2, @StringKey3, @OutputLen, @OutputOrder, @Separated, @Separator

IF EXISTS (SELECT 1 FROM MT0400 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	GOTO Recal

--INSERT VÀO BẢNG KẾT QUẢ PHÂN BỔ - MT0400
INSERT INTO MT0400 (ApportionCostID, PeriodID, MaterialQuantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID,ExpenseID, TranMonth, TranYear,
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID,  PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
FROM MT0621	
WHERE ExpenseID = 'COST001'  AND MaterialTypeID = @MaterialTypeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

