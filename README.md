# 支持平台

|平台 | 是否支持 |
|-----|------|
|JS    |  支持    |
|FO-NodeJS    |  不支持    |
|iOS    | 支持    |
|android    | 支持(待开发)    |

# 组件依赖关系

|组件 | 版本号 | 地址|
|-----|------|----|
|身份证识别    | 1.0.0    | [GitHub地址](https://github.com/pastryTeam/pastry-plugin-OCR.git)|

# 功能介绍
>
* 可选功能
  * 身份证识别
  
# 安装方法
>
* pastry本地包安装 
   +  命令行$: pastry bake plugin add pastry-plugin-OCR
>
* github在线安装

    # 安装指定 tag 版本
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-OCR.git#1.0.0 
    
    # 安装最新代码
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-OCR.git
    
# 使用方法
>
+ 身份证识别
  + 方法  
    ```OCRManager.scanOCR(params, completeCallback)```
  + 代码示例
  
        OCRManager.scanOCR(["1001"], function (tx) {
        //返回身份证信息JSon串
                  console.log(tx);
                  });


        
# 作者
* pastryTeam团队

