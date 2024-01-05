GO
IF EXISTS (SELECT * FROM sys.objects where [name] = 'SOP20502' and [type] = 'P')
	DROP PROC SOP20502
go
-- <Summary>
---- Lấy hạn mức nợ còn lại năm trước của nhân viên sale
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----SOP20501
-- <History>
----Created by Bảo Toàn on 13/08/2019

-- <Example>
--SOP20502 'DTI','BAOTOAN','2020'
CREATE PROC SOP20502
@DivisionID varchar(3),
@SaleID varchar(50),
@Year int
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
			RefundedCost Decimal(28,8)			--Chi phí được hoàn lại khi dự án thành công (Chi phí tiếp khách),
			
			)
	declare @fromDate varchar(20) = Cast((@Year - 1) as varchar(4)) + '0101'
	declare @endDate varchar(20) = Cast((@Year - 1) as varchar(4)) + '1231'
	--Validate
	insert into @tableResult(APK,VoucherNo,SaleID,VoucherDate,ExpensesID,ProjectID,RemainingQuota,AdvanceCost,RefundedCost )
	exec SOP20501 @DivisionID,@SaleID,@fromDate,@endDate

	select SaleID
	, case when SUM(ISNULL(RemainingQuota,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) < 0
			then ABS(SUM(ISNULL(RemainingQuota,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)))
			else case when SUM(ISNULL(RemainingQuota,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) > 0
			then cast(0 as decimal(28,8)) end
	end as RemainingQuota
	from @tableResult
	group by SaleID
END

