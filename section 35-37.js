// SECTION 35 & 36: SAFE QUERIES & PARALLEL SCHEMA ISOLATION (NODE.JS / PG)
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'socialnetwork_test',
  user: 'postgres',
  password: 'your_password',
});

// Safely handling table and schema names in SQL queries
function quoteIdent(identifier) {
  return `"${String(identifier).replace(/"/g, '""')}"`;
}

// Creating a separate schema for each test suite or worker
async function createTestSchema(client, schemaName) {
  const safeSchema = quoteIdent(schemaName);
  await client.query(`CREATE SCHEMA ${safeSchema};`);
  await client.query(`SET search_path TO ${safeSchema}, public;`);
}

// Removing the test schema and setting search_path back to public
async function dropTestSchema(client, schemaName) {
  const safeSchema = quoteIdent(schemaName);
  await client.query(`SET search_path TO public;`);
  await client.query(`DROP SCHEMA IF EXISTS ${safeSchema} CASCADE;`);
}

// Using parameters in queries to avoid SQL injection
async function createUser(username, bio) {
  const { rows } = await pool.query(
    `
      INSERT INTO users (username, bio)
      VALUES ($1, $2)
      RETURNING id, username, bio;
    `,
    [username, bio]
  );
  return rows[0];
}

module.exports = {
  pool,
  createTestSchema,
  dropTestSchema,
  createUser,
};