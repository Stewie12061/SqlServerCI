IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0432]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0432]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách các khoản doanh thu lô đất (master) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 19/04/2022 by Kiều Nga
----Modify on 23/04/2022 by Kiều Nga : Fix lỗi Load khoản thu đã kế thừa
-- <Example>
/*  
 EXEC AP0432 @DivisionID = N'CBD',@ObjectID= '%',@IsDate = 0,@FromMonth= '12',@FromYear= '2018',@ToMonth = '12',@ToYear = '2018',@ContractType = '%',@Mode = '1',@VoucherID = '',@StoreID = '%'

 AP0432 @DivisionID,@ObjectID,@IsDate,@FromMonth,@FromYear,@ToMonth,@ToYear,@ContractType,@Mode,@VoucherID,@StoreID
*/
----
CREATE PROCEDURE AP0432 ( 
        @DivisionID VARCHAR(50),
		@ObjectID VARCHAR(50),
		@IsDate TINYINT,
		@FromMonth INT,
	  	@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@Mode TINYINT, ---Mode = 0 addnew, =1 edit 
		@VoucherID VARCHAR (50),  ---add new ''
		@ContractNo VARCHAR (50)
)
AS

Declare
 @sSQL as nvarchar(max) = '',
 @sWhere as nvarchar(MAX) = ''


IF @IsDate = 1
Set  @sWhere = @sWhere +  'And (T1.TranMonth + T1.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'

IF ISNULL(@ObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND T1.ObjectID like ''%' + @ObjectID + '%'''

IF ISNULL(@ObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND T1.ContractNo like ''%' + @ContractNo + '%'''

 CREATE TABLE #TAM
	(
		APK nvarchar(50) ,
		ConvertedAmount decimal(28,8),
		OriginalAmount decimal(28,8)
	)

-----Lấy khoản thu chưa thanh toán đủ tiền 
 Set  @sSQL = '
	INSERT INTO #TAM  (APK,ConvertedAmount,OriginalAmount)
	SELECT T1.APK AS APK,ISNULL(H.ConvertedAmount,0),ISNULL(H.OriginalAmount,0)
	FROM AT0420 T1 WITH (NOLOCK)
	LEFT JOIN (SELECT SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount,T1.APK 
				FROM AT0420 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T2.InheritVoucherID
				WHERE T2.InheritTableID = ''AT0420''
				GROUP BY T1.APK) AS H ON H.APK = T1.APK  
	WHERE T1.DivisionID = ''' +@DivisionID+ ''' 
	AND T1.Amount > ISNULL(H.ConvertedAmount,0)
	' + @sWhere + ' 
	ORDER BY T1.ContractNo	
	'

	EXEC(@sSQL)

SET @sSQL = '
SELECT	DISTINCT T1.ContractNo,T1.ObjectID, T2.ObjectName
FROM AT0420 T1 WITH (NOLOCK)
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.ObjectID = T1.ObjectID 
INNER JOIN #TAM WITH (NOLOCK) ON #TAM.APK = T1.APK
WHERE T1.DivisionID = ''' + @DivisionID + '''
' + @sWhere + ''

Print (@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
