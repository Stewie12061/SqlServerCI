IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load màn hình chọn khách hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ
---- Modified by Tiểu Mai on 26/04/2016: Bổ sung Customize cho khách hàng Angel (CustomizeIndex = 57)
---- Modified by Thị Phượng on 25/07/2016: Bỏ kết với CT0143 để cái tiến tốc độ store vì load chậm
---- Modified by Hoàng vũ on 10/11/2016: Bổ sung thêm tham số @IsOrganize khi đứng tại màn hình CRMF1001 và CRMF2007 chọn khách hàng, những màn hình khác thì load default là null
---- Modified by Thị Phượng on 05/1/2017: Boor sung Load RePaymentTermID cho HT 
---- Modified by Thị Phượng on 17/04/2017: Bổ sung load khách hàng có IsCommon =1 với DivisionID ='@@@'
---  Modify by Thị Phượng,	Date 08/05/2017: Bổ sung phân quyền
---  Modify by Hoàng vũ,	Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
---  Modify by Trà Giang,	Date 21/11/2018: Load danh sách khách hàng từ AT1202 thay cho bảng từ POS
---  Modify by Trà Giang,	Date 23/11/2018: Bổ sung load địa chỉ giao hàng, người liên hệ cho ATTOM
---  Modify by Bảo Toàn,	Date 16/07/2019: custom 114 (DUCTIN) load khách hàng
---  Modify by Kiều Nga,	Date 11/06/2020: Tạo custom 117 (MAITHU) load thông tin địa chỉ giao hàng
---  Modify by Kiều Nga,	Date 02/11/2020: Fix lỗi chạy tiếp vào custiomize MAITHƯ
---  Modify by Tấn Lộc,		Date 26/12/2020: Bổ sung lấy thêm dữ liệu Ngành nghề kinh doanh vào custiomize MAITHƯ
---  Modify by Đình Hòa.,	Date 26/05/2020: Bổ sung lấy thêm dữ liệu khách hàng dùng chung cho MECI
---  Modify by Văn Tài,		Date 17/01/2022: Bổ sung trường hợp lấy danh sách khách hàng theo người phụ trách.
---  Modify by Minh Hiếu.,	Date 09/02/2022: Bổ sung lấy thêm RePaymentTermID,PaymentTermName
---  Modify by Nhựt Trường, Date 09/02/2022: ANGEL - Bổ sung load khách hàng là IsDealer.
---  Modify by Văn Tài,		Date 31/03/2022: Kiểm tra lấy danh sách dữ liệu theo người phụ trách và quyền xem dữ liệu đối tượng.
-- <Example> exec sp_executesql N'CRMP90011 @DivisionID=N''HCM'',@TxtSearch=N''77'',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'
 CREATE PROCEDURE CRMP90011 (
     @DivisionID NVARCHAR(2000),
	 @IsOrganize tinyint, --NULL: defualt; 1: Load form CRMF1001 và CRMF2007
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ConditionObjectID  NVARCHAR (MAX),
	 @ContactID VARCHAR (MAX) = null,
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = ' CRMT10101.AccountID, CRMT10101.AccountName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	


IF @CustomerName = 57 --- ANGEL
BEGIN
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow,
	AT1202.DivisionID, ObjectID as AccountID, ObjectName as AccountName,
	(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName,
	Address, VATNo, Tel, Email, IsCommon, Disabled,
	IsInvoice, '''' as RouteID, '''' as RouteName, Note as Description, Note, Note1, '''' as DeliveryAddress
    From AT1202 With (NOLOCK)
    WHERE (AT1202.IsDealer=1 or AT1202.IsCustomer=1 or AT1202.IsUpdateName=1) And AT1202.Disabled =0
    AND AT1202.DivisionID = '''+@DivisionID+''' ' + @sWhere +'
    ORDER BY ObjectID, ObjectName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE
IF @CustomerName = 51 --- HOANGTRAN
BEGIN

	IF Isnull(@IsOrganize, 0) = 1
			SET @sWhere = @sWhere + N' And CRMT10101.IsOrganize = 1 '
	
	IF Isnull(@TxtSearch,'') !='' SET @sWhere = @sWhere +N' AND (AccountID LIKE N''%'+@TxtSearch+'%'' 
								OR AccountName LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'')'
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	CRMT10101.DivisionID, CRMT10101.AccountID, CRMT10101.AccountName
	, CRMT10101.VATAccountID
	, Null as VATAccountName
	, CRMT10101.Address, CRMT10101.VATNo
	, CRMT10101.Tel, CRMT10101.Email, CRMT10101.IsCommon, CRMT10101.Disabled
	, CRMT10101.IsInvoice
	, CRMT10101.RouteID
	, CRMT10101.Description, CRMT10101.Note, CRMT10101.Note1, CRMT10101.DeliveryAddress, CRMT10101.RePaymentTermID
	FROM CRMT10101 With (NOLOCK)
   WHERE CRMT10101.Disabled = 0 and CRMT10101.DivisionID in( '''+@DivisionID+''') '+@sWhere+'
				
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	
END
ELSE
IF @CustomerName = 114 -- DUCTIN
BEGIN
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (MemberID LIKE N''%'+@TxtSearch+'%'' 
								OR MemberName LIKE N''%'+@TxtSearch+'%'' 
								OR VATNo LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY MemberID, MemberName) AS RowNum, '+@TotalRow+' AS TotalRow,
	A.DivisionID, MemberID as AccountID, MemberName as AccountName,
	Address, VATNo, Tel, Email, IsCommon, Disabled
    From POST0011 A With (NOLOCK)
    WHERE A.IsCustomer=1  And A.Disabled =0
    AND A.DivisionID = '''+@DivisionID+''' ' + @sWhere +'
    ORDER BY MemberID, MemberName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE
IF @CustomerName = 117 -- Customize cho Mai Thư
BEGIN
IF ISNULL(@ContactID, '') != ''
	SET @sWhere = @sWhere + ' AND CRMT10102.ContactID LIKE N''%'+@ContactID+'%''  '

		IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY AccountID, AccountName) AS RowNum, '+@TotalRow+' AS TotalRow, *
	From (
		 select distinct ObjectID as AccountID, ObjectName as AccountName, AT1202.DivisionID,
		(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName,
		Address, VATNo, Tel, Email, IsCommon, AT1202.Disabled,
		IsInvoice, '''' as RouteID, '''' as RouteName, Note as Description, Note, Note1--,P.DeliveryAddress, Contactor, P.BusinessLinesID, P.BusinessLinesName
		From AT1202 With (NOLOCK)
			LEFT JOIN CRMT10102 WITH (NOLOCK) ON AT1202.ObjectID = CRMT10102.AccountID
			LEFT JOIN (select * from 
						(select ROW_NUMBER() OVER (PARTITION BY A.MemberID ORDER BY A.MemberID DESC) as t,A.MemberID,ISNULL(C.DeliveryAddress,'''')  + '', '' + ISNULL(A4.DistrictName,'''')   + '', '' + ISNULL(A2.CityName,'''') AS DeliveryAddress,C.DeliveryWard, C.DeliveryDistrictID, C.DeliveryCityID, C.DeliveryPostalCode, C.DeliveryCountryID , A.BusinessLinesID, CRMT10701.BusinessLinesName
						from CRMT101011 C With (NOLOCK)    
						LEFT JOIN AT1001 A1 WITH(NOLOCK) ON C.DeliveryCountryID = A1.CountryID   
						INNER JOIN (
									select * 
									from POST0011 With (NOLOCK)
									where DivisionID = '''+@DivisionID+''' ) as A ON A.APK = C.APKMaster
						LEFT JOIN CRMT10701 WITH (NOLOCK) ON A.BusinessLinesID = CRMT10701.BusinessLinesID   
						LEFT JOIN AT1002 A2 WITH(NOLOCK) ON C.DeliveryCityID = A2.CityID  AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0   
						LEFT JOIN AT1003 A3 WITH(NOLOCK) ON C.DeliveryPostalCode = A3.AreaID  AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0   
						LEFT JOIN AT1013 A4 WITH(NOLOCK)ON C.DeliveryDistrictID = A4.DistrictID          
						AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0  where  C.DivisionID = '''+@DivisionID+''') B
						where B.t = 1)P ON P.MemberID = AT1202.ObjectID
		WHERE (AT1202.IsCustomer=1 or AT1202.IsUpdateName=1) And AT1202.Disabled =0
		AND AT1202.DivisionID = '''+@DivisionID+''' ' + @sWhere +') AS Account 
    ORDER BY AccountID, AccountName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE
IF @CustomerName = 137 -- Customize cho MECI
BEGIN
IF ISNULL(@ContactID, '') != ''
	SET @sWhere = @sWhere + ' AND CRMT10102.ContactID LIKE N''%'+@ContactID+'%''  '

		IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY AccountID, AccountName) AS RowNum, '+@TotalRow+' AS TotalRow, *
	From (
		 select distinct AT1202.ObjectID as AccountID, AT1202.ObjectName as AccountName, AT1202.DivisionID,
		(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName,
		Address, VATNo, Tel, Email,Website, IsCommon, AT1202.Disabled,
		IsInvoice, '''' as RouteID, '''' as RouteName, Note as Description, Note, Note1, DeAddress as DeliveryAddress, Contactor
		From AT1202 With (NOLOCK)
			LEFT JOIN CRMT10102 WITH (NOLOCK) ON AT1202.ObjectID = CRMT10102.AccountID
		WHERE (AT1202.IsCustomer=1 or AT1202.IsUpdateName=1) And AT1202.Disabled =0
		AND AT1202.DivisionID IN ('''+@DivisionID+''',''@@@'') ' + @sWhere +') AS Account 
    ORDER BY AccountID, AccountName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE
IF @CustomerName = 147 -- Customize cho VNA
BEGIN

	IF Isnull(@ConditionObjectID,'')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(T11.AssignedToUserID, T11.CreateUserID) IN ('''+@ConditionObjectID+''' )'

	IF ISNULL(@ContactID, '') != ''
	SET @sWhere = @sWhere + ' AND CRMT10102.ContactID LIKE N''%'+@ContactID+'%''  '

		IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Address LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Tel LIKE N''%'+@TxtSearch + '%'' 
								OR AT1202.Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY AccountID, AccountName) AS RowNum, '+@TotalRow+' AS TotalRow, *
	From (
		 select distinct AT1202.ObjectID as AccountID, AT1202.ObjectName as AccountName, AT1202.DivisionID,
		(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName,
		AT1202.Address
		, AT1202.VATNo
		, AT1202.Tel
		, AT1202.Email
		, AT1202.Website
		, AT1202.IsCommon
		, AT1202.Disabled
		, AT1202.IsInvoice, '''' as RouteID, '''' as RouteName
		, AT1202.Note as Description
		, AT1202.Note
		, AT1202.Note1, DeAddress as DeliveryAddress, Contactor
		From AT1202 With (NOLOCK)
			LEFT JOIN CRMT10102 WITH (NOLOCK) ON AT1202.ObjectID = CRMT10102.AccountID
			LEFT JOIN POST0011 T11 WITH (NOLOCK) ON AT1202.DivisionID IN (''@@@'', AT1202.DivisionID) AND T11.MemberID = AT1202.ObjectID
		WHERE (AT1202.IsCustomer=1 or AT1202.IsUpdateName=1) And AT1202.Disabled =0
		AND AT1202.DivisionID IN (''@@@'', '''+@DivisionID+''') 
		' 		
		+ @sWhere 
		+') AS Account 
    ORDER BY AccountID, AccountName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE
BEGIN
	/*IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (CRMT10101.MemberID LIKE N''%'+@TxtSearch+'%'' 
							OR CRMT10101.MemberName LIKE N''%'+@TxtSearch+'%'' 
							OR CRMT10101.VATAccountID LIKE N''%'+@TxtSearch+'%'' 
							OR CRMT10101.Address LIKE N''%'+@TxtSearch+'%'' 
							OR CRMT10101.Tel LIKE N''%'+@TxtSearch + '%'' 
							OR CRMT10101.Email LIKE N''%'+@TxtSearch+'%'')'
	IF Isnull(@ConditionObjectID,'')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10101.AssignedToUserID,CRMT10101.CreateUserID) in ('''+@ConditionObjectID+''' )'
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY CRMT10101.MemberID, CRMT10101.MemberName ) AS RowNum, '+@TotalRow+' AS TotalRow, CRMT10101.APK
							, CRMT10101.DivisionID, CRMT10101.MemberID as AccountID, CRMT10101.MemberName as AccountName
							, (Case when Isnull(CRMT10101.VATAccountID, '''') = '''' then CRMT10101.MemberID else CRMT10101.VATAccountID end) as VATAccountID, Null as VATAccountName
							, CRMT10101.Address, CRMT10101.VATNo
							, CRMT10101.Tel, CRMT10101.Email, CRMT10101.IsCommon, CRMT10101.Disabled
							, CRMT10101.IsInvoice
							, Null as RouteID
							, Null RouteName
							, CRMT10101.Description, CRMT10101.Note, CRMT10101.Note1, CRMT10101.DeliveryAddress
				FROM POST0011 CRMT10101 WITH (NOLOCK)  
				WHERE CRMT10101.Disabled = 0 and (CRMT10101.DivisionID in ('''+@DivisionID+''') or IsCommon =1) '+@sWhere+'
				ORDER BY CRMT10101.MemberID, CRMT10101.MemberName 
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '*/
IF ISNULL(@ContactID, '') != ''
	SET @sWhere = @sWhere + ' AND CRMT10102.ContactID LIKE N''%'+@ContactID+'%''  '

		IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR Address LIKE N''%'+@TxtSearch+'%'' 
								OR Tel LIKE N''%'+@TxtSearch + '%'' 
								OR Email LIKE N''%'+@TxtSearch+'%'')'
	
	SET @sSQL = '
	Select ROW_NUMBER() OVER (ORDER BY AccountID, AccountName) AS RowNum, '+@TotalRow+' AS TotalRow, *
	From (
		 select distinct AT1202.ObjectID as AccountID, AT1202.ObjectName as AccountName, AT1202.DivisionID,
		(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName,
		Address, VATNo, Tel, Email,Website, AT1202.IsCommon, AT1202.Disabled,
		IsInvoice, '''' as RouteID, '''' as RouteName, Note as Description, Note, Note1, DeAddress as DeliveryAddress, Contactor, AT1202.RePaymentTermID,AT1208.PaymentTermName
		From AT1202 With (NOLOCK)
			LEFT JOIN CRMT10102 WITH (NOLOCK) ON AT1202.ObjectID = CRMT10102.AccountID
			LEFT JOIN AT1208 WITH (NOLOCK) ON AT1202.RePaymentTermID = AT1208.PaymentTermID and AT1208.Disabled = 0 And AT1208.IsDueDate = 1
      AND (AT1208.DivisionID IN (''@@@'', '''+@DivisionID+''') or AT1208.IsCommon = 1)
		WHERE (AT1202.IsCustomer=1 or AT1202.IsUpdateName=1) And AT1202.Disabled =0 AND ISNULL(AT1202.DeleteFlg,0) = 0
		AND AT1202.DivisionID IN (''@@@'', '''+@DivisionID+''') ' + @sWhere +') AS Account 
    ORDER BY AccountID, AccountName
    OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END


EXEC (@sSQL)
print  (@sSQL)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
