IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2038]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2038]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- load detail PTTTV 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 3/2/2020
-- <Example>
/*
EDMP2038 @DivisionID = 'BE',@UserID = 'ASOFADMIN', @APK = '87D9D8CC-7888-40B3-B465-D3E90D4DB331',@PageNumber = '1',@PageSize= '25',@Mode = '0',@LanguageID = 'vi-VN'

*/

CREATE PROCEDURE EDMP2038 ( 
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
 
		SET @OrderBy = 'T1.FromDate DESC,T1.ReceiptTypeID'

	IF @Mode = 0
	BEGIN 
	SET @sSQL = N'
	SELECT T1.APK,T1.DivisionID,T1.APKMaster, T1.ReceiptTypeID,T2.ReceiptTypeName, 
		   CONVERT(INT, T1.PaymentMethod) as PaymentMethod, 
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.[Description]' ELSE 'T3.DescriptionE' END+' AS  PaymentMethodName,
		   T1.UnitPrice, T1.IsCSVC,
		   T7.AmountOfDay, T7.AmountOfOneMonth, T7.AmountOfSixMonth, T7.AmountOfNineMonth, T7.AmountOfYear,
		   T1.Quantity, T1.Amount, (T1.Quantity * T1.Amount)  as SumAmount, 
		   T1.AmountPromotion, T1.AmountTotalPromotion, T1.FromDate, T1.ToDate,
		   CONVERT (INT,T2.TypeOfFee) AS TypeOfFee, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.[Description]' ELSE 'T4.DescriptionE' END+' AS FeeTypeName,
		   T7.UnitID, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T8.[Description]' ELSE 'T8.DescriptionE' END+' AS UnitName,
		   Stuff(isnull((	Select  '', '' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),T5.APK) and X.DivisionID= T1.DivisionID AND X.APKDetail = T1.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID

	FROM EDMT2001 T1 WITH (NOLOCK) 
	LEFT JOIN EDMT1050 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.PaymentMethod AND		T3.CodeMaster = ''PaymentMethod''
	LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T4.ID = T2.TypeOfFee		AND		T4.CodeMaster=''TypeOfFee''
	LEFT JOIN EDMT2000 T5 WITH (NOLOCK) ON T5.APK = T1.APKMaster AND T5.DeleteFlg = 0
	LEFT JOIN EDMT1090 T6 WITH (NOLOCK) ON T6.FeeID = T5.FeeID 
	LEFT JOIN EDMT1091 T7 WITH (NOLOCK) ON T6.APK = T7.APKMaster AND T7.ReceiptTypeID = T1.ReceiptTypeID
	LEFT JOIN EDMT0099 T8 WITH (NOLOCK) ON T8.ID = T7.UnitID AND T8.CodeMaster = ''Time''

	WHERE T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0 
	ORDER BY '+@OrderBy+''
	END 


	ELSE IF @Mode = 1
	BEGIN 
	
	SET @TotalRow = 'COUNT(*) OVER ()'

	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK,T1.DivisionID,T1.APKMaster, T1.ReceiptTypeID,T2.ReceiptTypeName, T1.PaymentMethod, 
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.[Description]' ELSE 'T3.DescriptionE' END+' AS  PaymentMethodName,
		   T1.UnitPrice, T1.IsCSVC,
		   T1.Quantity, T1.Amount, (T1.Quantity * T1.Amount)  as SumAmount,
		   T1.AmountPromotion, T1.AmountTotalPromotion, T1.FromDate, T1.ToDate,
		   CONVERT (INT,T2.TypeOfFee) AS TypeOfFee  , '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.[Description]' ELSE 'T4.DescriptionE' END+' AS FeeTypeName,
		   T7.UnitID, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T8.[Description]' ELSE 'T8.DescriptionE' END+' AS UnitName,
		   Stuff(isnull((	Select  '', '' + X.PromotionID From  
												(	Select DISTINCT EDMT2002.DivisionID,EDMT2002.APKMaster,EDMT2002.APKDetail,EDMT2002.PromotionID
													From EDMT2002 WITH (NOLOCK)
													
												) X
								Where X.APKMaster = Convert(varchar(50),T5.APK) and X.DivisionID= T1.DivisionID AND X.APKDetail = T1.APK 
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS PromotionID

	FROM EDMT2001 T1 WITH (NOLOCK) 
	LEFT JOIN EDMT1050 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.PaymentMethod AND T3.CodeMaster = ''PaymentMethod''
	LEFT JOIN EDMT0099 T4 WITH (NOLOCK) ON T4.ID = T2.TypeOfFee		AND		T4.CodeMaster=''TypeOfFee''
	LEFT JOIN EDMT2000 T5 WITH (NOLOCK) ON T5.APK = T1.APKMaster AND T5.DeleteFlg = 0
	LEFT JOIN EDMT1090 T6 WITH (NOLOCK) ON T6.FeeID = T5.FeeID 
	LEFT JOIN EDMT1091 T7 WITH (NOLOCK) ON T6.APK = T7.APKMaster AND T7.ReceiptTypeID = T1.ReceiptTypeID
	LEFT JOIN EDMT0099 T8 WITH (NOLOCK) ON T8.ID = T7.UnitID AND T8.CodeMaster = ''Time''

	WHERE T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0 
	ORDER BY '+@OrderBy+' 

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END 



--PRINT @sSQL
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
