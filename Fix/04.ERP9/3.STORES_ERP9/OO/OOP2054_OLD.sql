IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2054_OLD]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2054_OLD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xét duyệt đơn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 09/12/2015
----Modified by Bảo Thy on 05/07/2016: bỏ Insert bảng phân ca where theo kỳ
--- Modify on 23/07/2018 by Bảo Anh: Bổ sung các cột D32, D33 cho bảng phân ca
/*-- <Example>
	OOP2054_OLD @DivisionID='NTY',@UserID='ASOFTADMIN',@TranMonth=7,@TranYear=2018,@APKMaster='CD9AB8B7-DCF9-442E-A0C8-9A7F069E45C9',
	@Type='DXLTG',@Status=1
----*/


CREATE PROCEDURE OOP2054_OLD
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @Type VARCHAR(50),
  @Status TINYINT --- 1 là chấp nhận; 2 là từ chối
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)=''

IF @Status =1 
BEGIN
	 IF @Type='DXP'--Đơn xin phép
	 EXEC OOP2062_OLD @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Status
	 
	 IF @Type='DXRN' -- Đơn xin phép ra ngoài
	 BEGIN
	 	EXEC OOP2059 @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Status
	 END
	 IF @Type ='DXBSQT' -- Đơn xin bổ sung quẹt thẻ
	 BEGIN
	 		--Bổ sung quẹt thẻ
	 	INSERT INTO HT2408_MK (APK,APKMaster,DivisionID, EmployeeID, TranMonth, TranYear,
	 	            AbsentCardNo, AbsentDate, AbsentTime, CreateUserID, CreateDate,
	 	            LastModifyUserID, LastModifyDate, IOCode,EditType)
	 	 SELECT	OT40.APK,OT40.APKMaster,OT40.DivisionID,OT40.EmployeeID,OT90.TranMonth,OT90.TranYear,
				HT17.AbsentCardNo,CONVERT(DATE,OT40.Date) AbsentDate,CONVERT(TIME(0),OT40.Date,0) AbsentTime,	
				OT90.CreateUserID,OT90.CreateDate,@UserID,GETDATE(),ISNULL(InOut,0),ISNULL(OT40.EditType,0)
	 	 FROM OOT2040 OT40
	 	 INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OT40.DivisionID AND OT90.APK = OT40.APKMaster
	 	 INNER JOIN HT1407 HT17 ON HT17.DivisionID = OT40.DivisionID AND HT17.EmployeeID = OT40.EmployeeID
	 	 LEFT JOIN HT2408_MK HT28 ON HT28.DivisionID = OT40.DivisionID AND HT28.APK = OT40.APK AND HT28.APKMaster = OT40.APKMaster AND HT28.IOCode=OT40.InOut
	 	 WHERE OT40.DivisionID=@DivisionID 
		 AND OT40.APKMaster =@APKMaster
		 AND ISNULL(OT40.Status,0)=1
		 AND HT28.APK IS NULL
	END
	IF @Type ='DXLTG' -- Đơn xin làm thêm giờ
	BEGIN
		EXEC OOP2056 @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Status
	END 
	IF @Type ='BPC' -- Bảng phân ca
	BEGIN
		-- xử lý đẩy ca xuống
		INSERT INTO HT1025(APK, DivisionID, TransactionID, EmployeeID, TranMonth,
		            TranYear, D01, D02, D03, D04, D05, D06, D07, D08, D09, D10,
		            D11, D12, D13, D14, D15, D16, D17, D18, D19, D20, D21, D22,
		            D23, D24, D25, D26, D27, D28, D29, D30, D31, D32, D33, Notes,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT OOT00.APK,OOT00.DivisionID, OOT00.APK, OOT00.EmployeeID,OT90.TranMonth,
			   OT90.TranYear,OOT00.D01, OOT00.D02, OOT00.D03, OOT00.D04, OOT00.D05,
			   OOT00.D06, OOT00.D07, OOT00.D08, OOT00.D09, OOT00.D10, OOT00.D11,
			   OOT00.D12, OOT00.D13, OOT00.D14, OOT00.D15, OOT00.D16, OOT00.D17,
			   OOT00.D18, OOT00.D19, OOT00.D20, OOT00.D21, OOT00.D22, OOT00.D23,
			   OOT00.D24, OOT00.D25, OOT00.D26, OOT00.D27, OOT00.D28, OOT00.D29,
			   OOT00.D30, OOT00.D31, OOT00.D32, OOT00.D33, OOT00.Note,OT90.CreateUserID,OT90.CreateDate,
			   @UserID,GETDATE()
		FROM OOT2000 OOT00
		INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OOT00.DivisionID AND OT90.APK = OOT00.APKMaster
		LEFT JOIN HT1025 HT25 ON HT25.DivisionID = OT90.DivisionID AND HT25.EmployeeID = OOT00.EmployeeID 
		AND HT25.TranMonth = OT90.TranMonth AND HT25.TranYear = OT90.TranYear
		WHERE OOT00.DivisionID=@DivisionID
		 --AND OT90.TranMonth=@TranMonth
		 --AND OT90.TranYear=@TranYear
		 AND OT90.APK=@APKMaster
		 AND ISNULL(OOT00.Status,0)=1
		 AND HT25.APK IS NULL
	END 
	IF @Type ='DXDC' -- Đơn xin đổi ca
	BEGIN
		EXEC OOP2057 @DivisionID, @UserID, @TranMonth, @TranYear, @APKMaster, @Status
	END
END
ELSE
BEGIN
	--Đơn xin phép
	IF @Type ='DXP'
		DELETE HT24
	 	FROM HT2401_MK HT24
		INNER JOIN OOT2010 OOT20 ON OOT20.DivisionID = HT24.DivisionID AND OOT20.APKMaster = HT24.APKMaster
	 	AND OOT20.APKMaster =@APKMaster 
		--AND ISNULL(OOT20.Status,0)=0
	 IF @Type='DXRN' -- Đơn xin phép ra ngoài
	 BEGIN
	 	DELETE HT24
	 	FROM HT2408_MK HT24
	 	INNER JOIN OOT2020 OOT20 ON OOT20.DivisionID = HT24.DivisionID AND OOT20.APK = HT24.APK AND OOT20.APKMaster = HT24.APKMaster
	 	AND OOT20.APKMaster =@APKMaster 
		AND ISNULL(OOT20.Status,0)=0
	 	
	 	INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
							TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
							AbsentAmount, CreateUserID,CreateDate, LastModifyUserID,LastModifyDate)
				SELECT OOT20.APK,OOT20.DivisionID,CONVERT(DATE,OOT20.GoFromDate),OOT20.EmployeeID,
					   OT90.TranMonth,HT14.DepartmentID,OT90.TranYear,HT14.TeamID,H13.AbsentTypeID,
					   -(CASE WHEN H13.UnitID='H' THEN OOT20.TotalTime ELSE OOT20.TotalTime/8 END) AbsentAmount,
					   OT90.CreateUserID,OT90.CreateDate,@UserID,GETDATE()
					   FROM OOT2020 OOT20
					   INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OOT20.DivisionID AND OT90.APK = OOT20.APKMaster
					   LEFT JOIN HT1013 H13 ON H13.DivisionID = OOT20.DivisionID 
											AND H13.AbsentTypeID = (SELECT TOP 1 AbsentTypeID FROM OOT0010 WHERE TranMonth=@TranMonth
																	AND TranYear=@TranYear AND DivisionID=@DivisionID AND AbsentType=@Type)
					   LEFT JOIN HT1400 HT14 ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID
					   LEFT JOIN HT2401_MK HMK ON HMK.DivisionID = HT14.DivisionID AND HMK.APKMaster = OOT20.APKMaster
					   WHERE OOT20.DivisionID=@DivisionID 
					   AND OOT20.APKMaster =@APKMaster 
					   AND ISNULL(OOT20.Status,0)=0
					   AND HMK.APK IS NULL
	 END
	 IF @Type ='DXBSQT' -- Đơn xin bổ sung quẹt thẻ
	 BEGIN
	 	--Bo sung quet the
		 DELETE HT24
		 FROM HT2408_MK HT24
		 INNER JOIN OOT2040 OOT40 ON OOT40.DivisionID = HT24.DivisionID AND OOT40.EmployeeID = HT24.EmployeeID
								  AND OOT40.APK=HT24.APK AND OOT40.APKMaster = HT24.APKMaster
		 WHERE HT24.DivisionID=@DivisionID
		 AND HT24.TranMonth=@TranMonth
		 AND HT24.TranYear=@TranYear
		 AND OOT40.APKMaster=@APKMaster
	END
	IF @Type ='DXLTG' -- Đơn xin làm thêm giờ
	BEGIN		
		EXEC OOP2056 @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Status
	END
	IF @Type ='BPC' -- Bảng phân ca
	BEGIN
		DELETE HT12
	 	FROM HT1025  HT12
		INNER JOIN OOT2000 OOT20 ON OOT20.DivisionID = HT12.DivisionID AND OOT20.EmployeeID = HT12.EmployeeID
	 	AND OOT20.APKMaster =@APKMaster 
	 	AND HT12.DivisionID=@DivisionID
	 	AND HT12.TranMonth=@TranMonth
	 	AND HT12.TranYear=@TranYear
		AND ISNULL(OOT20.Status,0)=0
	END
		
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
