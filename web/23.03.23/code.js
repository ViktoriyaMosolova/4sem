const form = document.querySelector('.form')

var res = []

const submitEvent = (event) => {
    event.preventDefault()
    const input = document.querySelectorAll('input')
    const obj = {
        name: input[0].value,
        age: input[1].value,
        tel: input[2].value,
    }
    var re = /^[\d\+][\d\(\)\ -]{4,14}\d$/;
    if (!re.test(input[2].value)) {
        alert("Номер телефона введен неправильно!");
        return false;
    }
    if (input[1].value == "") {
        alert("Введите возраст");
        return false;
    }
    var letters = /^[a-zA-Z-А-Яа-я()]+$/;
    if(!input[0].value.match(letters))
    {
        alert('Username must have alphabetcharactersonly');
        return false;
    }
    res.push(obj)
    input.value=""
    console.log(obj)
}
form.addEventListener('submit', submitEvent)

const submitEventlog = (event) => {
    event.preventDefault()
    const result = document.createElement('div')
    result.style.color = 'black'
    result.innerText = "es.toString"
    document.body.append(result)
}
document.addEventListener('button', submitEventlog)


//Сделать записную книжку
//Взять форму в которой есть несколько полей фио возраст и телефон и кнопка отправить

//при отправке формы должно срабатывать событие в котором 
//будут получены все данные с формы
//они должны быть проверены (в фио нет цифр, возраст не "rhne" и так далее)
//после проверки нужно вывести все полученные данные под формой, а также показать их в консоли(в виде объекта)
//должна быть кнопка при которой в консоли должна появиться вся записаная книжка