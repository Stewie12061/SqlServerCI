IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----<Summary> báo cáo công nợ công ty tài chính.
----<Created by>: Trà Giang on 12/11/2019: 
----Modify on 24/03/2020 by Trà Giang: (Sửa theo MinhSang) Load công nợ đối tượng, bỏ điều kiện phân loại đối tượng (vì chỉ có hình thức trả góp mới thiết lập chọn loại đối tượng POST0006(CON thiết lập)) 
----Modified on 08/04/2020 by Kiều Nga  : Lấy thêm thông tin hội viên
----Modified on 27/04/2020 by Kiều Nga  : Fix lỗi lọc theo đk thời gian chưa đúng
----Modified on 29/04/2020 by Kiều Nga  : Fix lỗi Số tiền trả góp phiếu hàng bán trả lại hiển thị sai
----<Example>
/*
    EXEC POSP3083 N'TD', 'CHBD01',  1, '2019-11-14 00:00:00.000','2019-11-14 00:00:00.000','11/2019',N'CTBINHAN'
*/

CREATE PROCEDURE POSP3083
		(	@DivisionIDList varchar(50),
			@ShopIDList			NVARCHAR(MAX),
		  	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
			@FromDate			DATETIME, 
			@ToDate				DATETIME, 
			@PeriodIDList		NVARCHAR(2000),
			@ObjectID			NVARCHAR(Max)
)
		  
AS 
BEGIN
	DECLARE @sSQL1 NVARCHAR(MAX)= '',
			@sWhere NVARCHAR(MAX)= '',
			@sWhere1 NVARCHAR(MAX)= '',
			@sWhere2 NVARCHAR(MAX)= '',
			@Date NVARCHAR(50)

	IF isnull(@DivisionIDList, '')!=''
	SET @sWhere = @sWhere + N' AND M.DivisionID IN ('''+@DivisionIDList+''') '
	
	IF Isnull(@ShopIDList, '') !=''
	SET @sWhere = @sWhere + N' AND M.ShopID IN ('''+@ShopIDList+''') '

	IF Isnull(@ObjectID, '') !=''
	Begin
	SET @sWhere1 = @sWhere1 + N' AND M.PaymentObjectID01 IN ('''+@ObjectID+''') '
	SET @sWhere2 = @sWhere2 + N' AND M.PaymentObjectID02 IN ('''+@ObjectID+''')'
	End

	IF @IsDate = 1	
	Begin
		SET @Date = @Date + ''''+CONVERT(VARCHAR,@FromDate,112)  +''' as FromDate,'''+CONVERT(VARCHAR,@ToDate,112)+ ''' as ToDate'
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	end
	ELSE
	Begin
		SET @Date = @Date + ' M.TranMonth, M.TranYear, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
										Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) as MonthYear '
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
										Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	End	
	
	
	SET @sSQL1	= N'			
		SELECT M.VoucherNo,M.VoucherDate,M.TotalInventoryAmount
			, AT1202.ObjectID AS PaymentObjectID01,AT1202.ObjectName as PaymentObjectName01
			, A2.ObjectID AS PaymentObjectID02,A2.ObjectName as PaymentObjectName02
			,M.MemberID,P0011.MemberName
			,case when M.PaymentObjectID01 IS NOT NULL then Isnull(M.PaymentObjectAmount01,0) - Isnull(M2.PaymentObjectAmount01,0) +Isnull(M3.PaymentObjectAmount01,0)
			when M.PaymentObjectID02 IS NOT NULL then Isnull(M.PaymentObjectAmount02,0) - Isnull(M2.PaymentObjectAmount02,0) + Isnull(M3.PaymentObjectAmount02,0)
			when M.PaymentObjectID01 IS NOT NULL and M.PaymentObjectID02 IS NOT NULL 
				then  Isnull(M.PaymentObjectAmount01,0) + Isnull(M.PaymentObjectAmount02,0) 
					  - (Isnull(M2.PaymentObjectAmount01,0) + Isnull(M2.PaymentObjectAmount02,0))
				      + (Isnull(M3.PaymentObjectAmount01,0) + Isnull(M3.PaymentObjectAmount02,0))
			else 0 end as DebitAmount
		FROM POST0016 M WITH (NOLOCK) 
		LEFT JOIN
			(SELECT ObjectID, ObjectName FROM  AT1202 WITH (NOLOCK) -- WHERE AT1202.IsSupplier = 1
				)AT1202 ON M.PaymentObjectID01 = AT1202.ObjectID 
		LEFT JOIN
			(SELECT ObjectID, ObjectName FROM  AT1202 WITH (NOLOCK) -- WHERE AT1202.IsSupplier = 1
			)A2 ON M.PaymentObjectID02 = A2.ObjectID 
		LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON M.MemberID = P0011.MemberID
		LEFT JOIN POST0006 WITH (NOLOCK) On M.APKPaymentID = POST0006.APK
		LEFT JOIN POST0016 M2 WITH (NOLOCK) ON M.VoucherNo = M2.VoucherNo AND M2.PVoucherNo is not null
		LEFT JOIN POST0016 M3 WITH (NOLOCK) ON M.VoucherNo = M3.VoucherNo AND M3.CVoucherNo is not null
		  WHERE  (M.PaymentObjectID01 IS NOT NULL  '+ @sWhere1+'
			OR M.PaymentObjectID02 IS NOT NULL '+ @sWhere2+') AND M.DeleteFlg=0 AND M.PVoucherNo is null AND M.CVoucherNo is null
	 ' + @sWhere +'
	 '
	EXEC (@sSQL1)
	PRINT (@sSQL1)
END 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
