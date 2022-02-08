let path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
    entry: './src/public/scripts/main.coffee',
    mode: 'development',
    output: {
      path: path.resolve('build/public'),
      filename: 'bundle.js'
    },
    plugins: [
      new MiniCssExtractPlugin(),
      new HtmlWebpackPlugin({
        filename: 'index.html',
        template: 'src/public/index.html'
      })
    ],
    module: {
      rules: [
        { test: /\.hbs$/, loader: "handlebars-loader" },
        {
          test: /\.coffee$/,
          loader: "coffee-loader",
        },
        {
          test: /\.s[ac]ss$/i,
          use: [
            // Creates `style` nodes from JS strings
            MiniCssExtractPlugin.loader,
            // Translates CSS into CommonJS
            "css-loader",
            // Compiles Sass to CSS
            "sass-loader",
          ],
        }
      ],
    },
    resolve: {
      modules: ['src/public/scripts', 'node_modules'],
      extensions: ['.js', '.hbs', '.coffee'],
      alias: {
          backbone: path.join(__dirname, 'node_modules', 'backbone')
      }
    }
}
