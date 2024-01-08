IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn đối tượng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thị Phượng Date 03/08/2017
----Edited by: Hoàng Vũ Date 18/10/2018: Lấy thêm 2 trường Contactor, Phonenumber
----Edited by: Tra Giang Date 22/11/2018: Bổ sung @Mode: truyền loại đối tượng
--- Edited by Hồng Thảo date  30/7/2019: Sửa lại điều kiện bỏ những đối tượng học sinh (Bluesky)
--- Edited by Tấn Thành date  06/24/2020: Thêm điều kiện lọc theo đối tượng là Nhân Viên (NV)
--- Edited by Phương Thảo date  04/01/2023: [2023/01/IS/0008] customize  cho BBA chọn tất cả đối tượng 

/*
	exec CMNP90051 @DivisionID=N'AT',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @Mode = 1
*/

 CREATE PROCEDURE CMNP90051 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @Mode TINYINT = 0	--- , 1: Nhà cung cấp, 2: Khách hàng ,0: Tất cả đối tượng , 3: Lod phụ huynh , 4: Nhân viên
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
	    @CustomerName INT,
		@ObjectType NVARCHAR(MAX),
		@All NVARCHAR(50) = N'Tất cả'
	
	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
	DROP TABLE #CustomerName
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.VATObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Address LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.Tel LIKE N''%'+@TxtSearch + '%'' 
								OR AT1202.Email LIKE N''%'+@TxtSearch+'%'')'
	
	IF @CustomerName = 91
	BEGIN 
		IF @Mode = 0
		BEGIN
		SET @sSQL = '
		Select ROW_NUMBER() OVER (ORDER BY AT1202.ObjectID, AT1202.ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow, AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName
			, (Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled, AT1202.IsInvoice, AT1202.Note as Description, AT1202.Note, AT1202.Note1
			, AT1202.ReAddress, AT1202.Contactor, AT1202.Phonenumber
			, Sum(Isnull(S11.IncrementQuantity, 0)) - Sum(Isnull(S11.DecrementQuantity, 0)) as BeforeToQuantity
			, Sum(Isnull(S11.IncrementQuantity, 0)) - Sum(Isnull(S11.DecrementQuantity, 0)) as AfterToQuantity
		From AT1202 With (NOLOCK) LEFT JOIN SHMT2010 S10 With (NOLOCK) ON AT1202.ObjectID = S10.ObjectID
								  LEFT JOIN SHMT2011 S11 With (NOLOCK) ON S10.APK = S11.APKMaster and S10.DeleteFlg = S11.DeleteFlg and S11.DeleteFlg = 0
		WHERE  AT1202.Disabled =0 
		AND AT1202.DivisionID in ('''+@DivisionID+''', ''@@@'') ' + @sWhere +'
		Group by AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName,(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end)
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled,AT1202.IsInvoice, AT1202.Note, AT1202.Note, AT1202.Note1, AT1202.ReAddress
			, AT1202.Contactor, AT1202.Phonenumber
		ORDER BY AT1202.ObjectID, AT1202.ObjectName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		END 
	    IF @Mode = 3
		BEGIN
		SET @sSQL = '
		Select ROW_NUMBER() OVER (ORDER BY AT1202.ObjectID, AT1202.ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow, AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName
			, (Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled, AT1202.IsInvoice, AT1202.Note as Description, AT1202.Note, AT1202.Note1
			, AT1202.ReAddress, AT1202.Contactor, AT1202.Phonenumber
			, Sum(Isnull(S11.IncrementQuantity, 0)) - Sum(Isnull(S11.DecrementQuantity, 0)) as BeforeToQuantity
			, Sum(Isnull(S11.IncrementQuantity, 0)) - Sum(Isnull(S11.DecrementQuantity, 0)) as AfterToQuantity
		From AT1202 With (NOLOCK) LEFT JOIN SHMT2010 S10 With (NOLOCK) ON AT1202.ObjectID = S10.ObjectID
								  LEFT JOIN SHMT2011 S11 With (NOLOCK) ON S10.APK = S11.APKMaster and S10.DeleteFlg = S11.DeleteFlg and S11.DeleteFlg = 0
		WHERE  AT1202.Disabled =0 
		AND AT1202.DivisionID in ('''+@DivisionID+''', ''@@@'') ' + @sWhere +'
		AND ISNULL(AT1202.FatherObjectID,'''') = '''' AND ISNULL(AT1202.MotherObjectID,'''') = '''' AND ISNULL(AT1202.IsParents,0) = 1 
		Group by AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName,(Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end)
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled,AT1202.IsInvoice, AT1202.Note, AT1202.Note, AT1202.Note1, AT1202.ReAddress
			, AT1202.Contactor, AT1202.Phonenumber, AT1202.IsParents
		ORDER BY AT1202.ObjectID, AT1202.ObjectName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


		END 
	END
	ELSE
	BEGIN
	IF @Mode = 0
		SET @ObjectType = ' '
	ELSE
	IF @Mode = 1
		SET @ObjectType = 'AND AT1202.IsSupplier = 1'	
	ELSE
	IF @Mode = 4 
		SET @ObjectType = ' AND AT1202.ObjectTypeID = ''NV'''
	ELSE
		SET @ObjectType = ' AND AT1202.IsCustomer = 1'

	IF @CustomerName = 57 OR @CustomerName = 157 -- Angel, BBA
	BEGIN
		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY AT1202.ObjectID, AT1202.ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
		Select NULL AS APK, ''@@@'' AS DivisionID, ''%'' AS ObjectID, N'''+@All+''' AS ObjectName
			, '''' as VATAccountID, Null as VATAccountName
			, '''' AS Address, '''' AS VATNo, '''' AS Tel, '''' AS Email, 0 AS IsCommon, 0 AS Disabled, '''' AS IsInvoice, '''' AS Description, '''' AS Note, '''' AS Note1
			, '''' AS ReAddress, '''' AS Contactor, '''' AS Phonenumber, 0 as BeforeToQuantity, 0 as AfterToQuantity
		Union All
		Select AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName
			, (Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled, AT1202.IsInvoice, AT1202.Note as Description, AT1202.Note, AT1202.Note1
			, AT1202.ReAddress, AT1202.Contactor, AT1202.Phonenumber, 0 as BeforeToQuantity, 0 as AfterToQuantity
		From AT1202 With (NOLOCK)
		WHERE  AT1202.Disabled =0 AND AT1202.DivisionID in ('''+@DivisionID+''', ''@@@'') ' + @sWhere + @ObjectType+ ' ) AT1202
		ORDER BY AT1202.ObjectID, AT1202.ObjectName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END
	ELSE
	BEGIN
		SET @sSQL = '
		Select ROW_NUMBER() OVER (ORDER BY AT1202.ObjectID, AT1202.ObjectName) AS RowNum, '+@TotalRow+' AS TotalRow, AT1202.APK, AT1202.DivisionID, AT1202.ObjectID, AT1202.ObjectName
			, (Case when Isnull(AT1202.VATObjectID, '''') = '''' then AT1202.ObjectID else AT1202.VATObjectID end) as VATAccountID, Null as VATAccountName
			, AT1202.Address, AT1202.VATNo, AT1202.Tel, AT1202.Email, AT1202.IsCommon, AT1202.Disabled, AT1202.IsInvoice, AT1202.Note as Description, AT1202.Note, AT1202.Note1
			, AT1202.ReAddress, AT1202.Contactor, AT1202.Phonenumber, 0 as BeforeToQuantity, 0 as AfterToQuantity
		From AT1202 With (NOLOCK)
		WHERE  AT1202.Disabled =0 AND AT1202.DivisionID in ('''+@DivisionID+''', ''@@@'') ' + @sWhere + @ObjectType+ '
		ORDER BY AT1202.ObjectID, AT1202.ObjectName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END

	END
	
PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
