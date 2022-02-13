const sqlite3 = require('sqlite3').verbose()
let db = new sqlite3.Database('main.db')

function createTable() {
  db.run("CREATE TABLE users(email, password, username, signup_date, avatar)")
}

function createUser(email, password, username, signup_date, avatar) {
  let stmt = db.prepare("INSERT INTO users(email, password, username, signup_date, avatar) VALUES(?,?,?,?,?)")

  let res = stmt.run(email, password, username, signup_date, avatar)
  let finalRes = stmt.finalize()
}

function getUser(email) {
  return new Promise((resolve, reject) => {
    let query = `SELECT * FROM users WHERE email = ?`
    let res = db.get(query, email, (err, row) => {
      if(err) reject(err.message);
      resolve(row ? row : undefined)
    })
  })
}

function getAllUsers() {
  const query = "SELECT * FROM users"
  let res = db.all(query, [], (err, rows) => {
    if(err) return console.error(err.message)

    rows.forEach((row) => {
      console.log(row);
    });
  })
}

function deleteUser(email) {
  const query = `DELETE FROM users WHERE email = ?`
  db.run(query, email, (err, row) => {
    if (err) return console.error(err.message);
    console.log(`Row(s) deleted`);
  });
}

function closeDb() {
  db.close(err => {
    if(err) return console.error(err.message)
    console.log('Database closed');
  })
}

module.exports = {
  createTable,
  createUser,
  getUser,
  deleteUser,
  getAllUsers,
  closeDb
}
