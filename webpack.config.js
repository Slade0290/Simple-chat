let path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CopyPlugin = require("copy-webpack-plugin");

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
      }),
      new CopyPlugin({
        patterns: [
          { from: 'src/public/img', to: 'img'}
        ]
      })
    ],
    module: {
      rules: [
        {
          test: /\.hbs$/,
          use: [{
            loader: "handlebars-loader",
            options: {
              helperDirs: [path.resolve('src/public/scripts/templates/helpers')]
            }
          }]
        },
        {
          test: /\.coffee$/,
          loader: "coffee-loader",
        },
        {
          test: /\.s[ac]ss$/i,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
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
