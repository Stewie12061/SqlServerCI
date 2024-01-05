IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2008_AIC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2008_AIC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load form xem thông tin đợt chi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN\ Nghiệp vụ \ Kết quả thu chi thực tế\ Xem chi tiết phiếu\ Tab đợt chi
---- ASOFT - FN\ Nghiệp vụ \ Kế hoạch thu chi\ Xem chi tiết phiếu\ Tab đợt chi
-- <History>
----Created by: Như Hàn, Date: 03/01/2019
---- Modified on 02/04/2019 by Như Hàn : Hiển thị Nguồn vốn theo các đợt chi (nếu có)
-- <Example>
---- 
/*-- <Example>
	FNP2008_AIC @DivisionID = 'AIC', @APKMaster = '557C7835-7D69-48FB-8DAE-466E4D8D71D3', @APK = '557C7835-7D69-48FB-8DAE-466E4D8D71D3',@IsViewDetail=0,@PageNumber=1,@PageSize=20

	FNP2008_AIC @DivisionID, @APKMaster, @APK, @IsViewDetail, @PageNumber, @PageSize
----*/

CREATE PROCEDURE FNP2008_AIC
( 
	 @DivisionID VARCHAR(50),
	 @APKMaster VARCHAR(50), --- truyền màn hình view
	 @APK VARCHAR(50),--- truyền màn hình edit
	 @IsViewDetail TINYINT = 0,	--- 0: màn hình edit, 1: màn hình view
	 @PageNumber INT,
     @PageSize INT
)
AS 
     
DECLARE @sSQL NVARCHAR (MAX),
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
SET @sSQL = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsViewDetail = 1
	BEGIN

		SET @sSQL = @sSQL + N'
		SELECT APK 
		INTO #APK
		FROM FNT2001 WHERE APKMaster = ''' + @APKMaster + ''' AND DivisionID = ''' + @DivisionID + '''
		'
		SET @sSQL = @sSQL + N'
		SELECT '+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY [Order]) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +' 
		T28.APK, T28.APKMaster, [Order], T28.DivisionID, T28.PaymentDate, T28.POAmount, T28.PCAmount, T28.APaymentDate, 
		T28.AOAmount, T28.ACAmount, T28.DeleteFlag, T28.Ana10ID, T11.AnaName As Ana10Name
		FROM FNT2008_AIC T28 WITH (NOLOCK)
		LEFT JOIN AT1011 T11 WITH (NOLOCK) ON T11.AnaID = T28.Ana10ID AND T11.AnaTypeID = ''A10''
		WHERE T28.DeleteFlag = 0 AND T28.DivisionID = ''' + @DivisionID + ''' AND T28.APKMaster IN (SELECT APK FROM #APK) 
		ORDER BY [Order]
		'
		SET @sSQL = @sSQL+ N'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		
	END
ELSE 
	BEGIN
	SET @sSQL = @sSQL + N'SELECT
	T28.APK, T28.APKMaster, [Order], T28.DivisionID, T28.PaymentDate, T28.POAmount, T28.PCAmount, T28.APaymentDate, 
	T28.AOAmount, T28.ACAmount, T28.DeleteFlag, T28.Ana10ID, T11.AnaName As Ana10Name
	FROM FNT2008_AIC T28 WITH (NOLOCK)
	LEFT JOIN AT1011 T11 WITH (NOLOCK) ON T11.AnaID = T28.Ana10ID AND T11.AnaTypeID = ''A10''
	WHERE T28.DeleteFlag = 0 AND T28.DivisionID = ''' + @DivisionID + ''' AND T28.APKMaster = ''' + @APK+ '''
	ORDER BY [Order]'
	END


EXEC (@sSQL)

PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
