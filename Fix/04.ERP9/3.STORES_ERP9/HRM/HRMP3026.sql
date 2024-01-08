IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load dữ liệu báo cáo chấm công và viếng thăm.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường
----Modified on 14/04/2022 by Nhựt Trường: Sửa lại hàm tính khoảng cách.
----Modified on 06/07/2022 by Nhựt Trường: [2022/06/IS/0189] - Sửa lỗi lấy sai số lượng đơn hàng và ngày đơn hàng.
----Modified on 06/07/2022 by Nhựt Trường: [2022/06/IS/0189] - Nếu khi check in mà không lập đơn hàng thì vẫn load lên dữ liệu.
----Modified on 22/07/2022 by Nhựt Trường: [2022/06/IS/0189] - Điều chỉnh lại cách lấy số lượng đơn hàng.
----Modified on 22/07/2022 by Nhựt Trường: [2022/08/IS/0098] - Fix lỗi không lấy được dữ liệu thông tin thiết bị.
----Modified on 04/01/2023 by Phương Thảo: [2023/01/IS/0008] - Customize cho BBAbổ sung thêm cột tên NPP, mã NPP(FatherObjectName,FatherObjectID)
----Modified on 07/03/2023 by Phương Thảo: [2023/01/IS/0042] - Customize cho BBA bổ sung thêm cột tên doanh số (revenue)
----Modified on 31/03/2023 by Kiều Nga: [2023/03/IS/0296] - Fix lỗi in báo cáo, thay đổi kiểu dữ liệu Notes,CheckoutAddress,CheckinAddress.
----Modified on 05/04/2023 by Kiều Nga: [2023/04/IS/0028] - Fix lỗi in báo cáo, .thêm đk check dữ liệu CheckinLatitude,CheckoutLatitude
----Modified on 18/04/2023 by Thành Sang: [2023/04/IS/0111] - Bổ sung cus cho BBA
----Modified on 12/05/2023 by Thành Sang: [2023/04/IS/0193] - Bổ sung thêm điều kiện cho câu load lấy thiêt bị 
----Modified on 13/06/2023 by Thành Sang: Fix dữ liệu double lấy theo thời gian lớn hơn
----Modified on 14/07/2023 by Thành Sang: Bổ sung WITH(NOLOCK) 
----Modified on 27/10/2023 by Xuân Nguyên: [2023/10/IS/0155] - Điều chỉnh lấy chức vụ cao nhất khi nhân viên có 2 vai trò
-- <Example>
/*
    EXEC HRMP3026 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE HRMP3026 (
     @DivisionID		NVARCHAR(50),	--Biến môi trường
	 @DivisionIDList	NVARCHAR(MAX),
	 @IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
	 @FromDate			DATETIME, 
	 @ToDate			DATETIME,
	 @ListSaleID		NVARCHAR(MAX), 
	 @ListObjectID		NVARCHAR(MAX),
	 @PeriodIDList		NVARCHAR(MAX)
)
AS
DECLARE @sSQL			NVARCHAR(MAX),
		@sSQL1			NVARCHAR(MAX),
		@sSQL2			NVARCHAR(MAX),
		@sWhere			NVARCHAR(MAX),
		@sWhere2		NVARCHAR(MAX),
		@sWhere3		NVARCHAR(MAX),
		@StrSaleID		NVARCHAR(MAX),
		@StrObjectID	NVARCHAR(MAX),
		@StrSUPID		NVARCHAR(MAX),
		@StrASMID		NVARCHAR(MAX),
		@StrInventoryID	NVARCHAR(MAX),
		@CustomerName	VARCHAR(50),
		@sSQL_Temp		NVARCHAR(MAX) 

SET @sWhere = ''
SET @sWhere2 = ''
SET @sWhere3 = ''

--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = N' AND M.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
Begin
	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = N' AND M.DivisionID = N'''+@DivisionID+''''	
End

--- SALE
IF CHARINDEX('%',@ListSaleID) > 0
BEGIN
	SET @StrSaleID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrSaleID = N'IN ('''+@ListSaleID+''')'
	
	SET @StrSaleID = REPLACE(@StrSaleID,',',''',''')
END

---- DEALER
IF CHARINDEX('%',@ListObjectID) > 0
BEGIN
	SET @StrObjectID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrObjectID = N'IN ('''+@ListObjectID+''')'
	SET @StrObjectID = REPLACE(@StrObjectID,',',''',''')
END

SET @CustomerName = (Select top 1 CustomerName from CustomerIndex)
SET @sWhere = ' 1 = 1 '

IF @IsDate = 1
BEGIN
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR, M.CheckInTime, 112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	SET @sWhere2 = @sWhere2 + ' AND CONVERT(VARCHAR, OrderDate, 112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
END
ELSE
BEGIN
	SET @sWhere = @sWhere + ' AND (Case When  Month(M.CheckInTime) <10 then ''0''+rtrim(ltrim(str(Month(M.CheckInTime))))+''/''+ltrim(Rtrim(str(Year(M.CheckInTime)))) 
											Else rtrim(ltrim(str(Month(M.CheckInTime))))+''/''+ltrim(Rtrim(str(Year(M.CheckInTime)))) End) IN ('''+@PeriodIDList+''')'
	SET @sWhere2 = @sWhere2 + ' AND (Case When  Month(OrderDate) <10 then ''0''+rtrim(ltrim(str(Month(OrderDate))))+''/''+ltrim(Rtrim(str(Year(OrderDate)))) 
											Else rtrim(ltrim(str(Month(OrderDate))))+''/''+ltrim(Rtrim(str(Year(OrderDate)))) End) IN ('''+@PeriodIDList+''')'
END

CREATE TABLE #TEMPT (
    APK UNIQUEIDENTIFIER, DivisionID VARCHAR(50), ObjectID VARCHAR(50),	ObjectName NVARCHAR(250), FatherObjectID NVARCHAR(250), FatherObjectName NVARCHAR(250), EmployeeID VARCHAR(50), EmployeeName NVARCHAR(250), CheckinTime DATETIME, VoucherDate VARCHAR(50),
	InTime VARCHAR(50), OutTime VARCHAR(50), TotalMinuteOneDate VARCHAR(50), ConvertToHour VARCHAR(50),	ConvertToMinute VARCHAR(50), TimeNo VARCHAR(50), CheckinAddress NVARCHAR(500), Tel VARCHAR(50),
	CheckoutTime DATETIME, CheckoutAddress NVARCHAR(500), Notes NVARCHAR(MAX),	CheckinLatitude VARCHAR(50), CheckinLongitude VARCHAR(50), CheckoutLatitude VARCHAR(50), CheckoutLongitude VARCHAR(50),
	MachineCode NVARCHAR(150), Distance INT, Image1 NVARCHAR(150), Image2 NVARCHAR(150), Image3 NVARCHAR(150), OrderQuantity INT, Revenue DECIMAL(28,8), DistanceMove INT, FakeGPS TINYINT
);


SET @sSQL_Temp = N'	-- Lấy dữ liệu check out lớn nhất tránh bị đúp
SELECT MAX(APK) APK,DivisionID,MAX(VisitID) VisitID,UserID,ObjectID,CheckinTime,CheckinLongitude,CheckinLatitude,CheckinAddress
	,MAX(CheckoutTime) CheckoutTime,MAX(CheckoutLongitude) CheckoutLongitude,MAX(CheckoutLatitude) CheckoutLatitude,MAX(CheckoutAddress) CheckoutAddress,Notes,FakeGPS
INTO #APT0003_Data
FROM APT0003 M WITH(NOLOCK) 
	Where '+@sWhere+'
GROUP BY DivisionID,UserID,ObjectID,CheckinTime,CheckinLongitude,CheckinLatitude,CheckinAddress,Notes,FakeGPS'

SET @sSQL = N'
Select M.APK, M.DivisionID, M.ObjectID, A02.ObjectName
	 , CASE WHEN A02.IsDealer = 1 THEN M.ObjectID ELSE A02.FatherObjectID END AS FatherObjectID
	 , CASE WHEN ISNULL(A02.IsDealer,0) = 1 THEN A02.ObjectName ELSE (SELECT ObjectName FROM AT1202 WITH(NOLOCK) WHERE ObjectID = A02.FatherObjectID) END AS FatherObjectName
	 , Upper(M.UserID) as EmployeeID, MAX(Upper(A03.AnaName)) as EmployeeName
	 , M.CheckInTime, Convert(varchar, M.CheckInTime, 105) as VoucherDate
	 , convert(varchar, M.CheckinTime, 108) as InTime
	 , convert(varchar, M.CheckoutTime, 108) as OutTime
	 , DATEDIFF(minute, M.CheckinTime, M.CheckoutTime) as TotalMinuteOneDate	--Lấy tổng số phút làm trong ngày
	 , DATEDIFF(minute, M.CheckinTime, M.CheckoutTime)/60 as ConvertToHour		--Lấy số giờ
	 , DATEDIFF(minute, M.CheckinTime, M.CheckoutTime)%60 as ConvertToMinute	--Lấy số phút
	 , Cast(DATEDIFF(minute, M.CheckinTime, M.CheckoutTime) as Decimal(28,8))/60 as TimeNo	--Số giờ làm việc
	 , M.CheckinAddress, M.CheckoutTime, M.CheckoutAddress, A02.Tel, M.Notes
	 , CheckinLatitude, CheckinLongitude, CheckoutLatitude, CheckoutLongitude, MachineCode   
	 , CASE WHEN (M.CheckinLatitude BETWEEN - 90 AND 90) AND (M.CheckoutLatitude BETWEEN - 90 AND 90) THEN
			CONVERT(INT,Geography::Point(M.CheckinLatitude, M.CheckinLongitude, 4326).STDistance(Geography::Point(M.CheckoutLatitude, M.CheckoutLongitude, 4326)))
			ELSE 0 END AS Distance			--Vị trí check in so với check out
	 , (SELECT REPLACE(REPLACE(CAST(Image as nvarchar(150)),''<Image>'',''''),''</Image>'','''') FROM APT0005 WITH(NOLOCK) WHERE DivisionID = M.DivisionID AND VisitID = M.VisitID AND Orders = 1) AS Image1
	 , (SELECT REPLACE(REPLACE(CAST(Image as nvarchar(150)),''<Image>'',''''),''</Image>'','''') FROM APT0005 WITH(NOLOCK) WHERE DivisionID = M.DivisionID AND VisitID = M.VisitID AND Orders = 2) AS Image2
	 , (SELECT REPLACE(REPLACE(CAST(Image as nvarchar(150)),''<Image>'',''''),''</Image>'','''') FROM APT0005 WITH(NOLOCK) WHERE DivisionID = M.DivisionID AND VisitID = M.VisitID AND Orders = 3) AS Image3
	 , (SELECT ISNULL(MAX(RowNum),0)
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY ObjectID) AS RowNum FROM OT2001 WITH(NOLOCK) WHERE DivisionID = M.DivisionID AND ObjectID = M.ObjectID AND CreateUserID = M.UserID AND CONVERT(VARCHAR, OrderDate, 112) = CONVERT(VARCHAR, M.CheckInTime, 112)) OT2001) AS OrderQuantity
	 ,	CASE WHEN '+@CustomerName+' = 157 THEN 
			(SELECT ISNULL(SUM(OT2002.OriginalAmount),0) FROM OT2001 WITH(NOLOCK)
									 INNER JOIN OT2002 WITH(NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
									 WHERE OT2001.DivisionID = M.DivisionID AND ObjectID = M.ObjectID
									 AND CreateUserID = M.UserID AND CONVERT(VARCHAR, OrderDate, 112) = CONVERT(VARCHAR, M.CheckInTime, 112))  
		ELSE 0 END AS Revenue -- doanh thu cho đơn hàng  
	 , 0 AS DistanceMove	-- Vị trí check in so với vị trí check out trước đó
	 , CASE WHEN (M.CheckinLatitude BETWEEN - 90 AND 90) AND (M.CheckoutLatitude BETWEEN - 90 AND 90) THEN ISNULL(M.FakeGPS,0) ELSE 1 END AS FakeGPS
From #APT0003_Data M With (Nolock)

LEFT JOIN OT1002 A03 With (Nolock) on A03.DivisionID IN (M.DivisionID, ''@@@'') AND M.UserID = A03.AnaID
LEFT JOIN AT1202 A02 With (Nolock) on A02.DivisionID IN (M.DivisionID, ''@@@'') AND M.ObjectID = A02.ObjectID
--INNER JOIN OT2001 A04  With (Nolock) on A04.DivisionID IN (M.DivisionID, ''@@@'') AND M.ObjectID = A04.ObjectID AND CONVERT(VARCHAR, A04.OrderDate, 112) = CONVERT(VARCHAR, M.CheckinTime, 112)
LEFT JOIN HT2406 WITH (NOLOCK) ON HT2406.DivisionID = M.DivisionID AND HT2406.ObjectID = A02.ObjectID
							  AND CONVERT(NVARCHAR(10), HT2406.AbsentDate,101) = CONVERT(NVARCHAR(10), M.CheckinTime, 101)
							  AND HT2406.AbsentTime = (SELECT MAX(H1.AbsentTime) FROM HT2406 H1 WITH(NOLOCK) WHERE H1.ObjectID = HT2406.ObjectID AND CONVERT(NVARCHAR(10), AbsentDate, 101) = CONVERT(NVARCHAR(10), M.CheckinTime, 101)
							  AND H1.EmployeeID = M.UserID)'
SET @sSQL2=N'
WHERE A03.AnaTypeID IN (''S01'',''S02'',''S03'')
	  AND A02.IsCustomer = 1
	  AND M.UserID '+@StrSaleID+'
	  AND M.ObjectID '+@StrObjectID+'
	  AND '+@sWhere+'
	    Group by  M.APK,M.DivisionID, M.ObjectID, A02.ObjectName
	 ,  M.ObjectID , A02.FatherObjectID 
	 ,  A02.IsDealer , A02.ObjectName 
	 , M.UserID 
	 , M.CheckInTime,M.VisitID
	 , M.CheckinAddress, M.CheckoutTime, M.CheckoutAddress, A02.Tel, M.Notes
	 , CheckinLatitude, CheckinLongitude, CheckoutLatitude, CheckoutLongitude, MachineCode   ,M.FakeGPS

Order By M.UserID, M.CheckinTime
'
PRINT @sSQL_Temp
PRINT @sSQL
PRINT @sSQL2
INSERT INTO #TEMPT (APK, DivisionID, ObjectID,	ObjectName, FatherObjectID, FatherObjectName, EmployeeID, EmployeeName, CheckinTime, VoucherDate,
					InTime, OutTime, TotalMinuteOneDate, ConvertToHour, ConvertToMinute, TimeNo, CheckinAddress,
					CheckoutTime, CheckoutAddress, Tel, Notes, CheckinLatitude, CheckinLongitude, CheckoutLatitude,
					CheckoutLongitude, MachineCode, Distance, Image1, Image2, Image3, OrderQuantity, Revenue, DistanceMove, FakeGPS)
EXEC (@sSQL_Temp+@sSQL+@sSQL2)

DECLARE @Cur1 CURSOR,
		@Cur2 CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@ObjectID VARCHAR(50),
		@CheckinLatitude VARCHAR(50),
		@CheckoutLatitude VARCHAR(50),
		@CheckinLongitude VARCHAR(50),
		@CheckoutLongitude VARCHAR(50),
		@VoucherDate VARCHAR(50),
		@lat AS VARCHAR(50), 
		@lon AS VARCHAR(50)

---- LẤY KHOẢNG CÁCH TỪ ĐỊA ĐIỂM CHECK IN SO VỚI ĐỊA ĐIỂM CHECK OUT TRƯỚC ĐÓ	    
SET @Cur1 = CURSOR SCROLL KEYSET FOR

SELECT EmployeeID, VoucherDate
FROM #TEMPT WITH (NOLOCK)
GROUP BY VoucherDate, EmployeeID

OPEN @Cur1
FETCH NEXT FROM @Cur1 INTO @EmployeeID, @VoucherDate
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @Cur2 = CURSOR SCROLL KEYSET FOR

	SELECT APK, EmployeeID, ObjectID, CheckinLatitude, CheckoutLatitude, CheckinLongitude, CheckoutLongitude, VoucherDate
	FROM #TEMPT WITH (NOLOCK)
	WHERE EmployeeID = @EmployeeID AND VoucherDate = @VoucherDate
	ORDER BY CheckinTime, CheckoutTime
	
	OPEN @Cur2
	FETCH NEXT FROM @Cur2 INTO @APK, @EmployeeID, @ObjectID, @CheckinLatitude, @CheckoutLatitude, @CheckinLongitude, @CheckoutLongitude, @VoucherDate
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@lat <> '' AND @lon <> '')
		BEGIN
			UPDATE #TEMPT SET DistanceMove =  CASE WHEN  CONVERT(decimal,@CheckinLatitude) BETWEEN -90 AND 90 
														THEN CONVERT(INT,Geography::Point(CheckinLatitude, CheckinLongitude, 4326).STDistance(Geography::Point(@lat, @lon, 4326))) 
														ELSE 0 END 
			WHERE APK = @APK
		END
		SET @lat = @CheckoutLatitude
		SET @lon = @CheckoutLongitude
	
		FETCH NEXT FROM @Cur2 INTO @APK, @EmployeeID, @ObjectID, @CheckinLatitude, @CheckoutLatitude, @CheckinLongitude, @CheckoutLongitude, @VoucherDate
	END
	CLOSE @Cur2

	SET @lat = ''
	SET @lon = ''

	FETCH NEXT FROM @Cur1 INTO @EmployeeID, @VoucherDate
END
CLOSE @Cur1

SELECT * FROM #TEMPT


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
