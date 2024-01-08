IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Đổ nguồn báo cáo so sánh giá nhà cung cấp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 18/03/2019 by Như Hàn
----Modify on ... by ...
----Modify on 11/11/2022 by Anh Đô: Chỉnh sửa điều kiện lọc ObjectID từ chọn một sang chọn nhiều
----Modify on 14/02/2023 by Anh Đô: Chuyển Params @ObjectID, @InventoryID sang kiểu NVARCHAR(MAX) để fix lỗi tràn chuỗi
-- <Example>
/*  
 EXEC POP3040 @DivisionID, @DivisionIDList, @IsDate, @FromDate, @ToDate, @PeriodList, @FromObjectID, @ToObjectID, @FromInventoryID, @ToInventoryID
*/
----
CREATE PROCEDURE POP3040 ( 
        @DivisionID VARCHAR(50),
		@DivisionList NVARCHAR(max) = '',  --Chọn
		@IsDate INT, ---- 1: là ngày, 0: là kỳ
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@ObjectID NVARCHAR(MAX),
		@InventoryID NVARCHAR(MAX)
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin VARCHAR(MAX)
		

SET @sWhere = ''
SET @sJoin = ''
SET @sSQL = ''
--SET @PeriodList = REPLACE(@PeriodList,',',''',''')

IF ISNULL(@DivisionList, '') <> '' 
	SET @sWhere = @sWhere + ' where T21.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' where T21.DivisionID = '''+@DivisionID+''''

IF @IsDate = 0
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN T21.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T21.TranMonth)))+''/''+ltrim(Rtrim(str(T21.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhere = @sWhere + ' AND (Convert(varchar(20),T21.VoucherDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END

IF ISNULL(@ObjectID,'') <> ''
	SET @sWhere = @sWhere + 'AND T21.ObjectID IN (SELECT Value FROM [dbo].StringSplit('''+@ObjectID+''', '',''))'

IF ISNULL(@InventoryID,'') <> '' 
	SET @sWhere = @sWhere + 'AND T22.InventoryID IN ('''+@InventoryID+''')'

SET @sSQL = @sSQL+ '
SELECT	T22.APK, T22.APKMaster, T22.DivisionID, T22.OrderID, T22.InventoryID,T02.InventoryName,T22.UnitPrice, T22.RequestPrice, T22.Notes,
		T22.TechnicalSpecifications, T22.InheritTableID, T22.InheritAPK, T22.InheritAPKDetail, T22.DeleteFlag,
		T22.IsSelectPrice,''DT''+T21.ObjectID as ObjectID , T12.ObjectName
FROM POT2022 T22 WITH (NOLOCK)
INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK
LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectID = T12.ObjectID
LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T02.InventoryID = T22.InventoryID
'+@sWhere+''
+'Order by InventoryID'

print @sSQL
print @sSQL1
EXEC(@sSQL + @sSQL1)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
