IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Báo cáo dự toán doanh thu + Phiếu dự thu học phí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 7/5/2019
-- <Example>
---- 
/*-- <Example>
	EXEC EDMP30007 @DivisionID = 'BE',@DivisionList='',@UserID='ASOFTADMIN',@SchoolYearID = '',@ClassID = '',@TranMonth = '',@TranYear = '',@StudentID = ''

	EDMP30007 @DivisionID = 'BE',@DivisionList='',@UserID='ASOFTADMIN',@SchoolYearID = '2017-2018',@ClassID = 'EST11'',''MG1',@TranMonth = '9',@TranYear = '2017',@StudentID = NULL,@ReportID = 'edmr30007'

	EXEC EDMP30007 @DivisionID,@DivisionList,@UserID,@SchoolYearID,@ClassID,@TranMonth,@TranYear,@StudentID,@ReportID 
----*/

CREATE PROCEDURE EDMP30007
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),	 
	 @SchoolYearID NVARCHAR(50), 	 
	 @ClassID NVARCHAR(4000),
	 @TranMonth VARCHAR(50) ,
	 @TranYear VARCHAR(50),
	 @StudentID NVARCHAR(4000),
	 @ReportID VARCHAR(50) 
)
AS 
DECLARE @sSQL NVARCHAR(4000) = N'',
		@SQL1 NVARCHAR(4000) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) 

SET @OrderBy = 'T2.StudentID'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + 'AND T1.DivisionID = '''+@DivisionID+''''

IF ISNULL(@SchoolYearID,'') != ''
	SET @sWhere = @sWhere + ' AND T1.SchoolYearID IN ('''+@SchoolYearID+''') '

IF ISNULL(@ClassID,'') != ''
	SET @sWhere = @sWhere + ' AND T1.ClassID IN ('''+@ClassID+''') '

IF ISNULL(@StudentID,'') != ''
	SET @sWhere = @sWhere + ' AND T2.StudentID IN ('''+@StudentID+''') '


SET @SQL1 = N'

	SELECT	 T1.DivisionID, T1.ObjectID,T1.ClassID,
			(isnull(OriginalAmount, 0) - isnull(OriginalAmountPT,0)) as EndOriginalAmount
		Into #TempA
			FROM(
			(Select 
				A.DivisionID,A.ClassID,StudentID AS ObjectID, SUM (C.Amount) AS OriginalAmount
			From EDMT2160 A WITH (NOLOCK)
			LEFT JOIN EDMT2161  B WITH (NOLOCK) ON A.APK = B.APKMaster AND  B.DeleteFlg = A.DeleteFlg 
			LEFT JOIN EDMT2162 C WITH (NOLOCK) ON C.APKMaster = B.APK
			LEFT JOIN EDMT1050 D WITH (NOLOCK) ON D.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D.ReceiptTypeID = C.ReceiptTypeID
			WHERE A.DivisionID = '''+@DivisionID+''' AND (A.TranMonth + A.TranYear *100 ) < ('''+@TranMonth+''' + '''+@TranYear+''' *100)
			AND A.ClassID IN ('''+@ClassID+''') AND A.SchoolYearID IN ('''+@SchoolYearID+''') AND ISNULL(D.IsMoney,0) IN (0,1)  AND A.DeleteFlg = 0 
			GROUP BY A.DivisionID,ClassID,StudentID
			 ) AS T1

			Left join (
				Select DivisionID, ObjectID, sum(OriginalAmount) As OriginalAmountPT
				From AT9000 WITH (NOLOCK) 
				Where DivisionID ='''+@DivisionID+''' AND TransactionTypeID In (''T21'',''T01'') 
				AND (TranMonth + TranYear * 100 ) < ('''+@TranMonth+''' + '''+@TranYear+''' *100)
			    AND ISNULL(InheritTransactionID,'''') != '''' AND InheritTableID = ''EDMT2160''
				Group by DivisionID, ObjectID

				) AS K  on T1.DivisionID = K.DivisionID AND K.ObjectID = T1.ObjectID				
			)
			WHERE	T1.DivisionID = '''+@DivisionID+'''  

' 


SET @sSQL = '
	SELECT T1.DivisionID,T7.DivisionName,T2.StudentID, T4.StudentName,T1.ClassID, T5.ClassName,T3.ReceiptTypeID, T6.ReceiptTypeName,T3.Amount,T6.IsMoney,
	CASE WHEN T1.TranMonth < 10 THEN ''0''+CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) Else CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) END AS MonthID,
	CASE WHEN ISNULL(FatherEmail,'''') != '''' THEN FatherEmail ELSE MotherEmail END AS Email,
	CASE WHEN '''+@ReportID+''' = ''EDMR30007'' THEN ''EDMR30007'' ELSE ''EDMR3008'' END AS ReportID,
	T2.AbsentPermission1, T2.AbsentPermission2,
	(Select EndOriginalAmount FROM #TempA
						WHERE DivisionID = '''+@DivisionID+''' And T1.ClassID= ClassID AND T2.StudentID = ObjectID) as AmountLastMonth
	FROM EDMT2160 T1 WITH (NOLOCK)
	LEFT JOIN EDMT2161 T2 WITH (NOLOCK) ON CONVERT (VARCHAR(50),T1.APK) = T2.APKMaster AND T2.DeleteFlg = T1.DeleteFlg
	LEFT JOIN EDMT2162 T3 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T2.APK) = T3.APKMaster 
	LEFT JOIN EDMT2010 T4 WITH (NOLOCK) ON T4.StudentID = T2.StudentID AND T4.DeleteFlg = 0 
	LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID IN ('''+@DivisionID+''',''@@@'') AND  T5.ClassID = T1.ClassID 
	LEFT JOIN EDMT1050 T6 WITH (NOLOCK) ON T6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T6.ReceiptTypeID = T3.ReceiptTypeID 
	LEFT JOIN AT1101   T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID 

	WHERE  T1.DeleteFlg = 0  '+@sWhere +'
	AND  T1.TranMonth = '''+@TranMonth+'''  AND T1.TranYear = '''+@TranYear+'''

   ORDER BY '+@OrderBy+' 

'
 
 

EXEC (@SQL1+ @sSQL)
PRINT  (@SQL1)
PRINT  (@sSQL)
 








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
