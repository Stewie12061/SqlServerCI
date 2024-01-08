IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3334]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3334]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Modified by Kim Thư on 17/9/2018: Điều chỉnh UnitPrice customerindex=93-Làng Tre
---- Modified by Kim Thư on 08/11/2018: Bổ sung trường hợp xóa vết kế thừa khi xóa phiếu từ màn hình truy vấn (ko có view AV3336)
---- Modified by Kim Thư on 24/12/2018: Bổ sung tùy chọn nhóm theo loại mặt hàng cho Làng Tre (93)
---- Modified by Kim Thư on 08/01/2019: Bổ sung load thêm cột ID ra lưới AF0066, lưu vết theo những ID có trên lưới
---- Modified by Kim Thư on 01/02/2019: Bổ sung biến UserID, lưu lại những ID đã được kế thừa vào table riêng vì sẽ sum lại những mặt hàng cùng tên
---- Modified by Kim Thư on 07/03/2019: Bổ sung tài khoản doanh thu đưa vào cột TK Có SalesAccountID
---- Modified by Kim Thư on 14/03/2019: Đưa câu chạy có gom nhóm của Làng Tre vào chuỗi do KH khác không có cột SalesAccountID ở AV3336
---- Modified by Kim Thư on 14/06/2019: Format lại tên hàng RM cho Làng Tre trường hợp nhón theo loại mặt hàng
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Thành Sang on 12/07/2022: Sửa cách lấy InventoryName
---- Modified by Thanh Lượng on 05/01/2023:[2023/01/IS/0004]: Bổ sung Customize lấy dữ liệu cho cột UnitID và Quantity,UnitPrice(SEAHORSE)
---- Modified by Đình Định on 20/10/2023: SEAHORSE - Gom các dòng mô tả khi kế thừa hóa đơn bán hàng.
---- Modified by Đình Định on 25/10/2023: SEAHORSE - Lấy Quantity gốc thay vì lấy theo số dòng sum.
---- Modified by Hương Nhung on [25/10/2023] [2023/10/IS/0271]: Fix lỗi Invalid object name 'AV3336'.
---- Modified by Kiều Nga on 01/12/2023: [2023/11/IS/0207] SEAHORSE - Fix lỗi kế thừa dữ liệu ra màn hình hóa đơn đối với trường hợp số lượng =0.

--Ke thua hoa don dich vu
CREATE  PROCEDURE AP3334 @DivisionID VARCHAR(50), @UserID VARCHAR(50), @Method tinyint = 0,
						 @VoucherID varchar(50) = '', -- 0, do du lieu ke thua, 1 cap nhat tinh trang da ke thua, 2 Xoa
						 @IsInventoryTypeID TINYINT = 0

AS
DECLARE @CustomerIndex INT,
		@ConvertDecimal INT

SELECT @CustomerIndex = CustomerName FROM CustomerIndex WITH (NOLOCK)

SELECT @ConvertDecimal = ConvertedDecimals FROM AT1101 WITH (NOLOCK)

	CREATE TABLE #Temp(
		RoomNo NVARCHAR(50),
		BillNo NVARCHAR(50),
		CheckInDate DATETIME, 
		CheckOutDate DATETIME, 
		InventoryID NVARCHAR(50) ,
		InventoryName NVARCHAR(100), 
		Quantity DECIMAL(28,8),
		UnitPrice DECIMAL(28,8), 
		OriginalAmount DECIMAL(28,8),
		UnitID NVARCHAR(50) )

IF EXISTS (Select Top 1 1 From sysobjects Where Id = Object_ID('AV3336') And xType = 'V')
BEGIN
	 IF @CustomerIndex = 100
	 BEGIN 
	 --1. Khách hàng SEAHORSE.
		INSERT INTO #Temp ( RoomNo, BillNo, CheckInDate, CheckOutDate, InventoryID, InventoryName, Quantity, UnitPrice, OriginalAmount, UnitID)
		SELECT * FROM (
			SELECT RoomNo, MIN(BillNo) AS BillNo, CheckInDate, CheckOutDate, InventoryID AS InventoryID, [Description] AS InventoryName,
				   SUM(ISNULL(Quantity,0)) AS Quantity,
				   CASE WHEN SUM(ISNULL(Quantity,0)) <> 0 THEN ROUND( (SUM(OriginalAmount)/SUM(ISNULL(Quantity,0))), @ConvertDecimal) ELSE 0 END AS UnitPrice, 
				   CASE WHEN SUM(ISNULL(Quantity,0)) <> 0 THEN (ROUND( (SUM(OriginalAmount)/SUM(ISNULL(Quantity,0))), @ConvertDecimal) * SUM(ISNULL(Quantity,0)) ) ELSE SUM(OriginalAmount) END AS OriginalAmount, UnitID AS UnitID
			  FROM AV3336 WITH (NOLOCK)
			 WHERE InventoryID = 'RM'
			 GROUP BY RoomNo, CheckInDate, CheckOutDate, InventoryID, [Description], UnitID
		UNION ALL
		    SELECT RoomNo, MIN(BillNo) AS BillNo, CheckInDate, CheckOutDate, InventoryID AS InventoryID, [Description] AS InventoryName,
		   	       SUM(ISNULL(Quantity,0)) AS Quantity, 
				   CASE WHEN SUM(ISNULL(Quantity,0)) <> 0 THEN ROUND( SUM(OriginalAmount)/SUM(ISNULL(Quantity,0)), @ConvertDecimal) ELSE 0 END AS UnitPrice,
				   CASE WHEN SUM(ISNULL(Quantity,0)) <> 0 THEN (ROUND (SUM(OriginalAmount)/SUM(ISNULL(Quantity,0)), @ConvertDecimal) * SUM(ISNULL(Quantity,0))) ELSE SUM(OriginalAmount) END AS OriginalAmount, UnitID
		      FROM AV3336 WITH (NOLOCK)
		     WHERE InventoryID <> 'RM'
		     GROUP BY RoomNo, CheckInDate, CheckOutDate, InventoryID, [Description], UnitID  
		  ) AS A 
	 END
	 ELSE
	 BEGIN
	 --2. Luồng chuẩn.
		INSERT INTO #Temp ( RoomNo, BillNo, CheckInDate, CheckOutDate, InventoryID, InventoryName, Quantity, UnitPrice, OriginalAmount, UnitID)
		SELECT * FROM (
			SELECT RoomNo,Null AS BillNo, CheckInDate, CheckOutDate, InventoryID AS InventoryID, Description AS InventoryName, 
				   Count(InventoryID) AS Quantity, Sum(OriginalAmount)/Count(InventoryID) AS UnitPrice,
				   Sum(OriginalAmount) AS OriginalAmount, UnitID AS UnitID
			  FROM AV3336 WITH (NOLOCK)
			 WHERE InventoryID = 'RM'
			 GROUP BY RoomNo, CheckInDate, CheckOutDate, InventoryID, [Description], OriginalAmount, UnitID
		UNION ALL
			SELECT RoomNo, BillNo, CheckInDate, CheckOutDate, InventoryID AS InventoryID, [Description] AS InventoryName,
				   1 AS Quantity, OriginalAmount AS UnitPrice, OriginalAmount AS OriginalAmount, UnitID
			  FROM AV3336 AV3336 WITH (NOLOCK)
			 WHERE InventoryID <> 'RM'
		) AS A 
	 END


	If @Method = 0
		IF @CustomerIndex <> 93 OR (@CustomerIndex = 93 AND @IsInventoryTypeID = 0)
		BEGIN
			Select  Null As ObjectID, Null As VATObjectID, 'VND' As CurrencyID, 
				T01.InventoryID, Case when T01.InventoryID = 'RM' Then A01.InventoryName + ' ' + A01.RoomNo + ' (' + ltrim(day(A01.CheckInDate)) + '/' + ltrim(month(A01.CheckInDate)) + '/' + ltrim(year(A01.CheckInDate)) + ' - ' + ltrim(day(A01.CheckOutDate)) + '/' + ltrim(month(A01.CheckOutDate)) + '/' + ltrim(year(A01.CheckOutDate)) + ')' 
				Else A01.InventoryName + Case when (BillNo is null Or BillNo = '') Then '' Else ' (' + A01.BillNo + ')' End End As InventoryName,
				Case when T01.InventoryID = 'RM' Then A01.InventoryName + ' ' + A01.RoomNo + ' (' + ltrim(day(A01.CheckInDate)) + '/' + ltrim(month(A01.CheckInDate)) + '/' + ltrim(year(A01.CheckInDate)) + ' - ' + ltrim(day(A01.CheckOutDate)) + '/' + ltrim(month(A01.CheckOutDate)) + '/' + ltrim(year(A01.CheckOutDate)) + ').' 
				Else A01.InventoryName + Case when (BillNo is null Or BillNo = '') Then '.' Else ' (' + A01.BillNo + ').' End End As InventoryName1,
				CASE WHEN @CustomerIndex=100 THEN A01.UnitID  ELSE T01.UnitID END As UnitID, T01.IsStocked, T01.MethodID, T01.IsSource, T01.IsLocation, T01.IsLimitDate,
				A01.Quantity, A01.UnitPrice, T01.SalesAccountID, A01.OriginalAmount, 0 As ConvertedAmount, 0 As ExchangeRate
			From 
				(
					SELECT * FROM #Temp
				UNION ALL
					Select Null As RoomNo,Null As BillNo,Null As CheckInDate,Null As CheckOutDate, 'ZZ' As InventoryID, NULL AS InventoryName,1 As Quantity, 
					CASE WHEN @CustomerIndex=93 THEN (SELECT TOP 1 ServiceCharge FROM AV3336 WITH (NOLOCK)) ELSE Sum(ServiceCharge) END As UnitPrice, 
					CASE WHEN @CustomerIndex=93 THEN (SELECT TOP 1 ServiceCharge FROM AV3336 WITH (NOLOCK)) ELSE Sum(ServiceCharge) END As OriginalAmount,NULL As UnitID
					From AV3336 WITH (NOLOCK)
				) AS A01 LEFT OUTER JOIN AT1302 T01 WITH (NOLOCK) ON A01.InventoryID = T01.InventoryID
			ORDER BY A01.InventoryID, A01.BillNo ASC
			
			--Lưu lại những ID đã được chọn kế thừa
			INSERT INTO AT3334_ID SELECT DISTINCT @DivisionID, @UserID, ID FROM AV3336
		END
		ELSE
		BEGIN
			EXEC ('SELECT  Null As ObjectID, Null As VATObjectID, ''VND'' As CurrencyID, 
			T01.InventoryTypeID AS InventoryID, 
			Case when ( T01.InventoryID = ''RM'') Then T01.InventoryName + '' '' + A01.RoomNo + '' ('' + convert(varchar(10),A01.CheckInDate,103) + '' - '' + 
			convert(varchar(10),A01.CheckOutDate,103) + '')''  Else T02.InventoryTypeName End AS InventoryName, 
			T01.UnitID, --T01.InventoryID AS InventoryID1, T01.IsStocked, T01.MethodID, T01.IsSource, T01.IsLocation, T01.IsLimitDate,T01.SalesAccountID,
			SUM(A01.Quantity) AS Quantity, SUM(A01.OriginalAmount)/SUM(A01.Quantity) AS UnitPrice,  SUM(A01.OriginalAmount) AS OriginalAmount, 0 As ConvertedAmount, 
			0 As ExchangeRate, A01.SalesAccountID, convert(varchar(10),A01.CheckInDate,103) as CheckInDate , convert(varchar(10),A01.CheckOutDate,103) as CheckOutDate
			From 
			(	Select  RoomNo,Null as BillNo,CheckInDate,CheckOutDate,InventoryID As InventoryID, Count(InventoryID) As Quantity, Sum(OriginalAmount)/Count(InventoryID) As UnitPrice, 
						SUM(OriginalAmount) As OriginalAmount, SalesAccountID
				From AV3336
				Where InventoryID = ''RM''
				GROUP BY RoomNo,CheckInDate,CheckOutDate,InventoryID,OriginalAmount, SalesAccountID
				UNION ALL
				Select RoomNo,BillNo,CheckInDate,CheckOutDate,InventoryID As InventoryID, 1 As Quantity, OriginalAmount As UnitPrice, OriginalAmount As OriginalAmount, SalesAccountID
				From AV3336
				Where InventoryID <> ''RM''
				UNION ALL
				Select TOP 1 NULL As RoomNo,Null As BillNo,Null As CheckInDate,Null As CheckOutDate, ''ZZ'' As InventoryID, 1 As Quantity,
					 ServiceCharge As UnitPrice, 
					ServiceCharge As OriginalAmount, (SELECT SalesAccountID FROM AT1302 WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND InventoryID = ''ZZ'') AS SalesAccountID
				From AV3336
			) AS A01 LEFT OUTER JOIN AT1302 T01 ON A01.InventoryID = T01.InventoryID
			INNER JOIN AT1301 T02 WITH (NOLOCK) ON T01.InventoryTypeID = T02.InventoryTypeID
			GROUP BY T01.InventoryTypeID, T02.InventoryTypeName, T01.UnitID, A01.SalesAccountID,T01.InventoryID, 
						A01.RoomNo,A01.CheckInDate,A01.CheckInDate,T01.InventoryName,A01.CheckOutDate
			--, T01.InventoryID, T01.IsStocked, T01.MethodID, T01.IsSource, T01.IsLocation, T01.IsLimitDate, T01.SalesAccountID
			')
			--Lưu lại những ID đã được chọn kế thừa
			INSERT INTO AT3334_ID SELECT DISTINCT @DivisionID, @UserID, ID FROM AV3336
		END
	Else
	If @Method = 1
	Begin
		Insert Into AT3333 (DivisionID, VoucherID, Ma) Select distinct @DivisionID,@VoucherID,ID From AT3334_ID Where ID Not In (Select Ma From AT3333)
	End
	Else
	Begin
		Delete From AT3333 WITH (ROWLOCK) Where VoucherID = @VoucherID
	End
	
END
ELSE
	If @Method = 2 Delete From AT3333 WITH (ROWLOCK) Where VoucherID = @VoucherID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
