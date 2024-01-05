----- MODIFY BY LÊ THỊ HẠNH ON 11/07/2014
----- THÊM TRƯỜNG ISPROMOTION
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0034' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0034' AND col.name='IsPromotion')
		ALTER TABLE POST0034 ADD IsPromotion TINYINT DEFAULT (0) NULL
	END
---- Thay đổi trường Quantity thành ActualQuantity
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0034' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0034' AND col.name='ActualQuantity')
		ALTER TABLE POST0034 ADD ActualQuantity DECIMAL(28,8) DEFAULT (1) NOT NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='POST0034' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0034' AND col.name='Quantity')
		BEGIN
		EXEC DROPCONSTRAINT 'POST0034','Quantity' 
		ALTER TABLE POST0034 DROP COLUMN Quantity
		END
	END