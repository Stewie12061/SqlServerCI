IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- In báo cáo quyết toán
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Anh Tuấn on 23/02/2022 theo store WMP30011 của ERP8
----Modified by Hoài Bảo on 22/06/2022 - Cập nhật tên store, điều kiện search theo ngày, theo kỳ
-- <Example>
/*
	EXEC WMP300111  @DivisionID, @DivisionIDList,IsDate,@UserID,@FromDate,@ToDate,@PeriodList,@ContractID
*/

 CREATE PROCEDURE WMP30011
(
     @DivisionID            VARCHAR(50),
	 @DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
	 @IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
     @UserID				VARCHAR(50),
	 @FromDate				DATETIME, 
	 @ToDate				DATETIME,
	 @PeriodList			NVARCHAR(2000),
	 @ContractID			VARCHAR(50)
)
AS
DECLARE 	@sSQL varchar(MAX),
			@sWhere NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere = ''

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' T1.DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1
	BEGIN
		--SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,T1.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (T1.VoucherDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (T1.VoucherDate <= ''' + @ToDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (T1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END
	ELSE IF @IsDate = 0 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		--SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(T1.VoucherDate) <10 THEN ''0''+rtrim(ltrim(str(MONTH(T1.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(T1.VoucherDate)))) 
		--			ELSE rtrim(ltrim(str(MONTH(T1.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(T1.VoucherDate)))) END) in ('''+@PeriodList +''')'
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(T1.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@ContractID,'') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.ContractID, '''') IN (''' + @ContractID + ''') '

	SET @sSQL = 'SELECT 
	T1.DivisionID, T2.Type, T1.VoucherTypeID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T3.ObjectName, T1.FromDate, T1.ToDate, T1.ContractID, 
	T4.ContractNo, T2.DetailVoucherID, T2.DetailVoucherNo, T2.DetailVoucherDate, T2.CostID, ISNULL(T5.InventoryName,N''Chi phí lưu kho'') AS CostName, 
	T2.WareHouseID AS WareHouseID, T6.InventoryName AS WareHouseName, T2.InventoryID, T7.InventoryName, T2.Quantity, T2.DetailFromDate, T2.DetailToDate, 
	T2.UnitPrice, T2.OriginalAmount, T2.ConvertAmount,
	CEILING(DATEDIFF(d,T2.DetailFromDate, T2.DetailToDate)/CASE WHEN T1.DayUnit = 0 THEN 1
															WHEN T1.DayUnit = 1 THEN 7
															WHEN T1.DayUnit = 2 THEN 30 END) AS NumDate
	FROM WT0100 T1 WITH (NOLOCK)
	LEFT JOIN WT0103 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T1.ObjectID = T3.ObjectID
	LEFT JOIN AT1020 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.ContractID = T4.ContractID
	LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T2.CostID = T5.InventoryID
	LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T2.WareHouseID = T6.InventoryID
	LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T2.InventoryID = T7.InventoryID
	WHERE '+ @sWhere + ' 
	ORDER BY T2.Type, T2.DetailVoucherNo, T2.DetailVoucherDate, T2.CostID, T2.InventoryID'

Print (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
