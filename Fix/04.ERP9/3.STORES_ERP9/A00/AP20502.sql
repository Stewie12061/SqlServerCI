IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP20502]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP20502]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Lấy hạn mức còn lại của nhân viên sale khi lập phiếu chi (Cảnh báo hạn mức quota)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----SOP20501
-- <History>
----Created by Bảo Toàn on 08/08/2019

-- <Example>
--AP20502 'DTI','HUULOI6','','CNHQ'
CREATE PROC AP20502
@DivisionID varchar(3),
@SaleID varchar(50),
@VoucherNoExpel varchar(50),
@ExpensesID varchar(50)				--Khoản chi (chi tiết)
AS
BEGIN
	--declare @SaleID varchar(50) = 'ANNA'
	--declare @VoucherNoExpel varchar(50) = ''
	--declare @ExpensesID varchar(50) = 'CNHQ'
	--Avariable
	declare @tableResult table(
			APK uniqueidentifier default newid(), 
			SaleID varchar(50),					--Tài khoản nhân viên Sale
			VoucherNo varchar(50),				--Ngày chứng từ phát sinh
			VoucherDate Datetime,				--Ngày chứng từ phát sinh
			ExpensesID varchar(50),				--Khoản chi
			ProjectID varchar(50),				--Mã dự án
			RemainingQuota Decimal(28,8),		--Hạn mức còn lại
			AdvanceCost Decimal(28,8),			--Chi phí đã ứng
			RefundedCost Decimal(28,8),			--Chi phí được hoàn lại khi dự án thành công (Chi phí tiếp khách),
			IsQuota tinyint						--Xác định có phải là hạn mức quota hay không
			)
	declare @fromDate varchar(20) = Cast(YEAR(GetDate()) as varchar(4)) + '0101'
	declare @endDate varchar(20) = Cast(YEAR(GetDate()) as varchar(4)) + '1231'
	
	--Validate
	if exists (select 1 from SOT2001 M with(nolock)  inner join SOT2000 R01 with(nolock) on M.APKMaster = R01.APK where R01.EmployeeID = @SaleID and M.ExpensesID = @ExpensesID)
	begin
		--Xác định đã có hạn mức quota: IsQuota = 1
		insert into @tableResult(APK,VoucherNo,SaleID,VoucherDate,ExpensesID,ProjectID,RemainingQuota,AdvanceCost,RefundedCost )
		exec SOP20501 @DivisionID,@SaleID,@fromDate,@endDate

		update @tableResult set IsQuota = 1

		select IsQuota,SaleID, SUM(ISNULL(RemainingQuota,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) as RemainingQuota
		from @tableResult
		where isnull(VoucherNo,'') <> @VoucherNoExpel or @VoucherNoExpel = ''
		group by IsQuota,SaleID
	end
	else
	begin
		
		--nếu tạm ứng không có chi phí trong hạn mức quota của nhân viên sale
		--trả về IsQuota = 0
		insert into @tableResult(IsQuota,SaleID, RemainingQuota)
		values(0, @SaleID, 0)

		select IsQuota,SaleID, RemainingQuota
		from @tableResult
	end
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
