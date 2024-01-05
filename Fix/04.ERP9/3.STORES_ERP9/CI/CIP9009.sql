IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP9009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP9009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn đối tượng (theo loại)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo Date 09/05/2022
----Modified by Hoài Bảo Date 13/06/2022 - Thay đổi cách search đối tượng theo danh sách ObjectTypeID
-- <Example>
/*
	EXEC CIP9009 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@ObjectTypeID=N'',@PageNumber=N'1',@PageSize=N'25'
*/

 CREATE PROCEDURE CIP9009 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ObjectTypeID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF ISNULL(@ObjectTypeID, '') != '' AND @ObjectTypeID != 'null'
		SET @sWhere = @sWhere + ' AND ISNULL(AT1202.ObjectTypeID, '''') IN (SELECT Value FROM StringSplit('''+@ObjectTypeID+''', '','')) '
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Address LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Tel LIKE N''%'+@TxtSearch + '%'' 
								OR AT1202.Email LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
		Select ROW_NUMBER() OVER (ORDER BY AT1202.ObjectID, AT1202.ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow, AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName
			, (Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled, AT1202.IsInvoice, AT1202.Note as Description, AT1202.Note, AT1202.Note1
			, AT1202.ReAddress, AT1202.Contactor, AT1202.Phonenumber, 0 as BeforeToQuantity, 0 as AfterToQuantity
		FROM AT1202 With (NOLOCK)
		WHERE  AT1202.Disabled =0 AND AT1202.DivisionID in ('''+@DivisionID+''', ''@@@'') ' + @sWhere + '
		ORDER BY AT1202.ObjectID, AT1202.ObjectName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	
PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
