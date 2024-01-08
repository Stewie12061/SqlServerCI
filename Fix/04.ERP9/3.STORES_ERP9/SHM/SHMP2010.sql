IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid sổ cổ đông ( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Xuân Minh , Date: 27/09/2018
----Edited by: Hoàng Vũ , Date: 23/10/2018
-- <Example>
/*
--Lọc nâng cao
EXEC SHMP2010 @DivisionID='BS' , @DivisionList='', @ObjectID ='',@ObjectName ='',
@Address ='',@Tel='',@VATno='',@Email ='',@IdentificationNumber ='',@ShareHolderCategoryID ='', @UserID ='',@PageNumber ='1',
@PageSize ='25',@SearchWhere =N' where IsNull(ObjectID,'''') = N''asdas'''
--Lọc thường
EXEC SHMP2010 @DivisionID='BS' , @DivisionList='',@ObjectID ='',@ObjectName ='',
@Address ='2',@Tel='2',@VATno='2',@Email ='2',@IdentificationNumber ='2',@ShareHolderCategoryID ='2', @UserID ='2',@PageNumber ='1',
@PageSize ='25',@SearchWhere =''

*/
CREATE PROCEDURE SHMP2010 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@ObjectID VARCHAR(50),
		@ObjectName NVARCHAR(250),
		@Address NVARCHAR (250),
		@Tel NVARCHAR(100),
		@VATno NVARCHAR(50),
		@Email NVARCHAR(100),
		@IdentificationNumber VARCHAR(50),
		@ShareHolderCategoryID VARCHAR(50),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = ' ObjectID'

	If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin
			IF ISNULL(@DivisionList, '') <> ''
				SET @sWhere = @sWhere + N' AND T1.DivisionID IN ('''+@DivisionList+''')'
			ELSE 
				SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''
	
			IF ISNULL(@ObjectID, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.ObjectID LIKE N''%'+@ObjectID+'%'''
			IF ISNULL(@ObjectName, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.ObjectName  LIKE N''%'+@ObjectName +'%'''
			IF ISNULL(@Address, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.Address  LIKE N''%'+@Address +'%'''
			IF ISNULL(@Tel, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.Tel  LIKE N''%'+@Tel +'%'''
			IF ISNULL(@VATno, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.VATno  LIKE N''%'+@VATno +'%'''
			IF ISNULL(@Email, '') <> '' 
				SET @sWhere = @sWhere + N' AND T4.Email  LIKE N''%'+@Email +'%'''
			IF ISNULL(@IdentificationNumber, '') <> '' 
				SET @sWhere = @sWhere + N' AND T1.IdentificationNumber  LIKE N''%'+@IdentificationNumber +'%'''
			IF ISNULL(@ShareHolderCategoryID, '') <> '' 
				SET @sWhere = @sWhere + N' AND T2.ShareHolderCategoryID  LIKE N''%'+@ShareHolderCategoryID +'%'''
			--nếu giá trị NULL thì set về rổng 
			SET @SearchWhere = Isnull(@SearchWhere, '')
	End

	SET @sSQL = N'
	SELECT T1.APK,T1.DivisionID, T4.ObjectID,T4.ObjectName,T4.Address,T4.Tel,T4.VATno,T4.Email,T1.IdentificationNumber
			, T2.ShareHolderCategoryID, SUM(ISNULL(T3.IncrementQuantity,0) - ISNULL(T3.DecrementQuantity,0)) as TotalShare,T1.CreateUserID,T1.CreateDate
			, T1.LastModifyUserID,T1.LastModifyDate
	INTO #SHMP2010
	FROM SHMT2010 T1 WITH (NOLOCK)
				LEFT JOIN SHMT1000 T2 WITH (NOLOCK) ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID
				LEFT JOIN SHMT2011 T3 WITH (NOLOCK) ON T1.APK=T3.APKMaster and T1.DeleteFlg = T3.DeleteFlg
				LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID
				LEFT JOIN SHMT1010 T5 WITH (NOLOCK) ON T3.ShareTypeID=T5.ShareTypeID
	WHERE '+@sWhere+' AND T1.DeleteFlg = 0
	GROUP BY T1.APK,T1.DivisionID,T4.ObjectID,T4.ObjectName,T4.Address,T4.Tel,T4.VATno,T4.Email,T3.APKMaster,T1.IdentificationNumber
			 , T2.ShareHolderCategoryID, T1.TotalShare,T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #SHMP2010
	'+@SearchWhere +'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
	EXEC (@sSQL)
	PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
