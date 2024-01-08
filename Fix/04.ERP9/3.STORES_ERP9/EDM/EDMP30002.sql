IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Báo cáo danh sách bé nghỉ học trong tháng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 30/11/2018
---- Modify  by Hồng Thảo on 15/10/2019: Sửa lại cách lấy dữ liệu báo cáo danh sách học sinh nghỉ (Bảo lưu + nghỉ học + chuyển trường)
-- <Example>
---- 
/*-- <Example>
  
  EDMP30002 @DivisionID = 'BE',@FromDate = '2019-03-01',@ToDate = '2019-03-30',@ClassID= '',@StudentID = NULL 

  EDMP30002 @DivisionID = 'BE',@FromDate = '2019-03-01',@ToDate = '2019-03-30',@ClassID= '',@StudentID = 'HS/2019/03/0010'',''HS/2019/02/0016'

  EDMP30002 @DivisionID,@FromDate,@ToDate,@ClassID,@StudentID

----*/

CREATE PROCEDURE EDMP30002 
(
	@DivisionID VARCHAR(MAX),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ClassID VARCHAR(MAX),
	@StudentID VARCHAR(50)
		
)
AS
DECLARE @sSQL   NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''


IF @ClassID <> ''
		SET @sWhere = @sWhere + ' AND T3.ClassID IN (''' + @ClassID + ''') '


IF @StudentID <> ''
		SET @sWhere = @sWhere + ' AND T1.StudentID = ''' + @StudentID + ''' '




SET @sSQL = N'
SELECT T1.DivisionID,(T1.DivisionID + '' - '' + T6.DivisionName) AS DivisionName,
T1.LeaveDate,T1.StudentID,T5.StudentName, T3.ClassID, T4.ClassName,T1.Reason,
CASE WHEN ISNULL(FatherMobiphone,'''') != '''' THEN FatherMobiphone ELSE MotherMobiphone END AS PhoneNumber,
''LeaveSchool'' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = T3.ClassID
LEFT JOIN EDMT2010 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.StudentID = T1.StudentID AND T5.DeleteFlg = 0
LEFT JOIN  AT1101 T6 WITH (NOLOCK) on T6.DivisionID = T1.DivisionID
WHERE T1.DivisionID IN ('''+@DivisionID+''')   AND T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID ) ----trường hợp thông tin lớp được tạo giống nhau nhưng có 1 xếp lớp bị xóa 
   
  '+ @sWhere +'

 UNION ALL 
 
 -----Bảo lưu 
 SELECT T1.DivisionID,(T1.DivisionID + '' - '' + T4.DivisionName) AS DivisionName,
 T1.FromDate AS LeaveDate,T1.StudentID, T2.StudentName,T1.ClassID, T3.ClassName,T1.Reason,
 CASE WHEN ISNULL(T2.FatherMobiphone,'''') != '''' THEN T2.FatherMobiphone ELSE T2.MotherMobiphone END AS PhoneNumber,
 ''Reserve'' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
 LEFT JOIN EDMT1020 T3 WITH (NOLOCK) ON T3.ClassID = T1.ClassID
 LEFT JOIN  AT1101 T4 WITH (NOLOCK) on T4.DivisionID = T1.DivisionID
 WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

  '+ @sWhere +'

 UNION ALL 

 ---chuyển trường 
 SELECT T1.DivisionID,(T1.DivisionID + '' - '' + T5.DivisionName) AS DivisionName,
 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T2.StudentName, T3.ClassID, T4.ClassName,T1.Reason,
 CASE WHEN ISNULL(T2.FatherMobiphone,'''') != '''' THEN T2.FatherMobiphone ELSE T2.MotherMobiphone END AS PhoneNumber,
 ''Transfer'' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = T3.ClassID
 LEFT JOIN  AT1101 T5 WITH (NOLOCK) on T5.DivisionID = T1.DivisionID
 WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
  '+ @sWhere +'


'



PRINT @sSQL
exec (@sSQL)













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
