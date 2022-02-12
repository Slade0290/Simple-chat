const sqlite3 = require('sqlite3').verbose()
let db = new sqlite3.Database('main.db')

function createTable() {
  db.run("CREATE TABLE users(email, password, username, signup_date, avatar)")
}

function createUser(email, password, username, signup_date, avatar) {
  let stmt = db.prepare("INSERT INTO users(email, password, username, signup_date, avatar) VALUES(?,?,?,?,?)")

  stmt.run(email, password, username, signup_date, avatar)
  stmt.finalize()
}

function getUser(email) {
  let stmt = db.prepare("SELECT * FROM users WHERE email = ?")

  let res = stmt.run(email)
  console.log(res);
  stmt.finalize()
  return res
}

// User model :
// Email
// Password
// Username
// Member since (date)
// Avatar

// db has to be closed between each operation ?
function closeDb() {
  db.close(err => {
    if(err) return console.error(err.message)
    console.log('Database closed');
  })
}

module.exports = {
  createUser,
  getUser,
  closeDb
}
