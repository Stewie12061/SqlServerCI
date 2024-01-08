IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OOP1002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Form OOF1002: Xem thông tin loại phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 27/11/2015
---- Modified by Phương Thảo on 28/06/2017: Bổ sung trường Quy định và check phân biệt loại phép ĐTVS
---- Modified by Như Hàn on 06/08/2019: Bổ sung trường IsSickLeave 
---- Modified by Trọng Kiên on 03/09/2020: Bổ sung load tên quy định
/*-- <Example>
	OOP1002 @DivisionID='MK',@UserID='ASOFTADMIN', @APK='126DE2C8-FAFB-4EDC-8DE1-063A002531A5'
----*/

CREATE PROCEDURE OOP1002
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50)
)
AS 
SELECT OOT1000.APK,OOT1000.DivisionID, OOT1000.AbsentTypeID,OOT1000.[Description],OOT1000.DescriptionE, OOT1000.TypeID, HT1013.AbsentName AS TypeName, OOT1000.Note, OOT1000.[Disabled], 
	OOT1000.CreateUserID +' - '+ (SELECT TOP 1 UserName FROM AT1405 WITH (NOLOCK) WHERE UserID = OOT1000.CreateUserID) CreateUserID, OOT1000.CreateDate,
	OOT1000.LastModifyUserID +' - '+ (SELECT TOP 1 UserName FROM AT1405 WITH (NOLOCK) WHERE UserID = OOT1000.LastModifyUserID) LastModifyUserID,
	OOT1000.LastModifyDate, OOT1000.RestrictID, OOT1000.IsDTVS, OOT1000.IsSickLeave, HT1022.RestrictName
FROM OOT1000 WITH (NOLOCK)
LEFT JOIN HT1013 WITH (NOLOCK) ON HT1013.DivisionID = OOT1000.DivisionID AND HT1013.AbsentTypeID = OOT1000.TypeID
LEFT JOIN HT1022 WITH (NOLOCK) ON HT1022.RestrictID = OOT1000.RestrictID
WHERE  OOT1000.DivisionID = @DivisionID
AND OOT1000.APK = @APK


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

