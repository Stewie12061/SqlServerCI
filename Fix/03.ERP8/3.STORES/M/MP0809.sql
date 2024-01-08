IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MP0809]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[MP0809]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--Created by:Hoµng ThÞ Lan
--Date 03/02/2004
--Purpose: Bao cao so sanh gia thanh va dinh muc
--Edit by: Dang Le Bao Quynh; Date: 10/08/2007
--Purpose: Bo sung va sua cach in bao cao so sanh gia thanh va dinh muc, cho phep chon mot dinh muc bat ky de so sanh
--Edit by: Thien Huynh; Date: 27/09/2011
--Purpose: Sua loi
/********************************************
'* Edited by: [GS] [Tố Oanh] [30/07/2010]
'********************************************/
-- Last Edit 01/03/2013 by Thiên Huỳnh: Đa chi nhánh
-- Edit by Khanh Van: Loi ket DivisionID chua dung
---- Modified by Bảo Thy on 30/03/2017: Fix lỗi Báo cáo so sánh thực tế và định mức lên thiếu dữ liệu 
---- Modified by Bảo Thy on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Nhựt Trường on 18/12/2020: Thay đổi cách lấy trường MaterialID khi tạo view MV0813, để lấy chi phí nhân công và chi phí NVL.
---- Modified by Nhựt Trường on 05/08/2021: Bổ sung: _ Lấy lên phần giảm chi phí nvl và phê phẩm
----												 _ Số lượng nhập kho thành phẩm (ProductQuantity)
----												 _ Trường nhận diện phế phẩm trong bộ định mức (IsWaste)
----												 _ Tỉ lệ hao hụt, tỉ lệ hao hụt phế phẩm trong bộ đinh mức (RateWastage, RateWastage02)
----												 _ số lượng nvl xuất kho, nhập kho (DebitQuantity, CreditQuantity)
---- Modified by Nhựt Trường on 18/08/2021: Bổ sung thêm trường OrderQuantity, SOrderID.

CREATE PROCEDURE  [dbo].[MP0809]	@PeriodID as nvarchar(50),
					@FromProduct as nvarchar(50),
					@ToProduct as nvarchar(50),					
					@FromMonth as int,
					@FromYear as int,
					@ToMonth as int,
					@ToYear as int,
					@Is621 tinyint,
					@Is622 tinyint,
					@Is627 tinyint,
					@CompareType int = 0, -- 0: So sanh theo cac bo dinh muc co trong phuong phap phan bo; 1: So sanh theo cac bo dinh muc tu chon 
					@ListofApportionID nvarchar(2000) = Null, 
					@DivisionID as nvarchar (50)
					
AS
Declare @sSQL as nvarchar(max),
	@FromPeriod as int,
	@ToPeriod as int,
	@DistributionID nvarchar(50),
	@lst_MaterialTypeID varchar(2000)
	

	Set @lst_MaterialTypeID  = '('

	Set @lst_MaterialTypeID  = @lst_MaterialTypeID + case when @Is621 = 1 then '''COST001'','  else ''''',' end + 
		 case when @Is622 = 1 then '''COST002'',' else ''''',' end  +  case when @Is627 = 1 then '''COST003'',' else ''''',' end 
	Set @lst_MaterialTypeID = left(@lst_MaterialTypeID, len(@lst_MaterialTypeID) - 1) + ')'


Set  @DistributionID =isnull((Select  DistributionID From MT1601 Where PeriodID = @PeriodID And DivisionID = @DivisionID), '')

Select   @FromPeriod =@FromMonth+@FromYear*100, @ToPeriod =@ToMonth+@ToYear*100

DECLARE @MT0809 TABLE (
	DivisionID VARCHAR(50),
	PeriodID VARCHAR(250),
	ExpenseID VARCHAR(250),
	ProductID VARCHAR(250),
	ProductName VARCHAR(MAX),
	MaterialTypeID VARCHAR(50),
	MaterialID VARCHAR(250),
	ConvertedUnit DECIMAL(28, 8),
	QuantityUnit DECIMAL(28, 8),
	ProductQuantity DECIMAL(28, 8),
	DebitQuantity DECIMAL(28, 8),
	CreditQuantity DECIMAL(28, 8),
	OrderQuantity DECIMAL(28, 8),
	SOrderID VARCHAR(250),
	Row INT
)

DECLARE @MT0813 TABLE (
	DivisionID VARCHAR(50),
	PeriodID VARCHAR(250),
	ApportionID VARCHAR(250),
	ExpenseID VARCHAR(250),
	ProductID VARCHAR(250),
	ProductName VARCHAR(MAX),
	MaterialTypeID VARCHAR(50),
	MaterialID VARCHAR(250),
	ConvertedA DECIMAL(28, 8),
	QuantityA DECIMAL(28, 8),
	ProductQuantity DECIMAL(28, 8),
	RateWastage DECIMAL(28, 8),
	RateWastage02 DECIMAL(28, 8),
	WasteID VARCHAR(250),
	DebitQuantity DECIMAL(28, 8),
	CreditQuantity DECIMAL(28, 8),
	OrderQuantity DECIMAL(28, 8),
	SOrderID VARCHAR(250),
	Row INT
)

----Lay san  pham cua DTTHCP  chiet tinh gia thanh
Set @sSQL = '
Select Distinct  MT4000.DivisionID, MT4000.PeriodID, MT4000.ExpenseID, MT4000.ProductID , AT1302.InventoryName as ProductName, MT4000.MaterialTypeID, ISNULL(MT4000.MaterialID, MT4000.MaterialTypeID) AS MaterialID,
MT4000.ConvertedUnit, MT4000.QuantityUnit, MT0400.ProductQuantity, SUM(D.Quantity) AS DebitQuantity, SUM(C.Quantity) AS CreditQuantity, OT2002.OrderQuantity, OT2002.SOrderID
INTO #Temp00
From 	MT4000 
	inner join At1302 on MT4000.ProductID = AT1302.InventoryID AND AT1302.DivisionID IN (MT4000.DivisionID,''@@@'')
	LEFT JOIN MT0400 ON MT0400.PeriodID = MT4000.PeriodID AND MT0400.ProductID = MT4000.ProductID AND MT0400.MaterialID = MT4000.MaterialID
	LEFT JOIN AT9000 D ON D.DivisionID = MT4000.DivisionID AND D.PeriodID = MT4000.PeriodID AND D.InventoryID = MT4000.MaterialID AND D.CreditAccountID LIKE ''621%''
	LEFT JOIN AT9000 C ON C.DivisionID = MT4000.DivisionID AND C.PeriodID = MT4000.PeriodID AND C.InventoryID = MT4000.MaterialID AND C.DebitAccountID LIKE ''621%''
	LEFT JOIN OT2001 ON  OT2001.DivisionID = MT4000.DivisionID AND OT2001.PeriodID = MT4000.PeriodID
    LEFT JOIN OT2002 ON OT2002.DivisionID = MT4000.DivisionID AND OT2002.InventoryID = MT4000.ProductID  AND OT2001.SOrderID = OT2002.SOrderID
Where MT4000.DivisionID = ''' + @DivisionID + ''' And	MT4000.PeriodID = '''+@PeriodID+''' and MT4000.ProductID Between ''' + @FromProduct + ''' and '''+@ToProduct + ''' and 
	MT4000.MaterialTypeID in (Select MaterialTypeID From MT5001 Where DistributionID = ''' + @DistributionID + ''' And IsDistributed = 1 And MT4000.ExpenseID In ' + @lst_MaterialTypeID + ')' + ' And
	MT4000.ExpenseID In ' + @lst_MaterialTypeID + '
Group by MT4000.DivisionID, MT4000.PeriodID, MT4000.ExpenseID, MT4000.ProductID , AT1302.InventoryName, MT4000.MaterialTypeID, MT4000.MaterialID, MT4000.ConvertedUnit, MT4000.QuantityUnit, ProductQuantity, OT2002.OrderQuantity, OT2002.SOrderID

SELECT  T00.*,
				(SELECT COUNT(MaterialID) FROM #Temp00 WHERE MaterialID = T00.MaterialID GROUP BY MaterialID) AS Row
		INTO #Temp01
		FROM #Temp00 T00

SELECT * FROM #Temp01		
'

INSERT INTO @MT0809
EXEC (@sSQL)

----- Xử lý lấy danh sách đơn hàng -----
	DECLARE @SOrderIDList NVARCHAR (MAX) = '',
			@Query NVARCHAR (MAX) = '',
			@SOrderID NVARCHAR (250),
			@MaterialID NVARCHAR (250)
	
	DECLARE cursorMaterialIDList CURSOR FOR
	SELECT MaterialID FROM @MT0809 WHERE Row > 0 GROUP BY MaterialID
	open cursorMaterialIDList
	FETCH NEXT FROM cursorMaterialIDList INTO @MaterialID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	   DECLARE cursorSOrderIDList CURSOR FOR
	   SELECT SOrderID FROM @MT0809 WHERE MaterialID = @MaterialID
	   open cursorSOrderIDList
	   FETCH NEXT FROM cursorSOrderIDList INTO @SOrderID
	   WHILE @@FETCH_STATUS = 0
	   BEGIN
		  IF(ISNULL(@SOrderID,'') <> '')
		  BEGIN
				SET @SOrderIDList = Concat(@SOrderIDList,@SOrderID,', ')
		  END
	      
	      FETCH NEXT FROM cursorSOrderIDList
	             INTO @SOrderID
	   END
	   
	   CLOSE cursorSOrderIDList
	   DEALLOCATE cursorSOrderIDList 
	
	   Update @MT0809
	   SET SOrderID = SUBSTRING(@SOrderIDList,1,LEN(@SOrderIDList)-1)
	   WHERE MaterialID = @MaterialID
	      SET @SOrderIDList=''
	
	   FETCH NEXT FROM cursorMaterialIDList
	          INTO @MaterialID
	END
	CLOSE cursorMaterialIDList
	DEALLOCATE cursorMaterialIDList

DELETE MT0809

INSERT INTO MT0809 (DivisionID, PeriodID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedUnit, QuantityUnit, ProductQuantity, DebitQuantity, CreditQuantity, OrderQuantity, SOrderID)
SELECT DivisionID, PeriodID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedUnit, QuantityUnit, ProductQuantity,
	   SUM(ISNULL(DebitQuantity,0)) AS DebitQuantity, SUM(ISNULL(CreditQuantity,0)) AS CreditQuantity, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity, SOrderID
FROM @MT0809
GROUP BY DivisionID, PeriodID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedUnit, QuantityUnit, ProductQuantity, SOrderID

SET @sSQL ='SELECT * FROM MT0809'

If not exists (Select top 1 1 From SysObjects Where name = 'MV0809' and Xtype ='V')
	Exec ('Create view MV0809 --- Tao boi MP0809 
	as '+@sSQL)
Else
	Exec ('Alter view MV0809 --- Tao boi MP0809 
	as '+@sSQL)



---Lay bo dinh muc
Set @ListofApportionID = replace(@ListofApportionID,',',''',''')

if @CompareType = 0
	Set @sSQL = '
	Select Distinct MT1603.DivisionID, ''' + @PeriodID + ''' As PeriodID, MT1603.ApportionID, MT1603.ExpenseID, MT1603.ProductID, AT1302.InventoryName as ProductName,
		MT1603.MaterialTypeID, ISNULL(MT1603.MaterialID, MT1603.MaterialTypeID) AS MaterialID, MT1603.ConvertedUnit AS ConvertedA, MT1603.QuantityUnit AS QuantityA,
		MT0400.ProductQuantity, RateWastage, RateWastage02, MT1603.WasteID, SUM(D.Quantity) AS DebitQuantity, SUM(C.Quantity) AS CreditQuantity, OT2002.OrderQuantity, OT2002.SOrderID
	INTO #Temp02
	From 	MT1603 
		inner join AT1302 on MT1603.ProductID = AT1302.InventoryID AND AT1302.DivisionID IN (MT1603.DivisionID,''@@@'')
		LEFT JOIN MT0400 ON MT0400.PeriodID = ''' + @PeriodID + ''' AND MT0400.ProductID = MT1603.ProductID AND MT0400.MaterialID = MT1603.MaterialID
		LEFT JOIN AT9000 D ON D.DivisionID = MT1603.DivisionID AND D.PeriodID = ''' + @PeriodID + ''' AND D.InventoryID = MT1603.MaterialID AND D.CreditAccountID LIKE ''621%''
		LEFT JOIN AT9000 C ON C.DivisionID = MT1603.DivisionID AND C.PeriodID = ''' + @PeriodID + ''' AND C.InventoryID = MT1603.MaterialID AND C.DebitAccountID LIKE ''621%''
	    LEFT JOIN OT2001 ON  OT2001.DivisionID = MT1603.DivisionID AND OT2001.PeriodID = ''' + @PeriodID + '''
        LEFT JOIN OT2002 ON OT2002.DivisionID = MT1603.DivisionID AND OT2002.InventoryID = MT1603.ProductID  AND OT2001.SOrderID = OT2002.SOrderID
	Where MT1603.DivisionID = ''' + @DivisionID + ''' And 	MT1603.ProductID Between  '''+@FromProduct+'''  And '''+@ToProduct + ''' 
	And MT1603.ExpenseID In ' + @lst_MaterialTypeID + ' 
	And (MT1603.MaterialTypeID in (Select MaterialTypeID From MT5001 Where DivisionID = ''' + @DivisionID + ''' And DistributionID = ''' + @DistributionID + ''' And IsDistributed = 1 And MT1603.ExpenseID In ' + @lst_MaterialTypeID + ') 
		Or ISNULL(MT1603.MaterialTypeID,'''') = '''')' + ' 
	And MT1603.ApportionID In (Select ApportionID From MT5001 Where DivisionID = ''' + @DivisionID + ''' And DistributionID = ''' + @DistributionID + ''' And IsDistributed = 1 And MT1603.ExpenseID In ' + @lst_MaterialTypeID + ') And ApportionID Is Not Null
	Group by MT1603.DivisionID, MT1603.ApportionID, MT1603.ExpenseID, MT1603.ProductID, AT1302.InventoryName,
			 MT1603.MaterialTypeID, MT1603.MaterialID, MT1603.ConvertedUnit, MT1603.QuantityUnit, MT0400.ProductQuantity,
			 RateWastage, RateWastage02, MT1603.WasteID, OT2002.OrderQuantity, OT2002.SOrderID

	SELECT  T02.*,
				(SELECT COUNT(MaterialID) FROM #Temp02 WHERE MaterialID = T02.MaterialID GROUP BY MaterialID) AS Row
		INTO #Temp03
		FROM #Temp02 T02

	SELECT * FROM #Temp03' 
else
	Set @sSQL = '
	Select  MT1603.DivisionID, ''' + @PeriodID + ''' As PeriodID, MT1603.ApportionID, MT1603.ExpenseID, MT1603.ProductID, AT1302.InventoryName as ProductName,
		MT1603.MaterialTypeID, ISNULL(MT1603.MaterialID, MT1603.MaterialTypeID) AS MaterialID, MT1603.ConvertedUnit AS ConvertedA, MT1603.QuantityUnit AS QuantityA,
		MT0400.ProductQuantity, RateWastage, RateWastage02, MT1603.WasteID, SUM(D.Quantity) AS DebitQuantity, SUM(C.Quantity) AS CreditQuantity, OT2002.OrderQuantity, OT2002.SOrderID
	INTO #Temp02
	From 	MT1603 
		inner join AT1302 on MT1603.ProductID = AT1302.InventoryID AND AT1302.DivisionID IN (MT1603.DivisionID,''@@@'')
		LEFT JOIN MT0400 ON MT0400.PeriodID = ''' + @PeriodID + ''' AND MT0400.ProductID = MT1603.ProductID AND MT0400.MaterialID = MT1603.MaterialID
		LEFT JOIN AT9000 D ON D.DivisionID = MT1603.DivisionID AND D.PeriodID = ''' + @PeriodID + ''' AND D.InventoryID = MT1603.MaterialID AND D.CreditAccountID LIKE ''621%''
		LEFT JOIN AT9000 C ON C.DivisionID = MT1603.DivisionID AND C.PeriodID = ''' + @PeriodID + ''' AND C.InventoryID = MT1603.MaterialID AND C.DebitAccountID LIKE ''621%''
	    LEFT JOIN OT2001 ON  OT2001.DivisionID = MT1603.DivisionID AND OT2001.PeriodID = ''' + @PeriodID + '''
        LEFT JOIN OT2002 ON OT2002.DivisionID = MT1603.DivisionID AND OT2002.InventoryID = MT1603.ProductID  AND OT2001.SOrderID = OT2002.SOrderID
	Where  MT1603.DivisionID = ''' + @DivisionID + '''	And MT1603.ProductID Between  '''+@FromProduct+'''  And '''+@ToProduct + '''  
	And  MT1603.ExpenseID In ' + @lst_MaterialTypeID + ' 
	And (MT1603.MaterialTypeID in (Select MaterialTypeID From MT5001 
								   Where DivisionID = ''' + @DivisionID + ''' And DistributionID = ''' + @DistributionID + '''
								   And IsDistributed = 1 And MT1603.ExpenseID In ' + @lst_MaterialTypeID + ') 
		Or ISNULL(MT1603.MaterialTypeID,'''') = '''')' + ' 
	And MT1603.ApportionID In (''' + @ListofApportionID+ ''')
	Group by MT1603.DivisionID, MT1603.ApportionID, MT1603.ExpenseID, MT1603.ProductID, AT1302.InventoryName,
			 MT1603.MaterialTypeID, MT1603.MaterialID, MT1603.ConvertedUnit, MT1603.QuantityUnit, MT0400.ProductQuantity,
			 RateWastage, RateWastage02, MT1603.WasteID, OT2002.OrderQuantity, OT2002.SOrderID
			 
	SELECT  T02.*,
				(SELECT COUNT(MaterialID) FROM #Temp02 WHERE MaterialID = T02.MaterialID GROUP BY MaterialID) AS Row
		INTO #Temp03
		FROM #Temp02 T02

	SELECT * FROM #Temp03' 

INSERT INTO @MT0813
EXEC (@sSQL)
----- Xử lý lấy danh sách đơn hàng -----
	SET @SOrderIDList = ''
	SET	@Query = ''
	SET	@SOrderID = ''
	SET	@MaterialID = ''

	DECLARE cursorMaterialIDList CURSOR FOR
	SELECT MaterialID FROM @MT0813 WHERE Row > 0 GROUP BY MaterialID
	open cursorMaterialIDList
	FETCH NEXT FROM cursorMaterialIDList INTO @MaterialID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	   DECLARE cursorSOrderIDList CURSOR FOR
	   SELECT SOrderID FROM @MT0813 WHERE MaterialID = @MaterialID
	   open cursorSOrderIDList
	   FETCH NEXT FROM cursorSOrderIDList INTO @SOrderID
	   WHILE @@FETCH_STATUS = 0
	   BEGIN
		  IF(ISNULL(@SOrderID,'') <> '')
		  BEGIN
				SET @SOrderIDList = Concat(@SOrderIDList,@SOrderID,', ')
		  END
	      
	      FETCH NEXT FROM cursorSOrderIDList
	             INTO @SOrderID
	   END
	   
	   CLOSE cursorSOrderIDList
	   DEALLOCATE cursorSOrderIDList 

	   Update @MT0813
	   SET SOrderID = SUBSTRING(@SOrderIDList,1,LEN(@SOrderIDList)-1)
	   WHERE MaterialID = @MaterialID
       SET @SOrderIDList=''

	   FETCH NEXT FROM cursorMaterialIDList
	          INTO @MaterialID
	END
	CLOSE cursorMaterialIDList
	DEALLOCATE cursorMaterialIDList

DELETE MT0813

INSERT INTO MT0813 (DivisionID, PeriodID, ApportionID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedA, QuantityA, ProductQuantity, RateWastage, RateWastage02, WasteID, DebitQuantity, CreditQuantity, OrderQuantity, SOrderID)
SELECT DivisionID, PeriodID, ApportionID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedA, QuantityA, ProductQuantity, RateWastage, RateWastage02, WasteID,
	   SUM(ISNULL(DebitQuantity,0)) AS DebitQuantity, SUM(ISNULL(CreditQuantity,0)) AS CreditQuantity, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity, SOrderID
FROM @MT0813
GROUP BY DivisionID, PeriodID, ApportionID, ExpenseID, ProductID, ProductName, MaterialTypeID, MaterialID, ConvertedA, QuantityA, ProductQuantity, RateWastage, RateWastage02, WasteID, SOrderID

SET @sSQL ='SELECT * FROM MT0813'
--print @sSQL	
If not exists (Select top 1 1 From SysObjects Where name = 'MV0813' and Xtype ='V')
	Exec ('Create view MV0813 --- Tao boi MP0809 
	as '+@sSQL)
Else
	Exec ('Alter view MV0813 --- Tao boi MP0809 
	as '+@sSQL)

Set @sSQL = '
Select Distinct
	Case When MV0809.DivisionID Is Null Then MV0813.DivisionID Else MV0809.DivisionID End As DivisionID,
	MV0813.PeriodID,
	Case When MV0809.ExpenseID Is Null Then MV0813.ExpenseID Else MV0809.ExpenseID End As ExpenseID, 
	Case When MV0809.ProductID Is Null Then MV0813.ProductID Else MV0809.ProductID End As ProductID,
	Case When MV0809.ProductName Is Null Then MV0813.ProductName Else MV0809.ProductName End As ProductName,
	Case When MV0809.MaterialTypeID Is Null Then MV0813.MaterialTypeID Else MV0809.MaterialTypeID End As MaterialTypeID,
	Case When MV0809.MaterialID Is Null Then MV0813.MaterialID Else MV0809.MaterialID End As MaterialID,
	isnull(MV0809.ConvertedUnit,0) as ConvertedUnit, Isnull(MV0809.QuantityUnit,0) as QuantityUnit, 	 
	isnull(ConvertedA,0) as ConvertedA, 
	isnull(QuantityA,0) as QuantityA, 
	MT0699.UserName , --MT0699.DivisionID,   
	isnull(MV0813.ApportionID, '''') as ApportionID,
	AT1302.InventoryName as MaterialName,-- AT1302.DivisionID
	Case When MV0809.ProductQuantity Is Null Then MV0813.ProductQuantity Else MV0809.ProductQuantity End As ProductQuantity,
	ISNULL(MV0813.RateWastage, 0) AS RateWastage, ISNULL(MV0813.RateWastage02, 0) AS RateWastage02,
	Case When MV0809.MaterialID IN (SELECT WasteID FROM MV0813 WHERE DivisionID= ''' + @DivisionID + ''') Then 1 Else 0 End As IsWaste,
	Case When MV0809.DebitQuantity Is Null Then MV0813.DebitQuantity Else MV0809.DebitQuantity End As DebitQuantity,
	Case When MV0809.CreditQuantity Is Null Then MV0813.CreditQuantity Else MV0809.CreditQuantity End As CreditQuantity,
	Case When MV0809.OrderQuantity Is Null Then MV0813.OrderQuantity Else MV0809.OrderQuantity End As OrderQuantity,
	Case When MV0809.SOrderID Is Null Then MV0813.SOrderID Else MV0809.SOrderID End As SOrderID
From MV0809 
Full join MV0813 on 

	MV0809.ProductID + ''_'' + 
	MV0809.ExpenseID + ''_'' + 
	case when left(MV0809.MaterialTypeID,1) = ''M'' then '' '' else MV0809.MaterialTypeID end 
	+ ''_'' +  isnull(MV0809.MaterialID,'' '')
	
	=
	MV0813.ProductID + ''_'' + 
	MV0813.ExpenseID + ''_'' + 
	case when left(MV0809.MaterialTypeID,1) = ''M'' then '' '' else MV0813.MaterialTypeID end 
	+ ''_'' +  isnull(MV0813.MaterialID,'' '')
 
	Left join MT0699 on Case When MV0809.MaterialTypeID Is Null Then MV0813.MaterialTypeID Else MV0809.MaterialTypeID End = MT0699.MaterialTypeID  AND MT0699.DivisionID = (Case When MV0809.DivisionID Is Null Then MV0813.DivisionID Else MV0809.DivisionID End)
	Left join AT1302 on AT1302.InventoryID = Case When MV0809.MaterialID Is Null Then MV0813.MaterialID Else MV0809.MaterialID End
						AND AT1302.DivisionID IN (Case When MV0809.DivisionID Is Null Then MV0813.DivisionID Else MV0809.DivisionID End,''@@@'')
Where MV0809.DivisionID = ''' + @DivisionID + ''''
	
--Print @sSQL

If not exists (Select top 1 1 From SysObjects Where name = 'MV0814' and Xtype ='V')
	Exec ('Create view MV0814 --- Tao boi MP0809 
	as '+@sSQL)
Else
	Exec ('Alter view MV0814 --- Tao boi MP0809 
	as '+@sSQL)