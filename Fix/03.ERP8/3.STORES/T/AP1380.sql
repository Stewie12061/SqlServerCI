IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'AP1380') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE AP1380
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form AF0380 Kế thừa phiếu đề nghị chi POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 12/12/2017
----Edited by: Hoàng Vũ, 05/03/2018: Thay đổi giá trị truyền Isdate theo đúng bên Code từ (0: theo ngày, 1: Theo kỳ) thành (1: theo ngày, 0: Theo kỳ)
----
-- <Example>
/* 
EXEC AP1380 'HCM','','', 0, '2015-01-01', '2017-12-30', '09', '2017', '12', '2017' ,'NV01'
*/
----
CREATE PROCEDURE AP1380 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ObjectID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@IsDate TINYINT,--1: theo ngày, 0: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@FromMonth Int,
		@FromYear  Int,
		@ToMonth Int,
		@ToYear Int,
		@UserID  VARCHAR(50)
		
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
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),M.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 0 
	SET @sWhere = @sWhere + 'M.TranYear * 100 + M.TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR(@ToYear * 100 + @ToMonth)+' '
	--Check Para DivisionIDList null then get DivisionID 
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and M.DivisionID = '''+ @DivisionID+''''
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID, '''') = '''+@ObjectID+''''
	


SET @sSQL = '
	SELECT M.APK, M.DivisionID, M.ShopID, A.ShopName, M.VoucherTypeID as VoucherTypeName, M.VoucherNo,  M.VoucherDate
	, M.MemberID, C.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
	, Sum(D.Amount) as TotalAmount, M.CreateUserID SaleManID, B.FullName SaleManName
	, A.Address, A.Tel, M.Description
	Into #TemPOST2020
	FROM POST2020 M With (NOLOCK) 
	INNER JOIN POST2021 D With (NOLOCK) ON D.APKMaster = M.APK	
	LEFT JOIN POST0010 A With (NOLOCK) ON A.DivisionID = M.DivisionID and A.ShopID = M.ShopID
	LEFT JOIN AT1103 B With (NOLOCK) ON B.EmployeeID = M.CreateUserID
	LEFT JOIN POST0011 C With (NOLOCK) ON C.MemberID = M.MemberID
	WHERE '+@sWhere+'and IsConfirm = 1 and M.DeleteFlg =0 
	and D.APKMaster not in (Select isnull(InheritPayPOS,'''') FROM AT9000 WITH (NOLOCK) WHERE IsInheritPayPOS = 1)
	Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, A.ShopName
	, M.MemberID, C.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
	, M.CreateUserID, B.FullName, A.Address, A.Tel, M.Description
	Having Sum(D.Amount) > 0
	Declare @Count int
	Select @Count = Count(VoucherNo) From  #TemPOST2020

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.ShopID, M.VoucherTypeName, M.VoucherNo
	, M.VoucherDate, M.MemberID, M.MemberName , M.ShopName, M.SaleManID, M.SaleManName
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.TotalAmount, M.Address, M.Tel, M.Description
	From  #TemPOST2020 M
	ORDER BY '+@OrderBy+''

EXEC (@sSQL)
Print @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
