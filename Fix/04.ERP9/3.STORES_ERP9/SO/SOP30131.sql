IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo so sánh số lượng bán hàng - SOF3013
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 19/08/2020 by Kiều Nga
---- Modify ON 04/01/2020 by Kiều Nga : [2020/12/IS/0578] in báo cáo so sanh so lượng bán theo tháng , lọc nhiều lần lỗi exeption
---- Modify ON 12/10/2022 by Tấn Lộc :  Bổ sung sử dụng CASE WHEN cho  OT2001.TranMonth và T3.TranMonth trường hợp tháng < 10 thì cộng thêm số 0 ở trước để ORDER By đúng tháng tăng dần
---- Modify on 27/12/2022 by Anh Đô : Fix lỗi không có dữ liệu khi chọn "Tất cả" ở trường Sản phẩm
-- <Example> EXEC SOP30131 'MT','MT',6,7,2020,2020

CREATE PROCEDURE [dbo].[SOP30131] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@FromMonth			INT, 
				@ToMonth			INT, 
				@FromYear		    INT,
				@ToYear				INT,
				@ListInventoryID	XML = '<D></D>'
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max)='',
			@sSQL1 NVARCHAR(max)='',
			@sWhere NVARCHAR(max)='',
	        @cols  AS NVARCHAR(MAX)='',
	        @cols1  AS NVARCHAR(MAX)='',
	        @query AS NVARCHAR(MAX)='',
			@query1 AS NVARCHAR(MAX)='',
			@sSelect AS NVARCHAR(MAX)='',
			@sJoin AS NVARCHAR(MAX)='',
			@sJoin1 AS NVARCHAR(MAX)='',
			@sWherePeriod NVARCHAR(max)=''

	-- Load dữ liệu từ xml params:
	--- Mặt hàng
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[tmpInventoryID]') AND TYPE IN (N'U'))
						DROP TABLE tmpInventoryID
	CREATE TABLE tmpInventoryID
	(
			InventoryID varchar(50)
	)
	INSERT INTO	tmpInventoryID		
	SELECT	X.D.value('.', 'VARCHAR(50)') AS InventoryID
	FROM	@ListInventoryID.nodes('//D') AS X (D)

	-- Where
	IF ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') = '' AND ISNULL(@ToYear,'') = ''
	BEGIN
		SET @sWherePeriod = @sWherePeriod + N'
			AND T3.TranMonth + T3.TranYear * 100 >= ' + STR(@FromMonth + @FromYear * 100)+ ''
	END
    ELSE IF ISNULL(@FromMonth,'') = '' AND ISNULL(@FromYear,'') = '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
	BEGIN
		SET @sWherePeriod = @sWherePeriod + N'
			AND T3.TranMonth + T3.TranYear * 100 <= ' + STR(@ToMonth + @ToYear * 100) + ''
	END
	ELSE
	BEGIN
	    SET @sWherePeriod = @sWherePeriod + N'
			AND T3.TranMonth + T3.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
	END

	IF (select count(InventoryID) from tmpInventoryID where ISNULL(InventoryID,'%') NOT IN ('%', '')) > 0
	SET @sWhere = @sWhere + '
	 AND T1.InventoryID IN (select InventoryID from tmpInventoryID)'

	 -- Select
	SET @sSelect =',ISNULL(O99.S01ID,'''') as S01ID,ISNULL(O99.S02ID,'''') as S02ID,ISNULL(O99.S03ID,'''') as S03ID,ISNULL(O99.S04ID,'''') as S04ID,ISNULL(O99.S05ID,'''') as S05ID,ISNULL(O99.S06ID,'''') as S06ID,ISNULL(O99.S07ID,'''') as S07ID,ISNULL(O99.S08ID,'''') as S08ID,ISNULL(O99.S09ID,'''') as S09ID 
	,ISNULL(O99.S10ID,'''') as S10ID,ISNULL(O99.S11ID,'''') as S11ID,ISNULL(O99.S12ID,'''') as S12ID,ISNULL(O99.S13ID,'''') as S13ID,ISNULL(O99.S14ID,'''') as S14ID,ISNULL(O99.S15ID,'''') as S15ID,ISNULL(O99.S16ID,'''') as S16ID,ISNULL(O99.S17ID,'''') as S17ID,ISNULL(O99.S18ID,'''') as S18ID,ISNULL(O99.S19ID,'''') as S19ID,ISNULL(O99.S20ID,'''') as S20ID'

	 -- Join
	SET @sJoin =' AND ISNULL(O99.S01ID,'''') = ISNULL(P.S01ID,'''') AND ISNULL(O99.S02ID,'''') = ISNULL(P.S02ID,'''') AND ISNULL(O99.S03ID,'''') = ISNULL(P.S03ID,'''') AND ISNULL(O99.S04ID,'''') = ISNULL(P.S04ID,'''') AND ISNULL(O99.S05ID,'''') = ISNULL(P.S05ID,'''') AND ISNULL(O99.S06ID,'''') = ISNULL(P.S06ID,'''') AND ISNULL(O99.S07ID,'''') = ISNULL(P.S07ID,'''') 
AND ISNULL(O99.S08ID,'''') = ISNULL(P.S08ID,'''') AND ISNULL(O99.S09ID,'''') = ISNULL(P.S09ID,'''') AND ISNULL(O99.S10ID,'''') = ISNULL(P.S10ID,'''') AND ISNULL(O99.S11ID,'''') = ISNULL(P.S11ID,'''') AND ISNULL(O99.S12ID,'''') = ISNULL(P.S12ID,'''') AND ISNULL(O99.S13ID,'''') = ISNULL(P.S13ID,'''') AND ISNULL(O99.S14ID,'''') = ISNULL(P.S14ID,'''')
AND ISNULL(O99.S15ID,'''') = ISNULL(P.S15ID,'''') AND ISNULL(O99.S16ID,'''') = ISNULL(P.S16ID,'''') AND ISNULL(O99.S17ID,'''') = ISNULL(P.S17ID,'''') AND ISNULL(O99.S18ID,'''') = ISNULL(P.S18ID,'''') AND ISNULL(O99.S19ID,'''') = ISNULL(P.S19ID,'''') AND ISNULL(O99.S20ID,'''') = ISNULL(P.S20ID,'''')
'

	 -- Join1
	SET @sJoin1 =' AND ISNULL(O99.S01ID,'''') = ISNULL(P1.S01ID,'''') AND ISNULL(O99.S02ID,'''') = ISNULL(P1.S02ID,'''') AND ISNULL(O99.S03ID,'''') = ISNULL(P1.S03ID,'''') AND ISNULL(O99.S04ID,'''') = ISNULL(P1.S04ID,'''') AND ISNULL(O99.S05ID,'''') = ISNULL(P1.S05ID,'''') AND ISNULL(O99.S06ID,'''') = ISNULL(P1.S06ID,'''') AND ISNULL(O99.S07ID,'''') = ISNULL(P1.S07ID,'''') 
AND ISNULL(O99.S08ID,'''') = ISNULL(P1.S08ID,'''') AND ISNULL(O99.S09ID,'''') = ISNULL(P1.S09ID,'''') AND ISNULL(O99.S10ID,'''') = ISNULL(P1.S10ID,'''') AND ISNULL(O99.S11ID,'''') = ISNULL(P1.S11ID,'''') AND ISNULL(O99.S12ID,'''') = ISNULL(P1.S12ID,'''') AND ISNULL(O99.S13ID,'''') = ISNULL(P1.S13ID,'''') AND ISNULL(O99.S14ID,'''') = ISNULL(P1.S14ID,'''')
AND ISNULL(O99.S15ID,'''') = ISNULL(P1.S15ID,'''') AND ISNULL(O99.S16ID,'''') = ISNULL(P1.S16ID,'''') AND ISNULL(O99.S17ID,'''') = ISNULL(P1.S17ID,'''') AND ISNULL(O99.S18ID,'''') = ISNULL(P1.S18ID,'''') AND ISNULL(O99.S19ID,'''') = ISNULL(P1.S19ID,'''') AND ISNULL(O99.S20ID,'''') = ISNULL(P1.S20ID,'''')
'

	-- Lấy thông tin số lượng, doanh số theo tháng
	SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM (select DISTINCT LTRIM(STR(OT2001.TranYear)) +'_'+ (CASE WHEN LTRIM(STR(OT2001.TranMonth)) < 10 THEN '0'+ LTRIM(STR(OT2001.TranMonth)) WHEN LTRIM(STR(OT2001.TranMonth)) >= 10  THEN LTRIM(STR(OT2001.TranMonth)) ELSE N'' END ) +'_SL' as AnaID
															from OT2001 WITH (NOLOCK)
															WHERE (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') = '' AND ISNULL(@ToYear,'') = ''
															       AND OT2001.TranMonth + OT2001.TranYear * 100 >= STR(@FromMonth + @FromYear * 100))
																OR 
																  (ISNULL(@FromMonth,'') = '' AND ISNULL(@FromYear,'') = '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
																   AND OT2001.TranMonth + OT2001.TranYear * 100 <= STR(@ToMonth + @ToYear * 100))
																OR
																   (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
																	AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN  STR(@FromMonth + @FromYear * 100) AND STR(@ToMonth + @ToYear * 100))
															) as tmp
	SELECT @cols = substring(@cols, 0, len(@cols))

	SELECT @cols1 = @cols1 + QUOTENAME(AnaID) + ',' FROM (select DISTINCT LTRIM(STR(OT2001.TranYear)) +'_'+ (CASE WHEN LTRIM(STR(OT2001.TranMonth)) < 10 THEN '0'+ LTRIM(STR(OT2001.TranMonth)) WHEN LTRIM(STR(OT2001.TranMonth)) >= 10  THEN LTRIM(STR(OT2001.TranMonth)) ELSE N'' END ) +'_TT' as AnaID
															from OT2001 WITH (NOLOCK)
															WHERE (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') = '' AND ISNULL(@ToYear,'') = ''
															       AND OT2001.TranMonth + OT2001.TranYear * 100 >= STR(@FromMonth + @FromYear * 100))
																OR 
																  (ISNULL(@FromMonth,'') = '' AND ISNULL(@FromYear,'') = '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
																   AND OT2001.TranMonth + OT2001.TranYear * 100 <= STR(@ToMonth + @ToYear * 100))
																OR
																   (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
																	AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN  STR(@FromMonth + @FromYear * 100) AND STR(@ToMonth + @ToYear * 100))
															) as tmp
	SELECT @cols1 = substring(@cols1, 0, len(@cols1))

	IF ISNULL(@cols,'') ='' OR ISNULL(@cols1,'') =''  return 

	SET @query = '
	SELECT * from 
	(
		select T1.InventoryID,T1.OrderQuantity '+@sSelect+', T2.UnitID
		,LTRIM(STR(T3.TranYear)) +''_''+ (CASE WHEN LTRIM(STR(T3.TranMonth)) < 10 THEN ''0''+ LTRIM(STR(T3.TranMonth)) WHEN LTRIM(STR(T3.TranMonth)) >= 10  THEN LTRIM(STR(T3.TranMonth)) ELSE N'''' END ) +''_SL'' as AnaID1
		FROM OT2002 T1 WITH (NOLOCK)
		inner join OT2001 T3 WITH (NOLOCK) on T1.DivisionID = T3.DivisionID and T1.SOrderID = T3.SOrderID
		LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T1.DivisionID AND O99.VoucherID = T1.SOrderID AND O99.TransactionID = T1.TransactionID
		WHERE T1.DivisionID  = '''+@DivisionID+''' '+@sWherePeriod+ '
	) src
	pivot 
	(
		sum(OrderQuantity)
		for AnaID1 in (' + @cols + ')
	) piv1 '

	SET @query1 = '
	SELECT * from 
	(
		select T1.InventoryID,T1.ConvertedAmount '+@sSelect+', T2.UnitID
		,LTRIM(STR(T3.TranYear)) +''_''+ (CASE WHEN LTRIM(STR(T3.TranMonth)) < 10 THEN ''0''+ LTRIM(STR(T3.TranMonth)) WHEN LTRIM(STR(T3.TranMonth)) >= 10  THEN LTRIM(STR(T3.TranMonth)) ELSE N'''' END ) +''_TT'' as AnaID2
		FROM OT2002 T1 WITH (NOLOCK)
		inner join OT2001 T3 WITH (NOLOCK) on T1.DivisionID = T3.DivisionID and T1.SOrderID = T3.SOrderID
		LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T1.DivisionID AND O99.VoucherID = T1.SOrderID AND O99.TransactionID = T1.TransactionID
		WHERE T1.DivisionID  = '''+@DivisionID+''' '+@sWherePeriod+'
	) src
	pivot
	( 
		sum(ConvertedAmount)
		for AnaID2 in (' + @cols1 + ')
	)piv2 '

	-- Lấy dữ liệu báo cáo
	SET @sSQL = '  SELECT DISTINCT T1.InventoryID, T2.InventoryName '+@sSelect+' ,T4.UnitName AS UnitID, ' + @cols + ',' + @cols1 + '
FROM OT2002 T1 WITH (NOLOCK)
inner join OT2001 T3 WITH (NOLOCK) on T1.DivisionID = T3.DivisionID and T1.SOrderID = T3.SOrderID
LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T1.InventoryID = T2.InventoryID
LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T1.DivisionID AND O99.VoucherID = T1.SOrderID AND O99.TransactionID = T1.TransactionID
LEFT JOIN AT1304 T4 WITH (NOLOCK) ON T4.UnitID = T1.UnitID
LEFT JOIN ('+@query+') 
P ON P.InventoryID = T1.InventoryID '+@sJoin+' AND P.UnitID = T2.UnitID '

	SET @sSQL1 ='
LEFT JOIN ('+@query1+') 
P1 ON P1.InventoryID = T1.InventoryID '+@sJoin1+' AND P1.UnitID = T2.UnitID

WHERE T1.DivisionID  = '''+@DivisionID+'''
'+@sWherePeriod + @sWhere+ '
ORDER BY T1.InventoryID
  '
	EXEC (@sSQL + @sSQL1)

	-- Lấy thông tin caption số lượng, doanh số theo tháng
	select * from (	select DISTINCT LTRIM(STR(OT2001.TranYear)) +'_'+ (CASE WHEN LTRIM(STR(OT2001.TranMonth)) < 10 THEN '0'+ LTRIM(STR(OT2001.TranMonth)) WHEN LTRIM(STR(OT2001.TranMonth)) >= 10  THEN LTRIM(STR(OT2001.TranMonth)) ELSE N'' END ) +'_SL' as AnaID
							, N'Số lượng' as [Name],N'Tháng '+LTRIM(STR(OT2001.TranMonth))+'/'+LTRIM(STR(OT2001.TranYear)) as [Period]
							from OT2001 WITH (NOLOCK)
							WHERE (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') = '' AND ISNULL(@ToYear,'') = ''
										AND OT2001.TranMonth + OT2001.TranYear * 100 >= STR(@FromMonth + @FromYear * 100))
									OR 
										(ISNULL(@FromMonth,'') = '' AND ISNULL(@FromYear,'') = '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
										AND OT2001.TranMonth + OT2001.TranYear * 100 <= STR(@ToMonth + @ToYear * 100))
									OR
										(ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
										AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN  STR(@FromMonth + @FromYear * 100) AND STR(@ToMonth + @ToYear * 100)) 
						union all
						select DISTINCT LTRIM(STR(OT2001.TranYear)) +'_'+ (CASE WHEN LTRIM(STR(OT2001.TranMonth)) < 10 THEN '0'+ LTRIM(STR(OT2001.TranMonth)) WHEN LTRIM(STR(OT2001.TranMonth)) >= 10  THEN LTRIM(STR(OT2001.TranMonth)) ELSE N'' END ) +'_TT' as AnaID
							,N'Doanh số' as [Name],N'Tháng '+LTRIM(STR(OT2001.TranMonth))+'/'+LTRIM(STR(OT2001.TranYear)) as [Period]
							from OT2001 WITH (NOLOCK)
							WHERE (ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') = '' AND ISNULL(@ToYear,'') = ''
									AND OT2001.TranMonth + OT2001.TranYear * 100 >= STR(@FromMonth + @FromYear * 100))
								OR 
									(ISNULL(@FromMonth,'') = '' AND ISNULL(@FromYear,'') = '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
									AND OT2001.TranMonth + OT2001.TranYear * 100 <= STR(@ToMonth + @ToYear * 100))
								OR
									(ISNULL(@FromMonth,'') <> '' AND ISNULL(@FromYear,'') <> '' AND ISNULL(@ToMonth,'') <> '' AND ISNULL(@ToYear,'') <> ''
									AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN  STR(@FromMonth + @FromYear * 100) AND STR(@ToMonth + @ToYear * 100))
					) as p
		order by AnaID
    
	Print @sSQL
	Print @sSQL1

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
