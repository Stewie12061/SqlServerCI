IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2423_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2423_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Created by Vo Thanh Huong  
-----Created date 20/08/2004  
----- purpose: Xu ly In cham cong ngay, Mau1: (C?t: AbsentDate)  
---Edit Huynh Trung Dung ,date 14/12/2010 --- Them tham so @ToDepartmentID
---- Modify on 27/07/2013 by Bao Anh: Bo sung to nhom, gio vao/ra (Thuan Loi)
---- Modify on 30/12/2013 by Bao Anh: Sua loi Tien Hung CRM TT7818 (sua cach lay FromTimeValid,ToTimeValid không join HT2407)
---- Modify on 19/02/2016 by Hoàng Vũ: Sua loi bản chuẩn khi diều kiện search từ ngày đến ngày qua lớn
---- Modify on 30/05/2023 by Kiều Nga: Bổ sung param @StrDivisionID
---- Exec HP2423_MK 'AS', '','','','', '2015-01-01', '2016-12-01' , 0
CREATE  PROCEDURE HP2423_MK  @DivisionID nvarchar(50),  
     @DepartmentID nvarchar(50),   
     @ToDepartmentID nvarchar(50),  
     @TeamID nvarchar(50),  
     @EmployeeID nvarchar(50),       
     @FromDate Datetime,   
     @ToDate Datetime,  
     @gnLang int,
	 @StrDivisionID AS NVARCHAR(4000) = ''
AS  
  
Declare @sSQL nvarchar(4000),  
 @sSQL0 nvarchar(Max),   
 @AbsentDate datetime,  
 @DateAmount int,  
 @i int,  
 @DateName nvarchar(50),
 @sSQL001 Nvarchar(4000) ='',
 @TableHT2401 Varchar(50),
 @sTranMonth Varchar(2),
 @StrDivisionID_New AS NVARCHAR(4000)

SET @StrDivisionID_New = ''		
IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''   
  
Select @sSQL0 = '', @sSQL = ''  
Select @DateAmount = DATEDIFF(day, @FromDate, @ToDate) + 2, @i = 1  
Set @AbsentDate = @FromDate  
  
SELECT @sTranMonth = CASE WHEN MONTH(@FromDate) >9 THEN Convert(Varchar(2),MONTH(@FromDate)) ELSE '0'+Convert(Varchar(1),MONTH(@FromDate)) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	IF(MONTH(@FromDate) = MONTH(@ToDate) and YEAR(@FromDate) = YEAR(@ToDate))
	BEGIN
		SET  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),YEAR(@FromDate))
	END
	ELSE
	IF(MONTH(@FromDate) <> MONTH(@ToDate) and YEAR(@FromDate) = YEAR(@ToDate))
	BEGIN
		SET  @TableHT2401 = 'HT2401Y'+Convert(Varchar(4),YEAR(@FromDate))
	END
	ELSE
		SET  @TableHT2401 = 'HT2401'
END
ELSE
BEGIN
	SET  @TableHT2401 = 'HT2401'
END

If @gnLang=0 --tieng Viet  
  
Begin  
  
While @i < @DateAmount  
Begin  
Set @DateName =    CASE WHEN DATENAME(dw, @AbsentDate) = 'Monday' THEN 'T2'  
        WHEN DATENAME(dw, @AbsentDate) = 'Tuesday' THEN 'T3'        
        WHEN DATENAME(dw, @AbsentDate) = 'Wednesday' THEN 'T4'    
         WHEN DATENAME(dw, @AbsentDate) = 'Thursday' THEN 'T5'        
         WHEN DATENAME(dw, @AbsentDate) = 'Friday' THEN 'T6'        
          WHEN DATENAME(dw, @AbsentDate) = 'Saturday' THEN 'T7'        
          ELSE 'CN'        
           END      
 Set @sSQL0 = @sSQL0 + ' Select   
    cast(''' + ltrim(month(@AbsentDate)) + '/' + ltrim(Day(@AbsentDate)) + '/' + ltrim(year(@AbsentDate)) + ''' as datetime) as AbsentDate,''' +  
    convert(nvarchar(5), @AbsentDate, 103) + ''' as Days,''' + @DateName + ''' as Dates,''' + @DivisionID + ''' as  DivisionID   Union'  
         
--- Insert HT2412(AbsentDate, Day, Date) values (@AbsentDate, convert(nvarchar(5), @AbsentDate, 103), @DateName)  
   
 Set @i = @i + 1  
 Set @AbsentDate =  Dateadd(Day, 1, @AbsentDate)   
End  
  
Set @sSQL0 = left(@sSQL0, len(@sSQL0) - 5)  
  
If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV1406')   
 EXEC('Create View HV1406 --- tao boi HP2423_MK  
   as ' + @sSQL0)  
 EXEC('Alter View HV1406 --- tao boi HP2423_MK  
   as ' + @sSQL0)  
  
  
Set @sSQL = ' Select  HT00.DivisionID, HT00.DepartmentID,  AT00.DepartmentName, HT00.TeamID, HT1101.TeamName, HT00.EmployeeID, FullName,   
  Birthday,   
  --convert(nvarchar(10), HT00.AbsentDate,103) as AbsentDate,   
  HT00.AbsentDate,  
  HT00.AbsentTypeID, AbsentName, UnitID, AbsentAmount,   
  HV00.Orders, HT01.Orders as OrdersAbsentType,
  (Select top 1 FromTimeValid From HT2407 Where DivisionID = HT00.DivisionID and EmployeeID = HT00.EmployeeID and AbsentDate = HT00.AbsentDate and AbsentTypeID = HT00.AbsentTypeID) as FromTimeValid,
  (Select top 1 ToTimeValid From HT2407 Where DivisionID = HT00.DivisionID and EmployeeID = HT00.EmployeeID and AbsentDate = HT00.AbsentDate and AbsentTypeID = HT00.AbsentTypeID) as ToTimeValid
 
 From '+@TableHT2401+'  HT00  inner join HV1400 HV00 on HV00.EmployeeID = HT00.EmployeeID and HV00.DivisionID = HT00.DivisionID   
  inner join AT1102  AT00 on AT00.DepartmentID = HT00.DepartmentID and AT00.DivisionID = HT00.DivisionID   
  inner join HT1013 HT01 on HT01.AbsentTypeID = HT00.AbsentTypeID and HT01.DivisionID = HT00.DivisionID
  left join HT1101  on HT1101.DivisionID = HT00.DivisionID and HT1101.TeamID = HT00.TeamID AND HT1101.DepartmentID = AT00.DepartmentName
 
 Where HT00.DivisionID '+@StrDivisionID_New+' and  
  HT00.DepartmentID between ''' + @DepartmentID + ''' and ''' + @ToDepartmentID + ''' and  
  Isnull(HT00.TeamID, ''' + ''') like Isnull(''' + @TeamID + ''', ''' + ''') and    
  HT00.EmployeeID like ''' + @EmployeeID + ''' and    
  (HT00.AbsentDate between ''' +  convert(nvarchar(10), @FromDate, 101) + '''  and ''' + convert(nvarchar(10), @ToDate, 101) + ''')'  
/*  
 Select  HT00.DivisionID, ''zzzzzzzz'' as DepartmentID,  ''TOÅNG COÄNG'' as DepartmentName, '''' as EmployeeID, '''' asFullName,   
  NULL as Birthday, convert(nvarchar(10), HT00.AbsentDate, 103) as AbsentDate, HT00.AbsentTypeID, AbsentName, UnitID,sum( AbsentAmount) as AbsentAmount,   
  0 as Orders, HT01.Orders as OrdersAbsentType  
 From HT2401  HT00  inner join HT1013 HT01 on HT01.AbsentTypeID = HT00.AbsentTypeID    
 Where HT00.DivisionID = ''' + @DivisionID + ''' and  
  HT00.DepartmentID like ''' + @DepartmentID + ''' and  
  Isnull(HT00.TeamID, ''' + ''') like Isnull(''' + @TeamID + ''', ''' + ''') and    
  HT00.EmployeeID like ''' + @EmployeeID + ''' and    
  (HT00.AbsentDate between ''' +  convert(nvarchar(10), @FromDate, 101) + '''  and ''' + convert(nvarchar(10), @ToDate, 101) + ''')  
 Group by HT00.DivisionID, HT00.AbsentTypeID, AbsentName, UnitID, HT01.Orders, HT00.AbsentDate'  
*/  
If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2403')   
 EXEC('Create view HV2403 --- tao boi HP2423_MK  
   as ' + @sSQL)  
 EXEC('Alter view HV2403 --- tao boi HP2423_MK  
   as ' + @sSQL)  
End ----Ket thuc tieng Viet  
  
Else   
  
Begin --tieng Anh  
  
While @i < @DateAmount  
Begin  
Set @DateName =    CASE WHEN DATENAME(dw, @AbsentDate) = 'Monday' THEN 'Mon'  
        WHEN DATENAME(dw, @AbsentDate) = 'Tuesday' THEN 'Tue'        
        WHEN DATENAME(dw, @AbsentDate) = 'Wednesday' THEN 'Wed'    
         WHEN DATENAME(dw, @AbsentDate) = 'Thursday' THEN 'Thu'        
         WHEN DATENAME(dw, @AbsentDate) = 'Friday' THEN 'Fri'        
          WHEN DATENAME(dw, @AbsentDate) = 'Saturday' THEN 'Sat'        
          ELSE 'Sun'        
           END      
 Set @sSQL0 = @sSQL0 + ' Select   
    cast(''' + ltrim(month(@AbsentDate)) + '/' + ltrim(Day(@AbsentDate)) + '/' + ltrim(year(@AbsentDate)) + ''' as datetime) as AbsentDate,''' +  
    convert(nvarchar(5), @AbsentDate, 103) + ''' as Days,''' + @DateName + ''' as Dates,''' + @DivisionID + ''' as  DivisionID Union'  
         
--- Insert HT2412(AbsentDate, Day, Date) values (@AbsentDate, convert(nvarchar(5), @AbsentDate, 103), @DateName)  
   
 Set @i = @i + 1  
 Set @AbsentDate =  Dateadd(Day, 1, @AbsentDate)   
End  
  
Set @sSQL0 = left(@sSQL0, len(@sSQL0) - 5)  
  
If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV1406')   
 EXEC('Create View HV1406 --- tao boi HP2423_MK  
   as ' + @sSQL0)  
 EXEC('Alter View HV1406 --- tao boi HP2423_MK  
   as ' + @sSQL0)  
  
  
Set @sSQL = ' Select  HT00.DivisionID, HT00.DepartmentID,  AT00.DepartmentName, HT00.TeamID, HT1101.TeamName, HT00.EmployeeID, FullName,   
  Birthday,   
  --convert(nvarchar(10), HT00.AbsentDate,103) as AbsentDate,   
  HT00.AbsentDate,  
  HT00.AbsentTypeID, AbsentName, UnitID, AbsentAmount,   
  HV00.Orders, HT01.Orders as OrdersAbsentType,
  (Select top 1 FromTimeValid From HT2407 Where DivisionID = HT00.DivisionID and EmployeeID = HT00.EmployeeID and AbsentDate = HT00.AbsentDate and AbsentTypeID = HT00.AbsentTypeID) as FromTimeValid,
  (Select top 1 ToTimeValid From HT2407 Where DivisionID = HT00.DivisionID and EmployeeID = HT00.EmployeeID and AbsentDate = HT00.AbsentDate and AbsentTypeID = HT00.AbsentTypeID) as ToTimeValid

 From '+@TableHT2401+'  HT00  inner join HV1400 HV00 on HV00.EmployeeID = HT00.EmployeeID and HV00.DivisionID = HT00.DivisionID   
  inner join AT1102  AT00 on AT00.DepartmentID = HT00.DepartmentID and AT00.DivisionID = HT00.DivisionID   
  inner join HT1013 HT01 on HT01.AbsentTypeID = HT00.AbsentTypeID and HT01.DivisionID = HT00.DivisionID
  left join HT1101  on HT1101.DivisionID = HT00.DivisionID and HT1101.TeamID = HT00.TeamID AND HT1101.DepartmentID = AT00.DepartmentName
 

 Where HT00.DivisionID '+@StrDivisionID_New+' and  
  HT00.DepartmentID between ''' + @DepartmentID + ''' and ''' + @ToDepartmentID + ''' and  
  Isnull(HT00.TeamID, ''' + ''') like Isnull(''' + @TeamID + ''', ''' + ''') and    
  HT00.EmployeeID like ''' + @EmployeeID + ''' and    
  (HT00.AbsentDate between ''' +  convert(nvarchar(10), @FromDate, 101) + '''  and ''' + convert(nvarchar(10), @ToDate, 101) + ''')'  
/*  
 Select  HT00.DivisionID, ''zzzzzzzz'' as DepartmentID,  ''TOÅNG COÄNG'' as DepartmentName, '''' as EmployeeID, '''' asFullName,   
  NULL as Birthday, convert(nvarchar(10), HT00.AbsentDate, 103) as AbsentDate, HT00.AbsentTypeID, AbsentName, UnitID,sum( AbsentAmount) as AbsentAmount,   
  0 as Orders, HT01.Orders as OrdersAbsentType  
 From HT2401  HT00  inner join HT1013 HT01 on HT01.AbsentTypeID = HT00.AbsentTypeID    
 Where HT00.DivisionID = ''' + @DivisionID + ''' and  
  HT00.DepartmentID like ''' + @DepartmentID + ''' and  
  Isnull(HT00.TeamID, ''' + ''') like Isnull(''' + @TeamID + ''', ''' + ''') and    
  HT00.EmployeeID like ''' + @EmployeeID + ''' and    
  (HT00.AbsentDate between ''' +  convert(nvarchar(10), @FromDate, 101) + '''  and ''' + convert(nvarchar(10), @ToDate, 101) + ''')  
 Group by HT00.DivisionID, HT00.AbsentTypeID, AbsentName, UnitID, HT01.Orders, HT00.AbsentDate'  
*/  
If not exists (Select 1 From sysObjects Where XType = 'V' and Name = 'HV2403')   
 EXEC('Create view HV2403 --- tao boi HP2423_MK  
   as ' + @sSQL)  
 EXEC('Alter view HV2403 --- tao boi HP2423_MK  
   as ' + @sSQL)  
End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
