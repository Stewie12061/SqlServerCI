IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0812]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0812]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Hoµng ThÞ Lan
--Date 31/10/2003
--Purpose:In bao cao Ket qua san xuat
--Edit by: Dang Le Bao Quynh; Date 27/04/2007
--Purpose: Them truong he so chuyen doi va nhom theo ma phan tich
--Edit Tuyen. date 04/05/2010 xu ly chia cho 0
--- Modify on 11/06/2014 by Bảo Anh: Sửa cách tính ConvertedAmount (phân bổ đều giá thành vì có trường hợp nhiều phiếu KQSX có 1 mặt hàng cùng tỷ lệ hoàn thành)
---- Modified on 13/08/2014 by Le Thi Thu Hien : ConvertedAmount đã tính cho từng Quantity*Price
---- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
/********************************************
'* Edited by: [GS] [Tố Oanh] [30/07/2010]
'********************************************/
---- Modified by Phương Thảo on 11/07/2017: Bổ sung dữ liệu tham số (tính SL QĐ), chi phí tập hợp và tổng thành tiền (NAMDAN)
---- Modified by Kim Thư on 24/8/2017: Bổ sung load cột Lô nhập (SourceNo) và Chứng từ nhập (ImVoucherNo)
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Thanh Lượng on 21/02/2023:[2023/02/TA/0097] - Bổ sung thêm trường dữ liệu RefInventoryID(Mã tham chiếu).
---- Modified by Đức Duy on 28/03/2023:[2023/03/IS/0253] - Bổ sung thêm các trường dữ liệu ObjectID, WarehouseID, TransferPeriodID, ProductID1, DebitaccountID, CreditaccountID, SOrderNo, Ana01ID.

CREATE Procedure [dbo].[MP0812]       
(
				@DivisionID nvarchar(50),	
				@PeriodID as nvarchar(50),	
				@ResultTypeID as nvarchar(50),		 
				@FromMonth as int,
				@FromYear as int,
				@ToMonth as int,
				@ToYear as int,
				@AnaID as nvarchar(50)
)
as	
Declare @sSQL as nvarchar(max),
	@sSQL1 as nvarchar(max) = '',
	@FromPeriod as int,
	@ToPeriod as int,
	@Where@ResultTypeID as nvarchar(2000)

Select  @FromPeriod =    @FromMonth + @FromYear*100,  @ToPeriod = @ToMonth + @ToYear*100,
		@Where@ResultTypeID = case when isnull(@ResultTypeID, '') = '' then '' else ' and MT0810.ResultTypeID=''' + @ResultTypeID + '''' end

If (@AnaID Is Null or @AnaID='')
BEGIN
	Set @sSQL='
	SELECT DISTINCT MT0810.VoucherID,
		MT0810.VoucherTypeID,
		MT0810.PeriodID,
		MT1601.Description as PeriodName,
		MT0810.DivisionID,
		MT0810.DepartmentID,
		AT1102.DepartmentName,
		MT0810.VoucherNo,
		MT0810.VoucherDate,
		MT0810.EmployeeID,	
		MT0810.KCSEmployeeID,	
		MT0810.Description,
		MT0810.CreateDate,
		MT0810.CreateUserID,
		MT0810.LastModifyUserID,
		MT0810.LastModifyDate,
		MT0810.ResultTypeID,
		MT0811.ResultTypeName,
		MT0810.InventoryTypeID,
		AT1301.InventoryTypeName,
		MT1001.PerfectRate,
		MT1001.ProductID,
		AT1302.RefInventoryID as RefInventoryID,
		AT1302.InventoryName as ProductName,
		AT1302.Notes01 as Notes01,
		AT1302.Notes02 as Notes02,
		AT1302.Notes03 as Notes03,
		MT1001.[Parameter01],
		MT1001.[Parameter02],
		MT1001.[Parameter03],
		MT1001.[Parameter04],
		MT1001.[Parameter05],
		MT1001.UnitID,
		MT1001.TransactionID,
		MT1001.Price,
		MT1001.ConvertedAmount,
		--(case when MT0810.ResultTypeID = ''R01'' then MT1001.ConvertedAmount
		--else (MT1001.ConvertedAmount/(select count(T80.VoucherID) from MT0810 T80
		--						Where T80.ResultTypeID = MT0810.ResultTypeID and T80.TranMonth = MT0810.TranMonth and T80.TranYear = MT0810.TranYear and T80.PeriodID = MT0810.PeriodID
		--						And VoucherID in (Select T01.VoucherID From MT1001 T01 Where T01.ProductID = MT1001.ProductID and Isnull(T01.PerfectRate,100) = Isnull(MT1001.PerfectRate,100))								 
		--)) end) as ConvertedAmount,
		MT1001.Note,
		MT1001.Quantity,
		MT1001.MaterialRate,
		MT1001.HumanResourceRate,
		MT1001.OthersRate, Null as AnaIDGroup, Null as AnaNameGroup,
		(Select Top 1 
		(Case When Operator = 1 Then ConversionFactor Else 1/ case when isnull(ConversionFactor,1) = 0 then 1 end   End) As ConversionFactor 
		From AT1309 
		Where InventoryID  =  MT1001.ProductID
		Order by At1309.UnitID) As ConversionFactor, 
		(Select Top 1 
		 (select UnitName From AT1304 Where UnitID = AT1309.UnitID) As UnitName  
		 From AT1309 
		 Where InventoryID  =  MT1001.ProductID
		 Order by At1309.UnitID) As UnitName, 
		 MT1001.MOrderID,
		 MT1614.Cost621, MT1614.Cost622, MT1614.Cost627,
		 (SELECT SUM(T2.ConvertedAmount) AS ConvertedAmount
		  FROM MT0810 T1  	      
		  INNER JOIN MT1001 T2 on T1.VoucherID=T2.VoucherID and T1.DivisionID=T2.DivisionID
		  WHERE	T1.DivisionID = ''' + @DivisionID + ''' 
		  AND T1.PeriodID like '''+@PeriodID+''' 
		  AND T1.TranMonth+T1.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) + @Where@ResultTypeID+'
		  AND T1.TranMonth = MT0810.TranMonth AND T1.TranYear = MT0810.TranYear AND T1.PeriodID = MT0810.PeriodID
		  ) AS TotalAmount, MT1001.ConvertedUnitID, MT1001.ConvertedQuantity, AT1304.UnitName AS ConvertedUnitName, MT1001.Orders,
		  MT1001.SourceNo, AT2006.VoucherNo AS ImVoucherNo,
		  MT0810.ObjectID, MT0810.WarehouseID, MT0810.TransferPeriodID,
		  MT1001.DebitAccountID, MT1001.CreditAccountID, MT1001.ProductID1, MT1001.Ana01ID,
		  OT2001.VoucherNo as SOrderNo'
	
	SET @sSQL1 = '
	FROM	MT0810   	      
	INNER JOIN MT1001 on MT0810.VoucherID=MT1001.VoucherID and MT0810.DivisionID=MT1001.DivisionID
	LEFT JOIN AT1302 on MT1001.ProductID=AT1302.InventoryID AND AT1302.DivisionID IN (MT1001.DivisionID,''@@@'')
	INNER JOIN MT1601 on MT0810.PeriodID=MT1601.PeriodID and MT0810.DivisionID=MT1601.DivisionID
	LEFT JOIN OT2001 on MT0810.DivisionID = OT2001.DivisionID and MT0810.VoucherNo = OT2001.VoucherNo
	LEFT JOIN AT1301 on AT1301.InventoryTypeID=MT0810.InventoryTypeID
	LEFT JOIN AT1102 on AT1102.DepartmentID=MT0810.DepartmentID
	LEFT JOIN MT0811 on MT0810.ResultTypeID=MT0811.ResultTypeID and MT0810.DivisionID=MT0811.DivisionID
	left join AT1304 on MT1001.ConvertedUnitID=AT1304.UnitID and MT1001.DivisionID=AT1304.DivisionID
	LEFT JOIN
	(SELECT DivisionID, TranMonth, TranYear, PeriodID, SUM([Cost621]) AS Cost621, SUM([Cost622]) AS Cost622, SUM([Cost627]) AS Cost627
	FROM MT1614	
	WHERE MT1614.DivisionID = ''' + @DivisionID + ''' 
		  AND MT1614.PeriodID like '''+@PeriodID+''' 
		  AND MT1614.TranMonth+MT1614.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) +'
	GROUP BY DivisionID, TranMonth, TranYear, PeriodID) MT1614 ON MT1614.DivisionID = MT0810.DivisionID AND MT1614.TranMonth = MT0810.TranMonth 
														AND MT1614.TranYear = MT0810.TranYear AND MT1614.PeriodID = MT0810.PeriodID	
	LEFT JOIN AT2006 ON MT0810.VoucherID = AT2006.VoucherID AND AT2006.TableID = ''MT0810''

	WHERE	MT0810.DivisionID = ''' + @DivisionID + ''' 
			AND MT0810.PeriodID like '''+@PeriodID+''' 
			AND MT0810.TranMonth+MT0810.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) + @Where@ResultTypeID
END
Else
BEGIN
	Set @sSQL='
		Select Distinct MT0810.VoucherID,
		MT0810.VoucherTypeID,
		MT0810.PeriodID,
		MT1601.Description as PeriodName,
		MT0810.DivisionID,
		MT0810.DepartmentID,
		AT1102.DepartmentName,
		MT0810.VoucherNo,
		MT0810.VoucherDate,
		MT0810.EmployeeID,	
		MT0810.KCSEmployeeID,	
		MT0810.Description,
		MT0810.CreateDate,
		MT0810.CreateUserID,
		MT0810.LastModifyUserID,
		MT0810.LastModifyDate,
		MT0810.ResultTypeID,
		MT0811.ResultTypeName,
		MT0810.InventoryTypeID,
		AT1301.InventoryTypeName,
		MT1001.PerfectRate,
		MT1001.ProductID,
		AT1302.RefInventoryID as RefInventoryID,
		AT1302.InventoryName as ProductName,
		AT1302.Notes01 as Notes01,
		AT1302.Notes02 as Notes02,
		AT1302.Notes03 as Notes03,
		MT1001.[Parameter01],
		MT1001.[Parameter02],
		MT1001.[Parameter03],
		MT1001.[Parameter04],
		MT1001.[Parameter05],
		MT1001.UnitID,
		MT1001.TransactionID,
		MT1001.Price,
		MT1001.ConvertedAmount,
		--(MT1001.ConvertedAmount/(Select count(*) From MT1001 T01 Where T01.DivisionID = MT1001.DivisionID And T01.ProductID = MT1001.ProductID
		--And T01.PerfectRate = MT1001.PerfectRate)) as ConvertedAmount,
		MT1001.Note,
		MT1001.Quantity,
		MT1001.MaterialRate,
		MT1001.HumanResourceRate,
		MT1001.OthersRate, (Select ' + @AnaID + 'ID From AT1302 Where DivisionID IN (MT1001.DivisionID,''@@@'') AND InventoryID = MT1001.ProductID) As AnaIDGroup,
		(Select AnaName From AT1015 Where AnaTypeID = ''' + @AnaID + ''' And AnaID In (Select ' + @AnaID + 'ID From AT1302 Where DivisionID IN (MT1001.DivisionID,''@@@'') AND InventoryID = MT1001.ProductID)) As AnaNameGroup,
		(Select Top 1 UserName From AT0005 Where TypeID = ''' + @AnaID  + ''' And DivisionID = MT1001.DivisionID) As AnaNameCommon, 
		(Select Top 1 
		(Case When Operator = 1 Then ConversionFactor Else 1/case when isnull(ConversionFactor,1) = 0 then 1 end  End) As ConversionFactor 
		From AT1309 
		Where InventoryID  =  MT1001.ProductID
		Order by At1309.UnitID) As ConversionFactor, 
		(Select Top 1 
		(select UnitName From AT1304 Where UnitID = AT1309.UnitID) As UnitName  
		From AT1309 
		Where InventoryID  =  MT1001.ProductID
		Order by At1309.UnitID) As UnitName, MT1001.MOrderID,	
		MT1614.Cost621, MT1614.Cost622, MT1614.Cost627,
		 (SELECT SUM(T2.ConvertedAmount) AS ConvertedAmount
		  FROM MT0810 T1  	      
		  INNER JOIN MT1001 T2 on T1.VoucherID=T2.VoucherID and T1.DivisionID=T2.DivisionID
		  WHERE	T1.DivisionID = ''' + @DivisionID + ''' 
		  AND T1.PeriodID like '''+@PeriodID+''' 
		  AND T1.TranMonth+T1.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) + @Where@ResultTypeID+'
		  AND T1.TranMonth = MT0810.TranMonth AND T1.TranYear = MT0810.TranYear AND T1.PeriodID = MT0810.PeriodID
		  ) AS TotalAmount, MT1001.ConvertedUnitID, MT1001.ConvertedQuantity, AT1304.UnitName AS ConvertedUnitName, MT1001.Orders,
		  MT1001.SourceNo, AT2006.VoucherNo AS ImVoucherNo,
		  MT0810.ObjectID, MT0810.WarehouseID, MT0810.TransferPeriodID,
		  MT1001.DebitAccountID, MT1001.CreditAccountID, MT1001.ProductID1, MT1001.Ana01ID,
		  OT2001.VoucherNo as SOrderNo'
	
	SET @sSQL1 = '
	From MT0810   	      
	inner join MT1001 on MT0810.VoucherID=MT1001.VoucherID 	and MT0810.DivisionID=MT1001.DivisionID
	left join AT1302 on MT1001.ProductID=AT1302.InventoryID AND AT1302.DivisionID IN (MT1001.DivisionID,''@@@'')
	inner join MT1601 on MT0810.PeriodID=MT1601.PeriodID and MT0810.DivisionID=MT1601.DivisionID
	LEFT JOIN OT2001 on MT0810.DivisionID = OT2001.DivisionID and MT0810.VoucherNo = OT2001.VoucherNo
	left join AT1301 on AT1301.InventoryTypeID=MT0810.InventoryTypeID
	left join AT1102 on AT1102.DepartmentID=MT0810.DepartmentID
	left join MT0811 on MT0810.ResultTypeID=MT0811.ResultTypeID and MT0810.DivisionID=MT0811.DivisionID
	left join AT1304 on MT1001.ConvertedUnitID=AT1304.UnitID and MT1001.DivisionID=AT1304.DivisionID
	LEFT JOIN
	(SELECT DivisionID, TranMonth, TranYear, PeriodID, SUM([Cost621]) AS Cost621, SUM([Cost622]) AS Cost622, SUM([Cost627]) AS Cost627
	FROM MT1614	
	WHERE MT1614.DivisionID = ''' + @DivisionID + ''' 
		  AND MT1614.PeriodID like '''+@PeriodID+''' 
		  AND MT1614.TranMonth+MT1614.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) +'
	GROUP BY DivisionID, TranMonth, TranYear, PeriodID) MT1614 ON MT1614.DivisionID = MT0810.DivisionID AND MT1614.TranMonth = MT0810.TranMonth 
														AND MT1614.TranYear = MT0810.TranYear AND MT1614.PeriodID = MT0810.PeriodID	
	
	LEFT JOIN AT2006 ON MT0810.VoucherID = AT2006.VoucherID AND AT2006.TableID = ''MT0810''
	Where MT0810.DivisionID = ''' + @DivisionID + ''' and MT0810.PeriodID like '''+@PeriodID+''' 
		and MT0810.TranMonth+MT0810.TranYear*100 between ' + str(@FromPeriod)+' and ' + str(@ToPeriod) + @Where@ResultTypeID
END	
--Print @sSQL
--Exec (@sSQL)
If not exists (Select top 1 1 From SysObjects Where name = 'MV0812' and Xtype ='V')
	Exec ('Create view MV0812 as '+@sSQL+@sSQL1)
Else
	Exec ('Alter view MV0812 as '+@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
