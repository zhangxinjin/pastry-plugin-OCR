// 1 源目录 mockdata\ 目录 或者 单个文件
// 2 目标目录 mockdata\
var fs = require("fs-extra");
var path = require("path");

var Tools = {
	// sourcePath = component-js-register/mockdata
	// targetPath = www/mockdata
	// 备注：component-js-register/mockdata 存在 多个文件夹 和 多个js文件；
	// mockdata
	//   ├── login
	//   │   └── login.do.js
	//   │   └── login2.do.js
	//   ├── register
	//   │   └── register.do.js
	//   ├── test.do.js
	//   └── test2.do.js
	copy : function (sourcePath, targetPath) {

		var sourceFiles = fs.readdirSync(sourcePath);
		// 1 获取 sourcePath 里 所有的文件路径 数组 sourceFileNameArr
        var sourceFileNameArr = [];
        var sourceFilePathArr = [];
        // 3 获取 sourcePath 里 所有的目录 数组 sourceDirNameArr
        var sourceDirNameArr = [];
        var sourceDirPathArr = [];
        for (var index = sourceFiles.length - 1; index >= 0; index--) {
            var name = sourceFiles[index];
            var filePath = path.join(sourcePath, name);
            var info = fs.statSync(filePath);
            if (info.isDirectory()) {
                sourceDirNameArr.push(name);
                sourceDirPathArr.push(filePath);
            } else {
                sourceFileNameArr.push(name);
                sourceFilePathArr.push(filePath);
            }
        }

		var targetFiles = fs.readdirSync(targetPath);
		// 2 获取 targetPath 里 所有的文件路径 数组 targetFileNameArr
        var targetFileNameArr = [];
        var targetFilePathArr = [];
        // 4 获取 targetPath 里 所有的目录 数组 targetDirNameArr
        var targetDirNameArr = [];
        var targetDirPathArr = [];
        for (var index = targetFiles.length - 1; index >= 0; index--) {
            var name = targetFiles[index];
            var filePath = path.join(targetPath, name);
            var info = fs.statSync(filePath);
            if (info.isDirectory()) {
                targetDirNameArr.push(name);
                targetDirPathArr.push(filePath);
            } else {
                targetFileNameArr.push(name);
                targetFilePathArr.push(filePath);
            }
        }
		
		// 循环源文件数组
		for (var sourceIndex = sourceFileNameArr.length - 1; sourceIndex >= 0; sourceIndex--) {

			var find = false;
			for (var targetIndex = targetFileNameArr.length - 1; targetIndex >= 0; targetIndex--) {
				// 比较 sourceFileArr[sourceIndex] 的 文件名是否存在 targetFileNameArr[targetIndex]
				if (sourceFileNameArr[sourceIndex] === targetFileNameArr[targetIndex]) {
					find = true;
				}
			}

			if (find === true) {
				// targetFileNameArr里存在 SourceFileArr[sourceIndex]
				//1 直接覆盖 或者 2 提示用户选择是否覆盖targetFileNameArr里的文件 (直接使用 1 直接覆盖)
				fs.removeSync(path.join(targetPath, sourceFileNameArr[sourceIndex]));
			} else {
				// 直接移动 sourceFileArr[sourceIndex] 到 对应的 targetPath 目录
			}

			fs.copySync(sourceFilePathArr[sourceIndex], path.join(targetPath, sourceFileNameArr[sourceIndex]));
		}

		// 循环源目录数组
		for (var sourceIndex = sourceDirNameArr.length - 1; sourceIndex >= 0; sourceIndex--) {

			var find = false;
			for (var targetIndex = targetDirNameArr.length - 1; targetIndex >= 0; targetIndex--) {
				// 比较 sourceDirNameArr[sourceIndex] 的 目录是否存在 targetDirNameArr[targetIndex]
				if (sourceDirNameArr[sourceIndex] === targetDirNameArr[targetIndex]) {
					find = true;
				}
			}

			if (find === true) {
				// targetDirNameArr里存在 sourceDirNameArr[sourceIndex]
				//1 直接覆盖 或者 2 提示用户选择是否覆盖targetDirNameArr里的文件 (直接使用 1 直接覆盖)
				fs.removeSync(path.join(targetPath, sourceDirNameArr[sourceIndex]));
			} else {
				// 直接移动 sourceDirNameArr[sourceIndex] 到 对应的 targetPath 目录
			}
			fs.copySync(sourceDirPathArr[sourceIndex], path.join(targetPath, sourceDirNameArr[sourceIndex]));
		}
	},

	// sourcePath = component-js-register/mockdata
	// targetPath = www/mockdata
	// 备注：component-js-register/mockdata 存在 多个文件夹 和 多个js文件；
	// mockdata
	//   ├── login
	//   │   └── login.do.js
	//   │   └── login2.do.js
	//   ├── register
	//   │   └── register.do.js
	//   ├── test.do.js
	//   └── test2.do.js
	delete : function (sourcePath, targetPath) {
		var sourceFiles = fs.readdirSync(sourcePath);
		// 1 获取 sourcePath 里 所有的文件路径 数组 sourceFileNameArr
        var sourceFileNameArr = [];
        var sourceFilePathArr = [];
        // 3 获取 sourcePath 里 所有的目录 数组 sourceDirNameArr
        var sourceDirNameArr = [];
        var sourceDirPathArr = [];
        for (var index = sourceFiles.length - 1; index >= 0; index--) {
            var name = sourceFiles[index];
            var filePath = path.join(sourcePath, name);
            var info = fs.statSync(filePath);
            if (info.isDirectory()) {
                sourceDirNameArr.push(name);
                sourceDirPathArr.push(filePath);
            } else {
                sourceFileNameArr.push(name);
                sourceFilePathArr.push(filePath);
            }
        }

		var targetFiles = fs.readdirSync(targetPath);
		// 2 获取 targetPath 里 所有的文件路径 数组 targetFileNameArr
        var targetFileNameArr = [];
        var targetFilePathArr = [];
        // 4 获取 targetPath 里 所有的目录 数组 targetDirNameArr
        var targetDirNameArr = [];
        var targetDirPathArr = [];
        for (var index = targetFiles.length - 1; index >= 0; index--) {
            var name = targetFiles[index];
            var filePath = path.join(targetPath, name);
            var info = fs.statSync(filePath);
            if (info.isDirectory()) {
                targetDirNameArr.push(name);
                targetDirPathArr.push(filePath);
            } else {
                targetFileNameArr.push(name);
                targetFilePathArr.push(filePath);
            }
        }
		
		// 循环目标文件数组
		for (var targetIndex = targetFileNameArr.length - 1; targetIndex >= 0; targetIndex--) {

			var find = false;
			for (var sourceIndex = sourceFileNameArr.length - 1; sourceIndex >= 0; sourceIndex--) {
				// 比较 sourceFileArr[sourceIndex] 的 文件名是否存在 targetFileNameArr[targetIndex]
				if (sourceFileNameArr[sourceIndex] === targetFileNameArr[targetIndex]) {
					find = true;
				}
			}

			if (find === true) {
				// targetFileNameArr里存在 SourceFileArr[sourceIndex]
				//1 直接覆盖 或者 2 提示用户选择是否覆盖targetFileNameArr里的文件 (直接使用 1 直接覆盖)
				fs.removeSync(targetFilePathArr[targetIndex]);
			} else {
				// 直接移动 sourceFileArr[sourceIndex] 到 对应的 targetPath 目录
			}
		}

		// 循环目标目录数组
		for (var targetIndex = targetDirNameArr.length - 1; targetIndex >= 0; targetIndex--) {

			var find = false;
			for (var sourceIndex = sourceDirNameArr.length - 1; sourceIndex >= 0; sourceIndex--) {
				// 比较 sourceDirNameArr[sourceIndex] 的 目录是否存在 targetDirNameArr[targetIndex]
				if (sourceDirNameArr[sourceIndex] === targetDirNameArr[targetIndex]) {
					find = true;
				}
			}

			if (find === true) {
				// targetDirNameArr里存在 sourceDirNameArr[sourceIndex]
				//1 直接覆盖 或者 2 提示用户选择是否覆盖targetDirNameArr里的文件 (直接使用 1 直接覆盖)
				fs.removeSync(targetDirPathArr[targetIndex]);
			} else {
				// 直接移动 sourceDirNameArr[sourceIndex] 到 对应的 targetPath 目录
			}
		}
	}
}
module.exports = Tools;