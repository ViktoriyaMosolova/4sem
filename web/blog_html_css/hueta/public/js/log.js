
const loginInput = document.querySelector('#login')
const passwordInput = document.querySelector('#password')
const form = document.querySelector('#login-form')

form.addEventListener('submit', (event) =>{
  event.preventDefault()
  const data = {
    login: loginInput.value,
    password: passwordInput.value
  }
  //console.log(data)
  axios.post('/api/user/login', data)
    .then(response => {
      // Обработка ответа от сервера
      localStorage.setItem('access_token', response.data.token)
      console.log(response.data.token)
      window.location.href = '/main';
    })
    .catch(error => {
      // Обработка ошибки
      // console.log(error)
      window.alert('Неправильный логин или пароль. Пожалуйста, попробуйте еще раз.');
    });

})
