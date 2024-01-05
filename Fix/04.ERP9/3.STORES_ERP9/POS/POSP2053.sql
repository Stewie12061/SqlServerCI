IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Insert or Update Điều phối nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Dũng DV, Date 202/10/2019
-- <Example>
/* 
exec POSP2053 @DivisionID=N'NN',@VoucherNo=N'BH/10/2019/0023',@GuaranteeEmployeeID=N'ASOFT',@RepairEmployeeID=N'KHANHNLN',@DeliveryEmployeeID=N'ASOFT',@IsCommon=1,@Disabled=0,@CreateUserID=N'ADMIN',@CreateDate='2019-10-02 10:49:55.343',@LastModifyUserID=N'ADMIN',@LastModifyDate='2019-10-02 10:49:55.920'
*/
CREATE PROCEDURE POSP2053
	@DivisionID varchar(50),
    @VoucherNo varchar(50),
    @GuaranteeEmployeeID varchar(50),
    @RepairEmployeeID  varchar(50),
    @DeliveryEmployeeID varchar(50),
    @IsCommon tinyint,
    @Disabled tinyint,
    @CreateUserID varchar(50),
    @CreateDate datetime,
    @LastModifyDate datetime,
    @LastModifyUserID VARCHAR(50)

as
BEGIN
IF NOT EXISTS(SELECT 1 FROM POST2053 WHERE VoucherNo = @VoucherNo)
begin
INSERT INTO dbo.POST2053
(
    APK,
    DivisionID,
    VoucherNo,
    GuaranteeEmployeeID,
    RepairEmployeeID,
    DeliveryEmployeeID,
    IsCommon,
    Disabled,
    CreateUserID,
    CreateDate,
    LastModifyDate,
    LastModifyUserID
)
VALUES
(   NEWID(),      -- APK - uniqueidentifier
    @DivisionID,        -- DivisionID - varchar(50)
    @VoucherNo,        -- VoucherNo - varchar(50)
    @GuaranteeEmployeeID,        -- GuaranteeEmployeeID - varchar(50)
    @RepairEmployeeID,        -- RepairEmployeeID - varchar(50)
    @DeliveryEmployeeID,        -- DeliveryEmployeeID - varchar(50)
    @IsCommon,         -- IsCommon - tinyint
    @Disabled,         -- Disabled - tinyint
    @CreateUserID,        -- CreateUserID - varchar(50)
    @CreateDate, -- CreateDate - datetime
    @LastModifyDate, -- LastModifyDate - datetime
    @LastModifyUserID         -- LastModifyUserID - varchar(50)
 )   
 END
    ELSE
    BEGIN
    UPDATE dbo.POST2053 SET 
    GuaranteeEmployeeID = @GuaranteeEmployeeID,
    RepairEmployeeID = @RepairEmployeeID,
    DeliveryEmployeeID = @DeliveryEmployeeID,
	LastModifyDate = @LastModifyDate,
    LastModifyUserID = @LastModifyUserID WHERE VoucherNo = @VoucherNo
	end
end