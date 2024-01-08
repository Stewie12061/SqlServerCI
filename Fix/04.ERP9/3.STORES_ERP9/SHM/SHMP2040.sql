IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid danh sách chia cổ tức ( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Xuân Minh , Date: 28/10/2018
----Edited by: Hoàng vũ , Date: 18/10/2018
-- <Example>
/*
--Lọc nâng cao
EXEC SHMP2040 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a',@LockDate='2018-01-01', 
@Description = 'a', @ObjectID ='a',@ObjectName ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=N' where IsNull(VoucherNo,'''') = N''asdas'''

--Lọc thường
EXEC SHMP2040 @DivisionID='BS' , @DivisionList='', @FromDate='2018-09-01',@ToDate ='2018-10-31',@IsDate =1,@PeriodIDList ='10/2018',@VoucherNo ='a',@LockDate='2018-01-01', 
@Description = 'a', @ObjectID ='a',@ObjectName ='a', @UserID ='a',@PageNumber ='1',
@PageSize ='25',@SearchWhere=N''

*/
CREATE PROCEDURE SHMP2040 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsDate TINYINT, -- 1: theo kỳ, 0: theo ngày
		@PeriodIDList NVARCHAR (Max),
		@VoucherNo VARCHAR(50),
		@LockDate DATETIME,
		@Description VARCHAR(250),
		@ObjectID VARCHAR(50),
		@ObjectName NVARCHAR(250),
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
				IF ISNULL(@LockDate, '') != '' 
					SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), T1.LockDate,112) = '+CONVERT(VARCHAR(10),@LockDate,112)+''
				IF ISNULL(@Description, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.Description LIKE N''%'+@Description+'%'''
				IF ISNULL(@ObjectID, '') != '' 
					SET @sWhere = @sWhere + N' AND T2.ObjectID LIKE N''%'+@ObjectID+'%'''
				IF ISNULL(@ObjectName, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.ObjectName  LIKE N''%'+@ObjectName +'%'''
				
				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End
		SET @sSQL = N'
				SELECT Distinct T1.APK, T1.DivisionID, T1.VoucherTypeID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth
					, T1.TranYear, T1.LockDate, T1.Description, T1.TotalHoldQuantity, T1.TotalAmount, T1.FaceValue
					, T1.DividendPerShare, T1.DeleteFlg, T1.CreateUserID, T1.LastModifyUserID, T1.CreateDate, T1.LastModifyDate
				INTO #SHMP2040
				FROM SHMT2040 T1 WITH (NOLOCK)
						LEFT JOIN SHMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg =  T2.DeleteFlg
						LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.ObjectID = T2.ObjectID
				WHERE '+@sWhere+' AND T1.DeleteFlg = 0

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, APK, DivisionID, VoucherTypeID, VoucherNo, VoucherDate, TranMonth
					, TranYear, LockDate, Description, TotalHoldQuantity, TotalAmount, FaceValue
					, DividendPerShare, DeleteFlg, CreateUserID, LastModifyUserID, CreateDate, LastModifyDate
				FROM #SHMP2040
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

