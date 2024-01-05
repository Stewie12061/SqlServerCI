IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2170]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2170]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Form POSF2050 Danh mục Phiếu yêu cầu dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Dũng DV, Date 28/09/2019
----Modify by: Trà Giang, Date 26/02/2020: Bổ sung phân quyền xem dữ liệu theo nhóm người dùng.
----Modify by: Kiều Nga, Date 13/04/2020: Lấy côt số điện thoại di động hội viên
----Modify by: Hoài Phong , Date 30/09/2020: Bổ sung cột tổng tiền hiển thị lên cho phiếu YCDV
----Modify by: Hoài Bảo , Date 21/06/2022: Cập nhật điều kiện load theo ngày, theo kỳ.
----Modify by: Hoài Bảo , Date 19/09/2022: Cập nhật lấy số điện thoại Phone  -> Tel
----Modify by: Hoài Bảo , Date 27/09/2022: Cập nhật đổi bảng lấy dữ liệu Điều phối nhân viên POST2053 -> CRMT2174.
----Modify by: Hoài Thanh , Date 30/09/2022: Lấy thêm cột StatusID.
----Modify by: Hoài Bảo , Date 09/12/2022: Bổ sung load dữ liệu theo biến phân quyền ConditionServiceRequestManagement
----Modify by: Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
----Modify by: Hoài Bảo, Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/* 
exec CRMP2170 @DivisionID=N'NN'',''TD',@DivisionIDList=N'',@WarrantyRecipientID=N'',@VoucherNo=N'',@MemberID=N'',@Tel=N'',@InventoryID=N'',@WarrantyCard=N'',@StatusID=N'0',@IsDate=1,@FromDate='2019-08-08 00:00:00',@ToDate='2019-09-29 00:00:00',@Period=N'',@UserID=N'ADMIN',@strWhere=N'',@PageNumber=1,@PageSize=25

*/
----
CREATE PROCEDURE CRMP2170 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID
		@WarrantyRecipientID  NVARCHAR(250) = '',
        @VoucherNo  NVARCHAR(250) = '',
		@MemberID  NVARCHAR(250) = '',
		@Tel  NVARCHAR(50) = '',
		@InventoryID  NVARCHAR(250) = '',
		@WarrantyCard  NVARCHAR(250) = '',
		@StatusID VARCHAR(50) = '',
		@IsDate TINYINT = 0,--0: theo ngày, 1: Theo kỳ
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@Period NVARCHAR(4000) = '', --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50) = '',
		@ShopID VARCHAR(50) = '',
		@strWhere NVARCHAR(MAX) = NULL,
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@ConditionServiceRequestManagement NVARCHAR(MAX) = '',
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@IsNotCodinator INT = 0,-- 1: lấy dữ liệu yêu cầu dịch vụ chưa điều phối
		@EmployeeIDList NVARCHAR(MAX) = NULL,
		@StatusIDList NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere01 NVARCHAR(MAX),
		@sWhere02 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = 'WHERE ',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
SET @sWhere01 = N''       
SET @sWhere='WHERE '
SET @OrderBy = ' M.CreateDate'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

--Check Para DivisionIDList null then get DivisionID 
IF Isnull(@DivisionIDList, '')!=''
	BEGIN
		SET @sWhere = @sWhere + ' P50.DivisionID IN ('''+@DivisionIDList+''')'
		SET @sWhereDashboard = @sWhereDashboard + ' P50.DivisionID IN ('''+@DivisionIDList+''')'
	END
Else 
	SET @sWhere = @sWhere + ' P50.DivisionID IN ('''+@DivisionID+''')'

SET @sWhere = @sWhere + ' AND ISNULL(P50.DeleteFlg, 0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(P50.DeleteFlg, 0) = 0 '

IF @IsDate = 1 
	BEGIN
		--SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),P50.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (P50.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (P50.VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (P50.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
ELSE 
	BEGIN
		--SET @sWhere = @sWhere + ' (Case When  MONTH(P50.VoucherDate) <10 then ''0''+rtrim(ltrim(str(MONTH(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) 
		--							Else rtrim(ltrim(str(MONTH(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) End) IN ('''+@Period+''')'
		IF(ISNULL(@Period,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(P50.VoucherDate, ''MM/yyyy'')) IN ( ''' + @Period + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(P50.VoucherDate, ''MM/yyyy'')) IN ( ''' + @Period + ''') '
		END
	END
	-- Xử lý phân quyền UserID thuộc nhóm người dùng nào được xem dữ liệu phiếu YCDV.
			--Nếu là quản lý muốn thấy all phiếu thì check vào [sửa] đối với 2 màn hình [APF0094].
			-- Không check thì NV nhóm đó chỉ thấy những phiếu mình được điều phối tới và những phiếu do mình tạo chưa được điều phối cho NV khác.
	--If Not exists (
 --           SELECT TOP 1 1 FROM AT1403 where DivisionID = @DivisionID and ModuleID='ASOFTAPP' and ScreenID ='APF0094' and IsUpdate = 1
 --           and GroupID in (Select GroupID FROM AT1402 Where DivisionID = @DivisionID and UserID = @UserID)
 --           )

	--SET @sWhere01 =  'AND  ((ISNULL(P50.CreateUserID,'''') = '''+@UserID+''' AND P53.DeliveryEmployeeID IS NULL AND P53.RepairEmployeeID IS NULL AND P53.GuaranteeEmployeeID IS NULL)
	--					OR (P53.DeliveryEmployeeID = '''+@UserID+''') OR (P53.RepairEmployeeID = '''+@UserID+''') OR (P53.GuaranteeEmployeeID = '''+@UserID+'''))' 

	-- Xử lý bổ sung biến phân quyền dữ liệu, User sẽ được phân quyền xem dữ liệu dựa vào thiết lập biến phân quyền dữ liệu ở màn hình Hệ thống
	SET @sWhere01 = ' AND (ISNULL(P50.CreateUserID, '''') IN (''' + @ConditionServiceRequestManagement + ''')
					  OR ISNULL(P53.DeliveryEmployeeID, '''') IN (''' + @ConditionServiceRequestManagement + ''')
					  OR ISNULL(P53.RepairEmployeeID, '''') IN (''' + @ConditionServiceRequestManagement + ''')
					  OR ISNULL(P53.GuaranteeEmployeeID, '''') IN (''' + @ConditionServiceRequestManagement + '''))'

	IF Isnull(@WarrantyRecipientID, '')!=''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(P50.WarrantyRecipientID,'''') LIKE N''%'+@WarrantyRecipientID+'%'' '
		END	
	IF Isnull(@StatusID, '')!=''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(P50.StatusID,'''') LIKE N''%'+@StatusID+'%'' '
		END	
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P50.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(P50.MemberID, '''') LIKE N''%'+@MemberID+'%'' '
	IF Isnull(@Tel, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P0011.Phone, '''') LIKE N''%'+@Tel+'%'' '
	IF Isnull(@WarrantyCard, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P50.WarrantyCard, '''') LIKE N''%'+@WarrantyCard+'%'''  
	IF Isnull(@InventoryID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P50.InventoryID, '''') LIKE N''%'+@InventoryID+'%'''
	IF Isnull(@ShopID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P50.ShopID, '''') LIKE N''%'+@ShopID+'%'' '

IF ISNULL(@strWhere,'')!=''
	BEGIN
		IF @strWhere LIKE '%IsNull%'
			SET @strWhere = REPLACE(@strWhere,''',''',',''''')
		IF @strWhere LIKE '%DivisionID%'
			SET @strWhere = REPLACE(@strWhere,'DivisionID','P50.DivisionID')
		SET @sWhere=@strWhere;
	END

IF @Type = 6
	BEGIN
		IF @IsNotCodinator = 1
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(P50.IsCordinator,0) = 0 AND P50.StatusID != 6'

		IF ISNULL(@EmployeeIDList, '') != '' 
			SET @sWhereDashboard = @sWhereDashboard + ' AND (ISNULL(P50.CreateUserID, '''') IN (''' + @EmployeeIDList + ''')
													    OR ISNULL(P53.DeliveryEmployeeID, '''') IN (''' + @EmployeeIDList + ''')
													    OR ISNULL(P53.RepairEmployeeID, '''') IN (''' + @EmployeeIDList + ''')
													    OR ISNULL(P53.GuaranteeEmployeeID, '''') IN (''' + @EmployeeIDList + '''))'
		IF ISNULL(@StatusIDList, '') != ''
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(P50.StatusID,'''') IN ('''+@StatusIDList+''') '

		SET @sWhere02 = @sWhereDashboard
	END
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere02 = 
		CASE
			WHEN @RelTable = 'POST0011' THEN 'INNER JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.MemberID = P50.MemberID 
										WHERE C9.APK = ''' +@RelAPK+ '''
										AND P50.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
										AND ISNULL(P50.DeleteFlg, 0) = 0'
			ELSE @sWhere
		END
	END
	ELSE
		SET @sWhere02 = @sWhere
END

SET @sSQL = '
	SELECT P50.APK,P50.DivisionID,P50.VoucherNo,P50.VoucherDate,P50.WarrantyRecipientID,P50.MemberID
		,P50.StatusID, ISNULL(P0011.Tel,ISNULL(P0011.Tel1, '''')) AS Tel
		,P50.InventoryID,(select sum (Amount) from POST2051 where  APKMaster = P50.APK ) as TotalAmount
		,P50.WarrantyCard,P50.IsGuarantee,A302.InventoryName,P0011.MemberName,P0011.Address,P50.CreateDate
		,A01.FullName as GuaranteeEmployeeID,A02.FullName as RepairEmployeeID,A03.FullName as DeliveryEmployeeID
	INTO #TemCRMT2170
	FROM CRMT2170 (NOLOCK) AS P50    
	LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON P50.MemberID = P0011.MemberID
	LEFT JOIN dbo.AT1302(NOLOCK)  AS A302 ON A302.InventoryID = P50.InventoryID
	--LEFT JOIN POST2053 (NOLOCK)   AS P53 ON P53.VoucherNo = P50.VoucherNo
	LEFT JOIN CRMT2174 (NOLOCK) AS P53 ON P53.VoucherNo = P50.VoucherNo
	LEFT JOIN AT1103 A01 WITH (NOLOCK)  ON P53.GuaranteeEmployeeID = A01.EmployeeID
	LEFT JOIN AT1103 A02 WITH (NOLOCK)  ON P53.RepairEmployeeID = A02.EmployeeID
	LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON P53.DeliveryEmployeeID = A03.EmployeeID
	'+@sWhere02+@sWhere01+'

	Declare @Count int
	Select @Count = Count(*) FROM #TemCRMT2170

	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,@Count AS TotalRow, 
		   M.APK,M.DivisionID,M.VoucherNo,M.VoucherDate,M.WarrantyRecipientID,M.MemberID,M.StatusID, M.Tel
		   ,M.InventoryID,M.TotalAmount,M.WarrantyCard,M.IsGuarantee,M.Address,M.InventoryName,M.MemberName,M.Address,M.CreateDate,
		   M.GuaranteeEmployeeID,M.RepairEmployeeID,M.DeliveryEmployeeID
	FROM #TemCRMT2170 M
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--PRINT (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
