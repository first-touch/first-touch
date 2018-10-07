const path = require('path');
const conf = require('./conf/gulp.conf');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const NODE_MDL = path.resolve('node_modules');
const SRC_DIR = path.resolve('src');

module.exports = {
  mode: 'development',
  entry: {
    app: './src/index.js'
  },
  resolve: {
    // Used to avoid having to define relative paths all over
    alias: {
      stylesheets: path.resolve(__dirname, './src/stylesheets/'),
      images: path.resolve(__dirname, './src/images/')
    },
    // When importing modules from files, we don't need to specify the
    // file extension because webpack will try to resolve with these
    extensions: ['.js', '.vue', '.css'],
    // Specify modules folders, so we can import straight from src/... or node_modules/...
    modules: [NODE_MDL, SRC_DIR]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'FirstTouch',
      favicon: 'src/images/favicon.png',
      template: 'src/index.html'
    }),
    new VueLoaderPlugin(),
    new MiniCssExtractPlugin({
      // Options similar to the same options in webpackOptions.output
      // both options are optional
      filename: "[name].css",
      chunkFilename: "[id].css"
    })
  ],
  output: {
    filename: 'main.js',
    path: path.join(process.cwd(), conf.paths.tmp),
    publicPath: '/'
  },
  module: {
    rules: [
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test: /.vue$/,
        loaders: ['vue-loader']
      }
    ]
  }
};
