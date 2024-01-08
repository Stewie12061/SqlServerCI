IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP1008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[BP1008]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO
 
--- Created by B.Anh	Date: 05/12/2010
--- Purpose: In bao cao nhap xuat ton theo seri cho tat ca cac kho

CREATE PROCEDURE BP1008  	@DivisionID as varchar(50),
					@FromMonth as int,
					@ToMonth as int,
					@FromYear as int,
					@ToYear as int,
					@FromDate as datetime,
					@ToDate as datetime,
					@FromInventoryID as varchar(50),
					@ToInventoryID as varchar(50),
					@IsDate as tinyint
 
AS
Declare @sSQL1 as varchar(max),
		@sSQL2 as varchar(max),
		@sSQL3 as varchar(max),
		@sSQL4 as varchar(max)

-------------------------------------Xac dinh so du
Set @sSQL1 ='
	Select DivisionID,SeriNo, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, 0 as DebitQuantity, 0 as CreditQuantity,
		0 as EndQuantity, I01ID, I02ID, I03ID, I04ID, I05ID, 
		InventoryTypeID,Specification,	Notes01, Notes02, Notes03, Sum(SignQuantity)  as BeginQuantity
	Into #BV7016
	From BV7000
	Where ' + case when @IsDate = 0 then + '(TranMonth  +100*TranYear < '+ ltrim(str(@FromMonth + @FromYear*100)) + ')'
		else + '(VoucherDate<'''+ Convert(varchar(10),@FromDate,101) + ''' Or D_C=''BD'')' end
		+ ' and DivisionID like ''' + @DivisionID + ''' and
		(InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''') 
	Group by DivisionID, SeriNo,WareHouseID,InventoryID,InventoryName, UnitID, UnitName,
		  I01ID, I02ID, I03ID, I04ID, I05ID ,InventoryTypeID,Specification, Notes01, Notes02, Notes03'
 
--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='BV7016')
--	Exec('Create view BV7016 as '+@sSQL)
--Else
--	Exec('Alter view BV7016 as '+@sSQL)

Set @sSQL2 ='
	Select DivisionID, SeriNo,InventoryID,InventoryName,UnitID,
		I01ID, I02ID, I03ID, I04ID, I05ID , InventoryTypeID, Specification,
		Notes01, Notes02, Notes03, UnitName,
		BeginQuantity,
		0 as DebitQuantity,
		0 as CreditQuantity,
		0 as EndQuantity
	Into #BV3088
	From #BV7016 BV7016
	Where 	SeriNo not in (Select SeriNo From BV7001 BV7000
					Where 	BV7000.DivisionID like '''+@DivisionID+''' and						
						(BV7000.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''') and
						BV7000.D_C in (''D'', ''C'') and ' +
						case when @IsDate = 0 then + '(BV7000.TranMonth + 100*BV7000.TranYear between ' + ltrim(str(@FromMonth + @FromYear*100)) +' and '+ ltrim(str(@ToMonth + @ToYear*100)) + ')'
						else + 'BV7000.VoucherDate between ''' + Convert(varchar(10),@FromDate,101) + ''' and ''' + Convert(varchar(10),@ToDate,101) + '''' end + ')'

Set @sSQL2 = @sSQL2 +'
Union all
Select BV7000.DivisionID, BV7000.SeriNo, BV7000.InventoryID,
	BV7000.InventoryName,
	BV7000.UnitID,
	BV7000.I01ID, BV7000.I02ID, BV7000.I03ID, BV7000.I04ID, BV7000.I05ID,  BV7000. InventoryTypeID,
        	BV7000.Specification , 	BV7000.Notes01,  BV7000.Notes02,  BV7000.Notes03,
	BV7000.UnitName,
	isnull(AV7016.BeginQuantity,0) as BeginQuantity,
	Sum(Case when D_C = ''D'' then isnull(BV7000.Quantity,0) else 0 end) as DebitQuantity,
	Sum(Case when D_C = ''C'' then isnull(BV7000.Quantity,0) else 0 end) as CreditQuantity,
	0 as EndQuantity

From  BV7001 BV7000 left join #BV7016 AV7016 on (BV7000.DivisionID = AV7016.DivisionID and BV7000.SeriNo = AV7016.SeriNo)
		
Where 	BV7000.DivisionID like '''+@DivisionID+''' and
	(BV7000.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''') and
	BV7000.D_C in (''D'', ''C'') and ' +
	case when @IsDate = 0 then + '(BV7000.TranMonth + 100*BV7000.TranYear between ' + ltrim(str(@FromMonth + @FromYear*100)) +' and '+ ltrim(str(@ToMonth + @ToYear*100)) + ')'
	else + 'BV7000.VoucherDate between ''' + Convert(varchar(10),@FromDate,101) + ''' and ''' + Convert(varchar(10),@ToDate,101) + '''' end +'
Group by BV7000.DivisionID, BV7000.SeriNo, BV7000.InventoryID, BV7000.InventoryName, BV7000.UnitID, BV7000.UnitName, AV7016.BeginQuantity,
	  BV7000.I01ID, BV7000.I02ID, BV7000.I03ID, BV7000.I04ID, BV7000.I05ID,  
	  BV7000.InventoryTypeID, BV7000.Specification, BV7000.Notes01,  BV7000.Notes02,  BV7000.Notes03 
 '

--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='BV3088')
--	Exec(' Create view BV3088 as '+@sSQL)
--Else
--	Exec(' Alter view BV3088 as '+@sSQL)
--print @sSQL

Set @sSQL3 = '
Select AV3088.DivisionID, AV3088.SeriNo, AV3088.InventoryID,
	InventoryName,
	AV3088.UnitID,
	UnitName ,  AV3088. InventoryTypeID, Specification ,
	AV3088.Notes01,  AV3088.Notes02,  AV3088.Notes03,
	AT1309.UnitID as ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator,
	I01ID, I02ID, I03ID, I04ID, I05ID, 
	sum(BeginQuantity) as BeginQuantity,
	DebitQuantity,
	CreditQuantity,
	0 as InDebitQuantity, 
	0 as InCreditQuantity,
	Sum(BeginQuantity) + DebitQuantity - CreditQuantity as EndQuantity
Into #BV3098
From  #BV3088 AV3088 Left join AT1309 on AT1309.InventoryID = AV3088.InventoryID
Group by AV3088.DivisionID, AV3088.SeriNo, AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, 
		AT1309.UnitID , AT1309.ConversionFactor, AT1309.Operator,
		I01ID, I02ID, I03ID, I04ID, I05ID,
		DebitQuantity, CreditQuantity, AV3088. InventoryTypeID, Specification, AV3088.Notes01,  AV3088.Notes02,  AV3088.Notes03'

--Print @sSQL

--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='BV3098')
--	Exec(' Create view BV3098 as '+@sSQL)
--Else
--	Exec(' Alter view BV3098 as '+@sSQL)

Set @sSQL4 = '
Select AV3098.DivisionID, AV3098.SeriNo, AV3098.InventoryID,
	AV3098.I01ID, AV3098.I02ID, AV3098.I03ID, AV3098.I04ID, AV3098.I05ID, InventoryTypeID,Specification,
	AV3098.Notes01, AV3098.Notes02, AV3098.Notes03,
	AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, 
	AV3098.ConversionUnitID , AV3098.ConversionFactor, AV3098.Operator,
	AV3098.BeginQuantity, AV3098.EndQuantity, 
	Case when AV3098.ConversionFactor = null or AV3098.ConversionFactor =0 then Null
	Else isnull(AV3098.EndQuantity,0) / AV3098.ConversionFactor End as ConversionQuantity,
	AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.InDebitQuantity, AV3098.InCreditQuantity
From #BV3098 as AV3098 
Where BeginQuantity <> 0 or DebitQuantity <> 0 or CreditQuantity <> 0 or EndQuantity <> 0'

--print  @sSQL
EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)

--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='BV3008')
--	Exec(' Create view BV3008 as '+@sSQL)
--Else
--	Exec(' Alter view BV3008 as '+@sSQL)
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
