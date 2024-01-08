IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3004]
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
---- Noi goi: BI\Finance\Biểu đồ  Doanh số khu vực
-- <History>
---- Create on 28/06/2016 by Phuong Thao: 
---- Modified on 28/06/2016 by Phuong Thao
---- Modified on 16/01/2016 by Hải Long: Bổ sung cộng cột chiết khấu doanh số
---- Modified by Tiểu Mai on 10/07/2017: Bổ sung công thức lấy thành tiền và điều kiện where
---- Modified by Văn Tài  on 25/04/2022: Bổ sung điều kiện lấy thông tin đơn vị.
-- <Example>
/*
 exec BP3004 @DivisionID=N'ANG',@FromMonth=01,@FromYear=2017,@ToMonth=01,@ToYear=2017,@CurrencyID=N'VND',@FromInventoryID=N'CO10KU10H1',@ToInventoryID=N'TSTW500W01',
 @Ana01ID=N'00323',@Ana02ID=null,@Ana03ID=null,@Ana04ID=null,@Ana05ID=null, @IsAll = 0,@FromInventoryTypeID='SP11', @ToInventoryTypeID='SP51'
*/

CREATE PROCEDURE BP3004
( 
	@DivisionID VARCHAR(50), 	
	@FromMonth INT, 
	@FromYear INT, 	
	@ToMonth INT, 
	@ToYear INT, 
	@CurrencyID VARCHAR(50), 	
	@FromInventoryID VARCHAR(50), 	
	@ToInventoryID VARCHAR(50), 	
	@Ana01ID VARCHAR(50),
	@Ana02ID VARCHAR(50),
	@Ana03ID VARCHAR(50),
	@Ana04ID VARCHAR(50),
	@Ana05ID VARCHAR(50),
	@IsAll TINYINT,
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50)
) 
AS
SET NOCOUNT ON


DECLARE	@sSQL1 as nvarchar(4000),
		@sSQL2 as nvarchar(4000),
		@sSQL3 as nvarchar(4000),		
		@sSQL4 as Varchar(8000),
		@sSQL5 as varchar(8000),
		@sSQL6 as Nvarchar(4000),			
		@sSQL7 as varchar(8000),
		@strwhereAnaID  nvarchar(4000)	

set  @sSQL1 = N''

SELECT *
INTO #AnaID
FROM (
	SELECT @Ana01ID AS AnaID
	WHERE ISNULL(@Ana01ID,'') <> '' 
	UNION
	SELECT @Ana02ID AS AnaID
	WHERE ISNULL(@Ana02ID,'') <> '' 
	UNION
	SELECT @Ana03ID AS AnaID
	WHERE ISNULL(@Ana03ID,'') <> '' 
	UNION
	SELECT @Ana04ID AS AnaID
	WHERE ISNULL(@Ana04ID,'') <> '' 
	UNION
	SELECT @Ana05ID AS AnaID
	WHERE ISNULL(@Ana05ID,'') <> '' 
) T

SELECT @sSQL1 = '
SELECT  DivisionID, DivisionName, TranMonth, TranYear,  LTRIM(RTRIM(TranMonth))+''/''+  LTRIM(RTRIM(TranYear)) AS Period,
		ISNULL(ASMID,'''') as ASMID, ASMName, SUM(Amount) As Amount, OrdersArea 
--INTO	#BP3004
FROM
(
	SELECT    ---- PHAT SINH CO   
			T2.DivisionID, A1.DivisionName, T2.TranMonth, T2.TranYear, T2.Ana03ID AS ASMID, T4.AnaName AS ASMName,
			(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(T1.DiscountSaleAmountDetail,0) + ISNULL(T1.DiscountSaleAmountDetail,0))
			AS Amount, T4.OrdersArea   						
	FROM	OT2002 T1 with (nolock)
	LEFT JOIN AT1101 A1 WITH (NOLOCK) ON A1.DivisionID = T1.DivisionID
	LEFT JOIN OT2001 T2 with (nolock) on T2.DivisionID = T1.DivisionID AND T1.SOrderID = T2.SOrderID	
	LEFT JOIN OT1002 T4 with (nolock) on  T2.DivisionID = T4.DivisionID AND T2.Ana03ID = T4.AnaID AND T4.AnaTypeID = ''S03''
	LEFT JOIN AT1302 A02 with (nolock) on A02.DivisionID IN (''@@@'', T1.DivisionID) AND A02.InventoryID = T1.InventoryID 
	WHERE T2.DivisionID = '''+@DivisionID+'''
			'+CASE WHEN ISNULL(@CurrencyID,'') = '' THEN '' ELSE ' AND T2.CurrencyID = '''+@CurrencyID+''' 'END +'
			AND T1.InventoryID BETWEEN  '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' 
			AND T2.TranYear*100 + T2.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100			
			AND Isnull(T1.IsProInventoryID,0) = 0	    		
			' + CASE WHEN ISNULL(@IsAll,0) <> 1 THEN 'AND EXISTS (SELECT TOP 1 1 FROM  #AnaID WHERE T2.Ana03ID LIKE #AnaID.AnaID)' ELSE '' END + '
			AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> ''''
			AND A02.InventoryTypeID BETWEEN  '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
)	T	
GROUP BY DivisionID, DivisionName, TranMonth, TranYear, ASMID, ASMName, OrdersArea
ORDER BY OrdersArea, ASMID, TranYear, TranMonth

'
PRINT (@sSQL1)
EXEC (@sSQL1)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
