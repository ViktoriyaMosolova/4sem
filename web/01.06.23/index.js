// const express = require('express');
// const { resolve } = require('path');

// const app = express();

// app.get('/', function (request, response) {
//     response.send('<h2>Привет</h2>');
// });

// const PORT = 3000
// app.listen(PORT, ()=> console.log(`server started on port ${PORT}`));

const p = new Promise((resolve, reject) => {
    setTimeout(()=>{
        console.log('данные подготавливаются')
        const data = {
            name: 'aboba',
            age: 100
        }
        reject()
    }, 2000)
})

p.then(data =>{
    console.log(data)
}).catch(() => {
    console.log('error')
})