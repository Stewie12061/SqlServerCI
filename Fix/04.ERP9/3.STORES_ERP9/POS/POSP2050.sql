IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2050]
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
-- <Example>
/* 
exec POSP2050 @DivisionID=N'NN'',''TD',@DivisionIDList=N'',@WarrantyRecipientID=N'',@VoucherNo=N'',@MemberID=N'',@Tel=N'',@InventoryID=N'',@WarrantyCard=N'',@StatusID=N'0',@IsDate=1,@FromDate='2019-08-08 00:00:00',@ToDate='2019-09-29 00:00:00',@Period=N'',@UserID=N'ADMIN',@strWhere=N'',@PageNumber=1,@PageSize=25

*/
----
CREATE PROCEDURE POSP2050 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@WarrantyRecipientID  NVARCHAR(250),
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@Tel  NVARCHAR(50),
		@InventoryID  NVARCHAR(250),
		@WarrantyCard  NVARCHAR(250),
		@StatusID VARCHAR(50),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@ShopID VARCHAR(50),
		@strWhere NVARCHAR(MAX) = NULL,
		@PageNumber INT,
		@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere01 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
SET @sWhere01 = N''       
SET @sWhere='WHERE P50.DeleteFlg =0 AND '
SET @OrderBy = ' P50.CreateDate'
		IF @IsDate = 1 
		begin
		SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),P50.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		end
	Else 
	BEGIN
		SET @sWhere = @sWhere + ' (Case When  MONTH(P50.VoucherDate) <10 then ''0''+rtrim(ltrim(str(MONTH(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) 
									Else rtrim(ltrim(str(MONTH(P50.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P50.VoucherDate)))) End) IN ('''+@Period+''')'
	end
	-- Xử lý phân quyền UserID thuộc nhóm người dùng nào được xem dữ liệu phiếu YCDV.
			--Nếu là quản lý muốn thấy all phiếu thì check vào [sửa] đối với 2 màn hình [APF0094].
			-- Không check thì NV nhóm đó chỉ thấy những phiếu mình được điều phối tới và những phiếu do mình tạo chưa được điều phối cho NV khác.
	If Not exists (
            SELECT TOP 1 1 FROM AT1403 where DivisionID = @DivisionID and ModuleID='ASOFTAPP' and ScreenID ='APF0094' and IsUpdate = 1
            and GroupID in (Select GroupID FROM AT1402 Where DivisionID = @DivisionID and UserID = @UserID)
            )

	SET @sWhere01 =  'AND  ((ISNULL(P50.CreateUserID,'''') = '''+@UserID+''' AND P53.DeliveryEmployeeID IS NULL AND P53.RepairEmployeeID IS NULL AND P53.GuaranteeEmployeeID IS NULL)
						OR (P53.DeliveryEmployeeID = '''+@UserID+''') OR (P53.RepairEmployeeID = '''+@UserID+''') OR (P53.GuaranteeEmployeeID = '''+@UserID+'''))' 

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND P50.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' AND P50.DivisionID IN ('''+@DivisionID+''')'

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
end
SET @sSQL = '	
Declare @Count int
	Select @Count = Count(VoucherNo) From  POST2050 (NOLOCK) AS P50 
	LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON P50.MemberID = P0011.MemberID
	' +@sWhere + ';
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,@Count AS TotalRow, 
       P50.APK,P50.DivisionID,P50.VoucherNo,P50.VoucherDate,P50.WarrantyRecipientID,P50.MemberID,P0011.Phone as Tel
	   ,P50.InventoryID,(select sum (Amount) from POST2051 where  APKMaster = P50.APK ) as TotalAmount,P50.WarrantyCard,P50.IsGuarantee,P0011.Address,A302.InventoryName,P0011.MemberName,P0011.Address,P50.CreateDate,
	   A01.FullName as GuaranteeEmployeeID,A02.FullName as RepairEmployeeID,A03.FullName as RepairEmployeeID
FROM POST2050 (NOLOCK) AS P50    
    LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON P50.MemberID = P0011.MemberID
	LEFT JOIN dbo.AT1302(NOLOCK)  AS A302 ON A302.InventoryID = P50.InventoryID
	LEFT JOIN POST2053 (NOLOCK)   AS P53 ON P53.VoucherNo = P50.VoucherNo
	LEFT JOIN AT1103 A01 WITH (NOLOCK)  ON P53.GuaranteeEmployeeID = A01.EmployeeID
	LEFT JOIN AT1103 A02 WITH (NOLOCK)  ON P53.RepairEmployeeID = A02.EmployeeID
	LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON P53.DeliveryEmployeeID = A03.EmployeeID
 '+@sWhere++@sWhere01+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)

print (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
