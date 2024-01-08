IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load data báo cáo theo dõi hạn mức quota
-- <Param>
----DivisionID : Đơn vị
----ProjectID : Mã dự án
-- <Return>
----
-- <Reference>
----Kế thừa SOP20501
-- <History>
----Created by:Bảo Toàn Date 13/08/2019
-- <Example>
--- BP3019 'DTI', 'HUULOI6','20190801','20190831' 
--- BP3019 'DTI', 'HUULOI6','20190101','20190831' , AP20502 'DTI', 'HUULOI6' , '' ,'CNHQ'
create proc BP3025
@DivisionID varchar(3),
@SaleID varchar(50),
@FromDate datetime,
@EndDate datetime
as
begin
	declare @tableResult table(
		APK uniqueidentifier default newid(), 
		SaleID varchar(50),					--Tài khoản nhân viên Sale
		VoucherNo varchar(50),				--Ngày chứng từ phát sinh
		VoucherDate Datetime,				--Ngày chứng từ phát sinh
		ExpensesID varchar(50),				--Khoản chi
		ProjectID varchar(50),				--Mã dự án
		RemainingQuota Decimal(28,8),		--Hạn mức còn lại
		AdvanceCost Decimal(28,8),			--Chi phí đã ứng
		RefundedCost Decimal(28,8),			--Chi phí được hoàn lại khi dự án thành công (Chi phí tiếp khách)
		VATCost  Decimal(28,8)				--Chi phí tiếp khách có hóa đơn
		)
	insert into @tableResult(APK,VoucherNo,SaleID,VoucherDate,ExpensesID,ProjectID,RemainingQuota,AdvanceCost,RefundedCost )
	exec SOP20501 @DivisionID, @SaleID,@FromDate,@EndDate 

	--convert table
	select ROW_NUMBER() over (order by VoucherDate ) STT, APK,VoucherNo,SaleID,VoucherDate,ExpensesID,ProjectID
			,AdvanceCost,RefundedCost,RemainingQuota, VATCost
		into #tableMain
	from @tableResult	
	order by VoucherDate

	--loop => tính hạn mức còn lại (RemainingQuota)	
	declare @REMAINING_COST decimal(28,8) = 0
	select top 1 @REMAINING_COST = RemainingQuota from #tableMain 
	declare @STT_COUNT int = 2
	while exists (select 1 from #tableMain where STT = @STT_COUNT)
	begin
		update #tableMain
		set RemainingQuota = @REMAINING_COST - isnull(AdvanceCost,0) + isnull(RefundedCost,0)
		where STT = @STT_COUNT

		select @REMAINING_COST = RemainingQuota from #tableMain where  STT = @STT_COUNT
		set @STT_COUNT = @STT_COUNT + 1
	end

	select M.EmployeeID, R01.FullName, M.Beginning, M.TotalQuota
	from SOT2000 M with(nolock) 
		left join AT1103 R01 with(nolock) on M.EmployeeID = R01.EmployeeID
	where M.EmployeeID = @SaleID and [Year] = YEAR(@EndDate)

	--tính chi phí tiếp khách có hóa đơn
	select VoucherDate,ProjectID
	,AdvanceCost
	,RefundedCost
	,RemainingQuota
	,VATCost
	from (
		select VoucherDate,ProjectID
			,AdvanceCost,RefundedCost,RemainingQuota, VATCost
		from #tableMain
		union all
		select M.VoucherDate,M.Ana02ID
			,null
			,null
			,null
			,M.ConvertedAmount
		from AT9000 M with(nolock)
		where 
			M.CreditObjectID = @SaleID and
			M.CreditAccountID like '141%' and
			M.DebitAccountID not like '133%' and
			isnull(M.VATTypeID,'') <> '' and
			M.VoucherDate between @FromDate and @EndDate 
	) M
	--group by VoucherDate,ProjectID
	order by VoucherDate 
end

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
