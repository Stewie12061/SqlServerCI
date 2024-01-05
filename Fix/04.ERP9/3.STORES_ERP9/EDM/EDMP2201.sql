IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- load detail thay đổi mức đóng phí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 11/2/2020
-- <Example>
/*
exec EDMP2201 @DivisionID=N'BE',@UserID=N'ASOFTADMIN',@LanguageID=N'vi-VN',@PageNumber=1,@PageSize=25,@APK=N'ea9cdabe-21ab-47d2-baf3-e3426348f076',@Mode=1


*/

CREATE PROCEDURE EDMP2201 ( 
       @DivisionID VARCHAR(50),
	   @UserID VARCHAR(50),
	   @APK VARCHAR(50),
	   @PageNumber INT,
	   @PageSize INT,
	   @Mode TINYINT, ---0: Load cập nhật, 1 Load xem chi tiết
	   @LanguageID VARCHAR(50) 
) 
AS 

DECLARE @sSQL NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''
 
		SET @OrderBy = 'T2.FromDate DESC,T2.ReceiptTypeID'

	IF @Mode = 0
	BEGIN 
	SET @sSQL = N'
	SELECT	T2.APK,T2.DivisionID,T2.APKMaster,T2.ReceiptTypeID,T3.ReceiptTypeName,T3.ReceiptTypeName as ReceiptTypeNamePTTTV,
			T2.AmountOld,
			-- Phương thức đóng
			T2.CurrentPaymentMethod,
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.[Description]' ELSE 'T4.DescriptionE' END+' AS  CurrentPaymentMethodName,
			T2.PaymentMethod, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.[Description]' ELSE 'T5.DescriptionE' END+' AS  PaymentMethodName,
			T2.FromDate, T2.ToDate,
			T2.OldFromDate, T2.OldToDate,

			T2.Quantity, T2.AmountPromotion, T2.AmountTotalPromotion, T2.AmountReceived,
			T2.UnitPrice, T2.Amount, T2.IsCSVC, T2.AmountReserve,
			(T2.Amount * T2.Quantity) as SumAmount,
			T2.IsCSVC,T2.IsNew,
			Stuff(isnull((	Select  '', '' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),T1.APK) and X.DivisionID= T1.DivisionID AND X.APKDetail = T2.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID


	FROM EDMT2200 T1 WITH (NOLOCK)
	LEFT JOIN EDMT2201 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster 
	LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T3.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T4.ID = T2.CurrentPaymentMethod AND T4.CodeMaster = ''PaymentMethod''
	LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T5.ID = T2.PaymentMethod AND T5.CodeMaster = ''PaymentMethod''
 
	WHERE T1.APK = '''+@APK+''' AND T1.DeleteFlg = 0 AND T2.DeleteFlg = 0 
	ORDER BY '+@OrderBy+''
	END 


	ELSE IF @Mode = 1
	BEGIN 
	
	SET @TotalRow = 'COUNT(*) OVER ()'

	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		   T2.APK,T2.DivisionID,T2.APKMaster,T2.ReceiptTypeID,T3.ReceiptTypeName,T2.AmountOld,
		   T2.PaymentMethod, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.[Description]' ELSE 'T5.DescriptionE' END+' AS  PaymentMethodName,
		   T2.Quantity, T2.AmountPromotion, T2.AmountTotalPromotion, T2.AmountReceived,
		   (T2.Amount * T2.Quantity) as SumAmount,
		   T2.UnitPrice, T2.Amount, T2.IsCSVC, T2.AmountReserve, T2.FromDate, T2.ToDate,T2.CurrentPaymentMethod,
		   '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.[Description]' ELSE 'T4.DescriptionE' END+' AS  CurrentPaymentMethodName,
		   T2.IsCSVC,T2.IsNew,
		   T2.FromDate, T2.ToDate,
		   Stuff(isnull((	Select  '', '' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),T1.APK) and X.DivisionID= T1.DivisionID AND X.APKDetail = T2.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID


	FROM EDMT2200 T1 WITH (NOLOCK)
	LEFT JOIN EDMT2201 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster 
	LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T3.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T4.ID = T2.CurrentPaymentMethod AND T4.CodeMaster = ''PaymentMethod''
	LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T5.ID = T2.PaymentMethod AND T5.CodeMaster = ''PaymentMethod''
    

	WHERE T1.APK = '''+@APK+''' AND T1.DeleteFlg = 0 AND T2.DeleteFlg = 0 
	ORDER BY '+@OrderBy+' 

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END 



PRINT @sSQL
EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
