const loginInput = document.querySelector('#login');
const passwordInput = document.querySelector('#password');
const form = document.querySelector('#login-form');

form.addEventListener('submit', async (event) => {
  event.preventDefault();
  const data = {
    login: loginInput.value,
    password: passwordInput.value
  };
  axios.post('/api/user/login', data)
    .then(async response => {
      // Обработка ответа от сервера
      localStorage.setItem('access_token', response.data.token);
      // console.log("axios.post('/api/user/login', data)");
      const token = localStorage.getItem('access_token');
      const headers = {
        'Authorization': `${token}`
      };
      axios.defaults.headers.common['Authorization'] = `${token}`;
      await axios.get('/api/user/protected-route', { headers })
        .then(response => {
          // Обработка ответа от сервера
          // console.log(response.data);
          // Перенаправляем на страницу Main
          document.location.href = '/main';
        })
        .catch(error => {
          // Обработка ошибки
          // console.log(error);
          localStorage.removeItem('access_token')
          window.alert('Ошибка аутентификации. Пожалуйста, войдите в систему.');
          // Перенаправляем на страницу авторизации
          document.location.href = '/login';
        });
    })
    .catch(error => {
      // Обработка ошибки
      // console.log(error);
      window.alert('Неправильный логин или пароль. Пожалуйста, попробуйте еще раз.');
    });
});
