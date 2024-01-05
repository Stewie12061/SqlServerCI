IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid danh sách đăng ký mua cổ phần( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Xuân Minh , Date: 01/10/2018
----Edited by: Hoàng vũ , Date: 18/10/2018
-- <Example>
/*
--Lọc nâng cao
EXEC SHMP2020 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a',@SHPublishPeriodID='a',@ObjectID ='',@ObjectName ='a',
@Address ='a',@Tel='a',@VATno='a',@Email ='a',@Contactor='a',@PhoneNumber='a',@IdentificationNumber ='a',@ShareHolderCategoryID ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=N' where IsNull(VoucherNo,'''') = N''asdas'''

--Lọc thường
EXEC SHMP2020 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a',@SHPublishPeriodID='a',@ObjectID ='',@ObjectName ='a',
@Address ='a',@Tel='a',@VATno='a',@Email ='a',@Contactor='a',@PhoneNumber='a',@IdentificationNumber ='a',@ShareHolderCategoryID ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=NULL

*/
CREATE PROCEDURE SHMP2020 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsDate TINYINT, -- 1: theo kỳ, 0: theo ngày
		@PeriodIDList NVARCHAR (Max),
		@VoucherNo VARCHAR(50),
		@SHPublishPeriodID VARCHAR(50),
		@ObjectID VARCHAR(50),
		@ObjectName NVARCHAR(250),
		@Address NVARCHAR (250),
		@Tel NVARCHAR(100),
		@VATno NVARCHAR(50),
		@Email NVARCHAR(100),
		@Contactor NVARCHAR(250),
		@PhoneNumber VARCHAR(100),
		@IdentificationNumber VARCHAR(50),
		@ShareHolderCategoryID VARCHAR(50),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(500) = N'', 
			@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
		SET @OrderBy = ' VoucherDate desc, VoucherNo'
		SET @sWhere = ' 1 = 1 '
		
		If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
				IF ISNULL(@DivisionList, '') != ''
					SET @sWhere = @sWhere + N' AND T1.DivisionID IN ('''+@DivisionList+''')'
				ELSE 
					SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''
				IF @IsDate = 0 
				BEGIN
					IF ISNULL(@FromDate, '') <> '' 
						SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), T1.VoucherDate,112) >= '+CONVERT(VARCHAR(10),@FromDate,112)+'  '
					IF ISNULL(@ToDate, '') <> '' 
						SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), T1.VoucherDate,112) <= '+CONVERT(VARCHAR(10),@ToDate,112)+'  '
				END
				ELSE
					SET @sWhere = @sWhere + ' AND (Case When  T1.TranMonth <10 then ''0''+rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) 
												Else rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) End) IN ('''+@PeriodIDList+''')'
				IF ISNULL(@VoucherNo, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.VoucherNo LIKE N''%'+@VoucherNo+'%'''
				IF ISNULL(@SHPublishPeriodID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.SHPublishPeriodID LIKE N''%'+@SHPublishPeriodID+'%'''
				IF ISNULL(@ObjectID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.ObjectID LIKE N''%'+@ObjectID+'%'''
				IF ISNULL(@ObjectName, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.ObjectName  LIKE N''%'+@ObjectName +'%'''
				IF ISNULL(@Address, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.Address  LIKE N''%'+@Address +'%'''
				IF ISNULL(@Tel, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.Tel  LIKE N''%'+@Tel +'%'''
				IF ISNULL(@VATno, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.VATno  LIKE N''%'+@VATno +'%'''
				IF ISNULL(@Email, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.Email  LIKE N''%'+@Email +'%'''
				IF ISNULL(@Contactor, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.Contactor  LIKE N''%'+@Contactor +'%'''
				IF ISNULL(@PhoneNumber, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.PhoneNumber  LIKE N''%'+@PhoneNumber +'%'''
				IF ISNULL(@IdentificationNumber, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.IdentificationNumber  LIKE N''%'+@IdentificationNumber +'%'''
				IF ISNULL(@ShareHolderCategoryID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.ShareHolderCategoryID  LIKE N''%'+@ShareHolderCategoryID +'%'''
				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End
		SET @sSQL = N'
				SELECT T1.APK, T1.DivisionID, T1.VoucherDate, T1.TranMonth, T1.TranYear, T1.VoucherTypeID, T1.VoucherNo
						, T1.SHPublishPeriodID, T1.ObjectID, T1.ShareHolderCategoryID, T1.IsPersonal, T1.ContactPrefix
						, T1.IdentificationNumber, T1.ContactIssueDate, T1.ContactIssueBy, T1.TotalQuantityBuyable
						, T1.TotalQuantityRegistered, T1.TotalQuantityApproved, T1.TotalAmountBought, T1.DeleteFlg
						, T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
						, T2.ShareHolderCategoryName, T3.SHPublishPeriodName, T3.SHPublishPeriodDate
						, T4.ObjectName, T4.Address, T4.Tel, T4.VATno, T4.Contactor, T4.PhoneNumber
				INTO #SHMP2020
				FROM SHMT2020 T1 WITH (NOLOCK)
						LEFT JOIN SHMT1000 T2 WITH (NOLOCK) ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
						LEFT JOIN SHMT1020 T3 WITH (NOLOCK) ON T1.SHPublishPeriodID=T3.SHPublishPeriodID AND T3.DivisionID IN (T1.DivisionID,''@@@'')
						LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID AND T4.DivisionID IN (T1.DivisionID,''@@@'')
				WHERE '+@sWhere+' AND T1.DeleteFlg = 0

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, APK, DivisionID, VoucherDate, TranMonth, TranYear, VoucherTypeID, VoucherNo
						, SHPublishPeriodID, ObjectID, ShareHolderCategoryID, IsPersonal, ContactPrefix
						, IdentificationNumber, ContactIssueDate, ContactIssueBy, TotalQuantityBuyable
						, TotalQuantityRegistered, TotalQuantityApproved, TotalAmountBought, DeleteFlg
						, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
						, ShareHolderCategoryName, SHPublishPeriodName, SHPublishPeriodDate
						, ObjectName, Address, Tel, VATno, Contactor, PhoneNumber
				FROM #SHMP2020
				'+@SearchWhere +'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		EXEC (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

