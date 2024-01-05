if exists(select 1 from sys.objects where [name] = 'AP20501' and [type] = 'P')
	drop proc AP20501
go

-- <Summary>
--- Lấy chi phí khả dụng còn lại so với định mức dự án (Cảnh báo chi vực định mức dự án)
-- <Param>
----DivisionID : Đơn vị
----ProjectID : Mã dự án
-- <Return>
----
-- <Reference>
----	
-- <History>
----Created by:Bảo Toàn Date 15/08/2019
-- <Example>
--- AP20501 'DTI', 'CH002','QH','CPHQ','TNK',''
create proc AP20501
@Division varchar(3),
@ProjectID varchar(50),
@AnaDepartmentID varchar(50),
@Ana03ID varchar(50),
@Ana04ID varchar(50),
@VoucherNo varchar(50)
as
begin
	
	select R01.DivisionID ,R01.ProjectID, isnull(M.[ActualMoney],0) - isnull(R02.OriginalAmount,0) as RemainingCost
	from OOT2141 M with(nolock) 
		inner join OOT2140 R01 with(nolock)  on M.APKMaster = R01.APK
		left join (
			select Ana03ID,Ana04ID, Ana07ID, SUM(OriginalAmount) as OriginalAmount
			from AT9000 with(nolock) 
			where Ana01ID = @ProjectID AND DivisionID = @Division
				and VoucherNo <> @VoucherNo or @VoucherNo = ''
			group by Ana03ID,Ana04ID, Ana07ID
			) R02 on M.CostGroup = R02.Ana03ID
			and M.CostGroupDetail = R02.Ana04ID
			and M.AnaDepartmentID = R02.Ana07ID
	where R01.ProjectID = @ProjectID and R01.DivisionID = @Division
		and M.AnaDepartmentID = @AnaDepartmentID
		and M.CostGroup = @Ana03ID
		and M.CostGroupDetail = @Ana04ID
end

