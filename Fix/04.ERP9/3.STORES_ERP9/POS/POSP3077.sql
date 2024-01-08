IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3077]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3077]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo chi tiết mua hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Trà Giang, Date: 29/06/2018
----Modify by:Trà Giang, Date: 12/17/2018: Bỏ search theo vật tư cho công nợ

-- <Example>
---- 
/*-- <Example>

  
  EXEC POSP3077 'VS', 'VS', '', 'CH03'',''CH02'',''CH01', 1, '2018-08-02', '2018-08-29', '1'','''','''
  , '0000000008', '0000000008'
  , '','' 
  , ''

----*/

CREATE PROCEDURE POSP3077 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToMemberID			VARCHAR(MAX),
	@FromMemberID		VARCHAR(MAX),
	@FromInventoryID	NVARCHAR(MAX),
	@ToInventoryID		VARCHAR(MAX),
	@UserID				VARCHAR(50)
	
	
)
AS
DECLARE @sSQL   NVARCHAR(MAX),  
		@sSQL1   NVARCHAR(MAX), 
		@sSQL2   NVARCHAR(MAX),
		@sSQL3  NVARCHAR(MAX), 
		@sSQL4  NVARCHAR(MAX), 
		@sSQL5  NVARCHAR(MAX), 
		@sSQL6  NVARCHAR(MAX), 
		@sSQL7  NVARCHAR(MAX), 
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),
		@sWhere3 NVARCHAR(MAX),
		@sWhere4 NVARCHAR(MAX),
		@sWhere5 NVARCHAR(MAX),
		@sWhere6 NVARCHAR(MAX),
		@sWhere7 NVARCHAR(MAX),
		@Date  NVARCHAR(MAX),
		@GroupDate NVARCHAR(MAX)
		
SET @GroupDate = ''
SET @Date = ''
SET @sWhere = ''
SET @sWhere1 = ''
SET @sWhere2 = ''
SET @sWhere3 = ''
SET @sWhere4 = ''
SET @sWhere5 = ''
SET @sWhere6 = ''

IF @IsDate = 1	
Begin
	SET @Date = @Date + ''''+CONVERT(VARCHAR,@FromDate,103)  +''' as FromDate,'''+CONVERT(VARCHAR,@ToDate,103)+ ''' as ToDate'
	SET @sWhere2 = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere3 =  '  CONVERT(VARCHAR,M.VoucherDate,112) < '''+CONVERT(VARCHAR,@FromDate,112)+''' '
	SET @sWhere4 = @sWhere4 + ' AND CONVERT(VARCHAR,P801.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
end
ELSE
Begin
	SET @Date = @Date + ' M.TranMonth, M.TranYear, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) as MonthYear '
	SET @sWhere2 = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	SET @sWhere3 =  '  (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	SET @sWhere4 = @sWhere4 + ' AND (Case When  P801.TranMonth <10 then ''0''+rtrim(ltrim(str(P801.TranMonth)))+''/''+ltrim(Rtrim(str(P801.TranYear))) 
									Else rtrim(ltrim(str(P801.TranMonth)))+''/''+ltrim(Rtrim(str(P801.TranYear))) End) IN ('''+@PeriodIDList+''')'
	SET @GroupDate = @GroupDate + ',M.TranMonth, M.TranYear'
End	
-- SEARCH chung
--Check Para DivisionIDList null then get DivisionID 
IF Isnull(@DivisionIDList,'') = ''
SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
Else 
SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'

--Check Para @ShopIDList null then get ShopID 
IF Isnull(@ShopIDList,'') = ''
SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
Else 
SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'
	
--Search theo khách hàng 
IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
	SET @sWhere = @sWhere + ' AND M.MemberID > = N'''+@FromMemberID +''''
ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere = @sWhere + ' AND M.MemberID < = N'''+@ToMemberID +''''
ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere = @sWhere + ' AND M.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''
  --Search theo vật tư 
IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
	SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
	SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
	SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''       

    -- search cho công nợ
--Check Para DivisionIDList null then get DivisionID 
IF Isnull(@DivisionIDList,'') = ''
SET @sWhere1 = @sWhere1 + ' P11.DivisionID IN ('''+ @DivisionID+''')'
Else 
SET @sWhere1 = @sWhere1 + '  P11.DivisionID IN ('''+@DivisionIDList+''')'

--Check Para @ShopIDList null then get ShopID 
IF Isnull(@ShopIDList,'') = ''
SET @sWhere1 = @sWhere1 + ' And P11.ShopID IN ('''+@ShopID+''')'
Else 
SET @sWhere1 = @sWhere1 + ' And P11.ShopID IN ('''+@ShopIDList+''')'
--Search theo khách hàng 
IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
	SET @sWhere1 = @sWhere1 + ' AND P11.MemberID > = N'''+@FromMemberID +''''
ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere1 = @sWhere1 + ' AND P11.MemberID < = N'''+@ToMemberID +''''
ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere1 = @sWhere1 + ' AND P11.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''
--  --Search theo vật tư 
--IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
--	SET @sWhere1 = @sWhere1 + ' AND InventoryID > = N'''+@FromInventoryID +''''
--ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
--	SET @sWhere1 = @sWhere1 + ' AND InventoryID < = N'''+@ToInventoryID +''''
--ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
--	SET @sWhere1 = @sWhere1 + ' AND InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''       
         
   -- search cho phiếu thu
--Check Para DivisionIDList null then get DivisionID 
IF Isnull(@DivisionIDList,'') = ''
SET @sWhere4 = @sWhere4 + ' and P801.DivisionID IN ('''+ @DivisionID+''')'
Else 
SET @sWhere4 = @sWhere4 + ' and P801.DivisionID IN ('''+@DivisionIDList+''')'

--Check Para @ShopIDList null then get ShopID 
IF Isnull(@ShopIDList,'') = ''
SET @sWhere4 = @sWhere4 + ' And P801.ShopID IN ('''+@ShopID+''')'
Else 
SET @sWhere4 = @sWhere4 + ' And P801.ShopID IN ('''+@ShopIDList+''')'
--Search theo khách hàng 
IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
	SET @sWhere6 = @sWhere6 + ' AND P11.MemberID > = N'''+@FromMemberID +''''
ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere6 = @sWhere6 + ' AND P11.MemberID < = N'''+@ToMemberID +''''
ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere6 = @sWhere6 + ' AND P11.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''

 	----Search khách hàng cho thu công nợ đầu kì
	--Search theo khách hàng 
IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
	SET @sWhere5 = @sWhere5 + ' AND P802.MemberID > = N'''+@FromMemberID +''''
ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere5 = @sWhere5 + ' AND P802.MemberID < = N'''+@ToMemberID +''''
ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere5 = @sWhere5 + ' AND P802.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''    
SET @sSQL1 = N'
-- Công nợ 
	SELECT DISTINCT  M.DivisionID, N''So du dau ky'' as CVoucherNo ,'''' as VoucherNo
, '''' AS InventoryID, '''' AS InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear, NULL AS VoucherDate
, '''' AS ObjectName
, P11.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice,0 AS Amount ,(ISNULL(a.amount,0) + ISNULL( P11.BeginPeriodDebt,0) - ISNULL(B.ConvertedAmount,0)) AS CASH, 
 NULL AS VoucherPrintDate,  0 AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate		
 ,'''' as  CreateDate	
from  POST0011 P11  WITH (NOLOCK) left join POST0016 M  WITH (NOLOCK) on  P11.MemberID = M.MemberID
	left join 
			(
			select MemberID, (SUM(M.TotalInventoryAmount)) as  amount from POST0016 M  
			Left join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
			WHERE '+@sWhere3+'
			group by  MemberID
			)A  on  P11.MemberID = A.MemberID
			left join 
			(
			select P802.MemberID, sum(P802.Amount) AS ConvertedAmount from  POST00802 P802 
			Left Join  POST00801 M  WITH (NOLOCK) on M.APK=P802.APKMaster 
			WHERE   '+@sWhere3+'
			group by  P802.MemberID
			)B  on  P11.MemberID = B.MemberID
			where '+@sWhere1 +'   
			union all
--bán hàng	
SELECT distinct  M.DivisionID,N''Phieu ban hang-''  +  M.VoucherNo  as CVoucherNo, M.VoucherNo  as VoucherNo
, A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName
, M.MemberID, M.MemberName,
case when IsKindVoucherID=1 then  D.ActualQuantity*(-1) else D.ActualQuantity end as ActualQuantity , D.UnitPrice,
case when IsKindVoucherID=1 then (D.ActualQuantity * D.UnitPrice) *(-1)- (D.ActualQuantity * O02.DiscountAmount) else 
  (D.ActualQuantity * D.UnitPrice) - ISNULL((D.ActualQuantity * O02.DiscountAmount),0)  end as Amount , 0 AS CASH,
 M.VoucherPrintDate,
/*Case When (M.PVoucherNo is null and M.CVoucherNo is null) then 0 else
 P802.ConvertedAmount END*/ 0 AS ConvertedAmount  ,
 D.DiscountAmount AS Promotion, M.TotalDiscountAmount AS InterestRate, 
   (D.ActualQuantity * D.UnitPrice)- (D.ActualQuantity * O02.DiscountAmount)  as DiscountAmount, M.TotalRedureAmount as DiscountRate,
   M.CreateDate		
from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
					LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
				Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
				Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				left join OT1302 O02 WITH (NOLOCK) on O02.InventoryID = A02.InventoryID
				WHERE M.DeleteFlg = 0 
				and M.PVoucherNo is null and M.CVoucherNo is null 
					and D.IsPromotion=0 '+@sWhere2+@sWhere+' 
				group by M.MemberID,IsKindVoucherID,VoucherNo,M.DivisionID,A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName,M.MemberName,D.ActualQuantity, D.UnitPrice,O02.DiscountAmount,
 M.VoucherPrintDate, P802.ConvertedAmount,	M.PVoucherNo,M.CVoucherNo	, D.DiscountAmount, D.DiscountRate	,M.TotalDiscountAmount,M.TotalInventoryAmount,M.TotalRedureAmount, M.CreateDate	
  union all'
  SET @sSQL2=N'
   --đổi hàng
SELECT distinct M.DivisionID, N''Phieu doi hang-''+ M.CVoucherNo +'' (''+ M.VoucherNo+'')'' as CVoucherNo, M.CVoucherNo as VoucherNo
, A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName
, M.MemberID, M.MemberName,
case when IsKindVoucherID=1 then  D.ActualQuantity*(-1) else D.ActualQuantity end as ActualQuantity , D.UnitPrice,
case when IsKindVoucherID=1 then (D.ActualQuantity * D.UnitPrice) *(-1) else   (D.ActualQuantity * D.UnitPrice)  end as Amount , 0 AS CASH,
 M.VoucherPrintDate,
 0 AS ConvertedAmount  ,   0 AS Promotion, 0 AS InterestRate		, D.DiscountAmount, D.DiscountRate	, M.CreateDate		
from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
					LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
				Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
				Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE M.DeleteFlg = 0 
				and M.PVoucherNo is null and M.CVoucherNo is not null    '+@sWhere2+@sWhere+' 	
				group by M.MemberID,IsKindVoucherID,VoucherNo,M.DivisionID,A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName,M.MemberName,D.ActualQuantity, D.UnitPrice,
 M.VoucherPrintDate,  P802.ConvertedAmount,	M.PVoucherNo,M.CVoucherNo	, D.DiscountAmount, D.DiscountRate, M.CreateDate		
  union all'
    SET @sSQL3=N'
  --trả hàng
SELECT  M.DivisionID,  N''Phieu tra hang-'' +  M.PVoucherNo +'' (''+ M.VoucherNo+'')'' as CVoucherNo,M.PVoucherNo as VoucherNo
, A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName
, M.MemberID, M.MemberName,
case when IsKindVoucherID=1 then  D.ActualQuantity*(-1) else D.ActualQuantity end as ActualQuantity , D.UnitPrice,
case when IsKindVoucherID=1 then (D.ActualQuantity * D.UnitPrice) *(-1) else   (D.ActualQuantity * D.UnitPrice)  end as Amount , 0 AS CASH,
 M.VoucherPrintDate, P802.ConvertedAmount  AS ConvertedAmount  , 
   0 AS Promotion, 0 AS InterestRate		, D.DiscountAmount, D.DiscountRate	, M.CreateDate		
from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
					LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
				Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
				Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE M.DeleteFlg = 0  
				and  M.PVoucherNo is not null and M.CVoucherNo is null    '+@sWhere2+@sWhere+' 
								group by M.MemberID,IsKindVoucherID,VoucherNo,M.DivisionID,A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName,M.MemberName,D.ActualQuantity, D.UnitPrice,
 M.VoucherPrintDate,  P802.ConvertedAmount,	M.PVoucherNo,M.CVoucherNo	, D.DiscountAmount, D.DiscountRate	, M.CreateDate	
 union all'
 SET @sSQL4=N'

--phiếu thu trả cho 1 phieu bán hàng
	SELECT  M.DivisionID, N''Phieu thu -'' + P801.VoucherNo  +'' (''+ M.VoucherNo+'')'' as CVoucherNo, /*P801.VoucherNo*/  M.VoucherNo as VoucherNo
, '''' AS InventoryID, N''Phieu thu -'' + P801.VoucherNo  +'' (''+ M.VoucherNo+'')''  AS InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear,P801.VoucherDate
, '''' AS ObjectName
, P11.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice, 0 AS Amount ,0 AS CASH, 
 NULL AS VoucherPrintDate,  P802.Amount AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate, P801.CreateDate		
from POST00801 P801 inner join POST00802 P802 WITH (NOLOCK) on P801.APK=P802.APKMaster
				left join POST0016 M   WITH (NOLOCK) on M.APK=P802.APKMInherited
				left  join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
				LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
			 	Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE P801.DeleteFlg = 0   and (P801.IsDeposit=0 and P801.IsPayInvoice=2)  and M.CVoucherNo is null
				'+@sWhere4+@sWhere6+'
			group by  M.DivisionID,P11.MemberID,ISNULL(P11.MemberName,M.MemberName),P11.BeginPeriodDebt,P801.VoucherNo ,
			P802.Amount,P801.VoucherDate,M.VoucherNo,P801.CreateDate,M.CVoucherNo 	

			union all
			
--phiếu thu trả cho 1 phieu đổi hàng
	SELECT  M.DivisionID, N''Phieu thu -'' + P801.VoucherNo  +'' cho phieu doi (''+ P801.VoucherNo+'')'' as CVoucherNo, /*P801.VoucherNo*/  P802.VoucherNoInherited as VoucherNo
, '''' AS InventoryID, N''Phieu thu -'' + P801.VoucherNo  +'' (''+ M.VoucherNo+'')''  AS InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear,P801.VoucherDate
, '''' AS ObjectName
, P11.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice, 0 AS Amount ,0 AS CASH, 
 NULL AS VoucherPrintDate,  P802.Amount AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate, P801.CreateDate		
from POST00801 P801 inner join POST00802 P802 WITH (NOLOCK) on P801.APK=P802.APKMaster
				left join POST0016 M   WITH (NOLOCK) on M.APK=P802.APKMInherited
				left  join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
				LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
			 	Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE P801.DeleteFlg = 0   and (P801.IsDeposit=0 and P801.IsPayInvoice=2) and  P802.VoucherNoInherited =M.CVoucherNo
				'+@sWhere4+@sWhere6+'
			group by  M.DivisionID,P11.MemberID,ISNULL(P11.MemberName,M.MemberName),P11.BeginPeriodDebt,P801.VoucherNo ,
			P802.Amount,P801.VoucherDate,M.VoucherNo,P801.CreateDate,P802.VoucherNoInherited	
'
 SET @sSQL5=N'
 
union all
--phi?u thu k? th?a nhi?u phi?u bán hàng
	SELECT  M.DivisionID,N''Phieu thu  '' + P801.VoucherNo as CVoucherNo ,P801.VoucherNo as VoucherNo
, '''' AS InventoryID, N''Phieu thu  '' +P801.VoucherNo+'' cho phieu ban (''+P802.VoucherNoInherited+'' )'' as InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear,P801.VoucherDate
, '''' AS ObjectName
, P11.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice, 0 AS Amount ,0 AS CASH, 
 NULL AS VoucherPrintDate,  P802.Amount AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate,P801.CreateDate		
from POST00801 P801 inner join POST00802 P802 WITH (NOLOCK) on P801.APK=P802.APKMaster
				left join POST0016 M   WITH (NOLOCK) on M.APK=P802.APKMInherited
				left  join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
				LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
			 	Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE P801.DeleteFlg = 0 and M.CVoucherNo is null  and ((P801.IsDeposit=0 and P801.IsPayInvoice is NULL) or (P801.IsDeposit is null and P801.IsPayInvoice is null) )  and P802.APKMInherited is not NULL
				'+@sWhere4+@sWhere6+'
			group by  M.DivisionID,P11.MemberID,ISNULL(P11.MemberName,M.MemberName),P11.BeginPeriodDebt,P801.VoucherNo ,
			P802.Amount,P801.VoucherDate,M.VoucherNo,P802.VoucherNoInherited,P801.CreateDate	


union all
--load thong tin tiền thu Công nợ dầu kì
	SELECT  P802.DivisionID,N''Phieu thu  '' + P801.VoucherNo as CVoucherNo ,P801.VoucherNo as VoucherNo
, '''' AS InventoryID,  N''Thu cong no dau ki'' + P801.VoucherNo as InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear,P801.VoucherDate
, '''' AS ObjectName
, P802.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice, 0 AS Amount ,0 AS CASH, 
 NULL AS VoucherPrintDate,  P802.Amount AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate,P801.CreateDate			
from POST00801 P801 inner join POST00802 P802 WITH (NOLOCK) on P801.APK=P802.APKMaster
				left join POST0016 M   WITH (NOLOCK) on M.APK=P802.APKMInherited
				left  join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
				LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
			 	Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE 	P801.IsDeposit=0 and P801.IsPayInvoice is NULL and
				  P802.APKMInherited is  null	
				   
			 '+@sWhere4+@sWhere5+' 
			group by  P802.DivisionID,P802.MemberID,ISNULL(P11.MemberName,M.MemberName),P11.BeginPeriodDebt,P801.VoucherNo ,
			P802.Amount,P801.VoucherDate,M.VoucherNo,P802.VoucherNoInherited,P801.CreateDate	


 '
  SET @sSQL7=N'
 union all
--phi?u thu ke thua nhieu phieu doi hang
	SELECT  M.DivisionID,N''Phieu thu  '' + P801.VoucherNo as CVoucherNo ,P801.VoucherNo as VoucherNo
, '''' AS InventoryID, N''Phieu thu  '' +P801.VoucherNo+'' cho phieu doi (''+P801.VoucherNo+'' )'' as InventoryName, '''' AS UnitID, '''' AS UnitName, ''''AS ShopName, NULL AS TranMonth, NULL AS TranYear,P801.VoucherDate
, '''' AS ObjectName
, P11.MemberID, ISNULL(P11.MemberName,M.MemberName) AS MemberName,
 0 AS ActualQuantity, 0 AS UnitPrice, 0 AS Amount ,0 AS CASH, 
 NULL AS VoucherPrintDate,  P802.Amount AS ConvertedAmount, 0 AS Promotion, 0 AS InterestRate	, 0 as DiscountAmount, 0 AS DiscountRate,P801.CreateDate		
from POST00801 P801 inner join POST00802 P802 WITH (NOLOCK) on P801.APK=P802.APKMaster
				left join POST0016 M   WITH (NOLOCK) on M.APK=P802.APKMInherited
				left  join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
				LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
			 	Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE P801.DeleteFlg = 0  and  P802.VoucherNoInherited =M.CVoucherNo
				  and ((P801.IsDeposit=0 and P801.IsPayInvoice is NULL) or (P801.IsDeposit is null and P801.IsPayInvoice is null) )  and P802.APKMInherited is not NULL
				'+@sWhere4+@sWhere6+'
			group by  M.DivisionID,P11.MemberID,ISNULL(P11.MemberName,M.MemberName),P11.BeginPeriodDebt,P801.VoucherNo ,
			P802.Amount,P801.VoucherDate,M.VoucherNo,P802.VoucherNoInherited,P801.CreateDate	
'
 SET @sSQL6=N'

union all
--khuyến mãi
SELECT  M.DivisionID,N''Phieu ban hang-'' +  M.VoucherNo  as CVoucherNo,M.VoucherNo  as VoucherNo
, A02.InventoryID, A02.InventoryName +''(Hang tang)'', A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName
, M.MemberID, M.MemberName,
 D.ActualQuantity  as ActualQuantity , D.UnitPrice,0 as Amount , 0 AS CASH,
 M.VoucherPrintDate,0 AS ConvertedAmount  ,    0 AS Promotion, 0 AS InterestRate		, D.DiscountAmount, D.DiscountRate	,P802.CreateDate		
from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
					LEFT JOIN POST0011 P11 WITH(NOLOCK) on  P11.MemberID = M.MemberID
				Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
				Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
				Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
				Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
				WHERE M.DeleteFlg = 0 
				and M.PVoucherNo is null and M.CVoucherNo is null 
				and D.IsPromotion=1 '+@sWhere2+@sWhere+' 
				group by M.MemberID,IsKindVoucherID,VoucherNo,M.DivisionID,A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherDate
, M.ObjectName,M.MemberName,D.ActualQuantity, D.UnitPrice,
 M.VoucherPrintDate,  P802.ConvertedAmount,	M.PVoucherNo,M.CVoucherNo	, D.DiscountAmount, D.DiscountRate	,P802.CreateDate	



'

SET  @sSQL= @sSQL1+ @sSQL2+ @sSQL3+ @sSQL4 + @sSQL5 + @sSQL6  + @sSQL7
EXEC (@sSQL)

print (@sSQL1)
print (@sSQL2)
print (@sSQL3)
print (@sSQL4)
print (@sSQL5)
print (@sSQL6)
print (@sSQL7)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
