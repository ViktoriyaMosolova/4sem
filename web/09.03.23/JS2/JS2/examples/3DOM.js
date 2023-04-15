// Получение элементов

// let button = document.getElementById('btnId')
// console.log(button)
// button = document.getElementsByClassName('btn')
// console.log(button)
// button = document.getElementsByTagName('button')
// console.log(Array.from(button))

// button = document.querySelector('.btn')
// button = document.querySelectorAll('.btn')
// console.dir(button)


// изменение элемента
// button.style.color = 'green'
// button.innerText = '123'
// button.innerHTML = '<div>213</div>'
// console.log(button.innerHTML)
// button.click()
// button.className = '123'


// получение размеров
// console.log(button.offsetHeight)
// console.log(button.offsetWidth)


// События

// mouseover, mouseout, mousemove, click, dblclick, scroll
// keydown, keyup, onChange, onInput, focus
// submit
// DOMContentLoaded, load

// const clickEvent = (event) => {
//     const button = event.target
//     console.log(event)
// }

// button.addEventListener('click', clickEvent)
// button.removeEventListener('click', clickEvent)

const form = document.querySelector('.form')


const submitEvent = (event) => {
    event.preventDefault()

    const input = document.querySelector('input')
    console.log(input.value)
}

form.addEventListener('submit', submitEvent)