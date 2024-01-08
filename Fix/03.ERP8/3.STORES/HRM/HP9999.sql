IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP9999]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Created by Nguyen Van Nhan, Date 08/05/2004  
----- Purpose: Khoa so ky ke toan  
---- Modify on 08/06/2015 by Bảo Anh: Lấy PeriodNum từ thông tin đơn vị AT1101   
---- Modify on 28/01/2016 by Quốc Tuấn: nếu khóa sổ HRM thì bắn dữ liệu cho Approve Online
---- Modify by Phương Thảo on 09/09/2016: Bổ sung tách bảng nghiệp vụ
---- Modify by Bảo Thy on 02/03/2017: Bổ sung bắn thông tin MaxAllowedTime, MaxTimeOut cho Approve Online
---- Modify on 14/12/2022 by Đức Tuyên: Bổ sung phát sinh kỳ bị thiếu do sinh kỳ tự động trên ERP9.
  
/********************************************  
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]  
'********************************************/  
  
  
CREATE PROCEDURE [dbo].[HP9999]   
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),   
  @TranMonth as INT,   
  @TranYear as INT,  
  @BeginDate as DATETIME,  
  @EndDate as DATETIME,
  @CheckPeriod as int =0
   
 AS  
  
  
Declare @Closing As TINYINT,  
		@NextMonth  TINYINT,  
		@NextYear  SMALLINT,  
		@PeriodNum  TINYINT,  
		@MaxPeriod INT,
		@sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)
   
   
Select  @PeriodNum = PeriodNum  
From AT1101 ---HT9000
where DivisionID=@DivisionID

If @PeriodNum Is Null   
Set @PeriodNum = 12  
  
Set @NextMonth = @TranMonth % @PeriodNum + 1  
Set @NextYear = @TranYear + @TranMonth/@PeriodNum  
  
Select   @Closing = Closing  
From  HT9999  
Where  DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear  
    
Select  @MaxPeriod = Max(TranMonth + TranYear * 100)  
From HT9999  
Where DivisionID = @DivisionID  
  
IF  @Closing <> 1 and @CheckPeriod = 0
BEGIN
    
	Update  HT9999  
	Set  Closing = 1  
	From  HT9999  
	Where  DivisionID = @DivisionID And TranMonth =@TranMonth And TranYear = @TranYear  
  
	IF @MaxPeriod < (@NextMonth + @NextYear * 100)  
	Begin  
	Insert     HT9999  (TranMonth,TranYear, DivisionID,Closing,BeginDate,EndDate)   
	Values(@NextMonth,@NextYear, @DivisionID,0,@BeginDate,@EndDate)  
	If Exists (Select 1 From HT0000 Where DivisionID = @DivisionID)  
	Begin  
		Update HT0000 Set  TranMonth = @NextMonth,  TranYear = @NextYear  
		Where  DivisionID = @DivisionID   
	End  
  
	End  
	IF @MaxPeriod >= (@NextMonth + @NextYear * 100)  
	Begin   
		Update  HT9999  Set  BeginDate = @BeginDate,  EndDate = @EndDate  
		From  HT9999  
		Where  DivisionID = @DivisionID And TranMonth = @NextMonth And TranYear = @NextYear  
	end     
  
  
	 -- Khóa sổ thì bắn tự động dữ liệu qua tháng sau viết chuỗi đễ khỏi bị lỗi bảng
 
	 --- Thiếp lập cập duyệt
	-----------OOT0010------------------
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OOT0010' AND xtype='U')
	BEGIN
		SET @sSQL='
		IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0010 WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@NextMonth)+' AND TranYear = '+STR(@NextYear)+')
		BEGIN
			--Đẩy dữ liệu Master
			INSERT INTO OOT0010(DivisionID, TranMonth, TranYear, VoucherTypeID, AbsentType,
					[Level], AbsentTypeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT DivisionID, '+STR(@NextMonth)+', '+STR(@NextYear)+', VoucherTypeID, AbsentType, [Level],AbsentTypeID, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
			FROM OOT0010 WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'
			--Đẩy dữ liêu detail
			--Đơn xin phép
			INSERT INTO OOT0011(DivisionID, AbsentType, RollLevel, DutyID, APKMaster)
			SELECT OOT11.DivisionID,OOT11.AbsentType, OOT11.RollLevel, OOT11.DutyID,
			(SELECT TOP 1 APK FROM OOT0010 WHERE AbsentType=OOT11.AbsentType AND TranMonth='+STR(@NextMonth)+' AND TranYear= '+STR(@NextYear)+')
			FROM OOT0011 OOT11
			INNER JOIN OOT0010 OOT10 ON OOT10.DivisionID = OOT11.DivisionID AND OOT10.APK = OOT11.APKMaster
			WHERE OOT11.DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'
		END

		--- Thiếp lập Thời gian OT
		IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0020 WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@NextMonth)+' AND TranYear = '+STR(@NextYear)+')
		   INSERT INTO OOT0020(DivisionID, TranMonth, TranYear,TimeLaw, TimeCompany,
					   EmailSuggest, EmailApprove, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, MaxAllowedTime, MaxTimeOut)
			SELECT DivisionID, '+STR(@NextMonth)+', '+STR(@NextYear)+',TimeLaw, TimeCompany,EmailSuggest, EmailApprove, '''+@UserID+''', GETDATE(),
			'''+@UserID+''', GETDATE(), MaxAllowedTime, MaxTimeOut
			FROM OOT0020 WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'	
	
		'
		EXEC (@sSQL)
		--PRINT @sSQL
	END
	
	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)
	BEGIN		
		---- Tạo bảng chi tiết cho kỳ mới
		EXEC AP9992 @DivisionID, @NextMonth, @NextYear, 'HRM', '%'

		---- Đẩy dữ liệu vào bảng nghiệp vụ Năm, All (Tách bảng nghiệp vụ)
		EXEC AP9991 @DivisionID, @TranMonth, @TranYear, @TranMonth, @TranYear, 'HRM', '%'		

	END
END 

EXEC AP99999 @DivisionID=@DivisionID, @MaxPeriod=@MaxPeriod, @PeriodNum=@PeriodNum, @ModuleID =N'ASOFTHRM', @TableName=N'HT9999', @UserID=N'ASOFTADMIN', @CheckPeriod=@CheckPeriod



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

