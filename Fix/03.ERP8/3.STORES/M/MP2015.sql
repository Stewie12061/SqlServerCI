IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[MP2015]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load Grid màn hình Kế thừa phiếu giao việc (Master)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phan thanh hoang vu
----Create date: 02/03/2015
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by hoàng vũ on 31/10/2016: không check trường hợp bị kế thừa hết với phiếu kết quả sản xuất
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
	exec MP2015 @DivisionID='SC',@FromMonth=7,@FromYear=2015,@ToMonth=10,@ToYear=2016,@IsType=0,@WareHouseID=N''
*/
 CREATE PROCEDURE MP2015
(
	@DivisionID VARCHAR(50),
    @FromMonth as int,
	@FromYear as int,
	@ToMonth as int,
	@ToYear as int,
	@IsType tinyint, --0: Kế quả sản sản xuất; 1: Phiếu xuất kho
	@WareHouseID as varchar(50)
)
AS
BEGIN
		DECLARE @sSQL NVARCHAR (MAX),
				@sWhere NVARCHAR(MAX),
				@sSQL1 NVARCHAR (MAX),
				@sWhere1 NVARCHAR(MAX),
				@OrderBy NVARCHAR(500),
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20)
				
				SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
				SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
				
				SET @sWhere = ''
				SET @OrderBy = ' M.VoucherDate, M.VoucherNo, M.ObjectID'
	
				IF Isnull(@DivisionID, '') != ''
					SET @sWhere = @sWhere + ' And M.DivisionID = '''+ @DivisionID+''''
				IF isnull(@WareHouseID, '') != '' 
					SET @sWhere = @sWhere + ' And D.WareHouseID = '''+ @WareHouseID+''' '
				
				
				If @IsType = 0
				Begin
					Set @sSQL1 = ' Left join ( 
											Select D.DivisionID, D.InventoryID, D.UnitID, Sum(D.Quantity) as Quantity, D.InheritVoucherID, 
											D.InheritTransactionID, D.InheritTableID
											From MT0810 M WITH (NOLOCK) inner join MT1001 D WITH (NOLOCK) on M.DivisionID =  D.DivisionID and M.VoucherID = D.VoucherID
																				and D.InheritVoucherID is not null
											Group by D.DivisionID, D.InventoryID, D.UnitID, D.InheritVoucherID, 
											D.InheritTransactionID, D.InheritTableID
										) A07 on D.DivisionID = A07.DivisionID and  D.VoucherID = A07.InheritVoucherID 
																				and D.TransactionID = A07.InheritTransactionID '
					Set @sWhere1 =  ' '
					--Set @sWhere1 =  ' Having Sum(Isnull(D.Quantity,0)) - Sum(Isnull(A07.Quantity,0)) > 0 '
				End
				If @IsType = 1
				Begin
					Set @sSQL1 = ' Left join ( 
											Select D.DivisionID, D.InventoryID, D.UnitID, D.ActualQuantity, D.InheritVoucherID, 
											D.InheritTransactionID, D.InheritTableID
											From AT2006 M WITH (NOLOCK) inner join AT2007 D WITH (NOLOCK) on M.DivisionID =  D.DivisionID and M.VoucherID = D.VoucherID
																				and D.InheritVoucherID is not null
										) A07 on D.DivisionID = A07.DivisionID and  D.VoucherID = A07.InheritVoucherID 
																				and D.TransactionID = A07.InheritTransactionID '
					Set @sWhere1 =  ' Having Sum(Isnull(D.Quantity,0)) - Sum(Isnull(A07.ActualQuantity,0)) > 0 '
					
				End
				
				SET @sSQL = '
							Select  Distinct convert(bit,0) as Choose, M.DivisionID, M.VoucherID,M.TranMonth,M.TranYear,
									M.VoucherTypeID, A17.VoucherTypeName, M.VoucherDate,M.VoucherNo,
									M.RefNo01,M.RefNo02,M.RefNo03,M.RefNo04,M.RefNo05,
									M.ObjectID, A12.ObjectName,
									M.LaborID,
									Ltrim(RTrim(isnull(A131.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(A131.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(A131.FirstName,''''))) AS LaborName,
									M.EmployeeID, A132.FullName as EmployeeName,
									M.Description,M.OrderStatus

							From MT2007 M WITH (NOLOCK) Inner join MT2008 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID ' + 
											@sSQL1
										  + ' Left join AT1202 A12 WITH (NOLOCK) on A12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND M.ObjectID = A12.ObjectID
										  Left join HT1400 A131 WITH (NOLOCK) on M.LaborID = A131.EmployeeID and M.DivisionID = A131.DivisionID
										  Left join AT1103 A132 WITH (NOLOCK) on M.EmployeeID = A132.EmployeeID
										  Left join AT1007 A17 WITH (NOLOCK) on M.VoucherTypeID = A17.VoucherTypeID and M.DivisionID = A17.DivisionID
							WHERE --M.OrderStatus = 0 and 
							M.TranMonth + 100*M.TranYear between  '+ @FromMonthYearText  + ' and  ' + @ToMonthYearText
							+@sWhere + 
							' Group by M.DivisionID, M.VoucherID, M.TranMonth, M.TranYear, M.VoucherTypeID, A17.VoucherTypeName, M.VoucherDate, 
									   M.VoucherNo, M.RefNo01, M.RefNo02, M.RefNo03, M.RefNo04, M.RefNo05, M.ObjectID,A12.ObjectName, M.LaborID, 
									   A131.LastName,A131.MiddleName,A131.FirstName, M.EmployeeID, A132.FullName, M.Description,M.OrderStatus '+ @sWhere1 + ' Order by ' +  @OrderBy + ''

				EXEC (@sSQL)
				--Print @sSQL
				
			
END
