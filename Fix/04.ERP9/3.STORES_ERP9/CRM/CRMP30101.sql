IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30101]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Khách hàng mới theo nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 27/01/2016
---- Modified by thị phượng on 03/11/2016: chỉnh sửa lấy nhân viên giao dịch là nhân viên lập đơn hàng
---- Modified by thị phượng on 09/01/2017: Fix bug dữ liệu
-- <Example>
----    EXEC CRMP30101 'HT','','2017-01-03 00:00:00','2017-01-03 00:00:00','31253-B.10*3','31253-B.10*3','','', 'ASOFTADMIN'
CREATE PROCEDURE [dbo].[CRMP30101] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@FromDate         DATETIME,
		@ToDate           DATETIME,
		@FromAccountID    NVarchar(50),
		@ToAccountID         NVarchar(50),
		@FromEmployeeID      NVarchar(50),
		@ToEmployeeID        NVarchar(50),
		@UserID  VARCHAR(50)
		
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 Nvarchar(Max),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max)

SET @sWhere2 = ''
SET @sWhere3 = ''
SET @sWhere =  ' AND (CONVERT(VARCHAR(10),OT01.OrderDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
Set @sWhere1 =	' AND (CONVERT(VARCHAR(10),OT01.OrderDate,112) < '''+ CONVERT(VARCHAR(20),@FromDate,112)+ ''' )'


--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' OT01.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere2 = @sWhere2+ ' OT01.DivisionID IN ('''+@DivisionIDList+''')'

	IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') !=''))
		SET @sWhere3 = @sWhere3 +' AND (CR01.AccountID between N'''+@FromAccountID+''' and N'''+@ToAccountID+''')'
	IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') =''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.AccountID as Nvarchar(50)) >= N'''+cast(@FromAccountID as Nvarchar(50))+''''
	IF ((Isnull(@FromAccountID, '') ='')and (Isnull(@ToAccountID, '') !=''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.AccountID as Nvarchar(50)) <= N'''+cast(@ToAccountID as Nvarchar(50))+'''' 
	
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND (OT01.CreateUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
		SET @sWhere2 = @sWhere2 +'AND cast(OT01.CreateUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND cast(OT01.CreateUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''

---Load danh sách khách hàng mới theo nhân viên
SET @sSQL =
	'Select b.DivisionID as Division, b.DivisionName,  Convert(Nvarchar(10),b.OrderDate,103) as OrderDate  , b.AccountID, b.AccountName, b.Address ,b.Tel, 
		max(c.InventoryID) InventoryID, max(c.InventoryName) InventoryName ,c.OrderQuantity, c.SalesManID, c.FullName, max(b.Notes) as Notes
		From  (select f.DivisionID, f.DivisionName, e.OrderDate, f.AccountID, f.AccountName, f.Address, f.Tel, 
			f.CreateUserID, f.SalesManID, f.Notes, f.InventoryID, f.InventoryName, AD from 
			(SELECT CR01.DivisionID, AT01.DivisionName, OT01.OrderDate , CR01.AccountID, CR01.AccountName, 
			CR01.Address, CR01.Tel, CR01.CreateUserID, OT01.SalesManID,
			Max(AT02.InventoryID) as InventoryID ,Max(AT02.InventoryName)as InventoryName, Isnull(OT02.Parameter01, 0) as Notes, count(OrderDate) as AD
			FROM CRMT10101 CR01 WITH (NOLOCK)
			Left JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = CR01.DivisionID AND OT01.ObjectID = CR01.AccountID
			Inner JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = CR01.DivisionID AND OT01.SOrderID = OT02.SOrderID
			Left JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID = CR01.DivisionID AND AT02.InventoryID = OT02.InventoryID
			Left Join AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID= CR01.DivisionID
			Where   '+@sWhere2+ @swhere3+ @sWhere+'
			And CR01.AccountID not in (SELECT CR01.AccountID FROM CRMT10101 CR01
				Inner JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = CR01.DivisionID AND OT01.ObjectID = CR01.AccountID
				Inner JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = CR01.DivisionID AND OT01.SOrderID = OT02.SOrderID
				Where   '+@sWhere2+ @swhere3+ @sWhere1+')
			Group by CR01.DivisionID, CR01.AccountID, CR01.AccountName, AT01.DivisionName,
			CR01.Address, CR01.Tel, CR01.CreateUserID,OT02.Parameter01, OT01.SalesManID, OT01.OrderDate
			)f 
			inner join (select DivisionID, Max(OrderDate) as OrderDate, ObjectID From OT2001 
			group by DivisionID, ObjectID
			)e on e.DivisionID=f.DivisionID and e.ObjectID =f.AccountID and e.OrderDate =f.OrderDate
		)b INNER join  (Select A.DivisionID, A.ObjectID, y.InventoryID, A.OrderQuantity, y.InventoryName, A.SalesManID, A.Fullname
		From( Select x.DivisionID, x.ObjectID, Max(x.OrderQuantity) as OrderQuantity,x.SalesManID, x.FullName
			from (Select OT01.DivisionID, OT01.ObjectID, OT02.InventoryID , Max(OT02.OrderQuantity) as OrderQuantity , OT01.SalesManID, AT03.FullName
			from OT2001 OT01 WITH (NOLOCK) 
			Left join OT2002 OT02 WITH (NOLOCK) On OT01.DivisionID = OT02.DivisionID and OT01.SOrderID = OT02.SOrderID
			Left JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID = OT01.DivisionID AND AT03.EmployeeID = OT01.SalesManID
			where  '+@sWhere2+'
			Group by OT01.DivisionID,OT01.ObjectID, OT02.InventoryID , OT01.SalesManID, AT03.FullName) x
		Group By x.DivisionID, x.ObjectID,x.SalesManID, x.FullName
		) A left join (
			Select OT01.DivisionID, OT01.ObjectID, OT02.InventoryID , H.InventoryName , MAx(OT02.OrderQuantity) as  MOrderQuantity 
			from OT2001 OT01 WITH (NOLOCK) 
			Left join OT2002 OT02 WITH (NOLOCK) On OT01.DivisionID = OT02.DivisionID and OT01.SOrderID = OT02.SOrderID
			Left join AT1302 H WITH (NOLOCK) On OT01.DivisionID = H.DivisionID and H.InventoryID = OT02.InventoryID
			where  '+@sWhere2+'
			Group by OT01.DivisionID,OT01.ObjectID, OT02.InventoryID , H.InventoryName, OT01.CreateUserID 
			) y on A.DivisionID = y.DivisionID and A.ObjectID = y.ObjectID
		Where A.OrderQuantity = y.MOrderQuantity
		)c ON b.AccountID = c.ObjectID And b.DivisionID = c.DivisionID	AND b.InventoryID = c.InventoryID and b.SalesManID = c.SalesManID
		Group by b.AccountID, b.DivisionID, b.AccountName, b.Address ,b.Tel, b.DivisionName,
		c.OrderQuantity, c.SalesManID, c.FullName,  b.OrderDate

		Order by b.AccountID, c.SalesManID
				'

EXEC (@sSQL)
--print (@sSQL)
GO
