IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0600_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0600_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by Tiểu Mai on 16/06/2016
--- Purpose cap nhat so du cho cac kho theo quy cach


CREATE PROCEDURE [dbo].[AP0600_QC] 	
				@KindVoucherID as tinyint, @DivisionID varchar(50), @TranMonth int, @TranYear int,
				@WareHouseID nvarchar(50), @WareHouseID2 nvarchar(50), @InventoryID as nvarchar(50),
				@DebitAccountID_Old nvarchar(50),  @CreditAccountID_Old nvarchar(50),  @DebitAccountID_New nvarchar(50), @CreditAccountID_New nvarchar(50), 
				@OldQuantity decimal(28, 8), @NewQuantity decimal(28, 8), @OldConvertedAmount decimal(28, 8), @NewConvertedAmount decimal(28, 8),
				@Parameter01 AS DECIMAL(28,8), @Parameter02 AS DECIMAL(28,8), @Parameter03 AS DECIMAL(28,8), @Parameter04 AS DECIMAL(28,8), @Parameter05 AS DECIMAL(28,8),
				@OldMarkQuantity AS DECIMAL(28,8), @NewMarkQuantity AS DECIMAL(28,8), @S01ID VARCHAR(50),@S02ID VARCHAR(50), @S03ID VARCHAR(50), @S04ID VARCHAR(50), @S05ID VARCHAR(50),
				@S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50), @S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50),
				@S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50), @S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50)
AS

-----<<<----------------
----------------------============================================----------------------------------------------------
--Print ' Kind: '+str(@KindVoucherID)+' New :' +@CreditAccountID_Old+'  ' +@CreditAccountID_New
If @KindVoucherID in (1,5,7,9,15,17) --- truong hop nhap kho
	 Begin
		If @DebitAccountID_Old = @DebitAccountID_New
		  	Begin	
		   		Update AT2008_QC		
				Set 	DebitQuantity 	=	isnull(DebitQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
					DebitAmount 	=	isnull(DebitAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) 
		 		Where 	InventoryID =@InventoryID and
					DivisionID =@DivisionID and
					WareHouseID =@WareHouseID and
					InventoryAccountID = @DebitAccountID_New  and
					TranMonth =@TranMonth and
					TranYear =@TranYear AND 
					ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
					ISNULL(S02ID,'') = isnull(@S02ID,'') AND
					ISNULL(S03ID,'') = isnull(@S03ID,'') AND
					ISNULL(S04ID,'') = isnull(@S04ID,'') AND
					ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
					ISNULL(S06ID,'') = isnull(@S06ID,'') AND
					ISNULL(S07ID,'') = isnull(@S07ID,'') AND
					ISNULL(S08ID,'') = isnull(@S08ID,'') AND
					ISNULL(S09ID,'') = isnull(@S09ID,'') AND
					ISNULL(S10ID,'') = isnull(@S10ID,'') AND
					ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
					ISNULL(S12ID,'') = isnull(@S12ID,'') AND
					ISNULL(S13ID,'') = isnull(@S13ID,'') AND
					ISNULL(S14ID,'') = isnull(@S14ID,'') AND
					ISNULL(S15ID,'') = isnull(@S15ID,'') AND
					ISNULL(S16ID,'') = isnull(@S16ID,'') AND
					ISNULL(S17ID,'') = isnull(@S17ID,'') AND
					ISNULL(S18ID,'') = isnull(@S18ID,'') AND
					ISNULL(S19ID,'') = isnull(@S19ID,'') AND
					ISNULL(S20ID,'') = isnull(@S20ID,'')					

				Update AT2008_QC		
				Set 	EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0),
					EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) 
		 		Where 	InventoryID =@InventoryID and
					DivisionID =@DivisionID and
					WareHouseID =@WareHouseID and
					InventoryAccountID = @DebitAccountID_New  and
					TranMonth =@TranMonth and
					TranYear =@TranYear AND 
					ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
					ISNULL(S02ID,'') = isnull(@S02ID,'') AND
					ISNULL(S03ID,'') = isnull(@S03ID,'') AND
					ISNULL(S04ID,'') = isnull(@S04ID,'') AND
					ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
					ISNULL(S06ID,'') = isnull(@S06ID,'') AND
					ISNULL(S07ID,'') = isnull(@S07ID,'') AND
					ISNULL(S08ID,'') = isnull(@S08ID,'') AND
					ISNULL(S09ID,'') = isnull(@S09ID,'') AND
					ISNULL(S10ID,'') = isnull(@S10ID,'') AND
					ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
					ISNULL(S12ID,'') = isnull(@S12ID,'') AND
					ISNULL(S13ID,'') = isnull(@S13ID,'') AND
					ISNULL(S14ID,'') = isnull(@S14ID,'') AND
					ISNULL(S15ID,'') = isnull(@S15ID,'') AND
					ISNULL(S16ID,'') = isnull(@S16ID,'') AND
					ISNULL(S17ID,'') = isnull(@S17ID,'') AND
					ISNULL(S18ID,'') = isnull(@S18ID,'') AND
					ISNULL(S19ID,'') = isnull(@S19ID,'') AND
					ISNULL(S20ID,'') = isnull(@S20ID,'')
            End
		Else
		   Begin
			
			Exec AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @OldConvertedAmount, @OldQuantity, @DebitAccountID_Old , @CreditAccountID_Old, 1, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID  -- (1) la cap nhat tang,(0 ) la cap nhat giam
			Exec AP0512_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @NewConvertedAmount, @NewQuantity, @DebitAccountID_New , @CreditAccountID_New, 1, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam
		   End
 	End --- Of Nhap kho
----------------------============================================----------------------------------------------------
	If @KindVoucherID in (2,4,6,8,10,14,20) --- truong hop Xuat kho
		Begin
		   	 If @CreditAccountID_Old = @CreditAccountID_New
				Begin
					Update AT2008_QC			 
						Set 	CreditQuantity 	=		isnull(CreditQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
							CreditAmount 	=		isnull(CreditAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) 
							--EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0),  --isnull(EndQuantity,0)	+ isnull(@OldQuantity,0) -  isnull(@NewQuantity,0),
							--EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) --isnull(EndAmount,0)		+ Isnull(@OldConvertedAmount,0) - Isnull(@NewConvertedAmount,0) 
					 Where 		InventoryID =@InventoryID and
							DivisionID =@DivisionID and
							WareHouseID =@WareHouseID and
							InventoryAccountID = @CreditAccountID_New and
							TranMonth =@TranMonth and
							TranYear =@TranYear AND 
						ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
						ISNULL(S02ID,'') = isnull(@S02ID,'') AND
						ISNULL(S03ID,'') = isnull(@S03ID,'') AND
						ISNULL(S04ID,'') = isnull(@S04ID,'') AND
						ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
						ISNULL(S06ID,'') = isnull(@S06ID,'') AND
						ISNULL(S07ID,'') = isnull(@S07ID,'') AND
						ISNULL(S08ID,'') = isnull(@S08ID,'') AND
						ISNULL(S09ID,'') = isnull(@S09ID,'') AND
						ISNULL(S10ID,'') = isnull(@S10ID,'') AND
						ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
						ISNULL(S12ID,'') = isnull(@S12ID,'') AND
						ISNULL(S13ID,'') = isnull(@S13ID,'') AND
						ISNULL(S14ID,'') = isnull(@S14ID,'') AND
						ISNULL(S15ID,'') = isnull(@S15ID,'') AND
						ISNULL(S16ID,'') = isnull(@S16ID,'') AND
						ISNULL(S17ID,'') = isnull(@S17ID,'') AND
						ISNULL(S18ID,'') = isnull(@S18ID,'') AND
						ISNULL(S19ID,'') = isnull(@S19ID,'') AND
						ISNULL(S20ID,'') = isnull(@S20ID,'')
						
					Update AT2008_QC		
						Set 	EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0),
							EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) 
				 		Where 	InventoryID =@InventoryID and
							DivisionID =@DivisionID and
							WareHouseID =@WareHouseID and
							InventoryAccountID = @CreditAccountID_New  and
							TranMonth =@TranMonth and
							TranYear =@TranYear AND 
							ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
							ISNULL(S02ID,'') = isnull(@S02ID,'') AND
							ISNULL(S03ID,'') = isnull(@S03ID,'') AND
							ISNULL(S04ID,'') = isnull(@S04ID,'') AND
							ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
							ISNULL(S06ID,'') = isnull(@S06ID,'') AND
							ISNULL(S07ID,'') = isnull(@S07ID,'') AND
							ISNULL(S08ID,'') = isnull(@S08ID,'') AND
							ISNULL(S09ID,'') = isnull(@S09ID,'') AND
							ISNULL(S10ID,'') = isnull(@S10ID,'') AND
							ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
							ISNULL(S12ID,'') = isnull(@S12ID,'') AND
							ISNULL(S13ID,'') = isnull(@S13ID,'') AND
							ISNULL(S14ID,'') = isnull(@S14ID,'') AND
							ISNULL(S15ID,'') = isnull(@S15ID,'') AND
							ISNULL(S16ID,'') = isnull(@S16ID,'') AND
							ISNULL(S17ID,'') = isnull(@S17ID,'') AND
							ISNULL(S18ID,'') = isnull(@S18ID,'') AND
							ISNULL(S19ID,'') = isnull(@S19ID,'') AND
							ISNULL(S20ID,'') = isnull(@S20ID,'')
				End
			Else
				Begin
					Exec AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @OldConvertedAmount, @OldQuantity, @DebitAccountID_Old , @CreditAccountID_Old, 0, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam
					Exec AP0512_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @NewConvertedAmount, @NewQuantity, @DebitAccountID_New , @CreditAccountID_New, 0, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam
				End

		  End --- Of Xuat kho
----------------------============================================----------------------------------------------------
		if @KindVoucherID =3  --- Nhap VCNB
			Begin
				---- Kho nhap
			      IF 	@DebitAccountID_Old = @DebitAccountID_New
				Begin
					Update AT2008_QC		
					Set DebitQuantity 	=	isnull(DebitQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
						DebitAmount 	=	isnull(DebitAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) ,--Date 14/01/2014
						InDebitQuantity  = 	isnull(InDebitQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
						InDebitAmount 	=	isnull(InDebitAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) --Date 14/01/2014
						--EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0), -- EndQuantity		=	isnull(EndQuantity,0)		- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
						--EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) --EndAmount		=	isnull(EndAmount,0)		- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) 
					 Where 		InventoryID =@InventoryID and
							DivisionID =@DivisionID and
							WareHouseID =@WareHouseID and
							InventoryAccountID = @DebitAccountID_New and
							TranMonth =@TranMonth and
							TranYear =@TranYear AND 
							ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
							ISNULL(S02ID,'') = isnull(@S02ID,'') AND
							ISNULL(S03ID,'') = isnull(@S03ID,'') AND
							ISNULL(S04ID,'') = isnull(@S04ID,'') AND
							ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
							ISNULL(S06ID,'') = isnull(@S06ID,'') AND
							ISNULL(S07ID,'') = isnull(@S07ID,'') AND
							ISNULL(S08ID,'') = isnull(@S08ID,'') AND
							ISNULL(S09ID,'') = isnull(@S09ID,'') AND
							ISNULL(S10ID,'') = isnull(@S10ID,'') AND
							ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
							ISNULL(S12ID,'') = isnull(@S12ID,'') AND
							ISNULL(S13ID,'') = isnull(@S13ID,'') AND
							ISNULL(S14ID,'') = isnull(@S14ID,'') AND
							ISNULL(S15ID,'') = isnull(@S15ID,'') AND
							ISNULL(S16ID,'') = isnull(@S16ID,'') AND
							ISNULL(S17ID,'') = isnull(@S17ID,'') AND
							ISNULL(S18ID,'') = isnull(@S18ID,'') AND
							ISNULL(S19ID,'') = isnull(@S19ID,'') AND
							ISNULL(S20ID,'') = isnull(@S20ID,'')
					
					UPDATE AT2008_QC		
					Set 	EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0),
						EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) 
			 		Where 	InventoryID =@InventoryID and
						DivisionID =@DivisionID and
						WareHouseID =@WareHouseID and
						InventoryAccountID = @DebitAccountID_New  and
						TranMonth =@TranMonth and
						TranYear =@TranYear AND 
						ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
						ISNULL(S02ID,'') = isnull(@S02ID,'') AND
						ISNULL(S03ID,'') = isnull(@S03ID,'') AND
						ISNULL(S04ID,'') = isnull(@S04ID,'') AND
						ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
						ISNULL(S06ID,'') = isnull(@S06ID,'') AND
						ISNULL(S07ID,'') = isnull(@S07ID,'') AND
						ISNULL(S08ID,'') = isnull(@S08ID,'') AND
						ISNULL(S09ID,'') = isnull(@S09ID,'') AND
						ISNULL(S10ID,'') = isnull(@S10ID,'') AND
						ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
						ISNULL(S12ID,'') = isnull(@S12ID,'') AND
						ISNULL(S13ID,'') = isnull(@S13ID,'') AND
						ISNULL(S14ID,'') = isnull(@S14ID,'') AND
						ISNULL(S15ID,'') = isnull(@S15ID,'') AND
						ISNULL(S16ID,'') = isnull(@S16ID,'') AND
						ISNULL(S17ID,'') = isnull(@S17ID,'') AND
						ISNULL(S18ID,'') = isnull(@S18ID,'') AND
						ISNULL(S19ID,'') = isnull(@S19ID,'') AND
						ISNULL(S20ID,'') = isnull(@S20ID,'')
				End
			   ELSE	
				Begin
					Exec AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @OldConvertedAmount, @OldQuantity, @DebitAccountID_Old , @CreditAccountID_Old, 11, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam; 11 la cho VCNB
					Exec AP0512_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @NewConvertedAmount, @NewQuantity, @DebitAccountID_New , @CreditAccountID_New, 11, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam
				End
			
				---- Kho Xuat
				If @CreditAccountID_New = @CreditAccountID_Old
					Begin
						Update AT2008_QC		
						Set CreditQuantity 	=	isnull(CreditQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
							CreditAmount 	=	isnull(CreditAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) ,
							InCreditQuantity  = 	isnull(InCreditQuantity,0)	- isnull(@OldQuantity,0) +  isnull(@NewQuantity,0),
							InCreditAmount 	=	isnull(InCreditAmount,0)	- Isnull(@OldConvertedAmount,0) + Isnull(@NewConvertedAmount,0) 
							--EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0), --EndQuantity		=	isnull(EndQuantity,0)		+ isnull(@OldQuantity,0) -  isnull(@NewQuantity,0),
							--EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) --EndAmount		=	isnull(EndAmount,0)		+ Isnull(@OldConvertedAmount,0) - Isnull(@NewConvertedAmount,0) 
						 Where 		InventoryID =@InventoryID and
								DivisionID =@DivisionID and
								WareHouseID =@WareHouseID2 and
								InventoryAccountID =@CreditAccountID_New and
								TranMonth =@TranMonth and
								TranYear =@TranYear AND 
								ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
								ISNULL(S02ID,'') = isnull(@S02ID,'') AND
								ISNULL(S03ID,'') = isnull(@S03ID,'') AND
								ISNULL(S04ID,'') = isnull(@S04ID,'') AND
								ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
								ISNULL(S06ID,'') = isnull(@S06ID,'') AND
								ISNULL(S07ID,'') = isnull(@S07ID,'') AND
								ISNULL(S08ID,'') = isnull(@S08ID,'') AND
								ISNULL(S09ID,'') = isnull(@S09ID,'') AND
								ISNULL(S10ID,'') = isnull(@S10ID,'') AND
								ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
								ISNULL(S12ID,'') = isnull(@S12ID,'') AND
								ISNULL(S13ID,'') = isnull(@S13ID,'') AND
								ISNULL(S14ID,'') = isnull(@S14ID,'') AND
								ISNULL(S15ID,'') = isnull(@S15ID,'') AND
								ISNULL(S16ID,'') = isnull(@S16ID,'') AND
								ISNULL(S17ID,'') = isnull(@S17ID,'') AND
								ISNULL(S18ID,'') = isnull(@S18ID,'') AND
								ISNULL(S19ID,'') = isnull(@S19ID,'') AND
								ISNULL(S20ID,'') = isnull(@S20ID,'')
						
						UPDATE AT2008_QC		
						Set 	EndQuantity		=	isnull(BeginQuantity,0) + isnull(DebitQuantity,0) - isnull(CreditQuantity,0),
							EndAmount		=	isnull(BeginAmount,0) + isnull(DebitAmount,0) - isnull(CreditAmount,0) 
				 		Where 	InventoryID =@InventoryID and
							DivisionID =@DivisionID and
							WareHouseID =@WareHouseID2 and
							InventoryAccountID = @CreditAccountID_New  and
							TranMonth =@TranMonth and
							TranYear =@TranYear AND 
							ISNULL(S01ID,'') = Isnull(@S01ID,'') AND 
							ISNULL(S02ID,'') = isnull(@S02ID,'') AND
							ISNULL(S03ID,'') = isnull(@S03ID,'') AND
							ISNULL(S04ID,'') = isnull(@S04ID,'') AND
							ISNULL(S05ID,'') = isnull(@S05ID,'') AND 
							ISNULL(S06ID,'') = isnull(@S06ID,'') AND
							ISNULL(S07ID,'') = isnull(@S07ID,'') AND
							ISNULL(S08ID,'') = isnull(@S08ID,'') AND
							ISNULL(S09ID,'') = isnull(@S09ID,'') AND
							ISNULL(S10ID,'') = isnull(@S10ID,'') AND
							ISNULL(S11ID,'') = isnull(@S11ID,'') AND 
							ISNULL(S12ID,'') = isnull(@S12ID,'') AND
							ISNULL(S13ID,'') = isnull(@S13ID,'') AND
							ISNULL(S14ID,'') = isnull(@S14ID,'') AND
							ISNULL(S15ID,'') = isnull(@S15ID,'') AND
							ISNULL(S16ID,'') = isnull(@S16ID,'') AND
							ISNULL(S17ID,'') = isnull(@S17ID,'') AND
							ISNULL(S18ID,'') = isnull(@S18ID,'') AND
							ISNULL(S19ID,'') = isnull(@S19ID,'') AND
							ISNULL(S20ID,'') = isnull(@S20ID,'')
					End
				Else

				Begin
					Exec AP0513_QC @DivisionID, @WareHouseID2, @TranMonth, @TranYear, @InventoryID, @OldConvertedAmount, @OldQuantity, @DebitAccountID_Old , @CreditAccountID_Old, 10, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam; 10 la cho VCNB
					Exec AP0512_QC @DivisionID, @WareHouseID2, @TranMonth, @TranYear, @InventoryID, @NewConvertedAmount, @NewQuantity, @DebitAccountID_New , @CreditAccountID_New, 10, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
									@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam

				End
			End
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

