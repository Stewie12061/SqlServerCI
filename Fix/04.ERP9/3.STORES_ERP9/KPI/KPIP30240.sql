IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30240]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30240]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Quy định giờ công vi phạm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 10/10/2019 by Trường Lãm
-- Modified on 19/06/2021 by Văn Tài: Tính tổng cho TargetsGroupPercentage.
-- Modified on 02/02/2022 by Nhựt Trường: [2023/02/IS/0003] - Điều chỉnh lại điều kiện kiểm tra Quy chuẩn Up&Down đánh giá KPI (bảng KPIT2020).
/* Example:
 EXEC KPIP30240 @DivisionID = 'DTI', @AssignedToUserID = 'D11001', @TranMonth = 4, @TranYear = 2020, @Period = NULL
 */
CREATE PROCEDURE [dbo].[KPIP30240]
(
	@DivisionID VARCHAR(50),
	@AssignedToUserID VARCHAR(50),
	@TranMonth INT = NULL,
	@TranYear INT = NULL,
	@Period VARCHAR(10) = NULL
)
AS
BEGIN
		IF (ISNULL(@TranMonth, '') = '' OR ISNULL(@TranYear, '') = '')
		BEGIN
			SET @TranMonth = CAST(SUBSTRING(@Period, 1, 2) AS INT)
			SET @TranYear = CAST(SUBSTRING(@Period, 4, 4) AS INT)
		END

		-- Tạo biến lưu giá trị tổng
		DECLARE
				@Total1 DECIMAL(28,2) = 0,
				@Total2 DECIMAL(28,2) = 0,
				@Total3 DECIMAL(28,2) = 0,
				@FixedSalary DECIMAL(28,2) = 0,
				@CustomerIndex INT = -1

		-- Create table để chứa store 3 KPI
		DECLARE @KPI AS TABLE (STT VARCHAR(10),
								TargetsID NVARCHAR(250),
								TargetsName NVARCHAR(250),
								Quantity DECIMAL(28,4),
								TargetsGroupPercentage DECIMAL(28,4),
								Total DECIMAL(28,4),
								TypeData VARCHAR(10),
								EmployeeID VARCHAR(50)
		)
		
		-- Lấy Customize Index của khách hàng
		SELECT @CustomerIndex = CustomerName FROM CustomerIndex

		-- Lấy dữ liệu Master
		SELECT '1' AS No, A2.DepartmentName, A1.FullName AS EmployeeName, A1.EmployeeID AS EmployeeID1, K1.TargetSales
			, K2.CompletionRate
			, K1.EffectiveSalary, H3.BaseSalary AS FixedSalary, 
			K2.ActualEffectiveSalary,
			 H1.InSurID AS Content, H1.SRate AS InsurrancePercent
			, H1.BaseSalary AS PremiumRate, (H1.SRate + H1.HRate + H1.TRate)/100 * H1.BaseSalary AS SAmount
			, H2.IncomeTax, CONCAT(@TranMonth, '/', @TranYear) AS Period
		INTO #Master
		FROM AT1103 A1 WITH (NOLOCK)
			LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A1.DepartmentID = A2.DepartmentID
			INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = A1.EmployeeID
			LEFT JOIN HT2400 H3 WITH (NOLOCK) ON H3.EmployeeID = A1.EmployeeID AND H3.TranMonth = @TranMonth AND H3.TranYear = @TranYear
			LEFT JOIN KPIT2040 K2 WITH (NOLOCK) ON K2.EmployeeID = A1.EmployeeID AND K2.TranMonth = @TranMonth AND K2.TranYear = @TranYear
			LEFT JOIN HT2461 H1 WITH (NOLOCK) ON H1.EmployeeID = A1.EmployeeID AND H1.TranMonth = @TranMonth AND H1.TranYear = @TranYear
			LEFT JOIN HT0338 H2 WITH (NOLOCK) ON H2.EmployeeID = A1.EmployeeID AND H2.TranMonth = @TranMonth AND H2.TranYear = @TranYear
		WHERE ISNULL(A1.Disabled, 0) = 0 AND A1.EmployeeID = @AssignedToUserID 
		AND @TranMonth + @TranYear * 100 BETWEEN MONTH(K1.EffectDate) + YEAR(K1.EffectDate) * 100 AND MONTH(K1.ExpiryDate) + YEAR(K1.ExpiryDate) * 100

		-- Lấy lương cơ bản
		SELECT @FixedSalary = FixedSalary FROM #Master
		--PRINT(@FixedSalary)
		
		-- Insert dữ liệu KPI kết quả làm việc
		INSERT INTO @KPI (STT, TargetsName, TypeData) VALUES ('I.', N'Phát triển tổ chức', '1')

		-- Insert dữ liệu KPI kết quả làm việc
		-- Customize xử lý cho Đức Tín
		IF @CustomerIndex = 114
		BEGIN
			INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'
			
			-- Lấy dữ liệu KPI quản lý
			INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '5'
		END
		ELSE
		BEGIN
			INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'
			
			-- Lấy dữ liệu KPI quản lý
			INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '5'
		END
		
		-- Trường hợp có tồn tại KPI quản lý thì update lại cột Số thứ tự và Phân loại (TypeData)
		UPDATE @KPI SET STT = (SELECT COUNT(*) FROM @KPI WHERE TypeData = 1), TypeData = 1 WHERE TypeData = 11

		INSERT INTO @KPI (TargetsName, Total, TypeData)
		SELECT N'Tổng (I)' AS TargetsName, ISNULL(SUM(T1.Total), 0) AS Total, '4' AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 1

		-- Lấy tổng
		SELECT @Total1 = ISNULL(Total, 0) FROM @KPI AS T1 WHERE T1.TypeData = 4
		-- Insert KPI doanh số NET
		INSERT INTO @KPI (STT, TargetsName, TypeData) VALUES ('II.', N'Kết quả kinh doanh', 2)
		INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30222 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'

		-- Tính và insert dữ liệu dòng Tổng tiền Kết quả kinh doanh
		INSERT INTO @KPI (TargetsName, TargetsGroupPercentage, Total, TypeData)
		SELECT N'Tổng (II)' AS TargetsName
			, SUM(ISNULL(T1.TargetsGroupPercentage, 0))  AS TargetsGroupPercentage
			, SUM(ISNULL(T1.TargetsGroupPercentage, 0) * ISNULL(T1.Quantity, 0)) AS Total
			, '5' AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 2

		-- Lấy tổng
		SELECT @Total2 = ISNULL(Total, 0) FROM @KPI AS T1 WHERE T1.TypeData = 5
		
		-- Insert KPI cố tình vi phạm
		INSERT INTO @KPI (STT, TargetsName, TypeData) VALUES ('III.', N'Các vi phạm', 3)

		INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30223 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'

		INSERT INTO @KPI (TargetsName, Total, TypeData)
		SELECT N'Tổng (III)' AS TargetsName, ISNULL(SUM(T1.Quantity* T1.TargetsGroupPercentage), 0) AS Total, '6' AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 3

		-- Lấy các vi phạm
		SELECT @Total3 = ISNULL(Total, 0) FROM @KPI AS T1 WHERE T1.TypeData = 6
		-- Tổng giá trị hoàn thành			 
		INSERT INTO @KPI (TargetsName, Total, TypeData) VALUES (N'Tổng giá trị hoàn thành', (@Total1 / 100 * @FixedSalary) + @Total2 - (@Total3), 7)
		--PRINT(@Total1 + @Total2 - @Total3)
		UPDATE @KPI SET EmployeeID = @AssignedToUserID

		SELECT T1.*, T2.*
		FROM @KPI T1
			INNER JOIN #Master T2 ON T1.EmployeeID = T2.EmployeeID1
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
