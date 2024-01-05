IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30162]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- In Báo cáo tình hình nhận hàng - SOF3016
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Hoà Date 27/08/2020
-- Modify by Kiều Nga Date 26/01/2021 : Chuyển đk lọc từ kỳ đến kỳ sang chọn kỳ
-- Modify by Đức Tuyên Date 14/09/2023 : Bổ sung cột thông số kỹ thuật.
-- <Example>

 CREATE PROCEDURE [dbo].[SOP30162] (
	 @DivisionID NVARCHAR(2000),
	 @DivisionIDList	NVARCHAR(MAX),
	 @IsDate INT, ---- 1: là ngày, 0: là kỳ
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList NVARCHAR(MAX),
	 @OrderID NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	    @sWhere NVARCHAR(MAX),
	    @sSQL1 AS NVARCHAR(MAX), 
		@sSQL2 AS NVARCHAR(MAX)
		,@sSQL3 AS NVARCHAR(MAX), 
		@VoucherNo nvarchar(50), 
		@VoucherDate datetime, 
		@ObjectID VARCHAR(50), 
		@ObjectName NVARCHAR(MAX) 
if @OrderID != ''
BEGIN
Select @VoucherNo = VoucherNo, @VoucherDate = OrderDate ,@ObjectID = COALESCE(OT3001.ObjectID,''), @ObjectName = COALESCE(AT1202.ObjectName, '')
	From OT3001 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND OT3001.ObjectID = AT1202.ObjectID
	Where POrderID = @OrderID

If not exists (Select Top 1 1 From OT3003_MT WITH (NOLOCK) Where POrderID = @OrderID)
	Set @sSQL = 'Select ''' + @DivisionID + ''' as DivisionID, '''' as Dates, ''Quantity01'' as Quantity'
else 	
Begin	
	Set @sSQL =  'Select DivisionID, Date as Dates, Quantity
				  From OT3003_MT WITH (NOLOCK) Where POrderID = '''+@OrderID+''''	    

End

--PRINT @sSQL

If  exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV3102')
	Drop view OV3102
EXEC('Create view OV3102 ---tao boi OP3006
		 as ' + @sSQL)	

Set @sSQL = 'Select  T00.DivisionID,
			V00.Dates, T00.InventoryID, A00.InventoryName, A01.UnitName, A00.Specification,
			A00.InventoryTypeID,
			 sum(OrderQuantity) as OrderQuantity,			 
			sum(case when V00.Quantity = ''Quantity01'' then T00.Quantity01 
			when V00.Quantity = ''Quantity02'' then T00.Quantity02 
			when V00.Quantity = ''Quantity03'' then T00.Quantity03 
			when V00.Quantity = ''Quantity04'' then T00.Quantity04 
			when V00.Quantity = ''Quantity05'' then T00.Quantity05 
			when V00.Quantity = ''Quantity06'' then T00.Quantity06 
			when V00.Quantity = ''Quantity07'' then T00.Quantity07 
			when V00.Quantity = ''Quantity08'' then T00.Quantity08 
			when V00.Quantity = ''Quantity09'' then T00.Quantity09 
			when V00.Quantity = ''Quantity10'' then T00.Quantity10  
			when V00.Quantity = ''Quantity11'' then T00.Quantity11 
			when V00.Quantity = ''Quantity12'' then T00.Quantity12 
			when V00.Quantity = ''Quantity13'' then T00.Quantity13 
			when V00.Quantity = ''Quantity14'' then T00.Quantity14 
			when V00.Quantity = ''Quantity15'' then T00.Quantity15 
			when V00.Quantity = ''Quantity16'' then T00.Quantity16 
			when V00.Quantity = ''Quantity17'' then T00.Quantity17 
			when V00.Quantity = ''Quantity18'' then T00.Quantity18 
			when V00.Quantity = ''Quantity19'' then T00.Quantity19 
			when V00.Quantity = ''Quantity20'' then T00.Quantity20 
			when V00.Quantity = ''Quantity21'' then T00.Quantity21 
			when V00.Quantity = ''Quantity22'' then T00.Quantity22 
			when V00.Quantity = ''Quantity23'' then T00.Quantity23 
			when V00.Quantity = ''Quantity24'' then T00.Quantity24 
			when V00.Quantity = ''Quantity25'' then T00.Quantity25 
			when V00.Quantity = ''Quantity26'' then T00.Quantity26 
			when V00.Quantity = ''Quantity27'' then T00.Quantity27 
			when V00.Quantity = ''Quantity28'' then T00.Quantity28 
			when V00.Quantity = ''Quantity29'' then T00.Quantity29 
			when V00.Quantity = ''Quantity30'' then T00.Quantity30   end) as Quantity,
			T00.Ana01ID as TAna01ID,
			T00.Ana02ID as TAna02ID,
			T00.Ana03ID as TAna03ID,
			T00.Ana04ID as TAna04ID,
			T00.Ana05ID as TAna05ID,
	
			A11.AnaName as A01AnaName,
			A02.AnaName as A02AnaName,
			A03.AnaName as A03AnaName,
			A04.AnaName as A04AnaName,
			A05.AnaName as A05AnaName,
	
			T00.Ana06ID as TAna06ID,
			T00.Ana07ID as TAna07ID,
			T00.Ana08ID as TAna08ID,
			T00.Ana09ID as TAna09ID,
			T00.Ana10ID as TAna10ID,
	
			A06.AnaName as A06AnaName,
			A07.AnaName as A07AnaName,
			A08.AnaName as A08AnaName,
			A09.AnaName as A09AnaName,
			A10.AnaName as A10AnaName,
			T00.StrParameter01, T00.StrParameter02, T00.StrParameter03, T00.StrParameter04, T00.StrParameter05,
			T00.StrParameter06, T00.StrParameter07, T00.StrParameter08, T00.StrParameter09, T00.StrParameter10
		'
SET @sSQL1 = 'From OT3002 T00 WITH (NOLOCK) cross join OV3102 V00
			inner join AT1302 A00 WITH (NOLOCK) ON A00.InventoryID = T00.InventoryID
			inner join AT1304 A01 WITH (NOLOCK) ON A00.UnitID = A01.UnitID
			left join AT1011 A11 WITH (NOLOCK) on A11.AnaTypeID = ''A01'' and A11.AnaID = T00.Ana01ID
			left join AT1011 A02 WITH (NOLOCK) on A02.AnaTypeID = ''A02'' and A02.AnaID = T00.Ana02ID
			left join AT1011 A03 WITH (NOLOCK) on A03.AnaTypeID = ''A03'' and A03.AnaID = T00.Ana03ID
			left join AT1011 A04 WITH (NOLOCK) on A04.AnaTypeID = ''A04'' and A04.AnaID = T00.Ana04ID
			left join AT1011 A05 WITH (NOLOCK) on A05.AnaTypeID = ''A05'' and A05.AnaID = T00.Ana05ID
			left join AT1011 A06 WITH (NOLOCK) on A06.AnaTypeID = ''A06'' and A06.AnaID = T00.Ana01ID
			left join AT1011 A07 WITH (NOLOCK) on A07.AnaTypeID = ''A07'' and A07.AnaID = T00.Ana02ID
			left join AT1011 A08 WITH (NOLOCK) on A08.AnaTypeID = ''A08'' and A08.AnaID = T00.Ana03ID
			left join AT1011 A09 WITH (NOLOCK) on A09.AnaTypeID = ''A09'' and A09.AnaID = T00.Ana04ID
			left join AT1011 A10 WITH (NOLOCK) on A10.AnaTypeID = ''A10'' and A10.AnaID = T00.Ana05ID
		Where T00.POrderID =''' + @OrderID + ''''
		   + CASE WHEN Isnull(@DivisionIDList, '') = '' THEN ' AND T00.DivisionID = ''' + @DivisionID + '''' ELSE ' AND T00.DivisionID IN ( ''' + @DivisionIDList + ''')' END +'
		Group by T00.DivisionID, V00.Dates, T00.InventoryID, A00.InventoryName, A01.UnitName , A00.Specification, A00.InventoryTypeID,
			T00.Ana01ID,T00.Ana02ID,T00.Ana03ID,T00.Ana04ID,T00.Ana05ID,T00.Ana06ID,T00.Ana07ID,T00.Ana08ID ,T00.Ana09ID,T00.Ana10ID,
			A11.AnaName,A02.AnaName,A03.AnaName,A04.AnaName,A05.AnaName,A06.AnaName,A07.AnaName,A08.AnaName,A09.AnaName,A10.AnaName,
			T00.StrParameter01, T00.StrParameter02, T00.StrParameter03, T00.StrParameter04, T00.StrParameter05,
			T00.StrParameter06, T00.StrParameter07, T00.StrParameter08, T00.StrParameter09, T00.StrParameter10'
--PRINT(@sSQL)
--PRINT(@sSQL1)

If exists (Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV3103')
	Drop view OV3103
EXEC('Create view OV3103 ---tao boi OP3006
		as ' + @sSQL +@sSQL1)

--PRINT (@sSQL)
--PRINT (@sSQL1)
Set @sSQL = N'Select A00.DivisionID, InventoryID,  sum(ActualQuantity) as ActualQuantity
		From AT2007 A00 WITH (NOLOCK) 
		    inner join AT2006 A01 WITH (NOLOCK) on A01.DivisionID = A00.DivisionID and A00.VoucherID = A01.VoucherID and A01.KindVoucherID in(1, 5, 7)
		Where A00.OrderID = ''' + @OrderID + '''
		    AND A00.DivisionID = ''' + @DivisionID + '''
		Group by A00.DivisionID, InventoryID'

If exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV3104')
	Drop view OV3104
EXEC('Create view OV3104 ---tao boi OP3006
		as ' + @sSQL)

Set @sSQL = N'Select T00.DivisionID, T00.InventoryID, InventoryName, A01.UnitName, A00.Specification,
		A00.InventoryTypeID, VoucherDate as Dates, V00.ActualQuantity, sum(T00.ActualQuantity) as Quantity
		From AT2007  T00 WITH (NOLOCK)   
		    inner join AT2006 T01 WITH (NOLOCK) on T01.DivisionID = T00.DivisionID and T00.VoucherID = T01.VoucherID and T01.KindVoucherID in(1, 5, 7)
			inner join OV3104 V00 on V00.DivisionID = T00.DivisionID and T00.InventoryID = V00.InventoryID
			inner join AT1302 A00 WITH (NOLOCK) on T00.InventoryID = A00.InventoryID
			inner join AT1304 A01 WITH (NOLOCK) on A00.UnitID = A01.UnitID
		Where T00.OrderID = ''' + @OrderID + ''''
		 + CASE WHEN Isnull(@DivisionIDList, '') = '' THEN ' AND T00.DivisionID = ''' + @DivisionID + '''' ELSE ' AND T00.DivisionID IN ( ''' + @DivisionIDList + ''')' END +'
		Group by T00.DivisionID, T00.InventoryID, InventoryName,  A01.UnitName, Voucherdate , V00.ActualQuantity , A00.Specification,
		A00.InventoryTypeID '

If  exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name ='OV3105')
	Drop view OV3105
EXEC('Create view OV3105 ---tao boi OP3006
		as ' + @sSQL) 

---Tat ca ngay  trong ke hoach san xuat va thuc te thuc hien
Set @sSQL = 'Select Dates, DivisionID From OV3102 Union
		Select Distinct Dates, DivisionID From OV3105'
--print @sSQL 
If  exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name ='OV3106')
	Drop view OV3106
EXEC('Create view OV3106  ---tao boi OP3006
		as ' + @sSQL)
--//

Set @sSQL = N'Select V00.DivisionID, ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, ''' + @ObjectID + ''' as ObjectID,
         N''' + @ObjectName + ''' as ObjectName,V00.InventoryID,  V00.InventoryName, V00.UnitName, V00.Specification,
		V00.InventoryTypeID, Dates, 
		1 as Types, ''OFML000183'' as TypeName, OrderQuantity, V01.ActualQuantity, Quantity,
		V00.TAna01ID,
		V00.TAna02ID,
		V00.TAna03ID,
		V00.TAna04ID,
		V00.TAna05ID,
	
		V00.A01AnaName,
		V00.A02AnaName,
		V00.A03AnaName,
		V00.A04AnaName,
		V00.A05AnaName,
	
		V00.TAna06ID,
		V00.TAna07ID,
		V00.TAna08ID,
		V00.TAna09ID,
		V00.TAna10ID,
	
		V00.A06AnaName,
		V00.A07AnaName,
		V00.A08AnaName,
		V00.A09AnaName,
		V00.A10AnaName,
		V00.StrParameter01,V00.StrParameter02,V00.StrParameter03, V00.StrParameter04, V00.StrParameter05,
		V00.StrParameter06,V00.StrParameter07,V00.StrParameter08,V00.StrParameter09,V00.StrParameter10  
	From OV3103 V00 left join OV3104 V01 on V00.InventoryID = V01.InventoryID 				
Union ' 
--print  @sSQL
SET @sSQL2 =N'
Select Distinct V00.DivisionID, ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, ''' + @ObjectID + ''' as ObjectID,
        N''' + @ObjectName + ''' as ObjectName,V00.InventoryID, V00.InventoryName, V00.UnitName, V00.Specification,
		V00.InventoryTypeID, V00.Dates, 
		1 as Types,''OFML000183'' as TypeName, V01.OrderQuantity as OrderQuantity, ActualQuantity,  0 as Quantity,
		V01.TAna01ID,
		V01.TAna02ID,
		V01.TAna03ID,
		V01.TAna04ID,
		V01.TAna05ID,
	
		V01.A01AnaName,
		V01.A02AnaName,
		V01.A03AnaName,
		V01.A04AnaName,
		V01.A05AnaName,
	
		V01.TAna06ID,
		V01.TAna07ID,
		V01.TAna08ID,
		V01.TAna09ID,
		V01.TAna10ID,
	
		V01.A06AnaName,
		V01.A07AnaName,
		V01.A08AnaName,
		V01.A09AnaName,
		V01.A10AnaName,
		V01.StrParameter01, V01.StrParameter02, V01.StrParameter03, V01.StrParameter04, V01.StrParameter05,
		V01.StrParameter06, V01.StrParameter07, V01.StrParameter08, V01.StrParameter09, V01.StrParameter10
	From OV3105  V00 left join (Select Distinct InventoryID, OrderQuantity,TAna01ID,
		TAna02ID,
		TAna03ID,
		TAna04ID,
		TAna05ID,
	
		A01AnaName,
		A02AnaName,
		A03AnaName,
		A04AnaName,
		A05AnaName,
	
		TAna06ID,
		TAna07ID,
		TAna08ID,
		TAna09ID,
		TAna10ID,
	
		A06AnaName,
		A07AnaName,
		A08AnaName,
		A09AnaName,
		A10AnaName,
		StrParameter01, StrParameter02, StrParameter03,StrParameter04,StrParameter05,
		StrParameter06, StrParameter07, StrParameter08,StrParameter09,StrParameter10 From OV3103) V01 
		on V00.InventoryID = V01.InventoryID
	Where V00.Dates not in (Select Distinct Dates From OV3102) '
--print  @sSQL2
SET @sSQL1 =
N'Union
Select V00.DivisionID, ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, ''' + @ObjectID + ''' as ObjectID,N''' + @ObjectName + ''' as ObjectName,
		 V00.InventoryID,  V00.InventoryName, V00.UnitName, V00.Specification,
		V00.InventoryTypeID, Dates, 
		2 as Types, ''OFML000184'' as TypeName, V01.OrderQuantity, ActualQuantity, Quantity,
		V01.TAna01ID,
		V01.TAna02ID,
		V01.TAna03ID,
		V01.TAna04ID,
		V01.TAna05ID,
	
		V01.A01AnaName,
		V01.A02AnaName,
		V01.A03AnaName,
		V01.A04AnaName,
		V01.A05AnaName,
	
		V01.TAna06ID,
		V01.TAna07ID,
		V01.TAna08ID,
		V01.TAna09ID,
		V01.TAna10ID,
	
		V01.A06AnaName,
		V01.A07AnaName,
		V01.A08AnaName,
		V01.A09AnaName,
		V01.A10AnaName,
		V01.StrParameter01, V01.StrParameter02, V01.StrParameter03, V01.StrParameter04, V01.StrParameter05,
		V01.StrParameter06, V01.StrParameter07, V01.StrParameter08, V01.StrParameter09, V01.StrParameter10 
	From OV3105 V00 inner join
	(Select Distinct InventoryID, OrderQuantity,
	TAna01ID,
	TAna02ID,
	TAna03ID,
	TAna04ID,
	TAna05ID,
	
	A01AnaName,
	A02AnaName,
	A03AnaName,
	A04AnaName,
	A05AnaName,
	
	TAna06ID,
	TAna07ID,
	TAna08ID,
	TAna09ID,
	TAna10ID,
	
	A06AnaName,
	A07AnaName,
	A08AnaName,
	A09AnaName,
	A10AnaName,
	StrParameter01, StrParameter02,StrParameter03, StrParameter04, StrParameter05,
	StrParameter06, StrParameter07, StrParameter08, StrParameter09,StrParameter10 From OV3103) V01 
		on V00.InventoryID = V01.InventoryID		
Union '
--print  @sSQL1
SET @sSQL3 = N'
Select Distinct V00.DivisionID, ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate,''' + @ObjectID + ''' as ObjectID,N''' + @ObjectName + ''' as ObjectName,
		V00.InventoryID,  V00.InventoryName, V00.UnitName, V00.Specification,
		V00.InventoryTypeID, V00.Dates,  
		2 as Types, ''OFML000184'' as TypeName, OrderQuantity, V01.ActualQuantity, 0 as Quantity,
		V00.TAna01ID,
		V00.TAna02ID,
		V00.TAna03ID,
		V00.TAna04ID,
		V00.TAna05ID,
	
		V00.A01AnaName,
		V00.A02AnaName,
		V00.A03AnaName,
		V00.A04AnaName,
		V00.A05AnaName,
	
		V00.TAna06ID,
		V00.TAna07ID,
		V00.TAna08ID,
		V00.TAna09ID,
		V00.TAna10ID,
	
		V00.A06AnaName,
		V00.A07AnaName,
		V00.A08AnaName,
		V00.A09AnaName,
		V00.A10AnaName,
		V00.StrParameter01, V00.StrParameter02, V00.StrParameter03, V00.StrParameter04,V00.StrParameter05,
		V00.StrParameter06, V00.StrParameter07, V00.StrParameter08, V00.StrParameter09,V00.StrParameter10
	From OV3103 V00 left join OV3104 V01 on V00.InventoryID = V01.InventoryID
	Where Dates not in (Select Distinct Dates From OV3105) '

PRINT @sSQL
PRINT @sSQL2
PRINT @sSQL1
PRINT @sSQL3

If  exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name ='OV3107')
	Drop view OV3107

EXEC('Create view OV3107 ---tao boi OP3006
		as ' +@sSQL+@sSQL2+@sSQL1+@sSQL3)

	--SET @sWhere = ''
	SET @sSql = 'SELECT OV3107.VoucherNo, OV3107.VoucherDate, OV3107.InventoryID, OV3107.InventoryName, OV3107.UnitName, OV3107.Specification,
      OV3107.Types, OV3107.TypeName, OV3107.OrderQuantity, OV3107.ActualQuantity, OV3107.Quantity, OV3106.Dates,OV3107.ObjectName
      From OV3107, OV3106
      Where OV3107.Dates = OV3106.Dates
      AND OV3107.DivisionID in ('''+ @DivisionID +''',''@@@'')'
	  + CASE WHEN Isnull(@DivisionIDList, '') = '' THEN ' AND OV3107.DivisionID IN ('''+ @DivisionID +''',''@@@'')' ELSE ' AND OV3107.DivisionID IN ( ''' + @DivisionIDList + ''',''@@@'')' END +'
  --    '--+ @sWhere +''
	
--PRINT(@sSQL)
EXEC (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
