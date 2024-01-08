---- Create by Tieumai on 10/2/2017 3:24:49 PM
---- Định nghĩa tham số

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT0002]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[LMT0002]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TypeID] NVARCHAR(50) NOT NULL,
  [SystemName] NVARCHAR(250) NULL,
  [SystemNameE] NVARCHAR(250) NULL,
  [UserName] NVARCHAR(250) NULL,
  [UserNameE] NVARCHAR(250) NULL,
  [IsUsed] TINYINT DEFAULT (0) NULL
CONSTRAINT [PK_LMT0002] PRIMARY KEY CLUSTERED
(	
	[DivisionID],
	[TypeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


---- Created by Tiểu Mai on 03/10/2017
---- Purpose: Add 20 tham số cho phân hệ LM (Quản lý vay ERP 9.0)

DECLARE @Cur CURSOR,
		@DivisionID VARCHAR(50),
		@sSQL NVARCHAR(1000)
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DivisionID FROM AT0001 WITH (NOLOCK)

OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID
WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @i INT = 1
	WHILE @i <= 20
	BEGIN
		IF @i < 10
			SET @sSQL = '
				INSERT INTO LMT0002 (APK,DivisionID, TypeID, SystemName, SystemNameE, UserName, UserNameE, IsUsed)
				VALUES (NEWID(), '''+@DivisionID+''', ''L0'+CONVERT(VARCHAR(2),@i)+''', N'''+N'Tham số 0'+CONVERT(VARCHAR(2),@i)+''', N'''+N'Parameter 0'+CONVERT(VARCHAR(2),@i)+''', 
						N'''+N'Tham số 0'+CONVERT(VARCHAR(2),@i)+''', N'''+N'Parameter 0'+CONVERT(VARCHAR(2),@i)+''', 0)'
		ELSE
			SET @sSQL = '
				INSERT INTO LMT0002 (APK,DivisionID, TypeID, SystemName, SystemNameE, UserName, UserNameE, IsUsed)
				VALUES (NEWID(), '''+@DivisionID+''', ''L'+CONVERT(VARCHAR(2),@i)+''', N'''+N'Tham số '+CONVERT(VARCHAR(2),@i)+''', N'''+N'Parameter'+CONVERT(VARCHAR(2),@i)+''', 
						N'''+N'Tham số '+CONVERT(VARCHAR(2),@i)+''', N'''+N'Parameter'+CONVERT(VARCHAR(2),@i)+''', 0)'
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM LMT0002 WHERE DivisionID = @DivisionID AND (TypeID = 'L'+ CONVERT(VARCHAR(2),@i) OR TypeID = 'L0'+ CONVERT(VARCHAR(2),@i)))		
			EXEC (@sSQL)

		SET @i = @i + 1
	END
	FETCH NEXT FROM @Cur INTO @DivisionID
END

