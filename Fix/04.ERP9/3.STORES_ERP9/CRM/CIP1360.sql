IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1360]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1360]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load Grid danh sách hợp đồng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 26/10/2018
----Modify  on 07/08/2019 by Bảo Toàn - Cập nhật phân quyền
----Modify  on 08/03/2021 by Hoài Phong  Bổ sung lấy thêm cột gói bảo  hành
--- Modify by Anh Tuấn,   Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Hoài Bảo,   Date 21/09/2022: Bổ sung load cột VATOriginalAmount, VATConvertedAmount
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modify by Hoài Bảo,	  Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
/*
----Lọc thường
EXEC CIP1360 'BE',null,1,25,0,'2019-04-01','2019-04-20', '06/2018'',''04/2019','','', '', '','','','','','','','','',0,'',NULL
----lỌc nâng cao
EXEC CIP1360 'BS',null,1,25,1,'2018-06-29','2018-06-29', '06/2018'',''07/2018','','', '1','2','3','4','5','6','7','8','9','10',0, NULL,N' where IsNull(ContractNo,'''') = N''asdas'''

 select * from AT1011 WITH (NOLOCK) 
*/
 CREATE PROCEDURE CIP1360
(
 	@DivisionID VARCHAR(50) = '',
    @DivisionIDList NVARCHAR(2000) = '',
    @PageNumber INT = 1,
    @PageSize INT = 25,
	@IsDate TINYINT = 0, --1:Datetime;0:Period
    @FromDate DATETIME = NULL,
    @ToDate DATETIME = NULL,
	@PeriodIDList NVARCHAR(4000) = '',
	@ContractNo NVARCHAR(50) = '',
	@ObjectID NVARCHAR(50) = '',
	@Ana01ID NVARCHAR(250) = '',
	@Ana02ID NVARCHAR(250) = '',
	@Ana03ID NVARCHAR(250) = '',
	@Ana04ID NVARCHAR(250) = '',
	@Ana05ID NVARCHAR(250) = '',
	@Ana06ID NVARCHAR(250) = '',
	@Ana07ID NVARCHAR(250) = '',
	@Ana08ID NVARCHAR(250) = '',
	@Ana09ID NVARCHAR(250) = '',
	@Ana10ID NVARCHAR(250) = '',
	@IsExcel BIT = 0, --1: thực hiện xuất file Excel; 0: Thực hiện load danh sách
	@APKList NVARCHAR(250) = '',
	@SearchWhere NVARCHAR(MAX) = NULL, --#NULL: Lọc nâng cao; =NULL: Lọc thường
	@ConditionOpportunityID NVARCHAR(MAX),
	@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	@UserID NVARCHAR(250) = '',
	@RelAPK NVARCHAR(250) = '',
	@RelTable NVARCHAR(250) = ''
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sJoin VARCHAR(MAX) = '',
        @sWhere NVARCHAR(MAX),
        @sWhere1 NVARCHAR(MAX),
		@sWhereDashboard NVARCHAR(MAX) = '1 = 1',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '
SET @OrderBy = ' SignDate DESC, ContractNo'
/*
IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TAM (APK VARCHAR(50))
	INSERT INTO #TAM (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK
	FROM @APKList.nodes('//Data') AS X (Data)
END	
	*/
If ISNULL(@SearchWhere, '') = '' --Lọc thường
Begin
		--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + 'AND A20.DivisionID IN ('''+@DivisionIDList+''')'
			SET @sWhereDashboard = @sWhereDashboard + 'AND A20.DivisionID IN ('''+@DivisionIDList+''')'
		END
	Else 
		SET @sWhere = @sWhere + 'AND A20.DivisionID IN ('''+@DivisionID+''')'

	IF ISNULL(@ContractNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A20.ContractNo, '''') LIKE N''%'+@ContractNo+'%'' '

	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND (AT1202.ObjectName LIKE N''%' + @ObjectID + '%'' OR A20.ObjectID LIKE N''%' + @ObjectID + '%'') '
	
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), A20.SignDate, 112) BETWEEN ' + 
			CONVERT(VARCHAR(10), @FromDate, 112)+' AND ' + CONVERT(VARCHAR(10), @ToDate, 112)+' '
	IF @IsDate = 0 AND ISNULL(@PeriodIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(A20.SignDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(A20.SignDate))))+''/''+LTRIM(RTRIM(STR(YEAR(A20.SignDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(A20.SignDate))))+''/''+LTRIM(RTRIM(STR(YEAR(A20.SignDate)))) END) IN ('''+@PeriodIDList+''')'
			SET @sWhereDashboard = @sWhereDashboard + ' AND (CASE WHEN MONTH(A20.SignDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(A20.SignDate))))+''/''+LTRIM(RTRIM(STR(YEAR(A20.SignDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(A20.SignDate))))+''/''+LTRIM(RTRIM(STR(YEAR(A20.SignDate)))) END) IN ('''+@PeriodIDList+''')'
		END
	
	IF ISNULL(@Ana01ID, '') != '' OR ISNULL(@Ana02ID, '') != '' OR 
	   ISNULL(@Ana03ID, '') != '' OR ISNULL(@Ana04ID, '') != '' OR 
	   ISNULL(@Ana05ID, '') != '' OR ISNULL(@Ana06ID, '') != '' OR 
	   ISNULL(@Ana07ID, '') != '' OR ISNULL(@Ana08ID, '') != '' OR 
	   ISNULL(@Ana09ID, '') != '' OR ISNULL(@Ana10ID, '') != ''
		BEGIN
			SET @sJoin = @sJoin + '' 
		END

	IF ISNULL(@Ana01ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana01ID like N''%' + @Ana01ID + '%'' OR A11.AnaName like N''%' + @Ana01ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A20.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01'''
		END

	IF ISNULL(@Ana02ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana02ID like ''%' + @Ana02ID + '%'' OR A12.AnaName like N''%' + @Ana02ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A20.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02'''
		END

	IF ISNULL(@Ana03ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A20.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03'''
		END

	IF ISNULL(@Ana04ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana04ID like ''%' + @Ana04ID + '%'' OR A14.AnaName like N''%' + @Ana04ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A20.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04'''
		END

	IF ISNULL(@Ana05ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana05ID like ''%' + @Ana05ID + '%'' OR A15.AnaName like N''%' + @Ana05ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A20.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05'''
		END

	IF ISNULL(@Ana06ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana06ID like ''%' + @Ana06ID + '%'' OR A16.AnaName like N''%' + @Ana06ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A20.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06'''
		END

	IF ISNULL(@Ana07ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana07ID like ''%' + @Ana07ID + '%'' OR A17.AnaName like N''%' + @Ana07ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A20.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07'''
		END

	IF ISNULL(@Ana08ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana08ID like ''%' + @Ana08ID + '%'' OR A18.AnaName like N''%' + @Ana08ID + '%'' OR A20.ContractName like N''%' + @Ana08ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A20.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08'''
		END

	IF ISNULL(@Ana09ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana09ID like ''%' + @Ana09ID + '%'' OR A19.AnaName like N''%' + @Ana09ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A20.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09'''
		END

	IF ISNULL(@Ana10ID,'') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (A20.Ana10ID LIKE ''%' + @Ana10ID + '%'' OR A21.AnaName like N''%' + @Ana10ID + '%'')'
			SET @sJoin = @sJoin + '
			LEFT JOIN AT1011 A21 WITH (NOLOCK) ON A20.Ana10ID = A21.AnaID AND A21.AnaTypeID = ''A10'''
		END
	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END

IF ISNULL(@ConditionOpportunityID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (ISNULL(A20.CreateUserID, '''') IN (''' + @ConditionOpportunityID + ''' ) OR ISNULL(A20.AssignedToUserID, '''') IN (''' + @ConditionOpportunityID + ''' ))'
		SET @sWhereDashboard = @sWhereDashboard + + ' AND (ISNULL(A20.CreateUserID, '''') IN (''' + @ConditionOpportunityID + ''' ) OR ISNULL(A20.AssignedToUserID, '''') IN (''' + @ConditionOpportunityID + ''' ))'
	END

SET @sWhere = @sWhere + ' AND ISNULL(A20.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(A20.DeleteFlg,0) = 0 '

IF @Type = 6
	SET @sWhere1 = ' WHERE ' +@sWhereDashboard +' '
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sJoin = 
		CASE
			WHEN @RelTable = 'CRMT20501' THEN 'LEFT JOIN AT1031 AT31 WITH (NOLOCK) ON A20.ContractID = AT31.ContractID AND A20.DivisionID = AT31.DivisionID
											   LEFT JOIN ' +@RelTable+ ' B1 WITH (NOLOCK) ON B1.OpportunityID = AT31.Ana02ID AND B1.DivisionID = AT31.DivisionID'
			WHEN @RelTable IN ('OT2001', 'OT3101') THEN 'INNER JOIN ' +@RelTable+ ' B1 WITH (NOLOCK) ON B1.ContractNo = A20.ContractNo'
			ELSE @sJoin
		END

		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'CRMT20501' THEN 'WHERE A20.DivisionID = ''' + @DivisionID + ''' AND B1.APK = ''' + @RelAPK + ''' AND A20.ContractType = 0 AND ISNULL(A20.DeleteFlg, 0) = 0'
			WHEN @RelTable IN ('OT2001', 'OT3101') THEN 'WHERE A20.DivisionID = ''' + @DivisionID + ''' AND B1.APK = ''' + @RelAPK + ''' AND ISNULL(A20.DeleteFlg, 0) = 0'
			ELSE 'WHERE ' + @sWhere + ''
		END
	END
	ELSE
		SET @sWhere1 = ' WHERE ' +@sWhere +' '
END

--Lấy Distinct
SET @sSQL01 = N'	
		SELECT DISTINCT A20.APK, A20.DivisionID, A20.ContractID, A20.ContractNo, A20.ContractName,
			A20.SignDate, A20.BeginDate, A20.EndDate, A20.ContractType,
			CASE WHEN A20.ContractType = 0 THEN N''Mua'' ELSE N''Bán'' END AS ContractTypeName,
			A20.ExchangeRate, A20.Amount, A20.ConvertedAmount, A20.VATOriginalAmount, A20.VATConvertedAmount,
			A20.CurrencyID, AT1004.CurrencyName, A20.Ana01ID, A20.Ana02ID, A20.Ana03ID, A20.Ana04ID, A20.Ana05ID,
			A20.Ana06ID, A20.Ana07ID, A20.Ana08ID, A20.Ana09ID, A20.Ana10ID, A20.Description, A20.ContractPackageID,
			A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, 
			A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, 
			A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			AT1202.ObjectName AS ObjectName
		INTO #CIP1360
		FROM AT1020 A20 WITH (NOLOCK)
			LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID= A20.CurrencyID  
			LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A20.Ana01ID = A01.AnaID AND A01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A20.Ana02ID = A02.AnaID AND A02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A20.Ana03ID = A03.AnaID AND A03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A20.Ana04ID = A04.AnaID AND A04.AnaTypeID = ''A04''
			LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A20.Ana05ID = A05.AnaID AND A05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A20.Ana06ID = A06.AnaID AND A06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A20.Ana07ID = A07.AnaID AND A07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A20.Ana08ID = A08.AnaID AND A08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A20.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A20.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID= A20.ObjectID
				
			'+ @sJoin+'
		' +@sWhere1 +'
			
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,	
			APK, DivisionID, ContractID, ContractNo, ContractName, SignDate, BeginDate, EndDate,
			ContractType, ContractTypeName, ExchangeRate, Amount, ConvertedAmount, VATOriginalAmount,
			VATConvertedAmount, CurrencyID, CurrencyName, Description,ContractPackageID,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
			Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,ObjectName
		FROM #CIP1360 	'+@SearchWhere +'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
'



EXEC (@sSQL01)
PRINT @sSQL01



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
