const db = require("../db");

module.exports.log = async function (req, res){
    res.sendFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/log.html');
}
module.exports.main = async function(req, res){
    res.sendFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/main.html');
}
module.exports.newpost = async function (req, res){
    res.sendFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/newpost.html');
}
module.exports.profile = async function(req, res){
    res.sendFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/profile.html');
}
module.exports.registry = async function (req, res){
    res.sendFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/registry.html');
}