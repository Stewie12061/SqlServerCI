IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP20531]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].EDMP20531
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lấy danh sách phiếu dự thu sắp đến ngày dự thu, gồm các thông tin: 
----    + Ngày dự thu
----    + Mã khối
----    + Mã lớp
----    + Mã biếu phí
----    + Mô tả
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Source
-- <History>
----Created by Đình Hòa on 05/06/2020

-- <Example>
-- SOP20531 'BE' , ''
CREATE PROC EDMP20531
@DivisionID varchar(50),
@UserID varchar(50),
@PageNumber int,
@PageSize int,
@TxtSearch nvarchar(max),
@IsNotification bit = 0 output 
AS
BEGIN
	--Declare
	declare @dateCurent datetime = GETDATE()
	declare @dateSetting int = 0
	declare @rowCount int = 0
	
	--Khởi tạo bảng
	declare @tableResult table(
		StudentId varchar(50),         --Mã học sinh
		StudentName nvarchar(max),		-- Tên học sinh
		ParentID VARCHAR(25),			--Mã phụ huynh
		ParentName NVARCHAR(250),		--Tên phụ huynh
		Telephone VARCHAR(25),			--Số điện thoại			
		GradeID varchar(50),			    --Mã khối 
		ClassID varchar(50),			--Mã lớp
		EstimateID varchar(50),			    
		EstimateDate datetime)		--Ngày dự thu
		

	--Lấy ngày đã được thiết lập
	set @dateSetting = (select DatePay from EDMT0000 with (nolock) where DivisionID = @DivisionID)

	--Kiếm tra có thiết lập ngày thông báo hay không.
	if @dateSetting > 0
	begin
		--Get danh sách các học sinh sắp đến ngày đóng phí
		select ROW_NUMBER() OVER (ORDER BY D.StudentID) RowNum, COUNT(1) OVER() TotalRow 
				,D.StudentID, D.StudentName, D.ParentID, D.ParentName, D.Telephone, A.GradeID, A.ClassID ,A.EstimateID, A.EstimateDate 
		from EDMT2160 A inner join EDMT2161 B on A.APK = B.APKMaster 
						inner join EDMT2013 C on B.StudentID = C.StudentID 
						inner join EDMT2000 D on C.InheritAPK = D.APK
		where A.CreateUserID = @UserID 
				AND  FORMAT(A.EstimateDate,'yyyyMMdd') = FORMAT(DateAdd(day,@dateSetting,@dateCurent),'yyyyMMdd') 
				AND A.DeleteFlg = '0' AND NOT EXISTS (select 1 from AT9000 where InheritVoucherID = CAST(A.APK as varchar(50)))
				AND @TxtSearch IN ('',D.StudentID, D.StudentName, D.ParentID, D.ParentName, D.Telephone, A.GradeID, A.ClassID ,A.EstimateID, CONVERT(VARCHAR(20),A.EstimateDate,103))

		select @rowCount = @@ROWCOUNT
	end

	if @rowCount > 0
		begin 
			set @IsNotification = 1
		end
	else
		begin
			set @IsNotification = 0
		end
END

GO
DECLARE @isNotification bit
EXECUTE EDMP20531 'BE','ASOFTADMIN',1,1,'', @isNotification OUTPUT
PRINT @isNotification
--select CONVERT(VARCHAR(20),getdate(),103)
--begin tran
--exec sp_executesql N'EXEC EDMP20531 @DivisionID=N''BE'',@UserID=N''AS0097'',@PageNumber=N''1'',@PageSize=N''25'',@TxtSearch=N''''',N'@CreateUserID nvarchar(6),@LastModifyUserID nvarchar(6),@DivisionID nvarchar(2)',@CreateUserID=N'AS0097',@LastModifyUserID=N'AS0097',@DivisionID=N'BE'
--rollback