var gulp = require("gulp");
var concat = require("gulp-concat");
var uglify = require("gulp-uglify");
var plumber = require("gulp-plumber");
var webserver = require("gulp-webserver");
var sass = require("gulp-sass");


gulp.task("build", function(){
	 gulp.src("./src/*.html")
	   .pipe(gulp.dest("./dist"));

	 gulp.src("./src/*.tag")
	   .pipe(gulp.dest("./dist"));

	 gulp.src("./src/js/*.js")
	   .pipe(uglify())
	   .pipe(gulp.dest("./dist/js"));

	 gulp.src("./src/sass/*.scss")
	   .pipe(sass())
	   .pipe(gulp.dest("./dist/css"));
});


gulp.task("watch", function(){
	gulp.watch('./src/*.html', ["html"])
	gulp.watch('./src/sass/*.scss', ["sass"])
	gulp.watch('./src/*.tag', ["tag"])

	gulp.src("./dist")
	  .pipe(
	  	webserver({
	  		host: "192.168.33.10",
	  		livereload: true
	  	})
	  	);
});



gulp.task("default", ["build", "watch", "watch"]);