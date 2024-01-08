IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2003_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2003_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- IN ĐƠN HÀNG MUA - QR Code & Skid Label.(nhiều mặt hàng tham khảo store POP2003)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 16/06/2023
-- <Example>
--- exec POP2003_1 @VoucherNo=N'DHM/2023/05/275',@DivisionID=N'EXV'
-- <Example>

CREATE PROCEDURE POP2003_1

(	 
	 @VoucherNo VARCHAR(50),
	 @DivisionID VARCHAR(50)
)
AS 

DECLARE @OrderQuantity DECIMAL(28, 2) = 0
DECLARE @ConvertFactor DECIMAL(28, 2) = 0
DECLARE @Pages INT
DECLARE @PageIndex INT
DECLARE @RemainQuantity DECIMAL(28, 2) = 0
DECLARE @masterCursor CURSOR
DECLARE @APK VARCHAR (50)
DECLARE @ConversionFactor DECIMAL(28, 2) = 0

-- Bảng kết quả
CREATE TABLE #POP2003_1_Result
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
SELECT 
  OT02.APK AS APK
, OT01.ObjectName
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

INTO #POP2003_1
FROM OT3002 OT02 WITH (NOLOCK)
LEFT JOIN OT3001 OT01 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT01.POrderID = OT02.POrderID
LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (OT02.DivisionID, '@@@') AND AT02.InventoryID = OT02.InventoryID
INNER JOIN AT1309 AT09 WITH (NOLOCK) ON AT09.DivisionID = OT02.DivisionID AND AT09.InventoryID = OT02.InventoryID
LEFT JOIN A00003 A03  WITH (NOLOCK) ON A03.DivisionID IN (OT02.DivisionID, '@@@') AND A03.InventoryID = OT02.InventoryID
WHERE OT02.DivisionID = @DivisionID
	  AND OT02.Ana08ID = @VoucherNo

BEGIN

	SET @masterCursor = CURSOR STATIC FOR
	SELECT APK 
			, OrderQuantity 
			, ConversionFactor 
	FROM #POP2003_1

	OPEN @masterCursor

	FETCH NEXT FROM @masterCursor 
	INTO	@APK, @OrderQuantity, @ConversionFactor
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT(@APK)
		PRINT(@OrderQuantity)
		PRINT(@ConversionFactor)
		-- Xử lý n dòng. Tổng số lượng / Hệ số chuyển đội. Làm tròn trên.
		SET @Pages = CEILING(@OrderQuantity / @ConversionFactor);

		SET @PageIndex = 1
		WHILE (@PageIndex <= @Pages)
		BEGIN

			SET @RemainQuantity = @OrderQuantity % @ConversionFactor;

			-- Kiểm tra lấy phần dư.
			IF(@RemainQuantity > 0)
			BEGIN
				IF (@PageIndex = @Pages)
				BEGIN
					SET @RemainQuantity = @OrderQuantity % @ConversionFactor;
				END
				ELSE
				BEGIN
					SET @RemainQuantity = @ConversionFactor;
				END
			END
			ELSE
				SET @RemainQuantity = @ConversionFactor;

			INSERT INTO	#POP2003_1_Result
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
			SELECT 
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
			FROM #POP2003_1  
			WHERE CONVERT(VARCHAR(50), APK) = @APK

			SET @PageIndex = @PageIndex + 1;

		END

	FETCH NEXT FROM  @masterCursor INTO	@APK, @OrderQuantity, @ConversionFactor
	END
	CLOSE @masterCursor

END

-- Trả về kết quả
SELECT * From #POP2003_1_Result ORDER BY InventoryID, RemainQuantity DESC,RowNum


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
