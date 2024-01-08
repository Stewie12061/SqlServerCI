IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3079]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3079]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo lịch sử mua hàng theo khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Tiểu Mai, Date: 10/07/2018
-- <Example>
---- 
/*-- <Example>
  
  EXEC POSP3079 'VS', 'VS','', 'CH03'',''CH02'',''CH01',1, '2018-06-01', '2018/06/30','','VIP01',''


----*/

CREATE PROCEDURE POSP3079 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),	
	@FromMemberID		VARCHAR(MAX),
	@ToMemberID			VARCHAR(MAX)
	
	
)
AS
DECLARE @sSQL   NVARCHAR(MAX),  
		@sWhere NVARCHAR(MAX),
		@Date  NVARCHAR(MAX),
		@GroupDate NVARCHAR(MAX)
SET @GroupDate = ''
SET @Date = ''
SET @sWhere = ''

--Check Para DivisionIDList null then get DivisionID 
IF Isnull(@DivisionIDList,'') = ''
SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
Else 
SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
--Search theo ngày/ theo kỳ
IF @IsDate = 1	
Begin
	SET @Date = @Date + ''''+CONVERT(VARCHAR,@FromDate,103)  +''' as FromDate,'''+CONVERT(VARCHAR,@ToDate,103)+ ''' as ToDate'
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	
end
ELSE
Begin
	SET @Date = @Date + ' M.TranMonth, M.TranYear, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) as MonthYear '
	SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	SET @GroupDate = @GroupDate + ',M.TranMonth, M.TranYear'
End	
--Check Para @ShopIDList null then get ShopID 
IF Isnull(@ShopIDList,'') = ''
SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
Else 
SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'
 --Search theo khách hàng 
IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
	SET @sWhere = @sWhere + ' AND M.MemberID > = N'''+@FromMemberID +''''
ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere = @sWhere + ' AND M.MemberID < = N'''+@ToMemberID +''''
ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
	SET @sWhere = @sWhere + ' AND M.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''     
               
               
               
          
 	    
SET @sSQL = N'	select M.MemberID, M.MemberName, VoucherDate, VoucherNo ,(D.ActualQuantity * D.UnitPrice) as Amount,P802.ConvertedAmount	, P10.ShopName
from POST0016 M WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited 
Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID	
where M.DeleteFlg = 0'+@sWhere+'
Group by  M.MemberID, M.MemberName, VoucherDate, VoucherNo ,P802.ConvertedAmount	, P10.ShopName,D.ActualQuantity , D.UnitPrice
order by M.MemberID
'


exec (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

			