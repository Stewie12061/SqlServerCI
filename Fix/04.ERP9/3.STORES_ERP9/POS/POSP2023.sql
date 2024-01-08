IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form POSF2013 Kế thừa phiếu đặt cọc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 08/12/2017
-- <Example>
/* 
EXEC POSP2023 'MS','CH001','','', 1, '2015-01-01', '2017-12-30', '04/2017'',''08/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE POSP2023 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ShopID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
		
) 
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere=''
SET @OrderBy = 'M.VoucherNo'
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),M.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  (CASE WHEN M.TranMonth <10 THEN ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
				ELSE rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and M.DivisionID = '''+ @DivisionID+''''
	IF  Isnull(@ShopID,'') != ''
		SET @sWhere = @sWhere + 'and M.ShopID = '''+ @ShopID+''''
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(D.MemberID, '''') LIKE N''%'+@MemberID+'%''  or ISNULL(E.MemberName, '''') LIKE N''%'+@MemberID+'%'')'
	

SET @sSQL = '
	SELECT M.APK, M.DivisionID
	, M.ShopID, M.VoucherTypeID, M.VoucherNo
	, convert(varchar(20), M.VoucherDate, 103) as VoucherDate
	, D.MemberID, E.MemberName, E.Tel, E.Address
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
	, M.TranMonth, M.TranYear, Sum(D.Amount) as SumAmount
	Into #TemPOST00801
	FROM POST00801 M With (NOLOCK) 
	INNER JOIN POST00802 D With (NOLOCK) ON D.APKMaster = M.APK
	LEFT JOIN POST0011 E With (NOLOCK) On D.MemberID = E.MemberID
	WHERE '+@sWhere+' and M.DeleteFlg =0 and (isnull(M.IsDeposit,0) = 1 or isnull(M.IsPayInvoice,0) = 1)
	and  D.APKMaster not in (Select A.APKMInherited From POST2021 A WITH (NOLOCK) INNER JOIN POST2020 B WITH (NOLOCK) ON A.APKMaster = B.APK Where B.SuggestType = 0 and isnull(B.DeleteFlg,0) = 0)
	GROUP BY M.APK, M.DivisionID
	, M.ShopID, M.VoucherTypeID, M.VoucherNo
	, M.VoucherDate
	, D.MemberID, E.MemberName, E.Tel, E.Address
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
	, M.TranMonth, M.TranYear
	Declare @Count int
	Select @Count = Count(VoucherNo) From  #TemPOST00801

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo
	, M.VoucherDate, M.MemberID, M.MemberName, M.Tel, M.Address
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.SumAmount
	From  #TemPOST00801 M
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
