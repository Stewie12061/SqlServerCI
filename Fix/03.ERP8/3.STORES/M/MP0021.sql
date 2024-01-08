IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Chiet tinh gia thanh theo quy trinh san xuat.
---- Created by Nguyen Van Nhan, chiet tinh gia thanh theo quy trinh san xuat
---- Edit by: Dang Le Bao Quynh; Date: 19/11/2008
---- Purpose: Cai tien toc do xu ly
---- Modified on 22/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified on 13/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified on 17/08/2021 by Nhựt Trường: Điều chỉnh độ rộng cột khi tạo bảng MT1633.
---- Modified on 05/10/2021 by Nhựt Trường: Mở scrip tạo bảng MT1634, sử dụng ở store MP0022.
---- Modified on 22/11/2021 by Nhật Thanh: Customize cho Angel

CREATE PROCEDURE MP0021  	@DivisionID as varchar(50),
					@TranMonth as int,
					@TranYear as int,
					@ProcedureID as varchar(50)--- Kiem
 AS
Declare @sSQL as varchar(8000),
	@PeriodID as varchar(20),
	@Cur as Cursor,
	@EndPeriodID as varchar(20),
	@ProductID as varchar(20),
	@ProductQuantity as money,
	@MaterialID as varchar(20),
	@ConvertedUnit as money,
	@QuantityUnit as money,
	@NexPeriodID as varchar(20),
	@CustomerName int

	SET @CustomerName = (Select CustomerName from CustomerIndex)

Set Nocount on

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MT1633]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MT1633]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MT1634]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MT1634]

if (@CustomerName = 57)
BEGIN
	CREATE TABLE [dbo].[MT1633](
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [nvarchar](3) NOT NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[ExpenseID] [nvarchar](50) NULL,
	[QuantityUnit] [decimal](28, 8) NULL,
	[ConvertedUnit] [decimal](28, 8) NULL,
	[MaterialTypeID] [nvarchar](50) NULL,
	 CONSTRAINT [PK_MT1633] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[MT1633] ADD  DEFAULT (newid()) FOR [APK]
END
ELSE
BEGIN
	CREATE TABLE [dbo].[MT1633] (
		[DivisionID] [varchar] (50) NULL ,
		[PeriodID] [varchar] (50) NULL ,
		[ProductID] [varchar] (50) NULL ,
		[MaterialID] [varchar] (50) NULL ,
		[ExpenseID] [varchar] (50) NULL ,
		[QuantityUnit] [money] NULL ,
		[ConvertedUnit] [money] NULL ,
		[MaterialTypeID] [varchar] (50) NULL 
	) ON [PRIMARY]

	CREATE TABLE [dbo].[MT1634] (
		[ProductID] [varchar] (50) NULL ,
		[PeriodID] [varchar] (50) NULL ,
		[FixProductID] [varchar] (50) NULL ,
		[QuantityUnit] [decimal](28, 8) NULL ,
		[ConvertedUnit] [decimal](28, 8) NULL 
	) ON [PRIMARY]
END

Set @EndPeriodID =(Select top 1 PeriodID From MT1631 Where  ProcedureID=@ProcedureID Order by StepID Desc)

Set @sSQL ='
		Select  		D10.DivisionID , 
				D10.ProductID as ProductID, 
				AT1302.InventoryTypeID,  
				D10.UnitID , 
				sum(D10.Quantity) as ProductQuantity
		From MT1001 D10 
		inner join MT0810 D08 on D08.VoucherID = D10.VoucherID and D08.DivisionID = D10.DivisionID		
		inner join AT1302 on  AT1302.InventoryID = D10.ProductID AND AT1302.DivisionID IN (D10.DivisionID,''@@@'')
		where 	D08.PeriodID = '''+@EndPeriodID+''' and
			D08.DivisionID ='''+@DivisionID+''' and
			D08.ResultTypeID in (''R01'',''R03'')
	Group  by 
		   D10.DivisionID ,  D10.ProductID , AT1302.InventoryTypeID,  
		   D10.UnitID ' 	
	

if exists (select * from sysobjects where id = object_id(N'[dbo].[MT2222]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MT2222]
IF (@CustomerName = 57)
BEGIN
		CREATE TABLE [dbo].[MT2222](
		[APK] [uniqueidentifier] NOT NULL,
		[DivisionID] [nvarchar](3) NOT NULL,
		[ProductID] [nvarchar](50) NULL,
		[InventoryTypeID] [nvarchar](50) NULL,
		[UnitID] [nvarchar](50) NULL,
		[ProductQuantity] [decimal](28, 8) NULL,
		[PerfectRate] [decimal](28, 8) NULL,
		[MaterialRate] [decimal](28, 8) NULL,
		[HumanResourceRate] [decimal](28, 8) NULL,
		[OthersRate] [decimal](28, 8) NULL,
		 CONSTRAINT [PK_MT2222] PRIMARY KEY NONCLUSTERED 
			(
				[APK] ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

	ALTER TABLE [dbo].[MT2222] ADD  DEFAULT (newid()) FOR [APK]
END 
ELSE
BEGIn
	CREATE TABLE [dbo].[MT2222] (
		[DivisionID] [varchar] (20) NULL ,
		[ProductID] [varchar] (20) NULL ,
		[InventoryTypeID] [varchar] (20) NULL ,
		[UnitID] [varchar] (20) NULL ,
		[ProductQuantity] [decimal](28, 8) NULL,
		[PerfectRate] [money] null, 
		[MaterialRate] [money] null,  
		[HumanResourceRate] [money] null,  
		[OthersRate] [money] null 
		) ON [PRIMARY]

END
	INSERT MT2222(	DivisionID,
				ProductID ,
			         	 InventoryTypeID,
				 UnitID ,
			               ProductQuantity    
			     ) 

	EXEC (@sSQL)

------------------------------------------
/*
----1. Insert tat ca cac chi phi NC, SXC cho cong doan cuoi cung
Insert MT1633 ( PeriodID, MaterialID, ProductID, ExpenseID, MaterialTypeID, QuantityUnit, ConvertedUnit)
Select  PeriodID, null,  ProductID, ExpenseID, MaterialTypeID,QuantityUnit, ConvertedUnit
From MT4000
Where ExpenseID in ('COST002', 'COST003')   and PeriodID =@EndPeriodID and DivisionID =@DivisionID and isnull(ConvertedUnit,0)<>0

--Order by ProductID, ExpenseID, MaterialTypeID

-----2 Insert Chi phi NVL TT ma khong phai chuyen tu cong doan truoc ve -----------------------------------------------------
	Insert MT1633 ( PeriodID, MaterialID, ProductID, ExpenseID,  QuantityUnit, ConvertedUnit)
	Select PeriodID, MaterialID, ProductID, ExpenseID,  QuantityUnit, ConvertedUnit
	From MT4000 
	Where ExpenseID = 'COST001'   and PeriodID =@EndPeriodID and DivisionID =@DivisionID and
		MaterialID  not in (Select  ProductID From  MT1001 inner join MT0810 on MT1001.VoucherID = MT0810.VoucherID
								Where isnull(TransferPeriodID,'')=@EndPeriodID --and
								---PeriodID in (select PeriodID From MT1631 Where ProcedureID =@ProcedureID)
								)
-----3 Insert Chi phi NVL TT ma khong phai chuyen tu cong doan truoc ve -----------------------------------------------------
SET @Cur = Cursor Scroll KeySet FOR 
Select  ProductID,  MaterialID,   QuantityUnit, ConvertedUnit 
From MT4000 
Where ExpenseID = 'COST001'   and PeriodID =@EndPeriodID and DivisionID =@DivisionID and
		MaterialID  in (Select  ProductID From  MT1001 inner join MT0810 on MT1001.VoucherID = MT0810.VoucherID
								Where isnull(TransferPeriodID,'')=@EndPeriodID ---and
								---PeriodID in (select PeriodID From MT1631 Where ProcedureID =@ProcedureID)
								)

OPEN	@Cur
FETCH NEXT FROM @Cur INTO  @ProductID, @MaterialID, @QuantityUnit, @ConvertedUnit 
WHILE @@Fetch_Status = 0Begin
	---Print @MaterialID
   	Set @NexPeriodID =  (Select Top 1 PeriodID From  MT1001 inner join MT0810 on MT1001.VoucherID = MT0810.VoucherID
								Where isnull(TransferPeriodID,'')=@EndPeriodID-- and
								---PeriodID in (select PeriodID From MT1631 Where ProcedureID =@ProcedureID
								and ProductID = @MaterialID)--)	
	Insert MT1634 (PeriodID,  ProductID,  FixProductID, QuantityUnit, ConvertedUnit)
	Values  (@NexPeriodID, @MaterialID,  @ProductID, @QuantityUnit, @ConvertedUnit)


   FETCH NEXT FROM @Cur INTO  @ProductID, @MaterialID, @QuantityUnit, @ConvertedUnit 
End
Close @Cur
Deallocate @Cur
*/
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
