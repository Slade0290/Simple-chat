const fse = require('fs-extra')

function base64ToImageFile(base64data, filePath) {
  fse.outputFileSync(filePath, base64data.split(',')[1], 'base64')
  const data = fse.readFileSync(filePath, 'base64')
}

module.exports = {
  base64ToImageFile
}
