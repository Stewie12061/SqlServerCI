IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1614]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1614]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by Hoang Thi Lan
--Date 21/10/2003
--Purpose :Dïng hiÓn thÞ d÷ liÖu lªn Grid cña Form (MF1633-Danh môc phiÕu CPDDDKú)
--Edit by Phan thanh hoàng vũ, on 10/08/2015: Bổ sung thêm phần quyền xem dữ liệu của người khác (Danh mục chi phí dỡ dang đầu kỳ-MF0049)
--Modified by Bảo Thy on 22/05/2017: Sửa danh mục dùng chung
--Modified by Nhựt Trường on 24/08/2020: Merge code Meiko.
--Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
--Test: EXEC MP1614 'HT', 'AAA', 1,2013,1,2016,'NV003'
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [02/08/2010]
'**************************************************************/

CREATE PROCEDURE [dbo].[MP1614] @DivisionID as nvarchar(50),@PeriodID as nvarchar(50),
			@FromMonth as int,
			@FromYear as int,
			@ToMonth as int,
			@ToYear as int,
			@UserID nvarchar(50)
as
Declare @FromPeriod as int,
	@ToPeriod as int,
	@sSQL as nvarchar(4000)
Set @FromPeriod=@FromMonth+@FromYear*100
Set @ToPeriod=@ToMonth+@ToYear*100

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	----------------->>>>>> Phân quy?n xem ch?ng t? c?a ng??i dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM MT0000 WHERE DivisionID = @DivisionID AND IsPermissionView = 1) -- N?u check Phân quy?n xem d? li?u t?i Thi?t l?p h? th?ng thì m?i th?c hi?n
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = MT1612.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = MT1612.CreateUserID '
				SET @sWHEREPer = ' AND (MT1612.CreateUserID = AT0010.UserID
										OR  MT1612.CreateUserID = '''+@UserID+''') '		
			END

		-----------------<<<<<< Phân quy?n xem ch?ng t? c?a ng??i dùng khác		

		IF @CustomerName = 50 --(Customize Meiko)
	BEGIN
Set @sSQL='
Select Distinct VoucherTypeID,
	--WipVoucherID,
	VoucherID,
	VoucherNo,
	EmployeeID,
	VoucherDate,
	MT1612.PeriodID,
	ProductID,
	MT1612.Type,
	AT1302.InventoryName as ProductName,
	AT1302.UnitID,
	'+ case when @CustomerName=57 then 'SUM(ISNULL(WipQuantity, 0)) as ' else '' end + 'ProductQuantity,sum(ConvertedAmount) as ConvertedAmount,
	MT1612.DivisionID, MT1612.Description, MT1601.Description AS PeriodName

From MT1612 left join AT1302 on MT1612.ProductID = AT1302.InventoryID and AT1302.DivisionID IN (MT1612.DivisionID,''@@@'')
' + @sSQLPer+ '
Where MT1612.DivisionID='''+ @DivisionID +'''
	and TranMonth+TranYear*100 between '+str(@FromPeriod)+' and '+str(@ToPeriod)+'
	and MT1612.PeriodID like '''+@PeriodID+'''
	'+ @sWHEREPer+'
Group by  VoucherTypeID,
	VoucherID,
	VoucherNo,
	EmployeeID,
	VoucherDate,
	MT1612.PeriodID,
	ProductID,
	MT1612.Type,	
	AT1302.InventoryName,
	AT1302.UnitID, ProductQuantity,
	MT1612.DivisionID'
	END
		ELSE
	BEGIN
Set @sSQL='
Select Distinct VoucherTypeID,
	--WipVoucherID,
	VoucherID,
	VoucherNo,
	EmployeeID,
	VoucherDate,
	PeriodID,
	ProductID,
	MT1612.Type,
	AT1302.InventoryName as ProductName,
	AT1302.UnitID,
	SUM(ISNULL(WipQuantity, 0)) as ProductQuantity,sum(ConvertedAmount) as ConvertedAmount,
	MT1612.DivisionID

From MT1612 left join AT1302 on MT1612.ProductID = AT1302.InventoryID AND AT1302.DivisionID IN (MT1612.DivisionID,''@@@'')
' + @sSQLPer+ '
Where MT1612.DivisionID='''+ @DivisionID +'''
	and TranMonth+TranYear*100 between '+str(@FromPeriod)+' and '+str(@ToPeriod)+'
	and MT1612.PeriodID like '''+@PeriodID+'''
	'+ @sWHEREPer+'
Group by  VoucherTypeID,
	VoucherID,
	VoucherNo,
	EmployeeID,
	VoucherDate,
	PeriodID,
	ProductID,
	MT1612.Type,	
	AT1302.InventoryName,
	AT1302.UnitID,
	MT1612.DivisionID'
	END
If not Exists (Select top 1 1 From SysObjects Where Xtype ='V' and name ='MV1614')
	 Exec ('Create view MV1614 as '  +@sSQL)
Else
	Exec ('Alter view MV1614 as '+@sSQL)
--Print @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
