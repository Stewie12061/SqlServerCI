IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1510_HUNGTHINH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1510_HUNGTHINH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----Created by Hoang Thi Lan  
---Created Date: 07/10/2003  
----Purpose:Dung cho Report AR1510(Report khau hao tai san co dinh)  
----Edit by: Nguyen Quoc Huy  
----Edit by: Nguyen Thi Ngoc Minh.  
---- Last Edit by  Van Nhan, note: Division like '%'  
----Edit by: Nguyen Quoc Huy, note: Add DepMonths  
---- Last Edit : Nguyen Thuy Tuyen. 26/10/2006  Lay ngay Giam TSCD, 14/07/2008, 08/08/2008,15/08/2008,18/02/2009,24/09/2009  
---- Last Eidt : Thuy Tuyen ,  date : 03/02/2009   
---- Last Edit:  Thuy Tuyen, date  18/03/2010 .. xu ly where theo Assetstatus  
---- Modified on 11/03/2013 by Lê Thị Thu Hiền : Bổ sung 1 số trường từ bảng AT9000 vào View av1510 (mantis 0020310 )  
---- Modified on 15/10/2013 by Khanh Van: Customize cho Sieu Thanh
---- Modified on 08/12/2013 by Bảo Anh: Bổ sung trường lũy kế trong năm DepAmountInYear (mantis 0021725) 
---- Modified on 11/03/2013 by Lê Thị Thu Hiền : Bo sung them Nguoi quan ly
---- Modified on 17/04/2015 by Thanh Sơn: Bổ sung customize cho LongGiang
---- Modified on 11/06/2015 by Bảo Anh: Lọc dữ liệu theo thời gian của niên độ tài chính do nguời dùng định nghĩa
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 26/07/2016: Fix bug ko hiện báo cáo do INNER JOIN
---- Modified on 08/06/2017 by Bảo Anh: Bổ sung CrDepOriginalAmount, CrDepConvertedAmount
---- Modified by Tiểu Mai on 30/08/2017: Fix bug lên báo cáo sai số kỳ đã khấu hao
---- Modified by Huỳnh Thử on 16/04/2021: Lấy store cũ bên 8.1 qua
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/********************************************  
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]  
'********************************************/  
---- exec AP1510 @Divisionid=N'BBL',@Frommonth=1,@Fromyear=2015,@Tomonth=5,@Toyear=2015,@Ismonth=1,@Grouptype=3,@Condition=N'(0,1,2,3,4,9)'  
  
CREATE PROCEDURE [dbo].[AP1510_HUNGTHINH]    
    @DivisionID AS nvarchar(50),  
    @FromMonth as int,  
    @FromYear as int,  
    @ToMonth as int,  
    @ToYear as int,
	@IsMonth as tinyint,
    @GroupType as tinyint,  ---  0 la khong nhom  
        ----  1 theo tai khoan  
        ---- 2 Bo phan su dung  
        ---- 3 Phan loai tai san  
    @Condition as nvarchar(50)  
      
 AS  
declare   
	@FromPeriod as int,  
	@ToPeriod as int,
	@FromPeriod_Year as int,  
	@ToPeriod_Year as int,  
	@sSQL AS nvarchar(MAX),  
	@sSQL1 AS nvarchar(MAX),  
	@sqlTemp AS nvarchar(MAX),
	@sSQL2 AS NVARCHAR(MAX), 
	@sSQL3 AS NVARCHAR(MAX),
	@sSQL4 AS NVARCHAR(MAX)='',
	@sFROM AS NVARCHAR(MAX),  
	@sWHERE AS NVARCHAR(MAX),  
   
	@GroupID as nvarchar(250),  
	@tmp cursor,  
	@i as int,
	@BeginMonth as int   
---Set @Condition  = ''  

	DECLARE	@CustomerName INT 
		
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
	DROP TABLE #CustomerName

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444

SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
--- Lấy tháng bắt đầu niên độ kế toán
SELECT @BeginMonth = Month(StartDate) FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID
IF ISNULL(@BeginMonth,0) = 0	SET @BeginMonth = 1

set @FromPeriod = @FromMonth + @FromYear * 100  
set @ToPeriod = @ToMonth + @ToYear * 100  
set @FromPeriod_Year = @BeginMonth + @ToYear * 100
set @ToPeriod_Year = @ToMonth + @ToYear * 100 
  
If @GroupType = 0    
 Set @GroupID =' '''' AS  GroupID,  ''''   as GroupName '  
If @GroupType = 1    
 Set @GroupID =' AT1503.AssetAccountID as GroupID, AT1005.AccountName as GroupName '  
If @GroupType = 2   
 Set @GroupID =' AT1503.DepartmentID as GroupID, AT1102.DepartmentName as GroupName '  
   
If @GroupType = 3   
 Set @GroupID =' AT1503.AssetGroupID as GroupID, AT1501.AssetGroupName as GroupName ' 

IF (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK)) = 40 ---- LONGGIANG
SET @sSQL = '
SELECT DivisionID, AssetID, CreditAccountID, DebitAccountID, SUM(T1DepAmount) T1DepAmount,  SUM(T2DepAmount) T2DepAmount,  SUM(T3DepAmount) T3DepAmount,  SUM(T4DepAmount) T4DepAmount,
	 SUM(T5DepAmount) T5DepAmount,  SUM(T6DepAmount) T6DepAmount,  SUM(T7DepAmount) T7DepAmount,  SUM(T8DepAmount) T8DepAmount,
	 SUM(T9DepAmount) T9DepAmount,  SUM(T10DepAmount) T10DepAmount, SUM(T11DepAmount) T11DepAmount, SUM(T12DepAmount) T12DepAmount,
	 (SELECT SUM(DepAmount) FROM AT1504 WITH (NOLOCK) WHERE DivisionID = A.DivisionID AND AssetID = A.AssetID
											AND TranMonth + TranYear * 100 < '+STR(@FromPeriod)+') FirstDebAmount
FROM
(
	SELECT AT1504.DivisionID, At1504.AssetID, Sum(AT1504.DepAmount) as DepAmount, TranMonth, TranYear,   
		(Case when '+ str(@IsMonth ) + ' = 0 Then ltrim(Rtrim(str(TranMonth))) + ''/'' +  Ltrim(Rtrim(str(TranYear))) else    
		Case When '+ str(@IsMonth ) + ' = 1 Then (select Quarter from FV9999 Where DivisionID = AT1504.DivisionID and TranMonth = AT1504.TranMonth and TranYear = AT1504.TranYear) else   
		Ltrim(Rtrim(str(TranYear))) end  end) as MonthYear,
		CASE WHEN TranMonth = 1 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T1DepAmount,
		CASE WHEN TranMonth = 2 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T2DepAmount, 
		CASE WHEN TranMonth = 3 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T3DepAmount, 
		CASE WHEN TranMonth = 4 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T4DepAmount, 
		CASE WHEN TranMonth = 5 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T5DepAmount, 
		CASE WHEN TranMonth = 6 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T6DepAmount, 
		CASE WHEN TranMonth = 7 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T7DepAmount,
		CASE WHEN TranMonth = 8 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T8DepAmount, 
		CASE WHEN TranMonth = 9 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T9DepAmount, 
		CASE WHEN TranMonth = 10 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T10DepAmount,
		CASE WHEN TranMonth = 11 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T11DepAmount, 
		CASE WHEN TranMonth = 12 THEN SUM(ISNULL(AT1504.DepAmount, 0)) ELSE 0 END T12DepAmount,
		CreditAccountID, DebitAccountID
	FROM AT1504   WITH (NOLOCK)
	LEFT JOIN AT1503 WITH (NOLOCK) on at1503.AssetID = At1504.AssetID and at1503.DivisionID = At1504.DivisionID  
	WHERE	At1504.DivisionID = AT1503.DivisionID and  
			At1504.AssetID = At1503.AssetID and  
			AT1504.TranMonth+AT1504.TranYear*100 between ' + str(@FromPeriod) + '  and ' + str(@ToPeriod )+'  
			and AT1503.DivisionID = '''+@DivisionID+'''  
	GROUP BY TranMonth, TranYear, At1504.AssetID,AT1504.DivisionID, CreditAccountID, DebitAccountID
)A
GROUP BY DivisionID, AssetID, CreditAccountID, DebitAccountID'
ELSE SET @sSQL = '  
SELECT AT1504.DivisionID, At1504.AssetID, Sum(AT1504.DepAmount) as DepAmount, TranMonth, TranYear,   
		(Case when '+ str(@IsMonth ) + ' = 0 Then ltrim(Rtrim(str(TranMonth))) + ''/'' +  Ltrim(Rtrim(str(TranYear))) else    
		Case When '+ str(@IsMonth ) + ' = 1 Then (select Quarter from FV9999 Where DivisionID = AT1504.DivisionID and TranMonth = AT1504.TranMonth and TranYear = AT1504.TranYear) else   
		Ltrim(Rtrim(str(TranYear))) end  end) as MonthYear
FROM AT1504   WITH (NOLOCK)
LEFT JOIN AT1503 WITH (NOLOCK) on at1503.AssetID = At1504.AssetID and at1503.DivisionID = At1504.DivisionID  
WHERE	At1504.DivisionID = AT1503.DivisionID and  
		At1504.AssetID = At1503.AssetID and  
		AT1504.TranMonth+AT1504.TranYear*100 between ' + str(@FromPeriod) + '  and ' + str(@ToPeriod )+'  
		and AT1503.DivisionID = '''+@DivisionID+'''  
GROUP BY TranMonth, TranYear, At1504.AssetID,AT1504.DivisionID  '  
  
PRINT (@sSQL)  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV1516')  
 EXEC ('CREATE VIEW AV1516 AS '+@sSQL)  
ELSE  
 EXEC( 'ALTER VIEW AV1516 AS '+@sSQL)  
  
--- Tao view xu ly tam AssetStatus,  
Set @sSQL = '  
SELECT AT1503.DivisionID, AT1503.AssetID,  
		(Case when isnull(T03.AssetID,'''') ='''' and isnull(AT1523.AssetID,'''') =''''  or (isnull(AT1523.AssetID,'''') <> '''') then   
		AT1503.AssetStatus   
		else 0 end) as AssetStatus 
FROM  AT1503   WITH (NOLOCK) 
LEFT JOIN AT1523 WITH (NOLOCK) on AT1523.AssetID = AT1503.AssetID And AT1523.DivisionID = AT1503.DivisionID  
				and  AT1523.ReduceMonth+AT1523.ReduceYear*100 <= ' + str( @ToPeriod)+'  
LEFT JOIN AT1523 T03 WITH (NOLOCK) on T03.AssetID = AT1503.AssetID And T03.DivisionID = AT1503.DivisionID   
WHERE AT1503.DivisionID = '''+@DivisionID+''''  

PRINT (@sSQL)   
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV1517')  
 EXEC ('CREATE VIEW AV1517 AS '+@sSQL)  
ELSE  
 EXEC( 'ALTER VIEW AV1517 AS '+@sSQL)  
  
----- Lay bao cao so chi tiet TSCD-----------------------  
set @sSQL = '   
SELECT AT1503.DivisionID,  
 AT1503.AssetID,  
    AT1503.AssetName,   
 '''' as Unit,  
 1 as Quantity,  
 AT1503.SerialNo,  
 AT1503.InvoiceNo,  
 AT1503.InvoiceDate,  
 AT1503.DepartmentID,  
 AT1102.DepartmentName,  
-- Nguyen gia  
 (Case when exists (select top 1 AssetID   
      from AT1506 WITH (NOLOCK)    
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
 Then (select top 1 AT1506.ConvertedNewAmount   
   From AT1506 WITH (NOLOCK)    
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod ) + '  
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
 Else AT1503.ConvertedAmount end) as ConvertedAmount,   
-- Dau ky   
 Isnull((Case when exists (select top 1 AssetID   
      from AT1506    WITH (NOLOCK) 
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <' + str(@FromPeriod) + ')   
       and (isnull(AT1523.ReduceDate,'''')='''' or AT1523.ReduceMonth+100*AT1523.ReduceYear>=' + str(@FromPeriod) + ')  
         
 Then (select top 1 AT1506.ConvertedNewAmount   
   From AT1506  WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear <' + str(@FromPeriod ) + '  
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
     
 Else (Select AT03.ConvertedAmount   
   From AT1503 AT03   WITH (NOLOCK)  
   Where AT03.AssetID = AT1503.AssetID and AT03.DivisionID = AT1503.DivisionID   
   and Month(AT1503.EstablishDate) + Year(AT1503.EstablishDate)*100 <    ' + str(@FromPeriod) + '  
   and (isnull(AT1523.ReduceDate,'''')='''' or AT1523.ReduceMonth+100*AT1523.ReduceYear>=' + str(@FromPeriod) + ')) end),0) as BeConvertedAmount,   
-- Tang trong ky   
 Isnull((Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)   
      Where AT1506.AssetID = AT1503.AssetID   
      and AT1503.DivisionID = AT1503.DivisionID  
      and AT1506.ConvertedOldAmount < AT1506.ConvertedNewAmount  
      and AT1506.TranMonth + 100*AT1506.TranYear between ' + str(@FromPeriod) + ' and  ' + str(@ToPeriod) + ')   
         
 Then (select sum(AT1590.ConvertedAmount)  
   From AT1506 WITH (NOLOCK)  inner join AT1590 WITH (NOLOCK)  on AT1590.DivisionID = AT1506.DivisionID   
   and AT1590.VoucherID = AT1506.RevaluateID  
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear between' + str(@FromPeriod ) + ' and ' + str(@ToPeriod ) + ')  
     
 Else (Select AT03.ConvertedAmount   
   From AT1503 AT03  WITH (NOLOCK)   
   Where AT03.AssetID = AT1503.AssetID and AT03.DivisionID = AT1503.DivisionID   
   and Month(AT1503.EstablishDate) + Year(AT1503.EstablishDate)*100 between   ' + str(@FromPeriod) + 'and ' + str(@ToPeriod ) + ')end),0) as DeConvertedAmount,   '
Set @sSQL1 = N' 
-- Giam trong ky   
 Isnull((Case when exists (select top 1 AssetID    from AT1523 WITH (NOLOCK)      
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID    
   and AT1523.ReduceMonth + 100*AT1523.ReduceYear between ' + str(@FromPeriod) + ' and ' + str(@ToPeriod) + ')   
 Then (select top 1 AT1523.ConvertedAmount     
   From AT1523  WITH (NOLOCK)  
   Where AT1523.AssetID = AT1503.AssetID and AT1523.DivisionID = AT1503.DivisionID    
    and AT1523.ReduceMonth + 100*AT1523.ReduceYear between  ' + str(@FromPeriod) + ' and ' + str(@ToPeriod) + '   
   Order by AT1523.ReduceYear Desc,AT1523.ReduceMonth Desc)   
   when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)   
      Where AT1503.AssetID = AT1503.AssetID   
      and AT1503.DivisionID = AT1503.DivisionID  
      and AT1506.ConvertedOldAmount > AT1506.ConvertedNewAmount  
      and AT1506.TranMonth + 100*AT1506.TranYear between ' + str(@FromPeriod) + ' and  ' + str(@ToPeriod) + ')  
        
   Then (select sum(AT1590.ConvertedAmount)  
   From AT1506 WITH (NOLOCK)  inner join AT1590 WITH (NOLOCK)  on AT1590.DivisionID = AT1506.DivisionID   
   and AT1590.VoucherID = AT1506.RevaluateID  
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear between' + str(@FromPeriod ) + ' and ' + str(@ToPeriod ) + ')   
   Else 0 end ),0) as CrConvertedAmount,  
        
 AT1503.StartDate,  
 AT1503.EndDate,     
 AT1503.BeginMonth,  
 AT1503.BeginYear,  
  
 (Case when exists (select top 1 AssetID   
      from AT1506 WITH (NOLOCK)    
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod ) + ')  
 Then (select top 1 AT1506.DepNewPeriods/12    
   From AT1506  WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear  <= ' + str(@ToPeriod ) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
 Else AT1503.Years end) as Years,   
 (Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)   
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
        and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod ) + ')  
 Then (select top 1 AT1506.DepNewPeriods   
   From AT1506  WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear  <=' + str(@ToPeriod ) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
 Else AT1503.DepPeriods end) as DepPeriods,     
 (Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)   
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
        and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod ) + ')  
 Then (select top 1 AT1506.DepNewAmount    
   From AT1506  WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
     and AT1506.TranMonth + 100*AT1506.TranYear  <=' + str(@ToPeriod ) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
 Else AT1503.DepAmount end) * 12 as YearDepAmount,   
 AT1503.AssetAccountID,  
 AT1005.AccountName,  
 AccuDepAmount = ( isnull (AT1503.ConvertedAmount,0)    
   - isnull(AT1503.ResidualValue,0)  
   + isnull((Select Sum(DepAmount)   
      From AT1504  WITH (NOLOCK)   
      Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
      and AT1504.TranMonth+AT1504.TranYear*100 <= ' + str(@ToPeriod) + '),0)),  
 '
 SET @sSQL2 = N'     
 AT1503.ResidualValue,  
 AT1503.Serial,  
 AT1503.SourceID1,  
 AT1503.SourceAmount1,  
 AT1503.SourcePercent1,  
 AT1503.SourceID2,  
 AT1503.SourceAmount2,  
 AT1503.SourcePercent2,  
 AT1503.SourceID3,  
 AT1503.SourceAmount3,  
 AT1503.SourcePercent3,   
 AT1503.MadeYear,  
 (Case when exists (select top 1 AssetID   
      from AT1506   WITH (NOLOCK)  
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
        and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
 Then (select top 1 AT1506.DepNewPercent   
   From AT1506  WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear  <=' + str(@ToPeriod) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
 Else AT1503.DepPercent end) as DepPercent,   
 DepreciatedMonths = isnull(AT1503.DepMonths,0) ' + CASE WHEN @CustomerName IN (50, 57) THEN '' ELSE ' + isnull((Select Count(*)   
        From (Select Distinct AssetID, TranMonth, TranYear, DivisionID   
          From AT1504 WITH (NOLOCK)   
             Group by TranMonth, AssetID, TranYear, DivisionID )  A  
        Where A.AssetID = AT1503.AssetID And A.DivisionID = AT1503.DivisionID   
        and A.TranMonth+A.TranYear*100 <= ' + str(@ToPeriod)+ ' ),0)  
      ' END + ','  
set @sqlTemp = N'
AccuDepAmountTemp =   
isnull(( case when exists (select top 1 AssetID   
      from AT1506 WITH (NOLOCK)    
      Where AT1503.AssetID = AT1503.AssetID   
      and AT1503.DivisionID = AT1503.DivisionID  
      and AT1506.ConvertedOldAmount > AT1506.ConvertedNewAmount  
      and AT1506.TranMonth + 100*AT1506.TranYear <=  ' + str(@ToPeriod) + N')  
        
Then Round(isnull(((select sum(AT1590.ConvertedAmount)  
   From AT1506 WITH (NOLOCK)  inner join AT1590 WITH (NOLOCK)  on AT1590.DivisionID = AT1506.DivisionID   
   and AT1590.VoucherID = AT1506.RevaluateID  
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
    and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + N')/ AT1503.DepPeriods),0)
    *  ( isnull( (Select Count(*)   
        From (Select Distinct AssetID, TranMonth, TranYear, DivisionID   
          From AT1504  WITH (NOLOCK)  
             Group by TranMonth, AssetID, TranYear, DivisionID )  A  
             inner join AT1506 WITH (NOLOCK)  on AT1506.AssetID = A.AssetID and AT1506.DivisionID = A.DivisionID 
        Where A.AssetID = AT1503.AssetID And A.DivisionID = AT1503.DivisionID   
        and A.TranMonth+A.TranYear*100 <= AT1506.TranMonth + 100*AT1506.TranYear ) ,0)
      + isnull(AT1503.DepMonths,0)-1),-3)     
   Else 0 end ),0),'
   
Set @sSQL3 = N'   
 (Case When AT1503.AssetStatus=0 then N''FFML000143''  
   When AT1503.AssetStatus=1 then N''FFML000144''  
   When AT1503.AssetStatus=2 then N''FFML000145''  
   when AT1503.AssetStatus=3 then N''FFML000146''   
   when AT1503.AssetStatus=4 then N''FFML000147''   
  Else N''FFML000148''  
 End) as Status,  
 ' + @GroupID + N',    
 AT1001.CountryName,  
 year(StartDate) as StartYear,  
 DepAmount = isnull((Select Sum(DepAmount)   
      From AT1504  WITH (NOLOCK)   
      Where  DivisionID = AT1503.DivisionID   
        and AssetID = At1503.AssetID   
        and AT1504.TranMonth + AT1504.TranYear * 100 between ' + str(@FromPeriod) + ' and ' + str(@ToPeriod) + N'),0),
 DepAmountInYear = isnull((Select Sum(DepAmount)   
      From AT1504  WITH (NOLOCK)   
      Where  DivisionID = AT1503.DivisionID   
        and AssetID = At1503.AssetID   
        and AT1504.TranMonth + AT1504.TranYear * 100 between ' + str(@FromPeriod_Year) + ' and ' + str(@ToPeriod_Year) + N'),0),
 AT1523.ReduceDate,  
 AT1523.ReduceVoucherNo,  
 AT1523.Notes as ReduceNote,  
 AT1523.ReduceMonth,  
 AT1523.ReduceYear,  
 At1523.ConvertedAmount as ReConvertedAmount,  
 (Case  When AT1523.AssetStatus=2 then    N''FFML000145''  
   when  AT1523.AssetStatus=3 then  N''FFML000146''   
   Else        N''FFML000148''  
 End) as ReduceStatus,  
 AT1503.EstablishDate,  
 AT1503.Notes, '  
 SET @sSQL4 ='
(Select top 1 AT9000.VoucherNo from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK) on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID)AS ReVoucherNo ,   
(Select top 1 AT9000.InvoiceNo from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK)  on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID) as ReInvoiceNo,  
(Select top 1 AT9000.Serial from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK)  on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID)AS ReSerial,  
(Select top 1 AT9000.TDescription from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK)  on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID) AS ReTDescription,   
(Select top 1 AT9000.BDescription from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK)  on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID)as ReBDescription,  
(Select top 1 AT9000.ObjectID from AT9000 WITH (NOLOCK)  inner join AT1533 WITH (NOLOCK)  on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID   
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID)as ReObjectID,  
(Select top 1 AT1202.ObjectName from AT9000 WITH (NOLOCK) inner join AT1533 WITH (NOLOCK) on AT9000.VoucherID = AT1533.ReVoucherID AND AT9000.TransactionID = AT1533.RetransactionID and AT9000.DivisionID = AT1533.DivisionID LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID  
where AT1533.DivisionID = AT1503.DivisionID AND AT1533.AssetID = AT1503.AssetID) as ReObjectName,  
  
 AT1503.AssetStatus,  
    (Case When AT1503.AssetStatus=0 then N''Đang sử dụng''    
   When AT1503.AssetStatus=1 then N''Ngưng khấu hao''    
   When AT1503.AssetStatus=2 then N''Đã nhượng bán''   
   when AT1503.AssetStatus=3 then N''Đã thanh lý''     
   when AT1503.AssetStatus=4 then N''Chưa sử dụng''    
  Else N''Khác''    
  End) as AssetStatusName,   
 '  

SET @sFROM = N'   
AT1503.Parameter01,  
AT1503.Parameter02,  
AT1503.Parameter03,  
AT1503.Parameter04,  
AT1503.Parameter05,  
AT1503.Parameter06,  
AT1503.Parameter07,  
AT1503.Parameter08,  
AT1503.Parameter09,  
AT1503.Parameter10,
AT1503.EmployeeID, AT1103.FullName AS EmployeeName,
AT1503.DebitDepAccountID1,

Isnull((select sum(AT1590.OriginalAmount)  
	   From AT1506 WITH (NOLOCK)
	   inner join AT1590 WITH (NOLOCK)  on AT1590.DivisionID = AT1506.DivisionID and AT1590.VoucherID = AT1506.RevaluateID and AT1590.DebitAccountID like ''214%'' 
	   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
		),0) as CrDepOriginalAmount,
 
Isnull((select sum(AT1590.ConvertedAmount)  
	   From AT1506 WITH (NOLOCK)
	   inner join AT1590 WITH (NOLOCK)  on AT1590.DivisionID = AT1506.DivisionID and AT1590.VoucherID = AT1506.RevaluateID and AT1590.DebitAccountID like ''214%'' 
	   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
		),0) as CrDepConvertedAmount
 
FROM AT1503  WITH (NOLOCK)  
LEFT JOIN AT1001 WITH (NOLOCK) on AT1503.CountryID=AT1001.CountryID AND AT1503.DivisionID=AT1001.DivisionID  
LEFT JOIN AT1005  WITH (NOLOCK) on AT1005.AccountID = AT1503.AssetAccountID AND AT1005.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1102 WITH (NOLOCK) on AT1102.DepartmentID = AT1503.DepartmentID and AT1102.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1501 WITH (NOLOCK) on At1501.AssetGroupID = AT1503.AssetGroupID AND At1501.DivisionID = AT1503.DivisionID   
LEFT JOIN AT1523 WITH (NOLOCK) on AT1523.AssetID = AT1503.AssetID AND AT1523.DivisionID = AT1503.DivisionID  
LEFT JOIN AV1517 on AV1517.AssetID = AT1503.AssetID AND AV1517.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = AT1503.EmployeeID and AT1103.DivisionID = AT1503.DivisionID    
'  
SET @sWHERE = N'  
WHERE  AT1503.DivisionID like N''' + @DivisionID + ''' and   
 AV1517.AssetStatus in  ' + isnull(@Condition,'') + ' and   
 Month(AT1503.EstablishDate) + Year(AT1503.EstablishDate)*100 <= ' + str(@ToPeriod) + '  
  
'  
  
     
PRINT (@sSQL)  
PRINT (@sqlTemp)  
PRINT (@sSQL1)  
PRINT (@sSQL2)  
PRINT (@sSQL3)  
PRINT (@sSQL4)  
PRINT (@sFROM)  
PRINT (@sWHERE)  

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV1510')  
 EXEC ('CREATE VIEW AV1510 AS -- AP1510 ' + @sSQL + @sqlTemp + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sFROM + @sWHERE)  
ELSE  
 EXEC( 'ALTER VIEW AV1510 AS -- AP1510 ' + @sSQL + @sqlTemp + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sFROM + @sWHERE)  
  
--- In bao cao nhom theo Ma phan tich 1  
set @sSQL = '   
SELECT DISTINCT AT1503.DivisionID,AT1503.Notes,  
 AT1503.AssetID,  
 AT1503.AssetName,   
 '''' as Unit,  
 1 as Quantity,  
 AT1503.SerialNo,  
 AT1503.InvoiceNo,  
 AT1503.InvoiceDate,  
 AT1503.DepartmentID,  
 AT1102.DepartmentName,  
 (Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)  
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <= ' + str(@ToPeriod) + ')  
 Then (select top 1 AT1506.ConvertedNewAmount  
   From AT1506    WITH (NOLOCK)
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
     and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + '  
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
 Else AT1503.ConvertedAmount end) as ConvertedAmount,   
 AT1503.StartDate,  
 AT1503.EndDate,     
 AT1503.BeginMonth,  
 AT1503.BeginYear,   
 (Case when exists (select top 1 AssetID   
      from AT1506 WITH (NOLOCK)   
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
 Then (select top 1 AT1506.DepNewPeriods/12    
   From AT1506 WITH (NOLOCK)   
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
     and AT1506.TranMonth + 100*AT1506.TranYear  <= ' + str(@ToPeriod) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
 Else AT1503.Years end) as Years,   
 (Case when exists (select top 1 AssetID   
      from AT1506    WITH (NOLOCK)
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
        and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
 Then (select top 1 AT1506.DepNewPeriods   
   From AT1506    WITH (NOLOCK)
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
     and AT1506.TranMonth + 100*AT1506.TranYear  <=' + str(@ToPeriod) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
 Else AT1503.DepPeriods end) as DepPeriods,     
 (Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)  
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
         and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod)+')  
 Then (select top 1 AT1506.DepNewAmount   
   From AT1506   WITH (NOLOCK) 
   Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
     and AT1506.TranMonth + 100*AT1506.TranYear  <=' + str(@ToPeriod) + '   
   Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
 Else AT1503.DepAmount end) * 12 as YearDepAmount,   
 AT1503.AssetAccountID,  
 AT1005.AccountName,  
 AccuDepAmount = (   
     isnull (AT1503.ConvertedAmount,0)  
    /* (Case when exists (Select top 1 AssetID   
         From AT1506  WITH (NOLOCK)  
         Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
          and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
    Then  (select top 1 isnull(AT1506.ConvertedNewAmount,0)   
      From AT1506  WITH (NOLOCK)  
      Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear <= '+ str(@ToPeriod) + '    
      Order by AT1506.TranYear Desc,AT1506.TranMonth Desc )  
    Else isnull(AT1503.ResidualValue,0) end)*/  
   - isnull(AT1503.ResidualValue,0)  
   + isnull((Select Sum(DepAmount)   
      From AT1504 WITH (NOLOCK)   
      Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID and  
       AT1504.TranMonth + AT1504.TranYear * 100 <= ' + str(@ToPeriod) + '  
      And DebitAccountID = K.DebitaccountID  
      and AT1504.Ana01ID = K.Ana01ID Group by Ana01ID),0)),  
 AT1503.ResidualValue,  
 AT1503.Serial,  
 AT1503.SourceID1,  
 AT1503.SourceAmount1,  
 AT1503.SourcePercent1,  
 AT1503.SourceID2,  
 AT1503.SourceAmount2,  
 AT1503.SourcePercent2,  
 AT1503.SourceID3,  
 AT1503.SourceAmount3,  
 AT1503.SourcePercent3,   
 AT1503.MadeYear,'  
   
set @sSQL1 = '    
	(Case when exists (select top 1 AssetID   
	  from AT1506   WITH (NOLOCK) 
	  Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
		and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + ')  
	Then (select top 1 AT1506.DepNewPercent   
	From AT1506  WITH (NOLOCK)  
	Where AT1506.AssetID = AT1503.AssetID and AT1506.DivisionID = AT1503.DivisionID  
	 and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + '   
	Order by AT1506.TranYear Desc,AT1506.TranMonth Desc)  
	Else AT1503.DepPercent end) as DepPercent,   
	DepreciatedMonths = isnull(AT1503.DepMonths,0) ' + CASE WHEN @CustomerName IN (50, 57) THEN '' ELSE ' + isnull((Select Count(*)   
        From (Select Distinct  AssetID, TranMonth, TranYear   
          From AT1504  WITH (NOLOCK) 
             Group by TranMonth, AssetID, TranYear) A  
        Where A.AssetID = AT1503.AssetID  and A.TranMonth+A.TranYear*100 <= ' + str(@ToPeriod) + ' ),0)  
      ' END + ',       
	(Case When AT1503.AssetStatus=0 then N''FFML000143''  
	When AT1503.AssetStatus=1 then   N''FFML000144''  
	When AT1503.AssetStatus=2 then   N''FFML000145''  
	when  AT1503.AssetStatus=3 then  N''FFML000146''  
	when  AT1503.AssetStatus=4 then  N''FFML000147''  
	Else        N''FFML000148''  
	End) as Status,  
	'+ @GroupID + ' ,    
	AT1001.CountryName,  
	year(StartDate) as StartYear,  
	DepAmount = isnull((Select Sum(DepAmount)   
	  From AT1504 WITH (NOLOCK)   
	  Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
	   and AT1504.TranMonth+AT1504.TranYear*100 between ' + str(@FromPeriod) + ' and ' + str(@ToPeriod) + '  
	   And DebitAccountID = K.DebitaccountID  
	   and AT1504.Ana01ID = K.Ana01ID Group by Ana01ID),0),  
	AT1523.ReduceDate,  
	AT1523.ReduceVoucherNo,  
	AT1523.Notes as ReduceNote,  
	AT1523.ReduceMonth,  
	AT1523.ReduceYear,  
	At1523.ConvertedAmount as ReConvertedAmount,  
	(Case  When AT1523.AssetStatus=2 then N''FFML000145''  
	when  AT1523.AssetStatus=3 then  N''FFML000146''  
	Else        N''FFML000148''  
	End) as ReduceStatus,  
	K.Ana01ID,  
	AT1011.AnaName ,
	AT1503.EmployeeID, AT1103.FullName AS EmployeeName   
FROM AT1503   WITH (NOLOCK) 
LEFT JOIN AT1001 WITH (NOLOCK) on AT1503.CountryID=AT1001.CountryID and AT1503.DivisionID=AT1001.DivisionID  
LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AT1503.AssetAccountID And AT1005.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1102 WITH (NOLOCK) on AT1102.DepartmentID = AT1503.DepartmentID and AT1102.DivisionID = AT1503.DivisionID  
LEFT JOIN  AT1501 WITH (NOLOCK) on At1501.AssetGroupID = AT1503.AssetGroupID And At1501.DivisionID = AT1503.DivisionID  
LEFT JOIN  AT1523  WITH (NOLOCK) on AT1523.AssetID = AT1503.AssetID And AT1523.DivisionID = AT1503.DivisionID  
LEFT JOIN (	SELECT	AssetID, DebitaccountID, Ana01ID, DivisionID   
			FROM	AT1504  WITH (NOLOCK)  
			WHERE	TranMonth + TranYear *100 between  ' + str(@FromPeriod) + '  and ' + str(@ToPeriod ) + '
			)   AS  K ON K.AssetID = AT1503.AssetID and AT1503.DivisionID = K.DivisionID  
LEFT JOIN  AT1011 WITH (NOLOCK) ON AT1011.AnaID = K.Ana01ID and AnaTypeID = ''A01'' And AT1011.DivisionID = K.DivisionID  
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = AT1503.EmployeeID and AT1103.DivisionID = AT1503.DivisionID  
WHERE  AT1503.DivisionID like N''' + @DivisionID + ''' and   
		AT1503.AssetStatus in ' + isnull(@Condition,'') + '  and   
		---------AT1503.BeginMonth+AT1503.BeginYear*100 <= ' + str(@ToPeriod) +'  
		Month(AT1503.EstablishDate) + Year(AT1503.EstablishDate)*100 <=    ' + str(@ToPeriod) + '  
		and AT1503.AssetID not in ( select AssetID from AT1523 where AT1523.ReduceMonth+AT1523.ReduceYear*100 < ' + str(@FromPeriod)+')   
 '  
   
PRINT (@sSQL)  
PRINT (@sSQL1)  
  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV1501') -- TAO BOI STORE AP1510  
 EXEC ('CREATE VIEW AV1501 as ' + @sSQL + @sSQL1) -- -- tao boi store AP1510  
Else  
 Exec( 'Alter view AV1501 as ' + @sSQL + @sSQL1) -- -- tao boi store AP1510  
  
--------------------- Lay du lieu bao cao Ghi  tang TSCD  
set @sSQL='   
SELECT AT1503.DivisionID,AT1503.Notes,  
 AT1503.AssetID,  
 AT1503.AssetName,   
 '''' as Unit,  
 1 as Quantity,  
 AT1503.SerialNo,  
 AT1503.InvoiceNo,  
 AT1503.InvoiceDate,  
 AT1503.DepartmentID,  
 AT1102.DepartmentName,  
 AT1503.ConvertedAmount as ConvertedAmountOld, ---Nguyen Gia dau  
 (Select Top 1 AccuDepAmount   
  From AT1506 WITH (NOLOCK)   
  Where AT1506.AssetID = AT1503.AssetID   
  Order by RevaluateID) as AccuDepAmountOld, ---Hao mon luy ke cua lan thay doi NT dau.  
 (Select Top 1 VoucherDate   
  From AT1590 WITH (NOLOCK) INNER JOIN AT1506 WITH (NOLOCK) on AT1506.RevaluateID = AT1590.VoucherID   
  Where AT1506.DivisionID = AT1503.DivisionID and AT1506.TranMonth + 100*AT1506.TranYear <=' + str(@ToPeriod) + '  
   and AT1506.AssetID = AT1503.AssetID Order by VoucherID Desc) as IncreaseDate, ---Ngay tang them sau cung  
 (Case when exists (select top 1 AssetID   
      from AT1506  WITH (NOLOCK)  
      Where AssetID = AT1503.AssetID and DivisionID = AT1503.DivisionID  
       and AT1506.TranMonth + 100*AT1506.TranYear between ' + str(@FromPeriod) + '  and ' + str(@ToPeriod) + ')  
 Then AT1506.ConvertedNewAmount   
 Else AT1503.ConvertedAmount end) as ConvertedAmount,   
 AT1503.StartDate,  
 AT1503.EndDate,    
 AT1523.ReduceDate,  
 AT1503.Years,  
 AT1503.DepPeriods,   
 AT1503.DepAmount * 12 as YearDepAmount,    
 AT1503.AssetAccountID,  
 AT1005.AccountName,  
 AccuDepAmount = (AT1503.ConvertedAmount - Isnull(ResidualValue,0)) +   
     isnull((Select Sum(DepAmount)   
       From AT1504 WITH (NOLOCK)   
       Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
       and AT1504.TranMonth+AT1504.TranYear*100 <= ' + str(@ToPeriod) + '),0),  
 AT1503.ResidualValue,  
 AT1503.Serial,  
 AT1503.SourceID1,  
 AT1503.SourceAmount1,  
 AT1503.SourcePercent1,  
 AT1503.SourceID2,  
 AT1503.SourceAmount2,  
 AT1503.SourcePercent2,  
 AT1503.SourceID3,  
 AT1503.SourceAmount3,  
 AT1503.SourcePercent3,  
 AT1503.DepPercent,  
 AT1503.MadeYear,  
 DepreciatedMonths = isnull(AT1503.DepMonths,0) ' + CASE WHEN @CustomerName IN (50, 57) THEN '' ELSE ' + isnull((Select Count(*)   
        From (Select Distinct  AssetID, TranMonth, TranYear   
          From AT1504  WITH (NOLOCK) 
             Group by TranMonth, AssetID, TranYear) A  
        Where A.AssetID = AT1503.AssetID  and A.TranMonth+A.TranYear*100 <= ' + str(@ToPeriod) + ' ),0)  
      ' END + ',       
 (Case When AT1503.AssetStatus=0 then N''FFML000143''  
  When AT1503.AssetStatus=1 then   N''FFML000144''  
  When AT1503.AssetStatus=2 then   N''FFML000145''  
  when  AT1503.AssetStatus=3 then  N''FFML000146''  
  when  AT1503.AssetStatus=4 then  N''FFML000147''  
  Else        N''FFML000148''  
 End) as Status,  
 ' + @GroupID + ' ,    
 AT1001.CountryName,  
 year(StartDate) as StartYear,  
 DepAmount =isnull((Select Sum(DepAmount)        From AT1504   WITH (NOLOCK) 
      Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
      and AT1504.TranMonth+AT1504.TranYear*100 between ' + str(@FromPeriod) + ' and ' + str(@ToPeriod) + '),0),  
 ConvertedOldAmount   ,
 AT1503.EmployeeID, AT1103.FullName AS EmployeeName '
 SET @sSQL1 = N'
FROM AT1503  WITH (NOLOCK)
LEFT JOIN AT1001 WITH (NOLOCK) on AT1503.CountryID=AT1001.CountryID AND AT1503.DivisionID=AT1001.DivisionID  
LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AT1503.AssetAccountID AND AT1005.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1102 WITH (NOLOCK) on AT1102.DepartmentID = AT1503.DepartmentID and AT1102.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1501 WITH (NOLOCK) on At1501.AssetGroupID = AT1503.AssetGroupID AND At1501.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1523 WITH (NOLOCK) on AT1523.AssetID = AT1503.AssetID AND AT1523.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1506 WITH (NOLOCK) ON AT1506.AssetID = AT1503.AssetID AND AT1506.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = AT1503.EmployeeID and AT1103.DivisionID = AT1503.DivisionID 
 
Where AT1503.DivisionID like N''' + @DivisionID + ''' and   
  AT1503.AssetStatus in '+ isnull(@Condition,'') +'  and   
 -----AT1503.BeginMonth+AT1503.BeginYear*100  between ' + str(@FromPeriod)+'  and  ' + str(@ToPeriod) + '  
 (Month(AT1503.EstablishDate) + Year(AT1503.EstablishDate)*100  between ' + str(@FromPeriod)+'  and  ' + str(@ToPeriod) + '    
OR  AT1506.TranMonth+AT1506.TranYear*100 between ' + str(@FromPeriod) + '  and ' + str(@ToPeriod )+')'   
  
PRINT @sSQL 
PRINT(@sSQL1) 
  
If Not Exists (Select 1 From sysObjects WITH (NOLOCK) Where Name ='AV1511')  
 Exec ('Create view AV1511 as '+@sSQL + @sSQL1)  
Else  
 Exec( 'Alter view AV1511 as '+@sSQL + @sSQL1)  
  
--- Lay du lieu bao cao Ghi Giam TSCD   
set @sSQL='   
SELECT AT1503.DivisionID,AT1503.Notes,  
 AT1503.AssetID,  
 AT1503.AssetName,   
 '''' as Unit,  
 1 as Quantity,  
 AT1503.SerialNo,  
 AT1503.InvoiceNo,  
 AT1503.InvoiceDate,  
 AT1503.DepartmentID,  
 AT1102.DepartmentName,  
 AT1523.ConvertedAmount,  
 AT1503.StartDate,  
 AT1503.EndDate,    
 AT1523.ReduceDate,  
 AT1503.Years,  
 AT1503.DepPeriods,   
 AT1503.DepAmount * 12 as YearDepAmount,    
 AT1503.AssetAccountID,  
 AT1005.AccountName,  
 /* AccuDepAmount = (AT1503.ConvertedAmount  -    
     Isnull(ResidualValue,0)) +   
     isnull((Select Sum(DepAmount)   
       From AT1504 WITH (NOLOCK)   
       Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
       and AT1504.TranMonth+AT1504.TranYear*100 <= '+str(@ToPeriod)+'),0), */  
 AT1523.AccuDepAmount,  
 AT1523.RemainAmount,  
 AT1503.ResidualValue,  
 AT1503.Serial,  
 AT1503.SourceID1,  
 AT1503.SourceAmount1,  
 AT1503.SourcePercent1,  
 AT1503.SourceID2,  
 AT1503.SourceAmount2,  
 AT1503.SourcePercent2,  
 AT1503.SourceID3,  
 AT1503.SourceAmount3,  
 AT1503.SourcePercent3,  
 AT1503.DepPercent,  
 AT1503.MadeYear,  
 DepreciatedMonths = isnull(AT1503.DepMonths,0) ' + CASE WHEN @CustomerName IN (50, 57) THEN '' ELSE ' + isnull((Select Count(*)   
        From (Select Distinct AssetID, TranMonth, TranYear   
          From AT1504 WITH (NOLOCK)  
             Group by TranMonth, AssetID, TranYear) A  
        Where A.AssetID = AT1503.AssetID and A.TranMonth+A.TranYear*100 <= '+str(@ToPeriod)+' ),0)  ' END + ',       
 (Case When AT1503.AssetStatus=0 then N''FFML000143''  
  When AT1503.AssetStatus=1 then   N''FFML000144''  
  When AT1503.AssetStatus=2 then   N''FFML000145''  
  when  AT1503.AssetStatus=3 then  N''FFML000146''  
  when  AT1503.AssetStatus=4 then  N''FFML000147''  
  Else        N''FFML000148''  
 End) as Status,  
 ' + @GroupID + ',  
 AT1001.CountryName,
 year(StartDate) as StartYear,  
 DepAmount = isnull((Select Sum(DepAmount) From AT1504 WITH (NOLOCK) Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID   
      and AT1504.TranMonth+AT1504.TranYear*100 between ' + str(@FromPeriod)+' and '+str(@ToPeriod )+'),0) ,
AT1503.EmployeeID, AT1103.FullName AS EmployeeName   
From AT1503 WITH (NOLOCK) 
LEFT JOIN AT1001 WITH (NOLOCK) on AT1503.CountryID=AT1001.CountryID AND AT1503.DivisionID=AT1001.DivisionID  
LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AT1503.AssetAccountID AND AT1005.DivisionID = AT1503.DivisionID  
LEFT JOIN AT1102 WITH (NOLOCK) on  AT1102.DepartmentID = AT1503.DepartmentID and AT1102.DivisionID = AT1503.DivisionID  
LEFT JOIN  AT1501 WITH (NOLOCK) on At1501.AssetGroupID = AT1503.AssetGroupID AND At1501.DivisionID = AT1503.DivisionID  
INNER JOIN  AT1523 WITH (NOLOCK) on AT1523.AssetID = AT1503.AssetID AND AT1523.DivisionID = AT1503.DivisionID 
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = AT1503.EmployeeID and AT1103.DivisionID = AT1503.DivisionID   
WHERE  AT1503.DivisionID like N''' + @DivisionID + ''' and   
 ----- AT1503.AssetStatus in ' + isnull(@Condition,'') +'  and   
 AT1523.ReduceMonth+AT1523.ReduceYear*100  between ' + str(@FromPeriod)+'  and  ' + str(@ToPeriod)+''  

PRINT(@sSQL)  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV1512')  
 EXEC ('CREATE VIEW AV1512 AS '+@sSQL)  
ELSE  
 EXEC( 'ALTER VIEW AV1512 AS '+@sSQL)  

DROP TABLE #CustomerName



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO