IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2212]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2212]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

























-- <Summary>
--- Load màn hình chọn phiếu thông kê kết quả sản xuất (Master)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên
-- <Example> exec sp_executesql N'MP2212 @DivisionID=N''HCM'',@TxtSearch=N''77'',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'

 CREATE PROCEDURE MP2212 (
     @DivisionID NVARCHAR(2000),
     @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
     @FromDate VARCHAR(50),
     @ToDate VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @ObjectID NVARCHAR(250) = '',
     @VoucherNo NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
     @FromScreen VARCHAR(50) = ''
)
AS
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText varchar(50),
		@ToDateTex varchar(50)

IF (ISNULL(@FromDate, '') <> '')
	SET @FromDateText = CONVERT(DATETIME, @FromDate, 103)
IF (ISNULL(@ToDate, '') <> '')
	SET @ToDateTex = CONVERT(DATETIME, @ToDate, 103)

SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

-- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'AND M1.TranMonth + M1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateTex + ''')'
        ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate >= ''' + @FromDateText + ''')'
        ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate <= ''' + @ToDateTex + ''')'
    END

IF ISNULL(@ObjectID, '') != ''
    SET @sWhere = @sWhere + ' AND ISNULL(M1.EmployeeID, '''') = ''' + @ObjectID + ''''

IF ISNULL(@VoucherNo, '') != ''
    SET @sWhere = @sWhere + ' AND ISNULL(M1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

	  
SET @sSQL = N'SELECT M1.APK, M1.VoucherNo, M1.VoucherDate, A1.FullName AS EmployeeName, M1.Description, '+@TotalRow+' AS TotalRow
              FROM MT2210 M1 WITH (NOLOCK)
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON M1.EmployeeID = A1.EmployeeID
			  WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.DeleteFlg = 0 ' + @sWhere
print  (@sSQL)
EXEC (@sSQL)






















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
