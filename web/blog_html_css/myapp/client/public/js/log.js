
var form = document.getElementById("login-form");
form.addEventListener("submit", function(event) {
  // Отменяем стандартную отправку формы
  event.preventDefault();
  console.log('Sumbit');
    const loginInput = document.getElementById('login');
    const passwordInput = document.getElementById('password');

    const login = loginInput.value;
    const password = passwordInput.value;

    Users.create({
      login: login,
      password: password
    }).then(user => {
      console.log('User created successfully:', user.toJSON());
    }).catch(err => {
      console.error('Error creating user:', err);
    });
});