--Import du lieu ngam thiet lap tieu chuan dinh muc sưc khoe
	---Can nang be trai 

IF NOT EXISTS (SELECT TOP 1 1 FROM NMT0002 WHERE YearOld = 0 AND LowerThreshold = 2.9)
 BEGIN 
	    INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',0,2.9,3.3,3.9,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',1,3.9,4.5,5.1,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',2,4.9,5.6,6.3,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',3,5.7,6.4,7.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',4,6.2,7.0,7.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',5,6.7,7.5,8.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',6,7.1,7.9,8.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',7,7.4,8.3,9.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',8,7.7,8.6,9.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',9,8.8,8.9,9.9,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',10,8.2,9.2,10.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',11,8.4,9.4,10.5,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',12,8.6,9.6,10.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',13,8.8,9.9,11.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',14,9.0,10.1,11.3,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',15,9.2,10.3,11.5,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',16,9.4,10.5,11.7,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',17,9.6,10.7,12.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',18,9.8,10.9,12.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',19,10.0,11.1,12.5,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',20,10.1,11.3,12.7,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',21,10.3,11.5,12.9,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',22,10.5,11.8,13.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',23,10.7,12.0,13.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',24,10.8,12.2,13.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',25,11.1,12.4,13.9,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',26,11.2,12.5,14.1,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',27,11.3,12.7,14.3,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',28,11.5,12.9,14.5,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',29,11.7,13.1,14.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',30,11.8,13.3,15.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',31,12.0,13.5,15.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',32,12.1,13.7,15.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',33,12.3,13.8,15.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',34,12.4,14.0,15.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',35,12.6,14.2,16.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',36,12.7,14.3,16.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',37,12.9,14.5,16.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',38,13.0,14.7,16.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',39,13.1,14.8,16.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',40,13.3,15.0,17.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',41,13.4,15.2,17.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',42,13.6,15.3,17.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',43,13.7,15.5,17.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',44,13.8,15.7,17.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',45,14.0,15.8,18.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',46,14.1,16.0,18.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',47,14.3,16.2,18.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',48,14.4,16.3,18.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',49,14.5,16.5,18.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',50,14.7,16.7,19.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',51,14.8,16.8,19.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',52,15.0,17.0,19.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',53,15.1,17.2,19.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',54,15.2,17.3,19.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',55,15.4,17.5,20.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',56,15.5,17.7,20.2,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',57,15.6,17.8,20.4,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',58,15.8,18.0,20.6,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',59,15.9,18.2,20.8,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',60,16.0,18.3,21.0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
	--Chieu cao be trai 
	    INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',0,48.0,49.9,51.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',1,52.8,54.7,56.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',2,56.4,58.4,60.4,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',3,59.4,61.4,63.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',4,61.8,63.9,66.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',5,63.8,65.9,68.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',6,65.5,67.6,69.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',7,67.0,69.2,71.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',8,68.4,70.6,72.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',9,69.7,72.0,74.2,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',10,71.0,73.3,75.6,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',11,72.2,74.5,76.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',12,73.4,74.7,78.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',13,74.5,76.9,79.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',14,75.6,78.0,80.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',15,76.6,79.1,81.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',16,77.6,80.2,82.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',17,78.6,81.2,83.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',18,79.6,82.3,85.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',19,80.5,83.2,86.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',20,81.4,84.2,87.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',21,82.3,85.1,88.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',22,83.1,86.0,89.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',23,83.9,86.9,89.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',24,84.9,88.0,91.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',25,84.8,87.8,90.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',26,85.6,88.8,92.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',27,86.4,89.6,92.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',28,87.1,90.4,93.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',29,87.8,91.2,94.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',30,88.5,91.9,95.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',31,89.2,92.7,96.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',32,89.9,93.4,96.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',33,90.5,94.1,97.6,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',34,91.1,94.8,98.4,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',35,91.8,95.4,99.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',36,92.4,96.1,99.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',37,93.0,96.7,100.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()


		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',38,93.6,97.4,101.2,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',39,94.4,98.0,101.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',40,94.7,98.6,102.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',41,95.3,99.2,103.2,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',42,95.9,99.9,103.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',43,96.4,100.4,104.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',44,97.0,101.0,105.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
			 
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',45,97.5,101.6,105.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',46,98.1,102.2,106.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',47,98.6,102.8,106.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',48,99.,103.3,107.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',49,99.7,103.9,108.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',50,100.2,104.4,108.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',51,100.7,105.0,109.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',52,101.2,105.6,109.9,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',53,101.7,106.1,110.5,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',54,102.3,106.7,111.1,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',55,102.8,107.2,111.7,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',56,103.3,107.8,112.3,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',57,103.8,108.3,112.8,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',58,104.3,108.9,113.4,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',59,104.8,109.4,114.0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	    SELECT '@@@',60,105.3,110.0,114.6,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

	--Cân nặng bé gái 
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',0,2.8,3.2,3.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
			  	
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',1,3.6,4.2,4.8,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',2,4.5,5.1,5.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
 
        INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',3,5.1,5.8,6.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',4,5.6,6.4,7.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

	    INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',5,6.1,6.9,7.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

	    INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',6,6.4,7.3,8.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',7,6.7,7.6,8.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',8,7.0,7.9,9.0,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',9,7.3,8.2,9.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',10,7.5,8.5,9.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',11,7.7,8.7,9.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',12,7.9,8.9,10.2,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',13,8.1,9.2,10.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',14,8.3,9.4,10.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',15,8.5,9.6,10.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',16,8.7,9.8,11.2,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',17,8.8,10.0,11.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',18,9.0,10.2,11.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',19,9.2,10.4,11.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',20,9.4,10.6,12.1,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',21,9.6,10.9,12.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',22,9.8,11.1,12.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
        
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',23,9.9,11.3,12.8,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',24,10.1,11.5,13.1,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',25,10.3,11.7,13.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',26,10.5,11.9,13.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',27,10.7,12.1,13.8,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',28,10.8,12.3,14.0,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',29,11.0,12.5,14.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',30,11.2,12.7,14.5,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',31,11.3,12.9,14.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',32,11.5,13.1,15.0,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',33,11.7,13.3,15.2,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',34,11.8,13.5,15.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',35,12.0,13.7,15.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',36,12.1,13.9,15.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',37,12.3,14.0,16.1,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',38,12.5,14.2,16.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',39,12.6,14.4,16.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',40,12.8,14.6,16.8,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',41,12.9,14.8,17.0,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',42,13.1,15.0,17.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',43,13.2,15.2,17.5,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',44,13.4,15.3,17.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',45,13.5,15.5,17.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',46,13.7,15.7,18.2,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',47,13.8,15.9,18.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',48,14.0,16.1,18.6,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',49,14.1,16.3,18.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',50,14.3,16.4,19.1,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',51,14.4,16.6,19.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',52,14.5,16.8,19.5,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',53,14.7,17.0,19.8,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',54,14.8,17.2,20.0,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',55,15.0,17.3,20.2,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',56,15.1,17.5,20.4,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',57,15.3,17.7,20.7,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',58,15.4,17.9,20.9,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',59,15.5,18.0,21.1,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',60,15.7,18.2,21.3,3,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
		--Chieu cao be gái 
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',0,47.3,49.1,51,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
			  	
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',1,51.7,53.7,55.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',2,55.5,57.1,59.1,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',3,57.7,59.8,61.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',4,59.9,62.1,64.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',5,61.8,64.0,66.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',6,63.5,65.7,68,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',7,65.0,67.3,69.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',8,66.4,68.7,71.1,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',9,67.7,70.1,72.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',10,69.0,71.5,73.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',11,70.3,72.8,75.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',12,71.4,74.0,76.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',13,72.5,75.2,77.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',14,73.6,76.4,79.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',15,74.7,77.5,80.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',16,75.7,78.6,81.5,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',17,76.7,79.7,82.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',18,77.8,80.7,83.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',19,78.7,81.7,84.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',20,79.6,82.7,85.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',21,80.5,83.7,86.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',22,81.4,84.6,87.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',23,82.2,85.5,88.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',24,83.2,86.4,89.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',25,83.2,86.6,90,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',26,84.0,87.4,90.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',27,84.8,88.3,91.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',28,85.5,89.1,92.7,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',29,86.3,89.9,93.5,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
			  
		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',30,87.1,90.7,94.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',31,87.7,91.4,95.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',32,88.4,92.2,95.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',33,89.1,92.9,96.7,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',34,89.8,93.6,97.5,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',35,90.5,94.4,98.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',36,91.2,95.1,98.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',37,91.7,95.7,99.7,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',38,92.4,96.4,100.5,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',39,93.0,97.1,101.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',40,93.6,97.7,101.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',41,94.2,98.2,102.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',42,95.0,99,103.1,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',43,95.4,99.7,103.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',44,96.0,100.3,104.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',45,96.6,100.9,105.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',46,97.2,101.5,105.9,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',47,97.7,102.1,106.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',48,98.4,102.7,107,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',49,98.8,103.3,107.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',50,99.4,103.9,108.4,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',51,99.9,104.5,109.1,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',52,100.4,105,109.7,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',53,101.0,105.6,110.3,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',54,101.6,106.2,110.7,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',55,102.0,106.7,111.5,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',56,102.5,107.3,112.1,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',57,103.0,107.8,112.6,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',58,103.5,108.4,113.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',59,104.0,108.9,113.8,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

		INSERT INTO NMT0002(DivisionID, YearOld, LowerThreshold,QuotaThreshold, AboveThreshold,QuotaType,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@',60,104.7,109.4,114.2,4,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()

END

