IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load phiếu thông tin tư vấn của học sinh kế thừa 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 27/9/2019
----Modify on Hồng Thảo on 22/10/2019: Bổ sung order by lấy học sinh sau cùng cho trường hợp học lại 
-- <Example>
---- 
/*-- <Example>
	EDMP2007 @DivisionID = 'CG', @UserID = 'HONGTHAO', @StudentID  = 'BE-Y009'
	
	EDMP2007 @DivisionID, @UserID, @StudentID 
----*/
CREATE PROCEDURE EDMP2007
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID NVARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''

 
 SET @sSQL = N'
 
SELECT TOP 1 APK, VoucherNo,VoucherDate,SType01ID,SType02ID,SType03ID,ParentID,ParentName,ParentDateBirth,
	   Telephone,[Address],Email,Prefix, 1 AS OldCustomer,InheritTranfer,
	   SType01IDS,SType02IDS,SType03IDS,StudentID,StudentName,StudentDateBirth,Sex,
	   ResultID,DateFrom,DateTo,[Status],Amount,
	   Information,DeleteFlg
FROM EDMT2000 WITH (NOLOCK) 
WHERE StudentID  = '''+@StudentID+''' AND DeleteFlg = 0 
ORDER BY CreateDate DESC
 
 
 
 
 
 
 
 '


 --PRINT @sSQL
 EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
