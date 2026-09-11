/*
    Appointment Management System - Database Setup
    SQL Server

    This script creates the RandevuDB database and its tables if they do not exist.
    It can be executed more than once without recreating existing tables.
*/

USE [master];
GO

IF DB_ID(N'RandevuDB') IS NULL
BEGIN
    CREATE DATABASE [RandevuDB];
END
GO

USE [RandevuDB];
GO

/* Departments */
IF OBJECT_ID(N'dbo.Bolum', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Bolum](
        [bolumID] INT IDENTITY(1,1) NOT NULL,
        [bolumAdi] NVARCHAR(100) NOT NULL,
        CONSTRAINT [PK_Bolum] PRIMARY KEY ([bolumID])
    );
END
GO

/* Doctors */
IF OBJECT_ID(N'dbo.Doktor', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Doktor](
        [doktorID] INT IDENTITY(1,1) NOT NULL,
        [ad] NVARCHAR(50) NOT NULL,
        [soyad] NVARCHAR(50) NOT NULL,
        [uzmanlik] NVARCHAR(100) NULL,
        [telefon] NVARCHAR(15) NULL,
        [email] NVARCHAR(100) NULL,
        [sifre] NVARCHAR(50) NULL,
        [bolumID] INT NULL,
        CONSTRAINT [PK_Doktor] PRIMARY KEY ([doktorID])
    );
END
GO

/* Patients */
IF OBJECT_ID(N'dbo.Hasta', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Hasta](
        [hastaID] INT IDENTITY(1,1) NOT NULL,
        [ad] NVARCHAR(50) NOT NULL,
        [soyad] NVARCHAR(50) NOT NULL,
        [tcNo] CHAR(11) NOT NULL,
        [telefon] NVARCHAR(15) NULL,
        [email] NVARCHAR(100) NULL,
        [sifre] NVARCHAR(50) NOT NULL,
        CONSTRAINT [PK_Hasta] PRIMARY KEY ([hastaID])
    );
END
GO

/* Appointments */
IF OBJECT_ID(N'dbo.Randevu', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Randevu](
        [randevuID] INT IDENTITY(1,1) NOT NULL,
        [hastaID] INT NULL,
        [doktorID] INT NULL,
        [tarih] DATE NOT NULL,
        [saat] TIME(7) NOT NULL,
        [durum] NVARCHAR(30) NULL CONSTRAINT [DF_Randevu_Durum] DEFAULT (N'Aktif'),
        CONSTRAINT [PK_Randevu] PRIMARY KEY ([randevuID])
    );
END
GO

/* Unique constraints */
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = N'UQ_Doktor_Email'
      AND object_id = OBJECT_ID(N'dbo.Doktor')
)
BEGIN
    ALTER TABLE [dbo].[Doktor]
        ADD CONSTRAINT [UQ_Doktor_Email] UNIQUE ([email]);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = N'UQ_Hasta_Email'
      AND object_id = OBJECT_ID(N'dbo.Hasta')
)
BEGIN
    ALTER TABLE [dbo].[Hasta]
        ADD CONSTRAINT [UQ_Hasta_Email] UNIQUE ([email]);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = N'UQ_Hasta_TcNo'
      AND object_id = OBJECT_ID(N'dbo.Hasta')
)
BEGIN
    ALTER TABLE [dbo].[Hasta]
        ADD CONSTRAINT [UQ_Hasta_TcNo] UNIQUE ([tcNo]);
END
GO

/* Foreign keys */
IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys
    WHERE name = N'FK_Doktor_Bolum'
)
BEGIN
    ALTER TABLE [dbo].[Doktor]
        ADD CONSTRAINT [FK_Doktor_Bolum]
        FOREIGN KEY ([bolumID]) REFERENCES [dbo].[Bolum] ([bolumID]);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys
    WHERE name = N'FK_Randevu_Doktor'
)
BEGIN
    ALTER TABLE [dbo].[Randevu]
        ADD CONSTRAINT [FK_Randevu_Doktor]
        FOREIGN KEY ([doktorID]) REFERENCES [dbo].[Doktor] ([doktorID]);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys
    WHERE name = N'FK_Randevu_Hasta'
)
BEGIN
    ALTER TABLE [dbo].[Randevu]
        ADD CONSTRAINT [FK_Randevu_Hasta]
        FOREIGN KEY ([hastaID]) REFERENCES [dbo].[Hasta] ([hastaID]);
END
GO

/* Demo departments */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Bolum] WHERE [bolumID] = 1)
    INSERT INTO [dbo].[Bolum] ([bolumID], [bolumAdi]) VALUES (1, N'Kardiyoloji');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Bolum] WHERE [bolumID] = 2)
    INSERT INTO [dbo].[Bolum] ([bolumID], [bolumAdi]) VALUES (2, N'Dahiliye');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Bolum] WHERE [bolumID] = 3)
    INSERT INTO [dbo].[Bolum] ([bolumID], [bolumAdi]) VALUES (3, N'Ortopedi');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Bolum] WHERE [bolumID] = 4)
    INSERT INTO [dbo].[Bolum] ([bolumID], [bolumAdi]) VALUES (4, N'Göz Hastalıkları');
GO

/* Demo doctors - sample data only */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 1)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (1, N'Ahmet', N'Yılmaz', N'Kardiyoloji Uzmanı', N'05000000001', N'doctor1@example.com', N'123', 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 2)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (2, N'Ayşe', N'Demir', N'Dahiliye Uzmanı', N'05000000002', N'doctor2@example.com', N'123', 2);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 3)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (3, N'Can', N'Aydın', N'Kardiyoloji Uzmanı', N'05000000003', N'doctor3@example.com', N'123', 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 4)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (4, N'Elif', N'Kaya', N'Dahiliye Uzmanı', N'05000000004', N'doctor4@example.com', N'123', 2);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 5)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (5, N'Mehmet', N'Kara', N'Ortopedi Uzmanı', N'05000000005', N'doctor5@example.com', N'123', 3);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 6)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (6, N'Zeynep', N'Şahin', N'Ortopedi Uzmanı', N'05000000006', N'doctor6@example.com', N'123', 3);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 7)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (7, N'Ali', N'Çetin', N'Göz Hastalıkları Uzmanı', N'05000000007', N'doctor7@example.com', N'123', 4);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Doktor] WHERE [doktorID] = 8)
    INSERT INTO [dbo].[Doktor] ([doktorID], [ad], [soyad], [uzmanlik], [telefon], [email], [sifre], [bolumID])
    VALUES (8, N'Ayça', N'Demir', N'Göz Hastalıkları Uzmanı', N'05000000008', N'doctor8@example.com', N'123', 4);
GO

/* Demo patients - sample data only */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Hasta] WHERE [hastaID] = 1)
    INSERT INTO [dbo].[Hasta] ([hastaID], [ad], [soyad], [tcNo], [telefon], [email], [sifre])
    VALUES (1, N'Mehmet', N'Kaya', N'10000000001', N'05000000011', N'patient1@example.com', N'123');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Hasta] WHERE [hastaID] = 2)
    INSERT INTO [dbo].[Hasta] ([hastaID], [ad], [soyad], [tcNo], [telefon], [email], [sifre])
    VALUES (2, N'Zeynep', N'Çelik', N'10000000002', N'05000000012', N'patient2@example.com', N'123');
GO

/* Demo appointments */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Randevu] WHERE [randevuID] = 1)
    INSERT INTO [dbo].[Randevu] ([randevuID], [hastaID], [doktorID], [tarih], [saat], [durum])
    VALUES (1, 1, 1, '2026-05-20', '10:00:00', N'İptal');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Randevu] WHERE [randevuID] = 2)
    INSERT INTO [dbo].[Randevu] ([randevuID], [hastaID], [doktorID], [tarih], [saat], [durum])
    VALUES (2, 1, 4, '2026-05-25', '10:30:00', N'İptal');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Randevu] WHERE [randevuID] = 3)
    INSERT INTO [dbo].[Randevu] ([randevuID], [hastaID], [doktorID], [tarih], [saat], [durum])
    VALUES (3, 1, 6, '2026-05-28', '12:00:00', N'Aktif');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Randevu] WHERE [randevuID] = 4)
    INSERT INTO [dbo].[Randevu] ([randevuID], [hastaID], [doktorID], [tarih], [saat], [durum])
    VALUES (4, 1, 1, '2026-05-25', '10:30:00', N'Aktif');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Randevu] WHERE [randevuID] = 5)
    INSERT INTO [dbo].[Randevu] ([randevuID], [hastaID], [doktorID], [tarih], [saat], [durum])
    VALUES (5, 1, 1, '2026-05-20', '10:00:00', N'Aktif');
GO

PRINT N'RandevuDB database setup completed successfully.';
GO
