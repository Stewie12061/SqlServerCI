IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo kế hoạch bán hàng - SOF3015
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 24/08/2020 by Kiều Nga
---- Updated ON 04/01/2021 by Trọng Kiên: Fix lỗi exception khi không có Year
-- <Example> EXEC SOP30151 'MT','MT',6,7,2020,2020

CREATE PROCEDURE [dbo].[SOP30151] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@YearPlan			INT,
				@ListObjectID		XML,
				@ListInventoryID	XML
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max)='',
			@sWhere NVARCHAR(max)=''

	-- Load dữ liệu từ xml params:
	--- Đối tượng
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[tmpObjectID]') AND TYPE IN (N'U'))
						DROP TABLE tmpObjectID
	CREATE TABLE tmpObjectID
	(
			ObjectID varchar(50)
	)
	INSERT INTO	tmpObjectID		
	SELECT	X.D.value('.', 'VARCHAR(50)') AS ObjectID
	FROM	@ListObjectID.nodes('//D') AS X (D)

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
	IF (select count(InventoryID) from tmpInventoryID where ISNULL(InventoryID,'') <> '') > 0
	SET @sWhere = @sWhere + '
	 AND T2.InventoryID IN (select InventoryID from tmpInventoryID)'

	IF (select count(ObjectID) from tmpObjectID where ISNULL(ObjectID,'') <> '') > 0
	SET @sWhere = @sWhere + '
	 AND T1.ObjectID IN (select ObjectID from tmpObjectID)'

	IF (@YearPlan IS NULL)
	BEGIN
	    SET @YearPlan = YEAR(GETDATE())
	END
	SET @sWhere = @sWhere + '
	 AND T1.YearPlan = '+ LTRIM(STR(@YearPlan)) +''
	 print @sWhere
	-- Lấy dữ liệu báo cáo
	SET @sSQL = '  SELECT T1.ObjectID,T4.ObjectName,T2.InventoryID,T3.InventoryName,Sum(ISNULL(T2.Quantity1,0)) as Quantity1,Sum(ISNULL(T2.Quantity2,0)) as Quantity2,Sum(ISNULL(T2.Quantity3,0)) as Quantity3
,Sum(ISNULL(T2.Quantity4,0)) as Quantity4,Sum(ISNULL(T2.Quantity5,0)) as Quantity5,Sum(ISNULL(T2.Quantity6,0)) as Quantity6,Sum(ISNULL(T2.Quantity7,0)) as Quantity7,Sum(ISNULL(T2.Quantity8,0)) as Quantity8
,Sum(ISNULL(T2.Quantity9,0)) as Quantity9,Sum(ISNULL(T2.Quantity10,0)) as Quantity10,Sum(ISNULL(T2.Quantity11,0)) as Quantity11,Sum(ISNULL(T2.Quantity12,0)) as Quantity12
,ISNULL(P.[1],0) as T1 ,ISNULL(P.[2],0) as T2 ,ISNULL(P.[3],0) as T3 ,ISNULL(P.[4],0) as T4 ,ISNULL(P.[5],0) as T5 ,ISNULL(P.[6],0) as T6 ,ISNULL(P.[7],0) as T7 ,ISNULL(P.[8],0) as T8 ,ISNULL(P.[9],0) as T9
,ISNULL(P.[10],0) as T10 ,ISNULL(P.[11],0) as T11 ,ISNULL(P.[12],0) as T12
FROM SOT2070 T1 WITH (NOLOCK)
LEFT JOIN SOT2071 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
LEFT JOIN AT1302 T3 WITH (NOLOCK) ON T2.InventoryID = T3.InventoryID
LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID
LEFT JOIN (SELECT * from (
			SELECT  O3.ObjectID,O1.InventoryID, A1.InventoryName, CASE WHEN A3.ActualQuantity IS NULL THEN 0 ELSE A3.ActualQuantity END	AS ShippedAmount,Convert(int, Month(OrderDate)) as Month1, Convert(int,Year(OrderDate)) as Year1
			FROM OT2002 O1 WITH (NOLOCK)
				LEFT JOIN AT1302 A1 WITH(NOLOCK) ON A1.InventoryID = O1.InventoryID
				LEFT JOIN (
					SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
					FROM AT2007 A3 WITH(NOLOCK)
						LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
					WHERE A4.KindVoucherID IN (2,4,6)
				) AS A3 on O1.InventoryID = A3.InventoryID AND O1.TransactionID = A3.InheritTransactionID
				LEFT JOIN OT2001 O3 WITH(NOLOCK) ON O3.SOrderID = O1.SOrderID
				INNER JOIN SOT2080 SO1 WITH (NOLOCK) ON O1.APK = SO1.APKInherit
				)src
				pivot 
				(
					sum(ShippedAmount) for Month1 in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
				) piv
) P ON P.ObjectID = T1.ObjectID AND P.InventoryID = T2.InventoryID
WHERE T1.DivisionID  = '''+@DivisionID+'''
'+@sWhere+'
Group by T1.ObjectID,T4.ObjectName,T2.InventoryID,T3.InventoryName,ISNULL(P.[1],0),ISNULL(P.[2],0),ISNULL(P.[3],0),ISNULL(P.[4],0),ISNULL(P.[5],0),ISNULL(P.[6],0),ISNULL(P.[7],0),ISNULL(P.[8],0),ISNULL(P.[9],0)
,ISNULL(P.[10],0),ISNULL(P.[11],0),ISNULL(P.[12],0)
order by InventoryID
'
	Print @sSQL
	EXEC (@sSQL)


END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
