IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load buổi ăn và menu theo Ngày của màn hình Kết quả học tập
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 53/11/2018
-- <Example>
/*



EXEC EDMP2053 @DivisionID, @MenuVoucherDate,@APK,@LanguageID,@Mode
		
EXEC EDMP2053 @DivisionID= 'BE' , @MenuVoucherDate  ='2019-09-12',@APK = '9351A788-E1F7-473B-8F8F-D9EC3AA7BD27' ,@GradeID = 'MG-3-4', @LanguageID = 'vi-VN', @Mode =0

*/

CREATE PROCEDURE EDMP2053 ( 
        @DivisionID VARCHAR(50), 
		@MenuVoucherDate DATETIME,
		@APK VARCHAR(50), 
		@GradeID VARCHAR(50),
		@LanguageID VARCHAR(50),
		@Mode VARCHAR(50) ---0: Load addnew, 1: Load edit 
		
) 
AS 

DECLARE 
	@sSQL NVARCHAR(MAX)
	

IF @Mode = 0 
BEGIN 
SET @sSQL =  N'
		SELECT T1.DivisionID, T1.GradeID, T2.MenuDate, T2.DishID, T2.MealID
		FROM  NMT2010  T1 WITH (NOLOCK)
		LEFT JOIN NMT2011 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg = T1.DeleteFlg 
		WHERE T1.DivisionID = '''+ @DivisionID +'''
		AND T1.DeleteFlg = 0
		AND T1.GradeID = ''' + @GradeID + '''
		AND '''+CONVERT(VARCHAR(10),@MenuVoucherDate,126)+''' BETWEEN  CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) AND  CONVERT(VARCHAR(10), CONVERT(DATE, T1.ToDate,120), 126)
		AND T2.MenuDate = ''' +CONVERT(VARCHAR(10),@MenuVoucherDate,126)+'''
		Order by T2.Orders
'
END 
ELSE IF @Mode = 1
BEGIN 
SET @sSQL =  N'
	SELECT T1.DivisionID, T1.GradeID, T2.DishID, T2.MealID, T2.StatusID
		FROM  EDMT2050  T1 WITH (NOLOCK)
		INNER JOIN EDMT2051 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg = T1.DeleteFlg  
		WHERE T1.DivisionID = '''+ @DivisionID +''' AND T1.APK = '''+@APK+'''
		AND T1.DeleteFlg = 0
		Order by T2.Orders

	'
END 

PRINT @sSQL
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
