IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách phiếu đề nghị chi
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng
----Create date: 08/12/2017
----Modify by Hoàng Vũ, on 31/01/2018: Sắp xếp giảm dần
----Modify by Cao Thị Phượng, on 28/02/2018: Bổ sung kết người duyệt từ bảng POST0026 -> AT1103
/*
	EXEC POSP2020 'HCM','','CH-HCM001','',0,'2017-12-08', '2017-12-30', '','','','','','','HOANG',1,25
*/
 CREATE PROCEDURE POSP2020 (
	 @DivisionID		NVARCHAR(Max),			--Biến môi trường
	 @DivisionIDList NVARCHAR(Max),
	 @ShopID		NVARCHAR(Max),				--Biến môi trường
     @ShopIDList	NVARCHAR(Max),
	 @IsDate		TINYINT,					--0:Datetime; 1:Period
     @FromDate		DATETIME,
     @ToDate		DATETIME,
	 @Period		NVARCHAR(Max),
	 @VoucherNo		 NVARCHAR(50),
	 @MemberName	NVARCHAR(250),
	 @CreateUserID	 NVARCHAR(250),
	 @SuggestType	NVARCHAR(250),
	 @IsConfirm		NVARCHAR(250),
	 @UserID		NVARCHAR(50),				--Biến môi trường
	 @PageNumber	 INT,
     @PageSize		 INT						--Biến môi trường
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

	SET @sWhere = ' '
	SET @OrderBy = ' M.VoucherDate desc, M.VoucherNo'
	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	Else 
		SET @sWhere = @sWhere + ' (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@Period+''')'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList,'') = ''
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
	Else 
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'

	--Check Para @ShopIDList null then get ShopID 
	IF Isnull(@ShopIDList,'') = ''
		SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
	Else 
		SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'

	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@MemberName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.MemberID,'''') LIKE N''%'+@MemberName+'%'' or ISNULL(P11.MemberName,'''') LIKE N''%'+@MemberName+'%'''
		
	IF Isnull(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID,'''') LIKE N''%'+@CreateUserID+'%'' or ISNULL(P12.EmployeeName,'''') LIKE N''%'+@CreateUserID+'%'''

	IF Isnull(@SuggestType, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SuggestType,'''') LIKE N''%'+@SuggestType+'%'' '
	
	IF Isnull(@IsConfirm, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsConfirm,'''') LIKE N''%'+@IsConfirm+'%'''

   	SET @sSQL ='		Select	M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
								, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID
								, M.MemberID, P11.MemberName
								, P13.Description as SuggestType
								, P14.Description as IsConfirm
								, M.Description, M.ConfirmUserID
								, P15.FullName ConfirmUserName, M.ConfirmDate, M.DeleteFlg
								, M.CreateUserID, P12.FullName CreateUserName, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
								, Sum(D.Amount) as Amount
							into #TempPOST2020
							FROM POST2020 M WITH (NOLOCK) 
							Inner join POST2021 D WITH (NOLOCK) on D.APKMaster = M.APK
							Left join POST0011 P11 WITH (NOLOCK) on M.MemberID = P11.MemberID
							Left join AT1103 P12 WITH (NOLOCK) on M.CreateUserID = P12.EmployeeID
							Left join POST0099 P13 WITH (NOLOCK) on M.SuggestType = P13.ID and P13.CodeMaster =''POS000012''
							Left join POST0099 P14 WITH (NOLOCK) on M.IsConfirm = P14.ID and P14.CodeMaster= ''POS000013''
							Left join AT1103 P15 WITH (NOLOCK) on M.ConfirmUserID = P15.EmployeeID
							WHERE  ' +@sWhere + ' AND M.DeleteFlg = 0 
							Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
								, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID
								, M.MemberID, P11.MemberName
								, P13.Description 
								, P14.Description
								, M.Description,  M.ConfirmUserID
								, P15.FullName , M.ConfirmDate, M.DeleteFlg
								, M.CreateUserID, P12.FullName, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
							DECLARE @count int
							Select @count = Count(APK) From #TempPOST2020 With (NOLOCK)
							
							SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
								,M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
								, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID
								, M.MemberID, M.MemberName
								, M.SuggestType
								, M.IsConfirm, M.Amount
								, M.Description , M.ConfirmUserName
								, M.ConfirmUserID, M.ConfirmDate, M.DeleteFlg
								, M.CreateUserID, M.CreateUserName, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
							FROM #TempPOST2020 M WITH (NOLOCK)
							ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--PRINT @sSQL




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
