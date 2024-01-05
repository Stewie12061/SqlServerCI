IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy danh sách nhân viên vượt hạn mức, gồm các thông tin: 
----    + Họ tên
----    + Hạn mức đầu năm
----    + Hạn mức được cấp.
----    + Chi phí đã chi
----    + Chi phí tiếp khách
----    + Hạn mức còn lại
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Source
-- <History>
----Created by Bảo Toàn on 30/08/2019
----Updated by Văn Tài  on 17/06/2021 - Bổ sung lại điều kiện vượt hạn mức.
----Updated by Văn Tài  on 27/07/2021 - Bổ sung điều kiện phiếu báo giá đã duyệt.

-- <Example>
-- SOP20504 'DTI' , 'HUULOI'
CREATE PROC SOP20504
			@DivisionID VARCHAR(50),
			@UserID VARCHAR(50),
			@PageNumber INT,
			@PageSize INT,
			@ExistsOverQuota BIT = 0 OUTPUT,
			@MessageWarring NVARCHAR(MAX) = '' OUTPUT
AS
BEGIN
	--Declare
	DECLARE @fromDate DATE = CAST(YEAR(GETDATE()) AS VARCHAR(4)) +'0101'
	DECLARE @toDate DATETIME = GETDATE()
	DECLARE @yearCurrent INT = YEAR(GETDATE())
	DECLARE @objectTypeID VARCHAR(50) = 'NV' -- Loại đối tượng là nhân viên ('NV')
	DECLARE @isSale TINYINT = 0
	DECLARE @dataID VARCHAR(50) = 'QuotaID' -- Khai báo loại dữ liệu
	DECLARE @Conditions VARCHAR(MAX)

	--Khởi tạo bảng
	DECLARE @tableResult TABLE(
		SaleID VARCHAR(50),	
		Beginning DECIMAL(28,8),			--Hạn mức đầu năm
		GrantedQuota DECIMAL(28,8),			--Hạn mức được cấp
		AdvanceCost DECIMAL(28,8),			--Chi phí đã ứng
		RefundedCost DECIMAL(28,8),			--Chi phí được hoàn lại khi dự án thành công (Chi phí tiếp khách)
		RemainingQuota DECIMAL(28,8),		--Hạn mức còn lại
		UserManagerID VARCHAR(50)			--Người quản lý
		)
	
	--Lấy danh sách nhân viên thuộc quyền quản lý
	DECLARE @tableUserByManager TABLE (EmployeeID VARCHAR(50))
	
	--[UPDATE 26/03/2020: lẤY THEO PHÂN QUYỀN VAI TRÒ]
	DECLARE @tmp_Condition TABLE(DataType VARCHAR(50), Condition VARCHAR(MAX))     
    INSERT INTO @tmp_Condition 
    EXEC SP10504 @DivisionID = @DivisionID, @UserID = @UserID, @DataID = @dataID

	SELECT TOP 1 @Conditions = Condition 
	FROM @tmp_Condition

	INSERT INTO @tableUserByManager(EmployeeID)
	SELECT * 
	FROM dbo.StringSplit(@Conditions, ',')

	--[NẾU USER LÀ NHÂN VIÊN]
	IF NOT EXISTS (SELECT 1 FROM @tableUserByManager)
	BEGIN
		INSERT INTO @tableUserByManager(EmployeeID)
		VALUES (@UserID)

		SET @isSale = 1
	END

	--Lấy danh sách các nhân viên có khai báo hạn mức quota trong năm
	INSERT INTO @tableResult(SaleID,Beginning,GrantedQuota)
	SELECT M.EmployeeID, M.Beginning, M.TotalQuota
	FROM SOT2000 M WITH (NOLOCK) 
		INNER JOIN @tableUserByManager R01 ON M.EmployeeID = R01.EmployeeID
	WHERE M.[YEAR] = @yearCurrent and M.DivisionID = @DivisionID

	--Get chi phí phiếu chi
	INSERT INTO @tableResult(SaleID,AdvanceCost)
	SELECT M.ObjectID,M.ConvertedAmount 
	FROM AT9000 M WITH(NOLOCK) 
		INNER JOIN (SELECT SaleID EmployeeID
					FROM @tableResult ) R01 ON M.ObjectID = R01.EmployeeID 
					WHERE M.DivisionID = @DivisionID 
						AND VoucherDate between @fromDate and @toDate 
						AND M.DebitAccountID like '141%'

	--Hoàn lại Chi phí tiếp khách từ dự án
	INSERT INTO @tableResult(SaleID,RefundedCost)
	SELECT R01.SalesManID, ISNULL(M.GuestsCost, 0) + ISNULL(M.SurveyCost,0)
	from SOT2062 M with(nolock) 
		inner join OT2101 R01 with(nolock) on M.APK_OT2101 = R01.APK
		inner join OOT2100 R02 with(nolock) on R01.OpportunityID = R02.ProjectID
		inner join @tableUserByManager R03 on R01.SalesManID = R03.EmployeeID
	where R01.ClassifyID = 'SALE'
		and R01.DivisionID = @DivisionID
		and (M.GuestsCost <> 0 or M.SurveyCost <> 0)
		and R01.OrderStatus = 1 -- Duyệt
		and R01.QuotationStatus = 3 -- Hoàn tất
		and R01.CreateDate between @fromDate and @toDate

	--[NẾU USER LÀ QUẢN LÝ SẼ THẤY NHÂN VIÊN SALE VƯỢT HẠN MỨC]

	if @isSale = 0
	begin
		--convert table
		select ROW_NUMBER() OVER (ORDER BY R01.ObjectName) RowNum, COUNT(1) OVER() TotalRow 
				, SaleID, R01.ObjectName as SaleName, Beginning, GrantedQuota, AdvanceCost,RefundedCost, RemainingQuota
		from (
		select SaleID
				, SUM(Beginning) Beginning
				, SUM(GrantedQuota) GrantedQuota
				, SUM(AdvanceCost) AdvanceCost
				, SUM(RefundedCost) RefundedCost
				, SUM(ISNULL(GrantedQuota,0) - ISNULL(Beginning,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) RemainingQuota
		from @tableResult 
		group by SaleID
		-- [17/06/2021] Văn Tài - Mở lại điều kiện kiểm tra.
		having SUM(ISNULL(GrantedQuota,0) - ISNULL(Beginning,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) < 0
		) M
		inner join (select ObjectID, ObjectName
				from AT1202 with (nolock)
				where ObjectTypeID = @objectTypeID) R01 on M.SaleID = R01.ObjectID	
		order by R01.ObjectName
		offset (@PageNumber-1) * @PageSize rows
		fetch next @PageSize rows ONLY

		set @ExistsOverQuota = @@RowCount
	end
	
	--[NẾU USER LÀ NHÂN VIÊN SALE SẼ THẤY TÌNH HÌNH SỬ DỤNG]
	if @isSale = 1
	begin
		--convert table
		select ROW_NUMBER() OVER (ORDER BY R01.ObjectName) RowNum, COUNT(1) OVER() TotalRow 
				, SaleID, R01.ObjectName as SaleName, Beginning, GrantedQuota, AdvanceCost,RefundedCost, RemainingQuota
		from (
		select SaleID
				, SUM(Beginning) Beginning
				, SUM(GrantedQuota) GrantedQuota
				, SUM(AdvanceCost) AdvanceCost
				, SUM(RefundedCost) RefundedCost
				, SUM(ISNULL(GrantedQuota,0) - ISNULL(Beginning,0) - ISNULL(AdvanceCost,0) + ISNULL(RefundedCost,0)) RemainingQuota
		from @tableResult 
		group by SaleID
		) M
		inner join (select ObjectID, ObjectName
				from AT1202 with (nolock)
				where ObjectTypeID = @objectTypeID) R01 on M.SaleID = R01.ObjectID	
		order by R01.ObjectName
		offset (@PageNumber-1) * @PageSize rows
		fetch next @PageSize rows ONLY

		set @ExistsOverQuota = @@RowCount
	end 
	if @isSale = 0
	begin
		SET @MessageWarring = N'Danh sách nhân viên sale vượt hạn mức'
	end
	else
	begin
		SET @MessageWarring = N'Tình hình hạn mức Quota'
	end
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
