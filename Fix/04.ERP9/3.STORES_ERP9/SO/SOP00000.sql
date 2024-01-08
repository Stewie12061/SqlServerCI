IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP00000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP00000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--<Summary>
-- Store load dữ liệu cho Dashboard của module SO
-- <Param>
-- 
--<Return>
-- 
-- <Reference>
-- 
--<History>
--Created by: Đoàn Duy, Date: 10/05/2021

--<Example>
/* 
EXEC SOP00000 'DTI', '', 1, '2015-01-01', '2017-12-30',
'01/2021'',''12/2020'',''11/2020'',''10/2020'',''09/2020'',''08/2020'',''07/2020'',''06/2020'',''05/2020'',''04/2020'',''03/2020'',''02/2020'',''01/2020'',''12/2019'',''11/2019'',''10/2019'',''09/2019'',''08/2019'',''07/2019'',''06/2019'',''05/2019'',''04/2019'',''03/2019'',''02/2019'',''01/2019',
'ASOFTADMIN',
'ASOFTADMIN'',''D11001'',''D16001'',''D21001'',''D26001'',''D26002'',''D31001'',''D31002'',''D31003'',''D31004'',''D31006'',''D31007'',''D31008'',''D31009'',''D36001'',''D41001'',''D41002'',''D46001'',''D51001'',''D51002'',''D51003'',''D51004'',''D51005'',''DGD001'',''DKS001'',''DQT001'',''NGA'',''NGA002'',''NV01'',''NV02'',''NV03'',''NV04'',''SUPPORT'',''T000001'',''T000007'',''T000008'',''T000009'',''T000010'',''T000011'',''T000013'',''T000016'',''TANLOC'',''TANLOC1'',''TANTHANH'',''THANHTHANH'',''TOAN'',''TOAN_PRV'',''TRUONGLAM'',''UNASSIGNED'',''USER01'',''USER02'',''USER03'',''USER04'',''USER05'',''USERTEST'',''USERTESTROLE1'
*/
--
CREATE PROCEDURE SOP00000 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = NULL,  --Chọn trong DropdownChecklist DivisionID
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@ConditionSOrderID  NVARCHAR(Max) = NULL		
) 
AS 
BEGIN 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
SET @sWhere='1 = 1'     
SET @OrderBy = ' M.CreateDate DESC, M.OrderDate, M.VoucherNo'   
--IF isnull(@SearchWhere,'') =''
Begin
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),OT2001.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + ' AND (CASE WHEN OT2001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) 
				ELSE rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and OT2001.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'and OT2001.DivisionID IN ('''+@DivisionIDList+''')'
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT2001.EmployeeID, OT2001.CreateUserID) in ('''+@ConditionSOrderID+''')'
End


SET @sSQL = N'
SELECT OT2001.APK, OT2001.DivisionID
, OT2001.ObjectID, OT2001.ObjectName 
, OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description as OrderStatusName
, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName EmployeeID
, OT2001.IsInvoice, Sum(A.ConvertedAmount) as TotalAmount
Into #TemOT2001
FROM OT2001 With (NOLOCK) 
Inner join OT2002 A  With (NOLOCK) ON A.DivisionID = OT2001.DivisionID and A.SOrderID =OT2001.SOrderID
			Left join AT1103 A03 With (NOLOCK) on OT2001.EmployeeID = A03.EmployeeID
			Left join AT0099 With (NOLOCK) on Convert(varchar, OT2001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
			Left join OOT0099  B With (NOLOCK) on isnull(OT2001.Status,0) = B.ID and B.CodeMaster = ''Status'' and B.Disabled = 0
			Left join OOT0099  B1 With (NOLOCK) on 1 = B1.ID and B1.CodeMaster = ''Status'' and B1.Disabled = 0
	WHERE '+@sWhere+'
	Group by OT2001.APK, OT2001.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate
	, OT2001.ObjectID, OT2001.ObjectName , OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description
	, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName 
	, OT2001.SalesManID, OT2001.ShipDate,OT2001.Status, B.Description,B1.Description, OT2001.DescriptionConfirm
	, OT2001.ConfirmDate, OT2001.ConfirmUserID, OT2001.IsInvoice

	Declare @Count int
	Select @Count = Count(OrderStatus) From  #TemOT2001

	Declare @Amount decimal
	Select @Amount = SUM(TotalAmount) From #TemOT2001

	
	

	SELECT Top 1 @Count AS TotalOrder, --- Tổng số đơn hàng
	@Amount as TotalAmount, --- Tổng tiền
	@Amount / @Count as AVGAmount, --- Giá trị trung bình
	(Select Count(APK) From #TemOT2001 Where ObjectID In (Select ObjectID From OT2001 With (NOLOCK)  where '+@sWhere+' Group by ObjectID HAVING COUNT(*)  > 1)) as RepeatedOrder, --- Số đơn hàng lặp lại
	(Select Count(Distinct InventoryID) From OT2002 With (NOLOCK)  Where '+@sWhere+') as TotalProduct, --- Tổng số sản phẩm
	(Select count(OrderStatus) From #TemOT2001 With (NOLOCK) Where OrderStatus = 0) as UnconfimredOrders, --- Tổng số đơn hàng chưa chấp nhận
	(Select count(OrderStatus) From #TemOT2001 With (NOLOCK) Where OrderStatus = 2) as ProcessingOrders, --- Tổng số đơn hàng chưa chấp nhận
	(Select count(OrderStatus) From #TemOT2001 With (NOLOCK) Where OrderStatus = 3) as CompleteOrders --- Tổng số đơn hàng chưa chấp nhận
	FROM OT2001  With (NOLOCK) 

	Select top 3 O1.InventoryID, A1.InventoryName, count(*) as Count from OT2002 O1 With (NOLOCK) 
	INNER JOIN AT1302 A1 With (NOLOCK) on O1.InventoryID = A1.InventoryID
	INNER JOIN OT2001 With (NOLOCK) on O1.SOrderID = OT2001.SOrderID
	Where '+@sWhere+' --- Sản phẩm bán chạy		
	Group by O1.InventoryID, A1.InventoryName
	order by Count DESC

'

EXEC (@sSQL)
end
print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
