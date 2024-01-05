IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3004_ANA01]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3004_ANA01]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Biểu đồ Doanh số khu vực
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Nội dung: BI\Finance\Biểu đồ  Doanh số khu vực
-- <History>
---- Created by Trọng Kiên 07/12/2020
-- <Example>
/*
 exec BP3004_Ana01 @DivisionID = 'CM', @DivisionIDList = NULL, @IsDate = 1, @FromDate = '2019-01-01', @ToDate = '2020-04-01', @PeriodIDList = NULL, @UserID = NULL
*/

CREATE PROCEDURE BP3004_Ana01
( 
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),	
	@UserID				VARCHAR(50),
	@AreaID	VARCHAR(MAX) = NULL,
	@ObjectID	VARCHAR(MAX) = NULL,
	@EmployeeID	VARCHAR(MAX) = NULL
) 
AS
SET NOCOUNT ON


DECLARE	@sSQL1 as nvarchar(4000),
		@sSQLWhere NVARCHAR(MAX) = N' '

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sSQLWhere = @sSQLWhere + 'AND T2.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sSQLWhere = @sSQLWhere + 'AND T2.DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sSQLWhere = @sSQLWhere + ' AND CONVERT(VARCHAR,T2.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sSQLWhere = @sSQLWhere+' AND (CASE WHEN  MONTH(T2.OrderDate) <10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(T2.OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(T2.OrderDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(T2.OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(T2.OrderDate)))) END) IN ('''+@PeriodIDList+''')'

    --Search theo điều điện khu vực
	IF ISNULL(@AreaID, '') != ''
	    SET @sSQLWhere = @sSQLWhere + ' AND T3.O01ID IN ('''+@AreaID+''')'

	--Search theo điều điện khách hàng
	IF ISNULL(@ObjectID, '') != ''
	    SET @sSQLWhere = @sSQLWhere + ' AND T2.ObjectID IN ('''+@ObjectID+''')'

	--Search theo điều điện nhân viên
	IF ISNULL(@EmployeeID, '') != ''
	    SET @sSQLWhere = @sSQLWhere + ' AND T2.SalesManID IN ('''+@EmployeeID+''')'

SELECT @sSQL1 = '
SELECT  DivisionID,DivisionName, TranMonth, TranYear,  LTRIM(RTRIM(TranMonth))+''/''+  LTRIM(RTRIM(TranYear)) AS Period,
		ISNULL(ASMID,'''') as ASMID, ASMName, SUM(Amount) As Amount --, OrdersArea 
--INTO	#BP3004_Ana01
FROM
(
	SELECT    ---- PHAT SINH CO   
			T2.DivisionID,T6.DivisionName,T2.TranMonth, T2.TranYear, T5.AnaID AS ASMID, T5.AnaName AS ASMName,
			(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(T1.DiscountSaleAmountDetail,0) + ISNULL(T1.DiscountSaleAmountDetail,0))
			AS Amount --,T4.OrdersArea		
	FROM	OT2002 T1 with (nolock)	
	LEFT JOIN OT2001 T2 with (nolock) on T2.DivisionID = T1.DivisionID AND T1.SOrderID = T2.SOrderID
	LEFT JOIN AT1202 T3 with (nolock) on T2.ObjectID = T3.ObjectID
	LEFT JOIN AT1015 T5 with (nolock) on T3.O01ID = T5.AnaID AND T5.AnaTypeID = ''O01''	AND T2.DivisionID in (T5.DivisionID,''@@@'')
	LEFT JOIN AT1101 T6 with (nolock) on T2.DivisionID = T6.DivisionID
	--LEFT JOIN OT1002 T4 with (nolock) on  T2.DivisionID = T4.DivisionID AND T2.Ana03ID = T4.AnaID AND T4.AnaTypeID = ''S03''	
	WHERE 1=1 ' + @sSQLWhere + '							
			AND Isnull(T1.IsProInventoryID,0) = 0
			--AND ISNULL(T2.ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(T2.ClassifyID,'''') <> ''''
) T
GROUP BY DivisionID,DivisionName,TranMonth, TranYear, ASMID, ASMName --, OrdersArea
HAVING SUM(Amount) > 0
ORDER BY ASMID, TranYear, TranMonth'
PRINT (@sSQL1)
EXEC (@sSQL1)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
