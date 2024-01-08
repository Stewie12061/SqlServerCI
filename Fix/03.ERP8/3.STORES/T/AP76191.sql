IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP76191]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP76191]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Bao cao ket qua kinh doanh theo ma phan tich - co group theo ma phan tich
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/09/2016 by Truong Ngoc Phuong Thao : 
---- 
---- Modified on 25/09/2016 by Truong Ngoc Phuong Thao
-- <Example>
----

CREATE PROCEDURE [dbo].[AP76191] 
				@DivisionID nvarchar(50), 
				@FromMonth as int, 
				@FromYear  as int,  
				@ToMonth  as int,  
				@ToYear  as int,  
				@CaculatorID nvarchar(50), 
				@FromAccountID  nvarchar(50),  
				@ToAccountID  nvarchar(50),  
				@FromCorAccountID  nvarchar(50),  
				@ToCorAccountID  nvarchar(50), 
				@AnaTypeID  nvarchar(50),  
				@FromAnaID  nvarchar(50), 
				@ToAnaID  nvarchar(50),  
				@FieldID nvarchar(50),  
				@AnaID nvarchar(50), 
				@BudgetID as nvarchar(50),
				--@Amount decimal(28,8) OUTPUT,
				@StrDivisionID AS NVARCHAR(4000) = '',				
				@Selection01 AS Nvarchar(50),
				@Selection02 AS Nvarchar(50),
				@Selection03 AS Nvarchar(50),
				@Selection04 AS Nvarchar(50),
				@Selection05 AS Nvarchar(50),
				@LineID AS nvarchar (50),
				@i AS Int,
				@ReportCode AS nvarchar (50),
				@IsLastPeriod AS TINYINT
AS

--Print '@AnaID:' + @AnaID
--Print '@BudgetID:' + @BudgetID
--Print '@FromAnaID:' + @FromAnaID
--Print '@ToAnaID:' + @ToAnaID
--Print '@AnaTypeID:' + @AnaTypeID

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000),
		@StrSQL1 AS NVARCHAR(4000) = '',		
		@Stri As Varchar(2),
		@StrTable As Varchar(50),
		@StrInsert AS NVARCHAR(MAX) = '',		
		@StrSelect1 AS NVARCHAR(MAX) = '',
		@StrSelect2 AS NVARCHAR(MAX) = '',		
		@StrUpdate AS NVARCHAR(MAX) = '',		
		@CustomerName INT		
		
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)	
	
SELECT @StrTable = CASE WHEN @IsLastPeriod = 0 THEN 'AT7622' ELSE 'AT7622_LastPeriod' END

SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')
---------------------<<<<<<<<<< Chuỗi DivisionID

-------------- Bổ sung nhóm dữ liệu --------------------------
--IF @Selection01 <> '' AND @Selection01 IS NOT NULL SET @strSQLGroup = @strSQLGroup + @Selection01
--IF @Selection02 <> '' AND @Selection02 IS NOT NULL SET @strSQLGroup = @strSQLGroup +', '+ @Selection02
--IF @Selection03 <> '' AND @Selection03 IS NOT NULL SET @strSQLGroup = @strSQLGroup + ', '+ @Selection03
--IF @Selection04 <> '' AND @Selection04 IS NOT NULL SET @strSQLGroup = @strSQLGroup + ', '+ @Selection04
--IF @Selection05 <> '' AND @Selection05 IS NOT NULL SET @strSQLGroup = @strSQLGroup + ', '+ @Selection05


SELECT @Selection01 = ISNULL(@Selection01,''),  @Selection02 = ISNULL(@Selection02,''),  @Selection03 = ISNULL(@Selection03,''), 
		@Selection04 = ISNULL(@Selection04,''),  @Selection05 = ISNULL(@Selection05,'')

SELECT @Stri = CASE WHEN @i < 10 THEN '0'+Convert(Varchar(1),@i) ELSE Convert(Varchar(2),@i) END

IF @CustomerName = 75
BEGIN
	SET @StrInsert = ' Amount'+@Stri+'A,'
	SET @StrSelect1 = ', sum(SignAmount2) * (-1) AS  Amount'+@Stri+'A'
	SET @StrSelect2 = ', sum(SignAmount2) AS  Amount'+@Stri+'A'	
	SET @StrUpdate = ', T1.Amount'+@Stri+'A = T2.Amount'+@Stri+'A'
END

-- TH4 ---- Phat sinh Co  PC
If @CaculatorID ='PC'
BEGIN
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		IF @BudgetID = 'AQ'
		BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ' ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ' ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ' ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ' ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ' ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,
						
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = ''AA'' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
		'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
		+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
		+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
		+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
		+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
									WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							)			 
			 '
		 
		SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount)* (-1) AS  Amount'+@Stri + @StrSelect1 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = ''AA'' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

--print @StrSQL1
			 EXEC (@StrSQL1)	
		END		
		ELSE
		BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '					
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '	
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''					
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount)* (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''		
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

--print @StrSQL1
			 EXEC (@StrSQL1)
		END			
  END   
  Else
  BEGIN  
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5,					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )					
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount)* (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )		
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

--print @StrSQL1
			 EXEC (@StrSQL1)
  END
--print (@StrSQL1)
END

-- TH5 ---- Phat sinh  No - PD
If @CaculatorID ='PD'
BEGIN

  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		IF @BudgetID = 'AQ'
		BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = ''AA'' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''							
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = ''AA'' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)	
		END  		
		ELSE   			
		BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '  
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''		
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

										 	
			 EXEC (@StrSQL1)
		END
  END   
  ELSE
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				 + CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				 + CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				 + CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				 + CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 	 						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '  
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
				AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+') AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 		
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID,'''')' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID,'''')' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', ISNULL(Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID,'''')' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

		EXEC (@StrSQL1)
  END 

END


 --TH1 ---  trong ky:  PA  (lay phat sinh No - Ps Co)
If @CaculatorID ='PA'
Begin

  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	BEGIN	
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5
					)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '									
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
						AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
					FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
					TransactionTypeID <>''T00'' AND
					(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 		
					AND CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''							
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '  
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
						AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
					FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
					TransactionTypeID <>''T00'' AND
					(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 		
					AND CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

		
	--select isnull(@StrSQL1,'null1')
--print @StrSQL1
		 EXEC (@StrSQL1)	
		     
	END    
	ELSE
	BEGIN
		--select @StrTable, @Selection01, @Selection02, @Selection03, @Selection04, @Selection05,
		--		@FromAccountID, @ToAccountID, @FromMonth, @FromYear, @ToMonth, @ToYear,
		--		@AnaID, @BudgetID, @FromAnaID, @ToAnaID, @LineID, @ReportCode, @Stri
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'	
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '								
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
						AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
					FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
					TransactionTypeID <>''T00'' AND
					(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '  
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between '+STR(@FromMonth)+' + 100* '+STR(@FromYear)+' 
						AND '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
					FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
					TransactionTypeID <>''T00'' AND
					(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

		
--print @StrSQL1
--select isnull(@StrSQL1,'null2')
		 EXEC (@StrSQL1)
	END	

	--print (@StrSQL1)
End

--- TH 2 ---  trong nam YA (lay phat sinh No - Ps Co)
If @CaculatorID ='YA'
begin
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '	
							
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '  
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

		 EXEC (@StrSQL1)	
  END    -----------
  ELSE
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 						
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '


		 EXEC (@StrSQL1)	
  END ---------->>>>
  --print (@StrSQL1)
end
----TH3 --- So du trong ky (Lay no - co den hien tai BA)
If @CaculatorID ='BA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5,					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				--TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 					
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				--TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''  			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)	
  END   
  ELSE
  BEGIN
		
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				--TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )  					
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND
				--TransactionTypeID <>''T00'' AND
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )  			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
		
			 EXEC (@StrSQL1)	
  END
   
   --print (@StrSQL1)
--Print @CaculatorID+'  '+@AnaID+'  '+@BudgetID+ '  '+@FromAccountID+'  '+@ToAccountID+' ma ptc: '+@FromAnaID

---- TH6 ---- So du lk truoc BL
If @CaculatorID ='BL'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''					
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
	---------------->>
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''  			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
  END   
  Else
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 				
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )   			
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
  END   
  --print (@StrSQL1)
---- TH7 ----Phat sinh Co trong nam YC
If @CaculatorID ='YC'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) *(-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''	
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) *(-1) AS  Amount'+@Stri + @StrSelect1 + '	
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+'''
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
  END  
  Else
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) *(-1) AS  Amount'+@Stri + @StrSelect1 + '	
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 
			 
			 '
		
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) *(-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''C'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' )
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
			 EXEC (@StrSQL1)
  END  
--print (@StrSQL1)

---- TH8 ----Phat sinh No trong nam YD


--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='YD'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
	
			 EXEC (@StrSQL1)
  END   
  Else
  BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranYear  between '+STR(@FromYear)+' AND '+STR(@ToYear)+')  AND
				D_C = ''D'' AND TransactionTypeID <>''T00'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
			 EXEC (@StrSQL1)
  END
  --print (@StrSQL1) 

---- TH9 ---- So dau nam theo nien do Nhat (dau ky 4) -  customize cho Meiko


--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='JBY'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 	
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  3 + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  3 + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
		
			 EXEC (@StrSQL1)
	 END		   
	 Else
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  3 + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				(TranMonth+TranYear*100 <=  3 + 100*'+STR(@ToYear)+')  AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
		
			 EXEC (@StrSQL1)
	 END
--print (@StrSQL1)	 	  
---- TH10 ---- So du dau ky ben No ('BD')

--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BD'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
		
			 EXEC (@StrSQL1)
	 END	  
	 Else
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
			 EXEC (@StrSQL1)
	 END	 
--print (@StrSQL1)
---- TH11---- So du dau ky ben Co ('BC')

--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BC'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '	
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
	 END	  
	 Else
	 BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <  '+STR(@FromMonth)+' + 100*'+STR(@FromYear)+') or TransactionTypeID=''T00'')  AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
	 END	  
--print (@StrSQL1)

---- TH12---- So du cuoi ky ben Co ('EC')

--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='EC'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')) AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+'))  AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
	 END	  
	 Else
	 BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '	 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')) AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + '
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) * (-1) AS  Amount'+@Stri + @StrSelect1 + '			
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')) AND
				D_C = ''C'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '

			 EXEC (@StrSQL1)
	 END

---- TH12---- So du cuoi ky ben No ('ED')

--Set @Amount = isnull(@Amount,0)

If @CaculatorID ='ED'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
			SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+'))  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + ' 		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+'))  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) AND
				CorAccountID between '''+@FromCorAccountID+''' AND '''+@ToCorAccountID+''' 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
		
			 EXEC (@StrSQL1)
	 END	  
	 Else
	 BEGIN
		SET @StrSQL1 = '
		INSERT INTO '+@StrTable+'  (	DivisionID, ReportCode, LineID, GroupID1, 
					GroupID2, GroupID3, GroupID4, GroupID5, 					
					Amount'+@Stri+',' + @StrInsert + '
					GroupName1, GroupName2, GroupName3, GroupName4, GroupName5)  
		SELECT	T1.*
				'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN  ', V921.SelectionName AS GroupName1' ELSE ', NULL AS GroupName1' END
				+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN  ', V922.SelectionName AS GroupName2' ELSE ', NULL AS GroupName2' END
				+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN  ', V923.SelectionName AS GroupName3' ELSE ', NULL AS GroupName3' END
				+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN  ', V924.SelectionName AS GroupName4' ELSE ', NULL AS GroupName4' END			
				+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN  ', V925.SelectionName AS GroupName5' ELSE ', NULL AS GroupName5' END+'
		FROM 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+')) AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
				'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				 +CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				 +CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END + 
			') AS T1
			'+ CASE WHEN @Selection01 <> '' AND @Selection01 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Selection01 + ''' AND V921.SelectionID = T1.GroupID1 AND V921.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection02 <> '' AND @Selection02 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Selection02 + ''' AND V922.SelectionID = T1.GroupID2 AND V922.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection03 <> '' AND @Selection03 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Selection03 + ''' AND V923.SelectionID = T1.GroupID3 AND V923.DivisionID = T1.DivisionID' ELSE '' END		
			+ CASE WHEN @Selection04 <> '' AND @Selection04 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V924 ON V924.SelectionType = ''' + @Selection04 + ''' AND V924.SelectionID = T1.GroupID4 AND V924.DivisionID = T1.DivisionID' ELSE '' END
			+ CASE WHEN @Selection05 <> '' AND @Selection05 IS NOT NULL THEN 
			' LEFT JOIN AV6666 AS V925 ON V925.SelectionType = ''' + @Selection05 + ''' AND V925.SelectionID = T1.GroupID5 AND V925.DivisionID = T1.DivisionID' ELSE '' END+'
			
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@StrTable+' T2
										WHERE T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''')
							  )
			 
			 '
		 
		 SET @StrSQL1 = @StrSQL1 + '
		UPDATE 	T1					 
		SET		T1.Amount'+@Stri+' = T2.Amount'+@Stri + @StrUpdate + ' 
		FROM	'+@StrTable+' T1
		inner JOIN 
		(
				SELECT	'''+@DivisionID+''' AS DivisionID , '''+@ReportCode+''' AS ReportCode, '''+@LineID+''' AS LineID, 
						'+CASE WHEN ISNULL(@Selection01,'') <> '' THEN 'Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  'NULL' END + ' AS GroupID1,
						'+CASE WHEN ISNULL(@Selection02,'') <> '' THEN 'Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  'NULL' END + ' AS GroupID2,		
						'+CASE WHEN ISNULL(@Selection03,'') <> '' THEN 'Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  'NULL' END + ' AS GroupID3,
						'+CASE WHEN ISNULL(@Selection04,'') <> '' THEN 'Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  'NULL' END + ' AS GroupID4,
						'+CASE WHEN ISNULL(@Selection05,'') <> '' THEN 'Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  'NULL' END + ' AS GroupID5,				
						sum(SignAmount) AS  Amount'+@Stri + @StrSelect2 + '		
				FROM AV9091 
				Where AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 				
				( (TranMonth+TranYear*100 <=  '+STR(@ToMonth)+' + 100*'+STR(@ToYear)+'))  AND
				D_C = ''D'' AND
				FilterMaster = '''+@AnaID+''' AND BudgetID = '''+@BudgetID+''' AND				
				(FilterDetail between '''+@FromAnaID+''' AND  '''+@ToAnaID+''' ) 
				GROUP BY DivisionID
			   '+CASE WHEN ISNULL(@Selection01,'') <> '' THEN ', Ana'+RIGHT(@Selection01,LEN(@Selection01) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection02,'') <> '' THEN ', Ana'+RIGHT(@Selection02,LEN(@Selection02) -1)+'ID' ELSE  '' END	
				+CASE WHEN ISNULL(@Selection03,'') <> '' THEN ', Ana'+RIGHT(@Selection03,LEN(@Selection03) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection04,'') <> '' THEN ', Ana'+RIGHT(@Selection04,LEN(@Selection04) -1)+'ID' ELSE  '' END
				+CASE WHEN ISNULL(@Selection05,'') <> '' THEN ', Ana'+RIGHT(@Selection05,LEN(@Selection05) -1)+'ID' ELSE  '' END	 + 
			
			') T2
			ON T1.LineID = T2.LineID AND T1.ReportCode = T2.ReportCode 
											  AND isnull(T1.GroupID1,'''') = isnull(T2.GroupID1,'''') 
											  AND isnull(T1.GroupID2,'''') = isnull(T2.GroupID2,'''') 
											  AND isnull(T1.GroupID3,'''') = isnull(T2.GroupID3,'''') 
											  AND isnull(T1.GroupID4,'''') = isnull(T2.GroupID4,'''') 
											  AND isnull(T1.GroupID5,'''') = isnull(T2.GroupID5,'''') 
		 '
			 EXEC (@StrSQL1)
	 END	 
--print (@StrSQL1)
					
DELETE FROM	A00007 WHERE SPID = @@SPID





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

