IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP11501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP11501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP11501 Danh muc đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao THị Phượng Date: 14/04/2016
----Edit by : Đình Hòa Date : 28/12/2020 Bổ sung load địa chỉ và mã số thuế cho đối tượng(MAITHU)
----Modified by: Hoài Bảo Date: 31/08/2022 - Bổ sung điều kiện không load record có DeleteFlg = 1
----Modified by: Hoài Thanh Date: 30/01/2023 - Bổ sung luồng load dữ liệu từ dashboard -> danh mục
----Modified by: Hoài Bảo Date: 15/02/2023 - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
----    EXEC CIP11501 'HT','','','','','','','','','','','','', 'ASOFTADMIN',10,1
----
CREATE PROCEDURE CIP11501 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID
        @ObjectTypeID NVARCHAR(50) = '',
        @ObjectID NVARCHAR(50) = '',
        @ObjectName NVARCHAR(250) = '',
		@Address NVARCHAR(100) = '',
		@Email NVARCHAR(100) = '',
		@Tel NVARCHAR(100) = '', 
		@IsUpdateName NVARCHAR(100) = '',
		@IsSupplier NVARCHAR(100) = '',
        @IsCustomer NVARCHAR(100) = '',
		@IsDealer NVARCHAR(100) = '',
        @IsCommon NVARCHAR(100) = '',
        @Disabled NVARCHAR(100) = '',
		@UserID  VARCHAR(50) = '',
		@PageSize INT = 25,
		@PageNumber INT = 1,
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@SupplierIDList NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR(MAX),
		@sSQL02 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhereDashboard NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
		@Count NVARCHAR(MAX)
		
SET @sWhere=' AND ISNULL(AT1202.DeleteFlg,0) = 0 '
SET @sWhereDashboard=' AND ISNULL(AT1202.DeleteFlg,0) = 0 '

SET @OrderBy='AT1202.DivisionID, AT1202.ObjectID'
IF (ISNULL(@DivisionIDList, '') = '')
		SET @sWhere = @sWhere + 'AND (AT1202.DivisionID = '''+@DivisionID+''' OR AT1202.IsCommon =1)'
	ELSE 
		BEGIN
			SET @sWhere = @sWhere + ' AND ( AT1202.DivisionID IN ('''+@DivisionIDList+''') OR AT1202.IsCommon =1)'        
			SET @sWhereDashboard = @sWhereDashboard + ' AND ( AT1202.DivisionID IN ('''+@DivisionIDList+''') OR AT1202.IsCommon =1)'        
		END
	IF (ISNULL(@ObjectID, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectID, '''') LIKE N''%'+@ObjectID+'%'' '
	IF (ISNULL(@ObjectName, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectName,'''') LIKE N''%'+@ObjectName+'%''  '
	IF (ISNULL(@Address, '') != '')
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Address,'''') LIKE N''%'+@Address+'%'' '
	IF (ISNULL(@Email, '') != '')
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Email,'''') LIKE N''%'+@Email+'%'' '
	IF (ISNULL(@Tel, '') != '')
		SET @sWhere = @sWhere +  'AND ISNULL(AT1202.Tel,'''') LIKE N''%'+@Tel+'%'' '
	IF (ISNULL(@IsUpdateName, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsUpdateName,0) = '+@IsUpdateName
	IF (ISNULL(@IsSupplier, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsSupplier,0) = '+@IsSupplier
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(AT1202.IsSupplier,0) = '+@IsSupplier
		END
	IF (ISNULL(@IsCustomer, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsCustomer,0) = '+@IsCustomer
	IF (ISNULL(@IsDealer, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsDealer,0) = '+@IsDealer
	IF (ISNULL(@IsCommon, '') != '') 
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.IsCommon,0) = '+@IsCommon
	IF (ISNULL(@Disabled, '') != '')
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.Disabled,0) = '+@Disabled
	IF (ISNULL(@ObjectTypeID, '') != '')
		SET @sWhere = @sWhere + ' AND (ISNULL(AT1202.ObjectTypeID,'''') LIKE N''%'+@ObjectTypeID+'%'' 
									OR ISNULL(AT1201.ObjectTypeName, '''') LIKE N''%'+@ObjectTypeID+'%'')'

IF @Type = 6
	BEGIN
		IF (ISNULL(@SupplierIDList, '') != '')
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(AT1202.ObjectID, '''') IN ('''+@SupplierIDList+''') '
		SET @sWhere1 = 'WHERE 1=1 '+@sWhereDashboard +' '
	END
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere1 = 
		CASE
			WHEN @RelTable IN ('AT2016', 'WT0095', 'AT2006') THEN 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON AT1202.ObjectID = C08.ObjectID
										WHERE AT1202.DivisionID = ''' +@DivisionID+ ''' AND ISNULL(AT1202.DeleteFlg, 0) = 0 AND C08.APK = ''' +@RelAPK+''' '
			ELSE 'WHERE 1=1 '+@sWhere +' '
		END
	END
	ELSE
		SET @sWhere1 = 'WHERE 1=1 '+@sWhere +' '
END

IF @PageNumber = 1
	BEGIN
		SET @Count = 'SELECT COUNT(AT1202.ObjectID) FROM AT1202
						LEFT JOIN AT1201 ON AT1202.ObjectTypeID = AT1201.ObjectTypeID
						LEFT JOIN AT1207 AT1207_S1 ON AT1202.S1 = AT1207_S1.S AND AT1207_S1.STypeID = ''O01'' 
						LEFT JOIN AT1207 AT1207_S2 ON AT1202.S2 = AT1207_S2.S AND AT1207_S2.STypeID = ''O02'' 
						LEFT JOIN AT1207 AT1207_S3 ON AT1202.S3 = AT1207_S3.S AND AT1207_S3.STypeID = ''O03'' 
						LEFT JOIN AT1015 AT1015_O01 ON AT1202.O01ID = AT1015_O01.AnaID AND AT1015_O01.AnaTypeID = ''O01''
						LEFT JOIN AT1015 AT1015_O02 ON AT1202.O02ID = AT1015_O02.AnaID AND AT1015_O02.AnaTypeID = ''O02'' 
						LEFT JOIN AT1015 AT1015_O03 ON AT1202.O03ID = AT1015_O03.AnaID AND AT1015_O03.AnaTypeID = ''O03''
						LEFT JOIN AT1015 AT1015_O04 ON AT1202.O04ID = AT1015_O04.AnaID AND AT1015_O04.AnaTypeID = ''O04''
						LEFT JOIN AT1015 AT1015_O05 ON AT1202.O05ID = AT1015_O05.AnaID AND AT1015_O05.AnaTypeID = ''O05''
						'+@sWhere1+'
					'
	END
		ELSE SET @Count = 'SELECT 0'

	DECLARE @CountEXEC TABLE (CountRow NVARCHAR(MAX))
	INSERT INTO @CountEXEC (CountRow)
	EXEC (@Count)
		
SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+(Select CountRow from @CountEXEC)+' AS TotalRow,
	AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName,
	AT1202.S1, AT1207_S1.SName, AT1202.S2, AT1207_S2.SName, AT1202.S3, AT1207_S3.SName,
	AT1202.ObjectTypeID, AT1201.ObjectTypeName, AT1202.IsSupplier, AT1202.IsCustomer, AT1202.IsDealer ,
	AT1202.CurrencyID, AT1202.CityID, AT1202.CountryID, AT1202.IsCommon, AT1202.[Disabled],
	AT1202.ReCreditLimit, AT1202.ReDueDays, AT1202.RePaymentTermID, AT1202.ReAccountID, AT1202.DeAddress, AT1202.Redays,
	AT1202.PaCreditLimit, AT1202.PaPaymentTermID, AT1202.PaDueDays, AT1202.PaAccountID,
	AT1202.PaDiscountDays, AT1202.PaDiscountPercent, AT1202.ReAddress, AT1202.Tel, AT1202.Fax, AT1202.Note,
	AT1202.Email, AT1202.BankName, AT1202.LicenseNo, AT1202.LegalCapital, AT1202.AreaID, AT1202.Note1, 
	AT1202.O01ID, AT1015_O01.AnaName, AT1202.O02ID, AT1015_O02.AnaName, AT1202.O03ID, AT1015_O03.AnaName,
	AT1202.O04ID, AT1015_O04.AnaName, AT1202.O05ID,AT1015_O05.AnaName, AT1202.IsUpdateName, AT1202.Address, AT1202.VATNo, AT1202.Contactor
	FROM AT1202 WITH (NOLOCK)'
SET @sSQL01=N'
	LEFT JOIN AT1201 ON AT1202.ObjectTypeID = AT1201.ObjectTypeID
	LEFT JOIN AT1207 AT1207_S1 ON AT1202.S1 = AT1207_S1.S AND AT1207_S1.STypeID = ''O01''
	LEFT JOIN AT1207 AT1207_S2 ON AT1202.S2 = AT1207_S2.S AND AT1207_S2.STypeID = ''O02''
	LEFT JOIN AT1207 AT1207_S3 ON AT1202.S3 = AT1207_S3.S AND AT1207_S3.STypeID = ''O03''
	LEFT JOIN AT1015 AT1015_O01 ON AT1202.O01ID = AT1015_O01.AnaID AND AT1015_O01.AnaTypeID = ''O01''
	LEFT JOIN AT1015 AT1015_O02 ON AT1202.O02ID = AT1015_O02.AnaID AND AT1015_O02.AnaTypeID = ''O02''
	LEFT JOIN AT1015 AT1015_O03 ON AT1202.O03ID = AT1015_O03.AnaID AND AT1015_O03.AnaTypeID = ''O03''
	LEFT JOIN AT1015 AT1015_O04 ON AT1202.O04ID = AT1015_O04.AnaID AND AT1015_O04.AnaTypeID = ''O04''
	LEFT JOIN AT1015 AT1015_O05 ON AT1202.O05ID = AT1015_O05.AnaID AND AT1015_O05.AnaTypeID = ''O05''
	'+@sWhere1+'
'
	
SET @sSQL02 = '	
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT (@sSQL+@sSQL01+@sSQL02)
EXEC (@sSQL+@sSQL01+@sSQL02)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
