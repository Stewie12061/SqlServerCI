IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP4005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP4005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----- Created by Nguyen Van Nhan, Date 26/05/2004
---- Purpose Bang phan tich gia thanh
/********************************************
'* Edited by: [GS] [Thành Nguyên] [03/08/2010]
-- Modified by Bảo Thy on 24/05/2016: Bổ sung WITH (NOLOCK)
'********************************************/
---- Modified by Tiểu Mai on 18/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Nhựt Trường on 19/05/2021: Bổ sung thêm trường O11ConvertedUnit -> O19ConvertedUnit.

CREATE PROCEDURE [dbo].[MP4005] 	@DivisionID nvarchar(50), 
					@FromMonth as int, 
					@FromYear as int, 
					@ToMonth as int, 
					@ToYear as int,
					@PeriodID as nvarchar(50), --- '%' co nghia la tat ca
					@ApportionID as nvarchar(50)

				
AS

Declare @sSQL as nvarchar(4000),
@sSQL1 nvarchar(4000), 
    @FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20)
    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)

------ Gia thanh chung cua san pham
Set @sSQL ='
Select 	DivisionID,
	PeriodID ,
	ProductID ,	
	ProductQuantity = (Select Sum(Quantity)  From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID = MT1001.VoucherID and MT0810.DivisionID = MT1001.DivisionID 
				Where ( MT1001.TranMonth + 100*MT1001.TranYear Between '+@FromMonthYearText+' and '+@ToMonthYearText+') and
					MT0810.ResultTypeID =''R01'' and 
					PeriodID = MT1614.PeriodID and
					ProductID = MT1614.ProductID and
					MT0810.DivisionID =N'''+@DivisionID+''' ) ,
	Sum(Cost) as Cost		
From MT1614 WITH (NOLOCK)
Where  PeriodID like N'''+@PeriodID+''' 
Group by ProductID,  DivisionID, PeriodID '


If not exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'MV4004' and Xtype ='V')
	Exec ('Create view MV4004 -- MP4005
	 as '+@sSQL)
Else
	Exec ('Alter view MV4004 -- MP4005
	as '+@sSQL)

--Print @sSQL
------ Gia thanh don vi cua dinh muc

Set @sSQL ='
Select DivisionID,
	ApportionID,
	ProductID,
	Sum(MaterialAmount)/ProductQuantity as AppCost 
From MT1603 WITH (NOLOCK)
Group by DivisionID,ApportionID,ProductID,ProductQuantity '

If not exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'MV4006' and Xtype ='V')
	Exec ('Create view MV4006 -- MP4005
	as '+@sSQL)
Else
	Exec ('Alter view MV4006 -- MP4005
	as '+@sSQL)

------- Phan tich chi tiet cac yeu to chi phi de hinh thanh gia thanh
Set @sSQL='
Select 	DivisionID,
	PeriodID,
	ProductID,
	---Sum(QuantityUnit) QuantityUnit,
	Sum(Case when MaterialTypeID=''M01'' then ConvertedUnit Else 0 End) as M01ConvertedUnit,
	Sum(Case when MaterialTypeID=''M02'' then ConvertedUnit Else 0 End) as M02ConvertedUnit,
	Sum(Case when MaterialTypeID=''M03'' then ConvertedUnit Else 0 End) as M03ConvertedUnit,
	Sum(Case when MaterialTypeID=''M04'' then ConvertedUnit Else 0 End) as M04ConvertedUnit,
	Sum(Case when MaterialTypeID=''M05'' then ConvertedUnit Else 0 End) as M05ConvertedUnit,
	Sum(Case when MaterialTypeID=''M06'' then ConvertedUnit Else 0 End) as M06ConvertedUnit,
	Sum(Case when MaterialTypeID=''M07'' then ConvertedUnit Else 0 End) as M07ConvertedUnit,
	Sum(Case when MaterialTypeID=''M08'' then ConvertedUnit Else 0 End) as M08ConvertedUnit,
	Sum(Case when MaterialTypeID=''M09'' then ConvertedUnit Else 0 End) as M09ConvertedUnit,
	Sum(Case when MaterialTypeID=''M10'' then ConvertedUnit Else 0 End) as M10ConvertedUnit,
	Sum(Case when MaterialTypeID=''H01'' then ConvertedUnit Else 0 End) as H01ConvertedUnit,
	Sum(Case when MaterialTypeID=''H02'' then ConvertedUnit Else 0 End) as H02ConvertedUnit,
	Sum(Case when MaterialTypeID=''H03'' then ConvertedUnit Else 0 End) as H03ConvertedUnit,
	Sum(Case when MaterialTypeID=''H04'' then ConvertedUnit Else 0 End) as H04ConvertedUnit,
'
set @sSQL1 =
N'	Sum(Case when MaterialTypeID=''H05'' then ConvertedUnit Else 0 End) as H05ConvertedUnit,
	Sum(Case when MaterialTypeID=''H06'' then ConvertedUnit Else 0 End) as H06ConvertedUnit,
	Sum(Case when MaterialTypeID=''H07'' then ConvertedUnit Else 0 End) as H07ConvertedUnit,
	Sum(Case when MaterialTypeID=''H08'' then ConvertedUnit Else 0 End) as H08ConvertedUnit,
	Sum(Case when MaterialTypeID=''H09'' then ConvertedUnit Else 0 End) as H09ConvertedUnit,
	Sum(Case when MaterialTypeID=''H10'' then ConvertedUnit Else 0 End) as H10ConvertedUnit,
	Sum(Case when MaterialTypeID=''O01'' then ConvertedUnit Else 0 End) as O01ConvertedUnit,
	Sum(Case when MaterialTypeID=''O02'' then ConvertedUnit Else 0 End) as O02ConvertedUnit,
	Sum(Case when MaterialTypeID=''O03'' then ConvertedUnit Else 0 End) as O03ConvertedUnit,
	Sum(Case when MaterialTypeID=''O04'' then ConvertedUnit Else 0 End) as O04ConvertedUnit,
	Sum(Case when MaterialTypeID=''O05'' then ConvertedUnit Else 0 End) as O05ConvertedUnit,
	Sum(Case when MaterialTypeID=''O06'' then ConvertedUnit Else 0 End) as O06ConvertedUnit,
	Sum(Case when MaterialTypeID=''O07'' then ConvertedUnit Else 0 End) as O07ConvertedUnit,
	Sum(Case when MaterialTypeID=''O08'' then ConvertedUnit Else 0 End) as O08ConvertedUnit,
	Sum(Case when MaterialTypeID=''O09'' then ConvertedUnit Else 0 End) as O09ConvertedUnit,
	Sum(Case when MaterialTypeID=''O10'' then ConvertedUnit Else 0 End) as O10ConvertedUnit,
	Sum(Case when MaterialTypeID=''O11'' then ConvertedUnit Else 0 End) as O11ConvertedUnit,
	Sum(Case when MaterialTypeID=''O12'' then ConvertedUnit Else 0 End) as O12ConvertedUnit,
	Sum(Case when MaterialTypeID=''O13'' then ConvertedUnit Else 0 End) as O13ConvertedUnit,
	Sum(Case when MaterialTypeID=''O14'' then ConvertedUnit Else 0 End) as O14ConvertedUnit,
	Sum(Case when MaterialTypeID=''O15'' then ConvertedUnit Else 0 End) as O15ConvertedUnit,
	Sum(Case when MaterialTypeID=''O16'' then ConvertedUnit Else 0 End) as O16ConvertedUnit,
	Sum(Case when MaterialTypeID=''O17'' then ConvertedUnit Else 0 End) as O17ConvertedUnit,
	Sum(Case when MaterialTypeID=''O18'' then ConvertedUnit Else 0 End) as O18ConvertedUnit,
	Sum(Case when MaterialTypeID=''O19'' then ConvertedUnit Else 0 End) as O19ConvertedUnit
 From MT4000 WITH (NOLOCK)
Where PeriodID like N'''+@PeriodID+''' 
Group by DivisionID,  ProductID, PeriodID '



If not exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'MV4000' and Xtype ='V')
	Exec ('Create view MV4000 -- MP4005
	as '+@sSQL + @sSQL1)
Else
	Exec ('Alter view MV4000 -- MP4005
	as '+@sSQL + @sSQL1)


----- Bang phan tich gia thanh

if @ApportionID =''
begin
Set @sSQL='
Select 	V0.DivisionID, V4.PeriodID, MT1601.Description as PeriodName, V4.ProductID, 
	T02.InventoryName as ProductName,
	V4.ProductQuantity,
	V4.Cost, 
	V0.M01ConvertedUnit, V0.M02ConvertedUnit, V0.M03ConvertedUnit, V0.M04ConvertedUnit,V0.M05ConvertedUnit,
	V0.M06ConvertedUnit, V0.M07ConvertedUnit, V0.M08ConvertedUnit, V0.M09ConvertedUnit, V0.M10ConvertedUnit,
	V0.O01ConvertedUnit,  V0.O02ConvertedUnit, V0.O03ConvertedUnit, V0.O04ConvertedUnit,V0.O05ConvertedUnit,
	V0.O06ConvertedUnit, V0.O07ConvertedUnit, V0.O08ConvertedUnit, V0.O09ConvertedUnit, V0.O10ConvertedUnit,
	V0.O11ConvertedUnit, V0.O12ConvertedUnit, V0.O13ConvertedUnit, V0.O14ConvertedUnit, V0.O15ConvertedUnit,
	V0.O16ConvertedUnit, V0.O17ConvertedUnit, V0.O18ConvertedUnit, V0.O19ConvertedUnit,
	V0.H01ConvertedUnit,  V0.H02ConvertedUnit, V0.H03ConvertedUnit, V0.H04ConvertedUnit,V0.H05ConvertedUnit, 
	V0.H06ConvertedUnit, V0.H07ConvertedUnit, V0.H08ConvertedUnit, V0.H09ConvertedUnit, V0.H10ConvertedUnit,
	0 as AppCost
	
'
set @sSQL1 =
N'From MV4000 V0 WITH (NOLOCK) inner join MV4004 V4 WITH (NOLOCK) on 	V4.DivisionID = V0.DivisionID and
						V4.PeriodID = V0.PeriodID and
						V4.ProductID = V0.ProductID
		inner join AT1302  T02 WITH (NOLOCK) on 	T02.InventoryID = V0.ProductID AND T02.DivisionID IN (V0.DivisionID,''@@@'')
		inner join MT1601 WITH (NOLOCK) on MT1601.PeriodID  = V4.PeriodID  and MT1601.DivisionID = V0.DivisionID
Where 	V0.DivisionID = N'''+isnull(@DivisionID,'')+''' and
	V0.PeriodID like N'''+@PeriodID+''' '

end
Else
	begin
		Set @sSQL='
Select 	V0.DivisionID, V4.PeriodID, MT1601.Description as PeriodName, V4.ProductID, 
	T02.InventoryName as ProductName,
	V4.ProductQuantity,
	T02.UnitID, 
	V4.Cost, 
	V0.M01ConvertedUnit, V0.M02ConvertedUnit, V0.M03ConvertedUnit, V0.M04ConvertedUnit,V0.M05ConvertedUnit, 
	V0.M06ConvertedUnit,V0.M07ConvertedUnit, V0.M08ConvertedUnit, V0.M09ConvertedUnit, V0.M10ConvertedUnit,
	V0.O01ConvertedUnit, V0.O02ConvertedUnit, V0.O03ConvertedUnit, V0.O04ConvertedUnit,V0.O05ConvertedUnit, 
	V0.O06ConvertedUnit,V0.O07ConvertedUnit, V0.O08ConvertedUnit, V0.O09ConvertedUnit, V0.O10ConvertedUnit,
	V0.O11ConvertedUnit, V0.O12ConvertedUnit, V0.O13ConvertedUnit, V0.O14ConvertedUnit, V0.O15ConvertedUnit,
	V0.O16ConvertedUnit, V0.O17ConvertedUnit, V0.O18ConvertedUnit, V0.O19ConvertedUnit,
	V0.H01ConvertedUnit, V0.H02ConvertedUnit, V0.H03ConvertedUnit, V0.H04ConvertedUnit,V0.H05ConvertedUnit, 
	V0.H06ConvertedUnit,V0.H07ConvertedUnit, V0.H08ConvertedUnit, V0.H09ConvertedUnit, V0.H10ConvertedUnit,
	V6.AppCost as AppCost	
'
		set @sSQL1 =
N'From MV4000 V0 WITH (NOLOCK) inner join MV4004 V4 WITH (NOLOCK) on 	V4.DivisionID = V0.DivisionID and
						V4.PeriodID = V0.PeriodID and
						V4.ProductID = V0.ProductID
		 Left join  MV4006  V6 WITH (NOLOCK) on 	V6.ApportionID = N'''+isnull(@ApportionID,'')+''' and
						V6.ProductID = V0.ProductID and V6.DivisionID = V0.DivisionID
		inner join AT1302  T02 WITH (NOLOCK) on 	T02.InventoryID = V0.ProductID AND T02.DivisionID IN (V0.DivisionID,''@@@'')
		inner join MT1601 WITH (NOLOCK) on MT1601.PeriodID = V4.PeriodID  and MT1601.DivisionID = V0.DivisionID
Where 	V0.DivisionID = N'''+isnull(@DivisionID,'')+''' and
	V0.PeriodID like N'''+isnull(@PeriodID,'')+''' '
	end


If not exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'MV4005' and Xtype ='V')
	Exec ('Create view MV4005 -- MP4005
	as ' + @sSQL + @sSQL1)
Else
	Exec ('Alter view MV4005 -- MP4005
	as ' + @sSQL + @sSQL1)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
