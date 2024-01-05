IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP3005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP3005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Báo cáo sản xuất hàng ngày
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đức Tuyên on: 01/10/2022
---- Modify by: Phương Thảo on: [EXEDY][2023/06/IS/0239]27/06/2023 Chỉnh sửa báo báo cáo theo luồng chuẩn EXEDY(
                                -- 1/Bổ sung chọn line và không chọn line
								-- 2/ Hiển thị line xuất báo cáo cách nhau bởi dấu phẩy
---- Modify by: Trọng Phúc on: [MAITHU] 22/08/2023 Hiển thị nhiều tên nhân viên, kế hoạch
--example:EXEC MP3005 @DivisionID=N'EXV',@DivisionIDList='EXV',@IsDate=1,@FromDate='',@ToDate='',@PeriodList='07/2023',@LineProduce='GG01'',''L011'


								
CREATE PROCEDURE MP3005
(
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate INT, ---- 1: là ngày, 0: là kỳ
	@FromDate DATETIME,
	@ToDate DATETIME,
   	@PeriodList NVARCHAR(MAX),
	@LineProduce NVARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
		@sWhere1 NVARCHAR(MAX)=''
        
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = ' MT10.DivisionID IN ('''+@DivisionIDList+''')'
	END
ELSE 
	BEGIN
		SET @sWhere = ' MT10.DivisionID = N'''+@DivisionID+''''
	END

IF @IsDate = 1
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN MT10.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(MT10.TranMonth)))+''/''+ltrim(Rtrim(str(MT10.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(20), MT10.VoucherDate,112) BETWEEN ''' + CONVERT(VARCHAR(20),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(20),Isnull(@ToDate,'12/31/9999'),112) + ''''
	END
IF ISNULL(@LineProduce, '') != '' -- Chọn line sản xuất
BEGIN
SET @sWhere1 = @sWhere +'And MT11.Ana06ID IN('''+@LineProduce+''') ' 

SET @sSQL = N'
-- kết quả sản xuất, lấy thông tin chung của sản phẩm

		SELECT DISTINCT MT11.InventoryID AS InventoryID, AT302.InventoryName AS InventoryName,
		MT11.StartTime  AS StartTime,
		MT11.EndTime  AS EndTime,
		MT41.Quantity AS Quantity,
		MT11.ItemActual  AS ItemActual,
		MT11.ItemReturnedQuantity  AS ItemReturnedQuantity,
		MT11.PreparePlanTime  AS PreparePlanTime,
		MT11.MoldProblemTime  AS MoldProblemTime,
		MT11.DeviceProblemTime  AS DeviceProblemTime
		FROM MT2210 MT10 WITH(NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT11.InheritVoucherID = MT60.apk AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2142 MT42 WITH (NOLOCK) ON MT60.InheritTransactionID = MT42.APK AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT42.APK_MT2141 = MT41.apk AND MT41.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT1302 AT302 WITH (NOLOCK) ON MT11.InventoryID = AT302.InventoryID AND AT302.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere1+'	
--Bộ phận sản xuất,lấy thông tin kết quả công đoạn
		SELECT MT10.VoucherNo AS VoucherNo, AT103.FullName as EmployeeName, MT11.SourceEmployeeID as EmployeeID, AT126.PhaseName AS PhaseName, MT11.Description AS Description, MT10.VoucherDate, MT10.CreateDate
		FROM MT2210 MT10 WITH(NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT11.InheritVoucherID = MT60.apk AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT1103 AT103 WITH (NOLOCK) ON MT11.SourceEmployeeID = AT103.EmployeeID AND AT103.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT0126 AT126 WITH (NOLOCK) ON MT11.PhaseID = AT126.PhaseID AND AT126.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere1+'	
		ORDER BY MT10.VoucherNo

----lấy line bộ phận:Line Assy:
		SELECT STRING_AGG(MT11.Ana06Name, '', '') AS Ana06Name
		FROM MT2210 MT10 WITH (NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere1+'


'
END
ELSE
BEGIN --- Không chọn line sản xuất
SET @sSQL = N'
-- kết quả sản xuất, lấy thông tin chung của sản phẩm

		SELECT DISTINCT MT11.InventoryID AS InventoryID, AT302.InventoryName AS InventoryName,
		MT11.StartTime  AS StartTime,
		MT11.EndTime  AS EndTime,
		MT11.ItemPlan AS Quantity,
		MT11.ItemActual  AS ItemActual,
		MT11.ItemReturnedQuantity  AS ItemReturnedQuantity,
		MT11.PreparePlanTime  AS PreparePlanTime,
		MT11.MoldProblemTime  AS MoldProblemTime,
		MT11.DeviceProblemTime  AS DeviceProblemTime
		FROM MT2210 MT10 WITH(NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT11.InheritVoucherID = MT60.apk AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2142 MT42 WITH (NOLOCK) ON MT60.InheritTransactionID = MT42.APK AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT42.APK_MT2141 = MT41.apk AND MT41.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT1302 AT302 WITH (NOLOCK) ON MT11.InventoryID = AT302.InventoryID AND AT302.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere+'	
--Bộ phận sản xuất,lấy thông tin kết quả công đoạn
		SELECT MT10.VoucherNo AS VoucherNo, 
				STUFF((SELECT '', '' + AT103.FullName
                FROM AT1103 AT103 WHERE AT103.EmployeeID IN (SELECT name FROM SplitString(MT11.SourceEmployeeID, '','')) AND AT103.DivisionID IN (''@@@'',MT10.DivisionID)
                FOR XML PATH('''')), 1, 2, '''') AS EmployeeName, 
			  MT11.SourceEmployeeID as EmployeeID, AT126.PhaseName AS PhaseName, MT11.Description AS Description, MT10.VoucherDate, MT10.CreateDate
		FROM MT2210 MT10 WITH(NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN MT2160 MT60 WITH (NOLOCK) ON MT11.InheritVoucherID = MT60.apk AND MT60.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT1103 AT103 WITH (NOLOCK) ON MT11.SourceEmployeeID = AT103.EmployeeID AND AT103.DivisionID IN (''@@@'',MT10.DivisionID)
			LEFT JOIN AT0126 AT126 WITH (NOLOCK) ON MT11.PhaseID = AT126.PhaseID AND AT126.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere+'	
		ORDER BY MT10.VoucherNo
----lấy line bộ phận:Line Assy:
		SELECT STRING_AGG(MT11.Ana06Name, '', '') AS Ana06Name
		FROM MT2210 MT10 WITH (NOLOCK)
			LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster AND MT11.DivisionID IN (''@@@'',MT10.DivisionID)
		WHERE '+@sWhere+'
'
END

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
