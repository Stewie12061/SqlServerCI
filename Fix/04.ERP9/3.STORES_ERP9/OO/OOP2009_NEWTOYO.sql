IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2009_NEWTOYO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2009_NEWTOYO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Import bảng phân ca NEW TOYO
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Nhật Thanh on 11/08/2022
---- Modified by: Đình Định on 11/05/2023  - Bổ sung kiểm tra tồn tại mã nhân viên trong hồ sơ lương.
---- Modified by: Kiều Nga on 22/05/2023  - Fix lỗi import bảng phân ca không tách đơn theo người duyệt

-- <Example>
/*
    EXEC OOP2009,0, 1
*/

 CREATE PROCEDURE OOP2009_NEWTOYO
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
		@CurApproveType CURSOR,
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
		@OTLevel Tinyint,
		@LevelNo int,
		@CaseID int,
		@ApproveTypeID1 VARCHAR(50), 
		@ConditionFrom VARCHAR(50),
		@ConditionTo VARCHAR(50),
		@DepartmentIDCur VARCHAR(50),
		@ContactPerson VARCHAR(50),
		@sSQLApprovePerson VARCHAR(250),
		@apk9002 UNIQUEIDENTIFIER,
		@Note VARCHAR(250),
		@Description VARCHAR(250),
		@TotalRow Int
SET @TransactionID = NEWID()
SET @EndMonth=(SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))

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
IF (SELECT TOP 1 DivisionID FROM OOT2009 WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE OOT2009 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000001' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

IF (SELECT TOP 1 (TranMonth + TranYear * 100) FROM OOT2009 WHERE TransactionKey = @TransactionKey) <> (@TranMonth + @TranYear * 100)    -- Kiểm tra kỳ kế toán hiện tại
BEGIN
	UPDATE OOT2009 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000002' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Period'),
					   ErrorColumn = 'Period'
	GOTO EndMessage
END

SET @Level=(SELECT LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND TranMonth=@TranMonth AND TranYear=@TranYear AND AbsentType='BPC')
SET @Level=ISNULL(@Level,0)
SELECT @TotalRow = 10
----------------------------------
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row],'' ID, [Description],ISNULL(DepartmentID,'') DepartmentID,EmployeeID,FullName,
	ISNULL(SectionID,'') SectionID, ISNULL(SubsectionID,'') SubsectionID, 
	ISNULL(ProcessID,'') ProcessID,ISNULL(D01,'') D01,ISNULL(D02,'') D02,
	ISNULL(D03,'') D03,ISNULL(D04,'') D04,ISNULL(D05,'') D05,ISNULL(D06,'') D06,
	ISNULL(D07,'') D07,ISNULL(D08,'') D08,ISNULL(D09,'') D09,ISNULL(D10,'') D10,
	ISNULL(D11,'') D11,ISNULL(D12,'') D12,ISNULL(D13,'') D13,ISNULL(D14,'') D14,
	ISNULL(D15,'') D15,ISNULL(D16,'') D16,ISNULL(D17,'') D17,ISNULL(D18,'') D18,
	ISNULL(D19,'') D19,ISNULL(D20,'') D20,ISNULL(D21,'') D21,ISNULL(D22,'') D22,
	ISNULL(D23,'') D23,ISNULL(D24,'') D24,ISNULL(D25,'') D25,ISNULL(D26,'') D26,
	ISNULL(D27,'') D27,ISNULL(D28,'') D28,ISNULL(D29,'') D29,ISNULL(D30,'') D30,
	ISNULL(D31,'') D31, Note,ISNULL(ApprovePersonID01,'') ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') ApprovePersonID02,ISNULL(ApprovePersonID03,'') ApprovePersonID03,
	ISNULL(ApprovePersonID04,'') ApprovePersonID04,ISNULL(ApprovePersonID05,'') ApprovePersonID05,
	ISNULL(ApprovePersonID06,'') ApprovePersonID06,ISNULL(ApprovePersonID07,'') ApprovePersonID07,
	ISNULL(ApprovePersonID08,'') ApprovePersonID08,ISNULL(ApprovePersonID09,'') ApprovePersonID09,
	ISNULL(ApprovePersonID10,'') ApprovePersonID10
	FROM OOT2009 
	WHERE TransactionID = @TransactionID
		
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@ID, @Description,@DepartmentID, @EmployeeID, @FullName,@SectionID,@SubsectionID, @ProcessID,@D01,
                          @D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @Note, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
WHILE @@FETCH_STATUS = 0
BEGIN

	---------------------------------------------------------- TEST INPUT ------------------------------------------------------
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''
---- Kiểm tra NV trong file import bị trùng

	--IF EXISTS (SELECT TOP 1 1 FROM OOT2009 WHERE EmployeeID = @EmployeeID AND TransactionKey = @TransactionKey HAVING COUNT(1) > 1)		
	--BEGIN
	--	SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
	--										WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
	--										) + CONVERT(VARCHAR,@Row) + '-OOFML000038,'
	--	SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
	--	SET @ErrorFlag = 1
	--END

	--- Kiểm tra tồn tại mã nhân viên trong hồ sơ lương.
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT2400 WHERE EmployeeID=@EmployeeID AND Tranmonth = @Tranmonth AND TranYear = @TranYear)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											  WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000068,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã Mã khối 
	IF @DepartmentID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WHERE DepartmentID=@DepartmentID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000003,'
		SET @ErrorColumn = @ErrorColumn + 'DepartmentID,'				
		SET @ErrorFlag = 1
	END
	
---- Kiểm tra tồn tại mã Mã phòng nếu có nhập	
	IF @SectionID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WHERE TeamID=@SectionID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000004,'
		SET @ErrorColumn = @ErrorColumn + 'SectionID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại mã Mã ban nếu có nhập	
	IF  @SubsectionID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE AnaID=@SubsectionID AND AnaTypeID='A04' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SubsectionID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000005,'
		SET @ErrorColumn = @ErrorColumn + 'SubsectionID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại mã Mã công đoạn nếu có nhập
	IF @ProcessID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE AnaID=@ProcessID AND AnaTypeID='A05' AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ProcessID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000006,'
		SET @ErrorColumn = @ErrorColumn + 'ProcessID,'				
		SET @ErrorFlag = 1
	END
		IF EXISTS (SELECT TOP 1 1 FROM OOT2009 WHERE EmployeeID = @EmployeeID AND TransactionKey = @TransactionKey HAVING COUNT(1) > 1)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000038,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END
	---- Kiểm tra tồn tại mã mã nhân viên và tên nhân viên
	--IF NOT EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID=@EmployeeID AND EmployeeStatus NOT IN (4,9))		
	--BEGIN
	--	SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
	--										WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
	--										) + CONVERT(VARCHAR,@Row) + '-OOFML000008,'
	--	SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
	--	SET @ErrorFlag = 1
	--END
	--ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM HV1400 WHERE EmployeeID=@EmployeeID)
	--BEGIN
	--	SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
	--										WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'FullName'
	--										) + CONVERT(VARCHAR,@Row) + '-OOFML000009,'
	--	SET @ErrorColumn = @ErrorColumn + 'FullName,'				
	--	SET @ErrorFlag = 1
	--END

------ Kiểm tra nhân viên đã được phân ca chưa
--	IF EXISTS (SELECT TOP 1 1 FROM OOT2000 
--	               LEFT JOIN OOT9000 ON OOT9000.APK = OOT2000.APKMaster AND [Type] = 'BPC'
--				   WHERE EmployeeID=@EmployeeID AND Tranmonth = @Tranmonth AND TranYear = @TranYear)		
--	BEGIN
--		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
--											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
--											) + CONVERT(VARCHAR,@Row) + '-OOFML000032,'
--		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
--		SET @ErrorFlag = 1
--	END
	
--- Kiểm tra nhân viên có thuộc Khối import 
	IF EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND DepartmentID <> @DepartmentID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END
--- Kiểm tra nhân viên có thuộc Phòng, ban, công đoạn import nếu có nhập
	IF @SectionID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND TeamID <> @SectionID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END
	
	IF @SubsectionID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND Ana04ID <> @SubsectionID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-OOFML000031,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END

	IF @ProcessID<>'' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND Ana05ID <> @ProcessID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
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
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000049-'+CONVERT(VARCHAR(10),@WorkDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

	IF @LeaveDate IS NOT NULL AND @LeaveDateMonth IS NOT NULL AND @LeaveDateYear IS NOT NULL
		AND EXISTS (SELECT TOP 1 1 FROM #Temp WHERE ((@LeaveDateMonth + @LeaveDateYear*100 < @TranMonth + @TranYear*100) OR (@LeaveDateMonth + @LeaveDateYear*100 = @TranMonth + @TranYear*100 AND ShiftDate >= ISNULL(@LeaveDateOrder,99))) and Isnull(ShiftID,'') <> '')
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000053-'+CONVERT(VARCHAR(10),@LeaveDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

--- Kiểm tra Mã Ca 1 nếu có nhập
	IF @D01<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D01 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D01,'				
		SET @ErrorFlag = 1
	END
	IF @D01<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D01,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D01,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D01,'				
		SET @ErrorFlag = 1
	END



--- Kiểm tra Mã Ca 2 nếu có nhập
	IF @D02<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D02 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D02,'				
		SET @ErrorFlag = 1
	END
	IF @D02<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D02,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 3 nếu có nhập
	IF @D03<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D03 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D03,'				
		SET @ErrorFlag = 1
	END
	IF @D03<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D03,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D03,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D03,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 4 nếu có nhập
	IF @D04<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D04 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D04,'				
		SET @ErrorFlag = 1
	END
	IF @D04<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D04,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 5 nếu có nhập
	IF @D05<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D05 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D05,'				
		SET @ErrorFlag = 1
	END
	IF @D05<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D05,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 6 nếu có nhập
	IF @D06<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D06 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D06,'				
		SET @ErrorFlag = 1
	END
	IF @D06<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D06,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 7 nếu có nhập
	IF  @D07<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D07 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D07,'				
		SET @ErrorFlag = 1
	END
	IF @D07<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D07,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 8 nếu có nhập
	IF @D08<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D08 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D08,'				
		SET @ErrorFlag = 1
	END
	IF @D08<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>'' ) 
				     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D08,'				
		SET @ErrorFlag = 1
	END

--- Kiểm tra Mã Ca 9 nếu có nhập
	IF @D09<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D09 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D09,'				
		SET @ErrorFlag = 1
	END
	IF @D09<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D09,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 10 nếu có nhập
	IF @D10<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D10 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D10,'				
		SET @ErrorFlag = 1
	END
	IF @D10<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D10,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 11 nếu có nhập
	IF @D11<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D11 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D11,'				
		SET @ErrorFlag = 1
	END
	IF @D11<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D11,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 12 nếu có nhập
	IF @D12<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D12 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D12,'				
		SET @ErrorFlag = 1
	END
	IF @D12<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D12,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 13 nếu có nhập
	IF @D13<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D13 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D13,'				
		SET @ErrorFlag = 1
	END
	IF @D13<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D13,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 14 nếu có nhập
	IF @D14<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D14 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D14,'				
		SET @ErrorFlag = 1
	END
	IF @D14<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D14,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 15 nếu có nhập
	IF @D15<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D15 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D15,'				
		SET @ErrorFlag = 1
	END
	IF @D15<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D15,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 16 nếu có nhập
	IF @D16<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D16 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D16,'				
		SET @ErrorFlag = 1
	END
	IF @D16<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D16,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 17 nếu có nhập
	IF @D17<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D17 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D17,'				
		SET @ErrorFlag = 1
	END
	IF @D17<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D17,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 18 nếu có nhập
	IF @D18<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D18 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D18,'				
		SET @ErrorFlag = 1
	END
	IF @D18<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D18,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 19 nếu có nhập
	IF @D19<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D19 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D19,'				
		SET @ErrorFlag = 1
	END
	IF @D19<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D19,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 20 nếu có nhập
	IF @D20<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D20 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D20,'				
		SET @ErrorFlag = 1
	END
	IF @D20<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D20,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 21 nếu có nhập
	IF @D21<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D21 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D21,'				
		SET @ErrorFlag = 1
	END
	IF @D21<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D21,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 22 nếu có nhập
	IF @D22<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D22 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D22,'				
		SET @ErrorFlag = 1
	END
	IF @D22<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D22,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 23 nếu có nhập
	IF @D23<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D23 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D23,'				
		SET @ErrorFlag = 1
	END
	IF @D23<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D23,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 24 nếu có nhập
	IF @D24<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D24 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D24,'				
		SET @ErrorFlag = 1
	END
	IF @D24<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D24,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 25 nếu có nhập
	IF @D25<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D25 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D25,'				
		SET @ErrorFlag = 1
	END
	IF @D25<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D25,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 26 nếu có nhập
	IF @D26<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D26 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D26,'				
		SET @ErrorFlag = 1
	END
	IF @D26<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D26,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 27 nếu có nhập
	IF @D27<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D27 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D27,'				
		SET @ErrorFlag = 1
	END
	IF @D27<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D27,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 28 nếu có nhập
	IF @D28<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D28 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D28,'				
		SET @ErrorFlag = 1
	END
	IF @D28<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
		SET @ErrorColumn = @ErrorColumn + 'D28,'				
		SET @ErrorFlag = 1
	END
--- Kiểm tra Mã Ca 29 nếu có nhập
IF @EndMonth>28
BEGIN
	INSERT INTO #Temp(ShiftID,ShiftDate,ShiftDateTime) VALUES(@D29,29,DATEFROMPARTS(@TranYear,@TranMonth,29))

	IF @D29<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D29 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D29'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D29,'				
		SET @ErrorFlag = 1
	END
	IF @D29<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
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

	IF @D30<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D30 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D30'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D30,'				
		SET @ErrorFlag = 1
	END
	IF @D30<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
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

	IF @D31<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D31 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D31'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D31,'				
		SET @ErrorFlag = 1
	END
	IF @D31<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>'' ) 
				     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
									 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
				                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>''))	
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
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
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000064-'+CONVERT(VARCHAR(10),@FromApprenticeTime,103)+'-'+CONVERT(VARCHAR(10),@ToApprenticeTime,103)+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

	DROP TABLE #Temp

		
	IF @ErrorColumn <> ''
	BEGIN
		UPDATE OOT2009 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END

	------------------------------------------------------- TÁCH ĐƠN --------------------------------------------------
	IF OBJECT_ID('tempdb..#OOT2009_00') IS NOT NULL
		DROP TABLE #OOT2009_00
	IF OBJECT_ID('tempdb..#OOT2009_01') IS NOT NULL
		DROP TABLE #OOT2009_01
	IF OBJECT_ID('tempdb..#OOT2009_02') IS NOT NULL
		DROP TABLE #OOT2009_02
	IF OBJECT_ID('tempdb..#OOT2009_03') IS NOT NULL
		DROP TABLE #OOT2009_03
	IF OBJECT_ID('tempdb..#OOT2009_04') IS NOT NULL
		DROP TABLE #OOT2009_04
	IF OBJECT_ID('tempdb..#OOT2009_05') IS NOT NULL
		DROP TABLE #OOT2009_05
	IF OBJECT_ID('tempdb..#OOT2009_06') IS NOT NULL
		DROP TABLE #OOT2009_06
	SET @OTLevel = 0


	-- Lấy thêm dữ liệu từ bảng phân ca lũy kế ngày đã phân ca trước đó
	SELECT OT209.EmployeeID, OT209.TranMonth, OT209.TranYear, CASE WHEN ISNULL(OT209.D01,'')='' then HT25.D01 else OT209.D01 end D01, 
	CASE WHEN ISNULL(OT209.D02,'')='' then HT25.D02 else OT209.D02 end D02, CASE WHEN ISNULL(OT209.D03,'')='' then HT25.D03 else OT209.D03 end D03, 
	CASE WHEN ISNULL(OT209.D04,'')='' then HT25.D04 else OT209.D04 end D04, CASE WHEN ISNULL(OT209.D05,'')='' then HT25.D05 else OT209.D05 end D05,
	CASE WHEN ISNULL(OT209.D06,'')='' then HT25.D06 else OT209.D06 end D06, CASE WHEN ISNULL(OT209.D07,'')='' then HT25.D07 else OT209.D07 end D07, 
	CASE WHEN ISNULL(OT209.D08,'')='' then HT25.D08 else OT209.D08 end D08, CASE WHEN ISNULL(OT209.D09,'')='' then HT25.D09 else OT209.D09 end D09, 
	CASE WHEN ISNULL(OT209.D10,'')='' then HT25.D10 else OT209.D10 end D10, CASE WHEN ISNULL(OT209.D11,'')='' then HT25.D11 else OT209.D11 end D11, 
	CASE WHEN ISNULL(OT209.D12,'')='' then HT25.D12 else OT209.D12 end D12, CASE WHEN ISNULL(OT209.D13,'')='' then HT25.D13 else OT209.D13 end D13, 
	CASE WHEN ISNULL(OT209.D14,'')='' then HT25.D14 else OT209.D14 end D14, CASE WHEN ISNULL(OT209.D15,'')='' then HT25.D15 else OT209.D15 end D15, 
	CASE WHEN ISNULL(OT209.D16,'')='' then HT25.D16 else OT209.D16 end D16, CASE WHEN ISNULL(OT209.D17,'')='' then HT25.D17 else OT209.D17 end D17, 
	CASE WHEN ISNULL(OT209.D18,'')='' then HT25.D18 else OT209.D18 end D18, CASE WHEN ISNULL(OT209.D19,'')='' then HT25.D19 else OT209.D19 end D19, 
	CASE WHEN ISNULL(OT209.D20,'')='' then HT25.D20 else OT209.D20 end D20, CASE WHEN ISNULL(OT209.D21,'')='' then HT25.D21 else OT209.D21 end D21, 
	CASE WHEN ISNULL(OT209.D22,'')='' then HT25.D22 else OT209.D22 end D22, CASE WHEN ISNULL(OT209.D23,'')='' then HT25.D23 else OT209.D23 end D23, 
	CASE WHEN ISNULL(OT209.D24,'')='' then HT25.D24 else OT209.D24 end D24, CASE WHEN ISNULL(OT209.D25,'')='' then HT25.D25 else OT209.D25 end D25, 
	CASE WHEN ISNULL(OT209.D26,'')='' then HT25.D26 else OT209.D26 end D26, CASE WHEN ISNULL(OT209.D27,'')='' then HT25.D27 else OT209.D27 end D27, 
	CASE WHEN ISNULL(OT209.D28,'')='' then HT25.D28 else OT209.D28 end D28, CASE WHEN ISNULL(OT209.D29,'')='' then HT25.D29 else OT209.D29 end D29, 
	CASE WHEN ISNULL(OT209.D30,'')='' then HT25.D30 else OT209.D30 end D30, CASE WHEN ISNULL(OT209.D31,'')='' then HT25.D31 else OT209.D31 end D31,  OT209.TransactionID
	INTO #OOT2009_00
	from OOT2009 OT209
	left join ht1025 HT25 on OT209.EmployeeID = HT25.EmployeeID and OT209.tranmonth = HT25.tranmonth and OT209.tranyear = HT25.tranyear
	 WHERe OT209.EmployeeID = @EmployeeID and OT209.TransactionID = @TransactionID
	 
	 --select * from #OOT2009_0

	SELECT EmployeeID, ShiftID,WorkShiftID,CONCAT(FORMAT(@TranMonth,'00'),'/' ,REPLACE(ShiftID,'D',''),'/', @TranYear) AS Date,
	CASE WHEN ISDATE(CONCAT(FORMAT(TranMonth,'00'),'/' ,REPLACE(ShiftID,'D',''),'/', TranYear))=1 THEN datename(dw,CONCAT(FORMAT(TranMonth,'00'),'/' ,REPLACE(ShiftID,'D',''),'/', TranYear)) ELSE null END as DayInWeek,
	@TranMonth as TranMonth, @TranYear as TranYear
	INTO #OOT2009_01
	FROM #OOT2009_00
	UNPIVOT (
	WorkShiftID FOR ShiftID IN (
	D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
	D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
	D31
	)
	) unpvt

	SELECT COUNT(*) OVER () AS TotalRow, ROW_NUMBER() OVER (ORDER BY Date) AS RowNum,#OOT2009_01.*,HT1026.Holiday, NULL as CaseID, NULL as ApprovePersonID01
	INTO #OOT2009_02
	FROM #OOT2009_01
	LEFT JOIN HT1021 ON WorkShiftID = HT1021.ShiftID and SUBSTRING(DayInWeek,1,3) = HT1021.DateTypeID
	LEFT JOIN HT1026 on Date = HT1026.Holiday
	WHERE HT1021.IsOvertime=1
	ORDER BY Date
	 
	-- Cập nhật lại những ngày là ngày lễ
	Update #OOT2009_02 set DayInWeek='Holiday' where Holiday is not null
	
	--select * from #OOT2009_02
	
	-- Tra người duyệt theo thiết lập xét duyệt BPC
	SET @CurApproveType = CURSOR SCROLL KEYSET FOR
	SELECT CaseID,ApproveTypeID1, ConditionFrom, ConditionTo
        FROM ST0010 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID
        AND TypeID = 'BPC'
		GROUP BY CaseID,ApproveTypeID1, ConditionFrom, ConditionTo
		Order by CaseID desc
	Open @CurApproveType
	FETCH NEXT FROM @CurApproveType INTO @CaseID,@ApproveTypeID1, @ConditionFrom, @ConditionTo
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@ApproveTypeID1='L01') -- Loại ngày
		BEGIN
			update #OOT2009_02 set CaseID=@CaseID where SUBSTRING(DayInWeek,1,3) in (select * from SplitString(@ConditionFrom,','))
		END
		ELSE
		IF (@ApproveTypeID1='L02') -- Số ngày
		BEGIN
			update #OOT2009_02 set CaseID=@CaseID where RowNum>=@ConditionFrom and RowNum<=@ConditionTo
		END

		FETCH NEXT FROM @CurApproveType INTO @CaseID,@ApproveTypeID1, @ConditionFrom, @ConditionTo  
	END
	CLOSE @CurApproveType
	DEALLOCATE @CurApproveType  
	
	select EmployeeID,Max(D01) D01,MAX(D02) D02,MAX(D03) D03,MAX(D04) D04 ,MAX(D05) D05 ,MAX(D06) D06 ,MAX(D07) D07, MAX(D08) D08 
	,MAX(D09) D09 ,MAX(D10) D10,MAX(D11) D11 ,MAX(D12) D12 ,MAX(D13) D13 ,MAX(D14) D14 ,MAX(D15) D15 ,MAX(D16) D16 ,MAX(D17) D17 
	,MAX(D18) D18 ,MAX(D19) D19 ,MAX(D20) D20 ,MAX(D21) D21 ,MAX(D22) D22 ,MAX(D23) D23 ,MAX(D24) D24 ,MAX(D25) D25 ,MAX(D26) D26 
	,MAX(D27) D27 ,MAX(D28) D28 ,MAX(D29) D29 ,MAX(D30) D30 ,MAX(D31) D31, CaseID
	into #OOT2009_03
	from #OOT2009_02
	PIVOT (
	MAX(WorkShiftID) for ShiftID in (
	D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
	D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
	D31
	)
	) pvt
	group by EmployeeID, CaseID

	--select * from #OOT2009_03

	SELECT EmployeeID,D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
	D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
	D31
	INTO #OOT2009_04
	FROM OOT2009 OT209 
	where OT209.TransactionID = @TransactionID AND OT209.EmployeeID = @EmployeeID

	UPDATE TEMP
	SET 
	TEMP.D01 =  CASE WHEN ISNULL(OT209.D01,'')!='' THEN TEMP.D01 ELSE OT209.D01 END,
	TEMP.D02 =  CASE WHEN ISNULL(OT209.D02,'')!='' THEN TEMP.D02 ELSE OT209.D02 END,
	TEMP.D03 =  CASE WHEN ISNULL(OT209.D03,'')!='' THEN TEMP.D03 ELSE OT209.D03 END,
	TEMP.D04 =  CASE WHEN ISNULL(OT209.D04,'')!='' THEN TEMP.D04 ELSE OT209.D04 END,
	TEMP.D05 =  CASE WHEN ISNULL(OT209.D05,'')!='' THEN TEMP.D05 ELSE OT209.D05 END,
	TEMP.D06 =  CASE WHEN ISNULL(OT209.D06,'')!='' THEN TEMP.D06 ELSE OT209.D06 END,
	TEMP.D07 =  CASE WHEN ISNULL(OT209.D07,'')!='' THEN TEMP.D07 ELSE OT209.D07 END,
	TEMP.D08 =  CASE WHEN ISNULL(OT209.D08,'')!='' THEN TEMP.D08 ELSE OT209.D08 END,
	TEMP.D09 =  CASE WHEN ISNULL(OT209.D09,'')!='' THEN TEMP.D09 ELSE OT209.D09 END,
	TEMP.D10 =  CASE WHEN ISNULL(OT209.D10,'')!='' THEN TEMP.D10 ELSE OT209.D10 END,
	TEMP.D11 =  CASE WHEN ISNULL(OT209.D11,'')!='' THEN TEMP.D11 ELSE OT209.D11 END,
	TEMP.D12 =  CASE WHEN ISNULL(OT209.D12,'')!='' THEN TEMP.D12 ELSE OT209.D12 END,
	TEMP.D13 =  CASE WHEN ISNULL(OT209.D13,'')!='' THEN TEMP.D13 ELSE OT209.D13 END,
	TEMP.D14 =  CASE WHEN ISNULL(OT209.D14,'')!='' THEN TEMP.D14 ELSE OT209.D14 END,
	TEMP.D15 =  CASE WHEN ISNULL(OT209.D15,'')!='' THEN TEMP.D15 ELSE OT209.D15 END,
	TEMP.D16 =  CASE WHEN ISNULL(OT209.D16,'')!='' THEN TEMP.D16 ELSE OT209.D16 END,
	TEMP.D17 =  CASE WHEN ISNULL(OT209.D17,'')!='' THEN TEMP.D17 ELSE OT209.D17 END,
	TEMP.D18 =  CASE WHEN ISNULL(OT209.D18,'')!='' THEN TEMP.D18 ELSE OT209.D18 END,
	TEMP.D19 =  CASE WHEN ISNULL(OT209.D19,'')!='' THEN TEMP.D19 ELSE OT209.D19 END,
	TEMP.D20 =  CASE WHEN ISNULL(OT209.D20,'')!='' THEN TEMP.D20 ELSE OT209.D20 END,
	TEMP.D21 =  CASE WHEN ISNULL(OT209.D21,'')!='' THEN TEMP.D21 ELSE OT209.D21 END,
	TEMP.D22 =  CASE WHEN ISNULL(OT209.D22,'')!='' THEN TEMP.D22 ELSE OT209.D22 END,
	TEMP.D23 =  CASE WHEN ISNULL(OT209.D23,'')!='' THEN TEMP.D23 ELSE OT209.D23 END,
	TEMP.D24 =  CASE WHEN ISNULL(OT209.D24,'')!='' THEN TEMP.D24 ELSE OT209.D24 END,
	TEMP.D25 =  CASE WHEN ISNULL(OT209.D25,'')!='' THEN TEMP.D25 ELSE OT209.D25 END,
	TEMP.D26 =  CASE WHEN ISNULL(OT209.D26,'')!='' THEN TEMP.D26 ELSE OT209.D26 END,
	TEMP.D27 =  CASE WHEN ISNULL(OT209.D27,'')!='' THEN TEMP.D27 ELSE OT209.D27 END,
	TEMP.D28 =  CASE WHEN ISNULL(OT209.D28,'')!='' THEN TEMP.D28 ELSE OT209.D28 END,
	TEMP.D29 =  CASE WHEN ISNULL(OT209.D29,'')!='' THEN TEMP.D29 ELSE OT209.D29 END,
	TEMP.D30 =  CASE WHEN ISNULL(OT209.D30,'')!='' THEN TEMP.D30 ELSE OT209.D30 END,
	TEMP.D31 =  CASE WHEN ISNULL(OT209.D31,'')!='' THEN TEMP.D31 ELSE OT209.D31 END
	FROM #OOT2009_03 TEMP
	INNER JOIN OOT2009 OT209 ON OT209.EmployeeID = TEMP.EmployeeID
	where OT209.TransactionID = @TransactionID
	
	
	UPDATE OT209
	SET 
	OT209.D01 =  CASE WHEN ISNULL(TEMP.D01,'')!='' THEN NULL ELSE OT209.D01 END,
	OT209.D02 =  CASE WHEN ISNULL(TEMP.D02,'')!='' THEN NULL ELSE OT209.D02 END,
	OT209.D03 =  CASE WHEN ISNULL(TEMP.D03,'')!='' THEN NULL ELSE OT209.D03 END,
	OT209.D04 =  CASE WHEN ISNULL(TEMP.D04,'')!='' THEN NULL ELSE OT209.D04 END,
	OT209.D05 =  CASE WHEN ISNULL(TEMP.D05,'')!='' THEN NULL ELSE OT209.D05 END,
	OT209.D06 =  CASE WHEN ISNULL(TEMP.D06,'')!='' THEN NULL ELSE OT209.D06 END,
	OT209.D07 =  CASE WHEN ISNULL(TEMP.D07,'')!='' THEN NULL ELSE OT209.D07 END,
	OT209.D08 =  CASE WHEN ISNULL(TEMP.D08,'')!='' THEN NULL ELSE OT209.D08 END,
	OT209.D09 =  CASE WHEN ISNULL(TEMP.D09,'')!='' THEN NULL ELSE OT209.D09 END,
	OT209.D10 =  CASE WHEN ISNULL(TEMP.D10,'')!='' THEN NULL ELSE OT209.D10 END,
	OT209.D11 =  CASE WHEN ISNULL(TEMP.D11,'')!='' THEN NULL ELSE OT209.D11 END,
	OT209.D12 =  CASE WHEN ISNULL(TEMP.D12,'')!='' THEN NULL ELSE OT209.D12 END,
	OT209.D13 =  CASE WHEN ISNULL(TEMP.D13,'')!='' THEN NULL ELSE OT209.D13 END,
	OT209.D14 =  CASE WHEN ISNULL(TEMP.D14,'')!='' THEN NULL ELSE OT209.D14 END,
	OT209.D15 =  CASE WHEN ISNULL(TEMP.D15,'')!='' THEN NULL ELSE OT209.D15 END,
	OT209.D16 =  CASE WHEN ISNULL(TEMP.D16,'')!='' THEN NULL ELSE OT209.D16 END,
	OT209.D17 =  CASE WHEN ISNULL(TEMP.D17,'')!='' THEN NULL ELSE OT209.D17 END,
	OT209.D18 =  CASE WHEN ISNULL(TEMP.D18,'')!='' THEN NULL ELSE OT209.D18 END,
	OT209.D19 =  CASE WHEN ISNULL(TEMP.D19,'')!='' THEN NULL ELSE OT209.D19 END,
	OT209.D20 =  CASE WHEN ISNULL(TEMP.D20,'')!='' THEN NULL ELSE OT209.D20 END,
	OT209.D21 =  CASE WHEN ISNULL(TEMP.D21,'')!='' THEN NULL ELSE OT209.D21 END,
	OT209.D22 =  CASE WHEN ISNULL(TEMP.D22,'')!='' THEN NULL ELSE OT209.D22 END,
	OT209.D23 =  CASE WHEN ISNULL(TEMP.D23,'')!='' THEN NULL ELSE OT209.D23 END,
	OT209.D24 =  CASE WHEN ISNULL(TEMP.D24,'')!='' THEN NULL ELSE OT209.D24 END,
	OT209.D25 =  CASE WHEN ISNULL(TEMP.D25,'')!='' THEN NULL ELSE OT209.D25 END,
	OT209.D26 =  CASE WHEN ISNULL(TEMP.D26,'')!='' THEN NULL ELSE OT209.D26 END,
	OT209.D27 =  CASE WHEN ISNULL(TEMP.D27,'')!='' THEN NULL ELSE OT209.D27 END,
	OT209.D28 =  CASE WHEN ISNULL(TEMP.D28,'')!='' THEN NULL ELSE OT209.D28 END,
	OT209.D29 =  CASE WHEN ISNULL(TEMP.D29,'')!='' THEN NULL ELSE OT209.D29 END,
	OT209.D30 =  CASE WHEN ISNULL(TEMP.D30,'')!='' THEN NULL ELSE OT209.D30 END,
	OT209.D31 =  CASE WHEN ISNULL(TEMP.D31,'')!='' THEN NULL ELSE OT209.D31 END
	FROM #OOT2009_04 OT209
	INNER JOIN (
	SELECT EmployeeID,Max(D01) D01,MAX(D02) D02,MAX(D03) D03,MAX(D04) D04 ,MAX(D05) D05 ,MAX(D06) D06 ,MAX(D07) D07, MAX(D08) D08 
	,MAX(D09) D09 ,MAX(D10) D10,MAX(D11) D11 ,MAX(D12) D12 ,MAX(D13) D13 ,MAX(D14) D14 ,MAX(D15) D15 ,MAX(D16) D16 ,MAX(D17) D17 
	,MAX(D18) D18 ,MAX(D19) D19 ,MAX(D20) D20 ,MAX(D21) D21 ,MAX(D22) D22 ,MAX(D23) D23 ,MAX(D24) D24 ,MAX(D25) D25 ,MAX(D26) D26 
	,MAX(D27) D27 ,MAX(D28) D28 ,MAX(D29) D29 ,MAX(D30) D30 ,MAX(D31) D31
	FROM #OOT2009_03
	GROUP BY EmployeeID
	) TEMP ON OT209.EmployeeID = TEMP.EmployeeID

	select EmployeeID,D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
	D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
	D31, 0 as CaseID,CONVERT(VARCHAR(50), '') as ApprovePersonID01,
	CONVERT(VARCHAR(50), '') as ApprovePersonID02,CONVERT(VARCHAR(50), '') as ApprovePersonID03,
	CONVERT(VARCHAR(50), '') as ApprovePersonID04,CONVERT(VARCHAR(50), '') as ApprovePersonID05,
	CONVERT(VARCHAR(50), '') as ApprovePersonID06,CONVERT(VARCHAR(50), '') as ApprovePersonID07,
	CONVERT(VARCHAR(50), '') as ApprovePersonID08,CONVERT(VARCHAR(50), '') as ApprovePersonID09,
	CONVERT(VARCHAR(50), '') as ApprovePersonID10, 0 as RowNumber
	INTO #OOT2009_05
	from #OOT2009_04
	WHERE EmployeeID=@EmployeeID
	AND (ISNULL(D01,'')!='' OR ISNULL(D02,'')!='' OR ISNULL(D03,'')!='' OR ISNULL(D04,'')!='' OR ISNULL(D05,'')!='' OR ISNULL(D06,'')!='' OR ISNULL(D07,'')!='' OR ISNULL(D08,'')!=''
	OR ISNULL(D09,'')!='' OR ISNULL(D10,'')!='' OR ISNULL(D11,'')!='' OR ISNULL(D12,'')!='' OR ISNULL(D13,'')!='' OR ISNULL(D14,'')!='' OR ISNULL(D15,'')!='' OR ISNULL(D16,'')!=''
	OR ISNULL(D17,'')!='' OR ISNULL(D18,'')!='' OR ISNULL(D19,'')!='' OR ISNULL(D20,'')!='' OR ISNULL(D21,'')!='' OR ISNULL(D22,'')!='' OR ISNULL(D23,'')!='' OR ISNULL(D24,'')!=''
	OR ISNULL(D25,'')!='' OR ISNULL(D26,'')!='' OR ISNULL(D27,'')!='' OR ISNULL(D28,'')!='' OR ISNULL(D29,'')!='' OR ISNULL(D30,'')!='' OR ISNULL(D31,'')!='') 
	union all
	select EmployeeID,D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
	D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
	D21, D22, D23, D24, D25, D26, D27, D28, D29, D30,
	D31, CaseID,CONVERT(VARCHAR(50), '') as ApprovePersonID01,
	CONVERT(VARCHAR(50), '') as ApprovePersonID02,CONVERT(VARCHAR(50), '') as ApprovePersonID03,
	CONVERT(VARCHAR(50), '') as ApprovePersonID04,CONVERT(VARCHAR(50), '') as ApprovePersonID05,
	CONVERT(VARCHAR(50), '') as ApprovePersonID06,CONVERT(VARCHAR(50), '') as ApprovePersonID07,
	CONVERT(VARCHAR(50), '') as ApprovePersonID08,CONVERT(VARCHAR(50), '') as ApprovePersonID09,
	CONVERT(VARCHAR(50), '') as ApprovePersonID10, 0 as RowNumber
	from #OOT2009_03
	WHERE EmployeeID=@EmployeeID
	AND (ISNULL(D01,'')!='' OR ISNULL(D02,'')!='' OR ISNULL(D03,'')!='' OR ISNULL(D04,'')!='' OR ISNULL(D05,'')!='' OR ISNULL(D06,'')!='' OR ISNULL(D07,'')!='' OR ISNULL(D08,'')!=''
	OR ISNULL(D09,'')!='' OR ISNULL(D10,'')!='' OR ISNULL(D11,'')!='' OR ISNULL(D12,'')!='' OR ISNULL(D13,'')!='' OR ISNULL(D14,'')!='' OR ISNULL(D15,'')!='' OR ISNULL(D16,'')!=''
	OR ISNULL(D17,'')!='' OR ISNULL(D18,'')!='' OR ISNULL(D19,'')!='' OR ISNULL(D20,'')!='' OR ISNULL(D21,'')!='' OR ISNULL(D22,'')!='' OR ISNULL(D23,'')!='' OR ISNULL(D24,'')!=''
	OR ISNULL(D25,'')!='' OR ISNULL(D26,'')!='' OR ISNULL(D27,'')!='' OR ISNULL(D28,'')!='' OR ISNULL(D29,'')!='' OR ISNULL(D30,'')!='' OR ISNULL(D31,'')!='')

	update #OOT2009_05
	SET #OOT2009_05.CaseID = Cast(ST0010.CaseID as int)
	from #OOT2009_05
	inner join ST0010 on ST0010.DivisionID = @DivisionID and #OOT2009_05.CaseID = Cast(ISNULL(ST0010.ConditionFrom,'0') as int) 
	and #OOT2009_05.CaseID = Cast(ISNULL(ST0010.ConditionTo,'0') as int)
	where #OOT2009_05.CaseID=0 and ST0010.TypeID = 'BPC' and ST0010.ApproveTypeID1 = 'L02'

	DECLARE @cnt INT = 1;
	DECLARE @SQLApprovePersonID Varchar(500);

	WHILE @cnt <= @Level
	BEGIN
		SET @SQLApprovePersonID = 'update #OOT2009_05 
		SET #OOT2009_05.ApprovePersonID'+FORMAT(@cnt,'00') +' = CASE WHEN ST0010.DepartmentID = ''99'' THEN ISNULL(A2.ContactPerson,'''') ELSE ISNULL(A1.ContactPerson,'''') END
		from #OOT2009_05
		inner join ST0010 on ST0010.DivisionID = '''+@DivisionID+''' and #OOT2009_05.CaseID = ST0010.CaseID
		left join AT1102 A1 on A1.DepartmentID = ST0010.DepartmentID
		left join AT1102 A2 on A2.DepartmentID = '''+@DepartmentID+'''
		where ST0010.TypeID = ''BPC'' and ST0010.LevelNo = '+Convert(varchar(2),@cnt)+''
		--print @SQLApprovePersonID
		exec(@SQLApprovePersonID)
		SET @cnt = @cnt + 1;
	END

	SELECT EmployeeID,Max(D01) D01,MAX(D02) D02,MAX(D03) D03,MAX(D04) D04 ,MAX(D05) D05 ,MAX(D06) D06 ,MAX(D07) D07, MAX(D08) D08 
	,MAX(D09) D09 ,MAX(D10) D10,MAX(D11) D11 ,MAX(D12) D12 ,MAX(D13) D13 ,MAX(D14) D14 ,MAX(D15) D15 ,MAX(D16) D16 ,MAX(D17) D17 
	,MAX(D18) D18 ,MAX(D19) D19 ,MAX(D20) D20 ,MAX(D21) D21 ,MAX(D22) D22 ,MAX(D23) D23 ,MAX(D24) D24 ,MAX(D25) D25 ,MAX(D26) D26 
	,MAX(D27) D27 ,MAX(D28) D28 ,MAX(D29) D29 ,MAX(D30) D30 ,MAX(D31) D31, ISNULL(ApprovePersonID01,'') ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') ApprovePersonID02,ISNULL(ApprovePersonID03,'') ApprovePersonID03,
	ISNULL(ApprovePersonID04,'') ApprovePersonID04,ISNULL(ApprovePersonID05,'') ApprovePersonID05,
	ISNULL(ApprovePersonID06,'') ApprovePersonID06,ISNULL(ApprovePersonID07,'') ApprovePersonID07,
	ISNULL(ApprovePersonID08,'') ApprovePersonID08,ISNULL(ApprovePersonID09,'') ApprovePersonID09,
	ISNULL(ApprovePersonID10,'') ApprovePersonID10, 0 as RowNumber
	INTO #OOT2009_06
	FROM #OOT2009_05 
	GROUP BY EmployeeID, ApprovePersonID01, ApprovePersonID02, ApprovePersonID03, ApprovePersonID04, ApprovePersonID05, ApprovePersonID06, ApprovePersonID07,
	ApprovePersonID08, ApprovePersonID09, ApprovePersonID10


	-- Đánh số thứ tự
	SET @cnt = 1;
	SET @SQLApprovePersonID = '';
	DECLARE @SQLWhereClause Varchar(500) = '';
	DECLARE @SQLRowNumber Varchar(500);
	WHILE @cnt <= @Level
	BEGIN
		SET @SQLApprovePersonID += CASE WHEN @cnt = @Level THEN 'ApprovePersonID'+FORMAT(@cnt,'00') ELSE 'ApprovePersonID'+FORMAT(@cnt,'00')+', ' END
		SET @SQLWhereClause += CASE WHEN @cnt = @Level THEN '#OOT2009_06.ApprovePersonID'+FORMAT(@cnt,'00')+'=x.ApprovePersonID'+FORMAT(@cnt,'00') 
			ELSE '#OOT2009_06.ApprovePersonID'+FORMAT(@cnt,'00')+'=x.ApprovePersonID'+FORMAT(@cnt,'00')+' AND ' END
		SET @cnt = @cnt + 1;
	END

	SET @SQLRowNumber = '
	UPDATE #OOT2009_06
	SET #OOT2009_06.RowNumber = x.NewRowNumber
	FROM (
		  SELECT EmployeeID, '+@SQLApprovePersonID +', ROW_NUMBER() OVER (ORDER BY '+@SQLApprovePersonID +') AS NewRowNumber
		  FROM #OOT2009_06
		  ) x
		  Where ' + @SQLWhereClause +'
	'
	--PRINT @SQLRowNumber
	EXEC(@SQLRowNumber)

	DECLARE @TotalRowOOT209 int
	SELECT @TotalRowOOT209 = ISNULL(Count(*) OVER (),0)
	FROM #OOT2009_06
	
	--select @TotalRowOOT209 as ToTalRowOOT209,* from #OOT2009_06
	-- xóa dòng gốc
	delete OOT2009 where TransactionID = @TransactionID and EmployeeID = @EmployeeID
	-- insert những dòng sau khi tách
	INSERT INTO OOT2009([Row], DivisionID, TranMonth, TranYear, ID, [Description],
            DepartmentID, SectionID, SubsectionID, ProcessID, EmployeeID, FullName,
            D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14,
            D15  , D16, D17, D18, D19, D20, D21, D22, D23, D24, D25, D26, D27, D28,
            D29, D30, D31, Note, ApprovePersonID01, ApprovePersonID02,
            ApprovePersonID03, ApprovePersonID04, ApprovePersonID05,
            ApprovePersonID06, ApprovePersonID07,ApprovePersonID08,
            ApprovePersonID09,ApprovePersonID10,TransactionKey, TransactionID,  CreateDate,ErrorColumn,ErrorMessage)
	SELECT @TotalRow  as [Row],@DivisionID, @TranMonth, @TranYear, @ID, @Description, ISNULL(@DepartmentID,'') DepartmentID,
	ISNULL(@SectionID,'') SectionID, ISNULL(@SubsectionID,'') SubsectionID, 
	ISNULL(@ProcessID,'') ProcessID,EmployeeID,@FullName,ISNULL(D01,'') D01,ISNULL(D02,'') D02,
	ISNULL(D03,'') D03,ISNULL(D04,'') D04,ISNULL(D05,'') D05,ISNULL(D06,'') D06,
	ISNULL(D07,'') D07,ISNULL(D08,'') D08,ISNULL(D09,'') D09,ISNULL(D10,'') D10,
	ISNULL(D11,'') D11,ISNULL(D12,'') D12,ISNULL(D13,'') D13,ISNULL(D14,'') D14,
	ISNULL(D15,'') D15,ISNULL(D16,'') D16,ISNULL(D17,'') D17,ISNULL(D18,'') D18,
	ISNULL(D19,'') D19,ISNULL(D20,'') D20,ISNULL(D21,'') D21,ISNULL(D22,'') D22,
	ISNULL(D23,'') D23,ISNULL(D24,'') D24,ISNULL(D25,'') D25,ISNULL(D26,'') D26,
	ISNULL(D27,'') D27,ISNULL(D28,'') D28,ISNULL(D29,'') D29,ISNULL(D30,'') D30,
	ISNULL(D31,'') D31,@Note, ISNULL(ApprovePersonID01,'') ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') ApprovePersonID02,ISNULL(ApprovePersonID03,'') ApprovePersonID03,
	ISNULL(ApprovePersonID04,'') ApprovePersonID04,ISNULL(ApprovePersonID05,'') ApprovePersonID05,
	ISNULL(ApprovePersonID06,'') ApprovePersonID06,ISNULL(ApprovePersonID07,'') ApprovePersonID07,
	ISNULL(ApprovePersonID08,'') ApprovePersonID08,ISNULL(ApprovePersonID09,'') ApprovePersonID09,
	ISNULL(ApprovePersonID10,'') ApprovePersonID10, @TransactionKey, @TransactionID,  GETDATE(),'' as ErrorColumn,'' as ErrorMessage
	from #OOT2009_06   

	SET @TotalRow = @TotalRow + @TotalRowOOT209

	FETCH NEXT FROM @Cur INTO  @Row,@ID, @Description,@DepartmentID, @EmployeeID, @FullName,@SectionID,@SubsectionID, @ProcessID,@D01,
                          @D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @Note, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
END
CLOSE @Cur

------------------------------------------------------------------------------------------------------------------------------------------------
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
	FROM OOT2009 
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
---- tạo mã mới
IF @ID=''		
	BEGIN
		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
		SET @ID=(SELECT TOP 1 ID FROM OOT2009 WHERE TransactionKey=@TransactionKey AND DepartmentID=@DepartmentID AND SectionID=@SectionID AND SubsectionID=@SubsectionID AND ProcessID=@ProcessID 
			AND ISNULL(ApprovePersonID01,'')=ISNULL(@ApprovePersonID01,'') AND ISNULL(ApprovePersonID02,'')=ISNULL(@ApprovePersonID02,'') AND  ISNULL(ID,'') <>'')
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
		AND ApprovePersonID01=@ApprovePersonID01 AND ApprovePersonID02=ApprovePersonID02
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

--select * 
--FROM OOT2009 
--	WHERE TransactionID = @TransactionID
--	order by [Row]
		
IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2009 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
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
			FROM OOT2009
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
		INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = OOT2009.DivisionID AND OOT9.TranMonth = OOT2009.TranMonth AND OOT9.TranYear = OOT2009.TranYear AND OOT9.ID = OOT2009.ID
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
				FROM OOT2009
				WHERE TransactionKey='''+@TransactionKey+'''
				GROUP BY DivisionID, TranMonth, TranYear, ID,DepartmentID,SectionID,SubsectionID,ProcessID
			)A
			INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.ID '
			--PRINT (@sSQL)
			EXEC (@sSQL)
			SET @i = @i + 1
		END	
		-- Insert thông báo
		SELECT NEWID() as APK,OOT9.APK as APKMaster,OOT9.DivisionID, OOT2009.ID,OOT2009.ApprovePersonID01
		INTO #OOT9002
		FROM OOT2009 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT9 ON OOT9.DivisionID = OOT2009.DivisionID AND OOT9.TranMonth = OOT2009.TranMonth AND OOT9.TranYear = OOT2009.TranYear AND OOT9.ID = OOT2009.ID
		WHERE TransactionKey=@TransactionKey
		Group by OOT9.APK,OOT9.DivisionID, OOT2009.ID,OOT2009.ApprovePersonID01

		INSERT INTO OOT9002(APK, APKMaster, ModuleID, UrlCustom, Description, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Title, EffectDate, ExpiryDate)
		SELECT APK, APKMaster,'HRM','/Contentmaster/Index/HRM/OOF2050',CONCAT(N'Bạn có một bảng phân ca cần duyệt: ',ID),GETDATE(),@UserID,GETDATE(),@UserID,
			CONCAT(N'Bạn có một bảng phân ca cần duyệt: ',ID), GETDATE(),DATEADD(day,30,GETDATE())
		FROM #OOT9002

		INSERT INTO OOT9003 (APK, APKMaster, UserID, DivisionID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT NEWID(),APK,ApprovePersonID01,DivisionID,@UserID,GETDATE(),@UserID,GETDATE()
		FROM #OOT9002
	END
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM OOT2009 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
