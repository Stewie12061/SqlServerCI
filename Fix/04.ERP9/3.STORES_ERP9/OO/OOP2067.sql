IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2067]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2067]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Import Đơn xin phép.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Văn Tài on 14/07/2022
---- Modified on 
---- Modified on 20/07/2022 by [Văn Tài]: Xử lý insert APKDetails vào OOT9001.
---- Modified on 06/10/2022 by [Văn Tài]: Di chuyển phần Cursor bị sai.
---- Modified on 12/10/2022 by [Đình Định]: Check trùng mã đơn bổ sung quẹt thẻ.
---- Modified on 17/10/2022 by [Đức Tuyên]: Fix lỗi import dữ liệu bị trùng lặp.
---- Modified on 03/11/2022 by [Đức Tuyên]: Thông tin số cấp duyệt(ApproveLevel) import theo dữ liệu từ hệ thống.
---- Modified on 14/11/2022 by [Văn Tài]  : Thông tin cấp duyệt bị sai RollLevel.
-- <Example>
/*
    EXEC OOP2067,0, 1
*/

 CREATE PROCEDURE OOP2067
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS
DECLARE @Cur CURSOR,
		@Row INT,
		@TransactionID UNIQUEIDENTIFIER,
		@ID VARCHAR(50),
		@Description NVARCHAR(500),
		@DepartmentID VARCHAR(50),
		@SectionID VARCHAR(50),
		@SubsectionID VARCHAR(50),
		@ProcessID VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@Reason NVARCHAR(250),
		@ApproveLevel INT,
		@InOut TINYINT,
		@Note NVARCHAR(250),
		@ApprovePersonID01 VARCHAR(50),
		@ApprovePersonID02 VARCHAR(50),
		@ApprovePersonID03 VARCHAR(50),
		@ApprovePersonID04 VARCHAR(50),
		@ApprovePersonID05 VARCHAR(50),
		@ApprovePersonID06 VARCHAR(50),
		@ApprovePersonID07 VARCHAR(50),
		@ApprovePersonID08 VARCHAR(50),
		@ApprovePersonID09 VARCHAR(50),
		@ApprovePersonID10 VARCHAR(50),
		@CreateDate  DATETIME,
		@ErrorColumn VARCHAR(50),
		@ErrorMessage  VARCHAR(50),
		@ErrorFlag TINYINT = 0,
		@Level INT,
		@EndMonth INT=0,
		@APK1 VARCHAR(50), --lưu giá trị APK cập nhật vào bảng
		@WorkDate DATETIME,
		@LeaveDate DATETIME,
		@Date DATETIME

SET @TransactionID = NEWID()
SET @EndMonth=(SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))

SET @Level=(SELECT LEVEL FROM OOT0010 WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND AbsentType='DXBSQT')
SET @Level=ISNULL(@Level,0)
SET @ApproveLevel=ISNULL(@Level,0)

DELETE OOT2041 WHERE CONVERT(DATE, CreateDate) <= (DATEADD(day, -1, CAST(GETDATE() AS date)))

---------INSERT dữ liệu từ file excel vào bảng ngầm theo TransactionKey---------------------------------------	
INSERT INTO OOT2041([Row], 
			DivisionID, 
			TranMonth, 
			TranYear, 
			ID, 
			[Description],
            DepartmentID, 
			SectionID, 
			SubsectionID, 
			ProcessID, 
			EmployeeID, 
            Reason,
            [Date],
			InOut, 
			Note,
			ApproveLevel,
			ApprovePersonID01, 
			ApprovePersonID02,
            ApprovePersonID03, 
			ApprovePersonID04, 
			ApprovePersonID05,
            ApprovePersonID06, 
			ApprovePersonID07,
			ApprovePersonID08,
            ApprovePersonID09,
			ApprovePersonID10,
			TransactionKey, 
			TransactionID,  
			CreateDate,
			ErrorColumn,
			ErrorMessage)
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
		CONVERT(INT,LEFT(X.Data.query('Period').value('.','VARCHAR(10)'),2)) AS TranMonth,
		CONVERT(INT,RIGHT(X.Data.query('Period').value('.','VARCHAR(10)'),4)) AS TranYear,
		X.Data.query('ID').value('.','VARCHAR(50)') AS ID,
		X.Data.query('Description').value('.','NVARCHAR(250)') AS Description,
		X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
		X.Data.query('SectionID').value('.','VARCHAR(50)') AS SectionID,
		X.Data.query('SubsectionID').value('.','VARCHAR(50)') AS SubsectionID,
		X.Data.query('ProcessID').value('.','VARCHAR(50)') AS ProcessID,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('Reason').value('.', 'NVARCHAR(250)') AS Reason,
		(CASE WHEN X.Data.query('Date').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Date').value('.', 'DATETIME') END) AS [Date],
		(CASE WHEN X.Data.query('InOut').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('InOut').value('.', 'TINYINT') END) AS InOut,
		X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note,
		@ApproveLevel AS ApproveLevel,
		X.Data.query('ApprovePersonID01').value('.', 'VARCHAR(50)') AS ApprovePersonID01,
		X.Data.query('ApprovePersonID02').value('.', 'VARCHAR(50)') AS ApprovePersonID02,
		X.Data.query('ApprovePersonID03').value('.', 'VARCHAR(50)') AS ApprovePersonID03,
		X.Data.query('ApprovePersonID04').value('.', 'VARCHAR(50)') AS ApprovePersonID04,
		X.Data.query('ApprovePersonID05').value('.', 'VARCHAR(50)') AS ApprovePersonID05,
		X.Data.query('ApprovePersonID06').value('.', 'VARCHAR(50)') AS ApprovePersonID06,
		X.Data.query('ApprovePersonID07').value('.', 'VARCHAR(50)') AS ApprovePersonID07,
		X.Data.query('ApprovePersonID08').value('.', 'VARCHAR(50)') AS ApprovePersonID08,
		X.Data.query('ApprovePersonID09').value('.', 'VARCHAR(50)') AS ApprovePersonID09,
		X.Data.query('ApprovePersonID10').value('.', 'VARCHAR(50)') AS ApprovePersonID10,
		@TransactionKey AS TransactionKey,
		@TransactionID,
		GETDATE(),
		'' AS ErrorColumn,
		'' AS ErrorMessage
FROM @XML.nodes('//Data') AS X (Data)

--- Cập nhật ngày làm việc.
UPDATE OOT2041
SET WorkingDate = CONVERT(DATE, [Date])


--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM OOT2041 WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE OOT2041 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000001' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

IF (SELECT TOP 1 (TranMonth + TranYear * 100) FROM OOT2041 WHERE TransactionKey = @TransactionKey) <> (@TranMonth + @TranYear * 100)    -- Kiểm tra kỳ kế toán hiện tại
BEGIN
	UPDATE OOT2041 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000002' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Period'),
					   ErrorColumn = 'Period'
	GOTO EndMessage
END


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT		[Row], 
			DivisionID,
			TranMonth, 
			TranYear, 
			ISNULL(ID, ''), 
			ISNULL(Description, ''),
            ISNULL(DepartmentID, ''), 
			ISNULL(SectionID, ''), 
			ISNULL(SubsectionID, ''), 
			ISNULL(ProcessID, ''), 
			ISNULL(EmployeeID, ''), 
            ISNULL(Reason, ''),
            [Date],
			InOut, 
			ISNULL(Note, ''),		
			ISNULL(ApprovePersonID01, ''), 
			ISNULL(ApprovePersonID02, ''),
            ISNULL(ApprovePersonID03, ''), 
			ISNULL(ApprovePersonID04, ''), 
			ISNULL(ApprovePersonID05, ''),
            ISNULL(ApprovePersonID06, ''), 
			ISNULL(ApprovePersonID07, ''),
			ISNULL(ApprovePersonID08, ''),
            ISNULL(ApprovePersonID09, ''),
			ISNULL(ApprovePersonID10, '')
	FROM OOT2041
	WHERE 
		TransactionKey = @TransactionKey
		AND TransactionID = @TransactionID
		
OPEN @Cur

FETCH NEXT FROM @Cur INTO 
			@Row, 
			@DivisionID,
			@TranMonth, 
			@TranYear, 
			@ID, 
			@Description,
            @DepartmentID,
			@SectionID, 
			@SubsectionID, 
			@ProcessID, 
			@EmployeeID, 
            @Reason,
            @Date,
			@InOut, 
			@Note,	
			@ApprovePersonID01,
			@ApprovePersonID02,
            @ApprovePersonID03,
			@ApprovePersonID04,
			@ApprovePersonID05,
            @ApprovePersonID06,
			@ApprovePersonID07,
			@ApprovePersonID08,
            @ApprovePersonID09,
			@ApprovePersonID10
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''

---- Kiểm tra tồn tại mã Mã khối 
	IF @DepartmentID <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WITH (NOLOCK) WHERE DepartmentID = @DepartmentID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000003,'
		SET @ErrorColumn = @ErrorColumn + 'DepartmentID,'				
		SET @ErrorFlag = 1
	END
	
---- Kiểm tra tồn tại mã Mã phòng nếu có nhập	
	IF @SectionID <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WITH (NOLOCK) WHERE TeamID = @SectionID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000004,'
		SET @ErrorColumn = @ErrorColumn + 'SectionID,'				
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã Mã ban nếu có nhập	
	IF  @SubsectionID <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WITH (NOLOCK) WHERE AnaID=@SubsectionID AND AnaTypeID='A04' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SubsectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000005,'
		SET @ErrorColumn = @ErrorColumn + 'SubsectionID,'				
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã Mã công đoạn nếu có nhập
	IF @ProcessID <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WITH (NOLOCK) WHERE AnaID = @ProcessID AND AnaTypeID='A05' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProcessID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000006,'
		SET @ErrorColumn = @ErrorColumn + 'ProcessID,'				
		SET @ErrorFlag = 1
	END

---- tạo mã mới
IF @ID=''		
	BEGIN

		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
		SET @ID = (
					SELECT TOP 1 ID 
					FROM OOT2041 WITH (NOLOCK)
					WHERE TransactionKey = @TransactionKey 
							AND DepartmentID = @DepartmentID 
							AND SectionID = @SectionID 
							AND SubsectionID = @SubsectionID 
							AND ProcessID = @ProcessID 
							AND  ISNULL(ID,'') <>''
					)
							
		IF ISNULL(@ID,'')=''
		BEGIN
			CREATE TABLE #VoucherNo (APK VARCHAR(50), LastKey INT,VoucherNo VARCHAR(100))
			INSERT INTO #VoucherNo (APK, LastKey,VoucherNo)
			EXEC OOP0000 @DivisionID,@TranMonth,@TranYear,'OOT2040','DQT'
			SELECT @APK1 = APK, @ID = VoucherNo FROM #VoucherNo	
			
			UPDATE AT4444 SET LastKey = LastKey + 1 WHERE APK = @APK1
			DROP TABLE #VoucherNo
		END

		UPDATE OOT2041 SET ID = @ID 
		WHERE Row = @Row 
				AND TransactionKey = @TransactionKey 
				AND DepartmentID = @DepartmentID 
				AND SectionID = @SectionID 
				AND SubsectionID = @SubsectionID 
				AND ProcessID = @ProcessID
	END
	
					
	--- Kiểm tra tồn tại mã phiếu.
	IF EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND Type = N'DXBSQT' AND ID = @ID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ID')
											+ CONVERT(VARCHAR,@Row) + '-OFML000207,'
							
		SET @ErrorColumn = @ErrorColumn + 'ID,'
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã mã nhân viên và tên nhân viên
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID=@EmployeeID AND EmployeeStatus NOT IN (4,9))		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000008,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END	
	
--- Kiểm tra nhân viên có thuộc Khối import 
	IF @DepartmentID <> '' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND DepartmentID <> @DepartmentID)
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

	IF @ProcessID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND Ana05ID <> @ProcessID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END

	-- Kiểm tra người duyệt.
	BEGIN
		--- Kiểm tra người duyệt 1
		IF @Level >0
		BEGIN
			IF @ApprovePersonID01=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE 
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXP'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID01 
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 2
		IF @Level > 1
		BEGIN
			IF @ApprovePersonID02=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
				SET @ErrorFlag = 1
			END 
			ELSE
			BEGIN
				BEGIN
					IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														  INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=2 AND O11.AbsentType='BPC'
															INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
															WHERE H14.EmployeeID=@ApprovePersonID02 
															AND O10.TranMonth=@TranMonth
															AND O10.TranYear=@TranYear
															AND H14.EmployeeStatus NOT IN (4,9))
					BEGIN	
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
															) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
						SET @ErrorFlag = 1
					END
				END
			END
		END

		--- Kiểm tra người duyệt 3
		IF @Level >2
		BEGIN
			IF @ApprovePersonID03=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE 
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=3 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID03
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 4
		IF @Level >3
		BEGIN
			IF @ApprovePersonID04=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE 
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=4 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID04
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 5
		IF @Level >4
		BEGIN
			IF @ApprovePersonID05=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE 
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=5 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID05
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
					SET @ErrorFlag = 1
				END
			END 
		END

		--- Kiểm tra người duyệt 6
		IF @Level > 5
		BEGIN
			IF @ApprovePersonID06=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=6 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID06
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 7
		IF @Level >6
		BEGIN
			IF @ApprovePersonID07=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=7 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID07
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 8
		IF @Level > 7
		BEGIN
			IF @ApprovePersonID08=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=8 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID08
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 9
		IF @Level > 8
		BEGIN
			IF @ApprovePersonID09=''		
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=9 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID09
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
					SET @ErrorFlag = 1
				END
			END
		END

		--- Kiểm tra người duyệt 10
		IF @Level > 9
		BEGIN
			IF @ApprovePersonID10=''
			BEGIN
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
				SET @ErrorFlag = 1
		
			END 
			ELSE 
			BEGIN
				IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
														INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=10 AND O11.AbsentType='BPC'
														INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
														WHERE H14.EmployeeID=@ApprovePersonID10
														AND O10.TranMonth=@TranMonth
														AND O10.TranYear=@TranYear
														AND H14.EmployeeStatus NOT IN (4,9))
				BEGIN	
					SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
														WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
														) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
					SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
					SET @ErrorFlag = 1
				END
			END
		END
	END
		
	IF @ErrorColumn <> ''
	BEGIN
		UPDATE OOT2041 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row
	
	FETCH NEXT FROM @Cur INTO 
			@Row, 
			@DivisionID,
			@TranMonth, 
			@TranYear, 
			@ID, 
			@Description,
            @DepartmentID,
			@SectionID, 
			@SubsectionID, 
			@ProcessID, 
			@EmployeeID, 
            @Reason,
            @Date,
			@InOut, 
			@Note,	
			@ApprovePersonID01,
			@ApprovePersonID02,
            @ApprovePersonID03,
			@ApprovePersonID04,
			@ApprovePersonID05,
            @ApprovePersonID06,
			@ApprovePersonID07,
			@ApprovePersonID08,
            @ApprovePersonID09,
			@ApprovePersonID10


END

	FETCH NEXT FROM @Cur INTO 
			@Row, 
			@DivisionID,
			@TranMonth, 
			@TranYear, 
			@ID, 
			@Description,
            @DepartmentID,
			@SectionID, 
			@SubsectionID, 
			@ProcessID, 
			@EmployeeID, 
            @Reason,
            @Date,
			@InOut, 
			@Note,	
			@ApprovePersonID01,
			@ApprovePersonID02,
            @ApprovePersonID03,
			@ApprovePersonID04,
			@ApprovePersonID05,
            @ApprovePersonID06,
			@ApprovePersonID07,
			@ApprovePersonID08,
            @ApprovePersonID09,
			@ApprovePersonID10
END
CLOSE @Cur
IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2041 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
	BEGIN
		--- insert master
		INSERT INTO OOT9000(DivisionID, TranMonth, TranYear, ID,
		            [Description], DepartmentID, [Type], SectionID, SubsectionID,
		            ProcessID, DeleteFlag, AppoveLevel, ApprovingLevel,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*,0,@Level,0,@UserID,GETDATE(),@UserID,GETDATE()
		FROM 
		(
			SELECT  DivisionID, TranMonth, TranYear, ID, MAX([Description]) [Description], 
			DepartmentID, 'DXBSQT' Type,SectionID, SubsectionID, ProcessID
			FROM OOT2041 WITH (NOLOCK)
			WHERE TransactionKey=@TransactionKey
			GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
		)A

		-- Insert bảng bổ sung quẹt thẻ
		INSERT INTO OOT2040
		(
			APKMaster
			, APK
			, DivisionID
			, EmployeeID
			, Reason
			, Date
			, InOut
			, EditType
			, Status
			, DeleteFlag
			, ApproveLevel
			, ApprovingLevel
			, WorkingDate
		)
			
		SELECT 
			OOT9.APK
			, NEWID()
			, OOT2041.DivisionID
			, EmployeeID
			, Reason
			, [Date]
			, InOut
			, 0 AS EditType
			, 0 AS Status
			, 0 AS DeleteFlag
			, ApproveLevel
			, 1 AS ApprovingLevel
			, WorkingDate
		FROM OOT2041 WITH (NOLOCK)
		INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = OOT2041.DivisionID 
									AND OOT9.TranMonth = OOT2041.TranMonth 
									AND OOT9.TranYear = OOT2041.TranYear 
									AND OOT9.ID = OOT2041.ID
		WHERE TransactionKey = @TransactionKey

		--- Insert người duyệt
		DECLARE @i INT = 1, @s VARCHAR(2),@sSQL NVARCHAR(MAX)
		WHILE @i <= @Level
		BEGIN
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
			SET @sSQL='
			INSERT INTO OOT9001 (DivisionID, APKMaster, APKDetail, ApprovePersonID, [Level], DeleteFlag, [Status])
			SELECT A.DivisionID, OOT9.APK, OOT4.APK,ApprovePersonID,'+str(@i)+',0,0
			FROM
			(
				SELECT  DivisionID, TranMonth, TranYear, ID, 
				DepartmentID,SectionID, SubsectionID, ProcessID,MAX(ApprovePersonID'+@s+') ApprovePersonID
				FROM OOT2041
				WHERE TransactionKey = ''' + @TransactionKey + '''
				GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
			)A
			INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.ID 
			INNER JOIN OOT2040 OOT4 ON OOT4.DivisionID = A.DivisionID AND OOT4.APKMaster = OOT9.APK
			'

			--PRINT (@sSQL)
			EXEC (@sSQL)
			SET @i = @i + 1
		END
	END
	
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM OOT2041 WITH (NOLOCK)
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

SET QUOTED_IDENTIFIER OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
