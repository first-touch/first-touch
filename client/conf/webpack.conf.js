const webpack = require('webpack');
const conf = require('./gulp.conf');
const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const autoprefixer = require('autoprefixer');
const ProgressBarPlugin = require('progress-bar-webpack-plugin');

const NODE_MDL = path.resolve('node_modules');
const SRC_DIR = path.resolve('src');

module.exports = {
  resolve: {
    alias: {
      stylesheets: path.resolve(__dirname, '../src/stylesheets/'),
      images: path.resolve(__dirname, '../src/images/')
    },
    extensions: ['.js', '.vue', '.css'],
    modules: [NODE_MDL, SRC_DIR]
  },
  module: {
    loaders: [
      /*{
        test: /.js$/,
        exclude: /node_modules/,
        loader: 'eslint-loader',
        enforce: 'pre'
      },*/
      {
        test: /\.(css|scss)$/,
        loaders: ['style-loader', 'css-loader', 'sass-loader', 'postcss-loader']
      },
      {
        test: /\.js$/,
        include: SRC_DIR,
        exclude: /node_modules/,
        loaders: ['babel-loader']
      },
      {
        test: /\.(png|jpg)$/,
        loader: 'url-loader'
      },
      {
        test: /.vue$/,
        loaders: ['vue-loader']
      }
    ]
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new HtmlWebpackPlugin({
      template: conf.path.src('index.html')
    }),
    new webpack.LoaderOptionsPlugin({
      options: {
        postcss: () => [autoprefixer]
      },
      debug: true
    }),
    new ProgressBarPlugin(),
    
  ],
  output: {
    path: path.join(process.cwd(), conf.paths.tmp),
    filename: 'index.js',
    publicPath: '/'
  },
  entry: `./${conf.path.src('index')}`
};
