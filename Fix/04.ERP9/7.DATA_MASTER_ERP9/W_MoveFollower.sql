--- Create by Trương Tấn Thành on 14/09/2020
--- Tách dữ liệu Follower từ bảng CMNT0020 sang các bảng follower cho từng module {X}T9020
--- ADMT9020, BEMT9020, CIT9020, CRMT9020, HRMT9020, KPIT9020, OOT9020, POT9020, ST9020

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT0020]') AND TYPE IN (N'U'))
BEGIN
	IF(EXISTS (SELECT TOP 1 1 FROM CMNT0020))
	BEGIN
		DECLARE @ModuleList TABLE (IndexCol INT, Module VARCHAR(50))
		DECLARE @Temp TABLE (APK UNIQUEIDENTIFIER, APKMaster UNIQUEIDENTIFIER, DivisionID VARCHAR(50)
				, RelatedToID VARCHAR(50), TableID VARCHAR(50), FollowerColumn VARCHAR(50), FollowerID VARCHAR(50)
				, TypeFollow TINYINT, CreateDate DATETIME)
		DECLARE @Temp2 TABLE (APKMaster UNIQUEIDENTIFIER, TableID VARCHAR(50), FollowerID VARCHAR(50), TypeFollow TINYINT, RelatedToID VARCHAR(50), RelatedToTypeID VARCHAR(50)
				, CreateUserID VARCHAR(50))

		DECLARE	@LenOfList INT = NULL,
				@Count INT = 0,
				@ModuleID VARCHAR(50) = '',
				@CountResult INT,
				@SQL_Insert VARCHAR(MAX) = '',
				@IsSuccessful INT = 0

		BEGIN TRY
			-- NẾU CÓ THÊM MODULE THÌ THÊM Ở ĐÂY: MÃ MODULE - KHÔNG LẤY TỰ ASOFT
			INSERT @ModuleList(IndexCol, Module) VALUES (0,'ADM'), (1,'BEM'), (2,'CI'), (3,'CRM'), (4,'HRM'), (5,'KPI'), (6,'OO'), (7,'PO'), (8,'S'), (9,'BI'), (10, 'CSM'), (11, 'DRM'), (12, 'EDM'), (13, 'FN'), (14, 'LM'), (15, 'MT'), (16, 'NM'), (17,'OP'), (18, 'PA'), (19, 'POS'), (20, 'SHM'), (21, 'SO'), (22, 'T'), (23, 'WM')
			SET @LenOfList = (SELECT COUNT (Module) FROM @ModuleList)
			PRINT (@LenOfList)
	
			BEGIN TRANSACTION;
			BEGIN
				WHILE @Count< @LenOfList
				BEGIN 
					-- Lấy từng mã Module trong List
					SET @ModuleID = (SELECT Module FROM @ModuleList WHERE IndexCol = @Count )

					-- Select dữ liệu từ bảng CMNT0020 theo từng Module.
					IF(@ModuleID = 'S')
					BEGIN
						INSERT INTO @Temp(APK, APKMaster, DivisionID, RelatedToID, TableID, FollowerColumn, FollowerID, TypeFollow, CreateDate)
						SELECT APK, APKMaster, DivisionID, RelatedToID, TableID,
							CONCAT('Follower', RIGHT(CONCAT('0', ROW_NUMBER() OVER (PARTITION BY APKMaster ORDER BY APKMaster)), 2)) AS FollowerColumn, FollowerID, TypeFollow, CreateDate
						FROM CMNT0020 
						WHERE TableID = ('OOT0030') OR TableID LIKE (@ModuleID + 'T%')

						INSERT INTO @Temp2(APKMaster, TableID, FollowerID, TypeFollow , RelatedToID, RelatedToTypeID, CreateUserID)
						SELECT APKMaster, TableID, FollowerID, TypeFollow, RelatedToID, RelatedToTypeID, CreateUserID
						FROM CMNT0020 
						WHERE TableID = ('OOT0030') OR TableID LIKE (@ModuleID + 'T%')
					END
					ELSE IF(@ModuleID = 'HRM')
					BEGIN
						INSERT INTO @Temp(APK, APKMaster, DivisionID, RelatedToID, TableID, FollowerColumn, FollowerID, TypeFollow, CreateDate)
						SELECT APK, APKMaster, DivisionID, RelatedToID, TableID,
							CONCAT('Follower', RIGHT(CONCAT('0', ROW_NUMBER() OVER (PARTITION BY APKMaster ORDER BY APKMaster)), 2)) AS FollowerColumn, FollowerID, TypeFollow, CreateDate
						FROM CMNT0020 
						WHERE TableID IN ('OOT9000','OOT1000') OR TableID LIKE (@ModuleID + '%') 

						INSERT INTO @Temp2(APKMaster, TableID, FollowerID, TypeFollow , RelatedToID, RelatedToTypeID, CreateUserID)
						SELECT APKMaster, TableID, FollowerID, TypeFollow, RelatedToID, RelatedToTypeID, CreateUserID
						FROM CMNT0020
						WHERE TableID IN ('OOT9000','OOT1000') OR TableID LIKE (@ModuleID + '%') 

					END
					ELSE IF(@ModuleID = 'PO')
					BEGIN
						INSERT INTO @Temp(APK, APKMaster, DivisionID, RelatedToID, TableID, FollowerColumn, FollowerID, TypeFollow, CreateDate)
						SELECT APK, APKMaster, DivisionID, RelatedToID, TableID,
							CONCAT('Follower', RIGHT(CONCAT('0', ROW_NUMBER() OVER (PARTITION BY APKMaster ORDER BY APKMaster)), 2)) AS FollowerColumn, FollowerID, TypeFollow, CreateDate
						FROM CMNT0020 
						WHERE TableID IN ('OT3101','POT2021') OR TableID LIKE (@ModuleID + '%')
				
						INSERT INTO @Temp2(APKMaster, TableID, FollowerID, TypeFollow , RelatedToID, RelatedToTypeID, CreateUserID)
						SELECT APKMaster, TableID, FollowerID, TypeFollow, RelatedToID, RelatedToTypeID, CreateUserID
						FROM CMNT0020
						WHERE TableID IN ('OT3101','POT2021') OR TableID LIKE (@ModuleID + '%')
					END
					ELSE IF(@ModuleID = 'ADM')
					BEGIN
						INSERT INTO @Temp(APK, APKMaster, DivisionID, RelatedToID, TableID, FollowerColumn, FollowerID, TypeFollow, CreateDate)
						SELECT APK, APKMaster, DivisionID, RelatedToID, TableID,
							CONCAT('Follower', RIGHT(CONCAT('0', ROW_NUMBER() OVER (PARTITION BY APKMaster ORDER BY APKMaster)), 2)) AS FollowerColumn, FollowerID, TypeFollow, CreateDate
						FROM CMNT0020 
						WHERE TableID IN ('sysScreen') OR TableID LIKE (@ModuleID + '%')

						INSERT INTO @Temp2(APKMaster, TableID, FollowerID, TypeFollow , RelatedToID, RelatedToTypeID, CreateUserID)
						SELECT APKMaster, TableID, FollowerID, TypeFollow, RelatedToID, RelatedToTypeID, CreateUserID
						FROM CMNT0020
						WHERE TableID IN ('sysScreen') OR TableID LIKE (@ModuleID + '%')
					END
					ELSE
					BEGIN
						INSERT INTO @Temp(APK, APKMaster, DivisionID, RelatedToID, TableID, FollowerColumn, FollowerID, TypeFollow, CreateDate)
						SELECT APK, APKMaster, DivisionID, RelatedToID, TableID,
							CONCAT('Follower', RIGHT(CONCAT('0', ROW_NUMBER() OVER (PARTITION BY APKMaster ORDER BY APKMaster)), 2)) AS FollowerColumn, FollowerID, TypeFollow, CreateDate
						FROM CMNT0020 
						WHERE TableID LIKE (@ModuleID + '%') AND TableID NOT IN ('OOT9000','OOT1000','OOT0030','OT3101','POT2021','sysScreen') 

						INSERT INTO @Temp2(APKMaster, TableID, FollowerID, TypeFollow , RelatedToID, RelatedToTypeID, CreateUserID)
						SELECT APKMaster, TableID, FollowerID, TypeFollow, RelatedToID, RelatedToTypeID, CreateUserID
						FROM CMNT0020
						WHERE TableID LIKE (@ModuleID + '%') AND TableID NOT IN ('OOT9000','OOT1000','OOT0030','OT3101','POT2021','sysScreen') 
					END

					SELECT APKMaster, DivisionID, RelatedToID, TableID, MAX(Follower01) AS FollowerID01, MAX(Follower02) AS FollowerID02, MAX(Follower03) AS FollowerID03
						, MAX(Follower04) AS FollowerID04, MAX(Follower05) AS FollowerID05, MAX(Follower06) AS FollowerID06, MAX(Follower07) AS FollowerID07
						, MAX(Follower08) AS FollowerID08, MAX(Follower09) AS FollowerID09, MAX(Follower10) AS FollowerID10, MAX(Follower11) AS FollowerID11
						, MAX(Follower12) AS FollowerID12, MAX(Follower13) AS FollowerID13, MAX(Follower14) AS FollowerID14, MAX(Follower15) AS FollowerID15
						, MAX(Follower16) AS FollowerID16, MAX(Follower17) AS FollowerID17, MAX(Follower18) AS FollowerID18, MAX(Follower19) AS FollowerID19
						, MAX(Follower20) AS FollowerID20, Min(CreateDate) AS CreateDate
					INTO #TempTable01 -- Bảng tạm số 1 lưu thông tin dữ liệu Follower: APKMaster, DivisionID, RelatedToID, TableID, FollowerID{X}, CreateDate
					FROM
					(
						SELECT *FROM @Temp
					) x
					pivot 
					(
					MAX(FollowerID)
					FOR FollowerColumn in (Follower01, Follower02, Follower03, Follower04, Follower05, Follower06, Follower07, Follower08, Follower09, Follower10, Follower11, Follower12, Follower13, Follower14, Follower15, Follower16, Follower17, Follower18, Follower19, Follower20)
					) p 

					GROUP BY APKMaster, DivisionID, RelatedToID, TableID
					ORDER BY APKMaster

					SELECT T1.APKMaster, C.CreateUserID, ISNULL(C.TypeFollow,0) AS TypeFollow, ISNULL(C.RelatedToTypeID,0) AS RelatedToTypeID
					INTO #TempTable02 -- Bảng tạm số 2 lưu thông tin dữ liệu Follower:APKMaster, CreateUserID, TypeFollow, RelatedToTypeID
					FROM #TempTable01 T1
					INNER JOIN @Temp2 C ON C.APKMaster = T1.APKMaster AND T1.FollowerID01 = C.FollowerID
					Group By C.CreateUserID, T1.APKMaster, C.TypeFollow, C.RelatedToTypeID


					SELECT T1.*, A1.FullName AS FollowerName01, A2.FullName AS FollowerName02, A3.FullName AS FollowerName03, A4.FullName AS FollowerName04, A5.FullName AS FollowerName05
								, A6.FullName AS FollowerName06, A7.FullName AS FollowerName07, A8.FullName AS FollowerName08, A9.FullName AS FollowerName09, A10.FullName AS FollowerName10
								, A11.FullName AS FollowerName11, A12.FullName AS FollowerName12, A13.FullName AS FollowerName13, A14.FullName AS FollowerName14, A15.FullName AS FollowerName15
								, A16.FullName AS FollowerName16, A17.FullName AS FollowerName17, A18.FullName AS FollowerName18, A19.FullName AS FollowerName19, A20.FullName AS FollowerName20
					INTO #TempTable03 -- Bảng tạm số 3 lưu thông tin dữ liệu Follower: lưu các thông tin của bảng #TempTable01 và Name của các Follower.
					FROM #TempTable01 T1
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = T1.FollowerID01 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = T1.FollowerID02 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = T1.FollowerID03 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A4 WITH (NOLOCK) ON A4.EmployeeID = T1.FollowerID04 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A5 WITH (NOLOCK) ON A5.EmployeeID = T1.FollowerID05 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A6 WITH (NOLOCK) ON A6.EmployeeID = T1.FollowerID06 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A7 WITH (NOLOCK) ON A7.EmployeeID = T1.FollowerID07 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A8 WITH (NOLOCK) ON A8.EmployeeID = T1.FollowerID08 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A9 WITH (NOLOCK) ON A9.EmployeeID = T1.FollowerID09 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A10 WITH (NOLOCK) ON A10.EmployeeID = T1.FollowerID10 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A11 WITH (NOLOCK) ON A11.EmployeeID = T1.FollowerID11 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A12 WITH (NOLOCK) ON A12.EmployeeID = T1.FollowerID12 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = T1.FollowerID13 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A14 WITH (NOLOCK) ON A14.EmployeeID = T1.FollowerID14 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A15 WITH (NOLOCK) ON A15.EmployeeID = T1.FollowerID15 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A16 WITH (NOLOCK) ON A16.EmployeeID = T1.FollowerID16 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A17 WITH (NOLOCK) ON A17.EmployeeID = T1.FollowerID17 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A18 WITH (NOLOCK) ON A18.EmployeeID = T1.FollowerID18 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A19 WITH (NOLOCK) ON A19.EmployeeID = T1.FollowerID19 AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A20 WITH (NOLOCK) ON A20.EmployeeID = T1.FollowerID20 AND ISNULL(A1.Disabled, 0) = 0

					--INSERT {ModuleID}T9020
					SELECT t3.*, T2.TypeFollow, T2.CreateUserID, T2.RelatedToTypeID
					INTO #TempTable04 -- Bảng tạm số 4 lưu thông tin dữ liệu Follower theo cấu trúc bảng mới {ModuleID}T9020
					FROM #TempTable03 T3 
					INNER JOIN #TempTable02 T2 ON T3.APKMaster = t2.APKMaster
				
					SET @SQL_Insert = '
						INSERT INTO ' + @ModuleID + 'T9020(APK, DivisionID, APKMaster, RelatedToID, TableID, FollowerID01, FollowerName01, FollowerID02, FollowerName02, FollowerID03, FollowerName03, FollowerID04
									, FollowerName04, FollowerID05, FollowerName05, FollowerID06, FollowerName06, FollowerID07, FollowerName07, FollowerID08, FollowerName08, FollowerID09
									, FollowerName09, FollowerID10, FollowerName10, FollowerID11, FollowerName11, FollowerID12, FollowerName12, FollowerID13, FollowerName13, FollowerID14
									, FollowerName14, FollowerID15, FollowerName15, FollowerID16, FollowerName16, FollowerID17, FollowerName17, FollowerID18, FollowerName18, FollowerID19
									, FollowerName19, FollowerID20, FollowerName20, TypeFollow, CreateDate, CreateUserID, RelatedToTypeID)
						SELECT NEWID() AS APK, T4.DivisionID, T4.APKMaster, T4.RelatedToID, T4.TableID, T4.FollowerID01, T4.FollowerName01, T4.FollowerID02, T4.FollowerName02, T4.FollowerID03, T4.FollowerName03
							, T4.FollowerID04, T4.FollowerName04, T4.FollowerID05, T4.FollowerName05, T4.FollowerID06, T4.FollowerName06, T4.FollowerID07, T4.FollowerName07, T4.FollowerID08, T4.FollowerName08
							, T4.FollowerID09, T4.FollowerName09, T4.FollowerID10, T4.FollowerName10, T4.FollowerID11, T4.FollowerName11, T4.FollowerID12, T4.FollowerName12, T4.FollowerID13, T4.FollowerName13
							, T4.FollowerID14, T4.FollowerName14, T4.FollowerID15, T4.FollowerName15, T4.FollowerID16, T4.FollowerName16, T4.FollowerID17, T4.FollowerName17, T4.FollowerID18, T4.FollowerName18
							, T4.FollowerID19, T4.FollowerName19, T4.FollowerID20, T4.FollowerName20, T4.TypeFollow, T4.CreateDate, T4.CreateUserID, T4.RelatedToTypeID
						FROM #TempTable04 T4'

					EXECUTE(@SQL_Insert)

					SET @CountResult = (SELECT COUNT(APKMaster) FROM #TempTable04)
				
					-- Xóa các dữ liệu đã chuyển thành công qua {ModuleID}T9020
					DELETE FROM CMNT0020 WHERE APKMaster IN (SELECT APKMaster FROM #TempTable04)

					Drop Table #TempTable01 -- 
					Drop Table #TempTable02 -- Bảng tạm lưu các thông tin: CreateUserID, TypeFollow, RelatedToTypeID
					Drop Table #TempTable03 -- Bảng tạm lưu các thông tin của bảng #TempTable01 và Name của các Follower.
					Drop Table #TempTable04 -- Bảng tạm đầy đủ các thông tin để đẩy dữ liệu qua {ModuleID}T9020
					DELETE FROM @Temp
					DELETE FROM @Temp2

					SET @Count = @Count + 1
				END
			END
			COMMIT TRANSACTION;
			SET @IsSuccessful = 1
		END TRY

		BEGIN CATCH
			SELECT   
				ERROR_NUMBER() AS ErrorNumber  
				,ERROR_SEVERITY() AS ErrorSeverity  
				,ERROR_STATE() AS ErrorState  
				,ERROR_LINE () AS ErrorLine  
				,ERROR_PROCEDURE() AS ErrorProcedure  
				,ERROR_MESSAGE() AS ErrorMessage;  
			ROLLBACK TRANSACTION;  
		END CATCH

		-- Trường hợp chuyển dữ liệu thành công
		IF(@IsSuccessful = 1)
		BEGIN
		-- Trường hợp không còn dữ liệu từ bảng CMNT0020
			IF(NOT EXISTS (SELECT TOP 1 1 FROM CMNT0020))
			BEGIN
			DROP TABLE CMNT0020
			END
		END
	END
END

