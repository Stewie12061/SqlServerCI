IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30220]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30220]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Modified by Huỳnh Thử on 28/07/2020 : Chuyển về Store KPIP30240 (báo cáo đánh giá KPIs) -- Dashboard
CREATE PROCEDURE [dbo].[KPIP30220]
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

		-- Create table để chứa store 3 KPI
		DECLARE @KPI AS TABLE (STT VARCHAR(10),
								TargetsName NVARCHAR(250),
								Quantity DECIMAL(28,8),
								TargetsGroupPercentage DECIMAL(28,8),
								Total DECIMAL(28,8),
								TypeData VARCHAR(10),
								EmployeeID VARCHAR(50)
		)

		DECLARE @CustomerIndex INT = -1
		SELECT @CustomerIndex = CustomerName FROM CustomerIndex
		
		IF @CustomerIndex = 114 
		BEGIN 
			exec KPIP30240 @DivisionID,@AssignedToUserID,@TranMonth,@TranYear
		END 
		ELSE
		BEGIN
			-- Lấy dữ liệu Master
		SELECT '1' AS No, A2.DepartmentName, A1.FullName AS EmployeeName, A1.EmployeeID, K1.TargetSales, CONCAT(@TranMonth, '/', @TranYear) AS Period
		INTO #Master
		FROM AT1103 A1 WITH (NOLOCK)
			LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A1.DepartmentID = A2.DepartmentID
			INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = A1.EmployeeID
		WHERE ISNULL(A1.Disabled, 0) = 0 AND A1.EmployeeID = @AssignedToUserID

		-- Insert dữ liệu KPI kết quả làm việc
		INSERT INTO @KPI (STT, TargetsName) VALUES ('I.', N'Kết quả làm việc')

		-- Customize xử lý cho Đức Tín
		IF @CustomerIndex = 114
		BEGIN
			INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '2'

			INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '6'
		END
		ELSE
		BEGIN
			INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '2'

			INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
			EXEC KPIP30221 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '6'
		END
		
		INSERT INTO @KPI (TargetsName, Total, TypeData)
		SELECT N'Tổng (I)' AS TargetsName, ISNULL(SUM(T1.Total), 0) AS Total, 11 AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 1
		
		-- Insert KPI doanh số NET
		INSERT INTO @KPI (STT, TargetsName) VALUES ('II.', N'Kết quả kinh doanh')

		INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30222 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '2'
		
		INSERT INTO @KPI (TargetsName, Total, TypeData)
		SELECT N'Tổng (II)' AS TargetsName, ISNULL(SUM(T1.Total), 0) AS Total, 12 AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 2
		
		-- Insert KPI cố tình vi phạm
		INSERT INTO @KPI (STT, TargetsName) VALUES ('III.', N'Các vi phạm')

		INSERT INTO @KPI (STT, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30223 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '2'
		
		INSERT INTO @KPI (TargetsName, Total, TypeData)
		SELECT N'Tổng (III)' AS TargetsName, ISNULL(SUM(T1.Total), 0) AS Total, 13 AS TypeData
		FROM @KPI AS T1
		WHERE T1.TypeData = 3

		UPDATE @KPI SET EmployeeID = @AssignedToUserID

		SELECT T1.*, T2.*
		FROM @KPI T1
			INNER JOIN #Master T2 ON T1.EmployeeID = T2.EmployeeID

		--SELECT *
		--FROM #Master
		END
END










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
