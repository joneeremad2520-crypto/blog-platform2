CREATE DATABASE BlogDB

ON PRIMARY
(
    NAME = BlogDB_Primary,
    FILENAME = 'C:\SQLData\BlogDB.mdf',
    SIZE = 20MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 5MB
),

FILEGROUP FG_BlogData
(
    NAME = BlogDB_Secondary,
    FILENAME = 'C:\SQLData\BlogDB_Secondary.ndf',
    SIZE = 20MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 5MB
)

LOG ON
(
    NAME = BlogDB_Log1,
    FILENAME = 'C:\SQLData\BlogDB_Log1.ldf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),
(
    NAME = BlogDB_Log2,
    FILENAME = 'C:\SQLData\BlogDB_Log2.ldf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
);
GO

USE BlogDB;
GO

CREATE TABLE Users
(
    user_id INT IDENTITY(1,1) NOT NULL,

    username VARCHAR(50) NOT NULL,

    email VARCHAR(100) NOT NULL,

    password VARCHAR(255) NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_Users_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Users
        PRIMARY KEY (user_id),

    CONSTRAINT UQ_Users_Username
        UNIQUE (username),

    CONSTRAINT UQ_Users_Email
        UNIQUE (email)
)
ON FG_BlogData;
GO

CREATE TABLE Categories
(
    category_id INT IDENTITY(1,1) NOT NULL,

    category_name VARCHAR(100) NOT NULL,

    description VARCHAR(255),

    CONSTRAINT PK_Categories
        PRIMARY KEY (category_id),

    CONSTRAINT UQ_Categories_Name
        UNIQUE (category_name)
)
ON FG_BlogData;
GO

CREATE TABLE Tags
(
    tag_id INT IDENTITY(1,1) NOT NULL,

    tag_name VARCHAR(50) NOT NULL,

    CONSTRAINT PK_Tags
        PRIMARY KEY (tag_id),

    CONSTRAINT UQ_Tags_Name
        UNIQUE (tag_name)
)
ON FG_BlogData;
GO

CREATE TABLE Posts
(
    post_id INT IDENTITY(1,1) NOT NULL,

    user_id INT NOT NULL,

    category_id INT NOT NULL,

    title VARCHAR(200) NOT NULL,

    content TEXT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_Posts_CreatedAt DEFAULT GETDATE(),

    status VARCHAR(20) NOT NULL
        CONSTRAINT DF_Posts_Status DEFAULT 'Draft',

    CONSTRAINT PK_Posts
        PRIMARY KEY (post_id),

    CONSTRAINT FK_Posts_Users
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT FK_Posts_Categories
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id),

    CONSTRAINT CK_Posts_Status
        CHECK (status IN ('Draft', 'Published', 'Archived'))
)
ON FG_BlogData;
GO

CREATE TABLE Comments
(
    comment_id INT IDENTITY(1,1) NOT NULL,

    user_id INT NOT NULL,

    post_id INT NOT NULL,

    content TEXT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_Comments_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Comments
        PRIMARY KEY (comment_id),

    CONSTRAINT FK_Comments_Users
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT FK_Comments_Posts
        FOREIGN KEY (post_id)
        REFERENCES Posts(post_id)
)
ON FG_BlogData;
GO

CREATE TABLE Post_Tags
(
    post_id INT NOT NULL,

    tag_id INT NOT NULL,

    CONSTRAINT PK_Post_Tags
        PRIMARY KEY (post_id, tag_id),

    CONSTRAINT FK_PostTags_Posts
        FOREIGN KEY (post_id)
        REFERENCES Posts(post_id),

    CONSTRAINT FK_PostTags_Tags
        FOREIGN KEY (tag_id)
        REFERENCES Tags(tag_id)
)
ON FG_BlogData;
GO

CREATE TABLE Likes
(
    user_id INT NOT NULL,

    post_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_Likes_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Likes
        PRIMARY KEY (user_id, post_id),

    CONSTRAINT FK_Likes_Users
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT FK_Likes_Posts
        FOREIGN KEY (post_id)
        REFERENCES Posts(post_id)
)
ON FG_BlogData;
GO

CREATE TABLE Stories
(
    story_id INT IDENTITY(1,1) NOT NULL,

    user_id INT NOT NULL,

    content TEXT NOT NULL,

    image_url VARCHAR(255),

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_Stories_CreatedAt DEFAULT GETDATE(),

    expires_at DATETIME2 NOT NULL
        CONSTRAINT DF_Stories_ExpiresAt
        DEFAULT DATEADD(HOUR, 24, GETDATE()),

    CONSTRAINT PK_Stories
        PRIMARY KEY (story_id),

    CONSTRAINT FK_Stories_Users
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT CK_Stories_Expiry
        CHECK (expires_at > created_at)
)
ON FG_BlogData;
GO
