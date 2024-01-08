IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12507]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP12507]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 -- <Summary>
 ---- 
 ---- 
 -- <Param>
---- Load View Master Màn hình bảng giá(màn hình cập nhật).
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Thanh Lượng on 07/27/2023
 /*-- <Example>
 EXEC CIP12507 @DivisionID = 'Gree-SI', @UserID = '', @TranMonth=12, @TranYear=2023,@PageNumber = 1, @PageSize = 25, @WarehouseID = '', @InventoryTypeID = 'KHO',@IsSerialized = 0, @FormID = 'SOF1259', 
 @TxtSearch = 'a', @ConditionIV = N'('''')', @IsUsedConditionIV= N' (0=0) '
 ----*/
 
CREATE PROCEDURE CIP12507
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @APKMaster_9000 VARCHAR(50) = '',
	 @Type VARCHAR(50) = '',		
	 @UserID VARCHAR(50)	 	
) 
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@PageNumber int = 1,
			@sSQLSL NVARCHAR (MAX) = '',
			@sSQLJon NVARCHAR(MAX) = '',
			@sWhere  NVARCHAR(max) = '',
			@Level INT,
			@i INT = 1,
			@s VARCHAR(2)

			IF ISNULL(@Type, '') = 'BGBSI' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),A.APKMaster_9000)= '''+@APKMaster_9000+''''
SELECT  @Level = MAX(Levels) FROM OT1301 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster_9000 AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),A.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),A.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM OT1301 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

    WHILE @i <= @Level
    BEGIN
        IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
        ELSE SET @s = CONVERT(VARCHAR, @i)
        SET @sSQLSL=@sSQLSL+' ,ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, O99.[Description] AS ApprovePerson'+@s+'Status , ApprovePerson'+@s+'Note' 
        SET @sSQLJon =@sSQLJon+ '
                      LEFT JOIN (
                                SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID,
                                       A1.FullName As ApprovePerson'+@s+'Name,OOT1.Note AS ApprovePerson'+@s+'Note
                                FROM OOT9001 OOT1 WITH (NOLOCK)
                                INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID in (''@@@'',OOT1.DivisionID) AND A1.EmployeeID=OOT1.ApprovePersonID
                                WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID in (''@@@'', OOT90.DivisionID)  AND APP'+@s+'.APKMaster=OOT90.APK'
        SET @i = @i + 1	
    END
		SET @sSQL =N'
		   SELECT A.APK, A.DivisionID, A.ID
	       , A.[Description] AS PriceName, A.[Disabled], AT0099_02.[Description] AS DisableName,  A.IsConvertedPrice
	       , AT0099_01.[Description] AS IsConvertedPriceName, A.FromDate, A.ToDate, A.InheritID
	       , CASE WHEN IIF(ISNULL(AT1301_01.InventoryTypeName, '''') != '''', AT1301_01.InventoryTypeName, ''%'') != ''%'' THEN AT1301_01.InventoryTypeName
		      ELSE (SELECT [Name] FROM A00001 WHERE ID = ''A00.All'' AND LanguageID = ''vi-VN'') END AS InventoryTypeName
	       , A.CurrencyID+''-''+AT1004_01.CurrencyName AS CurrencyID
	       , CASE WHEN IIF(ISNULL(AT1015_01.AnaName, '''') != '''', AT1015_01.AnaName, ''%'') != ''%'' THEN AT1015_01.AnaName
		      ELSE (SELECT [Name] FROM A00001 WHERE ID = ''A00.All'' AND LanguageID = ''vi-VN'') END AS OID
	       , A.IsTaxIncluded, A.IsSetBonus, A.IsTaxIncluded AS IsTaxIncludedTemp, A.TypeID AS IsPurchasePrice
	       , A03_01.FullName AS CreateUserID, A.CreateDate, A03_02.FullName AS LastModifyUserID, A.LastModifyDate, 
			A.StatusSS, A.Levels, A.ApproveLevel, A.ApprovingLevel, A.APKMaster_9000, ApprovalNotes
		'+@sSQLSL+'
        FROM OT1301 A WITH (NOLOCK)
        LEFT JOIN AT1103 A03_01 WITH (NOLOCK) ON A.CreateUserID = A03_01.EmployeeID
        LEFT JOIN AT1103 A03_02 WITH (NOLOCK) ON A.LastModifyUserID = A03_02.EmployeeID
        LEFT JOIN AT1301 AT1301_01 WITH (NOLOCK) ON A.InventoryTypeID = AT1301_01.InventoryTypeID
        LEFT JOIN AT1004 AT1004_01 WITH (NOLOCK) ON AT1004_01.CurrencyID = A.CurrencyID 
        LEFT JOIN AT1015 AT1015_01 WITH (NOLOCK) ON AT1015_01.AnaID = A.OID
        LEFT JOIN AT0099 AT0099_01 WITH (NOLOCK) ON A.IsConvertedPrice = AT0099_01.ID AND AT0099_01.CodeMaster = ''AT00000004''
        LEFT JOIN AT0099 AT0099_02 WITH (NOLOCK) ON A.[Disabled] = AT0099_02.ID AND AT0099_02.CodeMaster = ''AT00000004''
		LEFT JOIN OOT0099 O99 WITH(NOLOCK) ON O99.CodeMaster = ''Status'' AND A.StatusSS = O99.ID
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON A.APKMaster_9000 = OOT90.APK         
		 '+@sSQLJon+'
		WHERE A.DivisionID = '''+@DivisionID+''' '+@sWhere+''

		EXEC (@sSQL)
		PRINT (@sSQL +@sSQLJon )


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
