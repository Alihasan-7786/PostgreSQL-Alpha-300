// NODE.JS / PG REPOSITORY EXAMPLE (Sections 33–34)
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'socialnetwork',
  user: 'postgres',
  password: 'your_password',
});

// Creating a class to handle queries related to users
class UserRepo {
  // Getting all users from the database
  static async find() {
    const { rows } = await pool.query(`
      SELECT id, created_at, updated_at, username, bio
      FROM users
      ORDER BY id;
    `);

    return rows.map((row) => ({
      id: row.id,
      createdAt: row.created_at,
      updatedAt: row.updated_at,
      username: row.username,
      bio: row.bio,
    }));
  }

  // Finding a user using their ID
  static async findById(id) {
    const { rows } = await pool.query(
      `
        SELECT id, created_at, updated_at, username, bio
        FROM users
        WHERE id = $1;
      `,
      [id]
    );

    const row = rows[0];
    if (!row) return null;

    return {
      id: row.id,
      createdAt: row.created_at,
      updatedAt: row.updated_at,
      username: row.username,
      bio: row.bio,
    };
  }
}

module.exports = UserRepo;