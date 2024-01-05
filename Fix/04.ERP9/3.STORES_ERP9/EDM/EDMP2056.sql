IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2056]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2056]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
----	Sử dụng Store EDMP2055 để Insert dữ liệu vào EDMT2014
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: [Lương Mỹ] on [14/2/2020]
-- <Example>
---- 


CREATE PROCEDURE [dbo].[EDMP2056]
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@StudentID VARCHAR(50)	-- Mã học sinh
	--@APKMaster VARCHAR(50) -- APK của EDMT2013

)
AS 


BEGIN 


	DECLARE
			@key VARCHAR(50),
			@SchoolYearID VARCHAR(50),
			@StartYear DATETIME,
			@EndYear DATETIME,
			@APKMaster VARCHAR(50)
	
	-- Lấy EDMT2013 mới nhất làm bảng MAster
	SELECT TOP 1 @APKMaster = T1.APK 
		FROM EDMT2013 T1 WITH(NOLOCK)
		WHERE T1.DivisionID = @DivisionID
		    AND T1.StudentID = @StudentID
		ORDER BY T1.CreateDate DESC

	-- Xóa dữ liệu cũ để insert dữ liệu mới
	DELETE EDMT2014 
	WHERE APKMaster = @APKMaster AND ISNULL(InheritVoucherID,'') = '' AND ISNULL(InheritTransactionID,'') = ''



	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS APK, CONVERT(VARCHAR(50),'') AS DivisionID, 
	CONVERT(VARCHAR(50),'') AS FeeID, CONVERT(VARCHAR(50),'') AS ReceiptTypeID,  CONVERT(NVARCHAR(50),'') AS  ReceiptTypeName,
	CONVERT(VARCHAR(50),'') AS TypeOfFee, 
	CONVERT(VARCHAR(50),'') AS PaymentMethod, CONVERT(NVARCHAR(500),'') AS PaymentMethodName,
	CONVERT(VARCHAR(50),'') AS IsCSVC,
	CONVERT(DATETIME, NULL) AS FromDate, CONVERT(DATETIME, NULL) AS ToDate, CONVERT(DECIMAL(28,8), 100) AS Quantity,

	CONVERT(DECIMAL(28,8), 100) AS UnitPrice, CONVERT(DECIMAL(28,8), 100) AS Amount,
	CONVERT(DECIMAL(28,8), 100) AS AmountPromotion, --Tiền khuyến mãi
	CONVERT(DECIMAL(28,8), 100) AS AmountTotalPromotion, -- TỔng tiền sau khuyến mãi
	CONVERT(DECIMAL(28,8), 100) AS AmountPaid, -- Tiền đã thanh toán ở ERP8

	CONVERT(DECIMAL(28,8), 100) AS DeleteFlg, CONVERT(DECIMAL(28,8), 100) AS IsNew,
	CONVERT(DATETIME, NULL) AS CreateDate
	INTO  #Table

	-- Dữ liệu cần được xử lý
	INSERT INTO #Table
	exec EDMP2055 @DivisionID=@DivisionID,@UserID=@UserID,@APK='',@StudentID=@StudentID,@Mode=0,@PageSize=N'',@PageNumber=N''
	
	--SELECT * FROM #Table
	
	SELECT TOP 1 @SchoolYearID = T1.SchoolYearID, @StartYear = T1.DateFrom,  @EndYear = T1.DateTo
	FROM EDMT1040 T1 WITH(NOLOCK) 
	WHERE GETDATE() BETWEEN T1.DateFrom AND T1.DateTo 
	AND T1.DivisionID IN (@DivisionID, '@@@')


	DECLARE 
			@FeeID VARCHAR(50)= (SELECT TOP 1 FeeID FROM #Table)

	--INSERT INTO EDMT2013
	--(APK,DivisionID,SchoolYearID,StudentID,FeeID,FromDate,ToDate,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	--VALUES(@APKMaster,@DivisionID,@SchoolYearID,@StudentID,@FeeID,@StartYear,@EndYear,@UserID,GETDATE(),@UserID,GETDATE())


	--Duyệt từng dòng trong Table bằng WHILE
	WHILE EXISTS (SELECT TOP 1 1 FROM #Table)
	BEGIN
		--Gán dữ liệu Key
		SELECT TOP 1 @key = APK FROM #Table
		--print @key

		-- Xử lý dữ liệu
		DECLARE @TempDate DATETIME, -- Biến duyệt vòng lặp 2
			@StartDate DATETIME, 
			@EndDate DATETIME

		SELECT TOP 1 @StartDate = FromDate, @EndDate = ToDate FROM #Table
		SET @TempDate = @StartDate
		
		-- Thời hạn gói vượt quá năm học
		IF @EndDate > @EndYear SET @EndDate = @EndYear

		DECLARE @isFirst INT = 1 -- Biến xác định vòng lặp lần đầu tiên
		
		-- Xử lý vòng lặp 2
		-- Tách từng tháng trong gói => Insert vào EDMT2014
		WHILE @TempDate < @EndDate
		BEGIN
			DECLARE @FromDate DATETIME, 
					@ToDate DATETIME,
					@ReceiptTypeID VARCHAR(50),
					@PaymentMethod VARCHAR(50),
					@IsCSVC VARCHAR(50),
					@Quantity DECIMAL(28,8),
					@UnitPrice DECIMAL(28,8),
					@Amount DECIMAL(28,8),
					@AmountPromotion DECIMAL(28,8),
					@AmountTotalPromotion DECIMAL(28,8),
					@AmountEstimate DECIMAL(28,8),
					@IsNew DECIMAL(28,8)

			SET @FromDate = @TempDate
			-- Ngày cuối tháng theo FromDate
			SET @ToDate =  DATEADD(DAY, -1, DATEADD(MONTH , 1, DATEADD(MONTH, DATEDIFF(MONTH, 0, @FromDate), 0)))
			
			SELECT TOP 1 @ReceiptTypeID = ReceiptTypeID, @PaymentMethod = PaymentMethod, @IsCSVC= IsCSVC,
			@Quantity=Quantity,
			@UnitPrice = UnitPrice, @Amount = Amount,
			@AmountPromotion = AmountPromotion, @AmountTotalPromotion = AmountTotalPromotion,
			@AmountEstimate = AmountTotalPromotion,@IsNew = IsNew
			FROM #Table

			-- Những gói IsNew = 1 sẽ được lên dự thu
			IF (@isFirst <> 1 OR @IsNew = 0)
			BEGIN
				SET @AmountEstimate = 0
			END

			

			--Insert dữ liệu
			INSERT INTO EDMT2014
			(APK,DivisionID,APKMaster,FeeID,ReceiptTypeID,PaymentMethod,IsCSVC,Quantity,UnitPrice,Amount,AmountPromotion,AmountTotalPromotion,FromDate,ToDate,AmountEstimate,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate) VALUES
			(NEWID(),@DivisionID,@APKMaster,@FeeID,@ReceiptTypeID,@PaymentMethod,@IsCSVC,@Quantity,@UnitPrice,@Amount,@AmountPromotion,@AmountTotalPromotion,@FromDate,@ToDate,@AmountEstimate,@UserID,GETDATE(),@UserID,GETDATE())

			SET @isFirst = 0 -- Thoát khỏi vòng lặp đầu tiên
			-- Tăng vòng lặp
			SET @TempDate = DATEADD(DAY, 1, @ToDate)
		END

		
		--SELECT @StartDate, @EndDate
		-- Kết thúc 

		--Xóa dần dữ liệu bảng tạm để tiếp tục vòng lặp
		DELETE FROM #Table WHERE APK = @key

	END


	--SELECT * FROM EDMT2013 WHERE APK = @APKMaster

	--SELECT * 
	--FROM EDMT2014 WITH(NOLOCK)
	--WHERE APKMaster = @APKMaster 
	--ORDER BY ReceiptTypeID, FromDate




END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
