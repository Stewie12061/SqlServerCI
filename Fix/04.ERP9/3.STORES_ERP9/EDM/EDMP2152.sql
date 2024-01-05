IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2152]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- load detail bảo lưu 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 27/2/2020
-- <Example>
/*
EDMP2152 @DivisionID = 'BE',@UserID = 'ASOFADMIN', @APK = '87D9D8CC-7888-40B3-B465-D3E90D4DB331',@PageNumber = '1',@PageSize= '25',@Mode = '0',@LanguageID = 'vi-VN'

*/

CREATE PROCEDURE EDMP2152 ( 
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
	SELECT  T1.APK, T1.DivisionID, T1.APKMaster, T1.ReceiptTypeID,T2.ReceiptTypeName,T1.PaymentMethod, 
	'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.[Description]' ELSE 'T3.DescriptionE' END+' AS PaymentMethodName,
	T1.UnitPrice, T1.Amount,T1.AmountReceived, T1.AmountReserve, T1.TotalAmount, T1.MonthReserve,
	T1.FromDate,T1.ToDate, T1.IsTransfer,
	T1.CreateUserID, T1.CreateDate,T1.LastModifyUserID, T1.LastModifyDate
	FROM EDMT2151 T1 WITH (NOLOCK)
	LEFT JOIN EDMT1050 T2 WITH (NOLOCK) ON T1.ReceiptTypeID = T2.ReceiptTypeID 
	LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.PaymentMethod AND T3.CodeMaster =''PaymentMethod''
	WHERE T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0 
	ORDER BY '+@OrderBy+''
	END 


	ELSE IF @Mode = 1
	BEGIN 
	
	SET @TotalRow = 'COUNT(*) OVER ()'

	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.APK, T1.DivisionID, T1.APKMaster, T1.ReceiptTypeID,T2.ReceiptTypeName,T1.PaymentMethod, 
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.[Description]' ELSE 'T3.DescriptionE' END+' AS PaymentMethodName,
			T1.UnitPrice, T1.Amount,T1.AmountReceived, T1.AmountReserve, T1.TotalAmount, T1.MonthReserve,
			T1.FromDate,T1.ToDate,T1.IsTransfer,
			T1.CreateUserID, T1.CreateDate,T1.LastModifyUserID, T1.LastModifyDate
	FROM EDMT2151 T1 WITH (NOLOCK)
	LEFT JOIN EDMT1050 T2 WITH (NOLOCK) ON T1.ReceiptTypeID = T2.ReceiptTypeID 
	LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.PaymentMethod AND T3.CodeMaster =''PaymentMethod''
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
