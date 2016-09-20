/*
plugin install 之后将安装组件里的 ”mockdata“ 文件夹移动到项目根目录/pastry-fo-nodejs/wwwroot/mockdata中 /www/mockdata中
 */
var tools = require("./tools.js");

module.exports = function(ctx) {

    var fs = ctx.requireCordovaModule('fs');
    var path = ctx.requireCordovaModule('path');

    var pluginName = ctx.opts.plugin.id;
    // console.log('plugin id = ' + pluginName);
    var rootPath = ctx.opts.projectRoot;
    // console.log('rootPath = ' + rootPath);
    var pluginSourceDir = ctx.opts.plugin.pluginInfo.dir;
    var mockdataSourcePath = path.join(pluginSourceDir, 'mockdata');
    // console.log('mockdataSourcePath = ' + mockdataSourcePath);

    if (fs.existsSync(mockdataSourcePath)) {
        // 执行模拟数据的拷贝
        var mockdataTargetPath = path.join(rootPath, 'pastry-fo-nodejs', 'wwwroot', 'mockdata');
        // console.log('mockdataTargetPath = ' + mockdataTargetPath);
        if (fs.existsSync(mockdataTargetPath)) {
            tools.copy(mockdataSourcePath, mockdataTargetPath);
        }
    } 

    return;
};