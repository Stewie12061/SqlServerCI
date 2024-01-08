IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0546]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0546]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <Param>
---- Tổng hợp lương thời vụ sang dữ liệu tính lương.
-- <Return>
---- 
-- <Reference> HRM/Nghiep vu/ Tinh luong (PLUGIN NQH)
---- Bang phan ca
-- <History>
---- Modified [Văn Tài] on 22/12/2020: Update sang bảng HT3400.
---- Modified [Văn Tài] on 28/12/2020: Bổ sung cập nhật cờ Đã tổng hợp và cột SectionID vào bảng HT3400.
---- Modified [Văn Tài] on 22/02/2021: Điều chỉnh kiểm tra tồn tại trong bảng HT3400 thay vì HTT3400.
-- <Example>
---- EXEC HP0546 'NQH', 12, 2020, 'A000000','E000000','P05', 'aaa', 'bbbb'
CREATE PROCEDURE HP0546
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@TransferDate DATETIME,
	@FromTeamID NVARCHAR(50),
	@ToTeamID NVARCHAR(50),
	@SectionID NVARCHAR(50)
)
AS
DECLARE @SQL VARCHAR(MAX) = '',
		@CurSectionID VARCHAR(50) = '',
		@CurDepartmentID VARCHAR(50) = '',
		@CurTeamID VARCHAR(50) = '',
		@CurEmployeeID VARCHAR(50) = '',
		@CurEmployeeName NVARCHAR(100) = '',
		@TotalSalary DECIMAL(18, 8) = 0

-- Cập nhật bộ dữ liệu trước khi tổng hợp sang tính lương.
UPDATE HT0537 
SET IsCalculated = 1
WHERE DivisionID = @DivisionID
	AND TranYear = @TranYear
	AND TranMonth = @TranMonth
	AND [Date] <= @TransferDate
	AND TeamID BETWEEN @FromTeamID AND @ToTeamID
	AND SectionID LIKE @SectionID

-- Lấy danh sách dữ liệu cần tổng hợp sang tính lương theo điều kiện.
SELECT *
INTO #HP0546
FROM HT0537 HT37 WITH (NOLOCK)
WHERE HT37.DivisionID = @DivisionID
	AND HT37.TranYear = @TranYear
	AND HT37.TranMonth = @TranMonth
	AND HT37.[Date] <= @TransferDate
	AND HT37.TeamID BETWEEN @FromTeamID AND @ToTeamID
	AND HT37.SectionID LIKE @SectionID
	AND ISNULL(HT37.IsCalculated, 0) = 1

-- Group dữ liệu theo SectionID
SELECT DISTINCT SectionID AS SectionID
INTO #Section
FROM #HP0546
ORDER BY SectionID

-- Chạy từng SectionID
WHILE (EXISTS(SELECT TOP 1 1 FROM #Section))
BEGIN
	
	-- Chuyền
	SET @CurSectionID = (SELECT TOP 1 SectionID FROM #Section)

	-- Bộ phận
	SET @CurTeamID = (SELECT TOP 1 ReAnaID FROM AT1011 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND AnaID = @CurSectionID)

	-- Phân xưởng: OFFICE/FACTORY.
	SET @CurDepartmentID = (SELECT TOP 1 ReAnaID FROM AT1011 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND AnaID = @CurTeamID)

	-- Thông tin nhân viên
	--- Mã nhân viên theo Path [TeamID].[SectionID].PartTime
	SET @CurEmployeeID = CONVERT(VARCHAR(50), @CurSectionID) + '.PARTTIME';
	--SET @CurEmployeeName = (SELECT TOP 1 FullName FROM HV1400 WHERE EmployeeID = @CurEmployeeID);

	-- Tổng thu nhập
	SET @TotalSalary = (SELECT SUM(TotalSalary) 
						FROM #HP0546 HT37 
						WHERE HT37.SectionID = @CurSectionID
						GROUP BY SectionID)

	-- Nếu tồn tại tính lương rồi sẽ thực hiện update.
	IF(NOT EXISTS(
					SELECT TOP 1 1 
					FROM [HT3400] WITH (NOLOCK) 
					WHERE DivisionID = @DivisionID
							AND TranYear = @TranYear
							AND TranMonth = @TranMonth
							AND EmployeeID = @CurEmployeeID
					)
	)
	BEGIN

		INSERT INTO [dbo].[HT3400]
			   ([TransactionID]
			   ,[EmployeeID]
			   ,[DivisionID]
			   ,[TranMonth]
			   ,[TranYear]
			   ,[DepartmentID]
			   ,[TeamID]
			   ,[SectionID]
			   ,[Income30]                                 
			   ,[CreateDate]
			   ,[LastModifyUserID]
			   ,[LastModifyDate]
			   ,[CreateUserID]
			   ,[PayRollMethodID]
			   )
		 SELECT NEWID() AS TransactionID
				, @CurEmployeeID
				, @DivisionID
				, @TranMonth
				, @TranYear
				, @CurDepartmentID
				, @CurTeamID
				, @CurSectionID
				, @TotalSalary			
				, GETDATE()
				, @UserID
				, GETDATE()
				, @UserID
				, '%'
	END
	ELSE
	BEGIN

		-- Cập nhật Tổng thu nhập và ngày thay đổi.
		UPDATE [HT3400]
		SET		
			[Income30] = @TotalSalary			
			,[LastModifyUserID] = @UserID
			,[LastModifyDate] = GETDATE()
		WHERE
			DivisionID = @DivisionID
				AND TranYear = @TranYear
				AND TranMonth = @TranMonth
				AND EmployeeID = @CurEmployeeID
			
	END

	DELETE #Section WHERE SectionID = @CurSectionID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
