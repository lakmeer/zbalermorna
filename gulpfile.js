
var gulp    = require('gulp'),
    connect = require('gulp-connect'),
    shell   = require('gulp-shell');


// Tasks

gulp.task('compile', function () {
  gulp.src('src/*.sfd')
    .pipe( shell("./build.sh <%= file.relative.split('.')[0] %> --update-test")); //path.split('.sfd')[0] %>"));
});

gulp.task('preview', function () {
  connect.server({ root: 'test', livereload: true });
  gulp.watch([ 'src/*'       ], [ 'compile' ]);
  //gulp.watch([ 'output/*'    ], [ 'copy-output-to-test' ]);
  gulp.watch([ 'test/font/*' ], [ 'reload-fonts' ]);
  gulp.watch([ 'test/*'      ], [ 'reload-js' ]);
});

gulp.task('reload-fonts', function () {
  gulp.src('test/fonts/*').pipe(connect.reload());
});

gulp.task('reload-js', function () {
  gulp.src('test/*.js').pipe(connect.reload());
});

gulp.task('default', [ 'compile' ], function () {
  console.log('Rebuilding fonts');
});

