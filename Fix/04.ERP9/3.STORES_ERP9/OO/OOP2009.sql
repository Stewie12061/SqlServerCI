IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Import bảng phân ca
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Quốc Tuấn on 03/12/2015
---- Modified on 
---- Modified on 06/06/2016 by Bảo Thy: Bổ sung kiểm tra nhân viên có thuộc khối, phòng, ban, công đoạn import hay không
---- Modified on 13/06/2016 by Bảo Thy: Bổ sung kiểm tra nhân viên đã được phân ca chưa
---- Modified on 06/09/2016 by Bảo Thy: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Bảo Thy on 21/06/2017: Bổ sung kiểm tra thời gian sắp ca >= WorkDate
---- Modified by Phương Thảo on 06/11/2017: Bổ sung kiểm tra thời gian sắp ca < LeaveDate
---- Modified by Bảo Thy on 05/12/2017: Bổ sung kiểm tra ca làm việc trong thời gian thử việc
---- Modified by Bảo Thy on 18/12/2017: Bổ sung kiểm tra hợp lệ ApprovePersonID01 -> ApprovePersonID10 (CustomerIndex=50)
---- Modified by Bảo Anh on 23/11/2018: Bỏ kiểm tra ca làm việc trong thời gian thử việc, sửa lỗi kiểm tra chưa đúng thời gian sắp ca phải >= WorkDate và < LeaveDate
---- Modified by Huỳnh Thử on 14/10/2020: MEIKO: Bổ sung điều kiện check người duyệt (J2402)
---- Modified by Huỳnh Thử on 20/10/2020: MEIKO: Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
---- Modified by Nhật Thanh on 11/08/2022: Tách store NEWTOYO - Xử lý import bảng phân ca theo thiết lập ST0010
---- Modified by Nhut Truong on 22/04/2023: MEIKO: Bổ sung điều kiện check người duyệt (J2402,005273)
---- Modified by Kiều Nga on 30/10/2023: Bổ sung WITH (NOLOCK)

-- <Example>
/*
    EXEC OOP2009,0, 1
*/

 CREATE PROCEDURE OOP2009
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
		@ID VARCHAR(100),
		@DepartmentID VARCHAR(50),
		@SectionID VARCHAR(50),
		@SubsectionID VARCHAR(50),
		@ProcessID VARCHAR(50),
		@EmployeeID VARCHAR(100),
		@FullName NVARCHAR(250),
		@D01 VARCHAR(50),
		@D02 VARCHAR(50),
		@D03 VARCHAR(50),
		@D04 VARCHAR(50),
		@D05 VARCHAR(50),
		@D06 VARCHAR(50),
		@D07 VARCHAR(50),
		@D08 VARCHAR(50),
		@D09 VARCHAR(50),
		@D10 VARCHAR(50),
		@D11 VARCHAR(50),
		@D12 VARCHAR(50),
		@D13 VARCHAR(50),
		@D14 VARCHAR(50),
		@D15 VARCHAR(50),
		@D16 VARCHAR(50),
		@D17 VARCHAR(50),
		@D18 VARCHAR(50),
		@D19 VARCHAR(50),
		@D20 VARCHAR(50),
		@D21 VARCHAR(50),
		@D22 VARCHAR(50),
		@D23 VARCHAR(50),
		@D24 VARCHAR(50),
		@D25 VARCHAR(50),
		@D26 VARCHAR(50),
		@D27 VARCHAR(50),
		@D28 VARCHAR(50),
		@D29 VARCHAR(50),
		@D30 VARCHAR(50),
		@D31 VARCHAR(50),
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
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX)='',
		@Level INT,
		@EndMonth INT=0,
		@APK1 VARCHAR(50), --lưu giá trị APK cập nhật vào bảng
		@WorkDate DATETIME,
		@LeaveDate DATETIME,
		@Date DATETIME,
		@CustomerName int

SELECT @CustomerName = CustomerName from CustomerIndex
SET @TransactionID = NEWID()
SET @EndMonth=(SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))

IF @CustomerName = 81
BEGIN
	exec OOP2009_NEWTOYO @DivisionID, @UserID,@TranMonth,@TranYear,@Mode ,@ImportTransTypeID,@TransactionKey,@XML
END
ELSE
BEGIN

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2009]') AND TYPE IN (N'U'))
	DELETE OOT2009  WHERE DATEDIFF(DAY, CreateDate, GETDATE()) >= 1 -- xóa dữ liệu import thừa
	
INSERT INTO OOT2009([Row], DivisionID, TranMonth, TranYear, ID, [Description],
            DepartmentID, SectionID, SubsectionID, ProcessID, EmployeeID, FullName,
            D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14,
            D15  , D16, D17, D18, D19, D20, D21, D22, D23, D24, D25, D26, D27, D28,
            D29, D30, D31, Note, ApprovePersonID01, ApprovePersonID02,
            ApprovePersonID03, ApprovePersonID04, ApprovePersonID05,
            ApprovePersonID06, ApprovePersonID07,ApprovePersonID08,
            ApprovePersonID09,ApprovePersonID10,TransactionKey, TransactionID,  CreateDate,ErrorColumn,ErrorMessage)												
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
		X.Data.query('FullName').value('.', 'NVARCHAR(250)') AS FullName,
		X.Data.query('D01').value('.', 'VARCHAR(50)') AS D01,
		X.Data.query('D02').value('.', 'VARCHAR(50)') AS D02,
		X.Data.query('D03').value('.', 'VARCHAR(50)') AS D03,
		X.Data.query('D04').value('.', 'VARCHAR(50)') AS D04,
		X.Data.query('D05').value('.', 'VARCHAR(50)') AS D05,
		X.Data.query('D06').value('.', 'VARCHAR(50)') AS D06,
		X.Data.query('D07').value('.', 'VARCHAR(50)') AS D07,
		X.Data.query('D08').value('.', 'VARCHAR(50)') AS D08,
		X.Data.query('D09').value('.', 'VARCHAR(50)') AS D09,
		X.Data.query('D10').value('.', 'VARCHAR(50)') AS D10,
		X.Data.query('D11').value('.', 'VARCHAR(50)') AS D11,
		X.Data.query('D12').value('.', 'VARCHAR(50)') AS D12,
		X.Data.query('D13').value('.', 'VARCHAR(50)') AS D13,
		X.Data.query('D14').value('.', 'VARCHAR(50)') AS D14,
		X.Data.query('D15').value('.', 'VARCHAR(50)') AS D15,
		X.Data.query('D16').value('.', 'VARCHAR(50)') AS D16,
		X.Data.query('D17').value('.', 'VARCHAR(50)') AS D17,
		X.Data.query('D18').value('.', 'VARCHAR(50)') AS D18,
		X.Data.query('D19').value('.', 'VARCHAR(50)') AS D19,
		X.Data.query('D20').value('.', 'VARCHAR(50)') AS D20,
		X.Data.query('D21').value('.', 'VARCHAR(50)') AS D21,
		X.Data.query('D22').value('.', 'VARCHAR(50)') AS D22,
		X.Data.query('D23').value('.', 'VARCHAR(50)') AS D23,
		X.Data.query('D24').value('.', 'VARCHAR(50)') AS D24,
		X.Data.query('D25').value('.', 'VARCHAR(50)') AS D25,
		X.Data.query('D26').value('.', 'VARCHAR(50)') AS D26,
		X.Data.query('D27').value('.', 'VARCHAR(50)') AS D27,
		X.Data.query('D28').value('.', 'VARCHAR(50)') AS D28,
		X.Data.query('D29').value('.', 'VARCHAR(50)') AS D29,
		X.Data.query('D30').value('.', 'VARCHAR(50)') AS D30,
		X.Data.query('D31').value('.', 'VARCHAR(50)') AS D31,
		X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note,
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
		@TransactionKey AS TransactionKey, @TransactionID, GETDATE(),'',''
FROM @XML.nodes('//Data') AS X (Data)


--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM OOT2009 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE OOT2009 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000001' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

IF (SELECT TOP 1 (TranMonth + TranYear * 100) FROM OOT2009 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey) <> (@TranMonth + @TranYear * 100)    -- Kiểm tra kỳ kế toán hiện tại
BEGIN
	UPDATE OOT2009 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000002' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Period'),
					   ErrorColumn = 'Period'
	GOTO EndMessage
END

SET @Level=(SELECT LEVEL FROM OOT0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND TranMonth=@TranMonth AND TranYear=@TranYear AND AbsentType='BPC')
SET @Level=ISNULL(@Level,0)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row],'' ID,ISNULL(DepartmentID,'') DepartmentID,EmployeeID,FullName,
	ISNULL(SectionID,'') SectionID, ISNULL(SubsectionID,'') SubsectionID, 
	ISNULL(ProcessID,'') ProcessID,ISNULL(D01,'') D01,ISNULL(D02,'') D02,
	ISNULL(D03,'') D03,ISNULL(D04,'') D04,ISNULL(D05,'') D05,ISNULL(D06,'') D06,
	ISNULL(D07,'') D07,ISNULL(D08,'') D08,ISNULL(D09,'') D09,ISNULL(D10,'') D10,
	ISNULL(D11,'') D11,ISNULL(D12,'') D12,ISNULL(D13,'') D13,ISNULL(D14,'') D14,
	ISNULL(D15,'') D15,ISNULL(D16,'') D16,ISNULL(D17,'') D17,ISNULL(D18,'') D18,
	ISNULL(D19,'') D19,ISNULL(D20,'') D20,ISNULL(D21,'') D21,ISNULL(D22,'') D22,
	ISNULL(D23,'') D23,ISNULL(D24,'') D24,ISNULL(D25,'') D25,ISNULL(D26,'') D26,
	ISNULL(D27,'') D27,ISNULL(D28,'') D28,ISNULL(D29,'') D29,ISNULL(D30,'') D30,
	ISNULL(D31,'') D31,ISNULL(ApprovePersonID01,'') ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') ApprovePersonID02,ISNULL(ApprovePersonID03,'') ApprovePersonID03,
	ISNULL(ApprovePersonID04,'') ApprovePersonID04,ISNULL(ApprovePersonID05,'') ApprovePersonID05,
	ISNULL(ApprovePersonID06,'') ApprovePersonID06,ISNULL(ApprovePersonID07,'') ApprovePersonID07,
	ISNULL(ApprovePersonID08,'') ApprovePersonID08,ISNULL(ApprovePersonID09,'') ApprovePersonID09,
	ISNULL(ApprovePersonID10,'') ApprovePersonID10
	FROM OOT2009 WITH (NOLOCK) 
	WHERE TransactionID = @TransactionID
		
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@ID,@DepartmentID, @EmployeeID, @FullName,@SectionID,@SubsectionID, @ProcessID,@D01,
                          @D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''
---- Kiểm tra NV trong file import bị trùng

	IF EXISTS (SELECT TOP 1 1 FROM OOT2009 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND TransactionKey = @TransactionKey HAVING COUNT(1) > 1)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000038,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã Mã khối 
	IF @DepartmentID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WITH (NOLOCK) WHERE DepartmentID=@DepartmentID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000003,'
		SET @ErrorColumn = @ErrorColumn + 'DepartmentID,'				
		SET @ErrorFlag = 1
	END
	
---- Kiểm tra tồn tại mã Mã phòng nếu có nhập	
	IF @SectionID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WITH (NOLOCK) WHERE TeamID=@SectionID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000004,'
		SET @ErrorColumn = @ErrorColumn + 'SectionID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại mã Mã ban nếu có nhập	
	IF  @SubsectionID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WITH (NOLOCK) WHERE AnaID=@SubsectionID AND AnaTypeID='A04' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SubsectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000005,'
		SET @ErrorColumn = @ErrorColumn + 'SubsectionID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại mã Mã công đoạn nếu có nhập
	IF @ProcessID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WITH (NOLOCK) WHERE AnaID=@ProcessID AND AnaTypeID='A05' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProcessID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000006,'
		SET @ErrorColumn = @ErrorColumn + 'ProcessID,'				
		SET @ErrorFlag = 1
	END
---- tạo mã mới
IF @ID=''		
	BEGIN
		
		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
		SET @ID=(SELECT TOP 1 ID FROM OOT2009 WITH (NOLOCK) WHERE TransactionKey=@TransactionKey AND DepartmentID=@DepartmentID AND SectionID=@SectionID AND SubsectionID=@SubsectionID AND ProcessID=@ProcessID AND  ISNULL(ID,'') <>'')
		IF ISNULL(@ID,'')=''
		BEGIN
			CREATE TABLE #VoucherNo (APK VARCHAR(50), LastKey INT,VoucherNo VARCHAR(100))
			INSERT INTO #VoucherNo (APK, LastKey,VoucherNo)
			EXEC OOP0000 @DivisionID,@TranMonth,@TranYear,'OOT2000','BPC'
			SELECT @APK1 = APK, @ID = VoucherNo FROM #VoucherNo	
			
			UPDATE AT4444 SET LastKey = LastKey + 1 WHERE APK = @APK1
			DROP TABLE #VoucherNo
		END
		UPDATE OOT2009 SET ID = @ID WHERE Row=@Row AND  TransactionKey=@TransactionKey AND DepartmentID=@DepartmentID AND SectionID=@SectionID AND SubsectionID=@SubsectionID AND ProcessID=@ProcessID
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
	ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM HV1400 WITH (NOLOCK) WHERE EmployeeID=@EmployeeID)
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'FullName'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000009,'
		SET @ErrorColumn = @ErrorColumn + 'FullName,'				
		SET @ErrorFlag = 1
	END
		
---- Kiểm tra nhân viên đã được phân ca chưa
	IF EXISTS (SELECT TOP 1 1 FROM OOT2000 WITH (NOLOCK) 
	               LEFT JOIN OOT9000 WITH (NOLOCK) ON OOT9000.APK = OOT2000.APKMaster AND [Type] = 'BPC'
				   WHERE EmployeeID=@EmployeeID AND Tranmonth = @Tranmonth AND TranYear = @TranYear)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000032,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
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
	IF @SectionID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND TeamID <> @SectionID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END
	
	IF @SubsectionID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WITH (NOLOCK) WHERE EmployeeID = @EmployeeID AND Ana04ID <> @SubsectionID)
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

---- Kiểm tra thời gian sắp ca >= WorkDate
	CREATE TABLE #Temp (ShiftID VARCHAR(50), ShiftDate INT, ShiftDateTime DATETIME)
	INSERT INTO #Temp
	VALUES	(@D01, 1, DATEFROMPARTS(@TranYear,@TranMonth,1)),
			(@D02, 2, DATEFROMPARTS(@TranYear,@TranMonth,2)), 
			(@D03, 3, DATEFROMPARTS(@TranYear,@TranMonth,3)), 
			(@D04, 4, DATEFROMPARTS(@TranYear,@TranMonth,4)), 
			(@D05, 5, DATEFROMPARTS(@TranYear,@TranMonth,5)), 
			(@D06, 6, DATEFROMPARTS(@TranYear,@TranMonth,6)), 
			(@D07, 7, DATEFROMPARTS(@TranYear,@TranMonth,7)), 
			(@D08, 8, DATEFROMPARTS(@TranYear,@TranMonth,8)), 
			(@D09, 9, DATEFROMPARTS(@TranYear,@TranMonth,9)), 
			(@D10, 10, DATEFROMPARTS(@TranYear,@TranMonth,10)),
			(@D11, 11, DATEFROMPARTS(@TranYear,@TranMonth,11)), 
			(@D12, 12, DATEFROMPARTS(@TranYear,@TranMonth,12)), 
			(@D13, 13, DATEFROMPARTS(@TranYear,@TranMonth,13)), 
			(@D14, 14, DATEFROMPARTS(@TranYear,@TranMonth,14)), 
			(@D15, 15, DATEFROMPARTS(@TranYear,@TranMonth,15)), 
			(@D16, 16, DATEFROMPARTS(@TranYear,@TranMonth,16)), 
			(@D17, 17, DATEFROMPARTS(@TranYear,@TranMonth,17)), 
			(@D18, 18, DATEFROMPARTS(@TranYear,@TranMonth,18)), 
			(@D19, 19, DATEFROMPARTS(@TranYear,@TranMonth,19)), 
			(@D20, 20, DATEFROMPARTS(@TranYear,@TranMonth,20)), 
			(@D21, 21, DATEFROMPARTS(@TranYear,@TranMonth,21)), 
			(@D22, 22, DATEFROMPARTS(@TranYear,@TranMonth,22)), 
			(@D23, 23, DATEFROMPARTS(@TranYear,@TranMonth,23)), 
			(@D24, 24, DATEFROMPARTS(@TranYear,@TranMonth,24)), 
			(@D25, 25, DATEFROMPARTS(@TranYear,@TranMonth,25)), 
			(@D26, 26, DATEFROMPARTS(@TranYear,@TranMonth,26)), 
			(@D27, 27, DATEFROMPARTS(@TranYear,@TranMonth,27)), 
			(@D28, 28, DATEFROMPARTS(@TranYear,@TranMonth,28))

           
	--DECLARE @LastDate INT = DAY(DATEADD(DAY,-(DAY(CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))),DATEADD(MONTH,1,CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear))))) 
	DECLARE @WorkDateOrder INT, @LeaveDateOrder INT, @WorkDateMonth INT, @WorkDateYear INT, @LeaveDateMonth INT, @LeaveDateYear INT
	
	SET @WorkDateMonth = 0
	SET @WorkDateYear = 0
	SET @LeaveDateMonth = 0
	SET @LeaveDateYear = 0

	--IF @LastDate = 29 AND @TranMonth = 2
	--	INSERT INTO #Temp
	--	VALUES (@D31, CONVERT(VARCHAR(2),@TranMonth)+'/29/'+CONVERT(VARCHAR(4),@TranYear))
	--IF @LastDate = 31 AND @TranMonth <> 2
	--	INSERT INTO #Temp
	--	VALUES (@D29, CONVERT(DATETIME,STR(@TranMonth)+'/29/'+STR(@TranYear),120)), (@D30, CONVERT(DATETIME,STR(@TranMonth)+'/30/'+STR(@TranYear),120))
	--IF @LastDate = 31 AND @TranMonth <> 2
	--	INSERT INTO #Temp
	--	VALUES (@D31, CONVERT(VARCHAR(2),@TranMonth)+'/31/'+CONVERT(VARCHAR(4),@TranYear))	

	SET @WorkDate = (SELECT WorkDate FROM HT1403 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	SELECT @WorkDateOrder = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID,@TranMonth,@TranYear) WHERE [Date] = CONVERT(DATE,@WorkDate)
	SELECT @WorkDateMonth = TranMonth, @WorkDateYear = TranYear
		FROM HT9999 WHERE DivisionID = @DivisionID AND (@WorkDate BETWEEN BeginDate And EndDate)

	SET @LeaveDate = (SELECT MAX(LeaveDate) FROM HT1380 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID GROUP BY EmployeeID)
	SELECT @LeaveDateOrder = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID,@TranMonth,@TranYear) WHERE [Date] = CONVERT(DATE,@LeaveDate)
	SELECT @LeaveDateMonth = TranMonth, @LeaveDateYear = TranYear
		FROM HT9999 WHERE DivisionID = @DivisionID AND (@LeaveDate BETWEEN BeginDate And EndDate)

	IF @WorkDate IS NOT NULL AND ISNULL(@WorkDateMonth,0) <> 0 AND ISNULL(@WorkDateYear,0) <> 0
		AND EXISTS (SELECT TOP 1 1 FROM #Temp WHERE ((@WorkDateMonth + @WorkDateYear*100 > @TranMonth + @TranYear*100) OR (@WorkDateMonth + @WorkDateYear*100 = @TranMonth + @TranYear*100 AND ShiftDate < ISNULL(@WorkDateOrder,0)))  and Isnull(ShiftID,'') <> '')
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000049-'+CONVERT(VARCHAR(10),@WorkDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

	IF @LeaveDate IS NOT NULL AND @LeaveDateMonth IS NOT NULL AND @LeaveDateYear IS NOT NULL
		AND EXISTS (SELECT TOP 1 1 FROM #Temp WHERE ((@LeaveDateMonth + @LeaveDateYear*100 < @TranMonth + @TranYear*100) OR (@LeaveDateMonth + @LeaveDateYear*100 = @TranMonth + @TranYear*100 AND ShiftDate >= ISNULL(@LeaveDateOrder,99))) and Isnull(ShiftID,'') <> '')
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000053-'+CONVERT(VARCHAR(10),@LeaveDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

--- Kiểm tra Mã Ca 1 nếu có nhập
	IF @D01<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D01 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D01,'				
		SET @ErrorFlag = 1
	END
	IF @D01<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D01,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D01,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D01,'				
		SET @ErrorFlag = 1
	END



--- Kiểm tra Mã Ca 2 nếu có nhập
	IF @D02<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D02 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D02,'				
		SET @ErrorFlag = 1
	END
	IF @D02<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D02,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 3 nếu có nhập
	IF @D03<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D03 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D03,'				
		SET @ErrorFlag = 1
	END
	IF @D03<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D03,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D03,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D03,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 4 nếu có nhập
	IF @D04<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D04 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D04,'				
		SET @ErrorFlag = 1
	END
	IF @D04<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D04,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 5 nếu có nhập
	IF @D05<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D05 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D05,'				
		SET @ErrorFlag = 1
	END
	IF @D05<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D05,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 6 nếu có nhập
	IF @D06<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D06 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D06,'				
		SET @ErrorFlag = 1
	END
	IF @D06<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D06,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 7 nếu có nhập
	IF  @D07<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D07 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D07,'				
		SET @ErrorFlag = 1
	END
	IF @D07<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D07,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 8 nếu có nhập
	IF @D08<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D08 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D08,'				
		SET @ErrorFlag = 1
	END
	IF @D08<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D08,'				
		SET @ErrorFlag = 1
	END

--- Kiểm tra Mã Ca 9 nếu có nhập
	IF @D09<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D09 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D09,'				
		SET @ErrorFlag = 1
	END
	IF @D09<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D09,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 10 nếu có nhập
	IF @D10<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D10 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D10,'				
		SET @ErrorFlag = 1
	END
	IF @D10<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D10,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 11 nếu có nhập
	IF @D11<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D11 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D11,'				
		SET @ErrorFlag = 1
	END
	IF @D11<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D11,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 12 nếu có nhập
	IF @D12<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D12 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D12,'				
		SET @ErrorFlag = 1
	END
	IF @D12<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D12,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 13 nếu có nhập
	IF @D13<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D13 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D13,'				
		SET @ErrorFlag = 1
	END
	IF @D13<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D13,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 14 nếu có nhập
	IF @D14<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D14 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D14,'				
		SET @ErrorFlag = 1
	END
	IF @D14<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D14,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 15 nếu có nhập
	IF @D15<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D15 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D15,'				
		SET @ErrorFlag = 1
	END
	IF @D15<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D15,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 16 nếu có nhập
	IF @D16<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D16 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D16,'				
		SET @ErrorFlag = 1
	END
	IF @D16<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D16,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 17 nếu có nhập
	IF @D17<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D17 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D17,'				
		SET @ErrorFlag = 1
	END
	IF @D17<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D17,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 18 nếu có nhập
	IF @D18<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D18 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D18,'				
		SET @ErrorFlag = 1
	END
	IF @D18<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D18,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 19 nếu có nhập
	IF @D19<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D19 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D19,'				
		SET @ErrorFlag = 1
	END
	IF @D19<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D19,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 20 nếu có nhập
	IF @D20<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D20 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D20,'				
		SET @ErrorFlag = 1
	END
	IF @D20<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D20,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 21 nếu có nhập
	IF @D21<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D21 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D21,'				
		SET @ErrorFlag = 1
	END
	IF @D21<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D21,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 22 nếu có nhập
	IF @D22<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D22 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D22,'				
		SET @ErrorFlag = 1
	END
	IF @D22<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D22,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 23 nếu có nhập
	IF @D23<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D23 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D23,'				
		SET @ErrorFlag = 1
	END
	IF @D23<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D23,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 24 nếu có nhập
	IF @D24<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D24 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D24,'				
		SET @ErrorFlag = 1
	END
	IF @D24<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D24,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 25 nếu có nhập
	IF @D25<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D25 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D25,'				
		SET @ErrorFlag = 1
	END
	IF @D25<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D25,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 26 nếu có nhập
	IF @D26<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D26 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D26,'				
		SET @ErrorFlag = 1
	END
	IF @D26<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D26,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 27 nếu có nhập
	IF @D27<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D27 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D27,'				
		SET @ErrorFlag = 1
	END
	IF @D27<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D27,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 28 nếu có nhập
	IF @D28<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D28 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D28,'				
		SET @ErrorFlag = 1
	END
	IF @D28<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D28,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 29 nếu có nhập
IF @EndMonth>28
BEGIN
	INSERT INTO #Temp(ShiftID,ShiftDate,ShiftDateTime) VALUES(@D29,29,DATEFROMPARTS(@TranYear,@TranMonth,29))

	IF @D29<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D29 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D29'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D29,'				
		SET @ErrorFlag = 1
	END
	IF @D29<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D29'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D29,'				
		SET @ErrorFlag = 1
	END
END 
--- Kiểm tra Mã Ca 30 nếu có nhập
IF @EndMonth>29
BEGIN
	INSERT INTO #Temp(ShiftID,ShiftDate,ShiftDateTime) VALUES(@D30,30,DATEFROMPARTS(@TranYear,@TranMonth,30))

	IF @D30<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D30 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D30'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D30,'				
		SET @ErrorFlag = 1
	END
	IF @D30<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D30'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D30,'				
		SET @ErrorFlag = 1
	END
END 
--- Kiểm tra Mã Ca 31 nếu có nhập
IF @EndMonth>30
BEGIN
	INSERT INTO #Temp(ShiftID,ShiftDate,ShiftDateTime) VALUES(@D31,31,DATEFROMPARTS(@TranYear,@TranMonth,31))

	IF @D31<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WITH (NOLOCK) WHERE ShiftID=@D31 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D31'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D31,'				
		SET @ErrorFlag = 1
	END
	IF @D31<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20 WITH (NOLOCK) 
									 INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D31'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D31,'				
		SET @ErrorFlag = 1
	END
END 

-- Kiểm tra sắp ca thử việc (_TV) nếu ph trong thời gian thử việc
	DECLARE @FromApprenticeTime DATETIME,
			@ToApprenticeTime DATETIME
	SELECT @FromApprenticeTime = ISNULL(FromApprenticeTime,''),
		   @ToApprenticeTime = ISNULL(ToApprenticeTime,'') 
	FROM HT1403 WITH (NOLOCK) 
	WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID
	IF EXISTS ( SELECT TOP 1 1 FROM #Temp T1
				INNER JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
				WHERE T2.DivisionID = @DivisionID
				AND T1.ShiftDateTime BETWEEN @FromApprenticeTime AND @ToApprenticeTime 
				AND ISNULL(T1.ShiftID,'') <> ''
				AND ISNULL(IsApprenticeShift,0) = 0
				)
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000064-'+CONVERT(VARCHAR(10),@FromApprenticeTime,103)+'-'+CONVERT(VARCHAR(10),@ToApprenticeTime,103)+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

	DROP TABLE #Temp

--- Kiểm tra người duyệt 1
IF @Level >0
BEGIN
	IF @ApprovePersonID01=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID01
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID01 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
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
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID01 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 2
IF @Level >1
BEGIN
	IF @ApprovePersonID02=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 	
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID02
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID02 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
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
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID02 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
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
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID03
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID03 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID03
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID03
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 4
IF @Level >3
BEGIN
	IF @ApprovePersonID04=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID04
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID04 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID04
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID04
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 5
IF @Level >4
BEGIN
	IF @ApprovePersonID05=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID05
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID05 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID05
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID05
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
				SET @ErrorFlag = 1
			END
		END
	END 
END
--- Kiểm tra người duyệt 6
IF @Level >5
BEGIN
	IF @ApprovePersonID06=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID06
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID06 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID06
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID06
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 7
IF @Level >6
BEGIN
	IF @ApprovePersonID07=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID07
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID07 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID07
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID07
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 8
IF @Level >7
BEGIN
	IF @ApprovePersonID08=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID08
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID08 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID08
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID08
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 9
IF @Level >8
BEGIN
	IF @ApprovePersonID09=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID09
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID09 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID09
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID09
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
													) + CONVERT(VARCHAR,@Row) + '-ASML000075,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
				SET @ErrorFlag = 1
			END
		END
	END
END
--- Kiểm tra người duyệt 10
IF @Level >9
BEGIN
	IF @ApprovePersonID10=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF (SELECT ISNULL(CustomerName,-1) FROM CustomerIndex) = 50 ---MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE (H14.EmployeeID=@ApprovePersonID10
			                                        AND H14.DepartmentID = @DepartmentID
			                                        --AND ((@SectionID='' AND 1=1 ) OR (H14.TeamID =@SectionID)) 
			                                        --AND ((@SubsectionID='' AND 1=1 ) OR (H14.Ana03ID =@SubsectionID)) 
			                                        --AND ((@ProcessID='' AND 1=1 ) OR (H14.Ana04ID =@ProcessID)) 
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
													OR @ApprovePersonID10 in ('J2402','005273'))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
													WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
													) + CONVERT(VARCHAR,@Row) + '-OOFML000012,'
				SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
				SET @ErrorFlag = 1
			END

			-- Check thêm người duyệt có nằm trong chức vụ được thiết lập được duyệt hay không ở bảng OOT0010, OOT0011 theo tháng.
				IF NOT EXISTS (
					SELECT TOP 1 1 FROM HT1403 WITH (NOLOCK) 
					INNER JOIN OOT0011 ON OOT0011.DutyID = HT1403.DutyID
					INNER JOIN OOT0010 ON OOT0010.APK = OOT0011.APKMaster
					WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @ApprovePersonID10
				)
				BEGIN
						SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
															WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
															) + CONVERT(VARCHAR,@Row) + '-HRMFML000040,'
						SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
						SET @ErrorFlag = 1
				END 
		END
		ELSE ---<> MEIKO
		BEGIN
			IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14 WITH (NOLOCK) 
												  INNER JOIN OOT0011 O11 WITH (NOLOCK) ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='BPC'
												    INNER JOIN OOT0010 O10 WITH (NOLOCK) ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			                                        WHERE H14.EmployeeID=@ApprovePersonID10
			                                        AND O10.TranMonth=@TranMonth
			                                        AND O10.TranYear=@TranYear
													AND H14.EmployeeStatus NOT IN (4,9))
			BEGIN	
				SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
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
		UPDATE OOT2009 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END
	
	FETCH NEXT FROM @Cur INTO  @Row,@ID,@DepartmentID, @EmployeeID, @FullName,@SectionID,@SubsectionID, @ProcessID,@D01,
                          @D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
END
CLOSE @Cur


IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2009 WITH (NOLOCK) WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
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
			DepartmentID, 'BPC' Type,SectionID, SubsectionID, ProcessID
			FROM OOT2009 WITH (NOLOCK)
			WHERE TransactionKey=@TransactionKey
			GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
		)A
		-- Insert bảng phân ca
		INSERT INTO OOT2000(APKMaster,DivisionID, EmployeeID, D01, D02, D03, D04, D05, D06,
		            D07, D08, D09, D10, D11, D12, D13, D14, D15, D16, D17, D18,
		            D19, D20, D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
		            D31, Note, DeleteFlag, ApproveLevel, ApprovingLevel)
		SELECT OOT9.APK,OOT2009.DivisionID,EmployeeID, D01, D02, D03, D04, D05, D06, D07,
		       D08, D09, D10, D11, D12, D13, D14, D15,  D16,D17, D18, D19, D20,
		       D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31, Note,0, @Level,0
		FROM OOT2009 WITH (NOLOCK)
		INNER JOIN OOT9000 OOT9 WITH (NOLOCK) ON OOT9.DivisionID = OOT2009.DivisionID AND OOT9.TranMonth = OOT2009.TranMonth AND OOT9.TranYear = OOT2009.TranYear AND OOT9.ID = OOT2009.ID
		WHERE TransactionKey=@TransactionKey
		--- Insert người duyệt
		DECLARE @i INT = 1, @s VARCHAR(2),@sSQL NVARCHAR(MAX)
		WHILE @i <= @Level
		BEGIN
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
			SET @sSQL='
			INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status])
			SELECT A.DivisionID,OOT9.APK,ApprovePersonID,'+str(@i)+',0,0
			FROM
			(
				SELECT  DivisionID, TranMonth, TranYear, ID, 
				DepartmentID,SectionID, SubsectionID, ProcessID,MAX(ApprovePersonID'+@s+') ApprovePersonID
				FROM OOT2009 WITH (NOLOCK)
				WHERE TransactionKey='''+@TransactionKey+'''
				GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
			)A
			INNER JOIN OOT9000 OOT9 WITH (NOLOCK) ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.ID '
			--PRINT (@sSQL)
			EXEC (@sSQL)
			SET @i = @i + 1		
		END	
	END
	
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM OOT2009 WITH (NOLOCK) 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
