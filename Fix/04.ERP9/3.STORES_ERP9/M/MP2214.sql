IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2214]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2214]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu màn hình kế thừa lệnh sản xuất.
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Kiều Nga Date 16/03/2021
-- Modify by : Kiều Nga Date 14/09/2021 : Lỗi load kế thừa lệnh sản xuất
-- Modify by : Kiều Nga Date 28/01/2022 : Lỗi lặp dòng kế thừa
-- Modify by : Thanh Lượng Date 02/03/2023 : Bổ sung thay đổi customize (INNOTEK) thêm trường lấy dự liệu cần thiết đưa vào luồng chuẩn.
-- Modify by : Nhật Thanh Date 03/04/2023 : Thay đổi cách lấy dữ liệu
-- Modify by : Đức Tuyên Date 26/04/2023 : Không hiển thị những lệnh đã bị xóa
-- Modify by : Phương Thảo  Date 12/06/2023 : Bổ sung lấy mac nguồn lực may( machineID)
-- Modify by : Phương Thảo  Date 16/06/2023 : [EXEDY][2023/05/IS/0171]Lấy lên line sản xuất
-- Modify by : Đức Tuyên Date 14/08/2023 : Fix lỗi không kế thừa được quy cách theo lệnh sản xuất (MAITHU)t
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----Modify by: Nhật Thanh on 18/10/2023 - Cập nhật : Sửa bảng leftjoin
-- <Example>

 CREATE PROCEDURE [dbo].[MP2214] 
 (
	 @DivisionID NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @PhaseID NVARCHAR(MAX),
	 @VoucherNo VARCHAR(50),
	 @ObjectID NVARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sSQL2 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX) ='',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50)



IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T.TranMonth + T.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+'
	AND T.DeleteFlg <> 1'
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'
		AND T.VoucherDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T.VoucherDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T.VoucherDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END

IF ISNULL(@PhaseID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND A1.PhaseID IN ('''+REPLACE(@PhaseID,',',''',''')+''')'
END

IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND T.VoucherNo like ''%' + @VoucherNo + '%'''
END

IF ISNULL(@ObjectID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND ( T.ObjectID Like ''%'+@ObjectID+'%'' OR T2.ObjectName  Like N''%'+@ObjectID+'%'' )'
END

SET @sSQL = '
		SELECT DISTINCT T.APK,T.DivisionID,T.VoucherNo,T.VoucherDate,
		T.EmployeeID,T1.FullName as EmployeeName,T.ObjectID ,T2.ObjectName as ObjectName,T.DateDelivery as ShipDate,A4.PhaseID,T3.PhaseName as PhaseName,A4.MachineID as MachineID
		,A4.MachineName as MachineName,T.ProductID as DetailID, T.ProductName as DetailName,T.DateDelivery as ManufacturerDate,A41.InventoryID as InventoryID, A4.LineProduceID as Ana06ID , AT01.AnaName as Ana06Name
		,Isnull((Select Sum(TimeNumberPlan) from MT2142 where APK= A4.Apkmaster),0)AS TotalPlan,Isnull((Select Sum(WorkersLimit) from MT2142 where APK= A4.Apkmaster),0)AS TotalActualTime,ISNULL(T.ProductQuantity,0) as ItemPlan,
		T4.InventoryName as InventoryName,
		T4.UnitID,T4.Specification, T5.UnitName,Convert(int,(ISNULL(T.ProductQuantity,0) - ISNULL(A.Quantity,0))) as Quantity,T.OrderStatus, T.OrderStatus as StatusName
		,T.PONumber As S01ID,T.S02ID As S02ID,T.S03ID As S03ID,T.S04ID As S04ID,T.S05ID As S05ID,T.S06ID As S06ID,T.S07ID As S07ID,T.S08ID As S08ID
		,T.S09ID As S09ID,T.S10ID As S10ID,T.S11ID As S11ID,T.S12ID As S12ID,T.S13ID As S13ID,T.S14ID As S14ID,T.S15ID As S15ID,T.S16ID As S16ID
		,T.S17ID As S17ID,T.S18ID As S18ID,T.S19ID As S19ID,T.S20ID As S20ID
		,T.S01ID As S01Name,T.S02ID As S02Name,T.S03ID As S03Name,T.S04ID As S04Name,T.S05ID As S05Name,T.S06ID As S06Name,T.S07ID As S07Name,T.S08ID As S08Name
		,T.S09ID As S09Name,T.S10ID As S10Name,T.S11ID As S11Name,T.S12ID As S12Name,T.S13ID As S13Name,T.S14ID As S14Name,T.S15ID As S15Name,T.S16ID As S16Name
		,T.S17ID As S17Name,T.S18ID As S18Name,T.S19ID As S19Name,T.S20ID As S20Name
		--,B.S01 As S01Name,B.S02 As S02Name,B.S03 As S03Name,B.S04 As S04Name,B.S05 As S05Name,B.S06 As S06Name,B.S07 As S07Name,B.S08 As S08Name
		--,B.S09 As S09Name,B.S10 As S10Name,B.S11 As S11Name,B.S12 As S12Name,B.S13 As S13Name,B.S14 As S14Name,B.S15 As S15Name,B.S16 As S16Name
		--,B.S17 As S17Name,B.S18 As S18Name,B.S19 As S19Name,B.S20 As S20Name
		INTO #MT2160
		FROM MT2160 T WITH (NOLOCK)
		LEFT JOIN MT2140 A2 WITH (NOLOCK) ON T.MPlanID = A2.VoucherNo AND A2.DivisionID IN (''@@@'',T.DivisionID) 
		LEFT JOIN MT2142 A4 WITH (NOLOCK) ON T.InheritTransactionID = A4.APK AND A4.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN MT2141 A41 WITH (NOLOCK) ON A41.APK = A4.APK_MT2141 AND A4.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1103 T1 WITH (NOLOCK) ON T.EmployeeID = T1.EmployeeID AND T1.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T.ObjectID = T2.ObjectID AND T2.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT0126 T3 WITH (NOLOCK) ON A4.PhaseID = T3.PhaseID AND T3.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1302 T4 WITH (NOLOCK) ON A41.InventoryID = T4.InventoryID AND T4.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1304 T5 WITH (NOLOCK) ON T4.UnitID = T5.UnitID AND T5.DivisionID IN (''@@@'',T4.DivisionID)
		LEFT JOIN OT2001 OT1 WITH (NOLOCK) ON T.MOrderID = OT1.SOrderID AND OT1.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN OT2002 OT2 WITH (NOLOCK) ON OT1.SOrderID = OT2.SOrderID AND OT2.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1011 AT01 ON A4.LineProduceID = AT01.AnaID AND AT01.AnaTypeID = ''A06''
		LEFT JOIN (SELECT InheritVoucherID,PhaseID,SUM(ISNULL(Quantity,0)) as Quantity
					FROM MT2211 WITH (NOLOCK)
					WHERE InheritTableID = ''MT2160''
					GROUP BY InheritVoucherID,PhaseID) AS A ON A.InheritVoucherID = T.APK AND A4.PhaseID = A.PhaseID'
SET @sSQL2 = '	
		--LEFT JOIN (SELECT * FROM 
		--	(
		--		SELECT T1.InventoryID,T1.StandardTypeID,T2.StandardName
		--		FROM AT1323 T1 WITH (NOLOCK)
		--		LEFT JOIN AT0128 T2 WITH (NOLOCK) ON T1.StandardID =T2.StandardID AND T1.StandardTypeID =T2.StandardTypeID AND T2.DivisionID IN (''@@@'',T1.DivisionID)
		--		WHERE ISNULL(T1.OriginalValue,0) = 1
		--	) src PIVOT (
		--		MAX(StandardName) for StandardTypeID in (S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20)
		--	) piv ) B ON T4.InventoryID = B.InventoryID

		WHERE T.DivisionID = '''+@DivisionID+'''  AND (ISNULL(T.ProductQuantity,0) - ISNULL(A.Quantity,0)) > 0
		'+ @sWhere +'
		Order by T.DivisionID,T.VoucherNo,A4.PhaseID,A4.MachineName
		
		SELECT ROW_NUMBER() OVER (ORDER BY M.VoucherDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow,M.* 
		FROM #MT2160 M WITH (NOLOCK)'

PRINT(@sSQL)
PRINT(@sSQL2)
EXEC (@sSQL+@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

