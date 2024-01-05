
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		MaiVu
-- Create date: 03/06/2014
-- Description:	Lọc dữ liệu phiếu xuất hàng.
-- Modify by Hoàng Vũ; on 13/06/2016
-- Modify by Hoàng Vũ; on 31/01/2018: Sắp xếp giảm dần
-- EXEC POSP0027 'KC',0,'2014-01-01','2014-12-31','01/2016'',''02/2016'',''03/2016','KC','1','1','1','1','1','',1,1000
-- Bo sung Load so chung tu tham chieu tu phieu nhap va phieu yeu cau van chuyen
-- Modify by thị Phượng on 07/09/2016: Bỏ inner join POST0028 sang lấy left join để load phiếu xuất sinh trực tiếp
-- Modified by Tiểu Mai on 23/07/2018: Bổ sung Đối tượng giao hộ, ngày gửi giao (DeliveryObjectID, DeliveryDate) cho ATTOM
-- Modified by Tra Giang on 19/11/2018: Bổ sung select Đối tượng giao hộ, ngày gửi giao (DeliveryObjectID, DeliveryDate) cho ATTOM
-- Modified by Hoàng vũ on 05/04/2019: Fixbug lỗi Giang làm phát sinh lỗi bên ATTOM
-- Modified by Tuấn Anh on 27/12/2019: Bổ sung điều kiện lọc theo số tham chiếu

-- =============================================
CREATE PROCEDURE [dbo].[POSP0027]
 @DivisionID NVARCHAR(50),
 @IsDate tinyint, --0: Tìm theo ngày, 1: Tìm theo kỳ
 @FromDate datetime,
 @ToDate datetime,
 @PeriodList NVARCHAR(2000),
 @DivisionIDList NVARCHAR(2000),
 @ShopID varchar(50),
 @WarehouseID varchar(50),
 @VoucherNo varchar(50),
 @EmployeeID varchar(50),
 @EmployeeName nvarchar(250),
 @StatusName nvarchar(50),
 @PageNumber INT,
 @PageSize INT,
 @ShopIDPermission NVARCHAR(MAX) = NULL
AS
DECLARE @sSQL01 NVARCHAR (max),
		@sSQL02 NVARCHAR (max),
		@sWhere NVARCHAR(max),
		@sWhere1 NVARCHAR(max),
        @OrderBy NVARCHAR(max),
        @TotalRow NVARCHAR(max)
SET @sWhere = ''
SET @sWhere1 = ''
SET @TotalRow = ''
SET @OrderBy = ' x.VoucherDate desc, x.VoucherNoXK'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''')'

	IF @PageNumber = 1 SET @TotalRow = ' COUNT(*) OVER () ' ELSE SET @TotalRow = 'NULL'

	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),M.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodList+''')'
	IF Isnull(@ShopID, '')!=''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID,'''') LIKE N''%'+@ShopID+'%'' '
	END
	SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDPermission+''')'

	IF Isnull(@WarehouseID, '') != ''
		SET @sWhere = @sWhere + ' AND M.WarehouseID LIKE N''%'+@WarehouseID+'%''  '
	IF Isnull(@VoucherNo, '') != ''

		SET @sWhere1 = @sWhere1 + ' AND ( X.VoucherNoXK LIKE N''%'+@VoucherNo+'%'' or X.RefVoucherNo LIKE N''%'+@VoucherNo+'%'' ) '
	IF Isnull(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND M.EmployeeID LIKE N''%'+@EmployeeID+'%'' '
	IF Isnull(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EmployeeName,'''') LIKE N''%'+@EmployeeName+'%''  '
	IF Isnull(@StatusName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Status,0) ='+@StatusName

	SET @sSQL01 = 'SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
			, x.APK, x.DivisionID, x.ShopID, x.WarehouseID, x.VoucherDate,  x.EmployeeID, x.EmployeeName, x.Description
			, x.VoucherNoXK as VoucherNo, x.RefVoucherNo, x.Status, x.StatusName, x.DeliveryObjectID,x.DeliveryObjectName,x.DeliveryDate
			From (Select Distinct M.APK, M.DivisionID, M.ShopID, M.WarehouseID, M.VoucherDate, M.EmployeeID, M.EmployeeName, M.Description, M.VoucherNo as VoucherNoXK
					, W.VoucherNoYC, P.VoucherNoPN, Q.VoucherNoXC, P16.VoucherNo as BVoucherNo, P16.CVoucherNo, P16.PVoucherNo , M.Status, POST0099.Description as StatusName

					,  (Case When P16.CVoucherNo is null and W.VoucherNoYC is null and P.VoucherNoPN is null and Q.VoucherNoXC is null and T.VoucherNoDV is null then P16.VoucherNo 
						When P16.CVoucherNo is not null and W.VoucherNoYC is null and P.VoucherNoPN is null  and Q.VoucherNoXC is null and T.VoucherNoDV is null then P16.CVoucherNo 
						When P16.CVoucherNo is null and W.VoucherNoYC is not null and P.VoucherNoPN is null  and Q.VoucherNoXC is null and T.VoucherNoDV is null then W.VoucherNoYC 
						When P16.CVoucherNo is null and W.VoucherNoYC is null and P.VoucherNoPN is not null  and Q.VoucherNoXC is null and T.VoucherNoDV is null then P.VoucherNoPN
						When P16.CVoucherNo is null and W.VoucherNoYC is null and P.VoucherNoPN is null  and Q.VoucherNoXC is not null and T.VoucherNoDV is null then Q.VoucherNoXC
						When P16.CVoucherNo is null and W.VoucherNoYC is null and P.VoucherNoPN is null  and Q.VoucherNoXC is null and T.VoucherNoDV is not null then T.VoucherNoDV	
						End ) as RefVoucherNo, M.DeliveryObjectID, POST0011.MemberName AS DeliveryObjectName,  M.DeliveryDate
					FROM POST0027 M  WITH (NOLOCK) Left join POST0028 D  WITH (NOLOCK) on M.APK = D.APKmaster and M.DeleteFlg = D.Deleteflg
									left join  (Select Distinct M.DivisionID, M.VoucherID, M.VoucherNo as VoucherNoYC
												From WT0095 M  WITH (NOLOCK) inner join WT0096 D  WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID) W 
												on D.APKMInherited = W.VoucherID and D.DivisionID = W.DivisionID
									left join  (Select Distinct M.APK, M.DivisionID, M.VoucherID, M.VoucherNo as VoucherNoPN
												From POST0015 M  WITH (NOLOCK) inner join POST00151 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
												Where M.DeleteFlg =0
												) P on D.APKMInherited = P.APK and D.DivisionID = P.DivisionID
									left join  (Select Distinct M.APK, D.APK as APKDetail, M.DivisionID,  M.VoucherNo as VoucherNoXC
												From AT2006 M  WITH (NOLOCK) inner join AT2007 D  WITH (NOLOCK) on M.VoucherID = D.VoucherID and M.DivisionID = D.DivisionID
												) Q on D.APKMInherited = Q.APK and D.APKDInherited = Q.APKDetail and D.DivisionID = Q.DivisionID
									left join  (Select Distinct M.APK, D.APK as APKDetail, M.DivisionID,  M.VoucherNo as VoucherNoDV
												From POST2050 M  WITH (NOLOCK) inner join POST2051 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DivisionID = D.DivisionID
												) T on D.APKMInherited = T.APK and D.DivisionID = T.DivisionID
									Left Join POST0016 P16  WITH (NOLOCK) on M.DivisionID = P16.DivisionID 
												and (M.VoucherID = P16.VoucherID or  M.VoucherID = convert(varchar(50),P16.APK))
									Left Join POST0099 With (NOLOCK) on M.Status = POST0099.ID and CodeMaster =''POS000010''

									LEFT JOIN POST0011 WITH (NOLOCK) ON POST0011.MemberID = M.DeliveryObjectID
									'
	SET @sSQL02 = '
		WHERE '+@sWhere+' AND M.DeleteFlg = 0 )x 
		WHERE 1=1 '+@sWhere1+'
				 ORDER BY '+@OrderBy+'
				 OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				 FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL01 + @sSQL02)
PRINT (@sSQL01)
PRINT (@sSQL02)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

