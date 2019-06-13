const gulp = require('gulp');
const gutil = require('gulp-util');

const webpack = require('webpack');
const webpackConf = require('../conf/webpack.conf');
const webpackDistConf = require('../conf/webpack-dist.conf');
const gulpConf = require('../conf/gulp.conf');
const browsersync = require('browser-sync');
const WebpackDevServer = require('webpack-dev-server');

gulp.task('webpack:dev', done => {
  webpackWrapper(false, webpackConf, done);
});

gulp.task('webpack:watch', done => {
  webpackWrapper(true, webpackConf, done);
});

gulp.task('webpack:dist', done => {
  process.env.NODE_ENV = 'production';
  webpackWrapper(false, webpackDistConf, done);
});

gulp.task('webpack-dev-server', function(callback){
  var devConf = webpackConf;
  devConf.devtool = 'eval';

  const options = {
    publicPath: '/',
    stats: {
      color: true
    },
    contentBase: gulpConf.paths.src,
    proxy: {
      '/api/**': { target: 'http://localhost:3000', secure: false },
      '/rails': { target: 'http://localhost:3000', secure: false }
    },
    host: '0.0.0.0',
    hot: true,
    hotOnly: false,
    inline: true,
    historyApiFallback: true
  }
  WebpackDevServer.addDevServerEntrypoints(devConf, options)

  const server = new WebpackDevServer(webpack(devConf), options)

  server.listen(8080, '0.0.0.0', (err) => {
    if(err) throw new gutil.PluginError('webpack-dev-server', err);
    gutil.log('[webpack-dev-server]', 'http://localhost:8080');
  })
})

function webpackWrapper (watch, conf, done) {
  const webpackBundler = webpack(conf);

  const webpackChangeHandler = (err, stats) => {
    if (err) {
      gulpConf.errorHandler('Webpack')(err);
    }
    gutil.log(
      stats.toString({
        colors: true,
        chunks: false,
        hash: false,
        version: false
      })
    );
    if (done) {
      done();
      done = null;
    } else {
      browsersync.reload();
    }
  };

  if (watch) {
    webpackBundler.watch(200, webpackChangeHandler);
  } else {
    webpackBundler.run(webpackChangeHandler);
  }
}
