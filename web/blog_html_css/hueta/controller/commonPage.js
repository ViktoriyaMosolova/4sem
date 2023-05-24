const db = require("../db");
const fs = require('fs');


module.exports.log = async function (req, res) {
    fs.readFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/log.html', 'utf8', (err, data) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.send(data);
        }
    });
}

module.exports.main = function (req, res) {
    fs.readFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/main.html', 'utf8', (err, data) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.send(data);
        }
    });
};


module.exports.newpost = async function (req, res) {
    fs.readFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/newpost.html', 'utf8', (err, data) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.send(data);
        }
    });
}
module.exports.profile = async function (req, res) {
    fs.readFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/profile.html', 'utf8', (err, data) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.send(data);
        }
    });
}
module.exports.registry = async function (req, res) {
    fs.readFile('C:/Users/mosol/OneDrive/Рабочий стол/4sem/web/blog_html_css/hueta/public/html/registry.html', 'utf8', (err, data) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.send(data);
        }
    });
}
