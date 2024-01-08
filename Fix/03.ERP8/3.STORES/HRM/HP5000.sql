IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







----- Created by Nguyen Van Nhan, Date 26/04/2004.
----- Purpose: Tinh Luong thang

-----Edited by: Vo Thanh Huong
-----Edited date: 19/08/2004
-----purpose: Tính các khoản giảm trừ lương

-----Edited by: Dang Le Bao Quynh
-----Purpose: Thay doi sap xep theo truong MethodID tu bang HT5005,HT5006 phuc vu cho tinh khoan thu nhap tong hop
-----Edit by: Dang Le Bao Quynh; Date:17/07/2006
-----Purpose: Bo sung tinh luong san pham theo phuong phap phan bo
-----Dang Le Bao Quynh; Date: 08/12/2006
-----Purpose: Loc danh sach tinh luong theo chi dinh chi tiet cua phuong phap tinh luong.
--Edit by: Dang Le Bao Quynh; 27/03/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
--Edit by: Dang Le Bao Quynh; 28/03/2013: Xoa tinh luong cong trinh	
---- Modified on 13/11/2013 by Le Thi Thu Hien : Bo sung HP5014
---- Modified on 25/03/2015 by Lê Thị Hạnh: update Salary02: Doanh số bình quân tháng, tính ngày công nghỉ việc [CustomizeIndex: 36 - SGPT]
---- Modified by Tiểu Mai on 03/03/2017: Bổ sung chấm công theo sản phẩm cho Bourbon (CustomizeIndex = 38)
---- Modified by Bao Thy on 30/11/2016: Bo sung 150 khoan thu nhap cho MEIKO
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
---- Modified by Truong Lam on 29/10/2019: Bổ sung bắn dữ liệu Net và KPI phát triển tổ chức (DUCTIN)
---- Modified by Vĩnh Tâm on 08/04/2020: Điều chỉnh công thức tính thưởng KPI doanh số, KPI hoàn thành công việc và lương mềm (DUCTIN)
---- Modified by Vĩnh Tâm on 24/04/2020: Bổ sung xử lý đếm số ngày đi trễ và mức tiền phạt đi trễ (DUCTIN)
---- Modified by Văn Tài  on 09/09/2022: Bổ sung xử lý tính ra tiền Khen thưởng/Kỷ luật.
---- Modified by Nhựt Trường on 10/03/2023: Bổ sung Công thức tính chuuyên cần (Pertima)
---- Modified by Nhựt Trường on 16/06/2023: [2023/06/IS/0175] - Điều chỉnh công thức tính Income109 (Pertima).
---- Modified by Nhựt Trường on 19/06/2023: [2023/06/IS/0174] - Cập nhật lại giá trị Income95 (Pertima).
---- Modified by Kiều Nga on 18/07/2023: [2023/03/IS/0113] Fix lỗi tính tiền chuyên cần bị sai, xin nghỉ phép nhưng phần mềm vẫn tính là đi trễ.

-- <Example>
---- 

CREATE PROCEDURE 	[dbo].[HP5000] 	
					@DivisionID as nvarchar(50),   		---- Don vi tinh luong
					@TranMonth as int, 			---- Ky tinh luong
					@TranYear as int,			---- Nam tinh luong
					@PayrollMethodID as nvarchar(50),	---- PP tinh luong	
					@VoucherDate as Datetime,		---- ngay tinh luong
					@UserID as nvarchar(50),			---- Nguoi tinh luong
					@DepartmentID1 as nvarchar(50),
					@TeamID1 as nvarchar(50),
					@SalaryAmount as decimal(28,8) = 0
						
AS

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP5000_MK @DivisionID,   		---- Don vi tinh luong
					@TranMonth, 			---- Ky tinh luong
					@TranYear,			---- Nam tinh luong
					@PayrollMethodID,	---- PP tinh luong	
					@VoucherDate,		---- ngay tinh luong
					@UserID,			---- Nguoi tinh luong
					@DepartmentID1,
					@TeamID1,
					@SalaryAmount
END
ELSE

	Declare @sSQL as nvarchar(4000),
		@IncomeID as nvarchar(50), 
		@SubID as nvarchar(50), 
		@MethodID as nvarchar(50),  
		@BaseSalaryField as nvarchar(50),  
		@BaseSalary as decimal(28,8),
		@GeneralCoID as nvarchar(50),  
		@GeneralAbsentID as nvarchar(50),  
		@SalaryTotal as decimal(28,8),  
		@AbsentAmount decimal(28,8),
		@Orders as tinyint,
		@HT5005_cur as cursor,
		@HT5006_cur1 as cursor,
		@HT5006_cur2 as cursor,
		@TransactionID as nvarchar(50),
		@HT3400_cur as cursor,
		@EmployeeID as nvarchar(50), 
		@DepartmentID  as nvarchar(50),  
		@TeamID as nvarchar(50) ,
		@CYear as nvarchar(50),
		@IsIncome tinyint, ----1: thu nh?p, 0: các kho?n gi?m tr?
		@SourceFieldName nvarchar(100),
		@IsOtherDayPerMonth as tinyint,
		@SourceTableName nvarchar(50),
		@CurrencyID as nvarchar(50),
		@ExchangeRate decimal(28,8),
		@TableHT2400 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2),
		@CoefficientReward VARCHAR(50) = NULL,
		@CoefficientDiscipline VARCHAR(50) = NULL,
		@sSQL01 AS VARCHAR(MAX)

Set Nocount on
Set  @CYear = LTRIM(str(@TranYear))

--- Tách bảng nghiệp vụ
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

-- Lấy thông tin thiết lập.
-- Hệ số khen thưởng/kỷ luật.
SELECT TOP 1 
	@CoefficientReward = CoefficientReward,
	@CoefficientDiscipline = CoefficientDiscipline
FROM HT0000 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear),
	 	   @TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT @TableHT2400 = 'HT2400'
	SELECT @TableHT2402 = 'HT2402'
END

Delete HT340001_1 Where TransactionID In 
(Select APK From HT3400 
Where 	DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID)	
		
Delete HT3499 Where TransactionID in 
(SELECT TransactionID FROM HT3400 
	WHERE DivisionID = @DivisionID and
		TranMonth = @TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID )

--Xoa tinh luong cong trinh
Delete HT340001 Where TransactionID In 
(Select APK From HT3400 
Where 	DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID)
		
Delete HT3400 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID

DELETE HT3404 Where DivisionID = @DivisionID and
		TranMonth =@TranMonth and 
		TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID = @PayrollMethodID
		
--------->>>>>Edit by: Dang Le Bao Quynh; 27/02/2013: Toi uu lai cau lenh, sinh TransactionID bang NewID()	
----------->>>>>> Customize Cảng sài gòn
IF @CustomerName = 19 AND (@PayrollMethodID LIKE 'PPLKH%' OR @PayrollMethodID LIKE 'PPLSP%')		--- Cảng sài gòn
BEGIN
	IF @PayrollMethodID LIKE 'PPLKH%' --- Nếu là lương khoán chỉ hiển thị những người được check lương khoán
	BEGIN
		Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
			CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
		Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
						@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
		From HT2400
		Left Join HT3400 On
			HT2400.DivisionID = HT3400.DivisionID And
			HT2400.TranYear = HT3400.TranYear And
			HT2400.Tranmonth = HT3400.Tranmonth And
			HT2400.DepartmentID = HT3400.DepartmentID And
			Isnull(HT2400.TeamID,'') = isnull(HT3400.TeamID,'') And
			HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'') = @PayrollMethodID 
		Where 	HT2400.DivisionID =@DivisionID and  HT2400.TranMonth = @TranMonth and HT2400.TranYear =@TranYear and
				HT2400.DepartmentID like @DepartmentID1 and
				IsNull(HT2400.TeamID,'') like IsNull(@TeamID1,'') and
				(HT2400.DepartmentID In (Select DepartmentID From HT5004 Where PayrollMethodID = @PayrollMethodID And IsDetail = 0  And DivisionID = @DivisionID)
	 			Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where PayrollMethodID = @PayrollMethodID  And DivisionID = @DivisionID))
	 			And HT3400.DivisionID Is NULL
	 			AND HT2400.IsJobWage = 1
	END
	IF @PayrollMethodID LIKE 'PPLSP%' --- Nếu là lương sản phẩm chỉ hiển thị những người được check lương sản phẩm
	BEGIN
		Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
						CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)
		Select NewID(), HT2400.EmployeeID, @DivisionID, HT2400.DepartmentID, HT2400.TeamID, @TranMonth, @TranYear, @PayrollMethodID, 
						@UserID, getdate(),@UserID, getdate(), HT2400.IsOtherDayPerMonth
		From HT2400
		Left Join HT3400 On
			HT2400.DivisionID = HT3400.DivisionID And
			HT2400.TranYear = HT3400.TranYear And
			HT2400.Tranmonth = HT3400.Tranmonth And
			HT2400.DepartmentID = HT3400.DepartmentID And
			Isnull(HT2400.TeamID,'') = isnull(HT3400.TeamID,'') And
			HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'') = @PayrollMethodID 
		Where 	HT2400.DivisionID =@DivisionID and  HT2400.TranMonth = @TranMonth and HT2400.TranYear =@TranYear and
				HT2400.DepartmentID like @DepartmentID1 and
				IsNull(HT2400.TeamID,'') like IsNull(@TeamID1,'') and
				(HT2400.DepartmentID In (Select DepartmentID From HT5004 Where PayrollMethodID = @PayrollMethodID And IsDetail = 0  And DivisionID = @DivisionID)
	 			Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where PayrollMethodID = @PayrollMethodID  And DivisionID = @DivisionID))
	 			And HT3400.DivisionID Is NULL
	 			AND HT2400.IsPiecework = 1
	END
END -----------<<<<< Customize Cảng sài gòn	
ELSE 	
BEGIN

	-- Thực hiện bắn doanh số Net và KPIs
	IF @CustomerName = 114
	BEGIN
		-- Bảng quy định thưởng KPIs phát triển tổ chức
		SELECT K2.CompletionRate AS StartRate, ISNULL(MIN(K3.CompletionRate), 1000) AS EndRate, K2.BonusLevelsKPIs
		INTO #KPIsBonus
		FROM KPIT1080 K1
			INNER JOIN KPIT1081 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster
			LEFT JOIN KPIT1081 K3 WITH (NOLOCK) ON K3.APKMaster = K2.APKMaster AND K2.CompletionRate < K3.CompletionRate
		WHERE DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) BETWEEN K1.EffectiveDate AND K1.ExpirationDate
		GROUP BY K2.CompletionRate, K2.BonusLevelsKPIs

		-- Danh sách các Nhân viên được tính lương theo Phòng ban
		SELECT H1.EmployeeID, @DivisionID AS DivisionID, H1.DepartmentID AS DepartmentID, 
			H1.TeamID AS TeamID, @TranMonth AS TranMonth, @TranYear AS TranYear, @PayrollMethodID AS PayrollMethodID,
			H1.IsOtherDayPerMonth
		INTO #UserSalary
		FROM HT2400 H1 WITH (NOLOCK)
		WHERE H1.DivisionID = @DivisionID AND  H1.TranMonth = @TranMonth AND H1.TranYear = @TranYear
			AND H1.DepartmentID LIKE @DepartmentID1 AND ISNULL(H1.TeamID, '') LIKE ISNULL(@TeamID1, '')
			AND (H1.DepartmentID IN (SELECT DepartmentID FROM HT5004 WITH (NOLOCK)
										WHERE DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND IsDetail = 0)
 			OR H1.EmployeeID IN (SELECT EmployeeID FROM HT5040 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID))
		ORDER BY H1.EmployeeID

		-- 24/04/2020 - Vĩnh Tâm - Begin - Bổ sung lấy dữ liệu số ngày đi trễ để tính tiền phạt
		DECLARE @NumberWorkLate INT,
				@PunishLate DECIMAL(28,8) = 0,
				@StartDate VARCHAR(10) = FORMATMESSAGE('%04i-%02i-%02i', @TranYear, @TranMonth, 1)
		DECLARE @EndDate VARCHAR(10) = EOMONTH(@StartDate)

		SELECT @PunishLate = ISNULL(O1.PunishLate, 0)
		FROM OOT0030 O1 WITH (NOLOCK)
		WHERE @StartDate BETWEEN O1.FromDate AND O1.ToDate
			OR @EndDate BETWEEN O1.FromDate AND O1.ToDate
		-- 24/04/2020 - Vĩnh Tâm - End - Bổ sung lấy dữ liệu số ngày đi trễ để tính tiền phạt
		
		-- Copy danh sách User tính lương sang bảng tạm mới để xử lý tính KPI
		SELECT * INTO #UserKPI FROM #UserSalary

		DECLARE @KPIPoint DECIMAL(28, 8)
		-- Bảng tạm để lưu điểm KPI lúc nhận kết quả từ Store trả về
		CREATE TABLE #KPI (KPIPoint DECIMAL(28, 8))
		-- Bảng lưu điểm KPI theo User sau khi tính toán xong, dùng để thực hiện UPDATE dữ liệu
		CREATE TABLE #SalaryData (UserID VARCHAR(50), KPIPoint DECIMAL(28, 8), NumberWorkLate INT)

		WHILE EXISTS (SELECT TOP 1 1 FROM #UserKPI)
		BEGIN
			SELECT @EmployeeID = EmployeeID FROM #UserKPI

			-- Tổng điểm KPI đạt được
			INSERT INTO #KPI (KPIPoint)
			EXEC KPIP30221_DTI @DivisionID = @DivisionID, @AssignedToUserID = @EmployeeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = 3
			SELECT @KPIPoint = KPIPoint FROM #KPI
			DELETE #KPI

			-- Cộng điểm KPI quản lý
			INSERT INTO #KPI (KPIPoint)
			EXEC KPIP30221_DTI @DivisionID = @DivisionID, @AssignedToUserID = @EmployeeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = 7
			SELECT @KPIPoint = @KPIPoint + KPIPoint FROM #KPI
			DELETE #KPI

			-- Trừ điểm phạt Cố tình vi phạm
			INSERT INTO #KPI (KPIPoint)
			EXEC KPIP30223 @DivisionID = @DivisionID, @AssignedToUserID = @EmployeeID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = 3
			SELECT @KPIPoint = @KPIPoint - KPIPoint FROM #KPI
			DELETE #KPI

			EXEC OOP0034 @DivisionID = @DivisionID, @EmployeeID = @EmployeeID, @StartDate = @StartDate, @EndDate = @EndDate, @NumberWorkLate = @NumberWorkLate OUTPUT
	
			-- Đưa dữ liệu vào bảng tạm #SalaryData
			INSERT INTO #SalaryData (UserID, KPIPoint, NumberWorkLate)
			VALUES(@EmployeeID, @KPIPoint, @NumberWorkLate)

			DELETE #UserKPI WHERE EmployeeID = @EmployeeID
		END
		
		-- Hệ số 1: Số lần đi trễ trong tháng
		-- Hệ số 5: tiền thưởng KPI
		-- Hệ số 11: Số tiền phạt đi trễ trong tháng
		UPDATE HT2400
		SET C01 = K1.NumberWorkLate,
			C05 = K2.BonusLevelsKPIs,
			C11 = K1.NumberWorkLate * @PunishLate
		FROM HT2400 H1 WITH (NOLOCK)
			INNER JOIN #SalaryData K1 ON H1.EmployeeID = K1.UserID
			LEFT JOIN #KPIsBonus K2 ON K1.KPIPoint >= K2.StartRate AND K1.KPIPoint < K2.EndRate
		WHERE H1.DivisionID = @DivisionID AND H1.TranMonth = @TranMonth AND H1.TranYear = @TranYear
			AND H1.DepartmentID LIKE @DepartmentID1 AND ISNULL(H1.TeamID, '') LIKE ISNULL(@TeamID1, '')

		-- Nếu Phòng ban đang tính lương là phòng Kinh doanh thì xử lý tính KPI doanh số
		IF EXISTS (SELECT TOP 1 1 FROM AT1102 A1 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DepartmentID = @DepartmentID1 AND SystemFunctionID = 6)
		BEGIN

			-- Lấy ra danh sách các báo giá thỏa điều kiện để tính KPI
			SELECT O1.APK, O1.QuotationID, O1.DivisionID, O1.EmployeeID
			INTO #SaleQuotation
			FROM #UserSalary T1
				INNER JOIN OT2101 O1 WITH (NOLOCK) ON T1.DivisionID = O1.DivisionID AND T1.EmployeeID = O1.EmployeeID
													AND O1.TranMonth = @TranMonth AND O1.TranYear = @TranYear
													AND O1.ClassifyID = 'SALE' -- Báo giá Sale
													AND O1.OrderStatus = 1 -- Báo giá đã được duyệt
													AND O1.QuotationStatus = 3 -- Báo giá có trạng thái Hoàn thành

			UPDATE HT2400 SET C02 = T1.SalesKPI
			FROM HT2400 H1 WITH (NOLOCK)
				INNER JOIN (

				-- KPI doanh số = Tổng tiền dự án / Mốc thưởng KPI doanh số * Mức thưởng KPI doanh số
				-- ConvertedAmount: tiền hàng đã quy đổi theo tỉ giá (đã nhân với số lượng hàng hóa)
				-- SalesKPI đã trừ giá trị PlusSaleCost và DisCountAmount
				SELECT T1.DivisionID, T1.EmployeeID, ROUND((SUM(O2.ConvertedAmount - S1.PlusSaleCost - S1.DisCountAmount) / K1.TargetSalesKPI * K1.BonusSalesKPI),0) AS SalesKPI
				FROM #UserSalary T1
					INNER JOIN #SaleQuotation T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
					-- Không cần kiểm tra trạng thái duyệt detail vì màn hình Duyệt phiếu báo giá Sale không có duyệt detail
					INNER JOIN (SELECT QuotationID, SUM(ConvertedAmount) As ConvertedAmount 
								FROM OT2102 WITH (NOLOCK) 
								GROUP BY QuotationID) O2 ON O2.QuotationID = T2.QuotationID --AND O2.ApproveLevel = O2.ApprovingLevel
					INNER JOIN SOT2062 S1 WITH (NOLOCK) ON S1.APK_OT2101 = T2.APK
					INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON T1.DivisionID = K1.DivisionID AND T1.EmployeeID = K1.EmployeeID
				-- Chỉ lấy thông tin của những Nhân viên có thiết lập thưởng KPI doanh số
				WHERE ISNULL(K1.BonusSalesKPI, 0) > 0 AND ISNULL(K1.TargetSalesKPI, 0) > 0
				GROUP BY T1.DivisionID, T1.EmployeeID, K1.TargetSalesKPI, K1.BonusSalesKPI--, S1.PlusSaleCost, S1.DisCountAmount
				) T1 ON T1.DivisionID = H1.DivisionID AND T1.EmployeeID = H1.EmployeeID

			WHERE H1.DivisionID = @DivisionID AND H1.TranMonth = @TranMonth AND H1.TranYear = @TranYear
				AND H1.DepartmentID LIKE @DepartmentID1 AND ISNULL(H1.TeamID, '') LIKE ISNULL(@TeamID1, '')

			-- Cập nhật cờ cho biết Phiếu báo giá đã được dùng để tính KPI
			UPDATE OT2101 SET IsPayroll = 1
			FROM OT2101 O1 WITH (NOLOCK)
				INNER JOIN #SaleQuotation T1 WITH (NOLOCK) ON O1.APK = T1.APK
		END

		-- Hệ số 3: Lương mềm nhận trong tháng
		UPDATE HT2400
		SET C03 = K1.ActualEffectiveSalary
		FROM #UserSalary T1
			INNER JOIN HT2400 H1 WITH (NOLOCK) ON T1.EmployeeID = H1.EmployeeID AND T1.DivisionID = H1.DivisionID
			INNER JOIN KPIT2040 K1 WITH (NOLOCK) ON T1.EmployeeID = K1.EmployeeID AND T1.DivisionID = K1.DivisionID
		WHERE ISNULL(K1.IsGetEffectiveSalary, 0) = 1

	END
	-- Kết thúc Customize DTI - 114

	SET @sSQL = N'
		Select	NewID() AS TransactionID, HT2400.EmployeeID, '''+@DivisionID+''' AS DivisionID, HT2400.DepartmentID AS DepartmentID, 
				HT2400.TeamID AS TeamID, '+STR(@TranMonth)+' AS TranMonth, '+STR(@TranYear)+' AS TranYear, '''+@PayrollMethodID+''' AS PayrollMethodID, 
				'''+@UserID+''' AS CreateUserID, getdate() AS CreateDate, '''+@UserID+''' AS LastModifyUserID, getdate() AS LastModifyDate, 
				HT2400.IsOtherDayPerMonth
		INTO #HP5000_HT3400
		From '+@TableHT2400+' HT2400
		Left Join HT3400 On
			HT2400.DivisionID = HT3400.DivisionID And
			HT2400.TranYear = HT3400.TranYear And
			HT2400.Tranmonth = HT3400.Tranmonth And
			HT2400.DepartmentID = HT3400.DepartmentID And
			Isnull(HT2400.TeamID,'''') = isnull(HT3400.TeamID,'''') And
			HT2400.EmployeeID = HT3400.EmployeeID And isnull(HT3400.PayrollMethodID,'''') = '''+@PayrollMethodID+''' 
		Where 	HT2400.DivisionID = '''+@DivisionID+''' and  HT2400.TranMonth = '+STR(@TranMonth)+' and HT2400.TranYear = '+STR(@TranYear)+' and
				HT2400.DepartmentID like '''+@DepartmentID1+''' and
				IsNull(HT2400.TeamID,'''') like IsNull('''+@TeamID1+''','''') and
				(HT2400.DepartmentID In (Select DepartmentID 
										From HT5004 Where DivisionID = '''+@DivisionID+''' And PayrollMethodID = '''+@PayrollMethodID+''' And IsDetail = 0)
 				Or HT2400.EmployeeID In (Select EmployeeID From HT5040 Where DivisionID = '''+@DivisionID+''' And PayrollMethodID = '''+@PayrollMethodID+'''))
 				And HT3400.DivisionID Is Null	
				 -- And HT2400.EmployeeID between  ''NTVN0021'' and ''NTVN0021''
				 --and HT2400.DepartmentID like ''P000000''

		Insert Into HT3400 (TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
					CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth)		
		Select TransactionID,EmployeeID, DivisionID, DepartmentID,TeamID, TranMonth ,  TranYear, PayrollMethodID,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsOtherDayPerMonth
		From #HP5000_HT3400'

		SET  @sSQL = @sSQL + N'
			Insert Into HT3499 (TransactionID,EmployeeID, DivisionID, TranMonth , TranYear )
			Select TransactionID, EmployeeID, DivisionID,  TranMonth, TranYear
			From #HP5000_HT3400
			WHERE DivisionID = '''+@DivisionID+'''
			'
		SET  @sSQL = @sSQL + N'DROP TABLE #HP5000_HT3400'
		EXEC(@sSQL)
END

 	
---------------------- Xu ly tung khoan thu nhap 
IF @CustomerName = 19
	BEGIN
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			(Select Top 1 Isnull(TotalAmount,0) From HT9999 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear=@TranYear),
			AbsentAmount, right(IncomeID,2) as Orders, 1 as IsIncome,1			
		From HT5005
		Where HT5005.PayrollMethodID =@PayrollMethodID and HT5005.DivisionID = @DivisionID
		Order by MethodID
	END	 
ELSE
BEGIN
	SET @HT5005_cur = CURSOR SCROLL KEYSET FOR
		Select IncomeID, MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
			SalaryTotal, AbsentAmount, CONVERT(INT,STUFF(IncomeID,1,1,'')) as Orders, 1 as IsIncome,1			
		From HT5005
		Where HT5005.DivisionID = @DivisionID and HT5005.PayrollMethodID =@PayrollMethodID
		Order by MethodID, Orders 
	
	Open @HT5005_cur
	FETCH NEXT FROM @HT5005_cur INTO  @IncomeID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
		 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome,  @ExchangeRate

	WHILE @@FETCH_STATUS = 0
	  BEGIN
		If @AbsentAmount IS NULL
			Set @AbsentAmount = (Select DayPerMonth  From HT0000 where DivisionID = @DivisionID )
			Set 	@SalaryTotal = isnull(@SalaryTotal,0)* @ExchangeRate
			
			IF @CustomerName = 38   -------- BOURBON
			BEGIN
				IF @MethodID = 'P03'
				BEGIN
					Exec HP5016 	@DivisionID, @TranMonth, @TranYear,  
							@PayrollMethodID, 
							@IncomeID,   	--- Ma thu nhap
							@MethodID, 	--- PP tinh luong			
							@Orders,	--- Thu tu
							@IsIncome 
				END
			END

				
			Exec HP5001 	@DivisionID, @TranMonth, @TranYear,  
							@PayrollMethodID, 
							@IncomeID,   	--- Ma thu nhap
							@MethodID, 	--- PP tinh luong
							@BaseSalaryField,  ----- Muc luong co ban lay tu dau
							@BaseSalary, 		---- Muc luong co ban cu the (Chi su dung khi @BaseSalaryField ='Others'), 
							@GeneralCoID, 		---PP Xac dinh he so chung
							@GeneralAbsentID, 	--- PP xac dinh ngay cong tong hop
							@SalaryTotal, 		---- Quy luong chi ap dung trong truong hop la luong khoan
							@AbsentAmount , 	---- So ngay quy dinh (he so chi				

							@Orders,	--- Thu tu
							@IsIncome ,
							@DepartmentID1,
							@TeamID1,
							@ExchangeRate
					
			IF 	@CustomerName = 19	AND @IncomeID = 'I04'
				BEGIN
							----- 	Xac dinh he so chung:	--- Toàn công ty
						EXEC HP5009	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralCoID, @MethodID,
								@BaseSalaryField, @BaseSalary

							---	Xac dinh ngay cong tong hop: --- Toàn công ty
						EXEC HP5008	@DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralAbsentID	
				END

		FETCH NEXT FROM @HT5005_cur INTO  @IncomeID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
		 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome,  @ExchangeRate

	  END
	Close @HT5005_cur
END	
	IF @CustomerName = 19 --- Tinh tổng quỹ lương phân bổ xuống Customize riêng cho Cảng sài gòn
	EXEC HP5014
		@DivisionID,
		@TranMonth,
		@TranYear,
		@PayrollMethodID,
		@SalaryTotal		
-------------------------------------------------------------------------------------------------------

EXEC HP5106 @PayrollMethodID, @TranMonth, @TranYear, @DivisionID,@DepartmentID1,@TeamID1

-----------------------Xu ly tung khoan giam tru ( khong phai tu ket chuyen)
SET @HT5006_cur1 = CURSOR SCROLL KEYSET FOR
	Select HT5006.SubID, IsNull(MethodID,'P01') as MethodID, BaseSalaryField, BaseSalary, GeneralCoID, GeneralAbsentID, 
		IsNull(SalaryTotal,0) as SalaryTotal, AbsentAmount,  CONVERT(INT,STUFF(HT5006.SubID,1,1,'')) as Orders, 0 as IsIncome,
		1
	From HT5006  inner join HT0005  on HT5006.DivisionID = HT0005.DivisionID And HT5006.SubID = HT0005.SubID
	Where HT5006.DivisionID = @DivisionID and HT5006.PayrollMethodID =@PayrollMethodID and IsTranfer = 0
	Order by MethodID, Orders

	Open @HT5006_cur1
	FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate

	WHILE @@FETCH_STATUS = 0
	  BEGIN					
		If @AbsentAmount IS NULL
			Set @AbsentAmount = (Select DayPerMonth  From HT0000 WHERE DivisionID = @DivisionID)
			IF @CustomerName = 38  -------- BOURBON
			BEGIN
				IF @MethodID = 'P03'
				BEGIN
					Exec HP5016 	@DivisionID, @TranMonth, @TranYear,  
							@PayrollMethodID, 
							@SubID,   	--- Ma thu nhap
							@MethodID, 	--- PP tinh luong			
							@Orders,	--- Thu tu
							@IsIncome 
				END
			END
			
			Exec HP5001 	@DivisionID, @TranMonth, @TranYear,  
					@PayrollMethodID, 
					@SubID,   	--- Ma thu nhap
					@MethodID, 	--- PP tinh luong
					@BaseSalaryField,  ----- Muc luong co ban lay tu dau
					@BaseSalary, 		---- Muc luong co ban cu the (Chi su dung khi @BaseSalaryField ='Others'), 
					@GeneralCoID, 		---PP Xac dinh he so chung
					@GeneralAbsentID, 	--- PP xac dinh ngay cong tong hop
					@SalaryTotal, 		---- Quy luong chi ap dung trong truong hop la luong khoan
					@AbsentAmount , 	---- So ngay quy (he so chi				
					@Orders,	--- Thu thu
					@IsIncome,
					@DepartmentID1,
					@TeamID1,
					@ExchangeRate

		FETCH NEXT FROM @HT5006_cur1 INTO  @SubID, @MethodID, @BaseSalaryField, @BaseSalary, @GeneralCoID,
				 @GeneralAbsentID, @SalaryTotal, @AbsentAmount, @Orders, @IsIncome, @ExchangeRate
	  END

	Close @HT5006_cur1


----------------------------Xu ly tung khoan giam tru tu ket chuyen	
SET @HT5006_cur2 = CURSOR SCROLL KEYSET FOR
	Select HT00.SubID, right(HT00.SubID,2) as Orders,  
		SourceFieldName, SourceTableName
	From HT5006 HT00 inner join HT0005 HT01 on HT00.SubID = HT01.SubID and HT00.DivisionID = HT01.DivisionID
			
	Where HT00.PayrollMethodID =@PayrollMethodID and IsTranfer = 1 and HT00.DivisionID = @DivisionID
	Order by Orders
	
	Open @HT5006_cur2 
	FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	
	While @@FETCH_STATUS = 0
	Begin	
		EXEC HP5005   @PayrollMethodID,	@DivisionID,	@TranMonth,	@TranYear,
			@SubID,  	@Orders, 	@SourceFieldName,	@SourceTableName, @DepartmentID1, @TeamID1 --, @CurrencyID

		FETCH NEXT FROM @HT5006_cur2 INTO  @SubID,  @Orders, @SourceFieldName, @SourceTableName
	End

Set Nocount off

----------------------------------Tinh thue thu nhap 
IF exists (Select Top 1 1 From HT2400 
	Where DivisionID = @DivisionID and TranMonth = @TranMonth and 	TranYear = @TranYear and 	Isnull(TaxObjectID, '') <> '') 	

	If @PayrollMethodID='PPY' OR @PayrollMethodID='PPZ'
		EXEC HP5007 @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID, @DepartmentID1, @TeamID1
	Else
		EXEC HP5006 @DivisionID,	@TranMonth,	@TranYear ,	@PayrollMethodID , @DepartmentID1, @TeamID1

-- Nếu KH là SGPT thì update Salary02: Doanh số bình quân tháng, tính ngày công nghỉ việc
IF @CustomerName = 36 
BEGIN
DECLARE @Cur CURSOR,
	    @Salary02 DECIMAL(28,8) = 0
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT HT34.DivisionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HT34.PayRollMethodID,
	   ISNULL(AVG(ISNULL(HT24.Salary01,0)*ISNULL(HT24.C06,0)),0) AS Salary02
FROM HT3400 HT34
LEFT JOIN HT2400 HT24 ON HT24.DivisionID = HT34.DivisionID AND HT24.EmployeeID = HT34.EmployeeID 
AND HT24.DepartmentID = HT34.DepartmentID AND ISNULL(HT24.TeamID,'') = ISNULL(HT34.TeamID,'')
AND HT24.TranMonth = HT34.TranMonth AND HT24.TranYear = HT34.TranYear
LEFT JOIN HT1400 HT14 ON HT14.DivisionID = HT24.DivisionID AND HT14.EmployeeID = HT24.EmployeeID 
AND HT14.DepartmentID = HT24.DepartmentID AND ISNULL(HT14.TeamID,'') = ISNULL(HT24.TeamID,'')
WHERE HT34.DivisionID = @DivisionID AND HT34.PayRollMethodID = @PayrollMethodID AND 
      (HT34.TranYear*12 + HT34.TranMonth) <= (@TranYear*12 + @TranMonth)
      AND ISNULL(HT14.EmployeeStatus,0) = 9
GROUP BY HT34.DivisionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HT34.PayRollMethodID
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID,@EmployeeID,@DepartmentID,@TeamID,@PayrollMethodID,@Salary02
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE HT2400 SET 
		Salary02 = ISNULL(@Salary02,0)
	WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID AND TranYear = @TranYear AND TranMonth = @TranMonth AND DepartmentID = @DepartmentID AND ISNULL(TeamID,'') = ISNULL(@TeamID,'')
FETCH NEXT FROM @Cur INTO @DivisionID,@EmployeeID,@DepartmentID,@TeamID,@PayrollMethodID,@Salary02
END
CLOSE @Cur
END

-- Tiến hành tính giá trị tiền thưởng/kỷ luật trong tháng cho hồ sơ lương.
IF (ISNULL(@CoefficientReward, '') <> '')
BEGIN

	SET @sSQL01 = 'UPDATE HT2400 HT24
		SET 
			HT24.' + @CoefficientReward 
		  + ' = (SELECT ISNULL(SUM(HT06.Value), 0) AS Value 
					FROM HT1406 HT06 WITH (NOLOCK)
					WHERE HT06.DivisionID = @DivisionID
						AND ISNULL(HT06.IsReward, 0) = 1
						AND HT06.EmployeeID = HT24.EmployeeID
						AND YEAR(HT06.AwardDate) = HT24.TranYear,
						AND MONTH(HT06.AwardDate) = HT24.TranMonth
				)
		WHERE HT24.DivisionID = @DivisionID 
				AND HT24.TranYear = ''' + STR(@TranYear) + '''
				AND HT24.TranMonth = ''' + STR(@TranMonth) + '''
				AND HT24.DepartmentID = ''' + @DepartmentID + '''
				AND ISNULL(HT24.TeamID,'') = ''' + ISNULL(@TeamID, '') + '''
	'

	PRINT @sSQL01
	EXEC (@sSQL01)
	
END

IF (ISNULL(@CoefficientDiscipline, '') <> '')
BEGIN

	SET @sSQL01 = 'UPDATE HT2400 HT24
		SET 
			HT24.' + @CoefficientDiscipline 
		  + ' = (SELECT ISNULL(SUM(HT06.Value), 0) AS Value 
					FROM HT1406 HT06 WITH (NOLOCK)
					WHERE HT06.DivisionID = @DivisionID
						AND ISNULL(HT06.IsReward, 0) = 1
						AND HT06.EmployeeID = HT24.EmployeeID
						AND YEAR(HT06.AwardDate) = HT24.TranYear,
						AND MONTH(HT06.AwardDate) = HT24.TranMonth
				)
		WHERE HT24.DivisionID = @DivisionID 
				AND HT24.TranYear = ''' + STR(@TranYear) + '''
				AND HT24.TranMonth = ''' + STR(@TranMonth) + '''
				AND HT24.DepartmentID = ''' + @DepartmentID + '''
				AND ISNULL(HT24.TeamID,'') = ''' + ISNULL(@TeamID, '') + '''
	'

	PRINT @sSQL01
	EXEC (@sSQL01)
END

---- Customzie PERSTIMA
IF (@CustomerName = 155)
BEGIN
	DECLARE @Cur_PE CURSOR,
		    @InLateCount DECIMAL(28,8) = 0,
		    @OutEarlyCount DECIMAL(28,8) = 0,
			@Income01_PE DECIMAL(28,8) = 0,
			@Income52_PE DECIMAL(28,8) = 0,
			@Income53_PE DECIMAL(28,8) = 0,
			@Income109_PE DECIMAL(28,8) = 0,
			@Income110_PE DECIMAL(28,8) = 0,
			@DivisionID_PE NVARCHAR(50),
			@TransactionID_PE NVARCHAR(50),
			@EmployeeID_PE NVARCHAR(50),
			@TranMonth_PE INT,
			@TranYear_PE INT

	SET @Cur_PE = CURSOR SCROLL KEYSET FOR
	SELECT HT3499.DivisionID, HT3499.TransactionID, HT3499.EmployeeID, HT3499.TranMonth, HT3499.TranYear 
	FROM HT3499 WITH(NOLOCK)
	INNER JOIN HT3400 WITH(NOLOCK) ON HT3400.DivisionID = HT3499.DivisionID AND HT3400.TransactionID = HT3499.TransactionID 
	WHERE HT3499.DivisionID = @DivisionID and
		HT3499.TranMonth = @TranMonth and 
		HT3499.TranYear = @TranYear and
		DepartmentID like @DepartmentID1 and
		IsNull(TeamID,'') like IsNull(@TeamID1,'') and
		PayrollMethodID =@PayrollMethodID
	OPEN @Cur_PE
	FETCH NEXT FROM @Cur_PE INTO @DivisionID_PE, @TransactionID_PE, @EmployeeID_PE, @TranMonth_PE, @TranYear_PE
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @InLateCount = (SELECT COUNT(*) FROM (SELECT DISTINCT HT07.AbsentDate FROM HT2407 HT07 WITH (NOLOCK)
											LEFT JOIN HT1020 TT WITH (NOLOCK) ON  TT.DivisionID = HT07.DivisionID AND TT.ShiftID = HT07.ShiftID
											LEFT JOIN OOT2010 OT20 WITH (NOLOCK) ON HT07.DivisionID = OT20.DivisionID 
																				AND OT20.Status = 1 
																				AND OT20.EmployeeID = HT07.EmployeeID
																				AND CONVERT(DATE, HT07.AbsentDate)  -- Dữ liệu ngày trong thời gian xin phép
																					between CONVERT(DATE, OT20.LeaveFromDate) and CONVERT(DATE, OT20.LeaveToDate)
																				 AND -- Dữ liệu ngày chấm công <so sánh> Thời gian xin phép
																				 (
																					CONVERT(DATETIME, HT07.AbsentDate +' '+ TT.BeginTime )
																						between OT20.LeaveFromDate and OT20.LeaveToDate
																					) 
											WHERE HT07.DivisionID = @DivisionID_PE
													AND HT07.EmployeeID = @EmployeeID_PE
													AND HT07.TranMonth = @TranMonth_PE
													AND HT07.TranYear = @TranYear_PE
													AND ISNULL(HT07.InLateMinutes, 0) > 0
													AND OT20.EmployeeID IS NULL 
											) HT07)

		SET @OutEarlyCount = (SELECT COUNT(*) FROM (SELECT DISTINCT HT08.AbsentDate FROM HT2407 HT08 WITH (NOLOCK) 
											WHERE HT08.DivisionID = @DivisionID_PE
													AND HT08.EmployeeID = @EmployeeID_PE
													AND HT08.TranMonth = @TranMonth_PE
													AND HT08.TranYear = @TranYear_PE
													AND ISNULL(HT08.OutEarlyMinutes, 0) > 0
											) HT08)
		
		SELECT @Income01_PE = HT3400.Income01, @Income52_PE = HT3499.Income52, @Income53_PE = HT3499.Income53, @Income110_PE = HT3499.Income110
		FROM HT3499 WITH(NOLOCK) 
		INNER JOIN HT3400 WITH(NOLOCK) ON HT3400.DivisionID = HT3499.DivisionID AND HT3400.TransactionID = HT3499.TransactionID
		WHERE HT3499.TransactionID = @TransactionID_PE

		-- Cập nhật chuyên cần : tiền chuyên cần công thức phức tạp lấy từ nhiều nguồn dữ liệu khác nhau nên không thể thiết kế tính trên pp tính lương, vì vậy nên chỉnh đặc thù riêng khoản thu nhập này sẽ được update riêng theo công thức.
		IF((@Income52_PE >= 6) AND (@InLateCount = 0) AND (@Income53_PE = 0) AND (@Income110_PE <= 1) AND (@Income01_PE < 50000))
		BEGIN
			UPDATE HT3499
			SET Income95 = 200000
			WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF((@Income52_PE >= 6) AND (@InLateCount = 0) AND (@Income53_PE = 0) AND (@Income110_PE <= 1) AND (@Income01_PE >= 100000))
		BEGIN
			UPDATE HT3499
			SET Income95 = 200000
			WHERE TransactionID = @TransactionID_PE
		END
		ELSE
		BEGIN
			UPDATE HT3499
			SET Income95 = 0
			WHERE TransactionID = @TransactionID_PE
		END

		-- C?p nh?t t?ng c?ng
		UPDATE HT3499
			SET Income97 = Income95 + Income97 --- income95 là tiền chuyên cần, gán cứng cách tính, khi tính lươnng bằng công thức trong phần mềm số không có giá trị, 
			---sau khi tính lương xong mới update gtri , nên phải update thêm incom97 = income97 + incom95
			WHERE TransactionID = @TransactionID_PE

		UPDATE HT3499
			SET Income105 = Income105 + Income95 -- tương tự logic income97
			WHERE TransactionID = @TransactionID_PE

		UPDATE HT3499
			SET Income109 = Income109 + Income95  -- tương tự logic income97
			WHERE TransactionID = @TransactionID_PE

		SELECT @Income109_PE = Income109 FROM HT3499 WITH(NOLOCK) WHERE TransactionID = @TransactionID_PE  --- điều kiện tính thuế tncn, income109 lúc này đã được cộng income 95

		-- Nếu Income109 âm thì lấy 0
		IF(@Income109_PE < 0)
		BEGIN
			UPDATE HT3499
			SET Income109 = 0
			WHERE TransactionID = @TransactionID_PE

			SET @Income109_PE = 0
		END
	
		IF (@Income109_PE > 80000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-80000000)*0.35+18150000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF (@Income109_PE > 52000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-52000000)*0.30+9750000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF (@Income109_PE >32000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-32000000)*0.25+4750000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF (@Income109_PE >18000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-18000000)*0.20+1950000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF (@Income109_PE >10000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-10000000)*0.15+750000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE IF (@Income109_PE >5000000)
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE-5000000)*0.10+250000
				WHERE TransactionID = @TransactionID_PE
		END
		ELSE
		BEGIN
			UPDATE HT3499
				SET Income111 = (@Income109_PE)*0.05
				WHERE TransactionID = @TransactionID_PE
		END

		UPDATE HT3499
			SET Income116 = Income116 - Income111 + Income95  
			--- income116 khai báo tính trong phần mềm phải trừ thuế tncn (incom111), incom111 lúc tính trong pp tính lương bị sai vì chưa bao gồm income95(tính xong mới update)
			--- nên phải update incom116 - income11 (thuế tncn vừa đc update bên trên theo công thức riêng)
			--- income116 trong pp tính lương bao gồm incom97, mà lúc tính lương incom97 chưa đượcc cộng incom95 nên phải update incom116 + income95 ( tiền chuyên cần)
			WHERE TransactionID = @TransactionID_PE


	FETCH NEXT FROM @Cur_PE INTO @DivisionID_PE, @TransactionID_PE, @EmployeeID_PE, @TranMonth_PE, @TranYear_PE
	END
	CLOSE @Cur_PE
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
