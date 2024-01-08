IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2163_EXV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2163_EXV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- IN LỆNH SẢN XUẤT- QR Code.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nhật Quang, Date: 01/03/2023
----Modified by: Nhật Quang, Date: 28/03/2023 - Bổ sung thêm trường Notes01: Ghi chú 01 ở bảng AT1302.
----Modified by: Viết Toàn, Date: 11/05/2023 - Nếu mã thành phẩm có mã phân tích mặt hàng 03 mã FG, chưa lấy ra mã ,tên mặt hàng khách hàng ( lấy từ MPT nghiệp vụ 04).
-- <Example>
--- EXEC MP2163_EXV @VoucherNo=N'LSX/2023/01/009',@InventoryID=N'3317001100PR2-EP',@UnitID=N'THU',@DivisionID=N'EXV'
-- <Example>

CREATE PROCEDURE MP2163_EXV
(	 
	 @VoucherNo NVARCHAR(50),
	 @InventoryID NVARCHAR(50),
	 @UnitID NVARCHAR(50),
	 @DivisionID NVARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N''
DECLARE @OrderQuantity DECIMAL(28, 2) = 0
DECLARE @ConvertFactor DECIMAL(28, 2) = 0
DECLARE @Pages INT
DECLARE @PageIndex INT
DECLARE @RemainQuantity DECIMAL(28, 2) = 0

-- Bảng kết quả
CREATE TABLE #MF2163_EXV_Result
(
  RowNum INT NULL,
  VoucherNo NVARCHAR(50) NULL, 
  EmployeeID NVARCHAR (50) NULL, 
  ObjectName NVARCHAR (250) NULL, 
  ObjectID NVARCHAR (50) NULL, 
  SourceNo NVARCHAR(50) NULL, 
  MaterialQuantity DECIMAL(28, 2),
  DateDelivery DateTime NULL, 
  QuantityFormat NVARCHAR(50) NULL, 
  ConversionFactor DECIMAL(28, 2) NULL, 
  RemainQuantity DECIMAL(28, 2) NULL, 
  UnitID NVARCHAR(50) NULL,
  [Image] IMAGE NULL,
  Note NVARCHAR(500)
)

--- Lấy dữ liệu
SELECT TOP 1 
  MT60.VoucherNo
  , MT60.EmployeeID,  AT02.I03ID
, (CASE 
	WHEN AT02.I03ID = 'FG' 
		THEN AT11.Notes  -- Thành phẩm : lấy theo mã KH - Lấy từ đơn hàng sản xuất cột Ana04Name OT2001
	ELSE 
		AT02.InventoryName  -- Lấy lên inventoryID : lấy mã materialID trong lệnh sản xuất
	END ) AS ObjectName
, (CASE 
	WHEN AT02.I03ID = 'FG' 
		THEN AT11.AnaID
	ELSE AT02.InventoryID 
	END ) AS ObjectID
, MT60.SourceNo
, MT60.ProductQuantity AS MaterialQuantity
, MT60.DateDelivery
, (SELECT TOP 1 ConversionFactor FROM AT1309 WHERE InventoryID = @InventoryID AND UnitID = @UnitID) ConversionFactor
, AT04.UnitName AS UnitID
, AT02.Image01ID
, AT02.Notes01 AS Note

INTO #MF2163_EXV
FROM MT2160 MT60 WITH (NOLOCK)
LEFT JOIN OT2201 OT21 WITH (NOLOCK) ON OT21.DivisionID = MT60.DivisionID AND MT60.MOrderID = OT21.VoucherNo
LEFT JOIN OT2202 OT22 WITH (NOLOCK) ON OT22.DivisionID = MT60.DivisionID AND OT21.EstimateID = OT22.EstimateID
LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.DivisionID = OT22.DivisionID AND OT22.Ana04ID = AT11.AnaID
LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (MT60.DivisionID, '@@@') AND AT02.InventoryID = MT60.ProductID
LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON AT04.UnitID = OT22.UnitID
WHERE MT60.DivisionID = @DivisionID
	  AND MT60.VoucherNo = @VoucherNo

-- Lấy thông tính toán
SELECT @OrderQuantity = MaterialQuantity 
	, @ConvertFactor = ConversionFactor
FROM #MF2163_EXV


BEGIN

	-- Xử lý n dòng. Tổng số lượng / Hệ số chuyển đội. Làm tròn trên.
	SET @Pages = CEILING(@OrderQuantity / @ConvertFactor);

	SET @PageIndex = 1
	WHILE (@PageIndex <= @Pages)
	BEGIN

		SET @RemainQuantity = @OrderQuantity % @ConvertFactor;

		-- Kiểm tra lấy phần dư.
		IF(@RemainQuantity > 0)
		BEGIN
			IF (@PageIndex = @Pages)
			BEGIN
				SET @RemainQuantity = @OrderQuantity % @ConvertFactor;
			END
			ELSE
			BEGIN
				SET @RemainQuantity = @ConvertFactor;
			END
		END
		ELSE
			SET @RemainQuantity = @ConvertFactor;

		INSERT INTO	#MF2163_EXV_Result
		(
		  RowNum 
		  , VoucherNo
		  , EmployeeID
		  , ObjectName 
		  , ObjectID
		  , SourceNo
		  , MaterialQuantity
		  , DateDelivery 
		  , RemainQuantity
		  , QuantityFormat
		  , ConversionFactor 
		  , UnitID 
		  , [Image]
		  , Note
		)
		SELECT TOP 1
			@PageIndex 
		  , VoucherNo
		  , EmployeeID
		  , ObjectName 
		  , ObjectID
		  , SourceNo
		  , MaterialQuantity
		  , DateDelivery  
		  , @RemainQuantity
		  , CONCAT(CONVERT(INT, @RemainQuantity), ' | ', CONVERT(INT, MaterialQuantity)) AS QuantityFormat
		  , ConversionFactor 
		  , UnitID 
		  , Image01ID
		  , Note
		FROM #MF2163_EXV

		SET @PageIndex = @PageIndex + 1;

	END

END

-- Trả về kết quả
SELECT * From #MF2163_EXV_Result

PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
