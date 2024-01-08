IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0622]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP0622]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


------ Created BY Nguyen Van Nhan, Date 03/11/2003
------ Purpose Phan bo nhan cong truc tiep
/********************************************
'* Edited BY: [GS] [Tố Oanh] [30/07/2010]
'********************************************/
---- Modified by Tiểu Mai on 31/12/2015: Bổ sung trường hợp quản lý hàng theo quy cách (IsSpecificate = 1)
---- Modified by Bảo Anh on 24/04/2017: Đưa phần insert dữ liệu MT2222 từ MP5000 vào để tính được Số lượng SPDD = Số lượng SP * ISNULL(% chi phí NC, % TLHT)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Phương Thảo on 24/04/2018: Bổ sung quy cách cho pp PB theo he so
---- Modified by Kim Thư on 13/12/2018: Bổ sung biến UserID để vào các store bên trong insert vô table MT0400
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

CREATE PROCEDURE [dbo].[MP0622] 
    @DivisionID NVARCHAR(50), 
	@UserID VARCHAR(50),
    @PeriodID NVARCHAR(50), 
    @TranMonth AS INT, 
    @TranYear AS INT, 
    @DistributionID NVARCHAR(50)
AS

DECLARE 
    @MethodID AS NVARCHAR(50), 
    @CoefficientID AS NVARCHAR(50), 
    @ApportionID AS NVARCHAR(50), 
    @MaterialTypeID AS NVARCHAR(50), 
    @Expense_622 AS CURSOR, 
    @Expense_621 AS CURSOR,
	@CustomerName INT, 
    @sSQL AS NVARCHAR(4000), 
	@sSQL1 AS NVARCHAR(4000)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

------------ Buoc 1 --- Xac dinh ket qua san xuat dở dang và thành phẩm
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
SET @sSQL = '
SELECT DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID, SUM(ProductQuantity) AS ProductQuantity, 
	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
    S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
FROM (
		SELECT 
			D10.DivisionID, 
			D10.ProductID AS ProductID, 
			AT1302.InventoryTypeID, 
			D10.UnitID, 
			D08.PeriodID,
			SUM(D10.Quantity) AS ProductQuantity,    
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		FROM MT1001 D10  WITH (NOLOCK)
			INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.DivisionID = D10.DivisionID AND D08.VoucherID = D10.VoucherID
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = D10.ProductID AND AT1302.DivisionID IN (D10.DivisionID,''@@@'')
			LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D10.DivisionID AND O99.VoucherID = D10.VoucherID AND O99.TransactionID = D10.TransactionID AND O99.TableID = ''MT1001''
		WHERE '+ CASE WHEN @CustomerName = 50 THEN 'D08.TranMonth+D08.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+' AND  ' ELSE ' D08.PeriodID = N''' + @PeriodID + ''' AND ' END+'
			D08.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
			AND D08.ResultTypeID = ''R01''
		GROUP BY D10.DivisionID, D10.ProductID, AT1302.InventoryTypeID, D08.PeriodID, D10.UnitID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID 
		UNION ALL 
		SELECT 
			D10.DivisionID, 
			D10.ProductID AS ProductID, 
			AT1302.InventoryTypeID, 
			D10.UnitID, 
			D08.PeriodID,    
			SUM(D10.Quantity*ISNULL(D10.HumanResourceRate,D10.PerfectRate)/100) AS ProductQuantity,	
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		FROM MT1001 D10  WITH (NOLOCK)
			INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.DivisionID = D10.DivisionID AND D08.VoucherID = D10.VoucherID
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = D10.ProductID AND AT1302.DivisionID IN (D10.DivisionID,''@@@'')
			LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = D10.DivisionID AND O99.VoucherID = D10.VoucherID AND O99.TransactionID = D10.TransactionID AND O99.TableID = ''MT1001''
		WHERE '+ CASE WHEN @CustomerName = 50 THEN 'D08.TranMonth+D08.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+' AND  ' ELSE ' D08.PeriodID = N''' + @PeriodID + ''' AND ' END+'
			D08.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
			AND D08.ResultTypeID = ''R03''
		GROUP BY D10.DivisionID, D10.ProductID, AT1302.InventoryTypeID, D08.PeriodID, D10.UnitID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID 
	) T
GROUP BY DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID,
	S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
    S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
'
ELSE
SET @sSQL = '
SELECT DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID, SUM(ProductQuantity) AS ProductQuantity
FROM (
		SELECT 
			D10.DivisionID, 
			D10.ProductID AS ProductID, 
			AT1302.InventoryTypeID, 
			D10.UnitID, 
			D08.PeriodID,
			SUM(D10.Quantity) AS ProductQuantity    
		FROM MT1001 D10  WITH (NOLOCK)
			INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.DivisionID = D10.DivisionID AND D08.VoucherID = D10.VoucherID
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = D10.ProductID AND AT1302.DivisionID IN (D10.DivisionID,''@@@'')
		WHERE '+ CASE WHEN @CustomerName = 50 THEN 'D08.TranMonth+D08.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+' AND ' ELSE ' D08.PeriodID = N''' + @PeriodID + ''' AND ' END+'
			D08.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
			AND D08.ResultTypeID  = ''R01''
		GROUP BY D10.DivisionID, D10.ProductID, AT1302.InventoryTypeID, D08.PeriodID, D10.UnitID 
		UNION ALL 
		SELECT 
			D10.DivisionID, 
			D10.ProductID AS ProductID, 
			AT1302.InventoryTypeID, 
			D10.UnitID, 
			D08.PeriodID,    
			SUM(D10.Quantity*ISNULL(D10.HumanResourceRate,D10.PerfectRate)/100) AS ProductQuantity	
		FROM MT1001 D10  WITH (NOLOCK)
			INNER JOIN MT0810 D08 WITH (NOLOCK) ON D08.DivisionID = D10.DivisionID AND D08.VoucherID = D10.VoucherID
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = D10.ProductID AND AT1302.DivisionID IN (D10.DivisionID,''@@@'')
		WHERE '+ CASE WHEN @CustomerName = 50 THEN ' D08.TranMonth+D08.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+' AND ' ELSE ' D08.PeriodID = N''' + @PeriodID + ''' AND ' END+'
			D08.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N''' + @DivisionID + '''))
			AND D08.ResultTypeID  = ''R03''
		GROUP BY D10.DivisionID, D10.ProductID, AT1302.InventoryTypeID, D08.PeriodID, D10.UnitID
	) T
GROUP BY DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID
' 

IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[MT2222]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
    BEGIN
        CREATE TABLE [dbo].[MT2222] (
        [DivisionID] NVARCHAR (50) NULL, 
        [ProductID] NVARCHAR (50) NULL, 
        [InventoryTypeID] NVARCHAR (50) NULL, 
        [UnitID] NVARCHAR (50) NULL, 
		[PeriodID] NVARCHAR (50) NULL, 
        [ProductQuantity] DECIMAL(28, 8) NULL, 
        [PerfectRate] DECIMAL(28, 8) NULL, 
        [MaterialRate] DECIMAL(28, 8) NULL, 
        [HumanResourceRate] DECIMAL(28, 8) NULL, 
        [OthersRate] DECIMAL(28, 8) NULL
        ) ON [PRIMARY] 
    END
ELSE
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT2222' AND col.name = 'PeriodID')
		ALTER TABLE MT2222 ADD PeriodID NVARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT2222' AND col.name = 'PS01ID')
        ALTER TABLE MT2222 ADD PS01ID NVARCHAR(50) NULL,
        PS02ID NVARCHAR(50) NULL,
        PS03ID NVARCHAR(50) NULL,
        PS04ID NVARCHAR(50) NULL,
        PS05ID NVARCHAR(50) NULL,
        PS06ID NVARCHAR(50) NULL,
        PS07ID NVARCHAR(50) NULL,
        PS08ID NVARCHAR(50) NULL,
    PS09ID NVARCHAR(50) NULL,
        PS10ID NVARCHAR(50) NULL,
        PS11ID NVARCHAR(50) NULL,
        PS12ID NVARCHAR(50) NULL,
        PS13ID NVARCHAR(50) NULL,
        PS14ID NVARCHAR(50) NULL,
        PS15ID NVARCHAR(50) NULL,
        PS16ID NVARCHAR(50) NULL,
        PS17ID NVARCHAR(50) NULL,
        PS18ID NVARCHAR(50) NULL,
        PS19ID NVARCHAR(50) NULL,
        PS20ID NVARCHAR(50) NULL	
END

DELETE MT2222 --- bang tam 
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	SET @sSQL1 = '
	INSERT MT2222(DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID, ProductQuantity, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID) 

	'
ELSE
	SET @sSQL1 = '
	INSERT MT2222(DivisionID, ProductID, InventoryTypeID, UnitID, PeriodID, ProductQuantity) 

	'
--PRINT @sSQL1
--PRINT @sSQL	
EXEC (@sSQL1 + @sSQL)

------------ Buoc 2 --- Thực hiện phân bổ CPNC 
DELETE MT0621 WHERE DivisionID = @DivisionID AND ExpenseID = 'COST002'

SET @Expense_622 = CURSOR SCROLL KEYSET FOR 
    SELECT MethodID, CoefficientID, ApportionID, MaterialTypeID 
    FROM MT5001 
    WHERE DivisionID = @DivisionID AND DistributionID = @DistributionID AND ExpenseID = 'COST002' AND IsDistributed = 1 

OPEN @Expense_622
FETCH NEXT FROM @Expense_622 INTO @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID
WHILE @@Fetch_Status = 0
    BEGIN
        IF @MethodID = 'D01' --- Phan bo truc tiep. Da duoc lam xong ngay 06/11/2003.
        EXEC MP5201 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID

        IF @MethodID = 'D02' ---- Phan bo theo he so. Da duoc lam xong ngay 05/11/2003.
		
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
				EXEC MP5202_QC @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID
			ELSE
				EXEC MP5202 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID
		END
		
        IF @MethodID = 'D03' ---- Phan bo theo dinh muc
        BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
				EXEC MP6203 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @ApportionID
			ELSE	
				EXEC MP5203 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @ApportionID
        	
        END
        IF @MethodID = 'D04' ---- Phan bo theo nguyen vat lieu (NVL phai thuc hien truoc)
        EXEC MP5204 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID

        --IF @MethodID = 'D05' 
        ---khong su dung 

        IF @MethodID = 'D06' --- Phan bo truc tiep ket hop he so
        EXEC MP5206 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID

        IF @MethodID = 'D07' --- Phanbo truc tiep ket hop dinh muc
        EXEC MP5207 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @ApportionID 

        IF @MethodID = 'D08' --- Phan bo theo NVL ket hop he so. Coding BY Van Nhan (dap ung yeu cua cua Chau Electronics)
        EXEC MP5208 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID

        FETCH NEXT FROM @Expense_622 INTO @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID 
    END

CLOSE @Expense_622


----- Nhung cai duoc phan bo theo luong

-----1. NVL Phan bo theo luong
SET @Expense_621 = CURSOR SCROLL KEYSET FOR 
SELECT MethodID, CoefficientID, ApportionID, MaterialTypeID
FROM MT5001 WHERE DivisionID = @DivisionID AND DistributionID = @DistributionID AND ExpenseID = 'COST001' AND IsDistributed = 1 AND MethodID = 'D05' 

OPEN @Expense_621
FETCH NEXT FROM @Expense_621 INTO @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID
WHILE @@Fetch_Status = 0
    BEGIN
        DELETE MT0621 WHERE DivisionID = @DivisionID AND ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID

        EXEC MP5105 @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID

        FETCH NEXT FROM @Expense_621 INTO @MethodID, @CoefficientID, @ApportionID, @MaterialTypeID 
    END

CLOSE @Expense_621


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

