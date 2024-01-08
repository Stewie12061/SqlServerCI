IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2019_GREE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2019_GREE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Trả ra số cấp xét duyệt và người duyệt từng cấp + người duyệt mặc định
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 12/01/2023 by Thanh Lượng

-- <Example>
---- 
/*
	OOP2019_GREE @DivisionID='NTY', @EmployeeID = NULL,@TypeID='QDTD', @LeaveToDate = NULL,@Amount = NULL, @AbsentTypeID = NULL, @DepartmentID = '04'
*/

CREATE PROCEDURE dbo.OOP2019_GREE
(	
	@DivisionID VARCHAR(50),
	@EmployeeID VARCHAR(50),
	@TypeID VARCHAR(50),
	@LeaveToDate DATETIME,
	@Amount DECIMAL(28,8),
	@AbsentTypeID VARCHAR(50) = '',
	@DepartmentID VARCHAR(50) = '',
	@ShiftID VARCHAR(50) = ''
)
AS
DECLARE @SQL VARCHAR(MAX),
		@ConditionTypeID VARCHAR(50),	-- loại điều kiện xét duyệt: Loại phép, Phòng ban, Ca làm việc
		@DataTypeID INT,--- CÁCH LẤY DỮ LIỆU
		@Levels INT,	--- SỐ CẤP DUYỆT THEO THIẾT LẬP
		@ActualLevels INT,	--- SỐ CẤP DUYỆT THỰC TẾ DỰA TRÊN ĐIỀU KIỆN
		@IsAppCondition TINYINT,	--- có xét duyệt theo điều kiện không
		@DirectionTypeID TINYINT,	--- 0: duyệt từ dưới lên theo SĐTC, 1: duyệt từ trên xuống theo SĐTC
		@ActualAmount DECIMAL(28,8),	--- số ngày phép đã nghỉ trong tháng/năm/...
		@TimeConvert INT,
		@SameLevels INT

--- Nếu là nhân viên cấp cao nhất trong sơ đồ tổ chức thì đơn không cần xét duyệt nữa, mặc định trạng thái được duyệt
IF @TypeID = 'DXP' AND EXISTS (SELECT 1 FROM HT1403 WITH (NOLOCK)
								LEFT JOIN AT1102 WITH (NOLOCK) ON HT1403.DepartmentID = AT1102.DepartmentID
								WHERE HT1403.DivisionID = @DivisionID
								AND HT1403.EmployeeID = @EmployeeID
								AND AT1102.ContactPerson = @EmployeeID)
BEGIN
	SELECT 1 AS Status, 0 AS Levels
	SELECT NULL AS LevelNo, NULL AS ApproveID
	return
END

SELECT @TimeConvert = Isnull(TimeConvert,0) FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

--- Lấy loại điều kiện xét duyệt (LP:Loại phép, PB:Phòng ban, CLV:Ca làm việc)
SELECT TOP 1 @ConditionTypeID = ISNULL(ConditionTypeID,'')
FROM ST0010 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TypeID = @TypeID

--- Lấy cách lấy dữ liệu trong thiết lập (theo ngày/tháng/năm)
IF EXISTS (SELECT TOP 1 1
FROM ST0010 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TypeID = @TypeID
AND ISNULL(ID,'') = (CASE @ConditionTypeID WHEN 'LP' THEN @AbsentTypeID WHEN 'CLV' THEN @ShiftID WHEN 'PB' THEN @DepartmentID ELSE '' END))
	SELECT TOP 1 @IsAppCondition = IsAppCondition, @DataTypeID = DataTypeID, @Levels = Levels, @DirectionTypeID = DirectionTypeID,@SameLevels = SameLevels
	FROM ST0010 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND TypeID = @TypeID
	AND ISNULL(ID,'') = (CASE @ConditionTypeID WHEN 'LP' THEN @AbsentTypeID WHEN 'CLV' THEN @ShiftID WHEN 'PB' THEN @DepartmentID ELSE '' END)
ELSE 
	SELECT TOP 1 @IsAppCondition = 0, @DataTypeID = DataTypeID, @Levels = Levels, @DirectionTypeID = DirectionTypeID, @SameLevels = SameLevels
	FROM ST0010 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND TypeID = @TypeID

IF ISNULL(@IsAppCondition,0) <> 0	--- có xét duyệt theo điều kiện
BEGIN
	IF @TypeID = 'DXP'	--- Đơn xin phép
	BEGIN
		--- lấy tổng ngày nghỉ phép theo chứng từ/tháng/năm tùy theo cách lấy dữ liệu đã thiết lập xét duyệt
		IF @DataTypeID = 0	--- theo ngày
		BEGIN
			SET @ActualAmount = @Amount
		END
		ELSE IF @DataTypeID = 1	--- theo tháng
		BEGIN
			SELECT @ActualAmount = SUM(CASE WHEN HT1013.UnitID = 'H' THEN ISNULL((HT2401.AbsentAmount/@TimeConvert),0) ELSE ISNULL(HT2401.AbsentAmount,0) END)
			FROM HT2401 WITH (NOLOCK)
			LEFT JOIN HT1013 WITH (NOLOCK) ON HT2401.DivisionID = HT1013.DivisionID AND HT2401.AbsentTypeID = HT1013.AbsentTypeID
			WHERE HT2401.DivisionID = @DivisionID AND HT2401.EmployeeID = @EmployeeID AND HT2401.TranMonth = MONTH(@LeaveToDate) AND HT2401.TranYear = YEAR(@LeaveToDate)
			AND ParentID IN (SELECT AbsentTypeID FROM HT1013 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TypeID = 'P' And IsMonth = 1 AND IsAnnualLeave = 1)

			SELECT @ActualAmount = ISNULL(@ActualAmount,0) + ISNULL(@Amount,0)
		END
		ELSE IF @DataTypeID = 2	--- theo năm
		BEGIN
			SELECT @ActualAmount = SUM(CASE WHEN HT1013.UnitID = 'H' THEN ISNULL((HT2401.AbsentAmount/@TimeConvert),0) ELSE ISNULL(HT2401.AbsentAmount,0) END)
			FROM HT2401 WITH (NOLOCK)
			LEFT JOIN HT1013 WITH (NOLOCK) ON HT2401.DivisionID = HT1013.DivisionID AND HT2401.AbsentTypeID = HT1013.AbsentTypeID
			WHERE HT2401.DivisionID = @DivisionID AND HT2401.EmployeeID = @EmployeeID AND HT2401.TranYear = YEAR(@LeaveToDate)
			AND ParentID IN (SELECT AbsentTypeID FROM HT1013 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TypeID = 'P' And IsMonth = 1 AND IsAnnualLeave = 1)

			SELECT @ActualAmount = ISNULL(@ActualAmount,0) + ISNULL(@Amount,0)
		END
	END

	--- lấy các cấp xét duyệt cho trường hợp này
	--- bổ sung hàm CAST để chuyển đổi giá trị cho phù hợp
	SELECT LevelNo, DepartmentID, Levels,SameLevels,ApproveTypeID1
	INTO #LevelList
	FROM ST0010 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND TypeID = @TypeID
	AND ISNULL(ID,'') = (CASE @ConditionTypeID WHEN 'LP' THEN @AbsentTypeID WHEN 'CLV' THEN @ShiftID WHEN 'PB' THEN @DepartmentID ELSE '' END)
	AND ((ISNULL(@ActualAmount,0) >=
	     CASE WHEN ISNULL(CAST(ConditionTo as decimal(28,8)),0) = -1 
										THEN ISNULL(@ActualAmount,0) 
										ELSE ISNULL(CAST(ConditionTo as decimal(28,8)),0) 
									 END 
	AND ISNULL(@ActualAmount,0) >= ISNULL(ConditionFrom,0) )
	OR(ISNULL(@ActualAmount,0) BETWEEN ISNULL(CAST(ConditionFrom as decimal(28,8)),0) 
	AND CASE WHEN ISNULL(CAST(ConditionTo as decimal(28,8)),0) = -1 
			THEN ISNULL(@ActualAmount,0) 
			ELSE ISNULL(CAST(ConditionTo as decimal(28,8)),0) 
		END))
		ORDER BY LevelNo
	SET @ActualLevels = -1
END
ELSE	--- Không xét duyệt theo điều kiện
BEGIN
	SET @ActualLevels = @Levels
END

IF OBJECT_ID('tempdb..#Approve') IS NOT NULL DROP TABLE #Approve
CREATE TABLE #Approve (Levels INT, LevelNo INT, ApproveID VARCHAR(50),SameLevels INT,ApproveTypeID1  VARCHAR(50))

IF @ActualLevels >= 0
BEGIN
	--- Lấy các cấp duyệt trong sơ đồ tổ chức
	DECLARE @DepartmentID1 VARCHAR(50),
			@ApproveID VARCHAR(50),
			@Orders TINYINT

	SET @Orders = 0

	IF @TypeID = 'BPC'	--- bảng phân ca
	BEGIN
		--- Insert thông tin duyệt bảng phân ca cho bảng tạm OOT2099 dùng khi import
		SET @SQL = '
		INSERT OOT2099 (DepartmentID, Levels, LevelNo, ApproveID)
		SELECT DepartmentID, COUNT(*) OVER () AS Levels, LevelNo, ManagerID AS ApproveID
		FROM
		(
			SELECT *
			FROM dbo.[GetManagerList] (''' + @DivisionID + ''', ''' + @EmployeeID + ''', ' + LTRIM(@DirectionTypeID) + ', ''' + @DepartmentID + ''')
			WHERE LevelNo <= ' + LTRIM(@ActualLevels) + '
		) A'

		EXEC (@SQL)
	END		 
	
	IF @TypeID = 'KHTD'	--- Kế hoạch tuyển dụng
	BEGIN
		
		SET @SQL = '
		select '''+@DepartmentID+''' AS DepartmentID, Levels, LevelNo, '''' AS ApproveID From ST0010  where DivisionID = '''+@DivisionID+''' and TypeID = '''+@TypeID+''' '

		EXEC (@SQL)
	END	

	IF @TypeID = 'KQTV'	--- Kết quả thử việc(HRMF2200)
	BEGIN
		
		SET @SQL = '
		select  Levels, LevelNo, '''' AS ApproveID From ST0010  where DivisionID = '''+@DivisionID+''' and TypeID = '''+@TypeID+''' '

		EXEC (@SQL)
	END	

	IF @TypeID = 'QDTD'	--- Quyết định tuyển dụng
	BEGIN
		SET @SQL = '
		select '''+@DepartmentID+''' AS DepartmentID, Levels, LevelNo, '''' AS ApproveID From ST0010  where DivisionID = '''+@DivisionID+''' and TypeID = '''+@TypeID+''' '

		EXEC (@SQL)
	END		 
	
	INSERT INTO #Approve (Levels, LevelNo, ApproveID, SameLevels)
	SELECT COUNT(*) OVER () AS Levels, ROW_NUMBER() OVER(ORDER BY ApproveLevelNo) AS LevelNo, ManagerID AS ApproveID, @SameLevels AS SameLevels
	FROM
	(
		SELECT * FROM dbo.[GetManagerList] (@DivisionID, @EmployeeID, @DirectionTypeID, CASE WHEN @TypeID = 'BPC' OR @TypeID = 'QDTD' THEN @DepartmentID ELSE '' END)
		WHERE LevelNo <= @ActualLevels
	) B
END

ELSE IF ISNULL(@IsAppCondition,0) <> 0
BEGIN
	INSERT INTO #Approve (Levels, LevelNo, ApproveID, SameLevels)
	SELECT COUNT(*) OVER () AS Levels, ROW_NUMBER() OVER(ORDER BY ApproveLevelNo) AS LevelNo, ManagerID AS ApproveID, @SameLevels AS SameLevels
	FROM
	(
		SELECT * FROM dbo.[GetManagerList] (@DivisionID, @EmployeeID, @DirectionTypeID, '')
		WHERE LevelNo IN (SELECT LevelNo FROM #LevelList)
	) C
END


--- Trả ra dữ liệu
--SELECT TOP 1 0 AS Status, ISNULL(Levels, 0) AS Levels FROM #Approve
--SELECT LevelNo, ApproveID FROM #Approve ORDER BY LevelNo

SELECT TOP 1 0 AS Status, ISNULL(Levels, 0) AS Levels, ISNULL(SameLevels, 0) AS SameLevels FROM #Approve


		INSERT INTO #Approve (Levels,SameLevels, LevelNo, ApproveID, ApproveTypeID1)
		SELECT list.Levels,list.SameLevels, list.LevelNo , ContactPerson,list.ApproveTypeID1 from AT1102  
		INNER JOIN #LevelList list WITH(NOLOCK) ON  list.DepartmentID = AT1102.DepartmentID		


SELECT AP.LevelNo, AP.ApproveID, T3.FullName,Levels,SameLevels,ApproveTypeID1
FROM #Approve AP
LEFT JOIN AT1103 T3 WITH(NOLOCK) ON AP.ApproveID = T3.EmployeeID
LEFT JOIN HT1400 T4 WITH(NOLOCK) ON AP.ApproveID = T4.EmployeeID
Where T4.EmployeeStatus=1  ---Chỉ hiện nhân viên có trạng thái "Đang làm"
AND ApproveTypeID1 is not null
ORDER BY LevelNo


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
