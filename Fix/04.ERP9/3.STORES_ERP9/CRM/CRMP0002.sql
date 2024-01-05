IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP0002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP0002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lấy danh sách liên hệ, lead có sinh nhật vào hôm nay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Đoàn Duy on 16/03/2021
-- <Example>
/*
 EXEC CRMP0002 @IsUpcommingBirthDate = 1
 */

CREATE PROCEDURE CRMP0002
( 
	@IsUpcommingBirthDate BIT = 0 --Cờ để lấy những khách hàng sắp đến sinh nhật
) 
AS

BEGIN
IF (@IsUpcommingBirthDate = 1)
    Begin
		SELECT APK, FullName, BirthDate, ID, TableID 
		FROM
		(
		    SELECT c1.APK, c1.ContactName AS FullName, c1.BirthDate, c1.ContactID AS ID, 'CRMT10001' as TableID, IsNull(HomeMobile, HomeTel) as PhoneNumber FROM CRMT10001 c1 WITH (NOLOCK)
		    WHERE (CONVERT(float, DATEADD(yyyy, DATEDIFF(yyyy, c1.BirthDate, GETDATE()), c1.BirthDate)) - CONVERT(float,GETDATE())) BETWEEN  0 and 5 
		    UNION
		    SELECT c2.APK, c2.LeadName AS FullName, c2.BirthDate, c2.LeadID AS ID, 'CRMT20301' as TableID, LeadMobile as PhoneNumber FROM CRMT20301 c2 WITH (NOLOCK)
		    WHERE (CONVERT(float, DATEADD(yyyy, DATEDIFF(yyyy, c2.BirthDate, GETDATE()), c2.BirthDate)) - CONVERT(float,GETDATE())) BETWEEN  0 and 5
		) RESULT
		ORDER BY DATEADD(YEAR, 2000-YEAR(BirthDate), BirthDate) 
    End
Else
    Begin
		SELECT APK, FullName, BirthDate, ID, TableID 
		FROM
		(
            SELECT c1.APK, c1.ContactName AS FullName, c1.BirthDate, c1.ContactID AS ID, 'CRMT10001' as TableID, IsNull(HomeMobile, HomeTel) as PhoneNumber FROM CRMT10001 c1 WITH (NOLOCK)
		    WHERE CONVERT(VARCHAR(5),c1.BirthDate,110) = CONVERT(VARCHAR(5),GETDATE(),110)
		    UNION
		    SELECT c2.APK, c2.LeadName AS FullName, c2.BirthDate, c2.LeadID AS ID, 'CRMT20301' as TableID, LeadMobile as PhoneNumber FROM CRMT20301 c2 WITH (NOLOCK)
		    WHERE CONVERT(VARCHAR(5),c2.BirthDate,110) = CONVERT(VARCHAR(5),GETDATE(),110)
		) RESULT
		ORDER BY DATEADD(YEAR, 2000-YEAR(BirthDate), BirthDate) 
    End   	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
