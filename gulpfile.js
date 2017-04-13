"use strict";

var browserSync = require('browser-sync').create();
var del = require('del');
var gulp = require('gulp');
var gulpCopy = require('gulp-copy');
var map = require('map-stream');
var markdownlint = require('markdownlint');
var path = require('path');
var runSequence = require('run-sequence');
var shell = require('gulp-shell');
var through2 = require('through2');

var paths = {
  modulesDir: 'modules',
  assetsDir: 'modules/assets',
  goforeThemeDir: 'modules/assets/css/theme',
  goforeThemeSrcFile: 'modules/assets/css/theme/source/gofore.scss',
  revealjsDir: 'modules/assets/revealjs',
  revealjsThemeDir: 'modules/assets/revealjs/css/theme',
  revealjsThemeSrcDir: 'modules/assets/revealjs/css/theme/source',
  revealjsGoforeThemeFile: 'modules/assets/revealjs/css/theme/gofore.css',
  revealjsGoforeThemeSrcFile: 'modules/assets/revealjs/css/theme/source/gofore.scss',
}

gulp.task('copy-theme-to-reveal', function() {
  return gulp.src(paths.goforeThemeSrcFile)
    .pipe(gulpCopy(paths.revealjsThemeSrcDir, {'prefix': 5}));
});

gulp.task('copy-theme-from-reveal', function() {
  return gulp.src(paths.revealjsGoforeThemeFile)
    .pipe(gulpCopy(paths.goforeThemeDir, {'prefix': 5}));
});

gulp.task('revealjs-css-themes', shell.task('grunt --gruntfile ' + paths.revealjsDir + '/Gruntfile.js css-themes'));

gulp.task('clean-temp-files', function() {
  return del([
    paths.revealjsGoforeThemeFile,
    paths.revealjsGoforeThemeSrcFile
  ]);
});

gulp.task('theme', function(callback) {
  runSequence('copy-theme-to-reveal', 'revealjs-css-themes', 'copy-theme-from-reveal', 'clean-temp-files', callback);
});

var lintErrors = false;
gulp.task('lint', function() {
  return gulp.src([
        '**/*.md',
        '!node_modules/**/*',
        '!' + paths.revealjsDir + '/**/*'
      ],
      {'read': false}
    )
    .pipe(map(function(file, cb) {
      var result = markdownlint.sync(
        {
          'files': [file.relative],
          'config': require('./markdownrules.json')
        }
      );
      var resultString = result.toString();
      if (resultString) {
        console.log(result.toString());
        lintErrors = true;
      }
      cb(null, file);
    }))
    .on('end', function() {
      if (lintErrors) {
        process.exit(1);
      }
    })
});

gulp.task('serve', function() {
  browserSync.init({
    open: false,
    server: {
      baseDir: "./modules"
    }
  });

  gulp.watch(paths.goforeThemeSrcFile, ['theme']);
  gulp.watch([
    paths.modulesDir + '/**/*.{css,html,md}',
    paths.assetsDir + '/js/**/*.js'
  ]).on('change', browserSync.reload);
});

gulp.task('default', ['serve']);
