IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load tab thông tin phiếu thông tin tư vấn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 08/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2001 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '8DFC813D-37E9-4F24-8CC4-003400C58D69', @LanguageID ='vi-VN'
	
	EDMP2001 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2001
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT A.* , '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'B.Description' ELSE 'B.DescriptionE' END +' AS StatusName 
FROM 
(

SELECT T1.APK,T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.IsInheritClue, T1.ParentID, T1.ParentName,T1.ParentDateBirth, T1.Telephone,
T1.Address, T1.Email,T1.StudentID, T1.StudentName, T1.StudentDateBirth, T1.Sex, T1.Prefix,T1.OldCustomer,
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.Description' ELSE 'T5.DescriptionE' END +' as SexName, 
T1.ResultID, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END +' as ResultName, 
T1.DateFrom, T1.DateTo,
CASE WHEN  ISNULL(T1.Amount,1) - SUM(ISNULL(T6.ConvertedAmount, 0)) = 0 
												THEN 1
												ELSE 0 END AS Status,


T1.Amount, T1.Information,T1.SType01ID,T1.SType02ID,T1.SType03ID,T1.SType01IDS,SType02IDS,SType03IDS,
T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate,
CASE WHEN ISNULL(InheritTranfer,'''') = '''' THEN 0 ELSE 1 END AS IsInheritTransfer,
T1.AdmissionDate, T1.FeeID, T7.FeeName

FROM EDMT2000 T1  WITH (NOLOCK)
LEFT JOIN EDMT0099  T3 WITH (NOLOCK) ON T1.ResultID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''ConsultancyResult''
 
LEFT JOIN EDMT0099  T5 WITH (NOLOCK) ON T1.Sex = T5.ID AND T5.Disabled = 0 AND T5.CodeMaster=''Sex''
LEFT JOIN AT9000    T6 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T6.InheritVoucherID AND CONVERT(VARCHAR(50),T1.APK) = T6.InheritTransactionID AND T1.StudentID = T6.ObjectID AND T6.InheritTableID = ''EDMT2000'' 
LEFT JOIN EDMT1090  T7 WITH (NOLOCK) ON T7.FeeID = T1.FeeID

WHERE T1.APK = '''+@APK+'''
GROUP BY T1.APK,T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.IsInheritClue, T1.ParentID, T1.ParentName,T1.ParentDateBirth, T1.Telephone,
T1.Address, T1.Email,T1.StudentID, T1.StudentName, T1.StudentDateBirth, T1.Sex, T1.Prefix,T1.OldCustomer,T5.Description,T5.DescriptionE,
T1.ResultID, T3.Description,T3.DescriptionE,T1.DateFrom, T1.DateTo,T1.Amount,T1.Amount, 
T1.Information,T1.SType01ID,T1.SType02ID,T1.SType03ID,T1.SType01IDS,SType02IDS,SType03IDS,
T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate,InheritTranfer,AdmissionDate,T1.FeeID,FeeName
) A 
LEFT JOIN EDMT0099  B WITH (NOLOCK) ON A.Status = B.ID AND B.Disabled = 0 AND B.CodeMaster=''PaymentStatus''


'
 PRINT @sSQL
 EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
