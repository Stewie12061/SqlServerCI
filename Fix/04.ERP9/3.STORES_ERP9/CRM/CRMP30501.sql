IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30501]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP30501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----In báo cáo số lượng Đơn hàng theo nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 12/09/2016
-- <Example>
----    EXEC CRMP30501 'HT','',1,'2016-07-02','2016-08-02','6/2016'',''8/2016','',''

CREATE PROCEDURE [dbo].[CRMP30501] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsPeriod AS TINYINT,
		@FromDate         DATETIME,
		@ToDate           DATETIME,
		@Period nvarchar(max),
		@EmployeeIDList  NVarchar(MAx),
		@UserID  VARCHAR(50)
		
)
AS
BEGIN 
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
SET @sWhere=''
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere =@sWhere+ ' AND O01.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere+ ' AND O01.DivisionID IN ('''+@DivisionIDList+''')'

	IF isnull(@EmployeeIDList,'') != '' 
		SET @sWhere = @sWhere +' AND O01.CreateUserID IN ('''+@EmployeeIDList+''')'
		
	IF @IsPeriod = 1
		SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),O01.OrderDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
	IF @IsPeriod = 0
		SET @sWhere = @sWhere + ' AND (CASE WHEN O01.TranMonth <10 THEN ''0''+rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) 
  ELSE rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) END) in ('''+@Period+''')'


---Load danh sách Đơn hàng theo nhân viên
SET @sSQL =
	N' SELECT O01.DivisionID, CONVERT(NVARCHAR(50),O01.OrderDate,103) AS OrderDate, C01.O01ID, C01.O05ID, O01.ObjectID, C01.AccountName, O01.VoucherNo
	, CONVERT(VARCHAR(10), O01.CreateDate, 105) + '' '' + CONVERT(VARCHAR(8), O01.CreateDate, 108) AS CreateDate, O01.CreateUserID AS EmployeeID,A03.FullName AS EmployeeName
	, CONVERT(VARCHAR(10), O01.ConfirmDate, 105) + '' '' + CONVERT(VARCHAR(8), O01.ConfirmDate, 108) AS ConfirmDate, O01.OrderStatus, A99.[Description] AS OrderStatusName, O01.TranMonth, O01.TranYear, O01.SOrderID
	, O01.Varchar02, O01.Varchar03, O01.Varchar04, O01.Varchar05, O01.Varchar06, O01.Varchar07, O01.Varchar08, O01.Varchar09, O01.Varchar10, O01.Varchar11, O01.Varchar12
	, O01.Varchar13, O01.Varchar14, O01.Varchar15, O01.Varchar16, O01.Varchar17, O01.Varchar18, O01.Varchar19, O01.Varchar20 
	 FROM OT2001 O01 
	LEFT Join CRMT10101 C01 ON C01.DivisionID = O01.DivisionID AND C01.AccountID = O01.ObjectID
	LEFT JOIN AT0099 A99 ON A99.ID = O01.OrderStatus AND A99.CodeMaster=''AT00000003''
	LEFT Join AT1103 A03 ON A03.DivisionID = O01.DivisionID AND A03.EmployeeID = O01.CreateUserID
	Where 1=1 '+@sWhere+'
	Order BY  O01.DivisionID, O01.OrderDate, A03.EmployeeID
		'

EXEC (@sSQL)
--PRINT @sSQL	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

