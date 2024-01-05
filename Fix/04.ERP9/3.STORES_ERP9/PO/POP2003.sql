IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- IN ĐƠN HÀNG MUA - QR Code & Skid Label.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nhật Quang, Date: 17/10/2022
----Modify by: Nhật Quang, Date: 10/03/2023 : Lấy thêm trường HeatNo
-- <Example>
--- EXEC POP2003 @VoucherNo=N'DHM/2022/10/034',@InventoryID=N'1DW-E6611',@UnitID=N'THU',@DivisionID=N'EXV'
-- <Example>

CREATE PROCEDURE POP2003

(	 
	 @VoucherNo VARCHAR(50),
	 @InventoryID VARCHAR(50),
	 @UnitID VARCHAR(50),
	 @DivisionID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N''
DECLARE @OrderQuantity DECIMAL(28, 2) = 0
DECLARE @ConvertFactor DECIMAL(28, 2) = 0
DECLARE @Pages INT
DECLARE @PageIndex INT
DECLARE @RemainQuantity DECIMAL(28, 2) = 0

-- Bảng kết quả
CREATE TABLE #POP2003_Result
(
  RowNum INT NULL,
  ObjectName NVARCHAR (250) NULL, 
  OrderDate DateTime NULL, 
  ReceivedDate DateTime NULL, 
  SourceNo VARCHAR(50) NULL, 
  VoucherNo VARCHAR(50) NULL, 
  OrderQuantity DECIMAL(28, 2),
  RemainQuantity DECIMAL(28, 2),
  QuantityFormat VARCHAR(50),
  InventoryID VARCHAR(50) NULL, 
  InventoryName NVARCHAR (250) NULL, 
  ConversionFactor DECIMAL(28, 2) NULL, 
  UnitID VARCHAR(50) NULL,
  [Image] IMAGE NULL,
  HeatNo NVARCHAR(50)
)

--- Lấy dữ liệu
SELECT TOP 1 OT01.ObjectName
, OT01.OrderDate
, OT02.ReceivedDate
, OT02.SourceNo
, OT02.Ana08ID AS VoucherNo
, OT02.OrderQuantity
, OT02.InventoryID
, AT02.InventoryName
, AT09.ConversionFactor
, AT09.UnitID 
, A03.Image01ID
, AT02.Notes01 AS HeatNo

INTO #POP2003
FROM OT3002 OT02 WITH (NOLOCK)
LEFT JOIN OT3001 OT01 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT01.POrderID = OT02.POrderID
LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (OT02.DivisionID, '@@@') AND AT02.InventoryID = OT02.InventoryID
LEFT JOIN AT1309 AT09 WITH (NOLOCK) ON AT09.DivisionID = OT02.DivisionID AND AT09.InventoryID = OT02.InventoryID
LEFT JOIN A00003 A03  WITH (NOLOCK) ON A03.DivisionID IN (OT02.DivisionID, '@@@') AND A03.InventoryID = OT02.InventoryID
WHERE OT02.DivisionID = @DivisionID
	  AND OT02.InventoryID = @InventoryID
	  AND OT02.Ana08ID = @VoucherNo

-- Lấy thông tính toán
SELECT @OrderQuantity = OrderQuantity 
	, @ConvertFactor = ConversionFactor
FROM #POP2003

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

		INSERT INTO	#POP2003_Result
		(
		  RowNum 
		  , ObjectName 
		  , OrderDate
		  , ReceivedDate 
		  , SourceNo
		  , VoucherNo
		  , OrderQuantity 
		  , RemainQuantity
		  , QuantityFormat
		  , InventoryID
		  , InventoryName 
		  , ConversionFactor 
		  , UnitID 
		  , Image
		  , HeatNo
		)
		SELECT TOP 1
			@PageIndex 
		  , ObjectName 
		  , OrderDate
		  , ReceivedDate 
		  , SourceNo
		  , VoucherNo
		  , OrderQuantity 
		  , @RemainQuantity
		  , CONCAT(CONVERT(INT, @RemainQuantity), ' | ', CONVERT(INT, OrderQuantity)) AS QuantityFormat
		  , InventoryID
		  , InventoryName 
		  , ConversionFactor 
		  , UnitID 
		  , Image01ID
		  , HeatNo
		FROM #POP2003

		SET @PageIndex = @PageIndex + 1;

	END

END

-- Trả về kết quả
SELECT * From #POP2003_Result

PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
