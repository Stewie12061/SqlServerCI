IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra xóa màn hình khai báo hạn mức quota
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by BẢO TOÀN on 28/08/2019

CREATE PROCEDURE SOP20503
@DivisionID varchar(3),
@APKLIST_SOT2000 varchar(36),
@Mode tinyint -- 0: Kiểm tra sửa, 1: Xóa
as
begin

	if @Mode = 0
	begin
		--kiểm tra nếu không tồn tại
		if not exists (select 1 from SOT2000 M with (nolock) where M.APK = @APKLIST_SOT2000)
			begin
				select 1 as [Status], '00ML000052' as MessageID, '' Params
			end
		--kiểm tra phát sinh chi tạm ứng
		else if exists (select 1
			from SOT2000 M with (nolock)
				inner join AT9000 R01 with(nolock) on M.EmployeeID = R01.ObjectID
			where 
				M.APK = @APKLIST_SOT2000
				and R01.DebitAccountID like '141%'
				and CAST(M.[Year] as varchar(4)) = FORMAT(R01.VoucherDate,'yyyy')
				)
			begin
				select 2 as [Status], 'SOFML000024' as MessageID, '' Params
			end
		else 
		--kiểm tra hoàn ứng từ dự án
		if exists (select 1 
				from OOT2100 M with(nolock) 
					inner join CRMT20501 R01 with(nolock)  on M.ProjectID = R01.OpportunityID
					inner join SOT2000 R02 with(nolock) on R01.AssignedToUserID = R02.EmployeeID
				where M.DivisionID = @DivisionID
				and R02.APK = @APKLIST_SOT2000 
				and M.GuestCost <> 0
				and CAST(R02.[Year] as varchar(4)) = FORMAT(M.CreateDate,'yyyy')
				)
			begin
				select 2 as [Status], 'SOFML000025' as MessageID, '' Params
			end		
		end

	if @Mode = 1
	begin
		declare @tableAPK table(APK varchar(36))
		insert into @tableAPK(APK)
		select [value]
		from dbo.StringSplit(@APKLIST_SOT2000,',')
		
		--kiểm tra phát sinh chi tạm ứng
		if exists (select 1
			from SOT2000 M with (nolock)
				inner join AT9000 R01 with(nolock) on M.EmployeeID = R01.ObjectID
			where 
				M.APK in (select APK from @tableAPK)
				and R01.DebitAccountID like '141%'
				and CAST(M.[Year] as varchar(4)) = FORMAT(R01.VoucherDate,'yyyy')
				)
			begin
				select 2 as [Status], 'SOFML000024' as MessageID, '' Params
			end
		else 
		--kiểm tra hoàn ứng từ dự án
		if exists (select 1 
				from OOT2100 M with(nolock) 
					inner join CRMT20501 R01 with(nolock)  on M.ProjectID = R01.OpportunityID
					inner join SOT2000 R02 with(nolock) on R01.AssignedToUserID = R02.EmployeeID
				where M.DivisionID = @DivisionID
				and R02.APK in (select APK from @tableAPK) 
				and M.GuestCost <> 0
				and CAST(R02.[Year] as varchar(4)) = FORMAT(M.CreateDate,'yyyy')
				)
			begin
				select 2 as [Status], 'SOFML000025' as MessageID, '' Params
			end
		else
			--Xóa
			begin
				delete from SOT2000 where APK in (select APK from @tableAPK) 
				delete from SOT2001 where APKMaster in (select APK from @tableAPK) 
				select top 0 null as [Status], null as MessageID, '' Params
			end
		end
	end
