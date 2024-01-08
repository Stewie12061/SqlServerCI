IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2149]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2149]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Store tổng gộp 2 Store Định mức dự án và Phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 5/11/2019 by Đình Ly
----Modified on 25/03/2020 by Vĩnh Tâm: Fix lỗi không lấy được dữ liệu định mức theo Dự án đã chọn
----Modified on 13/04/2020 by Vĩnh Tâm: Bổ sung 3 cột hệ số NC, KHCU, Sale
-- <Example> Exec OOP2149 @DivisionID='DTI', @ProjectID = 'CH.00000007'

CREATE PROCEDURE [dbo].[OOP2149]
(
	@DivisionID VARCHAR(50),
	@ProjectID VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SumQuotationSale DECIMAL(28,8),
			@SumQuoteProject DECIMAL(28,8)

	-- Table lớn chứa dữ liệu bảng định mức và phiếu báo giá
	DECLARE @ReportQuoteProject TABLE (
		TypeOrder VARCHAR(10),
		STT VARCHAR(50),
		InventoryID NVARCHAR(50),
		Desciption NVARCHAR(MAX),
		OriginName NVARCHAR(500),
		UnitPrice DECIMAL(28,8),
		UnitID VARCHAR(50),
		QuoQuantity DECIMAL(28,8),
		OriginalAmount DECIMAL(28, 8),
		CoefficientNC VARCHAR(10),
		CoefficientKHCU VARCHAR(10),
		CoefficientSale VARCHAR(10),
		TypeData INT)

	DECLARE @Quotation TABLE (
		TypeOrder VARCHAR(10),
		STT VARCHAR(50),
		InventoryID NVARCHAR(50),
		Desciption NVARCHAR(MAX),
		OriginName NVARCHAR(500),
		UnitPrice DECIMAL(28,8),
		UnitID VARCHAR(50),
		QuoQuantity DECIMAL(28,8),
		OriginalAmount DECIMAL(28, 8),
		CoefficientNC VARCHAR(10),
		CoefficientKHCU VARCHAR(10),
		CoefficientSale VARCHAR(10),
		TypeData INT)

	DECLARE @QuoteProject TABLE (
		TypeOrder VARCHAR(10),
		STT VARCHAR(50),
		InventoryID NVARCHAR(50),
		CostGroupDetailID VARCHAR(50),
		Desciption NVARCHAR(MAX),
		OriginName NVARCHAR(500),
		UnitPrice DECIMAL(28,8),
		UnitID VARCHAR(50),
		QuoQuantity DECIMAL(28,8),
		OriginalAmount DECIMAL(28, 8),
		TypeData INT)

	-- Get dữ liệu định mức vào bảng tạm
	INSERT INTO @QuoteProject(STT, CostGroupDetailID, Desciption, UnitPrice, QuoQuantity, OriginName, InventoryID, TypeData)
	EXEC OOP2147 @DivisionID, @ProjectID

	-- Get dữ liệu mặt hàng phiếu báo giá vào bảng tạm
	INSERT INTO @Quotation(TypeOrder, STT, InventoryID, Desciption, OriginName, UnitPrice, UnitID, QuoQuantity
							, OriginalAmount, CoefficientNC, CoefficientKHCU, CoefficientSale, TypeData)
	EXEC OOP2148 @DivisionID, @ProjectID

	-- Insert dữ liệu bảng phiếu báo giá vào bảng cha
	INSERT INTO @ReportQuoteProject(TypeOrder, STT, InventoryID, Desciption, OriginName, UnitPrice, UnitID, QuoQuantity
							, OriginalAmount, CoefficientNC, CoefficientKHCU, CoefficientSale, TypeData)
	SELECT * FROM @Quotation

	INSERT INTO @ReportQuoteProject(Desciption, OriginalAmount, TypeData)
	SELECT N'Tổng báo giá', SUM(OriginalAmount), '4' FROM @Quotation

	-- Dòng dữ liệu đặc biệt - phân biệt giữa 2 bảng
	INSERT INTO @ReportQuoteProject(Desciption, TypeData)
	VALUES(N'Định mức dự án', '3')
	-- Dòng dữ liệu đặc biệt - phân biệt giữa 2 bảng
	INSERT INTO @ReportQuoteProject(Desciption, TypeData)
	VALUES(N'Dòng dữ liệu thay thế', '10')

	-- Insert dữ liệu bảng định mức vào bảng cha
	INSERT INTO @ReportQuoteProject(STT, InventoryID, Desciption, OriginalAmount, TypeData)
	SELECT STT, CostGroupDetailID, Desciption, QuoQuantity, TypeData FROM @QuoteProject

	-- Sum tổng tiền báo giá SALE(chưa nhân hệ số sale)
	SELECT @SumQuotationSale = SUM(O0.UnitPrice * O0.QuoQuantity * ISNULL(ISNULL(OT01.ExchangeRate, O1.ExchangeRate), 1))
	FROM OT2102 O0 WITH (NOLOCK)
		INNER JOIN OOT2140 O2 WITH (NOLOCK) ON O2.ProjectID = @ProjectID
		INNER JOIN OT2101 O1 WITH (NOLOCK) ON O0.QuotationID = O1.QuotationID
		INNER JOIN AT1302 A2 WITH (NOLOCK) ON O0.InventoryID = A2.InventoryID
		INNER JOIN AT1301 A1 WITH (NOLOCK) ON A2.InventoryTypeID = A1.InventoryTypeID
		LEFT JOIN OT2101 OT01 WITH (NOLOCK) ON OT01.DivisionID = O1.DivisionID
												AND OT01.QuotationID = O0.InheritVoucherID
	WHERE O1.QuotationNo = O2.QuotationID
	--PRINT @SumQuotationSale

	-- Sum tổng tiền định mức dự án
	SELECT @SumQuoteProject = QuoQuantity
	FROM @QuoteProject
	WHERE OriginName = 'SUM'
	--PRINT @SumQuoteProject

	-- Tính tỷ lệ lợi nhận tạm tính
	INSERT INTO @ReportQuoteProject(Desciption, OriginalAmount, TypeData)
	SELECT N'TỶ LỆ LỢI NHUẬN TẠM TÍNH(%)', (ROUND(@SumQuotationSale - @SumQuoteProject, 0) * 100) / @SumQuoteProject, '5'

	-- Select all dữ liệu
	SELECT * FROM @ReportQuoteProject
END	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

