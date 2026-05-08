# Ralph Prompt: Pixel-Recreate Figma Home Page With Flutter Web

你需要像素级还原这个 Figma 页面，目标是 Flutter Web demo，不使用 React、不使用 Tailwind、不使用纯 HTML/CSS 静态稿。

设计信息：
- 参考设计稿：`../assets/figma-home-design.png`
- 设计尺寸：390px x 844px

交付目录：
- 在当前仓库根目录新建独立目录：demo/
- Flutter Web 项目必须放在 demo/ 内，不要把实现文件写到仓库根目录。
- 不要覆盖或依赖根目录已有的 index.html、styles.css、assets/。

推荐交付结构：
- demo/pubspec.yaml
- demo/lib/main.dart
- demo/assets/figma/
- demo/web/

重要要求：
1. 使用 Flutter Web 实现页面。
2. 如果当前环境没有 Flutter SDK，先停止并报告，说明需要安装 Flutter；不要改用 HTML/CSS 兜底。
3. 如果 demo/ 不存在，使用 `flutter create demo --platforms web` 创建项目；如果 demo/ 已存在，先检查内容，避免覆盖用户已有代码。
4. 页面主体必须固定为 390px x 844px 的手机画布，在浏览器中居中展示。
5. 用 Flutter widget 精确还原视觉，优先使用 Stack + Positioned + SizedBox 固定坐标。
6. 不要继续在代码中引用 Figma 临时 asset URL。
7. 第一步先检查下面所有资源是否已经存在于 demo/assets/figma/。
8. 在 demo/pubspec.yaml 中正确声明 assets。
9. 如果任何资源缺失，停止并报告缺失资源，不要用占位图替代。
10. 目标是和 Figma 截图 1-2px 级别对齐。
11. 完成后运行 Flutter Web，并用浏览器截图检查视觉还原度。

资源清单，均应位于 demo/assets/figma/：
- avatar-emma.jpg
- post-photo-1.jpg
- post-photo-2.jpg
- like-active.svg
- comment.svg
- nav-home.svg
- nav-camera.svg
- nav-chat.svg
- nav-profile-body.svg
- nav-profile-head.svg
- fab-bg.svg
- status-notch.svg
- battery-outline.svg
- battery-end.svg
- battery-fill.svg
- wifi.svg
- mobile-signal.svg

Flutter 实现建议：
- `main.dart` 中关闭 debug banner。
- 根组件用 `MaterialApp(home: Scaffold(body: Center(child: PhoneCanvas())))`。
- `PhoneCanvas` 为 `SizedBox(width: 390, height: 844)`，内部使用 `ClipRect` + `Stack`。
- 背景使用 `DecoratedBox`，渐变为 top #fdf2f8，bottom #faf5ff。
- 所有图片使用 `Image.asset`。
- JPEG 图片裁切使用 `ClipRRect` + `Image.asset(fit: BoxFit.cover)`。
- SVG 资源可使用 `flutter_svg` 包；如果项目没有该依赖，在 demo/pubspec.yaml 中添加 `flutter_svg`，然后使用 `SvgPicture.asset`。
- 不要用网络图片，不要使用 Figma URL 作为运行时资源。
- 需要文本省略时使用 `Text(maxLines: 1, overflow: TextOverflow.ellipsis)`。

页面结构：
- 画布顶部有 iOS 状态栏。
- 主内容有两张白色动态卡片。
- 底部固定导航栏。
- 右下方有粉色悬浮加号按钮。

关键视觉参数：

画布：
- width: 390
- height: 844
- background: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xfffdf2f8), Color(0xfffaf5ff)])

状态栏：
- Positioned(left: 0, top: 0, width: 390, height: 47)
- 时间文字：9:41，left 27，top 15，width 54，height 20，fontSize 16，fontWeight 600，color black，textAlign center
- notch 使用 status-notch.svg，left 109，top 0，width 172，height 32
- mobile signal：left 286，top 20，width 18，height 12
- wifi：left 313，top 20，width 17，height 11.83
- battery group：left 337，top 19，width 27.4，height 13

第一张卡片：
- Positioned(left: 12, top: 61, width: 366)
- background: white
- borderRadius: 20
- padding: EdgeInsets.all(16)
- 纵向 gap: 10

第二张卡片：
- 与第一张同样样式
- Positioned(left: 12, top: 428, width: 366)
- 第二张卡片没有正文文字，图片区域直接在 header 下方

卡片 Header：
- header width: 334
- Row gap: 12
- avatar: 44 x 44，圆形裁切，BoxFit.cover
- name: Jane，fontSize 20，fontWeight 600，color #2d1b3d
- meta: Today - 10:30 AM - Corner window light，fontSize 12，color rgba(45,27,61,0.6)
- name/meta 垂直间距 2

第一张正文：
- 文案：Watched the sunset with him today, so beautiful and romantic 💕 Hope every day can be this sweet!
- fontSize 15
- color #2d1b3d
- width 334
- height 19
- 单行显示，超出省略号

图片横排：
- 容器 width 350
- Row gap 12
- ClipRect 横向裁切，第三张只露出右侧一部分
- 每张图尺寸：158 x 210
- borderRadius 10
- white border 1
- BoxFit.cover
- 第一张使用 post-photo-1.jpg
- 第二张使用 post-photo-2.jpg
- 第三张仍使用 post-photo-1.jpg

操作栏：
- width 334
- Row gap 22
- like icon 20 x 20，文字 1
- comment icon 20 x 20，文字 Comment
- 文字 fontSize 14，color #696969，fontWeight 500
- like 数字 opacity 0.8

底部导航：
- Positioned(left: 0, bottom: 0, width: 390, height: 80)
- background: white
- top border: 0.8px #e5e5e5
- 内容 padding: EdgeInsets.symmetric(horizontal: 38, vertical: 12)
- 四项：Home / camera / Chat / Profile
- 每项 width 58，height 54，padding horizontal 12 vertical 4
- 项间距约 27
- 图标 26 x 26
- label fontSize 11，fontWeight 600，uppercase
- Home 颜色 #ff3aa5
- 其他 label 颜色 #adadad
- Profile 图标由 nav-profile-body.svg 和 nav-profile-head.svg 组合，按 Figma 上下位置叠放

悬浮加号：
- Positioned(left: 318, top: 660, width: 56, height: 56)
- 背景使用 fab-bg.svg
- 中间白色加号可以用两个 Container 绘制：
  - 横线：20 x 4，borderRadius 999
  - 竖线：4 x 20，borderRadius 999
  - 两者居中
- z-order 高于第二张卡片和底部导航

字体：
- 优先使用 Inter。
- 若本机没有 Gilroy，用 Inter 或 system fallback，但字号、字重、颜色必须保持。
- 状态栏时间可用 system font / SF Pro fallback。

验收：
- 进入 demo/ 运行 `flutter pub get`。
- 运行 `flutter run -d chrome --web-port 4174` 或等价命令启动 Flutter Web。
- 浏览器中页面应展示为居中的 390 x 844 手机画布。
- 对照 Figma 截图检查：
  - 顶部状态栏位置准确
  - 第一张卡片 top 61，第二张卡片 top 428
  - 两张卡片宽度 366，左右边距 12
  - 图片尺寸和裁切接近 Figma
  - 第一张正文必须单行截断
  - 底部导航高度 80，Home 为粉色激活态
  - FAB 位置 left 318 / top 660
- 不允许出现默认滚动条、页面外溢、图片拉伸变形、资源 404 或 Flutter asset not found。

完成信号：
- 当且仅当 demo/ Flutter Web 项目已创建，资源都已本地化，`flutter pub get` 成功，并完成浏览器截图检查后，输出 COMPLETE。
