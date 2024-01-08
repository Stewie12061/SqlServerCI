IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load master Cập nhật/Xem chi tiết sổ cổ đông 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 26/09/2018
----Edited by: Hoàng vũ on 23/10/2018
-- <Example> EXEC SHMP2012 @DivisionID = 'AS', @UserID = '', @APK = '5DA80878-B1E6-4E46-8E53-EA703DE45FDD'

CREATE PROCEDURE SHMP2012
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 
BEGIN
	SELECT T1.APK,T1.DivisionID, T2.ObjectID,T2.ObjectName
		, T2.Address,T2.Tel,T2.Email,T2.VATno as VATNo,T1.ShareHolderCategoryID, S00.ShareHolderCategoryName,T1.ContactPrefix
		, A99.Description as ContactPrefixName,T2.Contactor,T2.PhoneNumber
		, T1.IdentificationNumber,T1.ContactIssueDate,T1.ContactIssueBy, T1.TotalShare
		, T1.CreateUserID,T1.CreateDate, T1.LastModifyUserID,T1.LastModifyDate
	FROM SHMT2010 T1  WITH (NOLOCK) LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.ObjectID=T1.ObjectID
									LEFT JOIN SHMT1000 S00 WITH (NOLOCK) ON S00.ShareHolderCategoryID=T1.ShareHolderCategoryID
								    LEFT JOIN AT0099 A99  WITH (NOLOCK) ON A99.ID=T1.ContactPrefix and A99.CodeMaster = 'AT00000002'
	WHERE T1.APK = @APK and T1.DeleteFlg = 0
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
