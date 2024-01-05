/*
 - Phân quyền các module đã có trong hệ thống.
 - 26/01/2021 - [Tấn Thành] - Tạo mới
*/

BEGIN TRY
BEGIN TRANSACTION;
BEGIN
	
	DECLARE @AT1409_DivisionID VARCHAR(50),
			@AT1409_ModuleID VARCHAR(50),
			@Cur CURSOR

	SET @Cur = CURSOR SCROLL KEYSET FOR

	SELECT DivisionID, ModuleID
	FROM AT1409 WITH(NOLOCK)

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @AT1409_DivisionID, @AT1409_ModuleID
	WHILE @@FETCH_STATUS = 0
	BEGIN

	IF(NOT EXISTS(SELECT TOP 1 1 FROM AT1403 WITH (NOLOCK) WHERE ModuleID = @AT1409_ModuleID AND DivisionID = @AT1409_DivisionID AND ScreenID = @AT1409_ModuleID))
	BEGIN
		IF ( EXISTS ( SELECT    *
                  FROM      AT1401 ) ) 
        BEGIN
            INSERT  AT1403
                    ( DivisionID ,
                      ScreenID ,
                      GroupID ,
                      ModuleID ,
                      IsAddNew ,
                      IsUpdate ,
                      IsDelete ,
                      IsView ,
                      IsPrint ,
					  IsHidden,
                      CreateDate ,
                      CreateUserID ,
                      LastModifyUserID ,
                      LastModifyDate ,
                      SourceID
                    )
                    SELECT distinct AT1401.DivisionID ,
                            @AT1409_ModuleID ,
                            GroupID ,
                            @AT1409_ModuleID ,
                            0 ,
                            0 ,
                            0 ,
							CASE 
								WHEN GroupID = 'ADMIN' THEN 1
								ELSE 0
							END ,
                            0 ,
							0,
                            GETDATE() ,
                            'ASOFTADMIN',
                            'ASOFTADMIN',
                            GETDATE(),
                            'Hidden'
                    FROM    AT1401
                    WHERE   AT1401.DivisionID + '_' + @AT1409_ModuleID + '_' + GroupID + '_' + @AT1409_ModuleID NOT IN (
                            SELECT  DivisionID + '_' + ScreenID + '_' + GroupID + '_' + ModuleID
                            FROM    AT1403 )
        END
	END
	ELSE
	BEGIN
		UPDATE AT1403
		SET SourceID = 'Hidden'
		WHERE ModuleID = @AT1409_ModuleID AND ModuleID = ScreenID AND DivisionID = @AT1409_DivisionID
	END

	FETCH NEXT FROM @Cur INTO @AT1409_DivisionID, @AT1409_ModuleID
	END
	CLOSE @Cur
END

COMMIT TRANSACTION;
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
