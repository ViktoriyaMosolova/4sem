const loginInput = document.querySelector('#loginuser')
const passwordInput = document.querySelector('#passworduser')
const nameInput = document.querySelector('#nameuser')
const form = document.querySelector('#login-form')

form.addEventListener('submit', (event) =>{
  event.preventDefault()
  const data = {
    name: nameInput.value,
    login: loginInput.value,
    password: passwordInput.value
  }
  console.log(data)
  axios.post('/api/user/registry', data)
    .then(response => {
      // Обработка ответа от сервера
    //   localStorage.setItem('access_token', response.data.token)
    //   console.log(response.data.token)
    //   axios.defaults.headers.common['Authorization'] = response.data.token;
      document.location.href = '/login'
    })
    .catch(error => {
      // Обработка ошибки
      // console.log(error)
      window.alert('что то пошло не так');
    });
})