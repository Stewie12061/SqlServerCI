

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'GetStatusQualityOfWork') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION GetStatusQualityOfWork
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

-- <Summary>
---- Lấy  ID ra để phát hành hóa đơn điện tử
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Hoài Phong on 09/03/2021  
----Created by Hoài Phong on 21/03/2021  Bổ sung thêm điều kiện , Kiểm tra có gói hợp đồng hay không  
-- <Example>
---select [dbo].GetStatusQualityOfWork('2021-03-13',null,'')
-- <Example>

CREATE FUNCTION [dbo].[GetStatusQualityOfWork](	
	@DeadlineRequest DATETIME ,
	@ActualEndDate DATETIME ,
	@StatusQualityOfWork NVARCHAR(80),
	@AccountID NVARCHAR(80),
	@StatusID NVARCHAR(80)	
)
RETURNS VARCHAR(80)
BEGIN
-- trạng thứ chưa xử lý , trạng thái hoàn thành thì để null,
 SET @AccountID=(Select TOP 1  isnull(ContractPackageID,'') from AT1020 where ObjectID=@AccountID  and ContractPackageID is not null)
if (@AccountID is null or @ActualEndDate  is null) 
	BEGIN
	SET @StatusQualityOfWork=N'';
	END
ELSE
	BEGIN
	If @ActualEndDate<=@DeadlineRequest
	 BEGIN
	 -- Là đạt
	 SET @StatusQualityOfWork=N'0'
	 END
	ELSE
	 BEGIN 
	 -- Không đạt
	  SET @StatusQualityOfWork=N'1'
	 END		
	END
	 RETURN @StatusQualityOfWork
END

GO



