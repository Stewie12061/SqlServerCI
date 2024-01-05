IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In Báo cáo thời gian giao hàng - SOF3014
-- <Param>
---- 
-- <Return>
-- <Notes> M - Master đơn hàng bán
--		   C - Chi tiết đơn hàng bán
--		   T - Tiến độ giao hàng 
--		   P - Phiếu xuất nhập kho
--		   CP- Chi tiết Phiếu xuất nhập kho 		
-- <Reference>
---- 
-- <History>
---- Create ON 19/08/2020 by Trần Đình Hoà
---- Update ON 16/01/2023 by Anh Đô - Select thêm cột AT2006.Notes, InventoryName, chỉnh sửa điều kiện lọc cho trường hợp chọn nhiều ObjectID
---- Update ON 06/02/2023 by Anh Đô - Bổ sung xử lí lọc bỏ đi những row có số lượng giao là 0.

CREATE PROCEDURE [dbo].[SOP30141] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromObjectID		NVARCHAR(MAX),
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR(Max)	--Biến môi trường
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sSQL2 NVARCHAR(MAX),
			@sWhere NVARCHAR(max)

	Set @sWhere = ''
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = ' M.DivisionID = N'''+@DivisionID+''''	

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (Case When M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''
										+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''
										+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	--IF Isnull(@FromObjectID, '')!= ''
	--	SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') > = N'''+@FromObjectID +''''

	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND M.SalesManID in ('''+@ConditionSOrderID+''')'

	IF ISNULL(@FromObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND M.ObjectID IN (SELECT Value FROM [dbo].StringSplit('''+ @FromObjectID +''', '','')) '

	SET @sSQL2 = N'
		CASE T.Quantity 
			WHEN ''Quantity01'' THEN C.Quantity01
			WHEN ''Quantity02'' THEN C.Quantity02
			WHEN ''Quantity03'' THEN C.Quantity03
			WHEN ''Quantity04'' THEN C.Quantity04
			WHEN ''Quantity05'' THEN C.Quantity05
			WHEN ''Quantity06'' THEN C.Quantity06
			WHEN ''Quantity07'' THEN C.Quantity07
			WHEN ''Quantity08'' THEN C.Quantity08
			WHEN ''Quantity09'' THEN C.Quantity09
			WHEN ''Quantity10'' THEN C.Quantity10
			WHEN ''Quantity11'' THEN C.Quantity11
			WHEN ''Quantity12'' THEN C.Quantity12
			WHEN ''Quantity13'' THEN C.Quantity13
			WHEN ''Quantity14'' THEN C.Quantity14
			WHEN ''Quantity15'' THEN C.Quantity15
			WHEN ''Quantity16'' THEN C.Quantity16
			WHEN ''Quantity17'' THEN C.Quantity17
			WHEN ''Quantity18'' THEN C.Quantity18
			WHEN ''Quantity19'' THEN C.Quantity19
			WHEN ''Quantity20'' THEN C.Quantity20
			WHEN ''Quantity21'' THEN C.Quantity21
			WHEN ''Quantity22'' THEN C.Quantity22
			WHEN ''Quantity23'' THEN C.Quantity23
			WHEN ''Quantity24'' THEN C.Quantity24
			WHEN ''Quantity25'' THEN C.Quantity25
			WHEN ''Quantity26'' THEN C.Quantity26
			WHEN ''Quantity27'' THEN C.Quantity27
			WHEN ''Quantity28'' THEN C.Quantity28
			WHEN ''Quantity29'' THEN C.Quantity29
			WHEN ''Quantity30'' THEN C.Quantity30
			ELSE 0 
		 END
	'
	
	SET @sSQL = 'Select   M.ObjectID
						, M.ObjectName
						, M.VoucherNo
						, M.OrderDate
						, T.Date
						, P.VoucherDate
						, P.Notes
						, A2.InventoryID
						, A2.InventoryName
						, '+ @sSQL2 +' AS Quantity
				 INTO #tmp
				 From OT2001 M WITH(NOLOCK)
						Inner Join OT2002 C WITH(NOLOCK) on M.SOrderID = C.SOrderID
						Inner Join OT2003_MT T WITH(NOLOCK) on M.SOrderID = T.SOrderID
						LEFT JOIN (
						SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A4.VoucherDate, A3.Notes
						FROM AT2007 A3 WITH(NOLOCK)
							 LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
					    WHERE A4.KindVoucherID IN (2,4,6)) AS P 
						ON C.InventoryID = P.InventoryID AND C.TransactionID = P.InheritTransactionID 
						LEFT JOIN AT1302 A2 ON A2.InventoryID = C.InventoryID AND ISNULL(A2.Disabled, 0) = 0
						AND A2.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
				 Where ' + @sWhere +'
				 GROUP BY  M.ObjectID, M.ObjectName, M.VoucherNo, M.OrderDate, T.Date, P.VoucherDate, P.Notes ,A2.InventoryID ,A2.InventoryName, T.Quantity,
				 '+ @sSQL2 +'
				 Order By M.ObjectName, M.OrderDate, A2.InventoryID ,A2.InventoryName
				 
				 SELECT * FROM #tmp WHERE Quantity > 0
				 '

	EXEC (@sSQL)
	PRINT (@sSQL)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
