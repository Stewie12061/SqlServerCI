IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2002_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2002_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---Created by Tiểu Mai on 16/06/2016
--- Purpose cap nhat so du cho cac kho theo quy cach
--- Modified by Tiểu Mai on 18/10/2016: Bổ sung cập nhật tồn kho


CREATE PROCEDURE [dbo].[AP2002_QC] 	
				@DivisionID varchar(50), @TranMonth int, @TranYear int,
				@WareHouseID_New nvarchar(50), @WareHouseID2_New nvarchar(50), @WareHouseID_Old nvarchar(50), @WareHouseID2_Old nvarchar(50), @InventoryID as nvarchar(50),
				@S01ID VARCHAR(50),@S02ID VARCHAR(50),	@S03ID VARCHAR(50), @S04ID VARCHAR(50), @S05ID VARCHAR(50),
				@S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50), @S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50),
				@S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50), @S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50)
AS

--- Tạo bảng tạm thay cho view AV2222
  IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM

  Select  (Case When DE.DivisionID is Null Then CE.DivisionID Else DE.DivisionID End) As DivisionID,
	 (Case When DE.TranMonth is Null Then CE.TranMonth Else DE.TranMonth End) As TranMonth,
	 (Case When DE.TranYear is Null Then CE.TranYear Else DE.TranYear End) As TranYear,
	 (Case When DE.WareHouseID is Null Then CE.WareHouseID Else DE.WareHouseID End) As WareHouseID,
	 (Case When DE.InventoryID is Null Then CE.InventoryID Else DE.InventoryID End) As InventoryID,
	 (Case When DE.InventoryAccountID is Null Then CE.InventoryAccountID Else DE.InventoryAccountID End) As InventoryAccountID,
	 BeginQuantity, 
	 BeginAmount, 
	 DebitQuantity, 
	 DebitAmount,
	 InDebitQuantity,
	 InDebitAmount,	
	 CE.Quantity As CreditQuantity,
	 CE.Amount As CreditAmount,
	 CE.InQuantity As InCreditQuantity,
	 CE.InAmount As InCreditAmount,
	 Isnull(CE.S01ID,DE.S01ID) AS S01ID, isnull(CE.S02ID,DE.S02ID) AS S02ID, isnull(CE.S03ID,DE.S03ID) AS S03ID, isnull(CE.S04ID,DE.S04ID) AS S04ID, isnull(CE.S05ID,DE.S05ID) AS S05ID, 
	 isnull(CE.S06ID,DE.S06ID) AS S06ID, isnull(CE.S07ID,DE.S07ID) AS S07ID, isnull(CE.S08ID,DE.S08ID) AS S08ID, isnull(CE.S09ID,DE.S09ID) AS S09ID, isnull(CE.S10ID,DE.S10ID) AS S10ID, 
	 isnull(CE.S11ID,DE.S11ID) AS S11ID, isnull(CE.S12ID,DE.S12ID) AS S12ID, isnull(CE.S13ID,DE.S13ID) AS S13ID, isnull(CE.S14ID,DE.S14ID) AS S14ID, isnull(CE.S15ID,DE.S15ID) AS S15ID, 
	 isnull(CE.S16ID,DE.S16ID) AS S16ID, isnull(CE.S17ID,DE.S17ID) AS S17ID, isnull(CE.S18ID,DE.S18ID) AS S18ID, isnull(CE.S19ID,DE.S19ID) AS S19ID, isnull(CE.S20ID,DE.S20ID) AS S20ID	
INTO #TAM	
From
--Nhap + So du
(Select  (Case When BE.DivisionID is Null Then DE.DivisionID Else BE.DivisionID End) As DivisionID,
	(Case When BE.TranMonth is Null Then DE.TranMonth Else BE.TranMonth End) As TranMonth,
	(Case When BE.TranYear is Null Then DE.TranYear Else BE.TranYear End) As TranYear,
	(Case When BE.WareHouseID is Null Then DE.WareHouseID Else BE.WareHouseID End) As WareHouseID,
	(Case When BE.InventoryID is Null Then DE.InventoryID Else BE.InventoryID End) As InventoryID,
	(Case When BE.InventoryAccountID is Null Then DE.InventoryAccountID Else BE.InventoryAccountID End) As InventoryAccountID,
	BE.Quantity As BeginQuantity, 
	BE.Amount As BeginAmount, 
	DE.Quantity As DebitQuantity, 
	DE.Amount As DebitAmount,
	DE.InQuantity As InDebitQuantity,
	DE.InAmount As InDebitAmount,
	Isnull(DE.S01ID,BE.S01ID) AS S01ID, ISNULL(DE.S02ID,BE.S02ID) AS S02ID, Isnull(DE.S03ID,BE.S03ID) AS S03ID, Isnull(DE.S04ID,BE.S04ID) AS S04ID, Isnull(DE.S05ID,BE.S05ID) AS S05ID,
	Isnull(DE.S06ID,BE.S06ID) AS S06ID, Isnull(DE.S07ID,BE.S07ID) AS S07ID, Isnull(DE.S08ID,BE.S08ID) AS S08ID, Isnull(DE.S09ID,BE.S09ID) AS S09ID, Isnull(DE.S10ID,BE.S10ID) AS S10ID,
	Isnull(DE.S11ID,BE.S11ID) AS S11ID, Isnull(DE.S12ID,BE.S12ID) AS S12ID, Isnull(DE.S13ID,BE.S13ID) AS S13ID, Isnull(DE.S14ID,BE.S14ID) AS S14ID, Isnull(DE.S15ID,BE.S15ID) AS S15ID,
	Isnull(DE.S16ID,BE.S16ID) AS S16ID, Isnull(DE.S17ID,BE.S17ID) AS S17ID, Isnull(DE.S18ID,BE.S18ID) AS S18ID, Isnull(DE.S19ID,BE.S19ID) AS S19ID, Isnull(DE.S20ID,BE.S20ID) AS S20ID
From
--So du dau
(Select T16.DivisionID,T16.TranMonth,T16.TranYear,T16.WareHouseID,T17.InventoryID,T17.DebitAccountID As InventoryAccountID,
isnull(Sum(isnull(T17.ActualQuantity,0)),0) As Quantity, 
isnull(Sum(isnull(T17.ConvertedAmount,0)),0) As Amount,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID 
From AT2016 T16 WITH (NOLOCK) Inner join AT2017 T17 WITH (NOLOCK) On T16.VoucherID = T17.VoucherID and T16.DivisionID = T17.DivisionID
LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T17.DivisionID AND O99.VoucherID = T17.VoucherID AND O99.TransactionID = T17.TransactionID
Group by T16.DivisionID,T16.TranMonth,T16.TranYear,WareHouseID,InventoryID,DebitAccountID,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID) As BE
Full Join
--Nhap kho
(
	Select T16.DivisionID,T16.TranMonth,T16.TranYear,T16.WareHouseID,T17.InventoryID,T17.DebitAccountID As InventoryAccountID,
isnull(Sum(isnull(T17.ActualQuantity,0)),0) As Quantity, 
isnull(Sum(isnull(T17.ConvertedAmount,0)),0) As Amount,
isnull(Sum(Case When T16.KindVoucherID = 3 Then isnull(T17.ActualQuantity,0) Else 0 End),0) As InQuantity, 
isnull(Sum(Case When T16.KindVoucherID = 3 Then isnull(T17.ConvertedAmount,0) Else 0 End),0) As InAmount,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID  
From AT2006 T16 WITH (NOLOCK) Inner join AT2007 T17 WITH (NOLOCK) On T16.VoucherID = T17.VoucherID and T16.DivisionID = T17.DivisionID
LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T17.DivisionID AND O99.VoucherID = T17.VoucherID AND O99.TransactionID = T17.TransactionID
Where KindVoucherID in (1,3,5,7,9,15,17)
Group by T16.DivisionID,T16.TranMonth,T16.TranYear,WareHouseID,InventoryID,DebitAccountID,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID) AS DE

On 
BE.DivisionID = DE.DivisionID 
And BE.TranMonth = DE.TranMonth 
And BE.TranYear = DE.TranYear
And BE.WareHouseID = DE.WareHouseID
And BE.InventoryID = DE.InventoryID
And BE.InventoryAccountID = DE.InventoryAccountID AND 
ISNULL(BE.S01ID,'') = ISNULL(DE.S01ID,'') AND 
ISNULL(BE.S02ID,'') = ISNULL(DE.S02ID,'') AND
ISNULL(BE.S03ID,'') = ISNULL(DE.S03ID,'') AND
ISNULL(BE.S04ID,'') = ISNULL(DE.S04ID,'') AND
ISNULL(BE.S05ID,'') = ISNULL(DE.S05ID,'') AND 
ISNULL(BE.S06ID,'') = ISNULL(DE.S06ID,'') AND
ISNULL(BE.S07ID,'') = ISNULL(DE.S07ID,'') AND
ISNULL(BE.S08ID,'') = ISNULL(DE.S08ID,'') AND
ISNULL(BE.S09ID,'') = ISNULL(DE.S09ID,'') AND
ISNULL(BE.S10ID,'') = ISNULL(DE.S10ID,'') AND
ISNULL(BE.S11ID,'') = ISNULL(DE.S11ID,'') AND 
ISNULL(BE.S12ID,'') = ISNULL(DE.S12ID,'') AND
ISNULL(BE.S13ID,'') = ISNULL(DE.S13ID,'') AND
ISNULL(BE.S14ID,'') = ISNULL(DE.S14ID,'') AND
ISNULL(BE.S15ID,'') = ISNULL(DE.S15ID,'') AND
ISNULL(BE.S16ID,'') = ISNULL(DE.S16ID,'') AND
ISNULL(BE.S17ID,'') = ISNULL(DE.S17ID,'') AND
ISNULL(BE.S18ID,'') = ISNULL(DE.S18ID,'') AND
ISNULL(BE.S19ID,'') = ISNULL(DE.S19ID,'') AND
ISNULL(BE.S20ID,'') = ISNULL(DE.S20ID,'')
) As DE

Full Join
--Xuat kho
(Select T16.DivisionID,T16.TranMonth,T16.TranYear,(Case When KindVoucherID = 3 Then T16.WareHouseID2 Else T16.WareHouseID End) As WareHouseID,T17.InventoryID,T17.CreditAccountID As InventoryAccountID,
isnull(Sum(isnull(T17.ActualQuantity,0)),0) As Quantity, 
isnull(Sum(isnull(T17.ConvertedAmount,0)),0) As Amount,
isnull(Sum(Case When T16.KindVoucherID = 3 Then isnull(T17.ActualQuantity,0) Else 0 End),0) As InQuantity, 
isnull(Sum(Case When T16.KindVoucherID = 3 Then isnull(T17.ConvertedAmount,0) Else 0 End),0) As InAmount,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID   
From AT2006 T16 WITH (NOLOCK) Inner join AT2007 T17 WITH (NOLOCK) On T16.VoucherID = T17.VoucherID and T16.DivisionID = T17.DivisionID
LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T17.DivisionID AND O99.VoucherID = T17.VoucherID AND O99.TransactionID = T17.TransactionID
Where KindVoucherID in (2,3,4,6,8,10,14,20)
Group by T16.DivisionID,T16.TranMonth,T16.TranYear,(Case When KindVoucherID = 3 Then T16.WareHouseID2 Else T16.WareHouseID End),InventoryID,CreditAccountID,
O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID) As CE
On
DE.DivisionID = CE.DivisionID 
And DE.TranMonth = CE.TranMonth 
And DE.TranYear = CE.TranYear
And DE.WareHouseID = CE.WareHouseID
And DE.InventoryID = CE.InventoryID
And DE.InventoryAccountID = CE.InventoryAccountID AND 
ISNULL(DE.S01ID,'') = ISNULL(CE.S01ID,'') AND 
ISNULL(DE.S02ID,'') = ISNULL(CE.S02ID,'') AND
ISNULL(DE.S03ID,'') = ISNULL(CE.S03ID,'') AND
ISNULL(DE.S04ID,'') = ISNULL(CE.S04ID,'') AND
ISNULL(DE.S05ID,'') = ISNULL(CE.S05ID,'') AND 
ISNULL(DE.S06ID,'') = ISNULL(CE.S06ID,'') AND
ISNULL(DE.S07ID,'') = ISNULL(CE.S07ID,'') AND
ISNULL(DE.S08ID,'') = ISNULL(CE.S08ID,'') AND
ISNULL(DE.S09ID,'') = ISNULL(CE.S09ID,'') AND
ISNULL(DE.S10ID,'') = ISNULL(CE.S10ID,'') AND
ISNULL(DE.S11ID,'') = ISNULL(CE.S11ID,'') AND 
ISNULL(DE.S12ID,'') = ISNULL(CE.S12ID,'') AND
ISNULL(DE.S13ID,'') = ISNULL(CE.S13ID,'') AND
ISNULL(DE.S14ID,'') = ISNULL(CE.S14ID,'') AND
ISNULL(DE.S15ID,'') = ISNULL(CE.S15ID,'') AND
ISNULL(DE.S16ID,'') = ISNULL(CE.S16ID,'') AND
ISNULL(DE.S17ID,'') = ISNULL(CE.S17ID,'') AND
ISNULL(DE.S18ID,'') = ISNULL(CE.S18ID,'') AND
ISNULL(DE.S19ID,'') = ISNULL(CE.S19ID,'') AND
ISNULL(DE.S20ID,'') = ISNULL(CE.S20ID,'')


Insert Into AT2008_QC (DivisionID, TranMonth, TranYear, WareHouseID, InventoryID, InventoryAccountID, 
			BeginQuantity, BeginAmount, 
			DebitQuantity, DebitAmount,
			InDebitQuantity, InDebitAmount,
			CreditQuantity, CreditAmount,
			InCreditQuantity, InCreditAmount,
			EndQuantity, EndAmount, S01ID, S02ID,S03ID,S04ID,S05ID, S06ID, S07ID, S08ID, S09ID,S10ID,
			S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID,S18ID,S19ID,S20ID)
Select 	V.DivisionID, V.TranMonth, V.TranYear, V.WareHouseID, V.InventoryID, V.InventoryAccountID,
	isnull(V.BeginQuantity,0), isnull(V.BeginAmount,0), 
	isnull(V.DebitQuantity,0), isnull(V.DebitAmount,0),
	isnull(V.InDebitQuantity,0), isnull(V.InDebitAmount,0),
	isnull(V.CreditQuantity,0), isnull(V.CreditAmount,0),
	isnull(V.InCreditQuantity,0), isnull(V.InCreditAmount,0),
	isnull(V.BeginQuantity,0) + isnull(V.DebitQuantity,0) - isnull(V.CreditQuantity,0),
	isnull(V.BeginAmount,0) + isnull(V.DebitAmount,0) - isnull(V.CreditAmount,0), V.S01ID, V.S02ID,V.S03ID,V.S04ID,V.S05ID, V.S06ID, V.S07ID, V.S08ID, V.S09ID, V.S10ID,
			V.S11ID, V.S12ID, V.S13ID, V.S14ID, V.S15ID, V.S16ID, V.S17ID, V.S18ID, V.S19ID, V.S20ID
From AT2008_QC  A  RIGHT JOIN  #TAM V
On 	A.DivisionID = V.DivisionID And
	A.WareHouseID = V.WareHouseID And
	A.InventoryID = V.InventoryID And
	A.InventoryAccountID = V.InventoryAccountID And
	A.TranMonth = V.TranMonth And
	A.TranYear = V.TranYear AND 
	ISNULL(A.S01ID,'') = ISNULL(V.S01ID,'') AND 
	ISNULL(A.S02ID,'') = ISNULL(V.S02ID,'') AND
	ISNULL(A.S03ID,'') = ISNULL(V.S03ID,'') AND
	ISNULL(A.S04ID,'') = ISNULL(V.S04ID,'') AND
	ISNULL(A.S05ID,'') = ISNULL(V.S05ID,'') AND 
	ISNULL(A.S06ID,'') = ISNULL(V.S06ID,'') AND
	ISNULL(A.S07ID,'') = ISNULL(V.S07ID,'') AND
	ISNULL(A.S08ID,'') = ISNULL(V.S08ID,'') AND
	ISNULL(A.S09ID,'') = ISNULL(V.S09ID,'') AND
	ISNULL(A.S10ID,'') = ISNULL(V.S10ID,'') AND
	ISNULL(A.S11ID,'') = ISNULL(V.S11ID,'') AND 
	ISNULL(A.S12ID,'') = ISNULL(V.S12ID,'') AND
	ISNULL(A.S13ID,'') = ISNULL(V.S13ID,'') AND
	ISNULL(A.S14ID,'') = ISNULL(V.S14ID,'') AND
	ISNULL(A.S15ID,'') = ISNULL(V.S15ID,'') AND
	ISNULL(A.S16ID,'') = ISNULL(V.S16ID,'') AND
	ISNULL(A.S17ID,'') = ISNULL(V.S17ID,'') AND
	ISNULL(A.S18ID,'') = ISNULL(V.S18ID,'') AND
	ISNULL(A.S19ID,'') = ISNULL(V.S19ID,'') AND
	ISNULL(A.S20ID,'') = ISNULL(V.S20ID,'')
Where 	A.DivisionID is null And
	A.WareHouseID is null And
	A.InventoryID is null And
	A.InventoryAccountID is null And
	A.TranMonth is null And
	A.TranYear is null And
	V.DivisionID = @DivisionID And
	V.TranMonth = @TranMonth And
	V.TranYear = @TranYear


  --- Update số liệu kho từ bảng tạm
  Update A Set     
  A.DebitQuantity = isnull(V.DebitQuantity,0),    
  A.DebitAmount = isnull(V.DebitAmount,0),    
  A.InDebitQuantity = isnull(V.InDebitQuantity,0),    
  A.InDebitAmount = isnull(V.InDebitAmount,0),    
  A.CreditQuantity = isnull(V.CreditQuantity,0),    
  A.CreditAmount = isnull(V.CreditAmount,0),    
  A.InCreditQuantity = isnull(V.InCreditQuantity,0),    
  A.InCreditAmount = isnull(V.InCreditAmount,0),    
  A.EndQuantity = isnull(A.BeginQuantity,0) + isnull(V.DebitQuantity,0) - isnull(V.CreditQuantity,0),    
  A.EndAmount = isnull(A.BeginAmount,0) + isnull(V.DebitAmount,0) - isnull(V.CreditAmount,0)    
  From AT2008_QC A Left Join #TAM V    
  On  A.DivisionID = V.DivisionID And    
	A.WareHouseID = V.WareHouseID And    
	A.InventoryID = V.InventoryID And    
	A.InventoryAccountID = V.InventoryAccountID And    
	A.TranMonth = V.TranMonth And    
	A.TranYear = V.TranYear AND 
	ISNULL(A.S01ID,'') = ISNULL(V.S01ID,'') AND 
	ISNULL(A.S02ID,'') = ISNULL(V.S02ID,'') AND
	ISNULL(A.S03ID,'') = ISNULL(V.S03ID,'') AND
	ISNULL(A.S04ID,'') = ISNULL(V.S04ID,'') AND
	ISNULL(A.S05ID,'') = ISNULL(V.S05ID,'') AND 
	ISNULL(A.S06ID,'') = ISNULL(V.S06ID,'') AND
	ISNULL(A.S07ID,'') = ISNULL(V.S07ID,'') AND
	ISNULL(A.S08ID,'') = ISNULL(V.S08ID,'') AND
	ISNULL(A.S09ID,'') = ISNULL(V.S09ID,'') AND
	ISNULL(A.S10ID,'') = ISNULL(V.S10ID,'') AND
	ISNULL(A.S11ID,'') = ISNULL(V.S11ID,'') AND 
	ISNULL(A.S12ID,'') = ISNULL(V.S12ID,'') AND
	ISNULL(A.S13ID,'') = ISNULL(V.S13ID,'') AND
	ISNULL(A.S14ID,'') = ISNULL(V.S14ID,'') AND
	ISNULL(A.S15ID,'') = ISNULL(V.S15ID,'') AND
	ISNULL(A.S16ID,'') = ISNULL(V.S16ID,'') AND
	ISNULL(A.S17ID,'') = ISNULL(V.S17ID,'') AND
	ISNULL(A.S18ID,'') = ISNULL(V.S18ID,'') AND
	ISNULL(A.S19ID,'') = ISNULL(V.S19ID,'') AND
	ISNULL(A.S20ID,'') = ISNULL(V.S20ID,'')    
  Where     
	A.DivisionID = @DivisionID And    
	A.WareHouseID In (@WareHouseID_Old, @WareHouseID2_Old, @WareHouseID_New, @WareHouseID2_New) And    
	A.InventoryID = @InventoryID And    
	A.TranMonth = @TranMonth And    
	A.TranYear = @TranYear  AND 
	ISNULL(A.S01ID,'') = ISNULL(@S01ID,'') AND 
	ISNULL(A.S02ID,'') = ISNULL(@S02ID,'') AND
	ISNULL(A.S03ID,'') = ISNULL(@S03ID,'') AND
	ISNULL(A.S04ID,'') = ISNULL(@S04ID,'') AND
	ISNULL(A.S05ID,'') = ISNULL(@S05ID,'') AND 
	ISNULL(A.S06ID,'') = ISNULL(@S06ID,'') AND
	ISNULL(A.S07ID,'') = ISNULL(@S07ID,'') AND
	ISNULL(A.S08ID,'') = ISNULL(@S08ID,'') AND
	ISNULL(A.S09ID,'') = ISNULL(@S09ID,'') AND
	ISNULL(A.S10ID,'') = ISNULL(@S10ID,'') AND
	ISNULL(A.S11ID,'') = ISNULL(@S11ID,'') AND 
	ISNULL(A.S12ID,'') = ISNULL(@S12ID,'') AND
	ISNULL(A.S13ID,'') = ISNULL(@S13ID,'') AND
	ISNULL(A.S14ID,'') = ISNULL(@S14ID,'') AND
	ISNULL(A.S15ID,'') = ISNULL(@S15ID,'') AND
	ISNULL(A.S16ID,'') = ISNULL(@S16ID,'') AND
	ISNULL(A.S17ID,'') = ISNULL(@S17ID,'') AND
	ISNULL(A.S18ID,'') = ISNULL(@S18ID,'') AND
	ISNULL(A.S19ID,'') = ISNULL(@S19ID,'') AND
	ISNULL(A.S20ID,'') = ISNULL(@S20ID,'')  



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
