IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Hàm kiểm tra số lượng cổ phần còn lại của trên đợt phát hành tới thời điểm hiện tại
---- Hàm kiểm tra số lượng cổ phần còn lại của trên sổ cổ đông tới thời điểm hiện tại
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng vũ , Date: 23/10/2018
-- <Example> EXEC SHMP2034 'BS', '', '', '2019-10-26', 1, 0, NULL

CREATE PROCEDURE SHMP2034  
(	
	 @DivisionID varchar(50),
	 @UserID varchar(50),
	 @SHPublishPeriodOrObjectID Varchar(50),--Đợt phát hành hoặc Cổ đông
	 @VoucherDate Datetime,						
	 @TransactionTypeID int,				--1: Đăng ký mua cổ phần; 2: Chuyển nhượng
	 @IsTypeID int,							--0: Thêm mới phiếu; 1: Sửa phiếu
	 @APK UNIQUEIDENTIFIER					--NULL: Thêm mới; NOTNULL: Sửa
	 
 )  
AS  
BEGIN  
	IF @IsTypeID = 0 --Trường hợp thêm phiếu mới
	Begin
		IF @TransactionTypeID = 1 --Đăng ký mua cổ phần
		Begin
			 SELECT D.ShareTypeID, S10.ShareTypeName, D.UnitPrice, ISNULL(D.Quantity, 0) - ISNULL(Ref.QuantityApproved, 0) as CloseQuantity
			 FROM SHMT1020 M WITH (NOLOCK) 
							 INNER JOIN SHMT1021 D WITH (NOLOCK) on M.APK = D.APKMaster
							 LEFT JOIN (
										SELECT M.SHPublishPeriodID, D.ShareTypeID, SUM(ISNULL(D.QuantityApproved, 0)) as QuantityApproved
										FROM SHMT2020 M WITH (NOLOCK) INNER JOIN SHMT2021 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										WHERE M.DeleteFlg = 0 and M.SHPublishPeriodID = @SHPublishPeriodOrObjectID and M.VoucherDate <= @VoucherDate
										GROUP BY M.DivisionID, M.SHPublishPeriodID, D.ShareTypeID
									   ) Ref on Ref.SHPublishPeriodID = M.SHPublishPeriodID and Ref.ShareTypeID = D.ShareTypeID
							 LEFT JOIN SHMT1010 S10 WITH (NOLOCK) on D.ShareTypeID = S10.ShareTypeID
			 WHERE M.DivisionID in (@DivisionID, '@@@') and M.Disabled = 0 and M.SHPublishPeriodID = @SHPublishPeriodOrObjectID and ISNULL(D.Quantity, 0) - ISNULL(Ref.QuantityApproved, 0) > 0
			 Order by D.ShareTypeID
		end

		IF @TransactionTypeID = 2 --Chuyển nhượng
		Begin
			SELECT D.ShareTypeID, S10.ShareTypeName, S10.UnitPrice, Sum(ISNULL(D.IncrementQuantity, 0)) - Sum(ISNULL(D.DecrementQuantity, 0)) as CloseQuantity
			FROM SHMT2010 M WITH (NOLOCK) Inner join SHMT2011 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
						Left join SHMT1010 S10 WITH (NOLOCK) ON  D.ShareTypeID = S10.ShareTypeID
			WHERE M.DeleteFlg = 0 and M.ObjectID = @SHPublishPeriodOrObjectID and D.TransactionDate <=@VoucherDate
			Group by D.ShareTypeID, S10.ShareTypeName, S10.UnitPrice
			Having Sum(ISNULL(D.IncrementQuantity, 0)) - Sum(ISNULL(D.DecrementQuantity, 0)) > 0
			Order by D.ShareTypeID
		end
		
	End

	IF @IsTypeID = 1 --Trường hợp sửa phiếu cũ
	Begin
		IF @TransactionTypeID = 1 --Đăng ký mua cổ phần
		Begin
			 SELECT D.ShareTypeID, S10.ShareTypeName, D.UnitPrice, ISNULL(D.Quantity, 0) - ISNULL(Ref.QuantityApproved, 0) as CloseQuantity
			 FROM SHMT1020 M WITH (NOLOCK) 
							 INNER JOIN SHMT1021 D WITH (NOLOCK) on M.APK = D.APKMaster
							 LEFT JOIN (
										SELECT M.SHPublishPeriodID, D.ShareTypeID, SUM(ISNULL(D.QuantityApproved, 0)) as QuantityApproved
										FROM SHMT2020 M WITH (NOLOCK) INNER JOIN SHMT2021 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										WHERE M.DeleteFlg = 0 and M.SHPublishPeriodID = @SHPublishPeriodOrObjectID and M.VoucherDate <= @VoucherDate and M.APK != @APK
										GROUP BY M.DivisionID, M.SHPublishPeriodID, D.ShareTypeID
									   ) Ref on Ref.SHPublishPeriodID = M.SHPublishPeriodID and Ref.ShareTypeID = D.ShareTypeID
							LEFT JOIN SHMT1010 S10 WITH (NOLOCK) on D.ShareTypeID = S10.ShareTypeID
			 WHERE M.DivisionID in (@DivisionID, '@@@') and M.Disabled = 0 and M.SHPublishPeriodID = @SHPublishPeriodOrObjectID and ISNULL(D.Quantity, 0) - ISNULL(Ref.QuantityApproved, 0) > 0
			 Order by D.ShareTypeID
		End

		IF @TransactionTypeID = 2 --Chuyển nhượng
		BEGIN
			SELECT D.ShareTypeID, S10.ShareTypeName, S10.UnitPrice, SUM(ISNULL(D.IncrementQuantity, 0)) - SUM(ISNULL(D.DecrementQuantity, 0)) as CloseQuantity
			FROM SHMT2010 M WITH (NOLOCK) 
			INNER JOIN SHMT2011 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
			LEFT JOIN SHMT1010 S10 WITH (NOLOCK) ON  D.ShareTypeID = S10.ShareTypeID
			WHERE M.DeleteFlg = 0 and M.ObjectID = @SHPublishPeriodOrObjectID 
				AND CONVERT(DATE,D.TransactionDate) <= @VoucherDate
				AND ISNULL(D.APKMInherited,'00000000-0000-0000-0000-000000000000') <> @APK -- Loại trừ chính nó
			GROUP BY D.ShareTypeID, S10.ShareTypeName, S10.UnitPrice
			HAVING SUM(ISNULL(D.IncrementQuantity, 0)) - SUM(ISNULL(D.DecrementQuantity, 0)) > 0
			Order by D.ShareTypeID
		End
	End
	
END  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
