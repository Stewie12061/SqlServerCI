IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2433_IPL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2433_IPL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created on 24/04/2016 by Bảo Anh: Customize cho IPL 
--- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
----- Modified by Bảo Thy on 13/09/2016: đổi kiểu dữ liệu @WorkingTime INT => DECIMAL(28,8)
----- Modified by Bảo Anh on 27/12/2017: Sửa lỗi chấm công sai khi nhân viên đi trễ về sớm bị trừ tiền theo quy định
----- HP2433_IPL 'IPL',12,2015,'12/05/2015','13081401','10003','CA00','SAT',0,'admin'
 
CREATE PROCEDURE [dbo].[HP2433_IPL]  @DivisionID nvarchar(50),  
     @TranMonth int,  
     @TranYear int,  
     @AbsentDate Datetime,  
     @EmployeeID nvarchar(50),  
     @AbsentCardNo nvarchar(50),      
     @ShiftID nvarchar(50),  
     @DateTypeID nvarchar(3),  
     @IsNextDay bit,  
     @UserID nvarchar(50)  
       
AS  
  
DECLARE @TransactionID nvarchar(50),  
  @AbsentHour decimal (28,8),  
  @AbsentTypeID nvarchar(50),  
  @Sub int,  
  @InEarlyMinutes int,  
  @InLateMinutes int,  
  @OutEarlyMinutes int,  
  @OutLateMinutes int,  
  @DeductMinutes int,  
  @DeductTotal decimal (28,8),  --- tổng số phút bị trừ
  @ShiftMaxRow int,  
  @FromMinute datetime,  
  @ToMinute datetime,  
  @IsNextDayDetail bit,  
  @RestrictID nvarchar(50),  
  @Orders int,   
  @ScanDate Datetime,  
  @InScanDate Datetime,  
  @OutScanDate Datetime,  
  @FromTimeValid Datetime,   
  @ToTimeValid Datetime,  
  @LateBeginPermit int,  
  @EarlyEndPermit int,  
  @SubMinute int,  
  @Coefficient decimal (28,8),    
  @curHV1020 cursor,  
  @curHV2433 cursor,  
  @i int,  
  @j int,  
  @o int,  
  @LateBeginPermit00 int,  
  @EarlyEndPermit00 int,  
  @TypeID nvarchar(50),  
  @InScanDate_C Datetime,  
  @InScanDate_NotC Datetime,
  @NotConfirmCo int,	--- hệ số phạt khi không được duyệt đi trễ/về sớm
  @IsConfirm tinyint,	--- trạng thái duyệt đi trễ/về sớm
  @InOutAbsentTypeID nvarchar(50), --- loại công đi trễ/về sớm (trừ tiền),
  @InOutAbsentTypeID_H nvarchar(50), --- loại công đi trễ/về sớm (trừ công),
  @SubAmount decimal(28,8),
  @DeductAmount decimal(28,8), --- tổng số tiền bị trừ
  @WorkingTime decimal(28,8)

DECLARE	@sSQL001 Nvarchar(4000),
		@sSQL002 Nvarchar(4000),
		@sSQL003 Nvarchar(4000),
		@TableHT2407 Varchar(50),		
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2407 = 'HT2407M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET  @TableHT2407 = 'HT2407'
END


SET @IsConfirm = 0
SET @DeductAmount = 0
SELECT @InOutAbsentTypeID = InOutAbsentTypeID, @InOutAbsentTypeID_H = InOutAbsentTypeID_H FROM HT0000 WHERE DivisionID = @DivisionID
SELECT TOP 1 @RestrictID = RestrictID FROM HT1022 WHERE DivisionID = @DivisionID
AND (@AbsentDate between FromDate and (case when ToDate is NULL then '12/31/9999' else ToDate end))

--- Lấy số phút được phép đi trễ, về sớm theo thiết lập  
SELECT @LateBeginPermit00 = Isnull(LateBeginPermit,0), @EarlyEndPermit00 = Isnull(EarlyEndPermit,0)  
FROM HT0000 WHERE DivisionID = @DivisionID  
  
 Select @ShiftMaxRow = Isnull(Max(Orders),'') + 1 From HV1020  
 Where ShiftID = @ShiftID And DateTypeID = @DateTypeID  
 
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
  Select ScanDate From HTT2433 Where DivisionID = @DivisionID And TranMonth = @TranMonth  
  And TranYear = @TranYear And EmployeeID = @EmployeeID Order by ScanDate  
   
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
 Begin
   SET @InScanDate_C = @InScanDate  
   SET @InScanDate_NotC = @InScanDate
   SELECT @IsConfirm = IsConfirm
   FROM HT0356
   WHERE DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear And AbsentDate = @AbsentDate
   And EmployeeID = @EmployeeID And ShiftID = @ShiftID
     
   Set @curHV1020 = cursor static for  
    Select	Cast(@AbsentDate + ' ' + FromMinute As DateTime), Cast(@AbsentDate + ' ' + ToMinute As DateTime), 
			IsNextDay, AbsentTypeID, Orders, TypeID, WorkingTime 
	From HV1020_IPL  
    Where ShiftID = @ShiftID And DateTypeID = @DateTypeID  
    Order By Orders  
    
   Open @curHV1020  
    
   Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders, @TypeID, @WorkingTime  
   While @@Fetch_Status = 0  
   Begin  
    Set @InEarlyMinutes = 0  
    Set @InLateMinutes = 0  
    Set @OutEarlyMinutes = 0  
    Set @OutLateMinutes = 0  
    Set @DeductMinutes =0  
    Set @DeductTotal =0
	Set @DeductAmount = 0
    Set @Sub = 0
	Set @SubAmount = 0
    Set @SubMinute = 0      Set @Coefficient = 1	Set @NotConfirmCo = 1 
      
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
    --Xac dinh vao tre ra som  
    If @TypeID = 'C' SET @InScanDate = @InScanDate_C  
    If @TypeID <> 'C' SET @InScanDate = @InScanDate_NotC  
    If @InScanDate <= @ToMinute And @OutScanDate>@FromMinute  
    Begin  
     Set @FromTimeValid = @InScanDate  
     Set @Sub = DATEDIFF ( mi , @InScanDate, @FromMinute )  
     If @Sub>=0  
      Begin  
       Set @InEarlyMinutes = @Sub  
       Set @InLateMinutes = 0  
      End  
     Else  
      Begin  
       Set @InEarlyMinutes = 0  
       Set @InLateMinutes = -@Sub  
      End  
     If @OutScanDate <= @ToMinute   
      Begin  
       Set @ToTimeValid = @OutScanDate  
       Set @OutEarlyMinutes = DATEDIFF ( mi , @OutScanDate, @ToMinute )  
      End  
     Else  
      Begin  
       If @Orders = @ShiftMaxRow  
        Begin  
         Set @ToTimeValid = @OutScanDate  
         Set @OutLateMinutes = -DATEDIFF ( mi , @OutScanDate, @ToMinute )  
        End  
       Else  
        Begin  
         Set @OutLateMinutes = 0  
         --Set @ToTimeValid = @ToMinute  
         Set @ToTimeValid = @OutScanDate  
         IF @TypeID <> 'C'  
          Begin  
           Set @InScanDate = DateAdd(ss,1,@ToMinute)  
           Set @InScanDate_NotC = @InScanDate   
          End  
        End  
      End  
  
     If isnull(@RestrictID,'')<>'' or Isnull(@LateBeginPermit00,0) <> 0 or ISNULL(@EarlyEndPermit00,0) <> 0  
      Begin  
       If isnull(@RestrictID,'')<>''  
        Select @LateBeginPermit=isnull(LateBeginPermit,0), @EarlyEndPermit=isnull(EarlyEndPermit,0) From HT1022  
        Where HT1022.RestrictID= @RestrictID  
       Else  
        Begin  
         Set @LateBeginPermit = @LateBeginPermit00  
         Set @EarlyEndPermit = @EarlyEndPermit00  
        End  
       --Tinh tong so phut bi tru         
       Set @DeductMinutes = Case When @InLateMinutes>@LateBeginPermit Then @InLateMinutes Else 0 End + Case When @OutEarlyMinutes>@EarlyEndPermit Then @OutEarlyMinutes Else 0 End  
       --Xac dinh so phut thuc tru va he so tru  
       Select Top 1 @SubMinute = isnull(SubMinute,0), @Coefficient = isnull(Coefficient,1), @NotConfirmCo = isnull(NotConfirmCo,1),
					@SubAmount = Amount
	   From HT1023   
       Where  HT1023.RestrictID= @RestrictID And  
        @DeductMinutes >= isnull(FromMinute,0) And  
        @DeductMinutes <= Case When isnull(ToMinute,0) = -1 Then 1440 Else isnull(ToMinute,0) End  
       Order by LevelID

	   IF Isnull(@IsConfirm,0) = 1 --- được duyệt
	   Begin		
			Set @DeductTotal = 0
			Set @DeductAmount = 0
	   End	  
	   ELSE --- chưa duyệt hoặc không duyệt
	   Begin
			Set @DeductTotal = isnull(@SubMinute,0) * isnull(@NotConfirmCo,1)
			Set @DeductAmount = isnull(@SubAmount,0) * isnull(@NotConfirmCo,1)
	   End
	   		 
      End --- có quy định
     Else --- không có quy định
      Begin
		If Isnull(@IsConfirm,0) = 1 --- được duyệt
		Begin
			Set @DeductMinutes = @InLateMinutes + @OutEarlyMinutes  
			Set @Coefficient = 1
			Set @DeductTotal = 0
			Set @DeductAmount = 0
		End
		Else --- không dược duyệt
		Begin
			Set @DeductMinutes = @InLateMinutes + @OutEarlyMinutes  
			Set @Coefficient = 1
			Set @DeductTotal = @DeductMinutes
		End   
      End

     Set @AbsentHour = CASE WHEN round((DATEDIFF ( mi , @FromMinute, @ToMinute ))/60,2) > @WorkingTime THEN @WorkingTime ELSE  round((DATEDIFF ( mi , @FromMinute, @ToMinute ))/60,2)  END

	 
	SET @sSQL001 = N'
     INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
        FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
        AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
        )  
     VALUES  (	newid(), '''+@DivisionID+''', '''+@EmployeeID+''', '''+@AbsentCardNo+''', '+STR(@TranMonth)+', '+STR(@TranYear)+',
				'''+Convert(Varchar(50),@AbsentDate,120)+''', '''+@ShiftID+''', '+STR(@o)+',  
				'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
				'+Convert(Varchar(50),@AbsentHour)+', '''+Convert(Varchar(50),@FromTimeValid,120)+''', '''+Convert(Varchar(50),@ToTimeValid,120)+''', 
				'''+@UserID+''', getDate(), '''+@UserID+''', getDate(),  
				'''+@AbsentTypeID+''', '+STR(@InEarlyMinutes)+', '+STR(@InLateMinutes)+', '+STR(@OutEarlyMinutes)+', 
				'+STR(@OutLateMinutes)+', '+STR(@DeductMinutes)+', 
				'''+IsnulL(@RestrictID,'')+''', '+Convert(Varchar(50),@Coefficient)+', '+STR(@DeductTotal)+'   
        )  '

	EXEC (@sSQL001)

	--- Insert số tiền bị trừ vào loại công đi trễ/về sớm (trừ tiền)
	 IF @DeductAmount <> 0 and Isnull(@InOutAbsentTypeID,'') <> ''
	 Begin
		 SET @sSQL002 = N'
			INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
			FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
			AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
			)  
			VALUES  (newid(),'''+@DivisionID+''', '''+@EmployeeID+''', '''+@AbsentCardNo+''', '+STR(@TranMonth)+', '+STR(@TranYear)+',
					'''+Convert(Varchar(50),@AbsentDate,120)+''', '''+@ShiftID+''',
					'+STR(@ShiftMaxRow+2)+',  
					'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
					'+Convert(Varchar(50),@DeductAmount)+', '''+Convert(Varchar(50),@FromTimeValid,120)+''', '''+Convert(Varchar(50),@ToTimeValid,120)+''', 
					'''+@UserID+''', getDate(), '''+@UserID+''', getDate(),  
					'''+@InOutAbsentTypeID+''', '+STR(@InEarlyMinutes)+', '+STR(@InLateMinutes)+', '+STR(@OutEarlyMinutes)+', 
					'+STR(@OutLateMinutes)+', '+STR(@DeductMinutes)+',  
					'''+IsnulL(@RestrictID,'')+''', '+Convert(Varchar(50),@NotConfirmCo)+', '+STR(@DeductTotal)+'   
			)
			'
		EXEC (@sSQL002)
	 End

	 --- Insert số tiền bị trừ vào loại công đi trễ/về sớm (trừ công)
	 IF @DeductTotal <> 0 and Isnull(@InOutAbsentTypeID_H,'') <> ''
	 Begin
		SET @sSQL003 = N'
		INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
        FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
        AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
        )  
		VALUES  (newid(),'''+@DivisionID+''', '''+@EmployeeID+''', '''+@AbsentCardNo+''', '+STR(@TranMonth)+', '+STR(@TranYear)+',
				'''+Convert(Varchar(50),@AbsentDate,120)+''', '''+@ShiftID+''', '+STR(@ShiftMaxRow+3)+', 
				'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
				'+Convert(Varchar(50),@DeductTotal)+', '''+Convert(Varchar(50),@FromTimeValid,120)+''', '''+Convert(Varchar(50),@ToTimeValid,120)+''',
				'''+@UserID+''', getDate(), '''+@UserID+''', getDate(), 
				'''+@InOutAbsentTypeID+''', '+STR(@InEarlyMinutes)+', '+STR(@InLateMinutes)+', '+STR(@OutEarlyMinutes)+', 
				'+STR(@OutLateMinutes)+', '+STR(@DeductMinutes)+',  '''+IsnulL(@RestrictID,'')+''',
				case when '+STR(Isnull(@IsConfirm,0))+' = 1 then  '+Convert(Varchar(50),@Coefficient)+' else  '+Convert(Varchar(50),@NotConfirmCo)+' end, '+STR(@DeductTotal)+'    
        )
		'
		EXEC (@sSQL003)
	 End

     Set @o = @o +1        
    End  
  
    Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders, @TypeID, @WorkingTime  
   End  
   Close @curHV1020  
  
  Fetch Next From @curHV2433 Into @InScanDate, @OutScanDate  
 End 

 Close @curHV2433     
  
Deallocate @curHV2433  
  
Drop Table #HT2433

SET NOCOUNT OFF




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
