if exists(select 1 from sys.objects where [name] = 'BP3024' and [type] = 'P')
	drop proc BP3024
go

-- <Summary>
--- Load data báo cáo chi tiết chi phí dự án
-- <Param>
----DivisionID : Đơn vị
----ProjectID : Mã dự án
-- <Return>
----
-- <Reference>
----	
-- <History>
----Created by:Bảo Toàn Date 10/08/2019
-- <Example>
--- BP3018 'DTI', 'A001.A01'
create proc BP3024
@Division varchar(3),
@ProjectID varchar(50)
as
begin
	--Lấy dữ liệu tổng hợp 
	select R01.ProjectID,M.AnaDepartmentID , M.CostGroup, M.CostGroupDetail
	,M.[Money], R02.OriginalAmount as [RealityCost]
	into #tableSource
	from OOT2141 M with(nolock) 
		inner join OOT2140 R01 with(nolock)  on M.APKMaster = R01.APK
		left join (
			select Ana03ID,Ana04ID, Ana07ID, SUM(OriginalAmount) as OriginalAmount
			from AT9000 with(nolock) 
			where Ana01ID = @ProjectID
			group by Ana03ID,Ana04ID, Ana07ID
			) R02 on M.CostGroup = R02.Ana03ID
			and M.CostGroupDetail = R02.Ana04ID
			and M.AnaDepartmentID = R02.Ana07ID
	where R01.ProjectID = @ProjectID and R01.DivisionID = @Division
	
	-- Chuẩn hóa dữ liệu theo group
	select ROW_NUMBER() OVER(ORDER BY ProjectID,AnaDepartmentID , CostGroup, CostGroupDetail) as STT
			, cast('' as varchar(10)) STTCaption
			, *
			, cast(0 as bit) IsUpdate into #temp
	from (
	select  ProjectID,AnaDepartmentID, '' CostGroup,'' CostGroupDetail, AnaDepartmentID as [Desciption]
		, SUM([Money]) AS [Money]
		, SUM([RealityCost]) AS [RealityCost]
	from #tableSource
	group by ProjectID,AnaDepartmentID

	union all

	select ProjectID, AnaDepartmentID , CostGroup,'' CostGroupDetail,CostGroup as [Desciption]
		, SUM([Money]) AS [Money]
		, SUM([RealityCost]) AS [RealityCost]
	from #tableSource
	group by ProjectID,AnaDepartmentID ,CostGroup

	union all
	select ProjectID,AnaDepartmentID ,CostGroup,CostGroupDetail, CostGroupDetail as [Desciption]
		, SUM([Money]) AS [Money]
		, SUM([RealityCost]) AS [RealityCost]
	from #tableSource
	group by ProjectID,AnaDepartmentID , CostGroup, CostGroupDetail
	) M
	order by ProjectID,AnaDepartmentID , CostGroup, CostGroupDetail

	--format dữ liệu hiển thị
	declare @STT int = 0
	declare @tck_1 varchar(10), @tck_2 varchar(10), @tck_3 varchar(10)
	while exists(select 1 from #temp where IsUpdate = 0)
	begin
		--set @tck_1 = null
		select top 1 @STT = STT from #temp where  IsUpdate = 0 order by STT
		if exists(select 1 from #temp where STT=@STT and isnull(CostGroup,'') = '' and isnull(CostGroupDetail,'') = '')
			begin
				if (isnull(@tck_1,'')='')
					begin
						set @tck_1 = '1'
				
					end
				else
					begin
						set @tck_1 = @tck_1 + 1					
					end
				set @tck_2 = null
				set @tck_3 = null
			end
	
		else if exists(select 1 from #temp where STT=@STT and isnull(CostGroup,'') <> '' and isnull(CostGroupDetail,'') = '')
			begin
				if (isnull(@tck_2,'')='')
					begin
						set @tck_2 = '1'
					
					end
				else
					begin
						set @tck_2 = @tck_2 + 1				
					end
				set @tck_3 = null
			end
		else if exists(select 1 from #temp where STT=@STT and isnull(CostGroup,'') <> '' and isnull(CostGroupDetail,'') <> '')
			if (isnull(@tck_3,'')='')
				begin
					set @tck_3 = '1'
				end
			else
				begin
					set @tck_3 = @tck_3 + 1
				end

		update #temp 
		set IsUpdate = 1 
			, STTCaption = @tck_1 
							+ case when ISNULL(@tck_2,'') <> '' then '.'+@tck_2 else '' end
							+ case when ISNULL(@tck_3,'') <> '' then '.'+@tck_3 else '' end 
		where STT = @STT
	end

	declare @STRING_SPACE1 varchar(10) = SPACE(3)
	declare @STRING_SPACE2 varchar(10) = SPACE(6)
	select case when LEN(STTCaption) = 3
						then @STRING_SPACE1+STTCaption					
					else case when LEN(STTCaption) = 5
							then @STRING_SPACE2+STTCaption
						else STTCaption
						end
					end
					as STTCaption
			, case when LEN(STTCaption) = 1 then R01.AnaName else '' end as DepartmentName
			, case when LEN(STTCaption) = 3
						then +R01.AnaName					
					else case when LEN(STTCaption) = 5
							then @STRING_SPACE1+R01.AnaName
						else ''
						end
					end
					as Desciption
			, M.[Money]
			, RealityCost
			, isnull([Money],0) - isnull([RealityCost],0) as DifferenceCost
	from #temp M 
		inner join AT1011 R01 with (nolock) on R01.AnaID = M.Desciption
	order by STT
end