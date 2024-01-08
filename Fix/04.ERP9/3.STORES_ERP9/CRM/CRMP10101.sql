IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid Form Danh muc khách hàng-CRMF1010 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 20/11/2015
----Modified by Thị Phượng, Date: 27/02/2017: Bỏ lọc Tuyến giao hàng và bổ sung thêm Xuất excel
-- -Modified by Thị Phượng, Date: 03/04/2017: Bổ sung load Người phụ trách
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Hoàng Vũ, Date 06/07/2017: Cải tiến tốc độ màn hình tìm kiếm, truy vấn, in, xuất excel, Bổ sung Index
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Hoàng vũ, Date 15/02/2019: Bổ sung thêm 1 số trường phục vụ search nâng cao (Tháng sinh, Năm sinh, Giới tính, Tuổi)
--- Modify by Hoàng vũ, Date 22/02/2019: Lọc số điện phone nếu không có thì lấy số tel
--- Modify by Trọng Kiên, Date 22/09/2020: Bổ sung STT cho in danh mục khách hàng
--- Modify by Vĩnh Tâm, Date 12/01/2021: Fix lỗi mất phân quyền dữ liệu khi dùng search nâng cao
--- Modify by Thành Sang, Date 22/12/2021: Thêm thuộc tính isDealer và FatherObjectID
--- Modify by Anh Tuấn,   Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Minh Hiếu	, Date 06/01/2022: Thêm điều kiện tìm theo người theo dõi
--- Modify by Văn Tài	, Date 08/01/2022: Cập nhật giá trị default FatherObjectID.
--- Modify by Ngọc Châu	, Date 07/07/2022: Thêm @sWhereSELLOUT set customize cho Angel CIT180
--- Modify by Ngọc Châu	, Date 07/07/2022: Orderby thêm AccountID nếu thuộc Angel.
--- Modify by Văn Tài	, Date 25/11/2022: Bổ sung luồng chuẩn, kiểm tra có sử dụng thiết lập biến môi trường Sellout.
--- Modify by Anh Đô	, Date 16/12/2022: Loại bỏ các dấu phẩy thừa ở cột BillAddress và DeliveryAddres
--- Modify by Thành Sang, Date 19/12/2022: Sửa phân quyền dữ liệu cho Division - SO
--- Modify by Thành Sang, Date 20/12/2022: Sửa câu điều kiện xem dữ liệu với Sale ở divisionID SO
--- Modify by Anh Đô, Date 26/12/2022: Select thêm cột CreateUserName, tách phần Join ở phần In/Export ra biến riêng (@sSQLJoin), fix lỗi không load được trường Tel mặc dù có dữ liệu
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modify by Hoài Bảo, Date 10/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example> 
/*
	exec CRMP10101 @DivisionID = N'AS', @DivisionIDList = N'AS'', ''GC'', ''GS', @AccountID = N'', @AccountName = N'a', @Address = N'b', 
	@Email = N'e', @Tel = N't', @IsCommon = N'f', @IsUsing = N'w', @Disabled = N'0', @UserID = N'VU', @PageNumber = 1, @PageSize = 25, @IsExcel = 0, 
	@ConditionObjectID = N'ASOFTADMIN'', ''DANH'', ''DUY'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''MINH'', ''PHUONG'', ''QUI'', ''VU', @SearchWhere = ''


	exec CRMP10101 @DivisionID=N'VNA',@DivisionIDList=N'',@FromDate='2021-11-01 00:00:00',@ToDate='2022-01-31 00:00:00',@IsPeriod=0,@PeriodList=N'',@AccountID=N'',@AccountName=N'',@Address=N'',@Email=N'',@Tel=N'',@AssignedToUser=N'VNA',
@FatherObjectID=N'',@IsCommon=N'',@IsUsing=N'',@Disabled=N'',@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsExcel=0,@ConditionObjectID=N'ADMIN'',''ASOFT'',''ASOFTADMIN'',''CHI'',''HCM-AM01'',''HCM-KD01'',''HCM-KD02'',''HCM-KD03'',''HCM-KD04'',''HCM-KD05'',''HCM-KD06'',''HCM-KD07'',''HCM-KD08'',''HCM-KD09'',''HCM-KD10'',''HCM-KT02'',''HCM-KT03'',''HCM-KT04'',''HCM-KT05'',''HCM-KT06'',''HCM-KT07'',''HCM-KT08'',''HCM-KT09'',''HCM-SEP01'',''HCM-SEP02'',''HCM-SEP03'',''HCM-XNK01'',''HCM-XNK02'',''HCM-XNK03'',''HCM-XNK04'',''HCM-XNK05'',''UNASSIGNED'',''USER01'',''USER03'',''VNA',@SearchWhere=N''
*/
CREATE PROCEDURE [dbo].[CRMP10101] ( 
		@DivisionID NVARCHAR(50) = '',		--Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',	--Chọn trong DropdownChecklist DivisionID
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
		@AccountID NVARCHAR(50) = '',
		@AccountName NVARCHAR(250) = '',
		@Address NVARCHAR(100) = '',
		@Email NVARCHAR(100) = '',
		@Tel NVARCHAR(100) = '',
		@IsCommon NVARCHAR(100) = '',
		@IsUsing NVARCHAR(100) = '',
		@Disabled NVARCHAR(100) = '',
		@UserID NVARCHAR(50) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@ConditionObjectID NVARCHAR(MAX) = '',
		@IsExcel BIT = 0,						--1: thực hiện xuất file Excel; 0: Thực hiện Filter
		@IsDealer TINYINT = 0,				--2: phân biệt khách hàng sellout - sellin
		@FatherObjectID VARCHAR(50) = '',		-- 3: đại lý của khách hàng sellout
		@SearchWhere NVARCHAR(MAX) = NULL,
		@AssignedToUser NVARCHAR(100) = '',
		@IsAngel NVARCHAR = NULL,
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL01 NVARCHAR(MAX) = '',
		@sSQL02 NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = '',
		@sWhereSELLOUT NVARCHAR(200) = '',
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@CustomerIndex INT,
		@DealerDivisionID VARCHAR(50),
		@sSQLJoin NVARCHAR(MAX)

	SET @sWhere = ''
	SET @OrderBy = N' POST0011.CreateDate DESC '
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Lấy CustomerIndex
SELECT TOP 1 @CustomerIndex = CustomerName FROM dbo.CustomerIndex WITH (NOLOCK)

SET @DealerDivisionID = (SELECT TOP 1 KeyValue FROM ST2101 WITH (NOLOCK) WHERE KeyName = 'DealerDivisionID')
	
	--Check Para DivisionIDList null then get DivisionID
IF ISNULL(@SearchWhere, '') = ''
BEGIN
	IF ISNULL(@DivisionIDList, '')!= ''
		BEGIN
			SET @sWhere = @sWhere + N' POST0011.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
			SET @sWhereDashboard = @sWhereDashboard + N' POST0011.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
		END
	ELSE 
		SET @sWhere = @sWhere + N' POST0011.DivisionID IN ( ''' + @DivisionID + ''', ''@@@'')'
	IF ISNULL(@AccountID, '') != ''
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.MemberID, '''') LIKE N''%' + @AccountID + '%'' '
	IF ISNULL(@AccountName, '') != ''
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.MemberName, '''') LIKE N''%' + @AccountName + '%'' '
	IF ISNULL(@Address, '') != ''
		SET @sWhere = @sWhere + N'AND ISNULL(POST0011.Address, '''') LIKE N''%' + @Address + '%'' '
	IF ISNULL(@Email, '') != ''
		SET @sWhere = @sWhere + N'AND ISNULL(POST0011.Email, '''') LIKE N''%' + @Email + '%'' '
	IF ISNULL(@Tel, '') != ''
		SET @sWhere = @sWhere + N'AND ISNULL(POST0011.Phone, POST0011.Tel) LIKE N''%' + @Tel + '%'' '
	IF ISNULL(@AssignedToUser, '') != ''
		SET @sWhere = @sWhere + N'AND ISNULL(A.FullName, '''') LIKE N''%' + @AssignedToUser + '%'' OR ISNULL(A.EmployeeID, '''') LIKE N''%' + @AssignedToUser + '%'' '
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.IsCommon, '''') LIKE N''%' + @IsCommon + '%'' '
	IF ISNULL(@IsUsing, '') != '' 
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.IsUsing, '''') LIKE N''%' + @IsUsing + '%'' '
	IF ISNULL(@Disabled, '') != '' 
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.Disabled, '''') LIKE N''%' + @Disabled + '%'' '
	IF ISNULL(@Disabled, '') != '' 
		SET @sWhere = @sWhere + N' AND ISNULL(POST0011.Disabled, '''') LIKE N''%' + @Disabled + '%'' '
	IF ISNULL(@ConditionObjectID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @ConditionObjectID + ''' ) OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @ConditionObjectID + ''' ))'
			SET @sWhereDashboard = @sWhereDashboard + ' AND (ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @ConditionObjectID + ''' ) OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @ConditionObjectID + ''' ))'
		END

	IF ISNULL(@FatherObjectID, '') != ''
		SET @sWhere = @sWhere + N'AND ISNULL(AT02.FatherObjectID, '''') LIKE N''%' + @FatherObjectID + '%'' '

	-- if else để không ảnh hưởng đến thuộc tính khác

	IF @CustomerIndex = 57
	BEGIN
		
		SET @OrderBy = N' POST0011.AccountID '
		IF ISNULL(@IsDealer, 0) = 0 
			SET @sWhere = @sWhere + N' AND ISNULL(AT02.IsDealer, 0) = 0
			'
		ELSE
			SET @sWhere = @sWhere + N' AND ISNULL(AT02.IsDealer, 0) = 1
			'
		IF(@DivisionID = 'ANGEL-SELLIN')
			SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.O03ID, '''') IN (''' + @UserID + ''' ) OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @UserID + ''' ) OR ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @UserID + ''' ) OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' ) OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' ))'
		IF(@DivisionID = 'ANGEL-SELLOUT')
		BEGIN
			SET @sWhereSELLOUT = 'LEFT JOIN CIT1180 WITH (NOLOCK) ON CIT1180.UserID = ''' + @UserID + ''' '
			SET @sWhere = @sWhere + ' AND AT02.FatherObjectID = CIT1180.DealerID '

		END
	END
	ELSE IF ISNULL(@DealerDivisionID, '') NOT IN ('', '...') -- Có sử dụng Division Sellout.
	BEGIN

		SET @OrderBy = N' POST0011.AccountID '
		IF ISNULL(@IsDealer, 0) = 0 
			SET @sWhere = @sWhere + N' AND ISNULL(AT02.IsDealer, 0) = 0
			'
		ELSE
			SET @sWhere = @sWhere + N' AND ISNULL(AT02.IsDealer, 0) = 1
			'

		IF(@DivisionID = @DealerDivisionID)
		BEGIN
			SET @sWhereSELLOUT = 'LEFT JOIN CIT1180 WITH (NOLOCK) ON CIT1180.DivisionID =''' + @DivisionID + ''' 
																		AND CIT1180.UserID = ''' + @UserID + ''' '

			-- Account Dealer
			IF EXISTS (SELECT TOP 1 1 from CIT1180 where DivisionID = @DivisionID AND @UserID  = CIT1180.DealerID  )
				SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.O03ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(AT02.FatherObjectID, '''') IN (''' + @UserID + ''' ))'

			-- Account SupID
			ELSE IF EXISTS (SELECT TOP 1 1 from CIT1180 where DivisionID = @DivisionID AND @UserID  = CIT1180.SUPID  )
			SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.O03ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(AT02.FatherObjectID, '''') IN (''' + @UserID + ''' ))'

			-- Account AsmID
			ELSE IF EXISTS (SELECT TOP 1 1 from CIT1180 where DivisionID = @DivisionID AND @UserID  = CIT1180.ASMID  )
			SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.O03ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.O05ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(AT02.FatherObjectID, '''') IN (''' + @UserID + ''' ))'
			
			
			-- Account SaleID
			ELSE -- Sale thấy mỗi Sale
				SET @sWhere = @sWhere + ' AND AT02.CreateUserID = CIT1180.UserID'
				--Print 'B'
		
		END
		
		IF(@DivisionID <> ISNULL(@DealerDivisionID, ''))
			SET @sWhere = @sWhere + ' AND (ISNULL(POST0011.O03ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' ) 
											OR ISNULL(POST0011.O04ID, '''') IN (''' + @UserID + ''' )
										)'

	END
	

END


	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + N' AND (POST0011.CreateDate >= ''' + @FromDateText + '''
											OR POST0011.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + N' AND (POST0011.CreateDate <= ''' + @ToDateText + ''' 
											OR POST0011.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + N' AND (POST0011.CreateDate BETWEEN ''' + @FromDateText + N''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + N' AND (SELECT FORMAT(POST0011.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + N' AND (SELECT FORMAT(POST0011.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF ISNULL(@SearchWhere, '') != ''
BEGIN
	SET @sWhere = '1 = 1'
	IF ISNULL(@ConditionObjectID,'') != ''
		SET @sWhere = @sWhere + N' AND (ISNULL(POST0011.AssignedToUserID, '''') IN (''' + @ConditionObjectID + ''' ) OR ISNULL(POST0011.CreateUserID, '''') IN (''' + @ConditionObjectID + ''' ))'
END

SET @sWhere = @sWhere + ' AND ISNULL(POST0011.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(POST0011.DeleteFlg,0) = 0 '

IF @IsExcel = 0
BEGIN
	SET @sSQL = N'SELECT POST0011.CreateUserID,  POST0011.APK, CASE WHEN POST0011.IsCommon = 1 THEN '''' ELSE POST0011.DivisionID END AS DivisionID, POST0011.MemberID AS AccountID
						, POST0011.MemberName AS AccountName
						, POST0011.Address
						, COALESCE(POST0011.Tel, POST0011.Phone, '''') AS Tel
						, POST0011.Fax,
						  POST0011.Email, O.Description AS ConvertTypeName
						, POST0011.InheritConvertID,
						  POST0011.IsCommon, ISNULL(POST0011.IsUsing, 0) AS IsUsing,
						  POST0011.Disabled, POST0011.CreateDate
						, POST0011.Website, POST0011.O01ID,
						 POST0011.O02ID,
						  POST0011.O03ID,
						  POST0011.O04ID,
						  POST0011.O05ID
						, POST0011.IsOrganize,
						  POST0011.Description,
						  POST0011.BillCountryID,
						  POST0011.BillCityID,
						  POST0011.BillPostalCode
						, D.CountryName,
						  E.CityName,
						  F.AreaName
						, POST0011.Birthday AS BirthDate			--Ngày sinh
						, Month(POST0011.Birthday) AS BirthMonth	--Tháng sinh
						, YEAR(POST0011.Birthday) AS BirthYear		--Năm sinh
						, POST0011.Gender							--Mã giới tính
						, P99.Description AS GenderName				--Tên giới tính
						, CASE WHEN MONTH(ISNULL(POST0011.Birthday, GETDATE())) = Month(GETDATE()) AND YEAR(ISNULL(POST0011.Birthday, GETDATE())) = YEAR(GETDATE())
									THEN 1
									ELSE CEILING(ROUND(CAST(DATEDIFF(MONTH, POST0011.Birthday, GETDATE()) AS DECIMAL(28, 8)) / 12.0, 2))
									END AS YearOld					--Tuổi
						, ISNULL(AT02.IsDealer, 0) AS IsDealer
						, AT02.FatherObjectID AS FatherObjectID
						,POST0011.AssignedToUserID
						,A.FullName AS AssignedToUserName
				INTO #TemPOST0011
				FROM POST0011 WITH (NOLOCK) 
						LEFT JOIN AT1001 D WITH (NOLOCK) ON POST0011.BillCountryID = D.CountryID
						LEFT JOIN AT1002 E WITH (NOLOCK) ON POST0011.BillCityID = E.CityID
						LEFT JOIN AT1003 F WITH (NOLOCK) ON POST0011.BillPostalCode = F.AreaID
						LEFT JOIN CRMT0099 O WITH (NOLOCK) ON CONVERT(VARCHAR, POST0011.ConvertType) = O.ID AND O.CodeMaster = ''CRMT00000002''
						LEFT JOIN POST0099 P99 WITH (NOLOCK) ON CONVERT(VARCHAR, POST0011.Gender) = P99.ID AND P99.CodeMaster = ''POS000009''
						LEFT JOIN AT1103 A WITH (NOLOCK) ON POST0011.AssignedToUserID = A.EmployeeID 
						LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', POST0011.DivisionID) AND AT02.ObjectID = POST0011.MemberID
						'+@sWhereSELLOUT+'
'
	IF @Type = 6
		SET @sSQL01 = N'
					WHERE ' + @sWhereDashboard + N'
					'
	ELSE --@Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
			SET @sSQLJoin = 
			CASE
				WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.APK = C.APKParent '
				WHEN @RelTable = 'CRMT20501_CRMT10101_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.APK = C.AccountID '
				WHEN @RelTable = 'CRMT20801_CRMT10101_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.APK = C.AccountID 
																 LEFT JOIN CRMT20801 C2 WITH (NOLOCK) ON C.RequestID = C2.RequestID
																 '
				WHEN @RelTable = 'CRMT10102' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.MemberID = C.AccountID 
												   LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = C.ContactID
												   '
				WHEN @RelTable = 'OOT2170' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.MemberID = C.AccountID '
				WHEN @RelTable = 'CRMT2170' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.MemberID = C.MemberID '
				WHEN @RelTable IN ('OT2101', 'OT2001', 'OT2003') THEN 'INNER JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON POST0011.MemberID = C.ObjectID '
				ELSE ''
			END

			SET @sSQL01 = 
			CASE
				WHEN @RelTable = 'CRMT0088' THEN 'WHERE POST0011.DivisionID = ''' +@DivisionID+ ''' AND C.APKChild = ''' +@RelAPK+''' AND POST0011.DeleteFlg = 0'
				WHEN @RelTable = 'CRMT20501_CRMT10101_REL' THEN 'WHERE POST0011.DivisionID = ''' +@DivisionID+ ''' AND C.OpportunityID = ''' +@RelAPK+''' AND POST0011.DeleteFlg = 0'
				WHEN @RelTable = 'CRMT20801_CRMT10101_REL' THEN 'WHERE POST0011.DivisionID = ''' +@DivisionID+ ''' AND C2.APK = ''' +@RelAPK+''' AND POST0011.DeleteFlg = 0'
				WHEN @RelTable = 'CRMT10102' THEN 'WHERE POST0011.DivisionID = ''' +@DivisionID+ ''' AND C2.APK = ''' +@RelAPK+''' AND POST0011.DeleteFlg = 0'
				WHEN @RelTable IN ('OOT2170', 'CRMT2170', 'OT2101', 'OT2001', 'OT2003') THEN 'WHERE POST0011.DivisionID = ''' +@DivisionID+ ''' 
																					AND C.APK = ''' +@RelAPK+''' AND POST0011.DeleteFlg = 0'
				ELSE N'
					WHERE ' + @sWhere + N'
					'
			END
		END
		ELSE
			SET @sSQL01 = N'
						WHERE ' + @sWhere + N'
						'
	END
		
    SET @sSQL02 = N' 
				DECLARE @count INT
				SELECT @count = COUNT(AccountID) FROM #TemPOST0011
				' + ISNULL(@SearchWhere, '') + N'

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + N') AS RowNum, @count AS TotalRow, POST0011.CreateUserID, POST0011.APK
						, POST0011.DivisionID, POST0011.AccountID
						, POST0011.AccountName, POST0011.Address, POST0011.Tel, POST0011.Fax, POST0011.Email, POST0011.ConvertTypeName
						, POST0011.InheritConvertID, POST0011.IsCommon, POST0011.IsUsing, POST0011.Disabled, POST0011.CreateDate
						, POST0011.Website, POST0011.O01ID, POST0011.O02ID, POST0011.O03ID, POST0011.O04ID, POST0011.O05ID
						, POST0011.Description, POST0011.BillCountryID
						, POST0011.BillCityID, POST0011.BillPostalCode, POST0011.IsOrganize
						, POST0011.CountryName, POST0011.CityName, POST0011.AreaName, POST0011.BirthDate, POST0011.BirthMonth, POST0011.BirthYear, POST0011.Gender, POST0011.GenderName, POST0011.YearOld, POST0011.IsDealer, POST0011.FatherObjectID
						,POST0011.AssignedToUserID
						,POST0011.AssignedToUserName
				FROM #TemPOST0011 POST0011
				' + ISNULL(@SearchWhere, '') + N'
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END
ELSE
BEGIN
	SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS OrderNo, POST0011.APK, CASE WHEN POST0011.IsCommon = 1 THEN '''' ELSE POST0011.DivisionID END AS DivisionID, POST0011.MemberID AS AccountID
						, POST0011.MemberName AS AccountName, POST0011.Address
						, POST0011.Phone, POST0011.Tel
						, POST0011.Fax, POST0011.Email, O.Description AS ConvertTypeName
						, POST0011.InheritConvertID, POST0011.IsCommon, ISNULL(POST0011.IsUsing, 0) AS IsUsing, POST0011.Disabled, POST0011.CreateDate, B.FullName AS CreateUserID
						, POST0011.Website, POST0011.O01ID, POST0011.O02ID, POST0011.O03ID, POST0011.O04ID, POST0011.O05ID
						, POST0011.IsOrganize, POST0011.Description, POST0011.BillCountryID, POST0011.BillCityID, POST0011.BillPostalCode
						, D.CountryName, E.CityName, F.AreaName
						, POST0011.Birthday AS BirthDate			--Ngày sinh
						, MONTH(POST0011.Birthday) AS BirthMonth	--Tháng sinh
						, YEAR(POST0011.Birthday) AS BirthYear		--Năm sinh
						, POST0011.Gender							--Mã giới tính
						, P99.Description AS GenderName				--Tên giới tính
						, CASE WHEN MONTH(ISNULL(POST0011.Birthday, GETDATE())) = MONTH(GETDATE()) AND YEAR(ISNULL(POST0011.Birthday, GETDATE())) = YEAR(GETDATE()) 
									THEN 1
								ELSE CEILING(ROUND(CAST(DATEDIFF(MONTH, POST0011.Birthday, GETDATE()) AS DECIMAL(28, 8)) / 12.0, 2))
								END AS YearOld						--Tuổi
						, CONCAT(
								POST0011.DeliveryAddress
								,CASE WHEN ISNULL(POST0011.DeliveryAddress, '''') != '''' AND ISNULL(POST0011.DeliveryWard, '''') != '''' THEN '', '' ELSE '''' END
								,POST0011.DeliveryWard
								,CASE WHEN ISNULL(POST0011.DeliveryWard, '''') != '''' AND ISNULL(POST0011.DeliveryDistrictID, '''') != '''' THEN '', '' ELSE '''' END
								,C1.DistrictName
								,CASE WHEN ISNULL(C1.DistrictName, '''') != '''' AND ISNULL(POST0011.DeliveryCityID, '''') != '''' THEN '', '' ELSE '''' END
								,E1.CityName
								,CASE WHEN ISNULL(E1.CityName, '''') != '''' AND ISNULL(POST0011.DeliveryCountryID, '''') != '''' THEN '', '' ELSE '''' END
								,D1.CountryName) AS DeliveryAddress
						, CONCAT(
								POST0011.BillAddress
								,CASE WHEN ISNULL(POST0011.BillAddress, '''') != '''' AND ISNULL(POST0011.DeliveryWard, '''') != '''' THEN '', '' ELSE '''' END
								,POST0011.BillWard
								,CASE WHEN ISNULL(POST0011.BillWard, '''') != '''' AND ISNULL(POST0011.BillDistrictID, '''') != '''' THEN '', '' ELSE '''' END
								,C.DistrictName
								,CASE WHEN ISNULL(C.DistrictName, '''') != '''' AND ISNULL(POST0011.BillCityID, '''') != '''' THEN '', '' ELSE '''' END
								,E.CityName,CASE WHEN ISNULL(E.CityName, '''') != '''' AND ISNULL(POST0011.BillCountryID, '''') != '''' THEN '', '' ELSE '''' END
								,D.CountryName) AS BillAddress
						 , POST0011.VATAccountID
						 , POST0011.AssignedToUserID
						 , A.FullName AS AssignedToUserName
						 , B.FullName AS CreateUserName
				INTO #TemPOST0011 FROM POST0011 WITH (NOLOCK)'

	SET @sSQLJoin = N' 
					LEFT JOIN AT1001 D WITH (NOLOCK) ON POST0011.BillCountryID = D.CountryID
					LEFT JOIN AT1002 E WITH (NOLOCK) ON POST0011.BillCityID = E.CityID
					LEFT JOIN AT1013 C WITH (NOLOCK) ON POST0011.BillDistrictID = C.DistrictID
					LEFT JOIN AT1003 F WITH (NOLOCK) ON POST0011.BillPostalCode = F.AreaID
					LEFT JOIN CRMT0099 O WITH (NOLOCK) ON CONVERT(VARCHAR, POST0011.ConvertType) = O.ID AND O.CodeMaster = ''CRMT00000002''
					LEFT JOIN POST0099 P99 WITH (NOLOCK) ON CONVERT(VARCHAR, POST0011.Gender) = P99.ID AND P99.CodeMaster = ''POS000009''
					LEFT JOIN AT1103 A WITH (NOLOCK) ON POST0011.AssignedToUserID = A.EmployeeID
					LEFT JOIN AT1103 B WITH (NOLOCK) ON POST0011.CreateUserID = B.EmployeeID
					LEFT JOIN AT1001 D1 WITH (NOLOCK) ON POST0011.DeliveryCountryID = D1.CountryID
					LEFT JOIN AT1002 E1 WITH (NOLOCK) ON POST0011.DeliveryCityID = E1.CityID
					LEFT JOIN AT1013 C1 WITH (NOLOCK) ON POST0011.DeliveryDistrictID = C1.DistrictID
					LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', POST0011.DivisionID) AND AT02.ObjectID = POST0011.MemberID
						'
	SET @sSQL01 = N'
				WHERE ' + @sWhere + N'
				'
	SET @sSQL02 = N'
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + N') AS OrderNo
						, POST0011.APK
						, POST0011.DivisionID, POST0011.AccountID
						, POST0011.AccountName, POST0011.Address
						, CASE WHEN ISNULL(POST0011.Phone, ''NULL'') NOT IN ('''', ''NULL'') THEN POST0011.Phone
							   WHEN ISNULL(POST0011.Tel, ''NULL'') NOT IN ('''', ''NULL'') THEN POST0011.Tel
						  END AS Tel
						, POST0011.Fax, POST0011.Email, POST0011.ConvertTypeName
						, POST0011.InheritConvertID, POST0011.IsCommon, POST0011.IsUsing, POST0011.Disabled, POST0011.CreateDate, POST0011.CreateUserID
						, POST0011.Website, POST0011.O01ID, POST0011.O02ID, POST0011.O03ID, POST0011.O04ID, POST0011.O05ID
						, POST0011.Description, POST0011.BillCountryID
						, POST0011.BillCityID, POST0011.BillPostalCode, POST0011.IsOrganize
						, POST0011.CountryName, POST0011.CityName, POST0011.AreaName, POST0011.BirthDate, POST0011.BirthMonth, POST0011.BirthYear, POST0011.Gender, POST0011.GenderName, POST0011.YearOld
						, POST0011.DeliveryAddress, POST0011.BillAddress, POST0011.VATAccountID,POST0011.AssignedToUserID, POST0011.AssignedToUserName, POST0011.CreateUserName
				FROM #TemPOST0011 POST0011
				' + ISNULL(@SearchWhere, '') + '
				ORDER BY ' + @OrderBy + '
				'
END


--PRINT (@CustomerIndex)
--PRINT (@sSQL)
--PRINT (@sSQL01)
--PRINT (@sSQL02)

EXEC (@sSQL + @sSQLJoin)

EXEC (@sSQL + @sSQLJoin + @sSQL01+ @sSQL02)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
