IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[WY2026]'))
DROP TRIGGER [dbo].[WY2026]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Created by Khanh Van
--Date 01/07/2013
--Purpose: Insert master phieu xuat kho va nhap kho nguyen vat lieu AT2006



CREATE TRIGGER [dbo].[WY2026]  ON [dbo].[WT2026]
FOR INSERT As
Declare		@D26_Cursor		Cursor,
			@D26_Cursor1		Cursor,
			@BaseCurrencyID as nVarchar(50)

Declare  	
	@DivisionID		nVarchar(50),	
	@VoucherTypeID	nVarchar(50),			
	@RDVoucherID	nVarchar(50), 	
	@RDVoucherNo	nVarchar(50),	
	@RDVoucherDate	Datetime,			
	@TranYear		Int,		
	@TranMonth		int,
	@WareHouseID	nVarchar(50),	
	@WareHouseID2	nVarchar(50),	
	@Description	nVarchar(255),	
	@CreateUserID	nVarchar(50),	
	@CreateDate		Datetime,
	@LastModifyUserID	nVarchar(50),	
	@LastModifyDate	Datetime,

	@EmployeeID		nVarchar(50),	
	@ObjectID		nVarchar(50),
	@Status			tinyint,
	@BatchID		nVarchar(50),
	@TableID 		nVarchar(50),
	@OrderID		nVarchar(50),
	@RefNo01		nVarchar(50),
	@RefNo02		nVarchar(50)


Set @D26_Cursor = Cursor Scroll KeySet For
Select 		ins.DivisionID, ins.VoucherID, ins.TranYear, ins.TranMonth,   ---- Thong tin chung
		Ins.VoucherDate,  Ins.VoucherNo, 
		EmployeeID,  Ins.ObjectID,   Ins.CreateUserID, Ins.CreateDate,  
		Ins.LastModifyUserID, Ins.LastModifyDate, Description,		
		Ins.WareHouseID, 0, Ins.BatchID,
		Ins.TableID,
		Ins.VoucherTypeID,
		Ins.OrderID, RefNo01, RefNo02				

From 	inserted ins 


Open @D26_Cursor
Fetch Next From @D26_Cursor Into @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   
		@RDVoucherDate,  @RDVoucherNo, 
		@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
		@LastModifyUserID, @LastModifyDate, @Description,
		@WareHouseID, @Status, @BatchID, @TableID,
		@VoucherTypeID, @OrderID, @RefNo01, @RefNo02				
                                         

While @@FETCH_STATUS = 0
Begin	
	
	INSERT INTO AT2006 	(DivisionID, VoucherID, TranYear, TranMonth,
				VoucherDate, VoucherNo, KindVoucherID,
				EmployeeID, ObjectID, CreateUserID, CreateDate, 
				LastModifyUserID, LastModifyDate, Description,
				WareHouseID, Status, BatchID, TableID,InventoryTypeID,
				VoucherTypeID, OrderID, RefNo01, RefNo02)
		VALUES	(@DivisionID, @RDVoucherID, @TranYear, @TranMonth,  
				@RDVoucherDate,  @RDVoucherNo, 2,
				@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
				@LastModifyUserID, @LastModifyDate, @Description,
				@WareHouseID, @Status, @BatchID, 'AT2006','%',
				@VoucherTypeID, @OrderID, @RefNo01, @RefNo02)


	Fetch Next From @D26_Cursor Into @DivisionID, @RDVoucherID, @TranYear, @TranMonth,  
			@RDVoucherDate,  @RDVoucherNo, 
			@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
			@LastModifyUserID, @LastModifyDate, @Description,
			@WareHouseID, @Status, @BatchID, @TableID,
			@VoucherTypeID, @OrderID, @RefNo01, @RefNo02				
                                       

End
Close @D26_Cursor
DeAllocate @D26_Cursor
Set @D26_Cursor1 = Cursor Scroll KeySet For
Select 		ins.DivisionID, ins.VoucherID, ins.TranYear, ins.TranMonth,   ---- Thong tin chung
		Ins.VoucherDate,  Ins.VoucherNo, 
		EmployeeID,  Ins.ObjectID,   Ins.CreateUserID, Ins.CreateDate,  
		Ins.LastModifyUserID, Ins.LastModifyDate, Description,		
		Ins.WareHouseID2, 0, Ins.BatchID,
		Ins.TableID, (SELECT top 1 VoucherTypeID  FROM AT1007 WHERE Disabled  = 0 AND VoucherGroupID IN ('31')),
		Ins.OrderID, RefNo01, RefNo02				

From 	inserted ins 


Open @D26_Cursor1
Fetch Next From @D26_Cursor1 Into @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   
		@RDVoucherDate,  @RDVoucherNo, 
		@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
		@LastModifyUserID, @LastModifyDate, @Description,
		@WareHouseID2, @Status, @BatchID, @TableID,
		@VoucherTypeID, @OrderID, @RefNo01, @RefNo02				
                                         

While @@FETCH_STATUS = 0
Begin	
	
	INSERT INTO AT2006 	(DivisionID, VoucherID, TranYear, TranMonth,
				VoucherDate, VoucherNo, KindVoucherID,
				EmployeeID, ObjectID, CreateUserID, CreateDate, 
				LastModifyUserID, LastModifyDate, Description,
				WareHouseID, Status, BatchID, TableID,InventoryTypeID,
				VoucherTypeID, OrderID, RefNo01, RefNo02,IsGoodsRecycled)
		VALUES	(@DivisionID, 'NNL'+@RDVoucherID, @TranYear, @TranMonth,  
				@RDVoucherDate,  @RDVoucherNo, 1,
				@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
				@LastModifyUserID, @LastModifyDate, @Description,
				@WareHouseID2, @Status, @BatchID, 'AT2006','%',
				@VoucherTypeID, @OrderID, @RefNo01, @RefNo02,1)


	Fetch Next From @D26_Cursor1 Into @DivisionID, @RDVoucherID, @TranYear, @TranMonth,  
			@RDVoucherDate,  @RDVoucherNo, 
			@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  
			@LastModifyUserID, @LastModifyDate, @Description,
			@WareHouseID2, @Status, @BatchID, @TableID,
			@VoucherTypeID, @OrderID, @RefNo01, @RefNo02				
                                       

End
Close @D26_Cursor1
DeAllocate @D26_Cursor1
GO


