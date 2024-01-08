IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0357]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0357]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <History>
---- Create on 03/12/2015 by Bảo Anh: Xử lý và insert dữ liệu đi trễ, về sớm vào bảng HT0356
---- Modified on ... by ...
---- <Example>
  
CREATE PROCEDURE [dbo].[HP0357]  @DivisionID nvarchar(50),  
     @TranMonth int,  
     @TranYear int,  
     @AbsentDate Datetime,      
     @ShiftID nvarchar(50),  
     @DateTypeID nvarchar(3),  
     @IsNextDay bit,
	 @EmployeeID nvarchar(50),
     @AbsentCardNo nvarchar(50)
AS  
  
DECLARE @TransactionID nvarchar(50),  
  @Sub int,  
  @InLateMinutes int,  
  @OutEarlyMinutes int,  
  @DeductMinutes int,  
  @ShiftMaxRow int,  
  @FromMinute datetime,  
  @ToMinute datetime,  
  @IsNextDayDetail bit,  
  @RestrictID nvarchar(50),   
  @ScanDate Datetime,  
  @InScanDate Datetime,  
  @OutScanDate Datetime,  
  @LateBeginPermit int,  
  @EarlyEndPermit int,  
  @curHV1020 cursor,  
  @curHV2433 cursor,  
  @i int,  
  @j int,  
  @o int,  
  @LateBeginPermit00 int,  
  @EarlyEndPermit00 int, 
  @MBeginTime Datetime,
  @MEndTime Datetime  
  
--- Lấy số phút được phép đi trễ, về sớm theo thiết lập  
SELECT @LateBeginPermit00 = Isnull(LateBeginPermit,0), @EarlyEndPermit00 = Isnull(EarlyEndPermit,0)  
FROM HT0000 WHERE DivisionID = @DivisionID

SELECT TOP 1 @RestrictID = RestrictID FROM HT1022 WHERE DivisionID = @DivisionID
AND (@AbsentDate between FromDate and (case when ToDate is NULL then '12/31/9999' else ToDate end))
  
 --Select @ShiftMaxRow = Isnull(Max(Orders),'') From HV1020  
 --Where ShiftID = @ShiftID And DateTypeID = @DateTypeID  
 
 --Tao bang tam lay du lieu xu ly du quet vao va ra tren cung 1 dong  
 Create Table #HT2433(  
    Orders int ,  
    InScanDate Datetime,  
    OutScanDate Datetime  
    )  
 Set @i=1  
 Set @j=1  
 Set @o = 1   
   
 Set @curHV2433 = cursor static for  
  Select ScanDate From ##HT03566 Where EmployeeID = @EmployeeID Order by ScanDate  
   
 Open @curHV2433  
   
 Fetch Next From @curHV2433 Into @ScanDate  
 While @@Fetch_Status = 0  
 Begin  
    
  If @i%2=0  
   Begin  
    Update #HT2433 Set OutScanDate=@ScanDate Where Orders = @j  
    Set @j = @j + 1  
   End  
  Else  
   Begin  
    Insert Into #HT2433(Orders, InScanDate) Values (@j,@ScanDate)  
   End  
  Set @i = @i +1  
  Fetch Next From @curHV2433 Into @ScanDate  
 End  
  
 Close @curHV2433  
 --So sanh doi chieu tung dong quet the thuc te va thiet lap  
 Set @curHV2433 = cursor static for  
  Select InScanDate,OutScanDate From #HT2433 Order by Orders  
   
 Open @curHV2433  
 --Lap tung dong thuc te  
 Fetch Next From @curHV2433 Into @InScanDate, @OutScanDate  
 While @@Fetch_Status = 0  
 BEGIN
	-- Select	Cast(@AbsentDate + ' ' + FromMinute As DateTime), Cast(@AbsentDate + ' ' + ToMinute As DateTime), IsNextDay,
	--		Cast(@AbsentDate + ' ' + BeginTime As DateTime) as BeginTime, Cast(@AbsentDate + ' ' + EndTime As DateTime) as EndTime
	--From HV1020  
 --   Where ShiftID = @ShiftID And DateTypeID = @DateTypeID
   Set @curHV1020 = cursor static for  
    Select	Cast(@AbsentDate + ' ' + FromMinute As DateTime), Cast(@AbsentDate + ' ' + ToMinute As DateTime), IsNextDay,
			Cast(@AbsentDate + ' ' + BeginTime As DateTime) as BeginTime, Cast(@AbsentDate + ' ' + EndTime As DateTime) as EndTime
	From HV1020  
    Where ShiftID = @ShiftID And DateTypeID = @DateTypeID
    
   Open @curHV1020  
    
   Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @MBeginTime, @MEndTime  
   While @@Fetch_Status = 0  
   Begin
    Set @InLateMinutes = 0  
    Set @OutEarlyMinutes = 0
    Set @DeductMinutes =0  
    Set @Sub = 0  
      
    If @IsNextDayDetail = 1  
     Begin  
      If @FromMinute>@ToMinute  
       Begin  
        Set @ToMinute = DateAdd(d,1,@ToMinute)  
       End  
      Else   
       Begin  
        Set @FromMinute = DateAdd(d,1,@FromMinute)  
        Set @ToMinute = DateAdd(d,1,@ToMinute)  
       End  
     End  
    --Bat dau so sanh doi chieu  
	--select @InScanDate as InScanDate, @ToMinute as ToMinute 
	--select @OutScanDate as OutScanDate, @FromMinute as FromMinute 
	--select @InScanDate as InScanDate , @MEndTime as MEndTime
	--select @OutScanDate as OutScanDate,   @MBeginTime as MBeginTime
    --Xac dinh vao tre ra som  
    If (@InScanDate <= @ToMinute And @OutScanDate>@FromMinute  )
	OR (@InScanDate <= @MEndTime And @OutScanDate> @MBeginTime )
    BEGIN  
	--select 'a', @FromMinute as  FromMinute, @ToMinute as ToMinute
		 Set @Sub = DATEDIFF ( mi , @InScanDate, @FromMinute )  
		 If @Sub>=0  
		  Begin  
		   ---Set @InEarlyMinutes = @Sub  
		   Set @InLateMinutes = 0  
		  End  
		 Else 
		 BEGIN 
			IF (@InScanDate <= @ToMinute)
			  Begin  
			   ---Set @InEarlyMinutes = 0  
			   Set @InLateMinutes = -@Sub  
			  End 
			ELSE
				Set @InLateMinutes =  DATEDIFF ( mi , @FromMinute, @ToMinute )  
		 END 
		 If @OutScanDate <= @ToMinute   
		  Begin  
			IF (@OutScanDate>@FromMinute)
			BEGIN
				---Set @ToTimeValid = @OutScanDate  
				Set @OutEarlyMinutes = DATEDIFF ( mi , @OutScanDate, @ToMinute )  
			END
			ELSE
			BEGIN
				Set @OutEarlyMinutes =  DATEDIFF ( mi , @FromMinute, @ToMinute )  
			END
		  End 
  
		If isnull(@RestrictID,'')<>''  
			Select @LateBeginPermit=isnull(LateBeginPermit,0), @EarlyEndPermit=isnull(EarlyEndPermit,0) From HT1022  
			Where HT1022.RestrictID= @RestrictID  
		Else  
			Begin  
				Set @LateBeginPermit = Isnull(@LateBeginPermit00,0)  
				Set @EarlyEndPermit = Isnull(@EarlyEndPermit00,0)  
			End
		  
		--Tinh tong so phut bi tru         
		Set @InLateMinutes = Case When @InLateMinutes>@LateBeginPermit Then @InLateMinutes Else 0 End
		Set @OutEarlyMinutes = Case When @OutEarlyMinutes>@EarlyEndPermit Then @OutEarlyMinutes Else 0 End
		Set @DeductMinutes = @InLateMinutes + @OutEarlyMinutes  
      
		IF @DeductMinutes > 0
		BEGIN
			IF NOT EXISTS (Select top 1 1 From HT0356 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear
							And EmployeeID = @EmployeeID And AbsentDate = @AbsentDate And FromTime = @InScanDate And ToTime = @OutScanDate)
			 
				 INSERT INTO HT0356  (APK,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,  
					FromTime, ToTime, InLateMinutes, OutEarlyMinutes, DepartmentID,TeamID,IsConfirm)  
				 VALUES  (newid(),@DivisionID,@EmployeeID,@AbsentCardNo,@TranMonth,@TranYear,@AbsentDate,@ShiftID,  
					@InScanDate, @OutScanDate, @InLateMinutes, @OutEarlyMinutes, 
					(Select DepartmentID From HT1400 Where DivisionID = @DivisionID and EmployeeID = @EmployeeID),
					(Select TeamID From HT1400 Where DivisionID = @DivisionID and EmployeeID = @EmployeeID),
					0)
			ELSE
				UPDATE HT0356 SET	InLateMinutes = InLateMinutes + @InLateMinutes,
									OutEarlyMinutes = OutEarlyMinutes + @OutEarlyMinutes
				WHERE DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear
				And EmployeeID = @EmployeeID And AbsentDate = @AbsentDate And FromTime = @InScanDate And ToTime = @OutScanDate	  
		END	
		 Set @o = @o +1        
    END  
  
    Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @MBeginTime, @MEndTime
   End  
   Close @curHV1020  
  
  Fetch Next From @curHV2433 Into @InScanDate, @OutScanDate  
 End  
  
 Close @curHV2433     
  
Deallocate @curHV2433  
  
Drop Table #HT2433

SET NOCOUNT OFF