IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1598_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1598_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo tình hình tăng giảm TSCĐ (Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> ASOFT-FA/Báo cáo/TSCĐ
---- Tình hình tăng giảm TSCĐ - FF0026
-- <History>
---- Create on 24/03/2016 by Phương Thảo
---- Modify on 28/03/2016 by  Phương Thảo: Bổ sung mã PT và chỉnh sửa cách trả dữ liệu hao mòn lũy kế
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 28/03/2016 by  Phương Thảo: Chỉnh sửa trong TH trong kỳ khấu hao nhiều lần
---- Modified on 19/12/2016 by  Phương Thảo: Sửa số đầu kỳ
---- Modified on 09/02/2017 by  Phương Thảo: Sửa số đầu kỳ: Trừ bớt trong TH năm trước đã thanh lý
---- Modified on 25/05/2017 by  Phương Thảo: Chỉnh sửa đối tượng cho những TS khai báo số dư (ko kế thừa từ kế toán)
---- Modified on 14/07/2017 by  Phương Thảo: Sửa dữ liệu Tăng trong kỳ (trường hợp in trong thời gian hình thành TSCĐ)
---- Modified on 12/09/2017 by  Phương Thảo: Bổ sung dữ liệu hao mon (tăng trong kỳ)
---- Modified on 02/04/2019 by  Kim Thư: Sửa cột tăng trong kỳ lấy nguyên giá mới nhất tính đến kỳ đang in
---- Modified on 07/05/2019 by Kim Thư: Sửa lấy số liệu tăng trong kỳ chia trường hợp TS hình thành trong năm hoặc khác năm
---- Modified on 11/06/2019 by  Kim Thư: Sửa tính độ chênh lệch thay đổi nguyên giá = nguyên giá mới - nguyên giá cũ
---- Modified on 11/19/2019 by  Văn Minh: Bổ sung trường Serial - SerialNO - AssetStatus
---- Modified on 10/14/2021 by  Nhật Thanh: Cập nhật điều kiện where ở nguyên giá khi hình thành tài sản
---- Modified on 10/01/2023 by  Thanh Lượng:[2023/01/IS/0057] - Chỉnh sửa lấy nguyên giá của kỳ lớn nhất ở bảng danh mục tscd đánh giá lại để tính đúng khấu hao(Tăng trong kỳ)
-- <Example>
---- exec AP1598 @DivisionID=N'MK',@TranMonthFrom=1,@TranYearFrom=2016,@TranMonthTo=1,@TranYearTo=2016,@ReportCode=N'FA_TG_TSCD'
  
CREATE PROCEDURE [dbo].[AP1598_MK]
    @DivisionID NVARCHAR(50), 
    @TranMonthFrom INT, 
    @TranYearFrom INT, 
    @TranMonthTo INT, 
    @TranYearTo INT, 
    @ReportCode NVARCHAR(50)
      
 AS  
declare   
	@FromPeriod as int,  
	@ToPeriod as int,
	@FromPeriod_Year as int,  
	@ToPeriod_Year as int,  
	@sSQL AS nvarchar(MAX),  
	@sSQL1 AS nvarchar(MAX),
	@Decimals AS int,
	@AssetStatus0 NVARCHAR(50) = N'Đang sử dụng',
    @AssetStatus1 NVARCHAR(50) = N'Ngưng khấu hao',
    @AssetStatus2 NVARCHAR(50) = N'Nhựng bán',
    @AssetStatus3 NVARCHAR(50) = N'Đã thanh lý',
    @AssetStatus4 NVARCHAR(50) = N'Chưa sử dụng',
    @AssetStatus5 NVARCHAR(50) = N'Khác'
	
set @FromPeriod = @TranMonthFrom + @TranYearFrom * 100  
set @ToPeriod = @TranMonthTo + @TranYearTo * 100  

SELECT @Decimals = ConvertedDecimals
FROM AT1101
WHERE DivisionID = @DivisionID

SELECT @sSQL = '', @sSQL1 = ''
  
SELECT	
		T1.AssetID, T1.AssetName, T1.DivisionID,
		Convert(NVarchar(50),'') AS ObjectID, Convert(NVarchar(250),T1.InvoiceNo) AS ObjectName,
		T1.AssetGroupID, T2.AssetGroupName,
		T1.AssetAccountID, T1.DepAccountID, T1.DepartmentID,
		T1.DepPeriods,
		T1.BeginMonth, T1.BeginYear, 
		ltrim(Rtrim(str(BeginMonth))) + '/' +  Ltrim(Rtrim(str(BeginYear)))  as BeginPeriod,
		--- Dau ky
		Convert(Decimal(28,8),0) AS OpeningAmount, 
		Convert(Decimal(28,8),0) AS OpeningAccuDepAmount, 
		Convert(Decimal(28,8),0) AS OpeningRemainAmount, 
		--- Phat sinh tăng
		Convert(Decimal(28,8),0) AS InCreaseAmount, 
		Convert(Decimal(28,8),0) AS InCreaseDepAmount, 		
		--- Phat sinh giảm
		Convert(Decimal(28,8),0) AS DecreaseAmount, 
		Convert(Decimal(28,8),0) AS DecreaseDepAmount, 
		--- Cuoi ky
		Convert(Decimal(28,8),0) AS ClosingAmount, 
		Convert(Decimal(28,8),0) AS ClosingAccuDepAmount, 
		Convert(Decimal(28,8),0) AS ClosingRemainAmount, 
		CONVERT(Decimal(28,8),0) AS DepAmount01, CONVERT(Decimal(28,8),0) AS DepAmount02, CONVERT(Decimal(28,8),0) AS DepAmount03,
		CONVERT(Decimal(28,8),0) AS DepAmount04, CONVERT(Decimal(28,8),0) AS DepAmount05, CONVERT(Decimal(28,8),0) AS DepAmount06,
		CONVERT(Decimal(28,8),0) AS DepAmount07, CONVERT(Decimal(28,8),0) AS DepAmount08, CONVERT(Decimal(28,8),0) AS DepAmount09,
		CONVERT(Decimal(28,8),0) AS DepAmount10, CONVERT(Decimal(28,8),0) AS DepAmount11, CONVERT(Decimal(28,8),0) AS DepAmount12,
		[Parameter01], [Parameter02], [Parameter03], [Parameter04], [Parameter05], [Parameter06], [Parameter07], [Parameter08], [Parameter09], [Parameter10],
		[Parameter11], [Parameter12], [Parameter13], [Parameter14], [Parameter15], [Parameter16], [Parameter17], [Parameter18], [Parameter19],[Parameter20],
		T1.Ana01ID1, A01.AnaName AS Ana01Name, T1.Ana02ID1, A02.AnaName AS Ana02Name,
		T1.Ana03ID1, A03.AnaName AS Ana03Name, T1.Ana04ID1, A04.AnaName AS Ana04Name,
		T1.Ana05ID1, A05.AnaName AS Ana05Name, T1.EstablishDate,
		T1.Serial, T1.SerialNo,         
		(CASE WHEN T1.AssetStatus = 0 THEN @AssetStatus0
             ELSE CASE WHEN T1.AssetStatus = 1 THEN @AssetStatus1
             ELSE CASE WHEN T1.AssetStatus = 2 THEN @AssetStatus2
             ELSE CASE WHEN T1.AssetStatus = 3 THEN @AssetStatus3
             ELSE CASE WHEN T1.AssetStatus = 4 THEN @AssetStatus4
             ELSE @AssetStatus5
         END END END END END) AS AssetStatusName
INTO #AP1598_MK
FROM AT1503 T1 WITH (NOLOCK)
LEFT JOIN AT1501 T2 WITH (NOLOCK) ON T1.AssetGroupID = T2.AssetGroupID AND T1.DivisionID = T2.DivisionID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.DivisionID = T1.DivisionID AND A01.AnaID = T1.Ana01ID1 AND A01.AnaTypeID ='A01'
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.DivisionID = T1.DivisionID AND A02.AnaID = T1.Ana02ID1 AND A02.AnaTypeID ='A02'
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.DivisionID = T1.DivisionID AND A03.AnaID = T1.Ana03ID1 AND A03.AnaTypeID ='A03'
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.DivisionID = T1.DivisionID AND A04.AnaID = T1.Ana04ID1 AND A04.AnaTypeID ='A04'
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.DivisionID = T1.DivisionID AND A05.AnaID = T1.Ana05ID1 AND A05.AnaTypeID ='A05'
WHERE Month(T1.EstablishDate)+Year(T1.EstablishDate)*100 <= @ToPeriod  
AND T1.DivisionID = @DivisionID 

--UPDATE T1
--SET		AddCostAmount = ResidualNewValue  - ResidualOldValue
--FROM #FP0051_AT1504_1	T1
--INNER JOIN AT1506 T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID



UPDATE T1
SET		T1.ObjectID = T2.ObjectID
FROM  #AP1598_MK T1
INNER JOIN (SELECT AT1533.DivisionID, AT1533.AssetID, MAX(AT9000.ObjectID) AS ObjectID 
			FROM AT1533 WITH (NOLOCK)
			INNER JOIN AT9000 WITH (NOLOCK) ON AT1533.ReVoucherID = AT9000.VoucherID AND AT1533.ReTransactionID = AT9000.TransactionID 
											AND AT1533.DivisionID = AT9000.DivisionID
			GROUP BY AT1533.DivisionID, AT1533.AssetID )T2 
ON T1.AssetID = T2.AssetID  AND T1.DivisionID = T2.DivisionID
WHERE Isnull(T1.ObjectName,'') = ''

UPDATE T1
SET		T1.ObjectName = T2.ObjectName
FROM #AP1598_MK T1
INNER JOIN AT1202 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ObjectID = T2.ObjectID
WHERE Isnull(T1.ObjectName,'') = ''
---- Cap nhat so dau ky

--SELECT	AssetID, DivisionID, ConvertedAmount
--FROM	AT1503
--WHERE	Month(EstablishDate)+Year(EstablishDate)*100 < @FromPeriod   and AssetID = '03-0300-160600001'

--SELECT	AT1506.AssetID, AT1506.DivisionID, SUM(AT1590.ConvertedAmount) AS ConvertedAmount
--FROM	AT1506
--INNER JOIN AT1590 ON AT1506.DivisionID = AT1590.DivisionID AND AT1506.RevaluateID = AT1590.VoucherID
--WHERE	AT1590.TranMonth+AT1590.TranYear*100 < @TranYearFrom - 1   and AssetID = '03-0300-160600001'
--GROUP BY AT1506.AssetID, AT1506.DivisionID

UPDATE T1
SET		T1.OpeningAmount = CASE WHEN YEAR(T1.EstablishDate) = @TranYearFrom THEN 0
							ELSE
							CASE WHEN ISNULL(T3.ConvertedAmount,0) <> 0 THEN ISNULL(T3.ConvertedAmount,0)-ISNULL(T5.ConvertedAmount,0) 
							ELSE
							CASE WHEN ISNULL(T4.ConvertedAmount,0) <> 0 THEN ISNULL(T4.ConvertedAmount,0)-ISNULL(T5.ConvertedAmount,0) 
							ELSE
							ISNULL(T2.ConvertedAmount,0) -ISNULL(T5.ConvertedAmount,0) END END END
FROM #AP1598_MK T1
LEFT JOIN 
--- T2: danh muc TSCD hinh thanh truoc nam in
(
SELECT	AssetID, DivisionID, ConvertedAmount
FROM	AT1503 WITH (NOLOCK)
WHERE	Month(EstablishDate)+Year(EstablishDate)*100 < @FromPeriod  
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
-- T3: Nghiep vu thay doi nguyen gia truoc nam in (lay du lieu sau cung)
LEFT JOIN 
(
	SELECT T1.AssetID, T1.DivisionID,T1.ConvertedNewAmount AS ConvertedAmount
	FROM AT1506 T1
	INNER JOIN 
	(
	SELECT	AT1506.AssetID, AT1506.DivisionID, MAX(TranYear*100+TranMonth) AS MaxPeriod
	FROM	AT1506 WITH (NOLOCK)
	inner join AT1503 with(nolock) on AT1503.AssetID = AT1506.AssetID AND AT1503.DivisionID = AT1506.DivisionID
	WHERE	TranYear <= @TranYearFrom - 1
	GROUP BY AT1506.AssetID, AT1506.DivisionID) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID AND T1.TranYear*100+T1.TranMonth = T2.MaxPeriod
) T3 ON T1.DivisionID = T3.DivisionID AND T1.AssetID = T3.AssetID
-- T4: Nghiep vu thay doi nguyen gia tu nam in tro ve sau (lay du lieu dau tien)
LEFT JOIN 
(
	SELECT T1.AssetID, T1.DivisionID,T1.ConvertedOldAmount AS ConvertedAmount
	FROM AT1506 T1
	INNER JOIN 
	(
	SELECT	AT1506.AssetID, AT1506.DivisionID, MIN(TranYear*100+TranMonth) AS MinPeriod
	FROM	AT1506 WITH (NOLOCK)
	inner join AT1503 with(nolock) on AT1503.AssetID = AT1506.AssetID AND AT1503.DivisionID = AT1506.DivisionID
	WHERE	TranYear >= @TranYearFrom 	
	GROUP BY AT1506.AssetID, AT1506.DivisionID
	
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID AND T1.TranYear*100+T1.TranMonth = T2.MinPeriod
) T4 ON T1.DivisionID = T4.DivisionID AND T1.AssetID = T4.AssetID
-- T5: Nghiep vu Thanh ly truoc nam in
LEFT JOIN 
(
SELECT	AssetID, DivisionID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(AccuDepAmount) AS AccuDepAmount
FROM	AT1523 WITH (NOLOCK)
WHERE	--ReduceMonth+ReduceYear*100 between @FromPeriod  and @ToPeriod
AT1523.ReduceYear <= @TranYearFrom - 1
GROUP BY AssetID, DivisionID
) T5 ON T1.DivisionID = T5.DivisionID AND T1.AssetID = T5.AssetID

UPDATE T1
SET		T1.OpeningAccuDepAmount = ISNULL(T2.DepAmount,0) + ISNULL(T3.DepAmount,0) - ISNULL(T4.AccuDepAmount,0)
--SET		T1.OpeningAccuDepAmount = ISNULL(T3.DepAmount,0)
FROM #AP1598_MK T1
LEFT JOIN 
(
SELECT	AssetID, DivisionID, SUM(DepAmount) AS DepAmount
FROM	AT1504 WITH (NOLOCK)
WHERE	--TranMonth+TranYear*100 < @FromPeriod 
		AT1504.TranYear <= @TranYearFrom - 1
GROUP BY AssetID, DivisionID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
LEFT JOIN -- tanphu add left join
(

 SELECT	AT1503.DivisionID, AT1503.AssetID, Round(CASE WHEN Isnull(AT1506.ConvertedAmount,0) = 0 THEN AT1503.ConvertedAmount ELSE AT1506.ConvertedAmount END - AT1503.ResidualValue,@Decimals) AS DepAmount
 FROM AT1503 WITH (NOLOCK)
 LEFT JOIN 
	(
		SELECT T1.AssetID, T1.DivisionID,T1.ConvertedOldAmount AS ConvertedAmount
		FROM AT1506 T1
		INNER JOIN 
		(
		SELECT	AT1506.AssetID, AT1506.DivisionID, MIN(TranYear*100+TranMonth) AS MinPeriod
		FROM	AT1506 WITH (NOLOCK)
		inner join AT1503 with(nolock) on AT1503.AssetID = AT1506.AssetID AND AT1503.DivisionID = AT1506.DivisionID		
		GROUP BY AT1506.AssetID, AT1506.DivisionID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID AND T1.TranYear*100+T1.TranMonth = T2.MinPeriod
	) AT1506 ON AT1503.DivisionID = AT1506.DivisionID AND AT1503.AssetID = AT1506.AssetID
  WHERE	Month(AT1503.EstablishDate)+Year(AT1503.EstablishDate)*100 < @FromPeriod  
) T3 ON T1.DivisionID = T3.DivisionID AND T1.AssetID = T3.AssetID
LEFT JOIN 
(
SELECT	AssetID, DivisionID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(AccuDepAmount) AS AccuDepAmount
FROM	AT1523 WITH (NOLOCK)
WHERE	--ReduceMonth+ReduceYear*100 between @FromPeriod  and @ToPeriod
AT1523.ReduceYear <= @TranYearFrom - 1
GROUP BY AssetID, DivisionID
) T4 ON T1.DivisionID = T4.DivisionID AND T1.AssetID = T4.AssetID

UPDATE T1
SET		T1.OpeningRemainAmount = T1.OpeningAmount - T1.OpeningAccuDepAmount
FROM #AP1598_MK T1

UPDATE T1
SET		T1.InCreaseAmount = CASE WHEN YEAR(T1.EstablishDate) = @TranYearFrom 
								THEN CASE WHEN ISNULL(T4.ConvertedAmount,0) = 0 THEN ISNULL(T2.ConvertedAmount,0)  
										ELSE ISNULL(T4.ConvertedAmount,0) + ISNULL(T3.ConvertedAmount,0) END
							ELSE ISNULL(T3_1.ConvertedAmount,0) END
FROM #AP1598_MK T1
LEFT JOIN -- Nguyên giá khi hình thành tài sản
(
SELECT	AssetID, DivisionID,ConvertedAmount
FROM	AT1503 WITH (NOLOCK)
WHERE	Month(EstablishDate)+Year(EstablishDate)*100 between @FromPeriod  and @ToPeriod
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
LEFT JOIN -- Tổng độ chênh lệch khi thay đổi nguyên giá từ kỳ đang in trở về trước 
(
SELECT	AT1506.AssetID, AT1506.DivisionID, SUM(AT1506.ConvertedNewAmount)-SUM(AT1506.ConvertedOldAmount) AS ConvertedAmount--, SUM(AT1590.ConvertedAmount) AS ConvertedAmount
FROM	AT1506 WITH (NOLOCK)
--INNER JOIN AT1590 WITH (NOLOCK) ON AT1506.DivisionID = AT1590.DivisionID AND AT1506.RevaluateID = AT1590.VoucherID
--WHERE	AT1590.TranMonth+AT1590.TranYear*100 <= @ToPeriod
WHERE	AT1506.TranMonth+AT1506.TranYear*100 <= @ToPeriod
GROUP BY AT1506.AssetID, AT1506.DivisionID
) T3 ON T1.DivisionID = T3.DivisionID AND T1.AssetID = T3.AssetID
LEFT JOIN --Tổng độ chênh lệch khi thay đổi nguyên giá từ đầu năm đang in -> kỳ đang in
(
SELECT	AT1506.AssetID, AT1506.DivisionID, SUM(AT1506.ConvertedNewAmount)-SUM(AT1506.ConvertedOldAmount) AS ConvertedAmount--, SUM(AT1590.ConvertedAmount) AS ConvertedAmount
FROM	AT1506 WITH (NOLOCK)
--INNER JOIN AT1590 WITH (NOLOCK) ON AT1506.DivisionID = AT1590.DivisionID AND AT1506.RevaluateID = AT1590.VoucherID
--WHERE	AT1590.TranMonth+AT1590.TranYear*100 between @TranYearFrom*100+1 and @ToPeriod
WHERE	AT1506.TranMonth+AT1506.TranYear*100 between @TranYearFrom*100+1 and @ToPeriod
GROUP BY AT1506.AssetID, AT1506.DivisionID
) T3_1 ON T1.DivisionID = T3_1.DivisionID AND T1.AssetID = T3_1.AssetID
---- Lay nguyen gia goc
LEFT JOIN 
(
	SELECT T1.AssetID, T1.DivisionID,T1.ConvertedOldAmount AS ConvertedAmount
	FROM AT1506 T1
	INNER JOIN 
	(
	SELECT	AT1506.AssetID, AT1506.DivisionID, Min(TranYear*100+TranMonth) AS MinPeriod
	FROM	AT1506 WITH (NOLOCK)
	--inner join AT1503 with(nolock) on AT1503.AssetID = AT1506.AssetID AND AT1503.DivisionID = AT1506.DivisionID
	WHERE	
	--AT1506.TranMonth+AT1506.TranYear*100 between @FromPeriod and @ToPeriod 
	--AND Month(EstablishDate)+Year(EstablishDate)*100 between @FromPeriod  and @ToPeriod 
	AT1506.TranYear >= @TranYearFrom
	GROUP BY AT1506.AssetID, AT1506.DivisionID
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID AND T1.TranYear*100+T1.TranMonth = T2.MinPeriod
) T4 ON T1.DivisionID = T4.DivisionID AND T1.AssetID = T4.AssetID



UPDATE T1
SET		T1.InCreaseDepAmount = T2.DepAmount
FROM #AP1598_MK T1
LEFT JOIN -- tanphu add left join
(

 SELECT	AT1503.DivisionID, AT1503.AssetID, Round(CASE WHEN Isnull(AT1506.ConvertedAmount,0) = 0 THEN AT1503.ConvertedAmount ELSE AT1506.ConvertedAmount END - AT1503.ResidualValue,@Decimals) AS DepAmount
 FROM AT1503 WITH (NOLOCK)
 LEFT JOIN 
	(
		SELECT T1.AssetID, T1.DivisionID,T1.ConvertedOldAmount AS ConvertedAmount
		FROM AT1506 T1
		INNER JOIN 
		(
		SELECT	AT1506.AssetID, AT1506.DivisionID, Max(TranYear*100+TranMonth) AS MaxPeriod
		--SELECT	AT1506.AssetID, AT1506.DivisionID, MIN(TranYear*100+TranMonth) AS MinPeriod
		FROM	AT1506 WITH (NOLOCK)
		inner join AT1503 with(nolock) on AT1503.AssetID = AT1506.AssetID AND AT1503.DivisionID = AT1506.DivisionID		
		GROUP BY AT1506.AssetID, AT1506.DivisionID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID AND T1.TranYear*100+T1.TranMonth = T2.MaxPeriod
	) AT1506 ON AT1503.DivisionID = AT1506.DivisionID AND AT1503.AssetID = AT1506.AssetID
  WHERE	Month(AT1503.EstablishDate)+Year(AT1503.EstablishDate)*100 between @FromPeriod and @ToPeriod
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
WHERE YEAR(T1.EstablishDate) = @TranYearFrom 



---- Cap nhat phat sinh giảm trong kỳ
UPDATE T1
SET		T1.DeCreaseAmount = ISNULL(T2.ConvertedAmount,0),
		T1.DecreaseDepAmount = ISNULL(T2.AccuDepAmount,0)
FROM #AP1598_MK T1
LEFT JOIN 
(
SELECT	AssetID, DivisionID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(AccuDepAmount) AS AccuDepAmount
FROM	AT1523 WITH (NOLOCK)
WHERE	ReduceMonth+ReduceYear*100 between @FromPeriod  and @ToPeriod
GROUP BY AssetID, DivisionID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID



---- Cap nhat so cuoi ky
UPDATE T1
SET		T1.ClosingAmount = ISNULL(T2.ConvertedAmount,0) +  ISNULL(T3.ConvertedAmount,0)
FROM #AP1598_MK T1
LEFT JOIN 
(
SELECT	AssetID, DivisionID, ConvertedAmount
FROM	AT1503 WITH (NOLOCK)
WHERE	Month(EstablishDate)+Year(EstablishDate)*100 <= str(@FromPeriod ) 
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
LEFT JOIN 
(
SELECT	AT1506.AssetID, AT1506.DivisionID, SUM(AT1506.ConvertedNewAmount)-SUM(AT1506.ConvertedOldAmount) AS ConvertedAmount--, SUM(AT1590.ConvertedAmount) AS ConvertedAmount
FROM	AT1506 WITH (NOLOCK)
--INNER JOIN AT1590 WITH (NOLOCK) ON AT1506.DivisionID = AT1590.DivisionID AND AT1506.RevaluateID = AT1590.VoucherID
--WHERE	AT1590.TranMonth+AT1590.TranYear*100 <= str(@FromPeriod ) 
WHERE	AT1506.TranMonth+AT1506.TranYear*100 <= str(@FromPeriod ) 
GROUP BY  AT1506.AssetID,  AT1506.DivisionID
) T3 ON T1.DivisionID = T3.DivisionID AND T1.AssetID = T3.AssetID


UPDATE T1
SET		T1.ClosingAccuDepAmount = ISNULL(T2.DepAmount,0) + ISNULL(T3.DepAmount,0) 
FROM #AP1598_MK T1
LEFT JOIN 
(
SELECT	AssetID, DivisionID, SUM(DepAmount) AS DepAmount
FROM	AT1504 WITH (NOLOCK)
WHERE	TranMonth+TranYear*100 <= @FromPeriod 
GROUP BY AssetID, DivisionID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID
LEFT JOIN -- tanphu add left join
(
SELECT	AssetID, DivisionID, ConvertedAmount - ResidualValue as DepAmount
FROM	AT1503 WITH (NOLOCK)
WHERE	Month(EstablishDate)+Year(EstablishDate)*100 <= @FromPeriod  
) T3 ON T1.DivisionID = T3.DivisionID AND T1.AssetID = T3.AssetID


UPDATE T1
SET		T1.ClosingRemainAmount = T1.ClosingAmount - T1.ClosingAccuDepAmount
-- tanphu fix so du cuoi
--SET		T1.ClosingRemainAmount = T1.OpeningRemainAmount - T1.ClosingAccuDepAmount
--SET		T1.ClosingRemainAmount = T1.ClosingAmount - T1.OpeningAccuDepAmount - T1.ClosingAccuDepAmount
FROM #AP1598_MK T1

DECLARE @i Int, @si Varchar(2)
SET @i = 1
WHILE (@i<=12)
BEGIN 
	IF @i < 10 SET @si = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @si = CONVERT(VARCHAR, @i)

	SET @sSQL = '
	
	UPDATE	T1
	SET		T1.DepAmount'+@si+' = T2.DepAmount
	FROM	 #AP1598_MK T1
	INNER JOIN 
	(
	SELECT DivisionID, AssetID, SUM(DepAmount) AS DepAmount
	FROM	 AT1504 WITH (NOLOCK)
	WHERE	TranMonth = '+STR(@i)+' and TranYear = '+STR(@TranYearFrom)+'
	GROUP BY DivisionID, AssetID
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.AssetID = T2.AssetID

	'
	--print @sSQL
	exec (@sSQL)
	Set @i = @i + 1
END

SELECT * FROM  #AP1598_MK 


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO