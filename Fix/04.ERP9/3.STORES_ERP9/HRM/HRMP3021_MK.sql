IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3021_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3021_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Import bảng đơn xin đổi ca (tách store cho Meiko)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Văn Minh on 27/09/2019
---- Updated by: Văn Minh on 24/10/2019
---- Modified by Huỳnh Thử on 14/10/2020: MEIKO: Bổ sung điều kiện check người duyệt (J2402)
---- Modified by Huỳnh Thử on 20/10/2020: MEIKO: Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
---- Modified by Nhựt Trường on 18/04/2023: Bổ sung format lại biến @ChangeFromDate khi get Date, Month, Year.
---- Modified by Kiều Nga on 22/04/2023: Bổ sung format lại ChangeFromDate,ChangeToDate sang dạng yyyy-mm-dd
---- Modified by Nhựt Trường on 22/05/2023: Xử lý lưu APKDetail bảng OOT9001.
---- Modified by Kiều Nga on 22/06/2023: [2023/06/IS/0228] Xử lý lỗi duyệt đơn xin đổi ca (lưu cột ApproveLevel).
---- Modified by Kiều Nga on 30/06/2023: [2023/06/IS/0268] Xử lý Đơn đổi ca bằng file excel khi chia nhiều dòng hệ thống chưa tách được mã đơn-> trùng đơn không lên.
---- Modified by Kiều Nga on 28/07/2023: [2023/07/IS/0006] Fix lỗi tạo đơn xin phép, đổi ca trùng vẫn cho lưu không báo lỗi.
---- Modified by Kiều Nga on 18/08/2023: [2023/08/IS/0169] Bổ sung không kiểm tra user 005273 vào người duyệt 1 và người duyệt 2
-- <Example>
/*
    EXEC HRMP3021_MK,0, 1
*/

 CREATE PROCEDURE HRMP3021_MK
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, -- 0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS
DECLARE @Cur CURSOR,
		@Row INT,
		@TransactionID UNIQUEIDENTIFIER,
		@ID NVARCHAR(100),
		@DepartmentID VARCHAR(50),
		@SectionID VARCHAR(50),
		@SubsectionID VARCHAR(50),
		@ProcessID VARCHAR(50),
		@EmployeeID VARCHAR(100),
		@ChangeFromDate datetime,
		@ChangeToDate datetime,
		@ShiftID VARCHAR(50),
		@ApprovePersonID01 NVARCHAR(50),
		@ApprovePersonID02 NVARCHAR(50),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX)='',
		@Level INT,
		@EndMonth INT = 0,
		@APK1 VARCHAR(50), -- lưu giá trị APK cập nhật vào bảng
		@WorkDate DATETIME,
		@LeaveDate DATETIME,
		@Date DATETIME,
		@Day INT,
		@Month INT,
		@Year INT,
		@sSQL NVARCHAR(MAX) = '',
		@ShiftIDFromDatabase VARCHAR(50),
		@FromApprenticeTime DATETIME,
		@ToApprenticeTime DATETIME,
		@ActFromApprenticeTime DATETIME,
		@ActToApprenticeTime DATETIME,
		@CustomerName INT,
		@Description NVARCHAR(250) = ''

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex

SET @TransactionID = NEWID()
SET @EndMonth = (SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))

-- xóa dữ liệu import thừa
IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2132]') AND TYPE IN (N'U'))
	DELETE HRMT2132  WHERE DATEDIFF(DAY, CreateDate, GETDATE()) >= 1 

-- INSERT dữ liệu từ file excel vào bảng tạm
INSERT INTO HRMT2132([Row], DivisionID, TranMonth, TranYear, ID, [Description],
            DepartmentID, SectionID, SubsectionID, ProcessID, EmployeeID,
            ChangeFromDate, ChangeToDate, ShiftID, Note, ApprovePersonID01, ApprovePersonID02,
            TransactionKey, TransactionID, CreateDate, ErrorColumn, ErrorMessage)
															
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
		CONVERT(INT,LEFT(X.Data.query('Period').value('.','VARCHAR(10)'),2)) AS TranMonth,
		CONVERT(INT,RIGHT(X.Data.query('Period').value('.','VARCHAR(10)'),4)) AS TranYear,
		'' AS ID,	
		X.Data.query('Description').value('.','NVARCHAR(250)') AS [Description],
		X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
		X.Data.query('SectionID').value('.','VARCHAR(50)') AS SectionID,
		X.Data.query('SubsectionID').value('.','VARCHAR(50)') AS SubsectionID,
		X.Data.query('ProcessID').value('.','VARCHAR(50)') AS ProcessID,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('ChangeFromDate').value('.', 'NVARCHAR(50)') AS ChangeFromDate,
		X.Data.query('ChangeToDate').value('.', 'NVARCHAR(50)') AS ChangeToDate,
		X.Data.query('ShiftID').value('.', 'VARCHAR(50)') AS ShiftID,
		X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note,
		X.Data.query('ApprovePersonID01').value('.', 'VARCHAR(50)') AS ApprovePersonID01,
		X.Data.query('ApprovePersonID02').value('.', 'VARCHAR(50)') AS ApprovePersonID02,
		@TransactionKey AS TransactionKey, @TransactionID, GETDATE(),'',''
FROM @XML.nodes('//Data') AS X (Data)

-- Test dữ liệu import
-- Kiểm tra đơn vị hiện tại
IF (SELECT TOP 1 DivisionID FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey) <> @DivisionID    
BEGIN
	UPDATE HRMT2132 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000001' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

-- Kiểm tra kỳ kế toán hiện tại
IF (SELECT TOP 1 (TranMonth + TranYear * 100) FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey) <> (@TranMonth + @TranYear * 100)    
BEGIN
	UPDATE HRMT2132 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000002' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Period'),
					   ErrorColumn = 'Period'
	GOTO EndMessage
END

SET @Level = (SELECT LEVEL FROM OOT0010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND AbsentType = 'DXDC')
SET @Level = ISNULL(@Level,0)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row],'' ID, ISNULL(DepartmentID,'') DepartmentID, EmployeeID,
	ISNULL(SectionID,'') SectionID, ISNULL(SubsectionID,'') SubsectionID, 
	ISNULL(ProcessID,'') ProcessID, CONVERT(VARCHAR(10), CONVERT(date, ChangeFromDate, 105), 23) as ChangeFromDate,
	CONVERT(VARCHAR(10), CONVERT(date, ChangeToDate, 105), 23) as ChangeToDate,
	ISNULL(ShiftID,'') ShiftID, ISNULL(ApprovePersonID01,'') ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') ApprovePersonID02,[Description]
	FROM HRMT2132 WITH (NOLOCK)
	WHERE TransactionID = @TransactionID
	Order by [Row]
		
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @ID, @DepartmentID, @EmployeeID, @SectionID, @SubsectionID, @ProcessID, @ChangeFromDate,
                          @ChangeToDate, @ShiftID, @ApprovePersonID01, @ApprovePersonID02,@Description

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''

---- Kiểm tra tồn tại mã Mã khối
	IF @DepartmentID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WITH (NOLOCK) WHERE DepartmentID = @DepartmentID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000003,'
		SET @ErrorColumn = @ErrorColumn + 'DepartmentID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại mã Ca
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID = @ShiftID)
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ShiftID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'ShiftID,'				
		SET @ErrorFlag = 1
	END

---- tạo mã mới
IF @ID=''		
	BEGIN		
		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
		SET @ID=(SELECT TOP 1 ID FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND DepartmentID=@DepartmentID AND SectionID=@SectionID AND SubsectionID=@SubsectionID AND ProcessID=@ProcessID 
			AND  ISNULL(ID,'') <>'' AND [Description] = @Description)
		IF ISNULL(@ID,'')=''
		BEGIN
			CREATE TABLE #VoucherNo (APK VARCHAR(50), LastKey INT,VoucherNo VARCHAR(100))
			INSERT INTO #VoucherNo (APK, LastKey,VoucherNo)
			EXEC OOP0000 @DivisionID,@TranMonth,@TranYear,'OOT2070','DXDC'
			SELECT @APK1 = APK, @ID = VoucherNo FROM #VoucherNo	
			
			UPDATE AT4444 SET LastKey = LastKey + 1 WHERE APK = @APK1
			DROP TABLE #VoucherNo
		END
		UPDATE HRMT2132 SET ID = @ID WHERE TransactionKey=@TransactionKey AND DepartmentID=@DepartmentID AND SectionID=@SectionID AND SubsectionID=@SubsectionID AND ProcessID=@ProcessID AND [Description] = @Description
	END

---- Kiểm tra tồn tại mã nhân viên
IF NOT EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND EmployeeStatus NOT IN (4,9))		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000008,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END
	ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM HV1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID)
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'FullName'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000009,'
		SET @ErrorColumn = @ErrorColumn + 'FullName,'				
		SET @ErrorFlag = 1
	END
	
--- Kiểm tra nhân viên có thuộc Khối import 
	IF EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND DepartmentID <> @DepartmentID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END

--- Kiểm tra nhân viên có thuộc Phòng, ban, công đoạn import nếu có nhập
	IF @SectionID <> '' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND TeamID <> @SectionID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END
	
	IF @SubsectionID <> '' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND Ana04ID <> @SubsectionID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END

	IF @ProcessID <> '' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND Ana05ID <> @ProcessID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END	

--- Kiểm tra ChangeFromDate và ChangeToDate
	IF @ChangeFromDate > @ChangeToDate
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ChangeFromDate')
											+ CONVERT(VARCHAR,@Row) + '-HFML000001,'
		SET @ErrorColumn = @ErrorColumn + 'ChangeFromDate,'				
		SET @ErrorFlag = 1
	END


---- Kiểm tra mã đơn có tồn tại hay không -----
	--- Bảng tạm lưu trữ ca ---
	IF Convert(Date, @ChangeFromDate, 120) <= Convert(Date, @ChangeToDate, 120) 
	BEGIN

	--- Kiểm tra ChangeFromDate với bảng phân ca
		--SET @Day = DATEPART(dd, CONVERT(VARCHAR(50), @ChangeFromDate, 103))
		--SET @Month = DATEPART(MM, CONVERT(VARCHAR(50), @ChangeFromDate, 103))
		--SET @Year = DATEPART(yyyy, CONVERT(VARCHAR(50), @ChangeFromDate, 103))
		SET @Day = DAY(@ChangeFromDate)
		SET @Month = MONTH(@ChangeFromDate)
		SET @Year = YEAR(@ChangeFromDate)
		
		--Lấy ca hiện tại trong bảng phân ca
		DECLARE  @s VARCHAR(2)
		IF @Day < 10 SET @s = '0' + CONVERT(VARCHAR, @Day)
		ELSE SET @s = CONVERT(VARCHAR, @Day)
		
		SET @sSQL = N'SELECT D' + @s + ' FROM HT1025 WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + ''' AND ISNULL(D' + @s + ','''')<>'''' AND EmployeeID = ''' + @EmployeeID + '''
														AND TranMonth = ' + STR(@Month) + ' AND TranYear = ' + STR(@Year) + ' 
         '
		 CREATE TABLE #TempShift (ShiftID VARCHAR(50))
		 INSERT INTO #TempShift
		 EXEC (@sSQL)
		 SET @ShiftIDFromDatabase = (SELECT ShiftID FROM #TempShift)

		 
		IF(@ShiftIDFromDatabase = @ShiftID) -- Kiểm Tra nếu ca trùng BPC thì báo trùng
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ChangeFromDate')
											+ CONVERT(VARCHAR,@Row) + '-HFML000414,'
			SET @ErrorColumn = @ErrorColumn + 'ChangeFromDate,'				
			SET @ErrorFlag = 1
		END
		ELSE --- Kiểm Tra nếu cùng 1 ngày 1 nhân viên 1 loại ca báo trùng (khác phiếu)
		IF EXISTS (SELECT 1 FROM OOT2070 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND [Status] =0 AND (@ChangeFromDate BETWEEN ChangeFromDate AND ChangeToDate) AND ShiftID =@ShiftID)
			OR EXISTS (SELECT 1 FROM OOT2070 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND [Status] =0 AND (@ChangeToDate BETWEEN ChangeFromDate AND ChangeToDate) AND ShiftID =@ShiftID)
			OR EXISTS (SELECT 1 FROM OOT2070 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND [Status] =0 AND (ChangeFromDate BETWEEN @ChangeFromDate AND @ChangeToDate) AND ShiftID =@ShiftID)
			OR EXISTS (SELECT 1 FROM OOT2070 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND [Status] =0 AND (ChangeToDate BETWEEN @ChangeFromDate AND @ChangeToDate) AND ShiftID =@ShiftID)															
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ChangeFromDate')
											+ CONVERT(VARCHAR,@Row) + '-HFML000414,'
			SET @ErrorColumn = @ErrorColumn + 'ChangeFromDate,'				
			SET @ErrorFlag = 1
		END

		--- Kiểm Tra nếu cùng 1 ngày 1 nhân viên 1 loại ca báo trùng (cùng file Import) 
		IF (SELECT COUNT(*) FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND EmployeeID = @EmployeeID AND @ChangeFromDate BETWEEN  CONVERT(VARCHAR(10), CONVERT(date, ChangeFromDate, 105), 23) AND CONVERT(VARCHAR(10), CONVERT(date, ChangeToDate, 105), 23) AND ShiftID =@ShiftID) >1
			OR (SELECT COUNT(*) FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND EmployeeID = @EmployeeID AND @ChangeToDate BETWEEN CONVERT(VARCHAR(10), CONVERT(date, ChangeFromDate, 105), 23) AND CONVERT(VARCHAR(10), CONVERT(date, ChangeToDate, 105), 23) AND ShiftID =@ShiftID) >1
			OR (SELECT COUNT(*) FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND EmployeeID = @EmployeeID AND (CONVERT(VARCHAR(10), CONVERT(date, ChangeFromDate, 105), 23) BETWEEN @ChangeFromDate AND @ChangeToDate) AND ShiftID =@ShiftID) >1
			OR (SELECT COUNT(*)FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND EmployeeID = @EmployeeID AND (CONVERT(VARCHAR(10), CONVERT(date, ChangeToDate, 105), 23) BETWEEN @ChangeFromDate AND @ChangeToDate) AND ShiftID =@ShiftID)	>1														
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ChangeFromDate')
											+ CONVERT(VARCHAR,@Row) + '-KPIFML000017,'
			SET @ErrorColumn = @ErrorColumn + 'ChangeFromDate,'				
			SET @ErrorFlag = 1
		END

         --Kiểm tra với ca đã được phân
         IF  ISNULL(@ShiftIDFromDatabase,'') = ''
         BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ChangeFromDate')
											+ CONVERT(VARCHAR,@Row) + '-HFML000431,'
			SET @ErrorColumn = @ErrorColumn + 'ChangeFromDate,'				
			SET @ErrorFlag = 1

			DROP TABLE #TempShift
         END
         ELSE 
         BEGIN
			DROP TABLE #TempShift
         END

	--- Kiểm tra cho ChangeToDate với bảng phân ca
         IF  NOT EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TRANYEAR = @TranYear AND EmployeeID = @EmployeeID)
         BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-HFML000431,'
			SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
			SET @ErrorFlag = 1
         END
	END

	--- Kiểm tra người duyệt 1
	IF @Level > 0
	BEGIN
	IF @ApprovePersonID01 = ''		
	BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
			SET @ErrorFlag = 1			
	END 
	ELSE 
	BEGIN
		IF @CustomerName = 50 -- MEKIO
		BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK)
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID01
			                                        AND H14.DepartmentID = @DepartmentID
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
															OR 'J2402' = @ApprovePersonID01 OR '005273' = @ApprovePersonID01)
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
					SET @ErrorFlag = 1
				END
				-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID01
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
						SET @ErrorFlag = 1
				END 
		END
		
	END
END
	
	-- Kiểm tra người duyệt 2
	IF @Level > 1
	BEGIN
		IF @ApprovePersonID02 = ''		
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
			SET @ErrorFlag = 1
		END 
		ELSE 	
		BEGIN
			IF @CustomerName = 50 -- MEKIO
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK)
													  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
														INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE (H14.EmployeeID=@ApprovePersonID02
														AND H14.DepartmentID = @DepartmentID
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
														OR 'J2402' = @ApprovePersonID02 OR '005273' = @ApprovePersonID02)
				BEGIN	
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
															) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
						SET @ErrorFlag = 1
				END
				-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 WITH (NOLOCK) ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 WITH (NOLOCK) ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID02
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
						SET @ErrorFlag = 1
				END 
			END 
			
		END
	END
		
	IF @ErrorColumn <> ''
	BEGIN
		UPDATE HRMT2132 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END
	
	FETCH NEXT FROM @Cur INTO  @Row, @ID, @DepartmentID, @EmployeeID, @SectionID, @SubsectionID, @ProcessID, @ChangeFromDate,
                          @ChangeToDate, @ShiftID, @ApprovePersonID01, @ApprovePersonID02,@Description
END
CLOSE @Cur


IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	IF NOT EXISTS (SELECT 1 FROM HRMT2132 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
	BEGIN

		--- insert master
		INSERT INTO OOT9000(DivisionID, TranMonth, TranYear, ID,
		            [Description], DepartmentID, [Type], SectionID, SubsectionID,
		            ProcessID, DeleteFlag, AppoveLevel, ApprovingLevel,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*, 0, @Level, 0, @UserID, GETDATE(), @UserID, GETDATE()
		FROM 
		(
			SELECT  DivisionID, TranMonth, TranYear, ID, [Description], 
			DepartmentID, 'DXDC' Type,SectionID, SubsectionID, ProcessID
			FROM HRMT2132 WITH (NOLOCK)
			WHERE TransactionKey = @TransactionKey
			GROUP BY DivisionID, TranMonth, TranYear, ID, [Description], DepartmentID, SectionID, SubsectionID, ProcessID
		) A

		-- Insert bảng đơn xin đổi ca
		INSERT INTO OOT2070(APKMaster, DivisionID, EmployeeID, ChangeFromDate, ChangeToDate, ShiftID, Note, DeleteFlag,ApproveLevel)
		SELECT OOT9.APK,HRMT2132.DivisionID, EmployeeID,CONVERT(VARCHAR(10), CONVERT(date, ChangeFromDate, 105), 23), CONVERT(VARCHAR(10), CONVERT(date, ChangeToDate, 105), 23), ShiftID, Note, 0,@Level
		FROM HRMT2132 WITH (NOLOCK)
		INNER JOIN OOT9000 OOT9 WITH (NOLOCK) ON OOT9.DivisionID = HRMT2132.DivisionID AND OOT9.TranMonth = HRMT2132.TranMonth AND OOT9.TranYear = HRMT2132.TranYear AND OOT9.ID = HRMT2132.ID
		WHERE TransactionKey = @TransactionKey

		--- Insert người duyệt
		DECLARE @i INT = 1,
				@j INT = 1,
				@TotalRow INT = 0,
				@APK_AT2070 VARCHAR(50),
				@APKMaster_OOT9000 VARCHAR(50)

		SELECT ROW_NUMBER() OVER (ORDER BY EmployeeID DESC) AS RowNum, COUNT(*) OVER () AS TotalRow, APK, APKMaster
		INTO #TEMP
		FROM OOT2070 WITH(NOLOCK)
		WHERE APKMaster IN (SELECT DISTINCT OOT9.APK 
							FROM HRMT2132 WITH (NOLOCK) 
							INNER JOIN OOT9000 OOT9 WITH (NOLOCK) ON OOT9.DivisionID = HRMT2132.DivisionID AND OOT9.TranMonth = HRMT2132.TranMonth AND OOT9.TranYear = HRMT2132.TranYear AND OOT9.ID = HRMT2132.ID
							WHERE TransactionKey = @TransactionKey)
		ORDER BY EmployeeID DESC

		SELECT TOP 1 @TotalRow = TotalRow, @j = 1 FROM #TEMP

		WHILE @j <= @TotalRow
		BEGIN
			SELECT @APK_AT2070 = APK,@APKMaster_OOT9000 = APKMaster, @i = 1 FROM #TEMP WHERE RowNum = @j

			WHILE @i <= @Level
			BEGIN
				IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
				ELSE SET @s = CONVERT(VARCHAR, @i)
				SET @sSQL='
				INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status], APKDetail)
				SELECT A.DivisionID,OOT9.APK,ApprovePersonID,'+str(@i)+',0,0, '''+@APK_AT2070+'''
				FROM
				(
					SELECT  DivisionID, TranMonth, TranYear, ID, 
					DepartmentID,SectionID, SubsectionID, ProcessID,MAX(ApprovePersonID'+@s+') ApprovePersonID
					FROM HRMT2132 WITH (NOLOCK)
					WHERE TransactionKey='''+@TransactionKey+'''
					GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
				)A
				INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.ID AND APK = '''+@APKMaster_OOT9000+''''
				--PRINT (@sSQL)
				EXEC (@sSQL)
				SET @i = @i + 1		
			END
			SET @j = @j + 1
		END
	END
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM HRMT2132 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
