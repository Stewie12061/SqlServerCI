IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2147]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2147]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















-- <Summary>
---- Báo cáo định mức dự án - Dữ liệu định mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 31/10/2019 by Đình Ly
----Modified on 24/03/2020 by Vĩnh Tâm: Fix lỗi các Mã phân tích hiển thị nhiều lần trên Định mức dự án
-- <Example> Exec OOP2147 @DivisionID='DTI', @ProjectID = 'CH.00000007'

CREATE PROCEDURE [dbo].[OOP2147]
(
	@DivisionID VARCHAR(50),
	@ProjectID VARCHAR(50)
)
AS
BEGIN
	-- Create bảng tạm chứa dữ liệu báo cáo định mức dự án (KẾ HOẠCH CUNG ỨNG)
	DECLARE @SupplyPlan AS TABLE (
		STT VARCHAR(10),
		CostGroupDetailID VARCHAR(50),
		CostGroupDetailName NVARCHAR(250),
		QuotaMoney DECIMAL(28, 8), 
		ActualMoney DECIMAL(28, 8),
		Classify NVARCHAR(50),
		Groups NVARCHAR(50),
		TypeData INT)

	DECLARE @RoseCharge DECIMAL(28, 8),
			@RoseCharges DECIMAL(28, 8)

	---- NỘI CHÍNH ----
	-- Insert dữ liệu group loại mặt hàng của phiếu báo giá vào detail của Group A.NỘI CHÍNH -> 1.Hàng nhập khẩu
	INSERT INTO @SupplyPlan (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT '+' AS STT, A1.AnaID, A1.AnaName, O2.Money, O2.ActualMoney, N'1 Hàng nhập khẩu', N'NỘI CHÍNH'
	FROM OOT2140 O1 WITH (NOLOCK)
		INNER JOIN OOT2141 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O2.CostGroupDetail
	WHERE O1.ProjectID = @ProjectID AND O2.CostGroupDetail = 'HH'

	-- Get dữ liệu định mức detail của Group A.NỘI CHÍNH -> 1.Hàng nhập khẩu
	INSERT INTO @SupplyPlan (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT '+' AS STT, A1.AnaID, A1.AnaName, O1.Money, O1.ActualMoney, N'1 Hàng nhập khẩu', N'NỘI CHÍNH'
	FROM OOT2141 O1 WITH (NOLOCK)
		INNER JOIN OOT2140 O0 WITH (NOLOCK) ON O0.APK = O1.APKMaster
		INNER JOIN CMNT0011 C1 WITH (NOLOCK) ON O1.CostGroupDetail = C1.Value
		INNER JOIN CMNT0010 C0 WITH (NOLOCK) ON C0.APK = C1.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O1.CostGroupDetail
	WHERE O0.ProjectID = @ProjectID AND C0.ScreenID = 'SOF2061A'


	---- KẾ HOẠCH CUNG ỨNG ----
	-- Get dữ liệu định mức detail của A.KẾ HOẠCH CUNG ỨNG -> 2.Thầu phụ
	INSERT INTO @SupplyPlan (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT '+' AS STT, A1.AnaId, A1.AnaName, O1.Money, O1.ActualMoney, N'2 Thầu phụ', N'KẾ HOẠCH CUNG ỨNG'
	FROM OOT2141 O1 WITH (NOLOCK)
		INNER JOIN OOT2140 O0 WITH (NOLOCK) ON O0.APK = O1.APKMaster
		INNER JOIN CMNT0011 C1 WITH (NOLOCK) ON O1.CostGroupDetail = C1.Value
		INNER JOIN CMNT0010 C0 WITH (NOLOCK) ON C0.APK = C1.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O1.CostGroupDetail
	WHERE C0.ScreenID = 'SOF2061C' AND O0.ProjectID = @ProjectID

	-- Insert dữ liệu group loại mặt hàng của phiếu báo giá
	INSERT INTO @SupplyPlan (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT '+' AS STT, A1.AnaId, A1.AnaName, O2.Money, O2.ActualMoney, N'2 Thầu phụ', N'KẾ HOẠCH CUNG ỨNG'
	FROM OOT2140 O1 WITH (NOLOCK)
		INNER JOIN OOT2141 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O2.CostGroupDetail
	WHERE O1.ProjectID = @ProjectID
		AND NOT EXISTS (SELECT TOP 1 1 FROM CMNT0011 C1 WITH (NOLOCK) WHERE O2.CostGroupDetail = C1.Value)
		AND O2.CostGroupDetail != 'HH'

	-- Get detail KẾ HOẠCH CUNG ỨNG vào bảng tạm
	SELECT Classify, SUM(QuotaMoney) QuotaMoney, SUM(ActualMoney) ActualMoney INTO #DetailSupplyPlan
	FROM @SupplyPlan
	GROUP BY Classify
	-- Insert detail KẾ HOẠCH CUNG ỨNG vào bảng tạm
	INSERT INTO @SupplyPlan(STT, CostGroupDetailName, QuotaMoney, ActualMoney, Classify)
	SELECT ROW_NUMBER() OVER (ORDER BY Classify) STT, Classify, QuotaMoney, ActualMoney, Classify
	FROM #DetailSupplyPlan

	-- Get group KẾ HOẠCH CUNG ỨNG vào bảng tạm
	SELECT Groups, Classify, SUM(QuotaMoney) QuotaMoney, SUM(ActualMoney) ActualMoney INTO #GroupSupplyPlan
	FROM @SupplyPlan
	WHERE Groups IS NOT NULL
	GROUP BY Groups, Classify

	-- Insert group NỘI CHÍNH và KẾ HOẠCH CUNG ỨNG vào bảng tạm 
	INSERT INTO @SupplyPlan(STT, CostGroupDetailName, QuotaMoney, ActualMoney, Groups, Classify)
	SELECT IIF(ROW_NUMBER() OVER (ORDER BY Classify) = '1', 'A', 'B') AS STT, Groups, QuotaMoney, ActualMoney, 'GROUP', ROW_NUMBER() OVER (ORDER BY Classify)
	FROM #GroupSupplyPlan


	---- KINH DOANH TIẾP THỊ ----
	-- Create bảng tạm chứa dữ liệu báo cáo định mức dự án (KINH DOANH TIẾP THỊ)
	DECLARE @MarketingBusiness AS TABLE (
		STT VARCHAR(10),
		CostGroupDetailID VARCHAR(50),
		CostGroupDetailName NVARCHAR(250),
		QuotaMoney DECIMAL(28, 8), 
		ActualMoney DECIMAL(28, 8),
		Classify NVARCHAR(50),
		Groups NVARCHAR(50), 
		TypeData INT)

	-- Get dữ liệu định mức detail của Group B.KINH DOANH TIẾP THỊ
	INSERT INTO @MarketingBusiness (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT '+' AS STT, A1.AnaID, A1.AnaName, O1.Money, O1.ActualMoney, '3 Kinh doanh', N'KINH DOANH TIẾP THỊ'
	FROM OOT2141 O1 WITH (NOLOCK)
		INNER JOIN OOT2140 O0 WITH (NOLOCK) ON O0.APK = O1.APKMaster
		INNER JOIN CMNT0011 C1 WITH (NOLOCK) ON O1.CostGroupDetail = C1.Value
		INNER JOIN CMNT0010 C0 WITH (NOLOCK) ON C0.APK = C1.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O1.CostGroupDetail
	WHERE C0.ScreenID = 'SOF2061B' AND O0.ProjectID = @ProjectID

	SELECT @RoseCharge = ISNULL(O1.ActualMoney, 0)
	FROM OOT2141 O1 WITH (NOLOCK)
		INNER JOIN OOT2140 O0 WITH (NOLOCK) ON O0.APK = O1.APKMaster
		INNER JOIN CMNT0011 C1 WITH (NOLOCK) ON O1.CostGroupDetail = C1.Value
		INNER JOIN CMNT0010 C0 WITH (NOLOCK) ON C0.APK = C1.APKMaster
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = 'A04' AND A1.AnaID = O1.CostGroupDetail
	WHERE C0.ScreenID = 'SOF2061B' AND O0.ProjectID = @ProjectID AND O1.CostGroupDetail = 'THH'

	-- Get group KINH DOANH TIẾP THỊ vào bảng tạm 
	SELECT Groups, Classify, (SUM(QuotaMoney) - @RoseCharge) AS QuotaMoney, (SUM(ActualMoney) - @RoseCharge) AS ActualMoney INTO #GroupBusiness
	FROM @MarketingBusiness
	GROUP BY Groups, Classify
	-- Insert group KINH DOANH TIẾP THỊ vào bảng tạm
	INSERT INTO @MarketingBusiness(STT, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups)
	SELECT 'C' AS STT, Groups, QuotaMoney, ActualMoney, Classify, 'GROUP'
	FROM #GroupBusiness

	-- Union 2 bảng lại với nhau bằng cách Insert bảng thứ 2 vào bảng thứ 1 
	INSERT INTO @SupplyPlan (STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups, TypeData)
	SELECT * FROM @MarketingBusiness

	-- Tổng định mức
	INSERT INTO @SupplyPlan (CostGroupDetailName, QuotaMoney, ActualMoney, Classify)
	SELECT N'Tổng chi phí', SUM(QuotaMoney), SUM(ActualMoney), 'SUM'
	FROM @SupplyPlan
	WHERE Groups IN ('GROUP')

	-- Update type cho bảng
	UPDATE @SupplyPlan SET TypeData = '1'

	-- Select all data
	SELECT STT, CostGroupDetailID, CostGroupDetailName, QuotaMoney, ActualMoney, Classify, Groups, TypeData
	FROM @SupplyPlan
	ORDER BY Classify ASC, STT DESC
END


















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
