/*
============================================================
RaceDay System - Part 1
SQL Server / SSMS Database Script
============================================================
This schema matches RaceDay_ERD.dbml exactly.
*/

IF DB_ID(N'RaceDay') IS NOT NULL
BEGIN
    ALTER DATABASE RaceDay SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDay;
END;
GO

CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) CONSTRAINT PK_Users PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL CONSTRAINT UQ_Users_Email UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant')),
    Phone NVARCHAR(30) NULL,
    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Users_CreatedAt DEFAULT SYSDATETIME()
);
GO

CREATE TABLE Venues (
    VenueId INT IDENTITY(1,1) CONSTRAINT PK_Venues PRIMARY KEY,
    VenueName NVARCHAR(120) NOT NULL,
    Address NVARCHAR(250) NOT NULL,
    City NVARCHAR(80) NOT NULL,
    Capacity INT NOT NULL
        CONSTRAINT CK_Venues_Capacity CHECK (Capacity > 0)
);
GO

CREATE TABLE Events (
    EventId INT IDENTITY(1,1) CONSTRAINT PK_Events PRIMARY KEY,
    OrganiserId INT NOT NULL,
    VenueId INT NOT NULL,
    EventName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    EventDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    Status NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Events_Status
        CHECK (Status IN ('Planned', 'Open', 'Completed', 'Cancelled')),
    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Events_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserId) REFERENCES Users(UserId),

    CONSTRAINT FK_Events_Venue
        FOREIGN KEY (VenueId) REFERENCES Venues(VenueId)
);
GO

CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) CONSTRAINT PK_Categories PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL
        CONSTRAINT CK_Categories_Distance CHECK (DistanceKm > 0),
    MaxParticipants INT NOT NULL
        CONSTRAINT CK_Categories_MaxParticipants CHECK (MaxParticipants > 0),
    EntryFee DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Categories_EntryFee CHECK (EntryFee >= 0),

    CONSTRAINT UQ_Categories_Event_Name
        UNIQUE (EventId, CategoryName),

    CONSTRAINT FK_Categories_Event
        FOREIGN KEY (EventId) REFERENCES Events(EventId)
);
GO

CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) CONSTRAINT PK_Enrolments PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL
        CONSTRAINT DF_Enrolments_Date DEFAULT SYSDATETIME(),
    Status NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Enrolments_Status
        CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    BibNumber NVARCHAR(20) NULL,

    CONSTRAINT UQ_Enrolments_Participant_Category
        UNIQUE (ParticipantId, CategoryId),

    CONSTRAINT UQ_Enrolments_Bib
        UNIQUE (BibNumber),

    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),

    CONSTRAINT FK_Enrolments_Category
        FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) CONSTRAINT PK_Results PRIMARY KEY,
    EnrolmentId INT NOT NULL,
    FinishPosition INT NOT NULL
        CONSTRAINT CK_Results_Position CHECK (FinishPosition > 0),
    FinishTime TIME(0) NOT NULL,
    ResultStatus NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Results_Status
        CHECK (ResultStatus IN ('Finished', 'DNF', 'DNS', 'DSQ')),
    RecordedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Results_RecordedAt DEFAULT SYSDATETIME(),

    CONSTRAINT UQ_Results_Enrolment
        UNIQUE (EnrolmentId),

    CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId)
);
GO

/* ============================================================
   SAMPLE DATA
   Minimum required:
   - 2 Organisers
   - 2 Participants
   - 3 Events
   - Categories for every event
   - Sample enrolments
   ============================================================ */

INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role, Phone)
VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za',
     'DEMO_HASH_ORGANISER_001', 'Organiser', '0710000001'),
    ('Lerato', 'Dlamini', 'lerato@raceday.co.za',
     'DEMO_HASH_ORGANISER_002', 'Organiser', '0710000002'),
    ('Nhlanhla', 'Gamede', 'nhlanhla@example.com',
     'DEMO_HASH_PARTICIPANT_001', 'Participant', '0720000001'),
    ('Kagiso', 'Molefe', 'kagiso@example.com',
     'DEMO_HASH_PARTICIPANT_002', 'Participant', '0720000002');
GO

INSERT INTO Venues
    (VenueName, Address, City, Capacity)
VALUES
    ('FNB Stadium', 'Soccer City Avenue', 'Johannesburg', 50000),
    ('Pretoria National Botanical Garden', '2 Cussonia Avenue', 'Pretoria', 10000),
    ('Durban Golden Mile', 'Marine Parade', 'Durban', 15000);
GO

INSERT INTO Events
    (OrganiserId, VenueId, EventName, Description, EventDate, StartTime, Status)
VALUES
    (1, 1, 'Johannesburg City Race 2026',
     'Road race event for multiple distance categories.',
     '2026-10-10', '07:00', 'Open'),

    (1, 2, 'Pretoria Spring Run 2026',
     'Community running event with 5 km and 10 km categories.',
     '2026-10-24', '07:30', 'Open'),

    (2, 3, 'Durban Beach Challenge 2026',
     'Coastal race with competitive and fun-run categories.',
     '2026-11-07', '06:30', 'Planned');
GO

INSERT INTO Categories
    (EventId, CategoryName, DistanceKm, MaxParticipants, EntryFee)
VALUES
    (1, '10 km Open', 10.00, 1000, 180.00),
    (1, '21 km Half Marathon', 21.10, 1500, 250.00),
    (2, '5 km Fun Run', 5.00, 800, 100.00),
    (2, '10 km Open', 10.00, 900, 180.00),
    (3, '5 km Beach Run', 5.00, 700, 120.00),
    (3, '10 km Beach Challenge', 10.00, 1000, 200.00);
GO

INSERT INTO Enrolments
    (ParticipantId, CategoryId, Status, BibNumber)
VALUES
    (3, 1, 'Confirmed', 'JHB001'),
    (4, 2, 'Confirmed', 'JHB002'),
    (3, 3, 'Confirmed', 'PTA001'),
    (4, 5, 'Pending', 'DBN001');
GO

INSERT INTO Results
    (EnrolmentId, FinishPosition, FinishTime, ResultStatus)
VALUES
    (1, 1, '00:48:35', 'Finished'),
    (2, 2, '01:47:20', 'Finished');
GO

/* Verification queries */
SELECT * FROM Users;
SELECT * FROM Venues;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO
