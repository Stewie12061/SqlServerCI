IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo lịch sử báo giá nhà cung cấp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 31/07/2019 by Kiều Nga
----Modify on 02/02/2021 by Kiều Nga: chuyển control từ kỳ, đến kỳ sang chọn kỳ
----Modify on 11/11/2022 by Anh Đô: Chỉnh sử điều kiện lọc ObjectID từ chọn một sang chọn nhiều

-- <Example>
/*  
 EXEC POP3003 @DivisionID,@IsDate, @FromDate, @ToDate, @PeriodList, @ObjectID, @InventoryID
*/
----
CREATE PROCEDURE POP3003 ( 
        @DivisionID VARCHAR(50),
		@DivisionIDList	NVARCHAR(MAX),
		@IsDate INT, ---- 1: là ngày, 0: là kỳ
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList NVARCHAR(MAX),
		@ObjectID NVARCHAR(MAX),
		@InventoryID NVARCHAR(MAX)
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin VARCHAR(MAX)

SET @sWhere = ''
SET @sJoin = ''
SET @sSQL = ''

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = ' T21.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = ' T21.DivisionID = N'''+@DivisionID+''''	

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
	SET @sWhere = @sWhere + 'AND T22.InventoryID IN ( '''+@InventoryID+''')'

SET @sSQL = @sSQL+ '
SELECT	T22.APK, T22.APKMaster, T22.DivisionID, T22.OrderID, T22.InventoryID,T02.InventoryName,T21.VoucherDate,T22.UnitPrice,T22.RequestPrice, T22.Notes,
		T22.TechnicalSpecifications, T22.InheritTableID, T22.InheritAPK, T22.InheritAPKDetail, T22.DeleteFlag,
		T22.IsSelectPrice, T21.ObjectID, T12.ObjectName
FROM POT2022 T22 WITH (NOLOCK)
INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK
LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectID = T12.ObjectID
LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T02.InventoryID = T22.InventoryID
where 
'+@sWhere+''

print @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
