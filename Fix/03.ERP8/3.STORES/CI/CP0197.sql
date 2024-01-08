IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0197]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0197]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load Danh mục hợp đồng màn hình SIKICO
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga  on: 28/03/2022
---- Modify by Kiều Nga on 22/04/2022    Load thông tin tình trạng hợp đồng 
-- <Example>
/*
	 CP0197 @DivisionID = N'CBD',@UserID= N'ASOFTADMIN',@FromDate=N'2018-12-01',@ToDate= N'2018-12-30',@ContractType='4',@StatusID= N'1',@IsContract = '0',@IsDate = N'0'
	
	 CP0197 @DivisionID,@UserID,@FromDate,@ToDate,@All,@ContractType,@StatusID,@IsContract,@IsDate
*/

 CREATE PROCEDURE CP0197
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromMonth AS int,
	@FromYear AS int,
	@ToMonth AS int,
	@ToYear AS int,
	@IsDate AS int,
	@ContractType NVARCHAR(50),
	@PlotID NVARCHAR(50),
	@IsAll TINYINT
)
AS


DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N''



SET @OrderBy = 'A1.ContractNo'

---loại hợp đồng 

IF ISNULL(@ContractType,'') <> '' AND ISNULL(@ContractType,'') <> '%'
SET @sWhere = @sWhere + '
AND (A1.ContractType = ' + @ContractType + ')'

-----lô đất
IF ISNULL(@PlotID,'') <> ''  AND ISNULL(@PlotID,'') <> '%'
SET @sWhere = @sWhere + '
AND (A2.PlotID = ''' + @PlotID + ''')'

IF @IsAll = 1 ----0: TẤT CẢ 
	SET  @sWhere = @sWhere +'
		AND 1 = 1'
ELSE IF @IsDate = 1 
	Set  @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,A1.SignDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''''
ELSE 
	Set  @sWhere = @sWhere + '
		AND A1.TranMonth + A1.TranYear*100 between '+str(@FromMonth+@FromYear*100)+' and '+str(@ToMonth+@ToYear*100)+''

SET @sSQL = N' 
	SELECT DISTINCT A1.APK, A1.DivisionID, A1.ContractNo, A1.ContractName,A1.SignDate,A1.BeginDate,A1.EndDate,A1.ContractType,A3.Description AS ContractTypeName, 
	A1.ObjectID, A4.ObjectName,A1.CreateDate,A6.Description as StatusName  --,A2.PlotID,A5.StoreName as PlotName
	FROM CT0155 A1 WITH (NOLOCK) 
	LEFT JOIN CT0156 A2 WITH (NOLOCK) ON A2.DivisionID IN (A1.DivisionID, ''@@@'') AND A2.APKMaster = A1.APK
	LEFT JOIN AT0099 A3 WITH (NOLOCK) ON A1.ContractType = A3.ID AND A3.CodeMaster = ''ContractTypeID''
	LEFT JOIN AT1202 A4 WITH (NOLOCK) ON A4.DivisionID IN (A1.DivisionID, ''@@@'') AND  A4.ObjectID = A1.ObjectID
	LEFT JOIN AT0416 A5 WITH (NOLOCK) ON A5.DivisionID IN (A2.DivisionID, ''@@@'') AND  A5.StoreID = A2.PlotID
	LEFT JOIN AT0099 A6 WITH (NOLOCK) ON A1.StatusID = A6.ID AND A6.CodeMaster = ''StatusPlot''
	WHERE A1.DivisionID = ''' + @DivisionID + '''
	'+@sWhere +'
	ORDER BY A1.CreateDate DESC'

PRINT @sSQL
EXEC(@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
