IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2162]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin detail dự thu học phí EDMF2161,EDMF2162
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 17/10/2018
----Modify by Hồng Thảo on 6/5/2019: Sử dụng load cập nhật và xem chi tiết chung mode = 0. Dev xử lý phân trang 
----Modify by Đình Hoà on 29/09/2020: Thêm cột thành tiền (Total) để xử lí tính tổng tiền trên server
-- <Example>
----
/*-- <Example>
	exec EDMP2162 @DivisionID = 'BS', @UserID = 'asoftadmin', @APK = '62F507E7-68C2-4E72-9F65-ABD69F3F359B',@PageNumber = '1', @PageSize= '25' , @Mode ='1',@LanguageID = 'vi-VN'
	
	EDMP2162 @DivisionID, @UserID, @APK,@PageNumber,@PageSize,@Mode,@LanguageID

----*/
CREATE PROCEDURE EDMP2162
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT,
	 @LanguageID VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.StudentID'


IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK, T1.DivisionID, T1.APKMaster, T1.StudentID, T2.StudentName AS StudentName,T1.AttendStudy,
T5.ReceiptTypeID, T6.ReceiptTypeName, T5.Amount,
T1.DeleteFlg,T1.CreateUserID,T3.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T4.FullName AS CreateUserName,T1.LastModifyDate, T5.Amount AS Total
FROM EDMT2161 T1 WITH (NOLOCK)
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T1.StudentID = T2.StudentID 
LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID IN  (T1.DivisionID,''@@@'') AND T3.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT2162 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.APKMaster = CONVERT(VARCHAR(50),T1.APK)  
LEFT JOIN EDMT1050 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ReceiptTypeID = T5.ReceiptTypeID
WHERE  T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0 
ORDER BY '+@OrderBy+'
' 
END 


--ELSE IF @Mode = 1 
--BEGIN 
--DECLARE @TotalRow NVARCHAR(50) = N''

--SET @TotalRow = 'COUNT(*) OVER ()'

--SET @sSQL = @sSQL + N'
--SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
--T1.APK, T1.DivisionID, T1.APKMaster, T1.StudentID, T2.StudentName AS StudentName,T1.AttendStudy,
--T5.ReceiptTypeID, T6.ReceiptTypeName, T5.Amount,
--T1.DeleteFlg,T1.CreateUserID,T3.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T4.FullName AS CreateUserName,T1.LastModifyDate
--FROM EDMT2161 T1 WITH (NOLOCK)
--LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T1.StudentID = T2.StudentID 
--LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID IN  (T1.DivisionID,''@@@'') AND T3.EmployeeID = T1.CreateUserID
--LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.EmployeeID = T1.LastModifyUserID
--LEFT JOIN EDMT2162 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.APKMaster = CONVERT(VARCHAR(50),T1.APK)   
--LEFT JOIN EDMT1050 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ReceiptTypeID = T5.ReceiptTypeID

--WHERE  T1.APKMaster = '''+@APK+''' AND T1.DeleteFlg = 0 

--ORDER BY '+@OrderBy+' 

--OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
--FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
--END 


 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
