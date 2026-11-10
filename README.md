# BlogDB

A blog platform database made for our Database Systems course. The database covers the main stuff you'd expect in a blogging platform -- users, posts, categories, comments, likes, stories, tags, etc.

Built using **Microsoft SQL Server**.

## Team Members

- Judy
- Joneer Emad
- Mina Elia
- Mina Samy
- George
- Azmy Ayman

## Database Structure

The database has 8 tables:

- **Users** - stores user accounts info
- **Categories** - categories for blog posts
- **Posts** - blog posts
- **Comments** - comments on posts
- **Tags** - tags for posts
- **Post_Tags** - links tags to posts (many-to-many)
- **Likes** - user likes on posts
- **Stories** - short stories / updates

## How to Run

1. Open Microsoft SQL Server Management Studio (SSMS)
2. Open the file `BlogDB.sql`
3. Run the script -- it will create the database and all the tables

## Project Files

| File | Description |
|------|-------------|
| `BlogDB.sql` | Main SQL script (creates the database, filegroups, tables, and constraints) |
| `ERD_BlogDB.drawio` | ER Diagram in Chen's notation (open with draw.io) |
| `Mapping_BlogDB.drawio` | Relational Mapping Diagram (open with draw.io) |
| `BlogDB_Project_Guide_Final.pdf` | Comprehensive 102-page academic project guide, diagrams breakdown, and oral defense booklet |
