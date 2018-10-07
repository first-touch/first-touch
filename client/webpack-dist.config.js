const path = require('path');
const conf = require('./conf/gulp.conf');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const NODE_MDL = path.resolve('node_modules');
const SRC_DIR = path.resolve('src');

module.exports = {
  mode: 'production',
  entry: {
    app: './src/index.js'
  },
  resolve: {
    alias: {
      stylesheets: path.resolve(__dirname, './src/stylesheets/'),
      images: path.resolve(__dirname, './src/images/')
    },
    extensions: ['.js', '.vue', '.css'],
    modules: [NODE_MDL, SRC_DIR]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'FirstTouch',
      favicon: 'src/images/favicon.png',
      template: 'src/index.html'
    }),
    new VueLoaderPlugin(),
    new CleanWebpackPlugin([path.join(process.cwd(), conf.paths.dist)]),
    new MiniCssExtractPlugin({
      // Options similar to the same options in webpackOptions.output
      // both options are optional
      filename: "[name].[hash].css",
      chunkFilename: "[id].[hash].css"
    })
  ],
  output: {
    filename: 'main.js',
    path: path.join(process.cwd(), conf.paths.tmp),
    publicPath: '/'
  },
  module: {
    rules: [{
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              modules: true,
              sourceMap: true,
              importLoader: 2
            }
          },
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
