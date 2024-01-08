IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0143]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0143]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Báo cáo đối chiếu số tiền công ty so với số tiền nhận giũa các cửa hàng hàng ngày
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/08/2017 by Thị Phượng  
---- Modify by 
-- <Example> EXEC WP0143 'KC', '', '', 1, 2017, 8,2017,'2014-01-01', '2017-08-30', 1 ,'PHUONG'
---- 
 
CREATE PROCEDURE [dbo].[WP0143]
(
	@DivisionID       AS NVARCHAR(50),
    @FromShopID     AS NVARCHAR(50),
    @ToShopID       AS NVARCHAR(50),
    @FromMonth        AS INT,
    @FromYear         AS INT,
    @ToMonth          AS INT,
    @ToYear           AS INT,
    @FromDate         AS DATETIME,
    @ToDate           AS DATETIME,
    @IsDate           AS TINYINT,
	@UserID			  AS NVARCHAR(50)
)
as 
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang MINH SANG khong (CustomerName = 79)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 79 --- Customize  MINH SANG
Begin
DECLARE	@sSQLSelect AS nvarchar(max) ,
				@sSQL01 AS nvarchar(max) ,
				@sWhere AS nvarchar(max) ,
				@sWhere1 AS nvarchar(max) ,
				@sWhere2 AS nvarchar(max) ,
				@sSQLUnion AS nvarchar(4000), 
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20)

IF @IsDate = 0 
Begin
	SET @sWhere = 'AND (M.TranMonth + M.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+')'
	SET @sWhere1 = 'AND (M.TranMonth + M.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+')'
End
IF @IsDate = 1 
Begin
	SET @sWhere = 'AND (CONVERT(VARCHAR, M.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' ) '
	SET @sWhere1 = 'AND (CONVERT(VARCHAR, M.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' ) '
End
--Search theo cửa hàng bên POS
IF Isnull(@FromShopID, '')!= '' and Isnull(@ToShopID, '') = ''
			SET @sWhere = @sWhere + ' AND M.ShopID > = N'''+@FromShopID +''''
ELSE IF Isnull(@FromShopID, '') = '' and Isnull(@ToShopID, '') != ''
			SET @sWhere = @sWhere + ' AND M.ShopID < = N'''+@ToShopID +''''
ELSE IF Isnull(@FromShopID, '') != '' and Isnull(@ToShopID, '') != ''
			SET @sWhere = @sWhere + ' AND M.ShopID Between N'''+@FromShopID+''' AND N'''+@ToShopID+''''

--Search theo cửa hàng bên ERP
IF Isnull(@FromShopID, '')!= '' and Isnull(@ToShopID, '') = ''
			SET @sWhere1 = @sWhere1 + ' AND M.ObjectID > = N'''+@FromShopID +''''
ELSE IF Isnull(@FromShopID, '') = '' and Isnull(@ToShopID, '') != ''
			SET @sWhere1 = @sWhere1 + ' AND M.ObjectID < = N'''+@ToShopID +''''
ELSE IF Isnull(@FromShopID, '') != '' and Isnull(@ToShopID, '') != ''
			SET @sWhere1 = @sWhere1 + ' AND  M.ObjectID Between N'''+@FromShopID+''' AND N'''+@ToShopID+''''
				
SET @sSQL01 = '
			Select A.DivisionID, A.DivisionName, A.ShopID, A.ShopName, sum(CreditAmount) as POSAmount
			Into #POS
			From
			(Select  M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName
					, Case when M.TotalInventoryAmount <= M.PaymentObjectAmount01 - M.PaymentObjectAmount02
						   Then M.TotalInventoryAmount
						   Else
						   Sum(Isnull(P8.Amount, 0)) + M.PaymentObjectAmount01 + M.PaymentObjectAmount02
						   End as CreditAmount
			from POST0016 M  WITH (NOLOCK) Left join POST00802 P8  WITH (NOLOCK) on M.APK = P8.APKMInherited and M.DeleteFlg = P8.DeleteFlg
											Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
											Left join AT1101 A01 WITH (NOLOCK) on M.DivisionID = A01.DivisionID
			Where M.DivisionID = '''+@DivisionID+''' and  M.DeleteFlg = 0 and M.CVoucherNo is null and M.PVoucherNo is null  '+@sWhere+'
			Group by M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName, M.TotalInventoryAmount, M.PaymentObjectAmount01, M.PaymentObjectAmount02
		
			)A
			Group By A.DivisionID, A.DivisionName, A.ShopID, A.ShopName

			Select M.DivisionID, M.ObjectID, isnull(sum(OriginalAmount),0) as ERPCreditAmount 
			Into #ERP
			FROM AT9000 M where  M.DivisionID = '''+@DivisionID+''' and TransactionTypeID in (''T01'',''T21'')  '+@sWhere1+'
			Group by M.DivisionID, M.ObjectID


			Select A.DivisionID, A.DivisionName, A.ShopID, A.ShopName, A.POSAmount, isnull(B.ERPCreditAmount,0) ERPAmount, (A.POSAmount - isnull(B.ERPCreditAmount,0)) as DiffAmount FROM #POS A
			Left Join #ERP B On A.DivisionID = B.DivisionID and A.ShopID = B.ObjectID
				'
--print @sSQL

		EXEC ( @sSQL01)
ENd
