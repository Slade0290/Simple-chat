const database = require('./database')

const get = async function(email) {
  console.log('in getCurrentUser')
  return await database.getUser(email)
}

module.exports = {
  get
}
