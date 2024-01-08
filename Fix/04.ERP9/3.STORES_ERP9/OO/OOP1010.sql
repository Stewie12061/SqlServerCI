IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form OOF1010: Danh mục loại bất thường
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date 26/11/2015
----Updated by: Thanh Phương, Date 19/12/2023
----Updated by Thanh Phương, Date 19/12/2023: - Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
/*-- <Example>
	OOP1010 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@UnusualTypeID=NULL,@Description=NULL,@HandleMethodID=NULL,@Note=NULL,@Disabled=1
----*/

CREATE PROCEDURE OOP1010
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch BIT,
	 @UnusualTypeID VARCHAR(50),
	 @Description NVARCHAR(250),
	 @HandleMethodID VARCHAR(50),
	 @Note NVARCHAR(250),
	 @Disabled NVARCHAR(1)
	 ,@FromDate DATETIME = NULL,  
     @ToDate DATETIME = NULL,  
     @IsPeriod INT = 0,  
     @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)='',
	    @FromDateText NVARCHAR(20),  
        @ToDateText NVARCHAR(20)  

SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID
IF @LanguageID='vi-VN'
 SET @sSQLLanguage='OOT1010.Description'
ELSE SET @sSQLLanguage='OOT1010.DescriptionE' 
              
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'OOT1010.UnusualTypeID ASC'
 SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)  
 SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'  
  
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF @IsSearch = 1
BEGIN
	
	IF @UnusualTypeID IS NOT NULL SET @sWhere = @sWhere + '
	AND OOT1010.UnusualTypeID LIKE ''%'+@UnusualTypeID+'%'' '
	IF @Description IS NOT NULL SET @sWhere = @sWhere + '
	AND '+@sSQLLanguage+' LIKE N''%'+@Description+'%'' '
	IF @HandleMethodID IS NOT NULL SET @sWhere = @sWhere + '
	AND OOT1010.HandleMethodID LIKE N''%'+@HandleMethodID+'%'' '
	IF @Note IS NOT NULL SET @sWhere = @sWhere + '
	AND OOT1010.Note LIKE N''%'+@Note+'%'' '
	IF @Disabled <> N'' SET @sWhere = @sWhere + '
	AND OOT1010.Disabled = '+@Disabled
	
	-- Check Para FromDate và ToDate
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (OOT1010.CreateDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OOT1010.CreateDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OOT1010.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + 'AND (SELECT FORMAT(OOT1010.CreateDate, ''MM/yyyy'')) IN (SELECT * FROM StringSplit(REPLACE('''+ @PeriodList + ''', '''', ''''), '',''))' 
		END
	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(OOT1010.DeleteFlg,0) = 0 '
END

SET @sSQL = '
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	OOT1010.APK,OOT1010.DivisionID,OOT1010.UnusualTypeID, '+@sSQLLanguage+' Description, OOT1010.HandleMethodID, OOT1010.Note, OOT0099.[Description] HandleMethodName, 
	OOT1010.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = OOT1010.CreateUserID) CreateUserID, OOT1010.CreateDate, 
	OOT1010.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = OOT1010.LastModifyUserID) LastModifyUserID, 
	OOT1010.LastModifyDate, OOT1010.Disabled    
FROM OOT1010
LEFT JOIN OOT0099 ON OOT0099.ID = OOT1010.HandleMethodID
where OOT1010.DivisionID = ''' +@DivisionID +'''
'
+@sWhere +'

ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
