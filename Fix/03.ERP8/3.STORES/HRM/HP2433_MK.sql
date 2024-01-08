IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2433_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2433_MK]
GO

SET NOCOUNT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--- Created on 14/12/2015 by Bảo Anh: Customize chấm công cho Meiko (bổ sung xử lý các loại công NB,CN,công khác, làm tròn số giờ OT theo quy định đã thiết lập)
--- Modify on 27/04/2016 by Bảo Anh: Sửa lỗi chấm công khác và OT sai
--- Modify on 20/06/2016 by Bảo Anh: Cải tiến tốc độ
--- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modify on 11/09/2020 by Nhựt Trường: Merge code Meiko (Bổ sung @FromMinute_OT và @ToMinute_OT).

CREATE PROCEDURE [dbo].[HP2433_MK]  @DivisionID nvarchar(50),  
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
  @DeductMinutes decimal (28,8),  
  @DeductTotal decimal (28,8),  
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
  @InScanDate_Or Datetime,  
  @OutScanDate_Or Datetime,
  @FromMinute_OT Datetime,  
  @ToMinute_OT Datetime

--- Lấy số phút được phép đi trễ, về sớm theo thiết lập  
SELECT @LateBeginPermit00 = Isnull(LateBeginPermit,0), @EarlyEndPermit00 = Isnull(EarlyEndPermit,0)  
FROM HT0000 WHERE DivisionID = @DivisionID  
  
Select @ShiftMaxRow = Isnull(Max(Orders),'') From HV1020  
Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and TypeID not in ('C','NB','CN')

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


 --Tao bang tam lay du lieu cua ca  
 /*  
 Create Table #HT1020 (  
    FromMinute,  
    ToMinute,  
    IsNextDay, AbsentTypeID, RestrictID, Orders  
    )  
 */  
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

 --Select @ShiftID, InScanDate,OutScanDate From #HT2433 Order by Orders  
 --So sanh doi chieu tung dong quet the thuc te va thiet lap  
 Set @curHV2433 = cursor static for  
  Select InScanDate,OutScanDate From #HT2433 Order by Orders  
   
 Open @curHV2433  
 --Lap tung dong thuc te  
 Fetch Next From @curHV2433 Into @InScanDate, @OutScanDate  
 While @@Fetch_Status = 0  
 Begin
   Set @InScanDate_Or = @InScanDate
Set @OutScanDate_Or = @OutScanDate


   --- 1. Chấm cho các loại công không phải công khác/nghỉ bù/con nhỏ
   Set @curHV1020 = cursor static for  
		Select Cast(@AbsentDate + ' ' + FromMinute As DateTime), Cast(@AbsentDate + ' ' + ToMinute As DateTime), IsNextDay, AbsentTypeID, RestrictID, Orders, TypeID From HV1020  
		Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and TypeID not in ('C','NB','CN')
		Order By Orders  
    
   Open @curHV1020  
    
   Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @RestrictID, @Orders, @TypeID  
   While @@Fetch_Status = 0  
   BEGIN  
    Set @InEarlyMinutes = 0  
    Set @InLateMinutes = 0  
    Set @OutEarlyMinutes = 0  
    Set @OutLateMinutes = 0  
    Set @DeductMinutes =0  
    Set @DeductTotal =0  
    Set @Sub = 0  
    Set @SubMinute = 0      Set @Coefficient = 1  
      
    If @IsNextDayDetail = 1  
     Begin  
      If (@FromMinute>@ToMinute)  
       Begin  
        Set @ToMinute = DateAdd(d,1,@ToMinute)  
       End  
      Else   
       Begin  
        Set @FromMinute = DateAdd(d,1,@FromMinute)  
        Set @ToMinute = DateAdd(d,1,@ToMinute)  
       End  
     End  
	 --select @AbsentTypeID, @InScanDate, @ToMinute ,  @OutScanDate, @FromMinute 
    --Bat dau so sanh doi chieu  
    --Xac dinh vao tre ra som
    If @InScanDate <= @ToMinute And @OutScanDate>@FromMinute  
    BEGIN  
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
			BEGIN  				
			 Set @OutLateMinutes = 0  
			 --Set @ToTimeValid = @ToMinute  
			 Set @ToTimeValid = @OutScanDate
			 Set @InScanDate = DateAdd(ss,1,@ToMinute)
			End  
		  End  
				

		IF (Select top 1 TypeID From HT1013 Where DivisionID = @DivisionID And IsMonth = 0 and AbsentTypeID =@AbsentTypeID) <> 'OT'
		BEGIN
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
		   Select Top 1 @SubMinute = isnull(SubMinute,0), @Coefficient = isnull(Coefficient,1) From HT1023   
		   Where HT1023.DivisionID = @DivisionID and HT1023.RestrictID= @RestrictID And  
			@DeductMinutes >= isnull(FromMinute,0) And  
			@DeductMinutes <= Case When isnull(ToMinute,0) = -1 Then 1440 Else isnull(ToMinute,0) End  
		   Order by LevelID  
		   Set @DeductTotal = Case When isnull(@SubMinute,0)>0 Then isnull(@SubMinute,0) * isnull(@Coefficient,1) Else isnull(@DeductMinutes,0) * isnull(@Coefficient,1) End  
         
		  End       
		 Else  
		  Begin  
		   Set @DeductMinutes = @InLateMinutes + @OutEarlyMinutes  
		   Set @Coefficient = 1  
		   Set @DeductTotal = @DeductMinutes   
		  End
	  
		  Set @AbsentHour = round((DATEDIFF (mi, @FromMinute, @ToMinute) - @DeductTotal)/60,2)  
		END --- loại cong không phải 'OT'
	
		ELSE	  --- Customize Meiko: nếu loại công OT thì làm tròn theo quy định đã thiết lập
		BEGIN
			  --select 'ot1', @ShiftID, @AbsentTypeID, @FromMinute , @FromTimeValid , @ToMinute , @ToTimeValid
			Select @ToMinute_OT = Case when @ToMinute < @ToTimeValid then @ToMinute else @ToTimeValid end
			Select @FromMinute_OT = Case when @FromMinute < @FromTimeValid then @FromTimeValid else @FromMinute end
			Select @DeductMinutes = DATEDIFF (mi , @FromMinute_OT, @ToMinute_OT)	--- số giờ OT

			  --select 'ot2', @ShiftID, @AbsentTypeID, @DeductMinutes, @FromMinute_OT, @ToMinute_OT

			If isnull(@RestrictID,'')<>''  
			Begin			
				Select Top 1 @SubMinute = isnull(SubMinute,0), @Coefficient = isnull(Coefficient,1) From HT1023   
				Where HT1023.DivisionID = @DivisionID and HT1023.RestrictID= @RestrictID And  
					@DeductMinutes >= isnull(FromMinute,0) And  
					@DeductMinutes <= Case When isnull(ToMinute,0) = -1 Then 1440 Else isnull(ToMinute,0) End  
				Order by LevelID  
			
				Set @DeductTotal = Case When isnull(@SubMinute,0)>0 Then isnull(@SubMinute,0) * isnull(@Coefficient,1) Else isnull(@DeductMinutes,0) * isnull(@Coefficient,1) End
				Set @AbsentHour = round(@DeductTotal/60,2)
			End
			Else --- không có quy định làm tròn số giờ OT				
				Set @AbsentHour = round(@DeductMinutes/60,2)
				
		END
	  --select @AbsentTypeID, @AbsentHour
		 --- Bổ sung xét cho trường hợp loại công cơm (Hưng Vượng)  
		 /*IF @TypeID = 'C'  
		  Begin  
		   SET @AbsentHour = round(DATEDIFF(mi , @InScanDate, @OutScanDate)/60,2)  
		   SET @DeductMinutes = @InLateMinutes + @OutEarlyMinutes  
		   Set @DeductTotal = @DeductMinutes         
		  End  
		 */   
		-- Exec AP0000 @DivisionID, @TransactionID  OUTPUT, 'HT2407', 'AC', @TranYear, @TranMonth, 20, 3, 0, ''  
		SET @sSQL001 = N'
		 INSERT INTO '+@TableHT2407+' (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
			FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
			AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
			)  
		 VALUES  (newid(),'''+@DivisionID+''', '''+@EmployeeID+''', '''+@AbsentCardNo+''', '+STR(@TranMonth)+', '+STR(@TranYear)+',
				'''+Convert(Varchar(50),@AbsentDate,120)+''', '''+@ShiftID+''', '+STR(@o)+',    
				'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
				'+Convert(Varchar(50),@AbsentHour)+', '''+Convert(Varchar(50),@FromTimeValid,120)+''', '''+Convert(Varchar(50),@ToTimeValid,120)+''', 
				'''+@UserID+''', getDate(), '''+@UserID+''', getDate(),   
				'''+@AbsentTypeID+''', '+STR(@InEarlyMinutes)+', '+STR(@InLateMinutes)+', '+STR(@OutEarlyMinutes)+', 
				'+STR(@OutLateMinutes)+', '+STR(@DeductMinutes)+', 
				'''+IsnulL(@RestrictID,'')+''', '+Convert(Varchar(50),@Coefficient)+', '+STR(@DeductTotal)+'
			)  '

			EXEC (@sSQL001)

		 Set @o = @o +1        
    END  
  
    Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @RestrictID, @Orders, @TypeID  
   End  
   Close @curHV1020

    
	
   --- 2. Chấm cho các loại công đặc biệt: công khác, nghỉ bù, nuôi con nhỏ
	Set @curHV1020 = cursor static for  
	Select Cast(@AbsentDate + ' ' + FromMinute As DateTime), Cast(@AbsentDate + ' ' + ToMinute As DateTime), IsNextDay, AbsentTypeID, RestrictID, TypeID From HV1020  
	Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and TypeID in ('C','NB','CN')
	Order By Orders
    
	Open @curHV1020  
    
	Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @RestrictID, @TypeID   
	While @@Fetch_Status = 0  
	Begin
		Set @AbsentHour = 0
		If @IsNextDayDetail = 1  
		Begin  
			If @FromMinute>@ToMinute
				Set @ToMinute = DateAdd(d,1,@ToMinute)
			Else   
			Begin
				Set @FromMinute = DateAdd(d,1,@FromMinute)  
				Set @ToMinute = DateAdd(d,1,@ToMinute)
			End
		End
	
		
		If @InScanDate_Or <= @ToMinute And @OutScanDate_Or>@FromMinute
		Begin
			--select @AbsentTypeID, @InScanDate_Or, @ToMinute,  @OutScanDate_Or, @FromMinute
			If @OutScanDate_Or > @ToMinute	SET @OutScanDate = @ToMinute
				ELSE Set @OutScanDate = @OutScanDate_Or
			If @InScanDate_Or < @FromMinute	SET @InScanDate = @FromMinute
				ELSE Set @InScanDate = @InScanDate_Or
			Set @AbsentHour = round((DATEDIFF (mi, @InScanDate, @OutScanDate))/60,2)

			-- select @AbsentTypeID, @InScanDate, @OutScanDate

			SET @sSQL001 = N'
			INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
			FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
			AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
			)  
			VALUES  (newid(),'''+@DivisionID+''', '''+@EmployeeID+''', '''+@AbsentCardNo+''', '+STR(@TranMonth)+', '+STR(@TranYear)+',
			'''+Convert(Varchar(50),@AbsentDate,120)+''', '''+@ShiftID+''', '+STR(@o)+',
			'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
			'+CASE WHEN @TypeID = 'NB' THEN Convert(Varchar(50),@AbsentHour*(-1)) ELSE  Convert(Varchar(50),@AbsentHour) END+', 
			'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
			'''+@UserID+''', getDate(), '''+@UserID+''', getDate(),  
			'''+@AbsentTypeID+''', NULL, NULL, NULL, NULL, NULL, '''+IsnulL(@RestrictID,'')+''', NULL, NULL   
			)
			'
			EXEC (@sSQL001)
		End
		
		Set @o = @o +1
		Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @RestrictID, @TypeID
	End
  
	Close @curHV1020

  Fetch Next From @curHV2433 Into @InScanDate, @OutScanDate  
 End  
  
Close @curHV2433
Deallocate @curHV2433
Deallocate @curHV1020
Drop Table #HT2433

SET NOCOUNT OFF




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
