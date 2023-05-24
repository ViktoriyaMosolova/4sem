const token = localStorage.getItem('access_token');
const headers = {
	'Authorization': `${token}`
};
axios.defaults.headers.common['Authorization'] = `${token}`;

const container = document.querySelector('#profile-container');

document.addEventListener('DOMContentLoaded', async function () {
	try {
		const token = localStorage.getItem('access_token');
		axios.defaults.headers.common['Authorization'] = `${token}`;
		const headers = {
			'Authorization': `${token}`
		};
		await axios.get('/profile', { headers })
		await axios.get('/api/user/protected-route', { headers })
			.then(async () => {
				try {
					const response2 = await axios.get('/api/user', { headers });
					const response1 = await axios.get(`/api/post?id=${response2.data.id}`);
					const photo = response2.data.photo ? response2.data.photo : '../img/default.jpg'
					let html = '';
					html += `
			<div class="block-profile">
				<form class="profile styleshadow">
					<div class="profile-content">
						<div class="ava">
							<div class="button-change">
							
							<input type="file" id="profile-photo-in" name="photo" style="display: none;">
							
							<button id="change-photo-profile-btn">Изменить</button></div>
							<img id="profile-photo" class="ava-img" src="${photo}" alt="photo">

						</div>
						<div class="input-name">
							<div>
								<div class="username">
									<label>Логин</label>
								</div>
								<div class="size">
									<div class="button-change-input">
										<button id="changelogin">Изменить</button>
										<div> <input id="changelogininput" class="inputstyle" type="text" value="${response2.data.login}"></input></div>
									</div>
								</div>
							</div>
							<div>
								<div class="username">
									<label>Имя</label>
								</div>
								<div class="size">
									<div class="button-change-input">
										<button id="changename">Изменить</button>
										<div><input id="changenameinput" class="inputstyle" type="text" value="${response2.data.name}"></input></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<div class="blocks">
					<div class="count-post styleshadow">
						<label class="countposttitle">Количество постов:</label>
						<label class="countpostnumer">${response1.data.length}</label>
					</div>
					<form class="form-change-password styleshadow">
						<label class="label-form-change-password">Форма для смены пароля</label>
						<div class="block-form-change-password">
							<div class="form-password-input">
								<div><label>Новый пароль:</label></div>
								<div><input type="password" id="changepasswordinput" autocomplete="new-password"></div>
							</div>
							<div class="button-change-password"><button id="changepassword">Изменить</button></div>
						</div>
					</form>
					<div id="button-change">
						<button class="delete-user">Удалить аккаунт</button>
					</div>
				</div>
			</div>
            `;
					// console.log(response1.data);
					container.innerHTML = html;
				} catch (error) {
					console.error(error);
				}
			})
			.catch(error => {
				localStorage.removeItem('access_token')
				document.location.href = '/login';
			});
	} catch (error) {
		console.error(error);
	}


	const deleteBtn = document.querySelector('.delete-user');

	deleteBtn.addEventListener('click', async function(event) {
		event.preventDefault();
		const confirmDelete = confirm('Вы уверены, что хотите удалить аккаунт? Все ваши посты удалятся');
		
		if (confirmDelete) {
			try {
				const token = localStorage.getItem('access_token');
				axios.defaults.headers.common['Authorization'] = `${token}`;
				const headers = {
					'Authorization': `${token}`
				};
				const response2 = await axios.get('/api/user', { headers });
				const response = await axios.delete(`/api/user/${response2.data.id}`);
				localStorage.removeItem('access_token');
				document.location.href = '/registry';
			} catch (error) {
				console.error(error);
			}
		}
	});

	// Добавляем обработчик событий клика на родительский элемент формы
	const form = document.querySelector('.profile');
	form.addEventListener('click', async function (event) {
		if (event.target.matches('#changelogin')) {
			event.preventDefault()
			const changelogininput = document.querySelector('#changelogininput');
			try {
				const token = localStorage.getItem('access_token');
				axios.defaults.headers.common['Authorization'] = `${token}`;
				const headers = {
					'Authorization': `${token}`
				};
				const response = await axios.get('/api/user', { headers });
				const reslogin = await axios.patch('/api/user/changelogin', { login: changelogininput.value, id: response.data.id });
				// console.log(reslogin);
			} catch (error) {
				console.error(error);
				if (error.response && error.response.status === 400) {
					// Пользователь с таким логином уже существует
					alert('Пользователь с таким логином уже существует');
				} else {
					// Другая ошибка
					alert('Произошла ошибка');
				}
			}
		}

		if (event.target.matches('#changename')) {
			event.preventDefault()
			const changenameinput = document.querySelector('#changenameinput');
			try {
				const token = localStorage.getItem('access_token');
				axios.defaults.headers.common['Authorization'] = `${token}`;
				const headers = {
					'Authorization': `${token}`
				};
				const response = await axios.get('/api/user', { headers });
				const resname = await axios.patch('/api/user/changename', { name: changenameinput.value, id: response.data.id });
				// console.log(resname);
			} catch (error) {
				console.error(error);
			}
		}

		// Проверяем, что кликнули на кнопке "Изменить" для фото профиля
		if (event.target.matches('#change-photo-profile-btn')) {
			// Действия при клике на кнопку изменения фото профиля
			event.preventDefault();
			try {
				const token = localStorage.getItem('access_token');
				axios.defaults.headers.common['Authorization'] = `${token}`;
				const headers = {
					'Authorization': `${token}`
				};
				const changephotoinput = document.querySelector('#profile-photo-in');
				const profilephoto = document.querySelector('#profile-photo');

				changephotoinput.addEventListener('change', async function () {
					try {
						const token = localStorage.getItem('access_token');
						axios.defaults.headers.common['Authorization'] = `${token}`;
						const headers = {
							'Authorization': `${token}`
						};
						const file = changephotoinput.files[0];
						const formData = new FormData();
						const response = await axios.get('/api/user', { headers });
						formData.append('id', response.data.id);
						formData.append('image', file);
						const respo = await axios.patch('/api/user/changephoto', formData, { headers });
						console.log(respo.data);

						// Обновляем фото профиля на странице
						const imageUrl = URL.createObjectURL(file);
						profilephoto.setAttribute('src', imageUrl);
					} catch (error) {
						console.error(error);
					}
				});
			}
			catch (error) {
				console.error(error);
			}
		}
	});
	const formpass = document.querySelector('.form-change-password');
	formpass.addEventListener('click', async function (event) {
		changepasswordinput.style.backgroundColor = '#FAF5FD';
		if (event.target.matches('#changepassword')) {
			event.preventDefault()
			const changepasswordinput = document.querySelector('#changepasswordinput');
			try {
				const token = localStorage.getItem('access_token');
				axios.defaults.headers.common['Authorization'] = `${token}`;
				const headers = {
					'Authorization': `${token}`
				};
				const response = await axios.get('/api/user', { headers });
				const respassword = await axios.patch('/api/user/changepassword', { password: changepasswordinput.value, id: response.data.id });
				// console.log(respassword);
				changepasswordinput.style.backgroundColor = 'rgb(144, 238, 144)';
				// location.reload()
			} catch (error) {
				console.error(error);
			}
		}
	});
	const changephotoinput = document.querySelector('#profile-photo-in');
	const changephotobtn = document.querySelector('#change-photo-profile-btn');

	changephotobtn.addEventListener('click', function () {
		changephotoinput.click();
	});
});



