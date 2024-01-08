IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[FP0051]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[FP0051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo theo dõi khấu hao TSCĐ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/11/2015 by Phương Thảo
---- Modified on 14/03/2016 by Phương Thảo: Bổ sung các trường ItemNo, Serial, Model
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/********************************************  
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]  
'********************************************/  
---- exec FP0051 @DivisionID=N'GS',@FromMonth=9,@FromYear=2015,@ToMonth=3,@ToYear=2016,@IsMonth=0 
  
CREATE PROCEDURE [dbo].[FP0051]    
    @DivisionID AS nvarchar(50),  
    @FromMonth as int,  
    @FromYear as int,  
    @ToMonth as int,  
    @ToYear as int,
	@IsMonth as tinyint
      
 AS  
declare   
	@FromPeriod as int,  
	@ToPeriod as int,
	@FromPeriod_Year as int,  
	@ToPeriod_Year as int,  
	@sSQL AS nvarchar(MAX),  
	@sSQL1 AS nvarchar(MAX)
	
set @FromPeriod = @FromMonth + @FromYear * 100  
set @ToPeriod = @ToMonth + @ToYear * 100  

SELECT @sSQL = '', @sSQL1 = ''
  

SELECT	AT1504.AssetID, AT1504.DivisionID, Sum(AT1504.DepAmount) as DepAmount,
		--MAX(AT1503.ObjectID) AS ObjectID, 
		Convert(NVarchar(50),'') AS ObjectID, Convert(NVarchar(250),'') AS ObjectName,
		MAX(AT1504.VoucherNo) AS VoucherNo,
		--Convert(NVarchar(50),'') AS Serial, 
		--Convert(NVarchar(50),'') AS Model, 
		--Convert(NVarchar(50),'') AS ItemNo, 
		(Case when str(@IsMonth ) = 0 Then 
			Case When  TranMOnth <10 then '0'+rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) else    
										 rtrim(ltrim(str(TranMonth)))+'/'+ltrim(Rtrim(str(TranYear))) End 
		ELSE
		Case When str(@IsMonth ) = 1 Then (select Quarter from FV9999 Where DivisionID = AT1504.DivisionID and TranMonth = AT1504.TranMonth and TranYear = AT1504.TranYear) else   
		Ltrim(Rtrim(str(TranYear))) END END ) as MonthYear,
		AT1503.AssetName, AT1503.ConvertedAmount, AT1503.DepartmentID, AT1503.DepPeriods,
		CONVERT(Decimal(28,8),0) AS AddCostAmount,
		AT1503.Serial AS ItemNo, AT1503.Parameter01 AS Serial, AT1503.Parameter02 AS Model,
		CONVERT(Decimal(28,8),0) AS DepAmount01, CONVERT(Decimal(28,8),0) AS DepAmount02, CONVERT(Decimal(28,8),0) AS DepAmount03,
		CONVERT(Decimal(28,8),0) AS DepAmount04, CONVERT(Decimal(28,8),0) AS DepAmount05, CONVERT(Decimal(28,8),0) AS DepAmount06,
		CONVERT(Decimal(28,8),0) AS DepAmount07, CONVERT(Decimal(28,8),0) AS DepAmount08, CONVERT(Decimal(28,8),0) AS DepAmount09,
		CONVERT(Decimal(28,8),0) AS DepAmount10, CONVERT(Decimal(28,8),0) AS DepAmount11, CONVERT(Decimal(28,8),0) AS DepAmount12,
		AT1503.Ana04ID1 AS ProcessID,
		AT1503.Ana01ID1, A01.AnaName AS Ana01Name, AT1503.Ana02ID1, A02.AnaName AS Ana02Name,
		AT1503.Ana03ID1, A03.AnaName AS Ana03Name, AT1503.Ana04ID1, A04.AnaName AS Ana04Name,
		AT1503.Ana05ID1, A05.AnaName AS Ana05Name
INTO #FP0051_AT1504_1
FROM AT1504 WITH (NOLOCK)
LEFT JOIN AT1503 WITH (NOLOCK) ON AT1503.AssetID = At1504.AssetID and AT1503.DivisionID = At1504.DivisionID 
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = AT1503.Ana01ID1 AND A01.AnaTypeID ='A01'
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID = AT1503.Ana02ID1 AND A02.AnaTypeID ='A02'
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaID = AT1503.Ana03ID1 AND A03.AnaTypeID ='A03'
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaID = AT1503.Ana04ID1 AND A04.AnaTypeID ='A04'
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaID = AT1503.Ana05ID1 AND A05.AnaTypeID ='A05'
WHERE AT1504.TranMonth+AT1504.TranYear*100 between str(@FromPeriod)  and str(@ToPeriod ) 
AND AT1504.DivisionID = @DivisionID 
GROUP BY AT1504.AssetID, AT1504.DivisionID, at1504.TranMonth, at1504.TranYear, 
		AT1503.AssetName, AT1503.ConvertedAmount, AT1503.DepartmentID, AT1503.DepPeriods, AT1503.Serial, AT1503.Parameter01, AT1503.Parameter02, AT1503.Ana04ID1,
		AT1503.Ana01ID1, A01.AnaName, AT1503.Ana02ID1, A02.AnaName,
		AT1503.Ana03ID1, A03.AnaName, AT1503.Ana04ID1, A04.AnaName,
		AT1503.Ana05ID1, A05.AnaName


UPDATE T1
SET		AddCostAmount = ResidualNewValue  - ResidualOldValue
FROM #FP0051_AT1504_1	T1
INNER JOIN AT1506 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID


UPDATE T1
SET		T1.ObjectID = T2.ObjectID
FROM #FP0051_AT1504_1 T1
INNER JOIN (SELECT AT1533.DivisionID, AT1533.AssetID, MAX(AT9000.ObjectID) AS ObjectID 
			FROM AT1533 WITH (NOLOCK)
			INNER JOIN AT9000 WITH (NOLOCK) ON AT1533.ReVoucherID = AT9000.VoucherID AND AT1533.ReTransactionID = AT9000.TransactionID 
											AND AT1533.DivisionID = AT9000.DivisionID
			GROUP BY AT1533.DivisionID, AT1533.AssetID )T2 
ON T1.AssetID = T2.AssetID  AND T1.DivisionID = T2.DivisionID


UPDATE T1
SET		T1.ObjectName = T2.ObjectName
FROM #FP0051_AT1504_1 T1
INNER JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T2.ObjectID


DECLARE @i Int, @si Varchar(2)
SET @i = 1
WHILE (@i<=12)
BEGIN 
	IF @i < 10 SET @si = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @si = CONVERT(VARCHAR, @i)

	SET @sSQL = '
	
	UPDATE	T1
	SET		T1.DepAmount'+@si+' = T2.DepAmount
	FROM	#FP0051_AT1504_1 T1
	INNER JOIN 
	(
	SELECT DivisionID, AssetID, DepAmount
	FROM	#FP0051_AT1504_1
	WHERE	Convert(int, LEFT(MonthYear,2)) = Convert(int,'''+@si+''')
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID

	'
	exec (@sSQL)
	Set @i = @i + 1
END

SELECT * FROM #FP0051_AT1504_1


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

