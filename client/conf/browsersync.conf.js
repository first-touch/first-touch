const conf = require('./gulp.conf');
const proxyMiddleware = require('http-proxy-middleware');

module.exports = function () {
  return {
    server: {
      baseDir: [conf.paths.tmp, conf.paths.src],
      middleware: [
        proxyMiddleware('/api', { target: 'http://localhost:3000' }),
        proxyMiddleware('/rails', { target: 'http://localhost:3000' })
      ]
    },
    open: false
  };
};
