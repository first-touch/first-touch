const webpack = require('webpack');
const conf = require('./gulp.conf');
const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const autoprefixer = require('autoprefixer');
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
      {
        test: /.json$/,
        loaders: ['json-loader']
      },
      // {
      //   test: /.js$/,
      //   exclude: /node_modules/,
      //   use: 'eslint-loader',
      //   enforce: 'pre'
      // },
      {
        test: /\.(css|scss)$/,
        loaders: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader?minimize!sass-loader!postcss-loader'
        })
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: ['babel-loader']
      },
      {
        test: /.vue$/,
        loaders: ['vue-loader']
      }
    ]
  },
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new HtmlWebpackPlugin({
      template: conf.path.src('index.html')
    }),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': '"production"'
    }),
    new ExtractTextPlugin('index-[contenthash].css'),
    new webpack.optimize.CommonsChunkPlugin({ name: 'vendor' }),
    new webpack.LoaderOptionsPlugin({
      options: {
        postcss: () => [autoprefixer]
      }
    })
  ],
  output: {
    path: path.join(process.cwd(), conf.paths.dist),
    filename: '[name]-[hash].js',
    publicPath: '/'
  },
  entry: {
    app: `./${conf.path.src('index')}`
  }
};
