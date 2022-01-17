let path = require('path')
const SymlinkWebpackPlugin = require('symlink-webpack-plugin');

module.exports = {
    entry: './src/public/javascript/script.js',
    watch: true,
    mode: 'development',
    output: {
      path: path.resolve('./public/build'),
      filename: 'bundle.js'
    },
    plugins: [
      new SymlinkWebpackPlugin({ origin: 'src/server/index.js', symlink: 'public/build/index.js' })
    ]
}
