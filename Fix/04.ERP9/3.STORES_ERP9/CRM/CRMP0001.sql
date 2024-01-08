
if exists (select 1 from sys.objects where [name] = 'CRMP0001' and [type] = 'P')
	drop proc CRMP0001
go

-- <Summary>
--- Load dữ liệu phân quyền nghiệp vụ
-- <Param>
----DivisionID : Đơn vị
----OpportunityID : Mã cơ hội
----UserID : User thao tác
----PageNumber : Số trang
----PageSize : Số dòng trong 1 trang
----ConditionOpportunityID : Phân quyền
-- <Return>
----
-- <Reference>
----	print '/'+REPLACE(@ConditionOpportunityID, ''',''', '/')+'/';
-- <History>
----Created by:Bảo Toàn Date 01/08/2019
-- <Example>


create proc CRMP0001 
@DivisionID varchar(50),
@OpportunityID varchar(50),
@PageSize int,
@PageNumber int,
@ConditionOpportunityID nvarchar(max)
as
begin	
--convert string ConditionOpportunityID, vd: /para1/para2/para3

	declare @ConditionOpportunityString  nvarchar(max) 
	IF Isnull(@ConditionOpportunityID, '') != ''
		SET @ConditionOpportunityString = '/'+REPLACE(@ConditionOpportunityID, ''',''', '/')+'/';

if @OpportunityID <> ''
	begin
		select M.DivisionID, M.VoucherNo,  M.VoucherTypeID, M.Ana02ID as OpportunityID,TableContent into #tb_0001
		from (
		select distinct M.DivisionID, M.VoucherNo,  M.VoucherTypeID, R.Ana02ID, 'OT3101' as TableContent
		from OT3101 M with (nolock)
			inner join OT3102 R with (nolock) on M.ROrderID = R.ROrderID
		where R.Ana02ID = @OpportunityID and @ConditionOpportunityString like '%/'+ISNULL(M.CreateUserID,'')+'/%'
		UNION ALL
		select distinct M.DivisionID, M.VoucherNo, M.VoucherTypeID, R.Ana02ID , 'OT3001' as TableContent
		from OT3001 M with (nolock)
			inner join OT3002 R with (nolock) on M.POrderID = R.POrderID
		where R.Ana02ID = @OpportunityID and @ConditionOpportunityString like '%/'+ISNULL(M.CreateUserID,'')+'/%'
		UNION ALL
		select distinct M.DivisionID, M.QuotationNo as VoucherNo, M.VoucherTypeID, R.Ana02ID , 'OT2101' as TableContent
		from OT2101 M with (nolock)
			inner join OT2102 R with (nolock) on M.QuotationID = R.QuotationID
		where R.Ana02ID = @OpportunityID and @ConditionOpportunityString like '%/'+ISNULL(M.CreateUserID,'')+'/%'
		UNION ALL
		select distinct M.DivisionID, M.VoucherNo, M.VoucherTypeID, R.Ana02ID , 'OT2001' as TableContent
		from OT2001 M with (nolock)
			inner join OT2002 R with (nolock) on M.SOrderID = R.SOrderID
		where R.Ana02ID = @OpportunityID and @ConditionOpportunityString like '%/'+ISNULL(M.CreateUserID,'')+'/%'
		) M
		---Yêu cầu mua hàng - Đơn mua hàng - Phiếu báo giá - Đơn bán hàng
		select ROW_NUMBER() OVER (ORDER BY M.VoucherNo asc) AS RowNum, Count(1) OVER() TotalRow,
				M.APK, M.DivisionID, M.VoucherNo, M.VoucherTypeID, R.VoucherTypeName, M.StatusID, M.AssignedToUserID, M.PermissionUserID, M.OpportunityID, M.TableContent
		from (
			select M.APK, M.DivisionID, M.VoucherNo, M.VoucherTypeID,  M.StatusID, M.AssignedToUserID, M.PermissionUserID, M.OpportunityID, M.TableContent
			from CRMT0001 M with (nolock)
			where M.OpportunityID = @OpportunityID 
				and M.DivisionID = @DivisionID
				and @ConditionOpportunityString like '%/'+ISNULL(M.AssignedToUserID,M.CreateUserID)+'/%'
			UNION all
			select  newid() APK ,M.DivisionID, M.VoucherNo,  M.VoucherTypeID, 0 as StatusID, '' as AssignedToUserID, '' as PermissionUserID, M.OpportunityID, M.TableContent
			from #tb_0001 M 
			where (M.VoucherNo + M.TableContent) not in (
					select M.VoucherNo + M.TableContent
					from CRMT0001 M with (nolock)
					where M.OpportunityID = @OpportunityID and M.DivisionID = @DivisionID
					)
			) M
			inner join AT1007 R with (nolock) on M.VoucherTypeID = R.VoucherTypeID
		where R.DivisionID = @DivisionID
		ORDER BY M.VoucherNo asc
		OFFSET (@PageNumber-1)*@PageSize ROWS 
		FETCH NEXT @PageSize ROWS ONLY
	end
else
	begin
		select ROW_NUMBER() OVER (ORDER BY M.VoucherNo asc) AS RowNum, Count(1) OVER() TotalRow,
				M.APK, M.DivisionID, M.VoucherNo, M.VoucherTypeID,R.VoucherTypeName,  M.StatusID, M.AssignedToUserID, M.PermissionUserID, M.OpportunityID, M.TableContent
		from CRMT0001 M with (nolock)
			inner join AT1007 R with (nolock) on M.VoucherTypeID = R.VoucherTypeID
		where M.DivisionID = @DivisionID
		ORDER BY M.VoucherNo asc
		OFFSET (@PageNumber-1)*@PageSize ROWS 
		FETCH NEXT @PageSize ROWS ONLY
	end
end