const _ =  require('lodash')
const sqlite3 = require('sqlite3').verbose()
let db = new sqlite3.Database('main.db')

function createTable() {
  res = db.run("SELECT * FROM sqlite_schema")
  console.log('result', res);
  // if(_.isEmpty(res)) {
  //   console.log('in create table query');
  //   db.run("CREATE TABLE users(username, password, signup_date, avatar)")
  // }
}

function createUser(username, password, signup_date, avatar) {
  return new Promise((resolve, reject) => {
    console.log('in createUser');
    const query = `INSERT INTO users(username, password, signup_date, avatar) VALUES(?,?,?,?)`
    const res = db.run(query, username, password, signup_date, avatar, (err, row) => {
      if(err) {
        reject(err);
      } else {
        resolve(row ? row : undefined)
      }
    })
  })
}

async function getUser(username) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM users WHERE username = ?`
    const res = db.get(query, username, (err, row) => {
      if(err) {
        reject(err);
      } else {
        resolve(row ? row : undefined)
      }
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

function deleteUser(username) {
  const query = `DELETE FROM users WHERE username = ?`
  db.run(query, username, (err, row) => {
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
