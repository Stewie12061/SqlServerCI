IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo danh sách tình hình chi trả cổ tức – SHMR3001
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Create Date: Hoàng vũ, on 26/10/2018
-- <History>
-- <Example> EXEC SHMP3001 'HCM', 'HCM', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018','','', 'ASOFTADMIN'

CREATE PROCEDURE SHMP3001 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToObjectID		VARCHAR(MAX),
	@FromObjectID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID = N'''+@DivisionID+''''	
	
		
		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
		--Search theo hội viên  (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng , đến mặt hàng
		IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
			SET @sWhere = @sWhere + ' AND D.ObjectID > = N'''+@FromObjectID +''''
		ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
			SET @sWhere = @sWhere + ' AND D.ObjectID < = N'''+@ToObjectID +''''
		ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
			SET @sWhere = @sWhere + ' AND D.ObjectID Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

		--Lấy dữ liệu bảng					 	    
		SET @sSQL=N'	
			SELECT   M.DivisionID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, M.TranMonth, M.TranYear, M.LockDate
				, M.Description, M.TotalHoldQuantity, M.TotalAmount, M.FaceValue, M.DividendPerShare
				, M.CreateUserID, M.LastModifyUserID, M.CreateDate, M.LastModifyDate
				, D.ObjectID, A02.ObjectName, A02.Address, A02.Tel, A02.Fax, A02.Email, A02.VATNo
				, S10.ContactIssueDate, S10.ContactIssueBy, S10.IdentificationNumber
				, D.HoldQuantity, D.AmountPayable
				, Sum(A90.ConvertedAmount) as AmountPaid, D.AmountPayable - Sum(A90.ConvertedAmount) as AmountRemainning
				, D.OrderNo
			FROM SHMT2040 M WITH (NOLOCK) INNER JOIN SHMT2041 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										  LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.ObjectID = D.ObjectID
										  LEFT JOIN SHMT2010 S10 WITH (NOLOCK) ON S10.ObjectID = D.ObjectID
										  Left join AT9000 A90 WITH (NOLOCK) ON D.DivisionID = A90.DivisionID and CONVERT(VARCHAR(50),D.APK) = A90.InheritTransactionID and CONVERT(VARCHAR(50),D.APKMaster) = A90.InheritVoucherID
			WHERE M.DeleteFlg = 0 '+@sWhere+'
			Group by  M.DivisionID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, M.TranMonth, M.TranYear, M.LockDate
				, M.Description, M.TotalHoldQuantity, M.TotalAmount, M.FaceValue, M.DividendPerShare
				, M.CreateUserID, M.LastModifyUserID, M.CreateDate, M.LastModifyDate
				, D.ObjectID, A02.ObjectName, A02.Address, A02.Tel, A02.Fax, A02.Email, A02.VATNo
				, S10.ContactIssueDate, S10.ContactIssueBy, S10.IdentificationNumber
				, D.HoldQuantity, D.AmountPayable, D.OrderNo
			Order by M.VoucherDate, M.LockDate, D.OrderNo
		'		
				PRINT (@sSQL)

		EXEC (@sSQL)
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
