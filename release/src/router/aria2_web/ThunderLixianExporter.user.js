var script = document.createElement('script');
script.id = "TLE_script";
if (location.host == "dynamic.cloud.vip.xunlei.com") {
script.src = "https://raw.github.com/binux/ThunderLixianExporter/master/ThunderLixianExporter.js";
} else {
script.src = "https://raw.github.com/binux/ThunderLixianExporter/master/vod_html5.js";
}
document.body.appendChild(script);

