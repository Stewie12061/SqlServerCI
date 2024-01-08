IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1113]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1113]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục biểu phí \ Cập nhật đưa đón \ Lưới
-- <History>
----Created by: Lương Mỹ, Date: 02/01/2019
---- Modified by on 
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE EDMP1113
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50)
)
AS 


SELECT 
T1.APK, T1.DivisionID, T2.PromotionName,  T3.ReceiptTypeName 
FROM EDMT1110 T1 WITH (NOLOCK)
LEFT JOIN EDMT1100 T2 WITH (NOLOCK) ON T1.PromotionID = T2.PromotionID
LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T1.ReceiptTypeID = T3.ReceiptTypeID
WHERE CONVERT(VARCHAR(50), T1.APK) = @APK







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
