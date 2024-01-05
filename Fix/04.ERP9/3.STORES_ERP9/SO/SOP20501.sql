GO
IF EXISTS (SELECT * FROM sys.objects where [name] = 'SOP20501' and [type] = 'P')
	DROP PROC SOP20501
go
-- <Summary>
---- Lấy dư dầu, phát sinh quota trong một khoản thời gian báo cáo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Source
-- <History>
----Created by Bảo Toàn on 08/08/2019

-- <Example>
CREATE PROC SOP20501
@DivisionID varchar(3),
@SaleID varchar(50),
@FromDate datetime,
@EndDate datetime
AS
BEGIN
	
	declare @tableResult table(
		APK uniqueidentifier default newid(), 
		SaleID varchar(50),								--Tài khoản nhân viên Sale
		VoucherNo varchar(50),							--Ngày chứng từ phát sinh
		VoucherDate Datetime,							--Ngày chứng từ phát sinh
		ExpensesID varchar(50),							--Khoản chi
		ProjectID varchar(50),							--Mã dự án
		RemainingQuota Decimal(28,8),		--Hạn mức còn lại
		AdvanceCost Decimal(28,8),			--Chi phí đã ứng
		RefundedCost Decimal(28,8)			--Chi phí được hoàn lại khi dự án thành công (Chi phí tiếp khách)
		)
	--stadand endDate 
	set @EndDate = DATEADD(Second,-1, DATEADD(DAY,1, convert(datetime,convert(date,@EndDate))))

	select SaleID,RemainingQuota  into #tableRemaining from @tableResult
		--Get dư đầu
		insert into #tableRemaining(SaleID, RemainingQuota)
		select EmployeeID,ISNULL(TotalQuota,0) - ISNULL(Beginning,0)
		from SOT2000 with(nolock)  
		where DivisionID = @DivisionID
				and EmployeeID = @SaleID
				and [Year] = YEAR(@FromDate)
		--Get chi phí phiếu chi (tính lại số dư theo móc thời gian)
		insert into #tableRemaining(SaleID,RemainingQuota)
		select M.ObjectID,-M.OriginalAmount 
		from AT9000 M with(nolock) 
		left join (select R01.EmployeeID, M.ExpensesID
					from SOT2001 M with(nolock)  
					inner join SOT2000 R01 with(nolock) on M.APKMaster = R01.APK 
					where R01.EmployeeID = @SaleID ) R01 on M.ObjectID = R01.EmployeeID and M.Ana04ID = R01.ExpensesID
		where M.DivisionID = @DivisionID 
			and	M.ObjectID = @SaleID 
			and M.VoucherDate < @FromDate 
			and M.DebitAccountID like '141%'

		--Hoàn lại Chi phí tiếp khách từ dự án (tính lại số dư theo móc thời gian)
		insert into #tableRemaining(SaleID,RemainingQuota)
		select R01.SalesManID, isnull(M.GuestsCost,0)+isnull(M.SurveyCost,0)
		from SOT2062 M with(nolock) 
			inner join OT2101 R01 with(nolock) on M.APK_OT2101 = R01.APK
			inner join OOT2100 R02 with(nolock) on R01.OpportunityID = R02.ProjectID
		where R01.ClassifyID = 'SALE'
			and R01.DivisionID = @DivisionID
			and R01.SalesManID = @SaleID
			and (M.GuestsCost <> 0 or M.SurveyCost <> 0)
			and R01.CreateDate < @FromDate
	
	insert into @tableResult(SaleID,RemainingQuota)
	select SaleID,SUM(RemainingQuota) as RemainingQuota
	from #tableRemaining
	group by SaleID

	--Get chi phí phiếu chi
	insert into @tableResult(SaleID,VoucherNo,VoucherDate,ExpensesID,ProjectID,AdvanceCost)
	select M.ObjectID,M.VoucherNo,M.VoucherDate,M.Ana04ID,M.Ana02ID,M.ConvertedAmount 
	from AT9000 M with(nolock) 
		inner join (select R01.EmployeeID, M.ExpensesID
					from SOT2001 M with(nolock)  
					inner join SOT2000 R01 with(nolock) on M.APKMaster = R01.APK 
					where R01.EmployeeID = @SaleID ) R01 on M.ObjectID = R01.EmployeeID and M.Ana04ID = R01.ExpensesID
		where M.DivisionID = @DivisionID 
			and M.ObjectID = @SaleID 
			and VoucherDate between @FromDate and @EndDate 
			and M.DebitAccountID like '141%'

	--Hoàn lại Chi phí tiếp khách từ dự án
	insert into @tableResult(SaleID,VoucherNo,VoucherDate,ProjectID,RefundedCost)	
	select R01.SalesManID,R01.QuotationNo,R01.QuotationDate, R02.ProjectID, isnull(M.GuestsCost,0)+isnull(M.SurveyCost,0)
		from SOT2062 M with(nolock) 
			inner join OT2101 R01 with(nolock) on M.APK_OT2101 = R01.APK
			inner join OOT2100 R02 with(nolock) on R01.OpportunityID = R02.ProjectID
		where R01.ClassifyID = 'SALE'
			and R01.DivisionID = @DivisionID
			and R01.SalesManID = @SaleID
			and (M.GuestsCost <> 0 or M.SurveyCost <> 0)
			and R01.CreateDate between @FromDate and @EndDate
	--convert table
	select APK,VoucherNo,SaleID,VoucherDate,ExpensesID,ProjectID,RemainingQuota,AdvanceCost,RefundedCost
	from @tableResult	
	order by VoucherDate

END