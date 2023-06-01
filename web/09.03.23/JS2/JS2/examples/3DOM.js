// Получение элемента по идентификатору
// let button = document.getElementById('btnId')
// console.log(button)

// Получение элементов по имени класса
// button = document.getElementsByClassName('btn')
// console.log(button)

// Получение элементов по имени тега
// button = document.getElementsByTagName('button')
// console.log(Array.from(button))

// Получение элемента с помощью селектора
// button = document.querySelector('.btn')
// button = document.querySelectorAll('.btn')
// console.dir(button)

// Изменение элемента

// Изменение цвета текста кнопки
// button.style.color = 'green'

// Изменение текста кнопки
// button.innerText = '123'

// Изменение HTML-содержимого кнопки
// button.innerHTML = '<div>213</div>'
// console.log(button.innerHTML)

// Имитация нажатия кнопки
// button.click()

// Изменение класса кнопки
// button.className = '123'

// Получение размеров элемента

// Получение высоты элемента
// console.log(button.offsetHeight)

// Получение ширины элемента
// console.log(button.offsetWidth)


// События

// Обработка событий мыши
// mouseover - событие возникает при наведении курсора на элемент
// mouseout - событие возникает при уходе курсора с элемента
// mousemove - событие возникает при движении курсора внутри элемента
// click - событие возникает при клике на элементе
// dblclick - событие возникает при двойном клике на элементе
// scroll - событие возникает при прокрутке страницы

// Обработка событий клавиатуры
// keydown - событие возникает при нажатии клавиши на клавиатуре
// keyup - событие возникает при отпускании клавиши на клавиатуре

// Обработка событий форм
// onChange - событие возникает при изменении значения элемента формы
// onInput - событие возникает при вводе символов в элемент формы
// focus - событие возникает при фокусировке на элементе формы

// Обработка событий отправки формы
// submit - событие возникает при отправке формы

// Обработка событий загрузки страницы
// DOMContentLoaded - событие возникает// при полной загрузке DOM-структуры страницы
// load - событие возникает при полной загрузке всех ресурсов страницы

// Обработка событий клика на кнопке
// const clickEvent = (event) => {
//     const button = event.target
//     console.log(event)
// }

// Добавление обработчика события клика на кнопку
// button.addEventListener('click', clickEvent)

// Удаление обработчика события клика на кнопку
// button.removeEventListener('click', clickEvent)

// Обработка событий отправки формы
// const form = document.querySelector('.form')

// Обработчик события отправки формы
// const submitEvent = (event) => {
//     // Отменяем стандартное действие браузера по отправке формы
//     event.preventDefault()

//     // Получаем значение поля ввода формы
//     const input = document.querySelector('input')
//     console.log(input.value)
// }

// Добавление обработчика события отправки формы
// form.addEventListener('submit', submitEvent)

const form = document.querySelector('.form')

form.addEventListener('click', (event) => {
    event.preventDefault()
    console.log('aboba')
})
