IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid danh sách chuyển nhượng cổ phần( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:  Hoàng vũ , Date: 26/10/2018
----Edited by: 
-- <Example>
/*
--Lọc nâng cao
EXEC SHMP2030 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a', @FromObjectID ='',@FromObjectName ='a',
@ShareTypeID = '', @ToObjectID ='',@ToObjectName ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=N' where IsNull(VoucherNo,'''') = N''asdas'''

--Lọc thường
EXEC SHMP2030 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a', @FromObjectID ='',@FromObjectName ='a',
@ShareTypeID = '', @ToObjectID ='',@ToObjectName ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=NULL

*/
CREATE PROCEDURE SHMP2030 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsDate TINYINT, -- 1: theo kỳ, 0: theo ngày
		@PeriodIDList NVARCHAR (Max),
		@VoucherNo VARCHAR(50),
		@FromObjectID VARCHAR(50),
		@FromObjectName NVARCHAR(250),
		@ShareTypeID VARCHAR(50),
		@ToObjectID VARCHAR(50),
		@ToObjectName NVARCHAR(250),
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
					SET @sWhere = @sWhere + N' AND S30.DivisionID IN ('''+@DivisionList+''')'
				ELSE 
					SET @sWhere = @sWhere + N' AND S30.DivisionID = '''+@DivisionID+''''
				IF @IsDate = 0 
				BEGIN
					IF ISNULL(@FromDate, '') <> '' 
						SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), S30.VoucherDate,112) >= '+CONVERT(VARCHAR(10),@FromDate,112)+'  '
					IF ISNULL(@ToDate, '') <> '' 
						SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), S30.VoucherDate,112) <= '+CONVERT(VARCHAR(10),@ToDate,112)+'  '
				END
				ELSE
					SET @sWhere = @sWhere + ' AND (Case When  S30.TranMonth <10 then ''0''+rtrim(ltrim(str(S30.TranMonth)))+''/''+ltrim(Rtrim(str(S30.TranYear))) 
												Else rtrim(ltrim(str(S30.TranMonth)))+''/''+ltrim(Rtrim(str(S30.TranYear))) End) IN ('''+@PeriodIDList+''')'
				IF ISNULL(@VoucherNo, '') != '' 
					SET @sWhere = @sWhere + N' AND S30.VoucherNo LIKE N''%'+@VoucherNo+'%'''
				IF ISNULL(@FromObjectID, '') != '' 
					SET @sWhere = @sWhere + N' AND S30.FromObjectID LIKE N''%'+@FromObjectID+'%'''
				IF ISNULL(@FromObjectName, '') != '' 
					SET @sWhere = @sWhere + N' AND A21.ObjectName  LIKE N''%'+@FromObjectName +'%'''
				IF ISNULL(@ShareTypeID, '') != '' 
					SET @sWhere = @sWhere + N' AND S31.ShareTypeID  LIKE N''%'+@ShareTypeID +'%'''
				IF ISNULL(@ToObjectID, '') != '' 
					SET @sWhere = @sWhere + N' AND S30.ToObjectID LIKE N''%'+@ToObjectID+'%'''
				IF ISNULL(@ToObjectName, '') != '' 
					SET @sWhere = @sWhere + N' AND A22.ObjectName  LIKE N''%'+@ToObjectName +'%'''

				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End
		SET @sSQL = N'
				SELECT Distinct S30.APK, S30.DivisionID, S30.VoucherTypeID, S30.VoucherNo, S30.VoucherDate, S30.TranMonth, S30.TranYear
						, S30.FromObjectID + '' - '' + A21.ObjectName as FromObjectID
						, S30.BeforeFromQuantity, S30.AfterFromQuantity
						, S30.ToObjectID + '' - '' + A22.ObjectName as ToObjectID
						, S30.BeforeToQuantity, S30.AfterToQuantity
						, S30.Description, S30.TransferFree
						, S30.TotalQuantityTransfered, S30.TotalAmountTransfered
						, S30.DeleteFlg
						, S30.CreateUserID, S30.LastModifyUserID, S30.CreateDate, S30.LastModifyDate
				INTO #SHMP2030
				FROM SHMT2030 S30 WITH (NOLOCK) 
						LEFT JOIN SHMT2031 S31 WITH (NOLOCK) ON S30.APK = S31.APKmaster and S30.DeleteFlg = S31.DeleteFlg
						LEFT JOIN AT1202 A21 WITH (NOLOCK) ON S30.FromObjectID = A21.ObjectID
						LEFT JOIN AT1202 A22 WITH (NOLOCK) ON S30.ToObjectID = A22.ObjectID
				WHERE '+@sWhere+' AND S30.DeleteFlg = 0

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, APK, DivisionID, VoucherTypeID, VoucherNo, VoucherDate, TranMonth, TranYear
						, FromObjectID, BeforeFromQuantity, AfterFromQuantity
						, ToObjectID, BeforeToQuantity, AfterToQuantity
						, Description, TransferFree, TotalQuantityTransfered, TotalAmountTransfered
						, DeleteFlg, CreateUserID, LastModifyUserID, CreateDate, LastModifyDate
				FROM #SHMP2030
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
